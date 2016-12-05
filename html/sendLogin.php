<?php

$dbhost = 'localhost:3306';
$dbuser = 'root';
$dbpass = '';

$Name = $_POST['username'];
$Password = $_POST['password'];

$con = mysql_connect($dbhost, $dbuser, $dbpass);
if(! $conn )
   {
     die('Could not connect: ' . mysql_error());
   }
$db = mysql_select_db('CookZilla', $con) or die("Failed to connect to Mysql: ".mysql__error());

function signIn()
{
	session_start();
	if(!empty($_POST['username']))
	{
		$query = mysql_query("SELECT * FROM User WHERE uname = '$_POST[username]' AND upassword = '$_POST[password]'") or die(mysql_error());
		$row = mysql_fetch_array($query) or die(mysql_error());
		if(!empty($row['uname']) AND !empty($row['upassword']))
		{
			$_SESSION['uname'] = $row['upassword'];
			echo "SUCCESSFULLY LOGIN TO USER PROFILE PAGE...";
		}
		else
		{
			echo "SORRY... YOU ENTERD WRONG ID AND PASSWORD... PLEASE RETRY...";
		}
	}
}

if(isset($_POST['login-submit']))
{
	signIn();
}

?>
