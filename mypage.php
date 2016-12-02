<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta charset="utf-8">
    <title>CookZilla</title>
    <meta name="generator" content="Bootply"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

    <!-- Optional theme -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">

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
                            <div class="col-sm-4">
                                <div class="panel panel-default">
                                    <div class="panel-body">
                                        <p><img src="images/73892.jpg"> <a href="#">The
                                                Bootstrap Playground</a></p>
                                        <div class="clearfix"></div>
                                        <hr>
                                        Design, build, test, and prototype using Bootstrap in real-time from your Web
                                        browser. Bootply combines the power of hand-coded HTML, CSS and JavaScript with
                                        the benefits of responsive design using Bootstrap. Find and showcase
                                        Bootstrap-ready snippets in the 100% free Bootply.com code repository.

                                        <div class="grid-col__ratings">
                                            <div class="rating-stars" data-scroll-to-anchor="reviews" data-ratingstars="3.85999989509583">
                                                <img height="16" width="16" src="images/full-star.svg">
                                                <img height="16" width="16" src="images/full-star.svg">
                                                <img height="16" width="16" src="images/full-star.svg">
                                                <img height="16" width="16" src="images/full-star.svg">
                                                <img height="16" width="16" src="images/empty-star.svg">
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                            <div class="col-sm-4">
                                <div class="panel panel-default">
                                    <div class="panel-body">
                                        <p><img src="images/714402.jpg"> <a href="#">The
                                                Bootstrap Playground</a></p>
                                        <div class="clearfix"></div>
                                        <hr>
                                        Design, build, test, and prototype using Bootstrap in real-time from your Web
                                        browser. Bootply combines the power of hand-coded HTML, CSS and JavaScript with
                                        the benefits of responsive design using Bootstrap. Find and showcase
                                        Bootstrap-ready snippets in the 100% free Bootply.com code repository.

                                        <div class="grid-col__ratings">
                                            <div class="rating-stars" data-scroll-to-anchor="reviews" data-ratingstars="3.85999989509583">
                                                <img height="16" width="16" src="images/full-star.svg">
                                                <img height="16" width="16" src="images/full-star.svg">
                                                <img height="16" width="16" src="images/full-star.svg">
                                                <img height="16" width="16" src="images/full-star.svg">
                                                <img height="16" width="16" src="images/empty-star.svg">
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                            <div class="col-sm-4">
                                <div class="panel panel-default">
                                    <div class="panel-body">
                                        <p><img src="images/789272.jpg"> <a href="#">The
                                                Bootstrap Playground</a></p>
                                        <div class="clearfix"></div>
                                        <hr>
                                        Design, build, test, and prototype using Bootstrap in real-time from your Web
                                        browser. Bootply combines the power of hand-coded HTML, CSS and JavaScript with
                                        the benefits of responsive design using Bootstrap. Find and showcase
                                        Bootstrap-ready snippets in the 100% free Bootply.com code repository.

                                        <div class="grid-col__ratings">
                                            <div class="rating-stars" data-scroll-to-anchor="reviews" data-ratingstars="3.85999989509583">
                                                <img height="16" width="16" src="images/full-star.svg">
                                                <img height="16" width="16" src="images/full-star.svg">
                                                <img height="16" width="16" src="images/full-star.svg">
                                                <img height="16" width="16" src="images/full-star.svg">
                                                <img height="16" width="16" src="images/empty-star.svg">
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
                New Post
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
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>

<script src="js/scripts.js"></script>
</body>
</html>