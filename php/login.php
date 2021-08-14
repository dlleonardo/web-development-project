<?php
	require_once "./utility/dbManager.php";
	
	$conn = openConnection();
	
	// Escape special characters
	$username = $conn->real_escape_string($_POST['username']);
	$password = $conn->real_escape_string($_POST['password']);
	
	// Initialize query text
	$selectUser = "SELECT *
				   FROM user
				   WHERE username = '".$username."'
						 AND password = '".$password."'";

	// Perform query and check the result
	$result = $conn->query($selectUser);
	$numRows = mysqli_num_rows($result);
	
	// Start the session and redirect to user panel if he has logged in correctly, else redirect to login page
	if($numRows === 1){
		$resultRow = $result->fetch_assoc();
		if($resultRow['banned'] == 1){
			$errorMsg = "This account has been banned, try again later.";
			header("location: ./../signin.php?errorMsg=".$errorMsg);			
		}
		else{
			session_start();
			$_SESSION['username'] = $resultRow['username'];
			$_SESSION['idUser'] = $resultRow['id'];
			$_SESSION['wallet'] = $resultRow['wallet'];
			$_SESSION['experience'] = $resultRow['experience'];
			$_SESSION['rank'] = $resultRow['_idrank'];
			if($resultRow['role'] === 'user'){
				header("location: ./home.php");
			}
			if($resultRow['role'] === 'admin'){
				header("location: ./admin.php");
			}
		}
	}
	else{
		$errorMsg = "Wrong username or password.";
		header("location: ./../signin.php?errorMsg=".$errorMsg);
	}
	
	$conn->close();
?>