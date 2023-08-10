<?php

// Created By Azozz ALFiras

class Task_Manager{
    
public function Create_User($Username,$Password,$link){
$Check_Username = $this->Check_Value_Database("User_List","Username",$Username,$link);
$TimeNow        = $this->TimeNow();
$Password_Hash  = password_hash($Password,PASSWORD_DEFAULT);

if($Check_Username == "NO"){

$sql = "INSERT INTO User_List (Username, Password, Join_Time)
VALUES ('$Username', '$Password_Hash', '$TimeNow')";
if ($link->query($sql) === TRUE) {
return [
'Status_Text' => "An account has been created successfully",
'Status_Login'=> "DONE",
"Username"=> $Username

];
} else {
return [
'Status_Text' => "Error: " . $sql . "<br>" . $link->error,
'Status_Login'=> "ERROR"
];
}
} else{
return [
'Status_Text' => "Username already used",
'Status_Login'=> "ERROR"
];
}
}

public function Check_Value_Database($Database,$Key,$Value,$link){
$sql = "SELECT * FROM `$Database` WHERE `$Key`='$Value'";
$result = $link->query($sql);
if ($result->num_rows > 0) {
while($row = $result->fetch_assoc()) {
return "YES";
}
} else {
return "NO";
}
}


public function Login_User($Username,$User_Password,$link){
$sql = "SELECT * FROM `User_List` WHERE `Username`='$Username'";
$result = $link->query($sql);
if ($result->num_rows > 0) {
while($row = $result->fetch_assoc()) {
$Password_Row = $row["Password"];
if(password_verify($User_Password,$Password_Row)){
return [
'Status_Text' => "Logged in successfully",
'Status_Login'=> "DONE",
"Username"=> $Username
];
}

}
} else {
return "NO";
}
}
public function Create_Task($Title,$Description,$TimeNow,$Username,$link){
$Check_Username = $this->Check_Value_Database("User_List","Username",$Username,$link);

if($Check_Username == "YES"){
$sql = "INSERT INTO Task_List (Title, Description, Username, Task_Time)
VALUES ('$Title', '$Description', '$Username', '$TimeNow')";
if ($link->query($sql) === TRUE) {
return [
'Status_Text' => "An task has been created successfully",
'Status_Task'=> "DONE"
];
} else {
return [
'Status_Text' => "Error: " . $sql . "<br>" . $link->error,
'Status_Task'=> "ERROR"
];
}
} else{
return [
'Status_Text' => "We don't have the username",
'Status_Task'=> "ERROR"
]; 
}
}

public function User_Tasks($Username,$link){
$AllTasks = [];
$sql = "SELECT * FROM `Task_List` WHERE `Username`='$Username'";
$result = $link->query($sql);
if ($result->num_rows > 0) {
while($row = $result->fetch_assoc()) {
$AllTasks[] = $row;
}
}
return $AllTasks;
}

public function Delete_Task($UserName,$id,$link){
$sql = "SELECT * FROM `Task_List` WHERE `id`='$id'";
$result = $link->query($sql);
if ($result->num_rows > 0) {
while($row = $result->fetch_assoc()) {
$Username_row = $row["Username"];
if($Username_row == $Username_row){
return $this->Delete_Item("Task_List",$id,$link);
} else{
   return [
'Status_Text' => "You don't have permission to delete this task",
'Status_Task'=> "ERROR"
];  
}
}
}
}


public function Delete_Item($table,$id,$link){
$sql = "DELETE FROM `$table` WHERE `id`='$id'";
if ($link->query($sql) === TRUE) {
return [
'Status_Text' => "Deleted successfully",
'Status_Task'=> "DONE"
];
} else {
return [
'Status_Text' => "Error: " . $sql . "<br>" . $link->error,
'Status_Task'=> "ERROR"
];
}
}


public function Update_Task($UserName,$Title,$Description,$Date,$id,$link){
$sql = "SELECT * FROM `Task_List` WHERE `id`='$id'";
$result = $link->query($sql);
if ($result->num_rows > 0) {
while($row = $result->fetch_assoc()) {
$Username_row = $row["Username"];
if($Username_row == $Username_row){
$sql = "UPDATE Task_List SET Title='$Title', Description='$Description', Task_Time='$Date' WHERE `id`='$id'";
if ($link->query($sql) === TRUE) {
 return [
'Status_Text' => "Updated successfully",
'Status_Task'=> "DONE"
];
} else {
return [
'Status_Text' => "Error: " . $sql . "<br>" . $link->error,
'Status_Task'=> "ERROR"
]; 
}
} else{
   return [
'Status_Text' => "You don't have permission to update this task",
'Status_Task'=> "ERROR"
];  
}
}
}
}

public function TimeNow(){
    return date("Y/m/d");
}

}