<?php
include "../dbconf.inc";

//open the database connection
$db = new mysqli($hostname, $usr, $pwd, $dbname);
if ($db->connect_error) {
    die('Unable to connect to database: ' . $db->connect_error);
}

if (isset($_GET['pid'])) {
    $pid = mysqli_real_escape_string($db, $_GET['pid']);
}

header("Content-type: image/jpeg");

if (!empty($pid) && $result = $db->prepare("select content from recipe_picture where pid = ?;")) {
    $result->bind_param("s", $pid);
    $result->execute();
    $result->store_result();
    $result->bind_result($resultimage);
    $result->fetch();
    echo $resultimage;
    $result->close();
}
$db->close();
?>
