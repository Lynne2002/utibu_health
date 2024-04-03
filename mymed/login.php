<?php 


	if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        
        if (isset($_POST['username']) && isset($_POST['password'])) {
            $username = $_POST['username'];
            $password = $_POST['password'];
    
          
            $servername = "localhost";
            $credname = "root";
            $pwd = "";
            $dbname = "utibu_health";
    
            
            $conn = new mysqli($servername, $credname, $pwd, $dbname);
    
           
            if ($conn->connect_error) {
                die("Connection failed: " . $conn->connect_error);
            }
    
            
            $query = "SELECT * FROM login WHERE username = ?";
            $stmt = mysqli_prepare($conn, $query);
            mysqli_stmt_bind_param($stmt, "s", $username);
            mysqli_stmt_execute($stmt);
            $result = mysqli_stmt_get_result($stmt);
    
            if (mysqli_num_rows($result) == 1) {
        
                $user = mysqli_fetch_assoc($result);
                if (password_verify($password, $user['password'])) {
                   
                    echo json_encode(array("status" => "success", "message" => "Login successful"));
                } else {
                    
                    echo json_encode(array("status" => "error", "message" => "Incorrect password"));
                }
            } else {
              
                echo json_encode(array("status" => "error", "message" => "User not found"));
            }
    
          
            $conn->close();
        } else {
            
            echo json_encode(array("status" => "error", "message" => "Missing parameters"));
        }
    } else {
       
        echo json_encode(array("status" => "error", "message" => "Invalid request method"));
    }
    

?>