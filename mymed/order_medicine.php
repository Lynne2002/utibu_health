<?php
header('Content-Type: application/json'); 
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    
    $medicineName = $_POST['medicine_name'];
    $quantity = $_POST['quantity'];
    $fullname = $_POST['fullname']; 
    
    
    $servername = "localhost";
    $username = "root"; // Update with your database username
    $password = ""; // Update with your database password
    $dbname = "utibu_health"; // Update with your database name
    $conn = new mysqli($servername, $username, $password, $dbname);

    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }
    
    
    $checkStockQuery = "SELECT quantity FROM medicine_stock WHERE medicine_name = ?";
    $checkStockStmt = $conn->prepare($checkStockQuery);
    $checkStockStmt->bind_param("s", $medicineName);
    $checkStockStmt->execute();
    $stockResult = $checkStockStmt->get_result();

    if ($stockResult->num_rows > 0) { 
        $row = $stockResult->fetch_assoc();
        $availableQuantity = $row["quantity"];
        
        if ($availableQuantity < $quantity) {
            echo json_encode(array("status" => "error", "message" => "Not enough medicine in stock"));
        } 
        else {
            
            $newQuantity = $availableQuantity - $quantity;
            $updateStockQuery = "UPDATE medicine_stock SET quantity = ? WHERE medicine_name = ?";
            $updateStockStmt = $conn->prepare($updateStockQuery);
            $updateStockStmt->bind_param("is", $newQuantity, $medicineName);
            $updateStockStmt->execute();
            
            
            $insertOrderQuery = "INSERT INTO orders (medicine_name, quantity, fullname) VALUES (?, ?, ?)";
            $insertOrderStmt = $conn->prepare($insertOrderQuery);
            $insertOrderStmt->bind_param("sis", $medicineName, $quantity, $fullname);
            $insertOrderStmt->execute();
            
          
            echo json_encode(array("status" => "success", "message" => "Order successful"));
        }
    } 
    else {
        echo json_encode(array("status" => "error", "message" => "Medicine not found"));
    }

    
    $conn->close();
} 
elseif ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $servername = "localhost";
    $username = "root"; 
    $password = ""; 
    $dbname = "utibu_health";
    $conn = new mysqli($servername, $username, $password, $dbname);

    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    $medicineList = array();
    $fetchMedicineQuery = "SELECT medicine_name FROM medicine_stock";
    $medicineResult = $conn->query($fetchMedicineQuery);

    if ($medicineResult->num_rows > 0) {
        while ($row = $medicineResult->fetch_assoc()) {
            $medicineList[] = $row['medicine_name'];
        }
    }

    echo json_encode(array("medicine_names" => $medicineList));

    $conn->close();
}

else {
    echo json_encode(array("status" => "error", "message" => "Invalid request method"));
}
