<?php
session_start();
if (!isset($_SESSION['uid'])) {
    header("Location: login.php");
}

$r_id = $_GET['r_id'];

include "../dbconf.inc";

$db = new mysqli($hostname, $usr, $pwd, $dbname);
if ($db->connect_error) {
    die('Unable to connect to database: ' . $db->connect_error);
}

if ($result = $db->prepare("select rid from review where r_id = ?;")) {
    $result->bind_param("s", $r_id);
    $result->execute();
    $result->bind_result($rid);
    $result->fetch();
    $result->close();
}

if ($result = $db->prepare("delete from review where r_id = ?;")) {
    $result->bind_param("s", $r_id);
    $result->execute();
    $result->close();
}
$db->close();
echo "<script>location.href='recipe.php?rid=$rid'</script>";
exit();
?>