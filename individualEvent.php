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
$eid = $_GET['eid'];
$uname_json = array();
$report_json = array();

if ($eid != "") {
    $db = new mysqli($hostname, $usr, $pwd, $dbname);
    if ($db->connect_error) {
        die('Unable to connect to database: ' . $db->connect_error);
    }

    if ($result = $db->prepare("select gname, etime, elocation, edescription, ecuid, etitle from event natural join ggroup where eid = ?;")) {
        $result->bind_param("i", $eid);
        $result->execute();
        $result->bind_result($gname, $etime, $elocation, $edescription, $ecuid, $etitle);
        $result->fetch();
        $result->close();
    }

    if ($result = $db->prepare("select uid, uname from event natural join reserve natural join user where eid = ?;")) {
        $result->bind_param("i", $eid);
        $result->execute();
        $result->bind_result($uuid, $uname);
        while ($result->fetch()) {
            $uname_json[$uuid]["uname"] = $uname;
        }
        $result->close();
    }

    if ($result = $db->prepare("select id, uid, uname, content from report natural join user where eid = ?;")) {
        $result->bind_param("i", $eid);
        $result->execute();
        $result->bind_result($rpid, $rpuid, $rpuname, $content);
        while ($result->fetch()) {
            $report_json[$rpid]["rpid"] = $rpid;
            $report_json[$rpid]["rpuid"] = $rpuid;
            $report_json[$rpid]["rpuname"] = $rpuname;
            $report_json[$rpid]["content"] = $content;
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
                                    <div class="panel-heading"><h3><?php echo $etitle; ?></h3></div>
                                    <div class="panel-body">
                                        <p>Group: <?php echo $gname; ?></p>
                                        <p>Location: <?php echo $elocation; ?></p>
                                        <p>Detail: <?php echo $edescription; ?></p>
                                        <p>Time: <?php echo $etime; ?></p>
                                        <?php
                                        if ($ecuid == $uid && count($uname_json) == 0) {
                                            ?>
                                            <a href="cancelEvent.php?eid=<?php echo $eid; ?>">
                                                <button type="submit" class="btn btn-primary">Cancel Event</button>
                                            </a>
                                            <?php
                                        };
                                        ?>
                                    </div>
                                </div>
                            </div>


                            <!--Participants-->
                            <div class="col-sm-12">
                                <div class="panel panel-default">
                                    <div class="panel-heading"><h3>Participants</h3></div>
                                    <div class="panel-body" ng-repeat="x in uname_records">
                                        <p>{{ x.uname }}</p>
                                    </div>
                                </div>
                            </div>


                            <!--Post Riview-->
                            <div class="col-sm-12">
                                <h3>Reports</h3>
                                <div class="panel panel-default" ng-repeat="x in report_records">
                                    <a href="report.php?id={{ x.rpid }}">
                                        <div class="panel-body">
                                            <p>{{ x.content }}</p>
                                        </div>
                                        <div class="panel-body">
                                            <p>Posted by: {{ x.rpuname }}</p>
                                        </div>

                                    </a>
                                </div>
                            </div>

                            <!--Post Riview-->
                            <div class="col-sm-12">
                                <div class="panel panel-default">
                                    <div class="panel-body">
                                        <h3>New Report</h3>
                                        <hr>
                                        <form role="form" method="post" name="recipe_form" action="sendReport.php"
                                              enctype="multipart/form-data">

                                            <input type="hidden" id="eid" name="eid" value="<?php echo $eid; ?>">

                                            <div class="form-group">
                                                <textarea class="form-control input-lg" autofocus="" id="rpcontent"
                                                          name="rpcontent"
                                                          placeholder="How was the event?" required></textarea>
                                            </div>

                                            <div class="form-group">
                                                <label for="photos">Photo(s)</label>
                                                <div class="input_photos_wrap" id="photos">
                                                    <div><input type="file" id="photo[]" name="photo[]"></div>
                                                </div>
                                                <button class="add_photo_button btn btn-primary">Add More Photos
                                                </button>
                                            </div>
                                            <button type="submit" class="btn btn-primary">Submit</button>
                                        </form>

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
        $scope.report_records = <?php echo json_encode(array_values($report_json)); ?>;
    });

    $(document).ready(function () {
        var photo_wrapper = $(".input_photos_wrap"); //Fields wrapper
        var add_photo_button = $(".add_photo_button"); //Add button ID

        $(add_photo_button).click(function (e) { //on add input button click
            e.preventDefault();
            $(photo_wrapper).append('<div><input type="file" id="photo[]" name="photo[]"><a href="#" class="remove_field">Remove</a></div>'); //add input box
        });

        $(photo_wrapper).on("click", ".remove_field", function (e) { //user click on remove text
            e.preventDefault();
            $(this).parent('div').remove();
        });
    });
</script>

</body>
</html>