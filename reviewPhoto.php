<?php
include "../dbconf.inc";

//open the database connection
$db = new mysqli($hostname, $usr, $pwd, $dbname);
if ($db->connect_error) {
    die('Unable to connect to database: ' . $db->connect_error);
}

if (isset($_GET['rpid'])) {
    $rpid = mysqli_real_escape_string($db, $_GET['rpid']);
}

header("Content-type: image/jpeg");

if (!empty($rpid) && $result = $db->prepare("select photo from review_photo where p_id = ?;")) {
    $result->bind_param("i", $rpid);
    $result->execute();
    $result->store_result();
    $result->bind_result($resultimage);
    $result->fetch();
    echo $resultimage;
    $result->close();
}
$db->close();
?>
