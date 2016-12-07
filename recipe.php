<?php
session_start();
if (!isset($_SESSION['uid'])) {
    header("Location: login.php");
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta charset="utf-8">
    <title>CookZilla</title>
    <meta name="generator" content="Bootply"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
          integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

    <!-- Optional theme -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css"
          integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">

    <link href="css/styles.css" rel="stylesheet">
    <script type="text/javascript" src="js/angular.min.js"></script>
</head>
<body ng-app="myApp" ng-controller="myCtrl">

<?php

include "../dbconf.inc";

$rid = -1;

if (isset($_GET['rid'])) {
    $rid = $_GET['rid'];
}

$uid = $_SESSION['uid'];

$ingredient_json = array();
$json = array();

if ($rid != -1) {
    $db = new mysqli($hostname, $usr, $pwd, $dbname);
    if ($db->connect_error) {
        die('Unable to connect to database: ' . $db->connect_error);
    }

//    $keyword = mysqli_real_escape_strings($db, $keyword);

    if ($result = $db->prepare("select rtitle, rserving, rdescription from recipe where rid = ?;")) {
        $result->bind_param("s", $rid);
        $result->execute();
        $result->bind_result($rtitle, $rserving, $rdescription);
        $result->fetch();
        $result->close();
    }

    if ($result = $db->prepare("select iname, iquantity from ingredient where rid = ?;")) {
        $result->bind_param("s", $rid);
        $result->execute();
        $result->bind_result($iname, $iquantity);
        while ($result->fetch()) {
            $ingredient_json[$iname]["iname"] = $iname;
            $ingredient_json[$iname]["iquantity"] = $iquantity;
        }
        $result->close();
    }

    if ($result = $db->prepare("select pid from recipe_picture where rid = ?;")) {
        $result->bind_param("s", $rid);
        $result->execute();
        $result->bind_result($pid);
        while ($result->fetch()) {
            $json[$pid]["pid"] = $pid;
        }
        $result->close();
    }
    $db->close();
}
?>

<div class="wrapper">
    <div class="box">
        <div class="row row-offcanvas row-offcanvas-left">

            <!-- sidebar -->
            <?php
            include "sidebar.php";
            ?>
            <!-- /sidebar -->

            <!-- main right col -->
            <div class="column col-sm-10 col-xs-11" id="main">

                <!-- top nav -->
                <?php
                include "topnav.php";
                ?>

                <div class="padding">
                    <div class="full col-sm-9">
                        <div class="panel panel-default">
                            <p><?php echo $rtitle ?></p>
                        </div>

                        <div class="panel panel-default">
                            <p>Serving: <?php echo $rserving ?></p>
                        </div>

                        <div class="panel panel-default">
                            <p><?php echo $rdescription ?></p>
                        </div>

                        <div class="panel panel-default" ng-repeat="x in ingredient_records">
                            <p>{{ x.iname }} {{ x.iquantity }} g</p>
                        </div>

                        <!-- images -->
                        <div class="row">
                            <!-- main col right -->
                            <div class="col-sm-4" ng-repeat="x in records">
                                <div class="panel panel-default">
                                    <div class="panel-body">
                                        <img src="image.php?pid={{ x.pid }}" style="width: 100%;">
                                    </div>
                                </div>
                            </div>
                        </div><!--/row-->

                        




                    </div><!-- /col-9 -->
                </div><!-- /padding -->
            </div>
            <!-- /main -->

        </div>
    </div>
</div>


<!-- script references -->
<script src="js/jquery-3.1.1.min.js"></script>
<!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"
        integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
        crossorigin="anonymous"></script>

<script src="js/scripts.js"></script>
<script type="text/javascript" language="javascript" class="init">
    var app = angular.module("myApp", []);
    app.controller("myCtrl", function ($scope) {
        $scope.records = <?php echo json_encode(array_values($json)); ?>;
        $scope.ingredient_records = <?php echo json_encode(array_values($ingredient_json)); ?>
    });
</script>
</body>
</html>

