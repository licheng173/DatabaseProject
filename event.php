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

$myevent_json = array();
$past_myevent_json = array();
$allevent_json = array();
$mygroup_json = array();
$past_allevent_json = array();

if ($uid != "") {
    $db = new mysqli($hostname, $usr, $pwd, $dbname);
    if ($db->connect_error) {
        die('Unable to connect to database: ' . $db->connect_error);
    }

    if ($result = $db->prepare("select eid, gid, gname, etime, elocation, edescription, ecuid, etitle from reserve natural join event natural join ggroup where uid = ? and etime > now();")) {
        $result->bind_param("i", $uid);
        $result->execute();
        $result->bind_result($eid, $gid, $gname, $etime, $elocation, $edescription, $ecuid, $etitle);

        while ($result->fetch()) {
            $myevent_json[$eid]["eid"] = $eid;
            $myevent_json[$eid]["gid"] = $gid;
            $myevent_json[$eid]["gname"] = $gname;
            $myevent_json[$eid]["etime"] = $etime;
            $myevent_json[$eid]["elocation"] = $elocation;
            $myevent_json[$eid]["edescription"] = $edescription;
            $myevent_json[$eid]["ecuid"] = $ecuid;
            $myevent_json[$eid]["etitle"] = $etitle;
        }
        $result->close();
    }

    if ($result = $db->prepare("select eid, gid, gname, etime, elocation, edescription, ecuid, etitle from reserve natural join event natural join ggroup where uid = ? and etime <= now();")) {
        $result->bind_param("i", $uid);
        $result->execute();
        $result->bind_result($eid, $gid, $gname, $etime, $elocation, $edescription, $ecuid, $etitle);

        while ($result->fetch()) {
            $past_myevent_json[$eid]["eid"] = $eid;
            $past_myevent_json[$eid]["gid"] = $gid;
            $past_myevent_json[$eid]["gname"] = $gname;
            $past_myevent_json[$eid]["etime"] = $etime;
            $past_myevent_json[$eid]["elocation"] = $elocation;
            $past_myevent_json[$eid]["edescription"] = $edescription;
            $past_myevent_json[$eid]["ecuid"] = $ecuid;
            $past_myevent_json[$eid]["etitle"] = $etitle;
        }
        $result->close();
    }

    if ($result = $db->prepare("select eid, gid, gname, etime, elocation, edescription, ecuid, etitle from event natural join ggroup natural join join_group where uid = ? and eid not in (select eid from reserve natural join event natural join ggroup where uid = ?) and etime > now();")) {
        $result->bind_param("ii", $uid, $uid);
        $result->execute();
        $result->bind_result($eid, $gid, $gname, $etime, $elocation, $edescription, $ecuid, $etitle);

        while ($result->fetch()) {
            $allevent_json[$eid]["eid"] = $eid;
            $allevent_json[$eid]["gid"] = $gid;
            $allevent_json[$eid]["gname"] = $gname;
            $allevent_json[$eid]["etime"] = $etime;
            $allevent_json[$eid]["elocation"] = $elocation;
            $allevent_json[$eid]["edescription"] = $edescription;
            $allevent_json[$eid]["ecuid"] = $ecuid;
            $allevent_json[$eid]["etitle"] = $etitle;
        }
        $result->close();
    }

    if ($result = $db->prepare("select eid, gid, gname, etime, elocation, edescription, ecuid, etitle from event natural join ggroup natural join join_group where uid = ? and eid not in (select eid from reserve natural join event natural join ggroup where uid = ?) and etime <= now();")) {
        $result->bind_param("ii", $uid, $uid);
        $result->execute();
        $result->bind_result($eid, $gid, $gname, $etime, $elocation, $edescription, $ecuid, $etitle);

        while ($result->fetch()) {
            $past_allevent_json[$eid]["eid"] = $eid;
            $past_allevent_json[$eid]["gid"] = $gid;
            $past_allevent_json[$eid]["gname"] = $gname;
            $past_allevent_json[$eid]["etime"] = $etime;
            $past_allevent_json[$eid]["elocation"] = $elocation;
            $past_allevent_json[$eid]["edescription"] = $edescription;
            $past_allevent_json[$eid]["ecuid"] = $ecuid;
            $past_allevent_json[$eid]["etitle"] = $etitle;
        }
        $result->close();
    }



    if ($result = $db->prepare("select gid, gname from join_group natural join ggroup where uid = ?;")) {
        $result->bind_param("i", $uid);
        $result->execute();
        $result->bind_result($gid, $gname);

        while ($result->fetch()) {
            $mygroup_json[$gid]["gid"] = $gid;
            $mygroup_json[$gid]["gname"] = $gname;
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
                                    <li class="active"><a data-toggle="pill" href="#myevent">My Events</a></li>
                                    <li><a data-toggle="pill" href="#discover">Discover</a></li>
                                    <li><a data-toggle="pill" href="#create">Create an event</a></li>
                                </ul>

                                <div class="tab-content col-xs-12 col-sm-12 col-md-12">
                                    <div id="myevent" class="tab-pane fade in active">
                                        <br/>
                                        <h2>Upcoming Event</h2>
                                        <div class="panel panel-default" ng-repeat="x in myevent_records">
                                            <div class="panel-heading"><a href="individualEvent.php?eid={{ x.eid }}"><h4>{{ x.etitle }}</h4></a></div>
                                            <div class="panel-body">
                                                <p>Group: {{ x.gname }}</p>
                                                <p>Location: {{ x.elocation }}</p>
                                                <p>Detail: {{ x.edescription }}</p>
                                                <p>Time: {{ x.etime }}</p>
                                                <a href="cancelReservation.php?eid={{ x.eid }}"><button type="submit" class="btn btn-primary">Cancel Reservation</button></a>
                                            </div>
                                        </div>
                                        <br/>
                                        <h2>Past Event</h2>
                                        <div class="panel panel-default" ng-repeat="x in past_myevent_records">
                                            <div class="panel-heading"><a href="individualEvent.php?eid={{ x.eid }}"><h4>{{ x.etitle }}</h4></a></div>
                                            <div class="panel-body">
                                                <p>Group: {{ x.gname }}</p>
                                                <p>Location: {{ x.elocation }}</p>
                                                <p>Detail: {{ x.edescription }}</p>
                                                <p>Time: {{ x.etime }}</p>
                                            </div>
                                        </div>
                                    </div>
                                    <div id="discover" class="tab-pane fade">
                                        <br/>
                                        <h2>Upcoming Event</h2>
                                        <div class="panel panel-default" ng-repeat="x in allevent_records">
                                            <div class="panel-heading"><a href="individualEvent.php?eid={{ x.eid }}"><h4>{{ x.etitle }}</h4></a></div>
                                            <div class="panel-body">
                                                <p>Group: {{ x.gname }}</p>
                                                <p>Location: {{ x.elocation }}</p>
                                                <p>Detail: {{ x.edescription }}</p>
                                                <p>Time: {{ x.etime }}</p>
                                                <a href="reserveEvent.php?eid={{ x.eid }}"><button type="submit" class="btn btn-primary">Reserve</button></a>
                                            </div>
                                        </div>
                                        <br/>
                                        <h2>Past Event</h2>
                                        <div class="panel panel-default" ng-repeat="x in past_allevent_records">
                                            <div class="panel-heading"><a href="individualEvent.php?eid={{ x.eid }}"><h4>{{ x.etitle }}</h4></a></div>
                                            <div class="panel-body">
                                                <p>Group: {{ x.gname }}</p>
                                                <p>Location: {{ x.elocation }}</p>
                                                <p>Detail: {{ x.edescription }}</p>
                                                <p>Time: {{ x.etime }}</p>
                                            </div>
                                        </div>

                                    </div>
                                    <div id="create" class="tab-pane fade">
                                        <br/>
                                        <div class="panel panel-default">
                                            <div class="panel-body">
                                                <form method="post" name="event_form" action="createEvent.php"
                                                      enctype="multipart/form-data">
                                                    <div class="form-group">
                                                        <label for="gid">Group</label>
                                                        <select id="gid" name="gid" required>
                                                            <option ng-repeat="x in mygroup_records"
                                                                    value="{{ x.gid }}">{{ x.gname }}
                                                            </option>
                                                        </select>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="etitle">Title</label>
                                                        <input type="text" class="form-control" id="etitle"
                                                               name="etitle" required="">
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="elocation">Location</label>
                                                        <input type="text" class="form-control" id="elocation"
                                                               name="elocation" required="">
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="edescription">Description</label>
                                                        <textarea class="form-control input-lg" id="edescription"
                                                                  name="edescription"></textarea>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="etime">Time</label>
                                                        <input type="datetime-local" id="etime" name="etime" required>
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
        $scope.allevent_records = <?php echo json_encode(array_values($allevent_json)); ?>;
        $scope.past_allevent_records = <?php echo json_encode(array_values($past_allevent_json)); ?>;
        $scope.myevent_records = <?php echo json_encode(array_values($myevent_json)); ?>;
        $scope.past_myevent_records = <?php echo json_encode(array_values($past_myevent_json)); ?>;
    });
</script>

</body>
</html>