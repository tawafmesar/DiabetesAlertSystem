<?php 

include "../connect.php" ; 

$id = filterRequest("id") ; 

deleteData("alarms" , "id   = $id ") ; 
