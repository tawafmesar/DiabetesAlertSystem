<?php 

include "../connect.php" ; 

$id = filterRequest("id") ; 

deleteData("alarms" , "users_id    = $id ") ; 
