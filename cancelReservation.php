<?php
session_start();
if (!isset($_SESSION['uid'])) {
    header("Location: login.php");
}

$uid = $_SESSION['uid'];
$eid = $_GET['eid'];

include "../dbconf.inc";

$db = new mysqli($hostname, $usr, $pwd, $dbname);
if ($db->connect_error) {
    die('Unable to connect to database: ' . $db->connect_error);
}

if ($result = $db->prepare("delete from reserve where eid = ? and uid = ?;")) {
    $result->bind_param("ii", $eid, $uid);
    $result->execute();
    $result->close();
}
$db->close();
echo "<script>location.href='event.php'</script>";
exit();
?>