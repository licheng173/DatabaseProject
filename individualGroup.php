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
<body>
<?php
include "../dbconf.inc";

$uid = $_SESSION['uid'];
$gid = $_GET['gid'];
$uname_json = array();

if ($gid != "") {
    $db = new mysqli($hostname, $usr, $pwd, $dbname);
    if ($db->connect_error) {
        die('Unable to connect to database: ' . $db->connect_error);
    }

    if ($result = $db->prepare("select gname, gdescription from ggroup where gid = ?;")) {
        $result->bind_param("s", $gid);
        $result->execute();
        $result->bind_result($gname, $gdescription);
        $result->fetch();
        $result->close();
    }

    if ($result = $db->prepare("select uid, uname from ggroup natural join join_group natural join user where gid = ?;")) {
        $result->bind_param("s", $gid);
        $result->execute();
        $result->bind_result($uuid, $uname);
        while ($result->fetch()) {
            $uname_json[$uuid]["uname"] = $uname;
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
                    <div class="full col-sm-9" ng-app="myApp" ng-controller="myCtrl">
                        <!-- content -->
                        <div class="row">
                            <!-- main col right -->
                            <div class="col-sm-12">
                                <div class="panel panel-default">
                                    <div class="panel-heading"><h4><?php echo $gname; ?></h4></div>
                                    <div class="panel-body"><?php echo $gdescription; ?></div>
                                </div>
                            </div>

                            <!--Participants-->
                            <div class="col-sm-12">
                                <div class="panel panel-default">
                                    <div class="panel-heading"><h3>Members</h3></div>
                                    <div class="panel-body" ng-repeat="x in uname_records">
                                        <button type="button" class="btn btn-primary">{{ x.uname }}</button>
                                    </div>
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
        $scope.uname_records = <?php echo json_encode(array_values($uname_json)); ?>;
    });
</script>
</body>
</html>