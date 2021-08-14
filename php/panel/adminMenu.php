<div id="menu">
	<div id="user-info">
		<div>
			<img src="./../images/admin.png" width="64" height="72" alt="Admin">
		</div>
		<div>
			<?php echo $_SESSION['username']; ?>
		</div>
	</div>
	<hr>
	<div id="menu-btns">
		<div class="tag-title">
			<span>Manage</span>
		</div>
		<a href="./admin.php">
			Users
		</a>
		<a href="./logout.php">
			Logout
		</a>
	</div>
</div>