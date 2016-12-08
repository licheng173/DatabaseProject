<?php

session_start();
if (!isset($_SESSION['uid'])) {
    header("Location: login.php");
}

include "../dbconf.inc";

$db = new mysqli($hostname, $usr, $pwd, $dbname);
if ($db->connect_error) {
    die('Unable to connect to database: ' . $db->connect_error);
}

$uid = $_SESSION['uid'];

$uname = $_POST['username'];
$realname = $_POST['realname'];
$uprofile = $_POST['uprofile'];
$pass = $_POST['password'];
$conpass = $_POST['confirm-password'];

$password_not_match = 0;
$uname_taken = 0;

if (strcmp($pass, $conpass) != 0) {
    $password_not_match = 1;
}

$hashed_password = md5($pass); // this function works only in PHP 5.5 or latest version

if ($result = $db->prepare("select uid from user where uname = ?;")) {
    $result->bind_param("s", $uname);
    $result->execute();
    $result->bind_result($fetched_uid);
    $result->fetch();
    if ($fetched_uid != $uid) {
        $uname_taken = 1;
    }
    $result->close();
}

if ($password_not_match == 1 || $uname_taken == 1) {
    $db->close();
    echo "<script>location.href='profile.php?password_not_match=$password_not_match&uname_taken=$uname_taken'</script>";
    exit();
}

if ($result1 = $db->prepare("update user set uname = ?, name = ?, uprofile = ?, upassword = ? where uid = ?;")) {
    $result1->bind_param("ssssi", $uname, $realname, $uprofile, $hashed_password, $uid);
    $result1->execute();
    $result1->close();
}

$db->close();
echo "<script>location.href='mypage.php'</script>";
?>