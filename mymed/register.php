<?php

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $username = $_POST['username'];
    $password = $_POST['password'];
    $email = $_POST['email'];
    $hashed_password = password_hash($password, PASSWORD_DEFAULT);

    $servername = "localhost";
    $credname = "root";
    $pwd = "";
    $dbname = "utibu_health";


    $conn = new mysqli($servername, $credname, $pwd, $dbname);


    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }


    $check_query = "SELECT * FROM login WHERE username = ?";
    $check_stmt = mysqli_prepare($conn, $check_query);
    mysqli_stmt_bind_param($check_stmt, "s", $username);
    mysqli_stmt_execute($check_stmt);
    $result = mysqli_stmt_get_result($check_stmt);

    if (mysqli_num_rows($result) > 0) {

        echo json_encode(array("status" => "error", "message" => "A user with that username already exists"));
    } 
    else {
        $insert_query = "INSERT INTO login (username, password, email) VALUES (?, ?, ?)";
        $insert_stmt = mysqli_prepare($conn, $insert_query);
        mysqli_stmt_bind_param($insert_stmt, "sss", $username, $hashed_password, $email);

        if (mysqli_stmt_execute($insert_stmt)) {
            echo json_encode(array("status" => "success", "message" => "Registration successful. You can now log in"));
        } 
        else {
            echo json_encode(array("status" => "error", "message" => "Registration failed"));
        }
    }

    $conn->close();
    } 
    else {
    echo json_encode(array("status" => "error", "message" => "Invalid request method"));
    }
