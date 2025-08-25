<?php 

include "../connect.php"; 

function filterRequestwithouthtml($requestname)
{
  return trim(strip_tags($_POST[$requestname]));
}

try {
    // Retrieve and sanitize input
    $user_id  = filterRequestwithouthtml("user_id"); 
    $category = filterRequestwithouthtml("category"); 
    $activity_type = filterRequestwithouthtml("activity_type");
    $duration_hours = filterRequestwithouthtml("duration_hours");
    $duration_minutes = filterRequestwithouthtml("duration_minutes");
    $duration_seconds = filterRequestwithouthtml("duration_seconds"); 
    $user_weight = filterRequestwithouthtml("user_weight");
    $calories_burned = filterRequestwithouthtml("calories_burned");


    // Validate required inputs
    if (empty($user_id) || empty($category) || empty($activity_type)|| empty($user_weight)|| empty($calories_burned )) {
        printFailure("Missing required fields");

        exit();
    }


        $data = array(
        "user_id" => $user_id,
        "category" => $category,
        "activity_type" => $activity_type,
        "duration_hours" => $duration_hours,
        "duration_minutes" => $duration_minutes,
        "duration_seconds" => $duration_seconds,
        "user_weight" => $user_weight,
        "calories_burned" => $calories_burned
        );

    // Insert data into activities table
   insertData("activities", $data);


} catch (Exception $e) {
    printFailure($e->getMessage());

}

