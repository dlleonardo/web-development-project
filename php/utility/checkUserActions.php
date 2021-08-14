<?php
	require_once "./utility/dbManager.php";

	function checkUserActions(){
		$marketCode = null;
		if(isset($_GET['marketCode'])){
			$marketCode = $_GET['marketCode'];
		}
		else return;
		
		$action = null;
		if(isset($_GET['action'])){
			$action = $_GET['action'];
		}
		else return;	

		$price = null;
		if(isset($_GET['price'])){
			$price = $_GET['price'];
		}
		else return;
		
		$transactionId = null;
		if(isset($_GET['transactionId'])){
			$transactionId = $_GET['transactionId'];
		}

		manageMarket($action, $marketCode, $transactionId, $_SESSION['idUser'], $price);
	}
	
	function checkUserPackets(){
		$packetId = null;
		if(isset($_GET['packetId']) && isset($_GET['packetType'])){
			$packetId = $_GET['packetId'];
			$packetType = $_GET['packetType'];
		}
		else return;
		
		openPacket($_SESSION['idUser'], $packetId, $packetType);	
	}
	
	function manageMarket($action, $marketCode, $transactionId, $userId, $price){
	
		$conn = openConnection();
	
		if($action === 'buy' && !isset($transactionId)){
			// check if user has enough credits
			if(floatval($_SESSION['wallet']) >= floatval($price)){
				$marketCode = $conn->real_escape_string($marketCode);
				$userId = $conn->real_escape_string($userId);
				$action = $conn->real_escape_string($action);			

				$marketId = getMarketIdByCode($marketCode, $conn);
				updateWallet($userId, $action, $price, $conn);
				$goalMsg = '';
				// Check if the user already purchased markets, if not, unlock the goal 'First Purchase'
				if(checkFirstPurchase($userId, $conn)){
					$goalMsg .= '<br>You also unlocked the FIRST PURCHASE goal!';
				}
				
				// Check if the user has purchased for the first the Euro-Pound currency
				if(checkFirstPurchaseByMarketId($userId, $marketId, $marketCode, $conn)){
					if($marketCode == 'EUR-GBP'){
						$goalMsg .= '<br>You also unlocked the BRITISH LOVER goal!';
					}
					if($marketCode == 'GOLD'){
						$goalMsg .= '<br>You also unlocked the GOLD LOVER goal!';
					}
				}
				
				insertTransaction($marketId, $userId, $action, $price, $conn);
				
				// Check if the user purchased almost one time all the cryptocurrencies 
				if(checkAllPurchasesByCategory($userId, 'CRYP', $conn)){
					$goalMsg .= '<br>You also unlocked the ALL CRYPTOCURRENCIES goal!';
				}
				
				// Check if the user purchased almost one time all the currencies 
				if(checkAllPurchasesByCategory($userId, 'CURR', $conn)){
					$goalMsg .= '<br>You also unlocked the ALL CURRENCIES goal!';
				}
				
				// Check if the user purchased almost one time all the commodities 
				if(checkAllPurchasesByCategory($userId, 'COMM', $conn)){
					$goalMsg .= '<br>You also unlocked the ALL COMMODITIES goal!';
				}
				
				$message = "You bought the market ".$marketCode." at price ".$price." ".$goalMsg;
			}
			else{
				$message = "You don't have enough credits for buy this market.";
			}
		}
		
		if($action === 'sell'){
			// get transaction price and market price, profit = MP - TP
			// set state = closed of transaction buy, insert new transaction with state = closed and type = sell
			// update wallet user wallet+profit
			$marketCode = $conn->real_escape_string($marketCode);
			$userId = $conn->real_escape_string($userId);
			$action = $conn->real_escape_string($action);
			$transactionId = $conn->real_escape_string($transactionId);
			
			$marketId = getMarketIdByCode($marketCode, $conn);
			
			$transactionValue = getTransactionValueById($transactionId, $conn);
			$profit = number_format(floatval($price) - floatval($transactionValue), 2);
			$goalMsg = '';
			if(checkFirstSale($userId, $conn)){
				$goalMsg .= '<br>You also unlocked the FIRST SALE goal!';
			}
			if(checkFirstSaleByMarketId($userId, $marketId, $marketCode, $conn)){
				if($marketCode == 'EUR-USD'){
					$goalMsg .= '<br>You also unlocked the AMERICAN SELLER goal!';
				}
				if($marketCode == 'COPPER'){
					$goalMsg .= '<br>You also unlocked the COPPER SELLER goal!';
				}
			}
			closeTransaction($transactionId, $price, $conn);
			updateWallet($userId, $action, $price, $conn);
			
			if($profit > 0){
				$message = "Congratulations, your profit is: ".$profit." ".$goalMsg;
			}
			else if($profit < 0){
				$message = "Oh no! Your profit is: ".$profit." ".$goalMsg;
			}
			else{
				$message = "Your profit is equal to zero. ".$goalMsg;
			}
		}
		
		// Check experience and eventually update rank
		// Update user rank to bronze
		if(intval($_SESSION['experience']) >= 100 && $_SESSION['rank'] == 1){
			updateUserRank($userId, 2, $conn);
			generatePacket($userId, $conn);
			$message .= "<br>Bronze rank unlocked!";
		}
		// Update user rank to silver
		if(intval($_SESSION['experience']) >= 300 && $_SESSION['rank'] == 2){
			updateUserRank($userId, 3, $conn);
			generatePacket($userId, $conn);
			$message .= "<br>Silver rank unlocked!";
		}
		// Update user rank to gold
		if(intval($_SESSION['experience']) >= 500 && $_SESSION['rank'] == 3){
			updateUserRank($userId, 4, $conn);
			generatePacket($userId, $conn);
			$message .= "<br>Gold rank unlocked!";
		}
		if($action === 'sell'){
			header("location: ./wallet.php?message=".$message);
		}
		if($action === 'buy'){
			header("location: ./home.php?message=".$message);
		}
		$conn->close();
	}
	
	function insertTransaction($marketId, $userId, $action, $price, $conn){
		$insertTransaction = "INSERT INTO transaction(_iduser, type, price_buy)
							  VALUES($userId, '$action', $price)";	
		$conn->query($insertTransaction);
		$lastTransactionId = $conn->insert_id;
		$insertRelation = "INSERT INTO transaction_market(_idtransaction, _idmarket)
						   VALUES($lastTransactionId, $marketId)";
		$conn->query($insertRelation);
	}
	
	function closeTransaction($transactionId, $price, $conn){
		$updateTransaction = "UPDATE transaction
							  SET state = 'closed', type = 'sell', timestamp_sell = NOW(), price_sell = '$price'
							  WHERE id = '$transactionId'";
		$conn->query($updateTransaction);
	}
	
	function updateWallet($userId, $action, $credits, $conn){
		if($action === 'buy'){
			$decrementWallet = "UPDATE user
								SET wallet = wallet - $credits
								WHERE id = $userId";
			$conn->query($decrementWallet);
			$_SESSION['wallet'] = floatval($_SESSION['wallet']) - floatval($credits);
			$_SESSION['wallet'] = number_format($_SESSION['wallet'], 2, ".", "");
		}
		
		if($action === 'sell'){
			$incrementWallet = "UPDATE user
								SET wallet = wallet + $credits
								WHERE id = $userId";
			$conn->query($incrementWallet);		
			$_SESSION['wallet'] = floatval($_SESSION['wallet']) + floatval($credits);
			$_SESSION['wallet'] = number_format($_SESSION['wallet'], 2, ".", "");			
		}
	}
	
	function updateUserExperience($userId, $exp, $conn){
		$updateUserExperience = "UPDATE user
								 SET experience = experience + $exp
								 WHERE id = $userId";
		$conn->query($updateUserExperience);
		$_SESSION['experience'] = intval($_SESSION['experience']) + intval($exp);
	}
	
	function getMarketIdByCode($marketCode, $conn){
		$getMarketByCode = "SELECT id
							FROM market
							WHERE code = '$marketCode' ";
		$result = $conn->query($getMarketByCode);
		$row = $result->fetch_assoc();
		return $row['id'];
	}
	
	function getTransactionValueById($transactionId, $conn){
		$getTransactionValue = "SELECT price_buy
								FROM transaction
								WHERE id = '$transactionId'";
		$result = $conn->query($getTransactionValue);
		$row = $result->fetch_assoc();
		return $row['price_buy'];
	}
	
	function updateUserRank($userId, $rankId, $conn){
		$rankId = intval($rankId);
		$updateUserRank = "UPDATE user
						   SET _idrank = $rankId
						   WHERE id = $userId";
		$conn->query($updateUserRank);
		$_SESSION['rank'] = $rankId;
	}
	
	function generatePacket($userId, $conn){
		$packetId = intval(rand(1,3));
		$insertUserPacket = "INSERT INTO user_packet(_iduser, _idpacket)
							 VALUES($userId, $packetId)";
		$conn->query($insertUserPacket);
	}
	
	function getPacketCreditsByType($packetId, $conn){
		$getPacketCredits = "SELECT credits
							 FROM packet
							 WHERE type = $packetId";
		$result = $conn->query($getPacketCredits);
		$row = $result->fetch_assoc();
		return $row['credits'];
	}
	
	function openPacket($userId, $packetId, $packetType){
		$conn = openConnection();
		
		$openPacket = "UPDATE user_packet
					   SET closed = 0
					   WHERE _iduser = $userId
							 AND id = $packetId
							 AND closed = 1";
		$conn->query($openPacket);
		$credits = getPacketCreditsByType($packetType, $conn);
		updateWallet($userId, 'sell', $credits, $conn);
		
		$msg = 'Congratulations! You gained '.$credits.' credits!';
		header("location: ./packets.php?message=".$msg);
		
		$conn->close();
	}
	
	/* functions for check if goals are unlockable */
	function checkFirstPurchase($userId, $conn){
		$checkUserPurchases = "SELECT *
							   FROM transaction
							   WHERE _iduser = $userId";
		$result = $conn->query($checkUserPurchases);
		if(mysqli_num_rows($result) === 0){
			unlockGoal($userId, 1, 30, $conn);
			return true;
		}
		else{
			return false;
		}
	}
	
	function checkFirstPurchaseByMarketId($userId, $marketId, $marketCode, $conn){
		$checkFirstPurchaseByMarketId = "SELECT *
										 FROM transaction_market TM
											  INNER JOIN 
											  transaction T
											  ON TM._idtransaction = T.id
										 WHERE T._iduser = $userId
											   AND TM._idmarket = $marketId";
		$result = $conn->query($checkFirstPurchaseByMarketId);
		if(mysqli_num_rows($result) === 0){
			if($marketCode == 'EUR-GBP'){
				unlockGoal($userId, 4, 50, $conn);
			}
			if($marketCode == 'GOLD'){
				unlockGoal($userId, 7, 50, $conn);
			}
			return true;
		}
		else{
			return false;
		}
	}
	
	function checkFirstSale($userId, $conn){
		$checkUserSales = "SELECT *
						   FROM transaction
						   WHERE _iduser = $userId
								 AND type = 'sell'";
		$result = $conn->query($checkUserSales);
		if(mysqli_num_rows($result) === 0){
			unlockGoal($userId, 2, 30, $conn);
			return true;
		}
		else{
			return false;
		}
	}
	
	function checkFirstSaleByMarketId($userId, $marketId, $marketCode, $conn){
		$checkFirstSaleByMarketId = "SELECT *
									 FROM transaction_market TM
										  INNER JOIN
										  transaction T
										  ON TM._idtransaction = T.id
									 WHERE T._iduser = $userId
										   AND TM._idmarket = $marketId
										   AND T.type = 'sell'";
		$result = $conn->query($checkFirstSaleByMarketId);					
		if(mysqli_num_rows($result) === 0){
			if($marketCode == 'EUR-USD'){
				unlockGoal($userId, 5, 50, $conn);
			}
			if($marketCode == 'COPPER'){
				unlockGoal($userId, 8, 50, $conn);
			}
			return true;
		}
		else{
			return false;
		}
	}
	
	function checkAllPurchasesByCategory($userId, $categoryCode, $conn){
		if($categoryCode === 'CRYP'){
			$goalId = 3;
			$exp = 40;
		}
		if($categoryCode === 'CURR'){
			$goalId = 6;
			$exp = 100;
		}
		if($categoryCode === 'COMM'){
			$goalId = 9;
			$exp = 100;
		}
	
		$checkUserPurchasesByCategory = "SELECT M.name AS marketName
										 FROM user_goal UG
											  INNER JOIN 
											  transaction T
											  ON UG._iduser = T._iduser
											  INNER JOIN
											  transaction_market TM
											  ON T.id = TM._idtransaction
											  INNER JOIN
											  market M
											  ON TM._idmarket = M.id
											  INNER JOIN 
											  category C
											  ON M._idcategory = C.id
										 WHERE T._iduser = $userId
											   AND C.code = '$categoryCode'
											   AND UG.unlocked = 0
											   AND UG._idgoal = $goalId
										 GROUP BY M.name";
		$result = $conn->query($checkUserPurchasesByCategory);
		if(mysqli_num_rows($result) === 4){
			unlockGoal($userId, $goalId, $exp, $conn);
			return true;
		}
		else{
			return false;
		}
	}
	
	function unlockGoal($userId, $goalId, $exp, $conn){
		$unlockGoal = "UPDATE user_goal
					   SET unlocked = 1
					   WHERE _iduser = $userId
							 AND _idgoal = $goalId";
		$conn->query($unlockGoal);
		updateUserExperience($userId, $exp, $conn);		
	}
	
	/* Admin functions */
	function sendAdminAction($idUser, $action){
		$conn = openConnection();
		
		if($action === 'packet'){
			generatePacket($idUser, $conn);
			$msg = 'The packet has been sent successfully.';
		}
		
		if($action === 'ban'){
			banUser($idUser, $conn);
			$msg = 'The user has been banned successfully.';
		}
		
		if($action === 'cancel'){
			cancelBanUser($idUser, $conn);
			$msg = 'The user ban has been canceled successfully.';
		}
		
		header("location: ./details.php?idUser=".$idUser."&message=".$msg);
		$conn->close();
	}
	
	function banUser($idUser, $conn){
		$banUser = "UPDATE user
					SET banned = 1
					WHERE id = $idUser";
		$conn->query($banUser);
	}
	
	function cancelBanUser($idUser, $conn){
		$cancelBanUser = "UPDATE user
						  SET banned = 0
						  WHERE id = $idUser";
		$conn->query($cancelBanUser);
	}
	
	function isBanned($idUser){
		$conn = openConnection();
		
		$checkUserBan = "SELECT banned
					  FROM user
					  WHERE id = $idUser";
		$result = $conn->query($checkUserBan);
		$row = $result->fetch_assoc();
		if($row['banned'] == 0){
			return false;
		}
		else{
			return true;
		}
		
		$conn->close();
	}
?>