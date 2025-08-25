<?php 

include "../connect.php" ; 

$id = filterRequest("id") ; 

deleteData("activities" , "activity_id    = $id ") ; 
