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
    	<title>Wallet</title>
	</head>
	<body onload="setMarkets('wallet')">
		<?php
			include "./panel/menu.php";
		?>
		<div id="container">
			<div>
				<div style="width:100%; text-align:center;">
					<h2>WALLET</h2>
					<p style="font-size:18px;">Sell the quotes of the markets that you bought, pays attention to the real time markets prices.</p>
				</div>
			</div>
			<?php
				if(isset($_GET['message'])){
					echo '<div class="message">'.$_GET['message'].'</div>';
				}
			?>
			<!-- Show personal wallet table -->
			<?php
				require "./panel/data.php";
				checkUserActions();
				showWallet();
			?>
		</div>
	</body>
</html>