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
$sql0="SELECT distinct pID,ptitle,plink FROM table_post WHERE pID = '".$q."' ";

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
	 echo "<td>" . "<a href='" . $row0['plink'] . "'> ".$row0['plink']." </a>" . "</td>";
	 echo "</tr>";
 }
echo "</table>";
//*/
echo "<p>Recommend list</p>";
//*/
$sql1="SELECT rID,rtitle,rlink FROM table_post WHERE pID = '".$q."' ";

$result1 = mysql_query($sql1);

echo "<table id='recommend'>
<tr>
<th>post ID</th>
<th>title</th>
<th>link</th>
</tr>";

while($row1 = mysql_fetch_array($result1))
 {
	 echo "<tr>";
	 echo "<td>" . $row1['rID'] . "</td>";
	 echo "<td>" . $row1['rtitle'] . "</td>";
	 echo "<td>" . "<a href='" . $row1['rlink'] . "'> ".$row1['rlink']." </a>" . "</td>";
	 echo "</tr>";
 }
echo "</table>";
//*/
//*/
$first="SELECT distinct pID FROM table_post";
$resultFirst = mysql_query($first);
echo "<option value=''>choice</option>";
while($rowFirst = mysql_fetch_array($resultFirst))
 {
echo "<option value='".$rowFirst['pID']."'>" . $rowFirst['pID'] . "</option>";
 }

mysql_close($con);
?>