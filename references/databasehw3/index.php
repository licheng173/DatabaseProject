<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Databasehw3</title>
    <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="js/bootstrap.min.js"></script>
    <script type="text/javascript" src="js/angular.min.js"></script>
</head>
<body class="container">

<?php
include "header.php";
?>

<div class="col-xs-12 col-sm-6 col-md-3">
    <form role="form" method="POST" name="form" action="movies.php">
        <label for="query">Please input a keyword</label>
        <input type="text" class="form-control" id="query" name="query">
        <br/>
        <button type="submit" class="btn btn-primary">Submit</button>
    </form>
</div>
</body>
</html>