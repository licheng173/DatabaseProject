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
            $('#actors').dataTable({
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

<table id="actors" class="display" cellspacing="0" width="100%">
    <thead>
    <tr>
        <th>name</th>
        <th>aid</th>
        <th>wage</th>
        <th>starring</th>
    </tr>
    </thead>
    <tfoot>
    <tr>
        <th>name</th>
        <th>aid</th>
        <th>wage</th>
        <th>starring</th>
    </tr>
    </tfoot>
    <tbody>
    <tr ng-repeat="x in records">
        <td>{{ x.name }}</td>
        <td>{{ x.aid }}</a></td>
        <td>{{ x.wage }}</td>
        <td>{{ x.starring }}</td>
    </tr>
    </tbody>
</table>
<?php
$mid = $_GET['mid'];

include "databasehw3.inc";

$json = array();

$db = new mysqli($hostname, $usr, $pwd, $dbname);
if ($db->connect_error) {
    die('Unable to connect to database: ' . $db->connect_error);
}

if ($result = $db->prepare("select aname, aid, wage, starring from actor natural join actedin natural join movie where mid = ?;")) {
    $result->bind_param("d", $mid);
    $result->execute();
    $result->bind_result($name, $aid, $wage, $starring);

    while ($result->fetch()) {
        $json[$aid]["name"] = $name;
        $json[$aid]["aid"] = $aid;
        $json[$aid]["wage"] = $wage;
        $json[$aid]["starring"] = ($starring == 1);
    }
    $result->close();
}
$db->close();
?>
<script type="text/javascript" language="javascript" class="init">
    var app = angular.module("myApp", []);
    app.controller("myCtrl", function ($scope) {
        $scope.records = <?php echo json_encode(array_values($json)); ?>;
    });
</script>
</body>
</html>