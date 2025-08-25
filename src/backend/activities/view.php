<?php

include "../connect.php";

$user_id = filterRequest("user_id");


$stmt = $con->prepare("SELECT 
    a.activity_id,
    a.category,
    a.activity_type,
    a.duration_hours,
    a.duration_minutes,
    a.duration_seconds,
    a.user_weight,
    a.calories_burned,
    a.activity_date,
    u.users_id,
    u.users_name,
    u.users_email,
    u.users_phone
FROM 
    activities a
LEFT JOIN 
    users u ON a.user_id = u.users_id
WHERE 
    (:user_id IS NULL OR u.users_id = :user_id)
ORDER BY 
    a.activity_date DESC");

$stmt->execute(array(':user_id' => $user_id));
$data = $stmt->fetchAll(PDO::FETCH_ASSOC);
$count = $stmt->rowCount();

if ($count > 0) {
    echo json_encode(array("status" => "success", "data" => $data));
} else {
    echo json_encode(array("status" => "failure"));
}

?>
