function showKeyUser(rankNum) {
	var xmlhttp;
	if (rankNum == "") {
		document.getElementById("txtHint").innerHTML = "";
		return;
	}
	if (window.XMLHttpRequest) { // code for IE7+, Firefox, Chrome, Opera, Safari
		xmlhttp = new XMLHttpRequest();
	} else { // code for IE6, IE5
		xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
	}
	xmlhttp.onreadystatechange = function () {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			document.getElementById("txtHint").innerHTML = xmlhttp.responseText;
		}
	}
	xmlhttp.open("GET", "mysql_keyuser.php?q=" + rankNum, true);
	xmlhttp.send();
}
function showRank() {
	var xmlhttp;

	if (window.XMLHttpRequest) { // code for IE7+, Firefox, Chrome, Opera, Safari
		xmlhttp = new XMLHttpRequest();
	} else { // code for IE6, IE5
		xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
	}
	xmlhttp.onreadystatechange = function () {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			document.getElementById("rank").innerHTML = xmlhttp.responseText;
		}
	}
	xmlhttp.open("GET", "mysql_keyuser.php", true);
	xmlhttp.send();
}
/*
google.load('visualization', '1.0', {'packages' : ['corechart']});
google.setOnLoadCallback(drawChart);
 */

function showKeyUser2(rankNum) {
	var xmlhttp;
	if (rankNum == "") {
		document.getElementById("txtHint").innerHTML = "";
		return;
	}
	if (window.XMLHttpRequest) { // code for IE7+, Firefox, Chrome, Opera, Safari
		xmlhttp = new XMLHttpRequest();
	} else { // code for IE6, IE5
		xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
	}
	xmlhttp.onreadystatechange = function () {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			document.getElementById("txtHint").innerHTML = xmlhttp.responseText;
			google.load('visualization', '1.0', {'packages' : ['corechart']});
			drawChartPie(rankNum);
			drawChartHistory(rankNum);
			drawChartPieC(rankNum);
			drawChartHistoryC(rankNum);
		}
	}
	xmlhttp.open("GET", "mysql_keyuser.php?q=" + rankNum, true);
	xmlhttp.send();
	
}
		
function drawChartPie(q) {
	var jsonData = $.ajax({
			url : "./mysql_like_ratio.php?q=" + q,
			dataType : "json",
			async : false
		}).responseText;
	// Create our data table out of JSON data loaded from server.
	var data = new google.visualization.DataTable(jsonData);

	// Set chart options
	var options = {
		'title' : 'Like Ratio',
		'width' : 400,
		'height' : 250
	};

	var chart = new google.visualization.PieChart(document.getElementById('chart_like_ratio'));
	chart.draw(data, options);
}

function drawChartHistory(q) {

	var jsonData = $.ajax({
	  url: "./mysql_like_history.php?q=" + q,
	  dataType:"json",
	  async: false,
	  }).responseText;
	// Create our data table out of JSON data loaded from server.
	var data = new google.visualization.DataTable(jsonData);

	// Set chart options
	var options = {'title':'Like History',
					'hAxis': { direction: -1, slantedText: true, slantedTextAngle: 45},
					legend: { position: 'none' },
				   'width':600,
				   'height':250
				   };

	var chart = new google.visualization.LineChart(document.getElementById('chart_like_history'));
	chart.draw(data, options);
}

function drawChartPieC(q) {
	var jsonData = $.ajax({
			url : "./mysql_comment_ratio.php?q=" + q,
			dataType : "json",
			async : false
		}).responseText;
	// Create our data table out of JSON data loaded from server.
	var data = new google.visualization.DataTable(jsonData);

	// Set chart options
	var options = {
		'title' : 'Comment Ratio',
		'width' : 400,
		'height' : 250
	};

	var chart = new google.visualization.PieChart(document.getElementById('chart_comment_ratio'));
	chart.draw(data, options);
}

function drawChartHistoryC(q) {

	var jsonData = $.ajax({
	  url: "./mysql_comment_history.php?q=" + q,
	  dataType:"json",
	  async: false,
	  }).responseText;
	// Create our data table out of JSON data loaded from server.
	var data = new google.visualization.DataTable(jsonData);

	// Set chart options
	var options = {'title':'Comment History',
					'hAxis': { direction: -1, slantedText: true, slantedTextAngle: 45},
					legend: { position: 'none' },
				   'width':600,
				   'height':250};

	var chart = new google.visualization.LineChart(document.getElementById('chart_comment_history'));
	chart.draw(data, options);
}

window.onload = showRank;