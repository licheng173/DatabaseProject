<?php
session_start();
if (!isset($_SESSION['uid'])) {
    header("Location: login.php");
}
?>

<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/html">
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

$recipe_json = array();

if ($rid != -1) {
    $db = new mysqli($hostname, $usr, $pwd, $dbname);
    if ($db->connect_error) {
        die('Unable to connect to database: ' . $db->connect_error);
    }

//    $keyword = mysqli_real_escape_strings($db, $keyword);

    if ($result = $db->prepare("select rid, rtitle from recipe where uid = ?;")) {
        $result->bind_param("i", $uid);
        $result->execute();
        $result->bind_result($myrid, $rtitle);
        while ($result->fetch()) {
            $recipe_json[$myrid]["rid"] = $myrid;
            $recipe_json[$myrid]["rtitle"] = $rtitle;
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
                            <div class="panel-body">
                                <form role="form" method="post" name="link_form" action="sendLink.php" enctype="multipart/form-data">
                                    <input type="hidden" id="rid" name="rid" value="<?php echo $rid; ?>">
                                    <div class="form-group">
                                        <label for="myrid">Select my recipe:</label>
                                        <select id="myrid" name="myrid">
                                            <option ng-repeat="x in recipe_records" value="{{ x.rid }}">{{ x.rtitle }}
                                            </option>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <button type="submit" class="btn btn-primary">Submit</button>
                                    </div>
                                </form>
                            </div>
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
            $scope.recipe_records = <?php echo json_encode(array_values($recipe_json)); ?>;

        });
    </script>
</body>
</html>


