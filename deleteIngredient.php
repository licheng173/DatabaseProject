<?php
session_start();
if (!isset($_SESSION['uid'])) {
    header("Location: login.php");
}

$rid = $_GET['rid'];
$iname = $_GET['iname'];

include "../dbconf.inc";

$db = new mysqli($hostname, $usr, $pwd, $dbname);
if ($db->connect_error) {
    die('Unable to connect to database: ' . $db->connect_error);
}

if ($result = $db->prepare("delete from ingredient where rid = ? and iname = ?;")) {
    $result->bind_param("ss", $rid, $iname);
    $result->execute();
    $result->close();
}
$db->close();
echo "<script>location.href='editRicpe.php?rid=$rid'</script>";
exit();
?>