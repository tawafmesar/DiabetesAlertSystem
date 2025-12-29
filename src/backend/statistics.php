<?php
// home_stats.php
// Returns JSON with expanded home-screen statistics for a user:
// - Metrics (grouped + averages + status)
// - Alarms count
// - Medications count
// - Activities summary (totals, calories, durations, breakdowns, recent items, last 7 days)
// Requires: ./connect.php to provide a PDO $con connection.
// Usage: home_stats.php?id=USER_ID  (or POST id=USER_ID)

include "./connect.php";

date_default_timezone_set('UTC');

try {
    // Helper: get user id from request (works with existing filterRequest if present)
    function getUserIdFromRequest(): int
    {
        if (function_exists('filterRequest')) {
            $id = filterRequest("id");
        } else {
            // Fallback to GET/POST
            $id = $_REQUEST['id'] ?? null;
        }
        if ($id === null || $id === '') {
            throw new InvalidArgumentException("Missing required parameter: id");
        }
        if (!is_numeric($id) || intval($id) <= 0) {
            throw new InvalidArgumentException("Invalid user id");
        }
        return intval($id);
    }

    $user_id = getUserIdFromRequest();

    //
    // 1) METRICS: fetch raw metrics, compute status, group by type
    //
    $sqlMetrics = "
        SELECT
            metric_type,
            value1,
            value2,
            DATE_FORMAT(`timestamp`, '%Y-%m-%d %H:%i:%s') AS timestamp,
            CASE
                WHEN metric_type = 'Blood Pressure' THEN
                    CASE
                        WHEN (value1 REGEXP '^-?[0-9]+(\\.[0-9]+)?$' AND value2 REGEXP '^-?[0-9]+(\\.[0-9]+)?$' AND CAST(value1 AS DECIMAL) < 90 AND CAST(value2 AS DECIMAL) < 60) THEN 'Low'
                        WHEN (value1 REGEXP '^-?[0-9]+(\\.[0-9]+)?$' AND value2 REGEXP '^-?[0-9]+(\\.[0-9]+)?$' AND (CAST(value1 AS DECIMAL) > 120 OR CAST(value2 AS DECIMAL) > 80)) THEN 'High'
                        ELSE 'Normal'
                    END
                WHEN metric_type = 'Heart Rate' THEN
                    CASE
                        WHEN (value1 REGEXP '^-?[0-9]+(\\.[0-9]+)?$' AND CAST(value1 AS DECIMAL) < 60) THEN 'Low'
                        WHEN (value1 REGEXP '^-?[0-9]+(\\.[0-9]+)?$' AND CAST(value1 AS DECIMAL) > 100) THEN 'High'
                        ELSE 'Normal'
                    END
                WHEN metric_type = 'Blood Sugar' THEN
                    CASE
                        WHEN (value1 REGEXP '^-?[0-9]+(\\.[0-9]+)?$' AND CAST(value1 AS DECIMAL) < 70) THEN 'Low'
                        WHEN (value1 REGEXP '^-?[0-9]+(\\.[0-9]+)?$' AND CAST(value1 AS DECIMAL) > 140) THEN 'High'
                        ELSE 'Normal'
                    END
                ELSE 'Unknown'
            END AS metric_status
        FROM metrics
        WHERE user_id = ?
        ORDER BY `timestamp` ASC
    ";
    $stmtMetrics = $con->prepare($sqlMetrics);
    $stmtMetrics->execute([$user_id]);
    $metrics = $stmtMetrics->fetchAll(PDO::FETCH_ASSOC);

    // Group metrics for charts and UI
    $metricsGrouped = [];
    foreach ($metrics as $m) {
        $type = $m['metric_type'] ?? 'Unknown';
        if (!isset($metricsGrouped[$type])) {
            $metricsGrouped[$type] = [];
        }
        // Try convert numeric values to float/int where possible
        $v1 = is_numeric($m['value1']) ? (float)$m['value1'] : null;
        $v2 = is_numeric($m['value2']) ? (float)$m['value2'] : null;

        $metricsGrouped[$type][] = [
            "value1"    => $v1,
            "value2"    => $v2,
            "timestamp" => $m['timestamp'],
            "status"    => $m['metric_status']
        ];
    }

    //
    // 2) AVERAGE METRICS (safe numeric conversion using REGEXP)
    //
    $sqlAverageMetrics = "
        SELECT
            AVG(CASE WHEN metric_type = 'Blood Pressure' AND value1 REGEXP '^-?[0-9]+(\\.[0-9]+)?$' THEN CAST(value1 AS DECIMAL(10,2)) END) AS avg_systolic,
            AVG(CASE WHEN metric_type = 'Blood Pressure' AND value2 REGEXP '^-?[0-9]+(\\.[0-9]+)?$' THEN CAST(value2 AS DECIMAL(10,2)) END) AS avg_diastolic,
            AVG(CASE WHEN metric_type = 'Heart Rate' AND value1 REGEXP '^-?[0-9]+(\\.[0-9]+)?$' THEN CAST(value1 AS DECIMAL(10,2)) END) AS avg_heart_rate,
            AVG(CASE WHEN metric_type = 'Blood Sugar' AND value1 REGEXP '^-?[0-9]+(\\.[0-9]+)?$' THEN CAST(value1 AS DECIMAL(10,2)) END) AS avg_blood_sugar
        FROM metrics
        WHERE user_id = ?
    ";
    $stmtAvg = $con->prepare($sqlAverageMetrics);
    $stmtAvg->execute([$user_id]);
    $avgRow = $stmtAvg->fetch(PDO::FETCH_ASSOC);

    $averageMetricsFormatted = [
        ["label" => "Average Blood Sugar","value" => isset($avgRow['avg_blood_sugar']) ? ($avgRow['avg_blood_sugar'] !== null ? (float)$avgRow['avg_blood_sugar'] : null) : null],
        ["label" => "Average Systolic",   "value" => isset($avgRow['avg_systolic']) ? ($avgRow['avg_systolic'] !== null ? (float)$avgRow['avg_systolic'] : null) : null],
        ["label" => "Average Diastolic",  "value" => isset($avgRow['avg_diastolic']) ? ($avgRow['avg_diastolic'] !== null ? (float)$avgRow['avg_diastolic'] : null) : null],
        ["label" => "Average Heart Rate", "value" => isset($avgRow['avg_heart_rate']) ? ($avgRow['avg_heart_rate'] !== null ? (float)$avgRow['avg_heart_rate'] : null) : null],
    ];

    //
    // 3) ALARMS & MEDICATIONS COUNTS
    //
    $sqlTotalAlarms = "SELECT COUNT(*) AS total_alarms FROM alarms WHERE users_id = ?";
    $stmtTotalAlarms = $con->prepare($sqlTotalAlarms);
    $stmtTotalAlarms->execute([$user_id]);
    $totalAlarms = (int)$stmtTotalAlarms->fetch(PDO::FETCH_ASSOC)['total_alarms'];

    $sqlMedications = "SELECT COUNT(*) AS medication_count FROM medications WHERE users_id = ?";
    $stmtMedications = $con->prepare($sqlMedications);
    $stmtMedications->execute([$user_id]);
    $medicationCount = (int)$stmtMedications->fetch(PDO::FETCH_ASSOC)['medication_count'];

    //
    // 4) ACTIVITIES: expanded summary and breakdowns
    //
    // Totals: count, calories sum, total duration in seconds
    $sqlActivitiesTotals = "
        SELECT
            COUNT(*) AS total_activities,
            COALESCE(SUM(COALESCE(calories_burned,0)), 0) AS total_calories,
            COALESCE(SUM(duration_hours * 3600 + duration_minutes * 60 + duration_seconds), 0) AS total_duration_seconds,
            MAX(activity_date) AS last_activity_date
        FROM activities
        WHERE user_id = ?
    ";
    $stmtActTotals = $con->prepare($sqlActivitiesTotals);
    $stmtActTotals->execute([$user_id]);
    $actTotals = $stmtActTotals->fetch(PDO::FETCH_ASSOC);

    $totalActivities = (int)$actTotals['total_activities'];
    $totalCalories = (float)$actTotals['total_calories'];
    $totalDurationSeconds = (int)$actTotals['total_duration_seconds'];
    $lastActivityDate = $actTotals['last_activity_date'] ? date('Y-m-d H:i:s', strtotime($actTotals['last_activity_date'])) : null;
    $avgCaloriesPerActivity = $totalActivities > 0 ? ($totalCalories / $totalActivities) : null;

    // Breakdown by activity_type
    $sqlByType = "
        SELECT
            activity_type,
            COUNT(*) AS cnt,
            COALESCE(SUM(COALESCE(calories_burned,0)),0) AS calories_sum,
            COALESCE(SUM(duration_hours * 3600 + duration_minutes * 60 + duration_seconds),0) AS duration_seconds_sum
        FROM activities
        WHERE user_id = ?
        GROUP BY activity_type
        ORDER BY cnt DESC
        LIMIT 100
    ";
    $stmtByType = $con->prepare($sqlByType);
    $stmtByType->execute([$user_id]);
    $types = $stmtByType->fetchAll(PDO::FETCH_ASSOC);
    $activitiesByType = [];
    foreach ($types as $t) {
        $activitiesByType[] = [
            "activity_type" => $t['activity_type'],
            "count" => (int)$t['cnt'],
            "calories" => (float)$t['calories_sum'],
            "duration_seconds" => (int)$t['duration_seconds_sum']
        ];
    }

    // Recent activities (limit 10)
    $sqlRecent = "
        SELECT
            activity_id,
            category,
            activity_type,
            duration_hours,
            duration_minutes,
            duration_seconds,
            user_weight,
            calories_burned,
            DATE_FORMAT(activity_date, '%Y-%m-%d %H:%i:%s') as activity_date
        FROM activities
        WHERE user_id = ?
        ORDER BY activity_date DESC
        LIMIT 10
    ";
    $stmtRecent = $con->prepare($sqlRecent);
    $stmtRecent->execute([$user_id]);
    $recentActivitiesRaw = $stmtRecent->fetchAll(PDO::FETCH_ASSOC);
    $recentActivities = [];
    foreach ($recentActivitiesRaw as $r) {
        $durationSeconds = ((int)$r['duration_hours'] * 3600) + ((int)$r['duration_minutes'] * 60) + (int)$r['duration_seconds'];
        $recentActivities[] = [
            "activity_id" => (int)$r['activity_id'],
            "category" => $r['category'],
            "activity_type" => $r['activity_type'],
            "duration_seconds" => $durationSeconds,
            "user_weight" => $r['user_weight'] !== null ? (int)$r['user_weight'] : null,
            "calories_burned" => $r['calories_burned'] !== null ? (float)$r['calories_burned'] : null,
            "activity_date" => $r['activity_date']
        ];
    }

    // Last 7 days (daily aggregates) - include days with zero as well
    $sqlLast7 = "
        SELECT
            DATE(activity_date) AS day,
            COUNT(*) AS activity_count,
            COALESCE(SUM(COALESCE(calories_burned,0)),0) AS calories_sum,
            COALESCE(SUM(duration_hours * 3600 + duration_minutes * 60 + duration_seconds),0) AS duration_seconds_sum
        FROM activities
        WHERE user_id = ? AND activity_date >= DATE_SUB(CURDATE(), INTERVAL 6 DAY)
        GROUP BY DATE(activity_date)
        ORDER BY day ASC
    ";
    $stmtLast7 = $con->prepare($sqlLast7);
    $stmtLast7->execute([$user_id]);
    $last7Raw = $stmtLast7->fetchAll(PDO::FETCH_ASSOC);

    // Normalize last 7 days to include missing dates (so client chart can plot continuous days)
    $last7 = [];
    $start = new DateTime('today -6 days');
    for ($i = 0; $i < 7; $i++) {
        $d = clone $start;
        $d->modify("+{$i} days");
        $dayStr = $d->format('Y-m-d');
        $last7[$dayStr] = [
            "date" => $dayStr,
            "activity_count" => 0,
            "calories_sum" => 0.0,
            "duration_seconds_sum" => 0
        ];
    }
    foreach ($last7Raw as $row) {
        $day = $row['day'];
        if (isset($last7[$day])) {
            $last7[$day] = [
                "date" => $day,
                "activity_count" => (int)$row['activity_count'],
                "calories_sum" => (float)$row['calories_sum'],
                "duration_seconds_sum" => (int)$row['duration_seconds_sum']
            ];
        }
    }
    // Reindex as array for JSON
    $last7List = array_values($last7);

    // Prepare activities summary object
    $activitiesSummary = [
        "total_activities" => $totalActivities,
        "total_calories" => $totalCalories,
        "total_duration_seconds" => $totalDurationSeconds,
        "average_calories_per_activity" => $avgCaloriesPerActivity !== null ? (float)round($avgCaloriesPerActivity, 2) : null,
        "last_activity_date" => $lastActivityDate,
        "by_type" => $activitiesByType,
        "recent" => $recentActivities,
        "last_7_days" => $last7List
    ];

    //
    // 5) FINAL RESPONSE
    //
    $statistics = [
        "metrics_grouped" => $metricsGrouped,
        "average_metrics" => $averageMetricsFormatted,
        "alarms_count" => $totalAlarms,
        "medication_count" => $medicationCount,
        "activities" => $activitiesSummary,
        "generated_at" => date('Y-m-d H:i:s')
    ];

    header('Content-Type: application/json; charset=utf-8');
    echo json_encode(["status" => "success", "data" => $statistics], JSON_UNESCAPED_UNICODE | JSON_PARTIAL_OUTPUT_ON_ERROR);
    exit(0);

} catch (Exception $e) {
    http_response_code(500);
    header('Content-Type: application/json; charset=utf-8');
    echo json_encode([
        "status" => "failure",
        "message" => $e->getMessage(),
        "generated_at" => date('Y-m-d H:i:s')
    ], JSON_UNESCAPED_UNICODE);
    exit(1);
}
?>