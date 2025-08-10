<?php 

include "../connect.php"; 




try {
    $id = filterRequest("id"); 
    $name = filterRequest("name"); 
    $class = filterRequest("classs");
    $type = filterRequest("type");
    $dosage = filterRequest("dosage");
    $frequency = filterRequest("frequency");


        $data = array(
            "name" => $name,
            "class" =>  $class,
            "type" => $type,
            "dosage" => $dosage,
            "frequency" => $frequency ,
            "users_id" => $id ,

        );

    insertData("medications" , $data) ; 


} catch (Exception $e) {
    echo json_encode(["message" => $e->getMessage()]);
}
