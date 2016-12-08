<?php
session_start();
if (!isset($_SESSION['uid'])) {
    header("Location: login.php");
}

$rid = $_GET['rid'];

include "../dbconf.inc";

$db = new mysqli($hostname, $usr, $pwd, $dbname);
if ($db->connect_error) {
    die('Unable to connect to database: ' . $db->connect_error);
}

if ($result = $db->prepare("delete from recipe where rid = ?;")) {
    $result->bind_param("s", $rid);
    $result->execute();
    $result->close();
}
$db->close();
echo "<script>location.href='mypage.php'</script>";
exit();
?>