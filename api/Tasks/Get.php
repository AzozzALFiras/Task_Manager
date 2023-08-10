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



// Check if the Empty Username or not 
if(!empty($User_Name)){


$Create_Task = $Task_Manager->User_Tasks($User_Name,$link);
echo json_encode($Create_Task, JSON_PRETTY_PRINT);

} else {
$array_json = [
'Status_Text' => "You can't get an tasks without a username",
'Status_Login'=> "ERROR"
];
echo json_encode($array_json, JSON_PRETTY_PRINT);
}


}


