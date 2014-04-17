
<?php
$q = $_GET['q'];
$con = mysql_connect('localhost', 'root', '') or die('Error connecting to server');
 mysql_query("SET NAMES 'UTF8'");
mysql_select_db('db3', $con);
//mysql_post_sex.php
// write your SQL query here (you may use parameters from $_GET or $_POST if you need them)

$query = mysql_query("SELECT * FROM table_post_sex WHERE pID = '".$q."'");

$table = array();
$table['cols'] = array(
	array('label' => 'sex ratio', 'type' => 'string'),
    array('label' => '男', 'type' => 'number'),
	array('label' => '女', 'type' => 'number')
);

$rows = array();
while($r = mysql_fetch_assoc($query)) {
    $temp = array();
	// each column needs to have data inserted via the $temp array
	$temp[] = array('v' => "文章".$r['pID']);
	$temp[] = array('v' => (int) $r['male_count']);
	$temp[] = array('v' => (int) $r['female_count']); // typecast all numbers to the appropriate type (int or float) as needed - otherwise they are input as strings
	
	// insert the temp array into $rows
    $rows[] = array('c' => $temp);
}

// populate the table with rows of data
$table['rows'] = $rows;

// encode the table as JSON
$jsonTable = json_encode($table);

// set up header; first two prevent IE from caching queries
header('Cache-Control: no-cache, must-revalidate');
header('Content-type: application/json');

// return the JSON data
echo $jsonTable;
mysql_close($con);
?>

