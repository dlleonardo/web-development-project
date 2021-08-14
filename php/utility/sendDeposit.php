<?php
session_start();
require_once "./dbManager.php";

$conn = openConnection();
$userId = $_SESSION['idUser'];

if(isset($_POST['depositType'])){
	$depositType = $_POST['depositType'];
	if($depositType === 'CC'){
		if(isset($_POST['amount']) && isset($_POST['cardNumber']) && isset($_POST['validThruMonth']) && isset($_POST['validThruYear']) && isset($_POST['secretCode'])){
			$amount = $conn->real_escape_string($_POST['amount']);
			$cardNumber = $conn->real_escape_string($_POST['cardNumber']);
			$validThruMonth = $conn->real_escape_string($_POST['validThruMonth']);
			$validThruYear = $conn->real_escape_string($_POST['validThruYear']);
			$secretCode = $conn->real_escape_string($_POST['secretCode']);
			
			$description = 'Credit Card, Card Number: '.$cardNumber.', ValidThru: '.$validThruMonth.'/'.$validThruYear.', Secret Code:'.$secretCode;
		}
	}
	if($depositType === 'PP'){
		if(isset($_POST['amount']) && isset($_POST['email'])){
			$amount = $conn->real_escape_string($_POST['amount']);
			$email = $conn->real_escape_string($_POST['email']);
			
			$description = 'PayPal, Email: '.$email;
		}
	
	}
	if($depositType === 'BT'){
		if(isset($_POST['amount']) && isset($_POST['name']) && isset($_POST['surname']) && isset($_POST['iban'])){
			$amount = $conn->real_escape_string($_POST['amount']);
			$name = $conn->real_escape_string($_POST['name']);
			$surname = $conn->real_escape_string($_POST['surname']);
			$iban = $conn->real_escape_string($_POST['iban']);
		
			$description = 'Bank Transfer, Fullname: '.$name.' '.$surname.', IBAN: '.$iban;
		}
	}
	$insertDeposit = "INSERT INTO deposit(_iduser,type,description,amount) VALUES($userId, '$depositType', '$description', $amount)";
	$conn->query($insertDeposit);	
	incrementWallet($_SESSION['idUser'], $amount, $conn);
	$msg = 'Deposit sent successfully.';
	header("location: ./../deposit-credits.php?message=".$msg);
	$conn->close();
}

function incrementWallet($userId, $amount, $conn){
	$incrementWallet = "UPDATE user
						SET wallet = wallet + $amount
						WHERE id = $userId";
	$conn->query($incrementWallet);		
	$_SESSION['wallet'] = floatval($_SESSION['wallet']) + floatval($amount);
	$_SESSION['wallet'] = number_format($_SESSION['wallet'], 2, ".", "");	
}
?>