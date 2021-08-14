<?php
	session_start();
	require "./utility/checkUserActions.php";	
	if(!isset($_SESSION['username']) || !isset($_SESSION['idUser']) || !isset($_SESSION['wallet']) || !isset($_SESSION['experience']) || !isset($_SESSION['rank'])){
		header("location: ./../signin.php");
		exit();
	}
	if(isset($_SESSION['idUser'])){
		if(isBanned($_SESSION['idUser'])){
			$msg = 'Your account is banned.';
			header("location: ./../signin.php?errorMsg=".$msg);
			exit();
		}
	}		
?>
<!DOCTYPE html>
<html lang="en"> 
	<head>
		<meta charset="UTF-8">
		<meta name="description" content="Financial Trading">
		<meta name="keywords" content="stocks, markets, trading">
    	<link rel="icon" href = "./../images/favicon.png" sizes="32x32" type="image/png">   		
		<link rel="stylesheet" href="./../css/panel.css" type="text/css" media="screen">
		<script src="./../js/trading.js"></script>
    	<title>Deposit Credits</title>
	</head>
	<body>
		<?php
			include "./panel/menu.php";
		?>
		<div id="container">
			<h2 class="userPanelTitle">
				Deposit Credits
			</h2>
			<?php
				if(isset($_GET['message'])){
					echo '<div class="message">'.$_GET['message'].'</div>';
				}
				
				checkUserActions();
			?>
			<div style="margin:12px;">
				<h3 style="font-family:arial;">Choose the deposit type:</h3>
				<select id="depositType" onchange="loadDepositType(this.value)">
					<option value="default"><i>Select a deposit type:</i></option>
					<option value="CC">Credit Card</option>
					<option value="PP">PayPal</option>
					<option value="BT">Bank Transfer</option>
				</select>
			</div>
			<div id="depositCreditsForm"></div>
		</div>
	</body>
</html>