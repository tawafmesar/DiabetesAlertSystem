<?php

include "../connect.php";

$id = filterRequest("id");



getAllData("view_medications", "user_id = ?", array($id), "medication_date_create DESC");
 
