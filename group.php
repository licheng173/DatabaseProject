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

$mygroup_json = array();
$allgroup_json = array();

if ($uid != "") {
    $db = new mysqli($hostname, $usr, $pwd, $dbname);
    if ($db->connect_error) {
        die('Unable to connect to database: ' . $db->connect_error);
    }

    if ($result = $db->prepare("select gid, gname, gdescription from join_group natural join ggroup where uid = ?;")) {
        $result->bind_param("i", $uid);
        $result->execute();
        $result->bind_result($gid, $gname, $gdescription);

        while ($result->fetch()) {
            $mygroup_json[$gid]["gid"] = $gid;
            $mygroup_json[$gid]["gname"] = $gname;
            $mygroup_json[$gid]["gdescription"] = $gdescription;
        }
        $result->close();
    }

    if ($result = $db->prepare("select gid, gname, gdescription from ggroup where gid not in (select gid from join_group natural join ggroup where uid = ?);")) {
        $result->bind_param("i", $uid);
        $result->execute();
        $result->bind_result($gid, $gname, $gdescription);

        while ($result->fetch()) {
            $allgroup_json[$gid]["gid"] = $gid;
            $allgroup_json[$gid]["gname"] = $gname;
            $allgroup_json[$gid]["gdescription"] = $gdescription;
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

                                <ul class="nav nav-tabs col-xs-12 col-sm-12 col-md-10">
                                    <li class="active"><a data-toggle="pill" href="#mygroup">My Groups</a></li>
                                    <li><a data-toggle="pill" href="#discover">Discover</a></li>
                                    <li><a data-toggle="pill" href="#create">Create a group</a></li>
                                </ul>

                                <div class="tab-content col-xs-12 col-sm-12 col-md-12">
                                    <div id="mygroup" class="tab-pane fade in active">
                                        <br/>
                                        <div class="panel panel-default" ng-repeat="x in mygroup_records">
                                            <div class="panel-heading">
                                                <a href="individualGroup.php?gid={{ x.gid }}">
                                                    <h4>{{ x.gname }}</h4>
                                                </a>
                                            </div>
                                            <div class="panel-body">
                                                <p>{{ x.gdescription }}</p>
                                                <a href="exitGroup.php?gid={{ x.gid }}">
                                                    <button type="submit" class="btn btn-primary">Leave Group</button>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                    <div id="discover" class="tab-pane fade">
                                        <br/>
                                        <div class="panel panel-default" ng-repeat="x in allgroup_records">
                                            <div class="panel-heading">
                                                <a href="individualGroup.php?gid={{ x.gid }}">
                                                    <h4>{{ x.gname }}</h4>
                                                </a>
                                            </div>
                                            <div class="panel-body">
                                                <p>{{ x.gdescription }}</p>
                                                <a href="joinGroup.php?gid={{ x.gid }}">
                                                    <button type="submit" class="btn btn-primary">Join Group</button>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                    <div id="create" class="tab-pane fade">
                                        <br/>
                                        <div class="panel panel-default">
                                            <div class="panel-body">
                                                <form method="post" name="group_form" action="createGroup.php"
                                                      enctype="multipart/form-data">
                                                    <div class="form-group">
                                                        <label for="gname">Group name</label>
                                                        <input type="text" class="form-control" id="gname" name="gname">
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="gdescription">Description</label>
                                                        <textarea class="form-control input-lg" autofocus=""
                                                                  id="gdescription" name="gdescription"></textarea>
                                                    </div>
                                                    <button type="submit" class="btn btn-primary">Create</button>
                                                </form>
                                            </div>
                                        </div>
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
        $scope.mygroup_records = <?php echo json_encode(array_values($mygroup_json)); ?>;
        $scope.allgroup_records = <?php echo json_encode(array_values($allgroup_json)); ?>;
    });
</script>

</body>
</html>