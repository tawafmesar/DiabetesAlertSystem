<?php

include "../connect.php";

$username = filterRequest("username");
$password = sha1($_POST['password']);
$email = filterRequest("email");
$verfiycode     = rand(10000 , 99999);


$stmt = $con->prepare("SELECT * FROM users WHERE users_email = ? ");
$stmt->execute(array($email));
$count = $stmt->rowCount();
if ($count > 0) {
    printFailure("This Email is already registered");
} else {

    $data = array(
        "users_name" => $username,
        "users_password" =>  $password,
        "users_email" => $email,
        "users_verfiycode" => $verfiycode ,
        "users_role" => 1 ,

    );
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

    
    insertData("users", $data);
    
}