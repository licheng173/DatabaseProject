<?php
session_start();
if (!isset($_SESSION['uid'])) {
    header("Location: login.php");
}

$rid = $_GET['rid'];
$pid = $_GET['pid'];

include "../dbconf.inc";

$db = new mysqli($hostname, $usr, $pwd, $dbname);
if ($db->connect_error) {
    die('Unable to connect to database: ' . $db->connect_error);
}

if ($result = $db->prepare("delete from recipe_picture where pid = ?;")) {
    $result->bind_param("i", $pid);
    $result->execute();
    $result->close();
}
$db->close();
echo "<script>location.href='editRicpe.php?rid=$rid'</script>";
exit();
?>