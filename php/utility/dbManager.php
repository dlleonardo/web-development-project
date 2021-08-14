<?php
	require "dbCredentials.php";
	
	function openConnection(){
		global $dbHostname;
		global $dbUsername;
		global $dbPassword;
		global $dbName;
		
		// Create a new connection
		$conn = new mysqli($dbHostname, $dbUsername, $dbPassword, $dbName);

		// Check connection
		if ($conn->connect_error) {
			die("Connection failed: " . $conn->connect_error);
		}
		return $conn;
	}
?>