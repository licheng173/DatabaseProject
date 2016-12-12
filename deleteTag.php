<?php
session_start();
if (!isset($_SESSION['uid'])) {
    header("Location: login.php");
}

$rid = $_GET['rid'];
$tid = $_GET['tag'];

include "../dbconf.inc";

$db = new mysqli($hostname, $usr, $pwd, $dbname);
if ($db->connect_error) {
    die('Unable to connect to database: ' . $db->connect_error);
}

if ($result = $db->prepare("delete from recipe_tag where rid = ? and tid = ?;")) {
    $result->bind_param("si", $rid, $tid);
    $result->execute();
    $result->close();
}
$db->close();
echo "<script>location.href='editRicpe.php?rid=$rid'</script>";
exit();
?>