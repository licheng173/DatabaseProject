<div class="navbar navbar-orange navbar-static-top">
    <div class="navbar-header">
        <button class="navbar-toggle" type="button" data-toggle="collapse"
                data-target=".navbar-collapse">
            <span class="sr-only">Toggle</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
        <a href="/" class="navbar-brand logo">c</a>
    </div>
    <nav class="collapse navbar-collapse" role="navigation">
        <form class="navbar-form navbar-left">
            <div class="input-group input-group-sm" style="max-width:360px;">
                <input type="text" class="form-control" placeholder="Search" name="srch-term"
                       id="srch-term">
                <div class="input-group-btn">
                    <button class="btn btn-default" type="submit"><i
                            class="glyphicon glyphicon-search"></i></button>
                </div>
            </div>
        </form>
        <ul class="nav navbar-nav">
            <li>
                <a href="mypage.php"><i class="glyphicon glyphicon-home"></i> My Page</a>
            </li>
            <li>
                <a href="#"><i class="glyphicon glyphicon-home"></i> Home</a>
            </li>
            <li>
                <a href="postModal.php"><i class="glyphicon glyphicon-plus"></i> Post</a>
            </li>
        </ul>
        <ul class="nav navbar-nav navbar-right">
            <li class="dropdown">
                <a href="signout.php"><i class="glyphicon glyphicon-user"></i> Sign out &nbsp</a>
            </li>
        </ul>
    </nav>
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
                        <label for="rtitle">Title</label>
                        <input type="text" class="form-control" id="rtitle" name="rtitle">
                    </div>

                    <div class="form-group">
                        <label for="rserving">Serving</label>
                        <input type="number" class="form-control" id="rserving" name="rserving">
                    </div>

                    <div class="input_fields_wrap">
                        <button class="add_field_button">Add More Fields</button>
                        <div><input type="text" name="mytext[]"></div>
                    </div>

                    <div class="form-group">
                        <label for="rdescription">Description</label>
                        <textarea class="form-control input-lg" autofocus="" id="rdescription" name="rdescription"
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