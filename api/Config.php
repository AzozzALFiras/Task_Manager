<?php

// Developer by Azozz ALFiras

$servername = "localhost";
$username = "task_manager";
$password = "L8GwkfGZ4GhFnfn5";
$dbname = "task_manager";

// Create connection
$link = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($link->connect_error) {
  die("Connection failed: " . $link->connect_error);
} 

include "Class/Task_Manager_Class.php";
$Task_Manager = new Task_Manager();
