<?php
    include 'conn.php';

    $username =$_POST['username'];
    $password =$_POST['password'];
    $email =$_POST['email'];
    $level =$_POST['level'];

    $connect->query("INSERT INTO user(username,password,email,level) VALUES('".$username."','".$password."','".$email."','".$level."')")
?>