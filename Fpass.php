<?php

include "../dbconf.inc";
session_start();


//if (isset($_SESSION['uid'])) {
//    header("Location: home.php");
//}

if(isset($_POST['submit']))
{
 $email = $_POST['txtemail'];
 $uname = $_POST['username'];
 $realname = $_POST['realname'];
    
 $db = new mysqli($hostname, $usr, $pwd, $dbname);
    if ($db->connect_error) {
        die('Unable to connect to database: ' . $db->connect_error);
    }

    if ($result = $db->prepare("select upassword from user where uname = ? and name = ?;")) {
        $result->bind_param("ss", $uname, $realname);
        $result->execute();
        $result->bind_result($password);
        $result->fetch();
        $result->close();
        
        
        if(!empty($password)) {
            $pass = uniqid(rand());
             $code = md5($pass);
            if ($result = $db->prepare("update user set upassword = ? where uname= ?;")) {
                $result->bind_param("ss", $code, $uname);
                $result->execute();
                $result->close();
            }
            
            $message= "
            Hello , $email
            <br /><br />
            We got requested to reset your password, if not just ignore this email,
            Your new password : $pass
            
            <br /><br />
            thank you :)";
            $subject = "Password Reset"; 
            mail($email,$subject,$message);
            $msg = "<div class='alert alert-success'>
            <button class='close' data-dismiss='alert'>&times;</button>
            We've sent an email to $email $pass
                    Please back to login. 
            </div>";
            $mess="true";
            
        }
        else
        {
            $msg = "<div class='alert alert-danger'>
                <button class='close' data-dismiss='alert'>&times;</button>
                <strong>Sorry!</strong>  this username not found. 
                    </div>";
        }
    }    
}
if(isset($_POST['login']))
{
    header("Location: login.php");
}

?>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <!-- This file has been downloaded from Bootsnipp.com. Enjoy! -->
    <title>Simple login form - Bootsnipp style colorgraph - Bootsnipp.com</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet">
    <style type="text/css">
        .wrapper {    
	margin-top: 80px;
	margin-bottom: 20px;
}

.form-signin {
  max-width: 420px;
  padding: 30px 38px 66px;
  margin: 0 auto;
  background-color: #eee;
  border: 3px dotted rgba(0,0,0,0.1);  
  }

.form-signin-heading {
  text-align:center;
  margin-bottom: 30px;
}

.form-control {
  position: relative;
  font-size: 16px;
  height: auto;
  padding: 10px;
}

input[type="text"] {
  margin-bottom: 0px;
  border-bottom-left-radius: 0;
  border-bottom-right-radius: 0;
}

input[type="password"] {
  margin-bottom: 20px;
  border-top-left-radius: 0;
  border-top-right-radius: 0;
}

.colorgraph {
  height: 7px;
  border-top: 0;
  background: #c4e17f;
  border-radius: 5px;
  background-image: -webkit-linear-gradient(left, #c4e17f, #c4e17f 12.5%, #f7fdca 12.5%, #f7fdca 25%, #fecf71 25%, #fecf71 37.5%, #f0776c 37.5%, #f0776c 50%, #db9dbe 50%, #db9dbe 62.5%, #c49cde 62.5%, #c49cde 75%, #669ae1 75%, #669ae1 87.5%, #62c2e4 87.5%, #62c2e4);
  background-image: -moz-linear-gradient(left, #c4e17f, #c4e17f 12.5%, #f7fdca 12.5%, #f7fdca 25%, #fecf71 25%, #fecf71 37.5%, #f0776c 37.5%, #f0776c 50%, #db9dbe 50%, #db9dbe 62.5%, #c49cde 62.5%, #c49cde 75%, #669ae1 75%, #669ae1 87.5%, #62c2e4 87.5%, #62c2e4);
  background-image: -o-linear-gradient(left, #c4e17f, #c4e17f 12.5%, #f7fdca 12.5%, #f7fdca 25%, #fecf71 25%, #fecf71 37.5%, #f0776c 37.5%, #f0776c 50%, #db9dbe 50%, #db9dbe 62.5%, #c49cde 62.5%, #c49cde 75%, #669ae1 75%, #669ae1 87.5%, #62c2e4 87.5%, #62c2e4);
  background-image: linear-gradient(to right, #c4e17f, #c4e17f 12.5%, #f7fdca 12.5%, #f7fdca 25%, #fecf71 25%, #fecf71 37.5%, #f0776c 37.5%, #f0776c 50%, #db9dbe 50%, #db9dbe 62.5%, #c49cde 62.5%, #c49cde 75%, #669ae1 75%, #669ae1 87.5%, #62c2e4 87.5%, #62c2e4);
}
    </style>
    <script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
</head>
<body>
<div class = "container">
	<div class="wrapper">
		<form action="" method="post" name="Login_Form" class="form-signin">       
		    <h3 class="form-signin-heading">Reset Your Password</h3>
			  <hr class="colorgraph"><br>
            <?php
   if(isset($msg))
   {
    echo $msg;
   }
   else
   {
    ?>
               <div class='alert alert-info'>
    Please enter your username realname and email address. You will receive your password via email!
    </div>  
                <?php
   }
   ?>
			  
            <br>
             <?php
                if (isset($mess)) {
                    
            ?>
                    <a href="login.php">
			  		<button class="btn btn-lg btn-primary btn-block"  name="login" value="Login" type="Submit">Login</button>  
                    </a>
             <?php
                }
            else {
                         ?>
            <input type="text" class="form-control" name="username" placeholder="Username" required="" autofocus="" />
			  <input type="text" class="form-control" name="realname" placeholder="RealName" required=""/>     		  
			  <input type="email" class="form-control" placeholder="Email address" name="txtemail" required />
            <br>
			  		<button class="btn btn-lg btn-primary btn-block"  name="submit" value="Login" type="Submit">Reset</button>  <?php
            }
            ?>
		</form>			
	</div>
</div>
<script type="text/javascript">

</script>
</body>
</html>
