<?php
session_start();
if (!isset($_SESSION['uid'])) {
    header("Location: login.php");
}

$uid = $_SESSION['uid'];

$rid = $_POST['rid'];
$rtitle = $_POST['rtitle'];
$rserving = $_POST['rserving'];
$ingredients = $_POST['ingredients'];
$units = $_POST['unit'];
$amounts = $_POST['amount'];
$rdescription = $_POST['rdescription'];

include "../dbconf.inc";

$db = new mysqli($hostname, $usr, $pwd, $dbname);
if ($db->connect_error) {
    die('Unable to connect to database: ' . $db->connect_error);
}

//    $keyword = mysqli_real_escape_strings($db, $keyword);

if ($result = $db->prepare("update recipe set rtitle = ?, rserving = ?, rdescription = ? where rid = ?;")) {
    $result->bind_param("siss", $rtitle, $rserving, $rdescription, $rid);
    $result->execute();
    $result->close();
}

for ($i = 0; $i < count($ingredients); $i++) {
    if ($result = $db->prepare("select quantity_in_gram from unit_conversion where unit_name = ?;")) {
        $result->bind_param("s", $units[$i]);
        $result->execute();
        $result->bind_result($quantity_in_gram);
        $result->fetch();
        $result->close();

        $iquantity = $amounts[$i] * $quantity_in_gram;

        $iname = $ingredients[$i];

        if ($result = $db->prepare("insert into ingredient (rid, iname, iquantity) values (?, ?, ?);")) {
            $result->bind_param("ssd", $rid, $iname, $iquantity);
            $result->execute();
            $result->close();
        }
    }
}

if (isset($_POST['tag']) && is_array($_POST['tag'])) {
    $tags = $_POST['tag'];

    for ($i = 0; $i < count($tags); $i++) {

        if ($result = $db->prepare("insert into recipe_tag (rid, tid) values (?, ?);")) {
            $result->bind_param("si", $rid, $tags[$i]);
            $result->execute();
            $result->close();
        }
    }
}

if (isset($_FILES['photo']['tmp_name'])) {
    $files = $_FILES['photo']['tmp_name'];
    for ($i = 0; $i < count($files); $i++) {
        if ($result = $db->prepare("insert into recipe_picture (rid, content) values (?, ?);")) {
            $null = NULL;
            $result->bind_param("sb", $rid, $null);
            $result->send_long_data(1, file_get_contents($_FILES["photo"]["tmp_name"][$i]));
            $result->execute();
            $result->close();
        }
    }
}
$db->close();
echo "<script>location.href='editRicpe.php?rid=$rid'</script>";
exit();
?>