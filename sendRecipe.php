<?php

if(isset($_POST['tag']) && is_array($_POST['tag'])){
    $tags = implode(', ', $_POST['tag']);
    echo $tags . '</br>';
}

echo $_POST['rtitle'] . '</br>';
echo $_POST['rserving'] . '</br>';

if(isset($_POST['ingredients']) && is_array($_POST['ingredients'])){
    $tags = implode(', ', $_POST['ingredients']);
    echo $tags . '</br>';
}

if(isset($_POST['unit']) && is_array($_POST['unit'])){
    $tags = implode(', ', $_POST['unit']);
    echo $tags . '</br>';
}

if(isset($_POST['amount']) && is_array($_POST['amount'])){
    $tags = implode(', ', $_POST['amount']);
    echo $tags . '</br>';
}

echo $_POST['rdescription'] . '</br>';

echo $_FILES["photo"]["tmp_name"][0] . '</br>';
echo $_FILES['photo']['size'][0] . '</br>';
echo $_FILES['photo']['type'][0] . '</br>';

echo $_FILES["photo"]["tmp_name"][1] . '</br>';
echo $_FILES['photo']['size'][1] . '</br>';
echo $_FILES['photo']['type'][1];
?>