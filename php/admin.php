<?php
	session_start();
	if(!isset($_SESSION['username']) || !isset($_SESSION['idUser'])){
		header("location: ./../signin.php");
		exit();
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
		<script src="./../js/ajax.js"></script>
    	<title>Administrator</title>
	</head>
	<body>
		<?php
			include "./panel/adminMenu.php";
		?>
		<div id="container">
			<div style="display:block; text-align:center;" id="search-bar">
				<input type="text" placeholder="Search by username ..." onkeyup="searchUsers(this.value)" />
			</div>
			<?php
				if(isset($_GET['message'])){
					echo '<div class="message">'.$_GET['message'].'</div>';
				}
			?>
			<!-- Show administrator table data -->
			<?php
				require "./utility/checkUserActions.php";
				require "./panel/data.php";
				showUsers();
			?>
		</div>
	</body>
</html>