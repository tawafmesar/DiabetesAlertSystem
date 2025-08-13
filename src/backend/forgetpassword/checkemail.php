<?php

include "../connect.php";

$email = filterRequest("email");

$verfiycode = rand(10000, 99999);

$stmt = $con->prepare("SELECT * FROM users WHERE users_email = ? ");
$stmt->execute(array($email));
$count = $stmt->rowCount();
result($count);

if ($count > 0) {
    $data = array("users_verfiycode" => $verfiycode);
    updateData("users", $data, "users_email = '$email'", false);
sendEmail( 
    $email, 
    "Dear User,

Thank you for using the Diabetes Alert System.

Your code to verify your account is: $verfiycode

---
If you didn’t ask for this code, please ignore this email.

Best regards,  
[Diabetes Alert System Team]",
    "Your Verification Code - Diabetes Alert System"
);

    
    
}