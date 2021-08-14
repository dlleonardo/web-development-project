var markets = [];
var obj = {};

/* The function setMarkets is called at the body onload (of home.php and wallet.php files), based on the number of cfd table rows: 
   - Initializes the markets objects array;
   - Update the html interface with the array contents;
   - Start the timer at every 2 seconds that calls a function that generates new markets prices.
*/
function setMarkets(location){
	var table = document.getElementById("cfd-table");
	if(table){
		var tbody = table.getElementsByTagName("tbody")[0];
		var rows = tbody.getElementsByTagName("tr").length;

		for(var j=0; j<rows; j++){
			var marketCode = document.getElementById("marketRow"+j);
			var code = marketCode.textContent.split(" - ");
			var newPrice = (Math.floor(Math.random() * (1000 - 100) + 100) / 100).toFixed(2);
			if(markets.length === 0){
				obj = {code:code[0], price:newPrice};
				markets.push(obj);
			}
			else{
				flag = false;
				for(var k=0; k<markets.length; k++){
					if(markets[k].code === code[0]){
						flag = true;
					}
				}
				if(flag === false){
					obj = {code:code[0], price:newPrice};
					markets.push(obj);			
				}
			}
		}
		updateInterfaceMarkets(rows, location);
		startTimer(rows, location);
	}
}

/*
	The function updateInterfaceMarkets, based on the markets array elements, update the text of the market price and the href attribute in the <a> element.
*/
function updateInterfaceMarkets(rows, location){
	for(var i=0; i<rows; i++){
		
		var marketCode = document.getElementById("marketRow"+i); 
		var code = marketCode.textContent.split(" - "); //code[0] is the market code
		var marketPrice = document.getElementById("marketPrice"+i);
		var marketHref = document.getElementById("marketBtn"+i);
		
		for(var j=0; j<markets.length; j++){
			if(markets[j].code === code[0]){
				marketPrice.innerHTML = markets[j].price;
			}
			if(location === 'home' && markets[j].code === code[0]){
				marketHref.setAttribute('href','./home.php?marketCode='+code[0]+'&action=buy&price='+markets[j].price);
			}
			if(location === 'wallet' && markets[j].code === code[0]){
				var href = marketHref.getAttribute('href');
				var attribute = href.split('&');
				marketHref.setAttribute('href','./home.php?marketCode='+code[0]+'&action=sell&'+attribute[2]+'&price='+markets[j].price);
			}
		}
	
	}
}

/*
	The function startTimer starts a timer that generates new markets prices every 2 seconds, then call the updateInterfaceMarkets for update the html interface.
*/
function startTimer(rows, location){
	
	setInterval(function(){
		for(var i=0; i<markets.length; i++){
			var newPrice = (Math.floor(Math.random() * (1000 - 100) + 100) / 100).toFixed(2);
			
			for(var j=0; j<rows; j++){
				var marketCode = document.getElementById("marketRow"+j); 
				var code = marketCode.textContent.split(" - "); //code[0] is the market code
				var marketChangeColor = document.getElementById("marketChange"+j);
				if(markets[i].code === code[0]){
					if(parseFloat(newPrice) > parseFloat(markets[i].price)){
						marketChangeColor.style.background = '#BFFF00';
					}
					else if(parseFloat(newPrice) < parseFloat(markets[i].price)){
						marketChangeColor.style.background = '#FF4500';
					}
					else{
						marketChangeColor.style.background = 'transparent';
					}
				}
			}
			
			markets[i].price = newPrice;
		}
		updateInterfaceMarkets(rows, location);
	}, 1000*2);
}

/*
	The function loadDepositType is called in deposit-credits.php script, at the on change value of the select list it loads a different html.
*/
function loadDepositType(depositType){			
	var container = document.getElementById('depositCreditsForm');
				
	if(typeof(depositType) !== undefined){
		if(depositType === 'CC'){
			container.innerHTML = '<div id="depositCreditsContainer">'+
									'<form method="POST" action="./utility/sendDeposit.php">'+
										'<div>'+
											'<span>Amount: (&euro;)</span><br>'+
											'<input name="amount" type="number" min="1" max="10000" value="1" step="0.01" style="text-align:center;" required>'+
										'</div>'+
										'<div>'+
											'<span>Card Number:</span><br>'+
											'<input id="cardNumber" class="inputDeposit" name="cardNumber" type="text" minlength="16" maxlength="16"'+
												   'pattern= "^[0-9]+$" title="Only numbers are allowed" required>'+
										'</div>'+
										'<div>'+
											'<div>'+
												'<span>Valid Thru:</span><br>'+
												'<input id="validThruMonth" class="inputDeposit" name="validThruMonth" type="text" minlength="2" maxlength="2"'+
													   'pattern= "^[0-9]+$" title="Only numbers are allowed" required> / '+
												'<input id="validThruYear" class="inputDeposit" name="validThruYear" type="text" minlength="2" maxlength="2"'+ 
													   'pattern= "^[0-9]+$" title="Only numbers are allowed" required><br>'+
											'</div>'+
											'<div>'+
												'<span>Secret Code:</span><br>'+
												'<input id="secretCode" class="inputDeposit" name="secretCode" type="text" minlength="3" maxlength="3"'+
													   'pattern= "^[0-9]+$" title="Only numbers are allowed" required><br>'+
											'</div>'+
										'</div>'+
										'<div style="margin:0;"><input id="submitDeposit" type="submit" value="Confirm Deposit"></div>'+
										'<input type="hidden" value="'+depositType+'" name="depositType">'+
									'</form>'+
								   '</div>';
		}
		else if(depositType === 'PP'){
			container.innerHTML = '<div id="depositCreditsContainer">'+
									'<form method="POST" action="./utility/sendDeposit.php">'+
										'<div>'+
											'<span>Amount: (&euro;)</span><br>'+
											'<input name="amount" type="number" min="1" max="10000" value="1" step="0.01" style="text-align:center;" required>'+
										'</div>'+
										'<div>'+
											'<span>Email:</span><br>'+
											'<input id="email" class="inputDeposit" name="email" type="email" style="width:80%" required>'+
										'</div>'+
										'<div style="margin:0;"><input id="submitDeposit" type="submit" value="Confirm Deposit"></div>'+
										'<input type="hidden" value="'+depositType+'" name="depositType">'+
									'</form>'+
								   '</div>';
		}
		else if(depositType === 'BT'){
			container.innerHTML = '<div id="depositCreditsContainer">'+
									'<form method="POST" action="./utility/sendDeposit.php">'+
										'<div>'+
											'<span>Amount: (&euro;)</span><br>'+
											'<input name="amount" type="number" min="1" max="10000" value="1" step="0.01" style="text-align:center;" required>'+
										'</div>'+
										'<div>'+
											'<span>Name:</span><br>'+
											'<input id="name" class="inputDeposit" name="name" type="text" style="width:80%" pattern="^[a-zA-z ]+"'+
												   ' title="Only letters are allowed" required>'+
										'</div><div>'+
											'<span>Surname:</span><br>'+
											'<input id="surname" class="inputDeposit" name="surname" type="text" style="width:80%" pattern="^[a-zA-z ]+"'+
												   'title="Only letters are allowed" required>'+
										'</div>'+
										'<div>'+
											'<span>IBAN:</span><br>'+
											'<input type="text" class="inputDeposit" name="iban" style="width:80%" minlength="27" maxlength="27" pattern="[A-Z0-9-]+"'+
												   'title="Only capital letters and numbers are allowed" required>'+
										'</div>'+
										'<div style="margin:0;"><input id="submitDeposit" type="submit" value="Confirm Deposit"></div>'+
										'<input type="hidden" value="'+depositType+'" name="depositType">'+
									'</form>'+
								   '</div>';
		}
		else{
			container.innerHTML = '';
		}
	}		
}