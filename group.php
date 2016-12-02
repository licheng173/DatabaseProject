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
</head>
<body>
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
                        <!-- content -->
                        <div class="row">
                            <!-- main col right -->
                            <div class="col-sm-12">

                                <ul class="nav nav-tabs col-xs-12 col-sm-12 col-md-10">
                                    <li class="active"><a data-toggle="pill" href="#mygroup">My Group</a></li>
                                    <li><a data-toggle="pill" href="#discover">Discover</a></li>
                                    <li><a data-toggle="pill" href="#create">Create a group</a></li>
                                </ul>

                                <div class="tab-content col-xs-12 col-sm-12 col-md-12">
                                    <div id="mygroup" class="tab-pane fade in active">
                                        <br/>
                                        <div class="panel panel-default">
                                            <div class="panel-heading"><a href="#" class="pull-right">View all</a> <h4>
                                                    Bootply Editor &amp; Code Library</h4></div>
                                            <div class="panel-body">
                                                <p><img src="//placehold.it/150x150" class="img-circle pull-right"> <a
                                                        href="#">The Bootstrap Playground</a></p>
                                                <div class="clearfix"></div>
                                                <hr>
                                                Design, build, test, and prototype using Bootstrap in real-time from
                                                your Web browser. Bootply combines the power of hand-coded HTML, CSS and
                                                JavaScript with the benefits of responsive design using Bootstrap. Find
                                                and showcase Bootstrap-ready snippets in the 100% free Bootply.com code
                                                repository.
                                            </div>
                                        </div>
                                        <div class="panel panel-default">
                                            <div class="panel-heading"><a href="#" class="pull-right">View all</a> <h4>
                                                    Bootply Editor &amp; Code Library</h4></div>
                                            <div class="panel-body">
                                                <p><img src="//placehold.it/150x150" class="img-circle pull-right"> <a
                                                        href="#">The Bootstrap Playground</a></p>
                                                <div class="clearfix"></div>
                                                <hr>
                                                Design, build, test, and prototype using Bootstrap in real-time from
                                                your Web browser. Bootply combines the power of hand-coded HTML, CSS and
                                                JavaScript with the benefits of responsive design using Bootstrap. Find
                                                and showcase Bootstrap-ready snippets in the 100% free Bootply.com code
                                                repository.
                                            </div>
                                        </div>
                                    </div>
                                    <div id="discover" class="tab-pane fade">
                                        <br/>
                                        <div class="panel panel-default">
                                            <div class="panel-heading"><a href="#" class="pull-right">View all</a> <h4>
                                                    Bootply Editor &amp; Code Library</h4></div>
                                            <div class="panel-body">
                                                <p><img src="//placehold.it/150x150" class="img-circle pull-right"> <a
                                                        href="#">The Bootstrap Playground</a></p>
                                                <div class="clearfix"></div>
                                                <hr>
                                                Design, build, test, and prototype using Bootstrap in real-time from
                                                your Web browser. Bootply combines the power of hand-coded HTML, CSS and
                                                JavaScript with the benefits of responsive design using Bootstrap. Find
                                                and showcase Bootstrap-ready snippets in the 100% free Bootply.com code
                                                repository.
                                            </div>
                                        </div>
                                    </div>
                                    <div id="create" class="tab-pane fade">
                                        <br/>
                                        <div class="panel panel-default">
                                            <div class="panel-body">
                                                <form>
                                                    <div class="form-group">
                                                        <label for="exampleInputEmail1">Email address</label>
                                                        <input type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email">
                                                        <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="exampleInputPassword1">Password</label>
                                                        <input type="password" class="form-control" id="exampleInputPassword1" placeholder="Password">
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="exampleSelect1">Example select</label>
                                                        <select class="form-control" id="exampleSelect1">
                                                            <option>1</option>
                                                            <option>2</option>
                                                            <option>3</option>
                                                            <option>4</option>
                                                            <option>5</option>
                                                        </select>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="exampleSelect2">Example multiple select</label>
                                                        <select multiple class="form-control" id="exampleSelect2">
                                                            <option>1</option>
                                                            <option>2</option>
                                                            <option>3</option>
                                                            <option>4</option>
                                                            <option>5</option>
                                                        </select>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="exampleTextarea">Example textarea</label>
                                                        <textarea class="form-control" id="exampleTextarea" rows="3"></textarea>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="exampleInputFile">File input</label>
                                                        <input type="file" class="form-control-file" id="exampleInputFile" aria-describedby="fileHelp">
                                                        <small id="fileHelp" class="form-text text-muted">This is some placeholder block-level help text for the above input. It's a bit lighter and easily wraps to a new line.</small>
                                                    </div>
                                                    <fieldset class="form-group">
                                                        <legend>Radio buttons</legend>
                                                        <div class="form-check">
                                                            <label class="form-check-label">
                                                                <input type="radio" class="form-check-input" name="optionsRadios" id="optionsRadios1" value="option1" checked>
                                                                Option one is this and that&mdash;be sure to include why it's great
                                                            </label>
                                                        </div>
                                                        <div class="form-check">
                                                            <label class="form-check-label">
                                                                <input type="radio" class="form-check-input" name="optionsRadios" id="optionsRadios2" value="option2">
                                                                Option two can be something else and selecting it will deselect option one
                                                            </label>
                                                        </div>
                                                        <div class="form-check disabled">
                                                            <label class="form-check-label">
                                                                <input type="radio" class="form-check-input" name="optionsRadios" id="optionsRadios3" value="option3" disabled>
                                                                Option three is disabled
                                                            </label>
                                                        </div>
                                                    </fieldset>
                                                    <div class="form-check">
                                                        <label class="form-check-label">
                                                            <input type="checkbox" class="form-check-input">
                                                            Check me out
                                                        </label>
                                                    </div>
                                                    <button type="submit" class="btn btn-primary">Submit</button>
                                                </form>

                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div><!--/row-->

                    <div class="row" id="footer">
                        <div class="col-sm-6">

                        </div>
                        <div class="col-sm-6">
                            <p>
                                <a href="#" class="pull-right">©Copyright 2013</a>
                            </p>
                        </div>
                    </div>

                    <hr>

                    <h4 class="text-center">
                        <a href="http://bootply.com/96266" target="ext">Download this Template @Bootply</a>
                    </h4>

                    <hr>


                </div><!-- /col-9 -->
            </div><!-- /padding -->
        </div>
        <!-- /main -->

    </div>
</div>
</div>


<!--post modal-->
<div id="postModal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                Update Status
            </div>
            <div class="modal-body">
                <form class="form center-block">
                    <div class="form-group">
                        <textarea class="form-control input-lg" autofocus=""
                                  placeholder="What do you want to share?"></textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <div>
                    <button class="btn btn-primary btn-sm" data-dismiss="modal" aria-hidden="true">Post</button>
                    <ul class="pull-left list-inline">
                        <li><a href=""><i class="glyphicon glyphicon-upload"></i></a></li>
                        <li><a href=""><i class="glyphicon glyphicon-camera"></i></a></li>
                        <li><a href=""><i class="glyphicon glyphicon-map-marker"></i></a></li>
                    </ul>
                </div>
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
</body>
</html>