<?php

include "../connect.php";

$id = filterRequest("id");



getallData("view_metrics" , " user_id = ?" , array($id), "metric_timestamp DESC");

