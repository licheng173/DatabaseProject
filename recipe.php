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

$ingredient_json = array();
$tag_json = array();
$json = array();
$review_json = array();
$links_json = array();

if ($rid != -1) {
    $db = new mysqli($hostname, $usr, $pwd, $dbname);
    if ($db->connect_error) {
        die('Unable to connect to database: ' . $db->connect_error);
    }

    if ($result = $db->prepare("insert into recipe_view (uid, rid, vtime) values (?, ?, now());")) {
        $result->bind_param("is", $uid, $rid);
        $result->execute();
        $result->close();
    }

    if ($result = $db->prepare("select rtitle, rserving, rdescription, uid from recipe where rid = ?;")) {
        $result->bind_param("s", $rid);
        $result->execute();
        $result->bind_result($rtitle, $rserving, $rdescription, $recipe_uid);
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

    if ($result = $db->prepare("select tid, ttitle from tag natural join recipe_tag where rid = ?;")) {
        $result->bind_param("s", $rid);
        $result->execute();
        $result->bind_result($tid, $ttitle);
        while ($result->fetch()) {
            $tag_json[$tid]["tid"] = $tid;
            $tag_json[$tid]["ttitle"] = $ttitle;
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

    if ($result = $db->prepare("select r_id, uid, uname, rrate, rtext, rvtitle from review natural join user where rid = ?;")) {
        $result->bind_param("s", $rid);
        $result->execute();
        $result->bind_result($r_id, $r_uid, $r_uname, $rrate, $rtext, $rvtitle);
        while ($result->fetch()) {
            $review_json[$r_id]["r_id"] = $r_id;
            $review_json[$r_id]["r_uid"] = $r_uid;
            $review_json[$r_id]["r_uname"] = $r_uname;
            $review_json[$r_id]["rrate"] = $rrate;
            $review_json[$r_id]["rtext"] = $rtext;
            $review_json[$r_id]["rvtitle"] = $rvtitle;
        }

        $result->close();
    }

    if ($result = $db->prepare("select r.rid, r.rtitle from link_recipe l join recipe r where l.rid = ? and l.rid_link = r.rid;")) {
        $result->bind_param("s", $rid);
        $result->execute();
        $result->bind_result($link_rid, $link_rtitle);
        while ($result->fetch()) {
            $links_json[$link_rid]["link_rid"] = $link_rid;
            $links_json[$link_rid]["link_rtitle"] = $link_rtitle;
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

                        <a ng-repeat="x in tag_records" href="search.php?tag={{ x.tid }}">
                            <button type="button" class="btn btn-success">{{ x.ttitle }}</button>
                        </a>
                        </br></br>

                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3><?php echo $rtitle ?></h3>
                            </div>
                            <div class="panel-body">
                                <p>Serving: <?php echo $rserving ?></p>
                                <p><?php echo $rdescription ?></p>
                            </div>
                        </div>

                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3>Ingredients</h3>
                            </div>
                            <div class="panel-body">
                                <p ng-repeat="x in ingredient_records">{{ x.iname }} {{ x.iquantity }} g</p>
                            </div>
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

                        <div class="row">
                            <h3>Links</h3>
                            <!-- main col right -->
                            <div class="col-sm-4" ng-repeat="x in link_records">
                                <a href="recipe.php?rid={{ x.link_rid }}">
                                    <div class="panel panel-default">
                                        <div class="panel-body">
                                            <h4>{{ x.link_rtitle }}</h4>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </div><!--/row-->

                        </br></br></br>
                        <?php
                        if ($recipe_uid == $uid) {
                            ?>
                            <a href="deleteRicpe.php?rid=<?php echo $rid; ?>">
                                <button type="submit" class="btn btn-primary">Delete recipe</button>
                            </a>
                            <?php
                        };
                        ?>
                        <!--add link-->
                        <a href="addLink.php?rid=<?php echo $rid; ?>">
                            <button type="submit" class="btn btn-info">Link to my recipe</button>
                        </a>
                    </div>


                    <div class="full col-sm-9">

                        <h2>Reviews</h2>

                        <div class="panel panel-default" ng-repeat="x in review_records">
                            <a href="review.php?r_id={{ x.r_id }}">
                                <div class="panel-heading">
                                    <h4>{{ x.rvtitle }}</h4>
                                </div>
                                <div class="panel-body">
                                    <p>{{ x.rtext }}</p>
                                    <img src="images/star{{ x.rrate }}.svg" style="height: 20px;">
                                    </br></br>
                                    <p>posted by: {{ x.r_uname }}</p>
                                </div>
                            </a>
                        </div>


                        <!--new review-->
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <h3>New Review</h3>
                                <hr>
                                <form role="form" method="post" name="review_form" action="sendReview.php"
                                      enctype="multipart/form-data">

                                    <input type="hidden" id="rid" name="rid" value="<?php echo $rid; ?>">
                                    <div class="form-group">
                                        <label for="rvtitle">Title</label>
                                        <input type="text" class="form-control" id="rvtitle" name="rvtitle"
                                               required>
                                    </div>

                                    <div class="form-group">
                                        <label for="rtext">Review Detail</label>
                                        <textarea class="form-control input-lg" id="rtext" name="rtext"
                                                  placeholder="What's your opinion?"></textarea>
                                    </div>

                                    <div class="form-group">
                                        <label for="rrate">Rating</label>
                                        <select id="rrate" name="rrate">
                                            <option>1</option>
                                            <option>2</option>
                                            <option>3</option>
                                            <option>4</option>
                                            <option>5</option>
                                        </select>
                                    </div>

                                    <div class="form-group">
                                        <label for="photos">Photo(s)</label>
                                        <div class="input_photos_wrap" id="photos">
                                            <div><input type="file" id="photo[]" name="photo[]"></div>
                                        </div>
                                        </br>
                                        <button class="add_photo_button btn btn-primary">Add More Photos
                                        </button>
                                    </div>

                                    <div class="form-group">
                                        <label for="suggestions">Suggestion(s)</label>
                                        <div class="input_suggestions_wrap" id="suggestions">
                                        </div>
                                        </br>
                                        <button class="add_suggestion_button btn btn-primary">Add More Suggestions
                                        </button>
                                    </div>
                                    <button type="submit" class="btn btn-primary">Submit</button>
                                    </br></br>
                                </form>
                            </div>
                        </div>
                        </br></br>
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
        $scope.ingredient_records = <?php echo json_encode(array_values($ingredient_json)); ?>;
        $scope.tag_records = <?php echo json_encode(array_values($tag_json)); ?>;
        $scope.review_records = <?php echo json_encode(array_values($review_json)); ?>;
        $scope.link_records = <?php echo json_encode(array_values($links_json)); ?>;
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

        var suggestion_wrapper = $(".input_suggestions_wrap"); //Fields wrapper
        var add_suggestion_button = $(".add_suggestion_button"); //Add button ID

        $(add_suggestion_button).click(function (e) { //on add input button click
            e.preventDefault();
            $(suggestion_wrapper).append('<div><textarea class="form-control input-lg" id="suggestion[]" name="suggestion[]"></textarea><a href="#" class="remove_field">Remove</a></div>'); //add input box
        });

        $(suggestion_wrapper).on("click", ".remove_field", function (e) { //user click on remove text
            e.preventDefault();
            $(this).parent('div').remove();
        });
    });
</script>
</body>
</html>


