<?php 

include "../connect.php"; 

try {
    // Retrieve and sanitize input
    $id = filterRequest("id"); 
    $metric_type = filterRequest("metric_type"); 
    $value1 = filterRequest("value1");
    $value2 = filterRequest("value2");

    // Validate required inputs
    if (empty($id) || empty($metric_type) || empty($value1)) {
        printFailure("Missing required fields");

        exit();
    }

    // Prepare data for insertion based on metric type
    if ($metric_type == 'Blood Pressure') {
        if (empty($value2)) {
            printFailure("Missing diastolic value for Blood Pressure");

            exit();
        }
        $data = array(
            "metric_type" => $metric_type,
            "value1" => $value1,
            "value2" => $value2,
            "user_id" => $id,
        );
    } elseif ($metric_type == 'Heart Rate' || $metric_type == 'Blood Sugar') {
        $data = array(
            "metric_type" => $metric_type,
            "value1" => $value1,
            "value2" => null, 
            "user_id" => $id,
        );
    } else {
        printFailure("Invalid metric type");

        exit();
    }

    // Insert data into metrics table
    $insertResult = insertData("metrics", $data);

    if ($insertResult) {

    } else {
        printFailure("Failed to add metric");

    }

} catch (Exception $e) {
    printFailure($e->getMessage());

}
