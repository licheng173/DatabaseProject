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
        <form class="navbar-form navbar-left" method="post" name="search_form" action="search.php" enctype="multipart/form-data">
            <div class="input-group input-group-sm" style="max-width:360px;">
                <input type="text" class="form-control" placeholder="Search" name="search"
                       id="search">
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
                <a href="home.php"><i class="glyphicon glyphicon-home"></i> Home</a>
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
