<?php
session_start();
if (!isset($_SESSION['uid'])) {
    header("Location: login.php");
}

$uid = $_SESSION['uid'];
$rid = $_POST['rid'];
$rvtitle = htmlspecialchars($_POST['rvtitle']);
$rtext = htmlspecialchars($_POST['rtext']);
$rrate = $_POST['rrate'];

include "../dbconf.inc";

$db = new mysqli($hostname, $usr, $pwd, $dbname);
if ($db->connect_error) {
    die('Unable to connect to database: ' . $db->connect_error);
}

$r_id = uniqid();

if ($result = $db->prepare("insert into review (r_id, rid, uid, rrate, rtext, rvtitle) values (?, ?, ?, ?, ?, ?);")) {
    $result->bind_param("ssiiss", $r_id, $rid, $uid, $rrate, $rtext, $rvtitle);
    $result->execute();
    $result->close();
}

if (isset($_POST['suggestion']) && is_array($_POST['suggestion'])) {
    $suggestions = $_POST['suggestion'];

    for ($i = 0; $i < count($suggestions); $i++) {
        if ($result = $db->prepare("insert into review_suggestion (r_id, content) values (?, ?);")) {
            $result->bind_param("ss", $r_id, $suggestions[$i]);
            $result->execute();
            $result->close();
        }
    }
}

if (isset($_FILES['photo']['tmp_name'])) {
    $files = $_FILES['photo']['tmp_name'];
    for ($i = 0; $i < count($files); $i++) {
        if ($result = $db->prepare("insert into review_photo (r_id, photo) values (?, ?);")) {
            $null = NULL;
            $result->bind_param("sb", $r_id, $null);
            $result->send_long_data(1, file_get_contents($_FILES["photo"]["tmp_name"][$i]));
            $result->execute();
            $result->close();
        }
    }
}
$db->close();
echo "<script>location.href='recipe.php?rid=$rid'</script>";
exit();
?>