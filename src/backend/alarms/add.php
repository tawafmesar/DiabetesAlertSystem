<?php
include "../connect.php";

try {
    // Retrieve and sanitize inputs
    $is_active = filterRequest("is_active"); // Active state (0 or 1)
    $is_ringing = filterRequest("is_ringing"); // Ringing state (0 or 1)
    $name_of_alarm = filterRequest("name_of_alarm"); // Alarm name
    $alarm_time_hour = filterRequest("alarm_time_hour"); // Hour of the alarm
    $alarm_time_minute = filterRequest("alarm_time_minute"); // Minute of the alarm
    $alarm_date = filterRequest("alarm_date"); // Date of the alarm
    $is_recurrent = filterRequest("is_recurrent"); // Recurrence flag (0 or 1)
    $weekday_recurrence = filterRequest("weekday_recurrence"); // JSON array for recurrence (e.g., ["Monday", "Wednesday"])
    $challenge_mode = filterRequest("challenge_mode"); // Challenge mode (0 or 1)
    $users_id = filterRequest("users_id"); // Associated user ID
    $medications_id = filterRequest("medications_id"); // Associated medication ID

    // Validate JSON format for weekday_recurrence
    if (!json_decode($weekday_recurrence, true)) {
        throw new Exception("Invalid JSON format for weekday_recurrence");
    }

    // Prepare the SQL query
    $sql = "INSERT INTO alarms (
                is_active, is_ringing, name_of_alarm, alarm_time_hour, alarm_time_minute,
                alarm_date, is_recurrent, weekday_recurrence, challenge_mode, users_id, medications_id
            ) VALUES (
                :is_active, :is_ringing, :name_of_alarm, :alarm_time_hour, :alarm_time_minute,
                :alarm_date, :is_recurrent, :weekday_recurrence, :challenge_mode, :users_id, :medications_id
            )";

    $stmt = $con->prepare($sql);

    // Bind parameters
    $stmt->bindParam(':is_active', $is_active);
    $stmt->bindParam(':is_ringing', $is_ringing);
    $stmt->bindParam(':name_of_alarm', $name_of_alarm);
    $stmt->bindParam(':alarm_time_hour', $alarm_time_hour);
    $stmt->bindParam(':alarm_time_minute', $alarm_time_minute);
    $stmt->bindParam(':alarm_date', $alarm_date);
    $stmt->bindParam(':is_recurrent', $is_recurrent);
    $stmt->bindParam(':weekday_recurrence', $weekday_recurrence);
    $stmt->bindParam(':challenge_mode', $challenge_mode);
    $stmt->bindParam(':users_id', $users_id);
    $stmt->bindParam(':medications_id', $medications_id);

    // Execute the query
    $stmt->execute();

    // Get the ID of the last inserted row
    $alarm_id = $con->lastInsertId();

    // Respond with success message
    echo json_encode([
        'status' => 'success',
        'alarm_id' => $alarm_id,
    ]);
} catch (Exception $e) {
    // Respond with error message
    echo json_encode(["message" => $e->getMessage()]);
}

?>
