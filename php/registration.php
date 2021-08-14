<?php
	require_once "./utility/dbManager.php";
	require_once "./utility/insertUserGoals.php";
	
	$conn = openConnection();
	
	$username = $conn->real_escape_string($_POST['username']);
	$password = $conn->real_escape_string($_POST['password']);
	$confirmPassword = $conn->real_escape_string($_POST['confirmPassword']);
	$email = $conn->real_escape_string($_POST['email']);
	$firstName = $conn->real_escape_string($_POST['firstName']);
	$surname = $conn->real_escape_string($_POST['surname']);
	
	// Check if the password and confirmPassword fields are equals
	if($password === $confirmPassword){
		$selectUsersInfo = "SELECT *
							FROM user
							WHERE username = '".$username."'
								  OR
								  email = '".$email."'";
		$result = $conn->query($selectUsersInfo);
		$numRows = mysqli_num_rows($result);
		// Check if the username or email have been already taken
		if($numRows === 0){
			// Insert new user
			$insertNewUser = "INSERT INTO user(username, password, email, name, surname)
							  VALUES('".$username."','".$password."','".$email."','".$firstName."','".$surname."')";
			$conn->query($insertNewUser);
			$userId = $conn->insert_id;
			insertUserGoals($userId, $conn);
			header("location: ./../successfull-page.html");
		}
		else{
			$errorMsg = "The username or email are already registered.";
			header("location: ./../signup.php?errorMsg=".$errorMsg);
		}
	}
	else{
		$errorMsg = "The fields Password and Confirm Password don't match.";
		header("location: ./../signup.php?errorMsg=".$errorMsg);
	}
	
	$conn->close();
?>