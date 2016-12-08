<?php
session_start();
if (!isset($_SESSION['uid'])) {
    header("Location: login.php");
}

date_default_timezone_set('America/New_York');

$uid = $_SESSION['uid'];
$gid = $_POST['gid'];
$etitle = $_POST['etitle'];
$elocation = $_POST['elocation'];
$edescription = $_POST['edescription'];
$etime = $_POST['etime'];
$etime = strftime('%Y-%m-%d %H:%M:%S', strtotime($etime));

include "../dbconf.inc";

$db = new mysqli($hostname, $usr, $pwd, $dbname);
if ($db->connect_error) {
    die('Unable to connect to database: ' . $db->connect_error);
}

if ($result = $db->prepare("insert into event (gid, etime, elocation, edescription, ecuid, etitle) values (?, ?, ?, ?, ?, ?);")) {
    $result->bind_param("ssssis", $gid, $etime, $elocation, $edescription, $uid, $etitle);
    $result->execute();
    $result->close();
}
$db->close();
echo "<script>location.href='event.php'</script>";
exit();
?>