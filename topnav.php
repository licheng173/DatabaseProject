<div class="navbar navbar-orange navbar-static-top">
    <div class="navbar-header">
        <button class="navbar-toggle" type="button" data-toggle="collapse"
                data-target=".navbar-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
        <a href="/" class="navbar-brand logo">c</a>
    </div>
    <nav class="collapse navbar-collapse" role="navigation">
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
                <a href="signout.php"><?php echo $_SESSION['uname']?>&nbsp;<i class="glyphicon glyphicon-user"></i> Sign out &nbsp;</a>
            </li>
        </ul>
    </nav>
</div>
