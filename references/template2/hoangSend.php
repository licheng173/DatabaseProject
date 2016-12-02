<?php

date_default_timezone_set('America/Chicago');

$numberOfMetastaticSites = $_POST['numberOfMetastaticSites'];

$subcutaneousMetastasis = $_POST['subcutaneousMetastasis'];
if ($subcutaneousMetastasis != 1) {
    $subcutaneousMetastasis = 0;
}

$liverMetastasis = $_POST['liverMetastasis'];
if ($liverMetastasis != 1) {
    $liverMetastasis = 0;
}

$ecog = $_POST['ecog'];

$lossOfAppetite = $_POST['lossOfAppetite'];
if ($lossOfAppetite != 1) {
    $lossOfAppetite = 0;
}

$noPreviousLungSurgery = $_POST['noPreviousLungSurgery'];
if ($noPreviousLungSurgery != 1) {
    $noPreviousLungSurgery = 0;
}

include "../../dbincloc/nomogram.inc";

$db = new mysqli($hostname, $usr, $pwd, $dbname);
if ($db->connect_error) {
    die('Unable to connect to database: ' . $db->connect_error);
}

$parameters =
    $numberOfMetastaticSites . "|" .
    $subcutaneousMetastasis . "|" .
    $liverMetastasis . "|" .
    $ecog . "|" .
    $lossOfAppetite . "|" .
    $noPreviousLungSurgery;

if ($result = $db->prepare("select JOBID from Jobs where Parameters = ? and Software = 'nomogram' and Analysis = 'hoang' and Status = 2 and ResultImage is not null limit 1;")) {
    $result->bind_param("s", $parameters);
    $result->execute();
    $result->bind_result($JOBID);
    $result->fetch();
    $result->close();

    if (empty($JOBID)) {
        $JOBID = uniqid("", TRUE);

        $date = new DateTime('0000-01-01 00:00:00');
        $dateString = $date->format('Y-m-d H:i:s');

        // set job status as 0. 0 means non-dealt, while 1 means dealt
        if ($result1 = $db->prepare("INSERT INTO Jobs (JOBID, Parameters, Software, Analysis, ResultPlot, ResultTable, ResultFile, CreateTime, FinishTime) VALUES (?, ?, 'nomogram', 'hoang', '', '', '', now(), ?);")
        ) {
            $result1->bind_param("sss", $JOBID, $parameters, $dateString);
            $result1->execute();
            $result1->close();
        }
    }

    echo "<script>location.href='hoang.php?jobid=" . $JOBID .
        "&numberOfMetastaticSites=" . $numberOfMetastaticSites .
        "&subcutaneousMetastasis=" . $subcutaneousMetastasis .
        "&liverMetastasis=" . $liverMetastasis .
        "&ecog=" . $ecog .
        "&lossOfAppetite=" . $lossOfAppetite .
        "&noPreviousLungSurgery=" . $noPreviousLungSurgery .
        "'</script>";
}

$db->close();

?>
