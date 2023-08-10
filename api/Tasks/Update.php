<?php
// Created By Azozz ALFiras 



include "../Config.php";

// For workigng with POST parameters

$REQUEST_METHOD = $_SERVER['REQUEST_METHOD'];
if(strcasecmp($REQUEST_METHOD, "GET") == 0){
header($_SERVER["SERVER_PROTOCOL"]."Error method", true, 405);
exit();
} else{


// For Get request body parameters 
$data =  file_get_contents('php://input');

// convert data to json string and append to array with request parameters
$jsondata = json_decode($data, true);

// Get data from json string 
$User_Name  = $jsondata["User_Name"];
$Task_id    = $jsondata["id"];
$Task_Title = $jsondata["Task_Title"];
$Task_Des   = $jsondata["Task_Des"];
$Task_Date  = $jsondata["Task_Date"];



// Check if the Empty Username or not 
if(!empty($User_Name)){

// Check if the Empty Task id or not 

if(!empty($Task_id)){
    
    
$Create_Task = $Task_Manager->Update_Task($User_Name,$Task_Title,$Task_Des,$Task_Date,$Task_id,$link);
echo json_encode($Create_Task, JSON_PRETTY_PRINT);

} else{
$array_json = [
'Status_Text' => "You can't update an tasks without a id",
'Status_Update'=> "ERROR"
];
echo json_encode($array_json, JSON_PRETTY_PRINT);  
}

} else {
$array_json = [
'Status_Text' => "You can't update an tasks without a username",
'Status_Update'=> "ERROR"
];
echo json_encode($array_json, JSON_PRETTY_PRINT);
}


}


