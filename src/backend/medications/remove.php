<?php 

include "../connect.php" ; 

$id = filterRequest("id") ; 

deleteData("medications" , "id  = $id ") ; 
