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
    <style type="text/css">
        .serving_p {
            font-weight: bold;
        }

        .recipe-img {
            margin-left: 4px;
        }

        .serving-bar {
            border-bottom: inset;
            1px gray;

        }

        .description {
            margin-top: 10px;
            font-style: solid;

        }

        .seperate {
            border-bottom-style: solid;
        }

        h3 {
            margin-top: 40px;
            font-family: serif;
            font-weight: 200;
        }
        .tuple{
            padding-top: 5px;
            padding-bottom: 5px;

        }
        li{
            list-style: none;
        }
    </style>
</head>
<body ng-app="myApp" ng-controller="myCtrl">

<?php

include "../dbconf.inc";

$rid = -1;

if (isset($_GET['rid'])) {
    $rid = $_GET['rid'];
}


$uid = $_SESSION['uid'];
$alltag_json = array();
$ingredient_json = array();
$tag_json = array();
$json = array();
$links_json = array();
$unit_json = array();

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

    if ($result = $db->prepare("select unit_name from unit_conversion;")) {
        $result->execute();
        $result->bind_result($unit_name);

        while ($result->fetch()) {
            $unit_json[$unit_name]["unit_name"] = $unit_name;
        }
        $result->close();
    }

    if ($result = $db->prepare("select tid, ttitle from tag;")) {
        $result->execute();
        $result->bind_result($tid, $ttitle);

        while ($result->fetch()) {
            $alltag_json[$tid]["tid"] = $tid;
            $alltag_json[$tid]["ttitle"] = $ttitle;
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
                            <div class="panel-heading">
                                <h4>Click To Delete</h4>
                            </div>
                            <div class="panel-body">
                        <a ng-repeat="x in tag_records" href="deleteTag.php?rid=<?php echo $rid; ?>&tag={{ x.tid }}">
                            <button type="button" class="btn btn-success">{{ x.ttitle }}</button>
                        </a>
                        </br></br>
                    </div>
                </div>

                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h4>Ingredients</h4>
                            </div>
                            <div class="panel-body">
                                <li ng-repeat="x in ingredient_records">
                                <div class="tuple">
                                    <a href="deleteIngredient.php?rid=<?php echo $rid; ?>&iname={{ x.iname }}">
                                    <button type="button" class="btn btn-success btn-success-edit">Delete</button>
                                    </a>{{ x.iname }} : {{ x.iquantity }} g
                                </div>
                                
                                </li>

                            </div>
                        </div>

                        <!-- images -->
                        <div class="panel panel-default">
                            <!-- <div class="panel-heading"> -->
                            <div class="panel-body">
                                <!-- <div class="row"> -->
                                <!-- main col right -->
                                <div class="col-sm-4" ng-repeat="x in records">
                                    <div class="panel panel-default">
                                        <div class="panel-body">
                                            <img src="image.php?pid={{ x.pid }}" style="width: 100%;"><a
                                                href="deleteRecipePicture.php?rid=<?php echo $rid; ?>&pid={{ x.pid }}">
                                                </br></br>
                                                <button type="button" class="btn btn-success">Delete</button>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div><!--/row-->
                            <!-- </div> -->
                            <!-- </div> -->
                        </div>
                        <div class="panel panel-default">
                            <!-- <div class="panel-heading"> -->
                            <div class="panel-heading">
                                <div class="row">
                                    <h4>Links</h4>
                                    <!-- main col right -->
                                    <div class="col-sm-4" ng-repeat="x in link_records">
                                        <a href="recipe.php?rid={{ x.link_rid }}">
                                            <div class="panel panel-default">
                                                <div class="panel-body">
                                                    <h4>{{ x.link_rtitle }}</h4>
                                                    <a href="deleteLink.php?rid=<?php echo $rid; ?>&link_rid={{ x.link_rid }}">
                                                        <button type="button" class="btn btn-success">Delete</button>
                                                    </a>
                                                </div>
                                            </div>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>

<div class="panel panel-default">
                        <!-- content -->
                        <div class="row">
                            <!-- main col right -->
                            <div class="col-sm-12">
                                <br/>
                                <div class="panel panel-default">
                                    <div class="panel-body">
                                        <form role="form" method="post" name="recipe_form" action="updateRecipe.php"
                                              enctype="multipart/form-data">
                                            <input name="rid" type="hidden" value="<?php echo $rid;?>">
                                            <div class="form-group">
                                                <label class="tag-div" for="tag">Tag(s)</label></br>
                                                <span class="input_tags_wrap" id="tag" name="tag"
                                                      ng-repeat="x in alltag_records">
                                                    <!-- <span class="checkbox"> -->
                                                        <label><input type="checkbox" value="{{ x.tid   }}"
                                                                      name="tag[] "> {{  x.ttitle }}</label>&nbsp;&nbsp;&nbsp;
                                                    <!-- </span> -->
                                                </span>
                                            </div>

                                            <div class="form-group">
                                                <label for="rtitle">Title</label>
                                                <input type="text" class="form-control" id="rtitle" name="rtitle" value="<?php echo $rtitle ?>"
                                                       required>
                                            </div>

                                            <div class="form-group">
                                                <label for="rserving">Serving</label>
                                                <input type="number" id="rserving" name="rserving" value="<?php echo $rserving ?>"
                                                       required>
                                            </div>

                                            <div class="form-group">
                                                <label for="ingredient">Ingredient(s)</label>
                                                <div class="input_fields_wrap" id="ingredient" name="ingredient">
                                                </div>
                                                <button class="add_field_button btn btn-primary">Add More Ingredients
                                                </button>
                                            </div>

                                            <div class="form-group">
                                                <label for="rdescription">Description</label>
                                                <textarea class="form-control input-lg" id="rdescription"
                                                          name="rdescription"><?php echo $rdescription ?></textarea>
                                            </div>

                                            <div class="form-group">
                                                <label for="photos">Photo(s)</label>
                                                <div class="input_photos_wrap" id="photos">
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

                        </br></br>

                    </div><!-- /padding -->
                </div>
                <!-- /main -->
            </div>
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
            $scope.link_records = <?php echo json_encode(array_values($links_json)); ?>;
            $scope.unit_records = <?php echo json_encode(array_values($unit_json)); ?>;
            $scope.alltag_records = <?php echo json_encode(array_values($alltag_json)); ?>;
        });


        $(document).ready(function () {
            var wrapper = $(".input_fields_wrap"); //Fields wrapper
            var add_button = $(".add_field_button"); //Add button ID
            var unit_records = <?php echo json_encode(array_values($unit_json)); ?>;

            var s = '<div><input type="text" name="ingredients[]" required>\n<label for="unit">Unit</label>\n<select id="unit[]" name="unit[]">';
            for (var i = 0; i < unit_records.length; i++) {
                s += '<option value="'+ unit_records[i].unit_name + '">' + unit_records[i].unit_name + '</option>';
            }
            s += '</select>\n<label for="amount[]">Amount</label>\n<input type="number" class="form-inline" id="amount[]" name="amount[]" required><a href="#" class="remove_field">Remove</a></div>';

            $(add_button).click(function (e) { //on add input button click
                e.preventDefault();
                $(wrapper).append(s); //add input box
            });

            $(wrapper).on("click", ".remove_field", function (e) { //user click on remove text
                e.preventDefault();
                $(this).parent('div').remove();
            });

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


