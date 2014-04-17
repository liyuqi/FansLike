<meta charset="utf-8">
<?php
//mysql_keyuser
header('Content-type: text/html; charset=utf-8');
$q=$_GET["q"];

$con = mysql_connect('localhost', 'root', '');
if (!$con)
 {
 die('Could not connect: ' . mysql_error());
 }

mysql_select_db("db3", $con);
mysql_query("SET NAMES 'UTF8'");
//*/
$sql0="SELECT * FROM table_post_sex WHERE pID = '".$q."' ";

$result0 = mysql_query($sql0);

echo "<table id='post'>
<tr>
<th>post ID</th>
<th>title</th>
<th>link</th>
</tr>";

while($row0 = mysql_fetch_array($result0))
 {
	 echo "<tr>";
	 echo "<td>" . $row0['pID'] . "</td>";
	 echo "<td>" . $row0['ptitle'] . "</td>";
	 echo "<td>" . "<a href=http://pansci.tw/archives/" . $row0['pID'] . " target=_blank'> http://pansci.tw/archives/".$row0['pID']." </a>" . "</td>";
	 echo "</tr>";
 }
 
echo "</table>";

echo "<p>Recommend list</p>";

$sql1="SELECT * FROM table_post_post WHERE pID = '".$q."' ";

$result1 = mysql_query($sql1);

echo "<table id='recommend'>
<tr>
<th>Rank</th>
<th>Weight</th>
<th>Post ID</th>
<th>Title</th>
<th>Link</th>
</tr>";

while($row1 = mysql_fetch_array($result1))
 {
	 echo "<tr>";
	 echo "<td>" . $row1['rank'] . "</td>";
	 echo "<td>" . $row1['rweight'] . "</td>";
	 echo "<td>" . $row1['rID'] . "</td>";
	 echo "<td>" . $row1['rtitle'] . "</td>";
	 echo "<td>" . "<a href=http://pansci.tw/archives/" . $row1['rID'] . " target=_blank'> http://pansci.tw/archives/".$row1['rID']." </a>" . "</td>";
	 echo "</tr>";
 }
echo "</table>";

//*/
$first="SELECT * FROM table_post_post";
$resultFirst = mysql_query($first);
echo "<option value=''>choice</option>";
while($rowFirst = mysql_fetch_array($resultFirst))
 {
echo "<option value=http://pansci.tw/archives/'".$rowFirst['pID']."'>http://pansci.tw/archives/" . $rowFirst['pID'] . "</option>";
 }

mysql_close($con);
?>