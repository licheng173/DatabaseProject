<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Databasehw3</title>
    <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <link href="css/jquery.dataTables.min.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="js/jquery.js"></script>
    <script type="text/javascript" src="js/bootstrap.min.js"></script>
    <script type="text/javascript" src="js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="js/angular.min.js"></script>
    <script type="text/javascript" language="javascript" class="init">
        $(document).ready(function () {
            $('#movies').dataTable({
                "paging": false,
                "info": false,
                "searching": false
            });
        });
    </script>
</head>
<body class="container" ng-app="myApp" ng-controller="myCtrl">

<?php
include "header.php";
?>

<table id="movies" class="display" cellspacing="0" width="100%">
    <thead>
    <tr>
        <th>title</th>
        <th>mid</th>
        <th>budget</th>
        <th>gross income</th>
    </tr>
    </thead>
    <tfoot>
    <tr>
        <th>title</th>
        <th>mid</th>
        <th>budget</th>
        <th>gross income</th>
    </tr>
    </tfoot>
    <tbody>
    <tr ng-repeat="x in records">
        <td><a href="movie.php?mid={{ x.mid }}">{{ x.mname }}</td>
        <td>{{ x.mid }}</a></td>
        <td>{{ x.budget }}</td>
        <td>{{ x.gross }}</td>
    </tr>
    </tbody>
</table>
<?php
$keyword = $_POST['query'];

include "databasehw3.inc";

$json = array();

if ($keyword != "") {
    $db = new mysqli($hostname, $usr, $pwd, $dbname);
    if ($db->connect_error) {
        die('Unable to connect to database: ' . $db->connect_error);
    }

//    $keyword = mysqli_real_escape_strings($db, $keyword);

    if ($result = $db->prepare("select mid, mname, budget, gross from movie where mname like concat('%',?,'%');")) {
        $result->bind_param("s", $keyword);
        $result->execute();
        $result->bind_result($mid, $mname, $budget, $gross);

        while ($result->fetch()) {
            $json[$mid]["mid"] = $mid;
            $json[$mid]["mname"] = $mname;
            $json[$mid]["budget"] = $budget;
            $json[$mid]["gross"] = $gross;
        }
        $result->close();
    }
    $db->close();
}
?>
<script type="text/javascript" language="javascript" class="init">
    var app = angular.module("myApp", []);
    app.controller("myCtrl", function ($scope) {
        $scope.records = <?php echo json_encode(array_values($json)); ?>;
    });
</script>
</body>
</html>