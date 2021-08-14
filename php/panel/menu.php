<div id="menu">
	<div id="user-info">
		<div>
			<?php
				if($_SESSION['rank'] == 1){
					echo '<img src="./../images/wood.png" width="64" height="64" alt="Wood">';
				}				
				else if($_SESSION['rank'] == 2){
					echo '<img src="./../images/bronze.png" width="64" height="64" alt="Bronze">';
				}				
				else if($_SESSION['rank'] == 3){
					echo '<img src="./../images/silver.png" width="64" height="64" alt="Silver">';
				}				
				else{
					echo '<img src="./../images/gold.png" width="64" height="64" alt="Gold">';
				}
			?>
		</div>
		<div>
			<?php echo $_SESSION['username']; ?>
		</div>
		<div>
			<?php 
				echo $_SESSION['wallet']." &euro;"; 
			?>
		</div>
		<div>
			<?php echo $_SESSION['experience']." EXP"; ?>
		</div>
	</div>
	<hr>
	<div id="menu-btns">
		<div class="tag-title">
			<span>Invest</span>
		</div>
		<a href="./home.php">
			Home CFD
		</a>		
		<a href="./wallet.php">
			Wallet
		</a>
		<div class="tag-title">
			<span>Personal</span>
		</div>
		<a href="./packets.php">
			Packets
			<?php
				require './utility/checkNewPackets.php';
				newPacket($_SESSION['idUser']);
			?>
		</a>
		<a href="./goals.php">
			Goals
		</a>
		<a href="./history.php">
			History
		</a>
		<a href="./deposit-credits.php">
			Deposit Credits
		</a>
		<a href="./logout.php">
			Logout
		</a>
	</div>
</div>