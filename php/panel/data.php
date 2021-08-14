<?php
	require_once "./utility/dbManager.php";

	$conn = openConnection();
	
	/* Users functions */
	function showCFDMarkets(){
		global $conn;
		$selectCFDMarkets = "SELECT M.id AS id,
								    M.icon AS icon,
									M.code AS code,
									M.name AS marketName,
									C.name AS catName
							 FROM market M
								  INNER JOIN
								  category C
								  ON M._idcategory = C.id
								  INNER JOIN
								  category_rank CR
								  ON C.id = CR._idcategory
							 WHERE CR._idrank = ".$_SESSION['rank']."
							 ORDER BY M.name ASC";
		$result = $conn->query($selectCFDMarkets);
		echo '<div id="cfd-section">
				<table id="cfd-table">
					<thead>
						<th></th>
						<th>Market</th>
						<th>Category</th>
						<th>Price</th>
						<th></th>
					</thead>
					<tbody>';
		$i=0;
		while($row = $result->fetch_assoc()){
			echo '<tr>
					<td style="text-align:center;"><img src="./../images/icons/'.$row['icon'].'" width="32" height="32" alt="'.$row['code'].'"></td>
					<td id="marketRow'.$i.'">'.$row['code'].' - '.$row['marketName'].'</td>
					<td>'.$row['catName'].'</td>
					<td id="marketChange'.$i.'"><span id=marketPrice'.$i.'></span> &euro;</td>
					<td style="text-align:center;"><a id="marketBtn'.$i.'" href="./home.php?marketCode='.$row['code'].'&action=buy">Buy</a></td>
				  </tr>';
			$i++;
		}
		echo '</tbody>
			  </table>
			  </div>';
		$conn->close();
	}
	
	function showGoals(){
		global $conn;
		
		$selectGoals = "SELECT G.title AS goalTitle,
							   G.description AS goalDescription,
							   G.experience AS goalExperience,
							   G.code AS goalCode,
							   UG.timestamp AS timestamp,
							   UG.unlocked AS goalUnlocked
						FROM user U
							 INNER JOIN
							 user_goal UG
							 ON U.id = UG._iduser
							 INNER JOIN
							 goal G
							 ON UG._idgoal = G.id
						WHERE U.id = ".$_SESSION['idUser']."";
		$result = $conn->query($selectGoals);
		
		if(mysqli_num_rows($result) == 0){
			echo '<div id="cfd-section">
					<h3 style="font-family:arial;">No goals found.</h3>
				  </div>';
		}
		else{
			echo '<div id="cfd-section">
					<table id="cfd-table">
						<thead>
							<th></th>
							<th>Title</th>
							<th>Description</th>
							<th>Experience</th>
							<th>Timestamp (h:m:s D-M-YY)</th>
							<th></th>
						</thead>
						<tbody>';
			$i=0;
			while($row = $result->fetch_assoc()){
				if($row['goalUnlocked'] == 0){
					$icon = '<img src="./../images/lock.png" width="32" height="32" alt="Locked">';
					$tableRow = '<tr style="background:#c6c6c6;">';
					$timestamp = '';
				}
				else{
					$tableRow = '<tr>';
					$icon = '<img src="./../images/unlock.png" width="32" height="32" alt="Unlocked">';
					$timestamp = date("H:i:s d-m-Y" , strtotime($row['timestamp']));
				}
				
				echo $tableRow.'
						<td style="text-align:center;"><img src="./../images/goals/'.$row['goalCode'].'.png" width="32" height="32" alt="'.$row['goalCode'].'"></td>
						<td>'.$row['goalTitle'].'</td>
						<td>'.$row['goalDescription'].'</td>
						<td>'.$row['goalExperience'].' EXP</td>
						<td>'.$timestamp.'</td>
						<td style="text-align:center;">'.$icon.'</td>
					</tr>';
				$i++;
			}
			echo '</tbody>
				 </table>
				</div>';
		}
		$conn->close();		
	}
	
	function showWallet(){
		global $conn;
		
		$selectUserTransactions = "SELECT T.id AS transactionId,
										 T.price_buy AS transactionPrice,
										 T.timestamp_buy AS transactionTime,
										 C.name AS category,
										 M.id AS marketId,
										 M.name AS marketName,
										 M.icon AS marketIcon,
										 M.code AS marketCode
								  FROM category C
									   INNER JOIN
									   market M
									   ON C.id = M._idcategory
									   INNER JOIN
									   transaction_market TM
									   ON M.id = TM._idmarket
									   INNER JOIN 
									   transaction T
									   ON TM._idtransaction = T.id
								  WHERE T._iduser = ".$_SESSION['idUser']."
										AND T.state = 'open'
										AND T.type = 'buy'
								  ORDER BY T.timestamp_buy DESC";
		$result = $conn->query($selectUserTransactions);
		
		if(mysqli_num_rows($result) == 0){
			echo '<div id="cfd-section">
					<h3 style="font-family:arial;">No transactions found in your wallet. Starts to buy markets at the <a class="link" href="./home.php">home CFD.</a></h3>
				  </div>';
		}
		else{
			echo '<div id="cfd-section">
					<table id="cfd-table">
						<thead>
							<th></th>
							<th>Market</th>
							<th>Category</th>
							<th>Transaction Price</th>
							<th>Market Price</th>
							<th>Time (h:m:s D-M-YY)</th>
							<th></th>
						</thead>
						<tbody>';
			$i=0;
			while($row = $result->fetch_assoc()){
				echo '<tr>
						<td style="text-align:center;"><img src="./../images/icons/'.$row['marketIcon'].'" width="32" height="32" alt="'.$row['marketCode'].'"></td>
						<td id="marketRow'.$i.'">'.$row['marketCode'].' - '.$row['marketName'].'</td>
						<td>'.$row['category'].'</td>
						<td>'.$row['transactionPrice'].' &euro;</td>
						<td id="marketChange'.$i.'"><span id=marketPrice'.$i.'></span> &euro;</td>
						<td>'.date("H:i:s d-m-Y" , strtotime($row['transactionTime'])).'</td>
						<td style="text-align:center;"><a id="marketBtn'.$i.'" href="./wallet.php?marketCode='.$row['marketCode'].'&action=sell&transactionId='.$row['transactionId'].'">Sell</a></td>
					</tr>';
				$i++;
			}
			echo '</tbody>
				 </table>
				</div>';
		}
		$conn->close();
	}
	
	function showPackets(){
		global $conn;
		
		$selectUserPackets = "SELECT U.id AS userId,
									 UP.id AS packetId,
									 P.type AS packetType,
									 P.credits AS packetCredits,
									 UP.closed AS flag,
									 UP.timestamp AS timestamp
								  FROM user U
									   INNER JOIN
									   user_packet UP
									   ON U.id = UP._iduser
									   INNER JOIN 
									   packet P
									   ON UP._idpacket = P.id
								  WHERE U.id = ".$_SESSION['idUser']."
								  ORDER BY UP.timestamp DESC";
		$result = $conn->query($selectUserPackets);
		
		if(mysqli_num_rows($result) == 0){
			echo '<div id="cfd-section">
					<h3 style="font-family:arial;">No packets found. You can receive them by unlocking goals.</h3>
				  </div>';
		}
		else{
			echo '<div id="cfd-section">
					<table id="cfd-table">
						<thead>
							<th></th>
							<th>Type</th>
							<th>Credits</th>
							<th>Timestamp (h:m:s D-M-YY)</th>
							<th></th>
						</thead>
						<tbody>';
			$i=0;
			while($row = $result->fetch_assoc()){
				if($row['packetType'] == 1){
					$type = 'Ultra rare';
					$icon = 'ultra-rare';
				}
				if($row['packetType'] == 2){
					$type = 'Rare';
					$icon = 'rare';
				}
				if($row['packetType'] == 3){
					$type = 'Common';
					$icon = 'common';
				}
				
				if($row['flag'] == 1){
					$btn = '<a href="./packets.php?packetId='.$row['packetId'].'&packetType='.$row['packetType'].'">Open</a>';
					$iconHtml = '<img src="./../images/'.$icon.'-closed.png" width="32" height="32" alt="Closed">';
				}
				else{
					$btn = '';
					$iconHtml = '<img src="./../images/'.$icon.'-open.png" width="32" height="32" alt="Open">';
				}
			
				echo '<tr>
						<td style="text-align:center;">'.$iconHtml.'</td>
						<td>'.$type.'</td>
						<td>'.$row['packetCredits'].' &euro;</td>
						<td>'.date("H:i:s d-m-Y" , strtotime($row['timestamp'])).'</td>
						<td style="text-align:center;">'.$btn.'</td>
					</tr>';
				$i++;
			}
			echo '</tbody>
				 </table>
				</div>';
		}
		$conn->close();	
	}
	
	function showHistory(){
		global $conn;
		
		$selectUserHistory = "SELECT M.icon AS marketIcon,
									 M.code AS marketCode,
									 M.name AS marketName,
									 C.name AS category,
									 T.price_buy AS priceBuy,
									 T.price_sell AS priceSell,
									 (T.price_sell - T.price_buy) AS profit,
									 T.timestamp_buy AS timestampBuy,
									 T.timestamp_sell AS timestampSell
							  FROM user U
								   INNER JOIN
								   transaction T
								   ON U.id = T._iduser
								   INNER JOIN
								   transaction_market TM
								   ON T.id = TM._idtransaction
								   INNER JOIN
								   market M
								   ON TM._idmarket = M.id
								   INNER JOIN 
								   category C
								   ON M._idcategory = C.id
							  WHERE T._iduser = ".$_SESSION['idUser']."
									AND T.state = 'closed'
									AND T.type = 'sell'
							  ORDER BY T.timestamp_sell DESC";
		$result = $conn->query($selectUserHistory);
		
		if(mysqli_num_rows($result) == 0){
			echo '<div id="cfd-section">
					<h3 style="font-family:arial;">No transactions found. You can sell them in your <a class="link" href="./wallet.php">personal wallet.</a></h3>
				  </div>';
		}
		else{
			echo '<div id="cfd-section">
					<table style="margin-bottom:81px;" id="cfd-table">
						<thead>
							<th></th>
							<th>Name</th>
							<th>Category</th>
							<th>Price Buy</th>
							<th>Price Sell</th>
							<th>Profit</th>
						</thead>
						<tbody>';
			$i=0;
			while($row = $result->fetch_assoc()){
				if(floatval($row['profit']) < 0){
					$profit = '<td style="background:#FF4500;">'.$row['profit'].' &euro;</td>';
				}
				else if(floatval($row['profit']) > 0){
					$profit = '<td style="background:#BFFF00;">'.$row['profit'].' &euro;</td>';
				}
				else{
					$profit = '<td>'.$row['profit'].' &euro;</td>';
				}
			
				echo '<tr>
						<td style="text-align:center;"><img src="./../images/icons/'.$row['marketIcon'].'" width="32" height="32" alt="'.$row['marketCode'].'"></td>
						<td>'.$row['marketCode'].' - '.$row['marketName'].'</td>
						<td>'.$row['category'].'</td>
						<td>'.$row['priceBuy'].' &euro; on '.date("H:i:s d-m-Y" , strtotime($row['timestampBuy'])).'</td>
						<td>'.$row['priceSell'].' &euro; on '.date("H:i:s d-m-Y" , strtotime($row['timestampSell'])).'</td>
						'.$profit.'
					</tr>';
				$i++;
			}
			echo '</tbody>
				 </table>
				</div>';
		}
		
		showHistoryProfit($_SESSION['idUser']);	
	}
	
	function showHistoryProfit($userId){
		global $conn;
		
		$getUserTotalProfit = "SELECT IF(ISNULL(SUM(price_buy)), 0.00, SUM(price_buy)) AS totalBuy,
									  IF(ISNULL(SUM(price_sell)), 0.00, SUM(price_sell)) AS totalSell,
									  IF(ISNULL(SUM(price_sell) - SUM(price_buy)), 0.00, SUM(price_sell) - SUM(price_buy)) AS totalProfit
							   FROM transaction
							   WHERE _iduser = $userId
									AND state = 'closed'";
		$result = $conn->query($getUserTotalProfit);
		while($row = $result->fetch_assoc()){
			echo '<footer id="adminFooter">
					<div class="footerContainer">
						TOTAL PURCHASES:<br> '.$row['totalBuy'].' &euro;
					</div>
					<div class="footerContainer">
						TOTAL SALES:<br> '.$row['totalSell'].' &euro;
					</div>';
				  if($row['totalProfit'] > 0){
					$profit = '<div class="footerContainer">
							     PROFIT:<br><span style="color:#BFFF00;">'.$row['totalProfit'].' &euro;</span>
							   </div>';
				  }
				  else if($row['totalProfit'] < 0){
					$profit = '<div class="footerContainer">
							     PROFIT:<br><span style="color:red;">'.$row['totalProfit'].' &euro;</span>
							   </div>';			  
				  }
				  else{
					$profit = '<div class="footerContainer">
							     PROFIT:<br><span>'.$row['totalProfit'].' &euro;</span>
							   </div>';			  
				  }
			echo $profit.'</footer>';
		}
		
		$conn->close();
	}

	
	/* Admin funcitons */
	function showUsers(){
		global $conn;
		$selectUsers = "SELECT *
						FROM user
						WHERE role = 'user'
						ORDER BY _idrank DESC, wallet DESC ";
		$result = $conn->query($selectUsers);
		if(mysqli_num_rows($result) == 0){
			echo "";
		}
		else{
			echo '<div id="cfd-section">
					<table id="cfd-table">
						<thead>
							<th></th>
							<th>Username</th>
							<th>Fullname</th>
							<th>Email</th>
							<th>Wallet</th>
							<th>Experience</th>
							<th>Registration Timestamp (h:m:s D-M-YY)</th>
							<th>Banned</th>
							<th></th>
						</thead>
						<tbody>';
			while($row = $result->fetch_assoc()){
				if($row['_idrank'] == 1){
					$icon = '<img src="./../images/wood.png" width="32" height="32" alt="Wood">';
				}
				else if($row['_idrank'] == 2){
					$icon = '<img src="./../images/bronze.png" width="32" height="32" alt="Bronze">';
				}
				else if($row['_idrank'] == 3){
					$icon = '<img src="./../images/silver.png" width="32" height="32" alt="Silver">';
				}
				else{
					$icon = '<img src="./../images/gold.png" width="32" height="32" alt="Gold">';
				}
				
				if($row['banned'] == 0){
					$banned = '<tr>';
					$txt = 'No';
				}
				else{
					$banned = '<tr style="background-color:#c6c6c6">';
					$txt = 'Yes';
				}
				
				echo ''.$banned.'
						<td style="text-align:center;">'.$icon.'</td>
						<td>'.$row['username'].'</td>
						<td>'.$row['name'].' '.$row['surname'].'</td>
						<td>'.$row['email'].'</td>
						<td>'.$row['wallet'].' &euro;</td>
						<td>'.$row['experience'].' EXP</td>
						<td>'.date("H:i:s d-m-Y" , strtotime($row['timestamp'])).'</td>
						<td>'.$txt.'</td>
						<td style="text-align:center;"><a href="./details.php?idUser='.$row['id'].'">Details</a></td>
					</tr>';
			}
			echo '</tbody>
				 </table>
				</div>';		
		}
	}
	
	function showUserDetails($idUser){
		global $conn;
		$idUser = $conn->real_escape_string($idUser);
		
		// Get and show the user personal informations
		$selectUserDetails = "SELECT *
							  FROM user
							  WHERE id = $idUser";
		$result = $conn->query($selectUserDetails);
		
		echo '<div>
				<div class="section">
					<header>
						<h3>USER INFORMATIONS</h3>
					</header>
					<table class="admin-table">
						<thead>
							<th></th>
							<th>Username</th>
							<th>Fullname</th>
							<th>Email</th>
							<th>Wallet</th>
							<th>Experience</th>
							<th>Banned</th>
						</thead>
						<tbody>';
		$row = $result->fetch_assoc();
		
		if($row['_idrank'] == 1){
			$icon = '<img src="./../images/wood.png" width="64" height="64" alt="Wood">';
		}
		else if($row['_idrank'] == 2){
			$icon = '<img src="./../images/bronze.png" width="64" height="64" alt="Bronze">';
		}
		else if($row['_idrank'] == 3){
			$icon = '<img src="./../images/silver.png" width="64" height="64" alt="Silver">';
		}
		else{
			$icon = '<img src="./../images/gold.png" width="64" height="64" alt="Gold">';
		}
		
		if($row['banned'] == 0){
			$banned = '<tr>';
			$txt = 'No';
		}
		else{
			$banned = '<tr style="background-color:#c6c6c6">';
			$txt = 'Yes';
		}
				
		echo ''.$banned.'
				<td style="text-align:center;">'.$icon.'</td>
				<td>'.$row['username'].'</td>
				<td>'.$row['name'].' '.$row['surname'].'</td>
				<td>'.$row['email'].'</td>
				<td>'.$row['wallet'].' &euro;</td>
				<td>'.$row['experience'].' EXP</td>
				<td>'.$txt.'</td>
			</tr>';
			
		echo '</tbody>
			</table>
		   </div>';			
		  
		// Get and show the recent activities of the user
		$selectUserRecentActivities = "SELECT M.code AS marketCode,
											  M.name AS marketName,
											  C.name AS categoryName,
											  T.price_buy AS priceBuy,
											  T.price_sell AS priceSell,
											  (T.price_sell - T.price_buy) AS profit,
											  T.timestamp_buy AS timestampBuy,
											  T.timestamp_sell AS timestampSell
									   FROM user U
											INNER JOIN
											transaction T
											ON U.id = T._iduser
											INNER JOIN 
											transaction_market TM
											ON T.id = TM._idtransaction
											INNER JOIN
											market M
											ON TM._idmarket = M.id
											INNER JOIN 
											category C
											ON M._idcategory = C.id
									   WHERE U.id = $idUser
											 AND T.state = 'closed'
									   ORDER BY T.timestamp_sell DESC
									   LIMIT 5";
		$result = $conn->query($selectUserRecentActivities);
		
		echo '<div class="section">';
		
		if(mysqli_num_rows($result) == 0){
			echo '<p style="font-size:18px;">No activities found.</p>';
		}
		else{
			echo '<header>
					<h3>RECENT ACTIVITIES</h3>
				  </header>
					<table style="margin-bottom:81px;" class="admin-table">
						<thead>
							<th></th>
							<th>Market</th>
							<th>Category</th>
							<th>Price Buy</th>
							<th>Price Sell</th>
							<th>Profit</th>
						</thead>
						<tbody>';	
			while($row = $result->fetch_assoc()){
			
				if(floatval($row['profit']) < 0){
					$profit = '<td style="background:#FF4500;">'.$row['profit'].' &euro;</td>';
				}
				else if(floatval($row['profit']) > 0){
					$profit = '<td style="background:#BFFF00;">'.$row['profit'].' &euro;</td>';
				}
				else{
					$profit = '<td>'.$row['profit'].' &euro;</td>';
				}
			
				echo '<tr>
						<td style="text-align:center;"><img src="./../images/icons/'.$row['marketCode'].'.png" width="32" height="32" alt="'.$row['marketCode'].'"></td>
						<td>'.$row['marketCode'].' - '.$row['marketName'].'</td>
						<td>'.$row['categoryName'].'</td>
						<td>'.$row['priceBuy'].' &euro; on '.$row['timestampBuy'].'</td>
						<td>'.$row['priceSell'].' &euro; on '.$row['timestampSell'].'</td>
						'.$profit.'
					  </tr>';			
			
			}
			echo '</table>';
		}					
		
		 
		echo '</div>
			</div>';
	}
?>