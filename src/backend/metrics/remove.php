<?php 

include "../connect.php" ; 

$id = filterRequest("id") ; 

deleteData("metrics" , "metric_id   = $id ") ; 
