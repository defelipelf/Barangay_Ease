<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');
header('Access-Control-Allow-Headers: Content-Type');

include '../../config/database.php';

$input = json_decode(file_get_contents('php://input'), true);

try {
    $database = new Database();
    $pdo = $database->getConnection();
    
    if ($_SERVER['REQUEST_METHOD'] === 'PUT') {
        $user_id = $input['id'] ?? '';
        $username = $input['username'] ?? '';
        $password = $input['password'] ?? '';
        $full_name = $input['full_name'] ?? '';
        $email = $input['email'] ?? '';
        $role = $input['role'] ?? 'admin';
        $is_active = $input['is_active'] ?? 1;
        
        // Validate required fields
        if (empty($username) || empty($full_name)) {
            echo json_encode(['success' => false, 'error' => 'Username and full name are required']);
            exit;
        }
        
        // Check if username already exists (excluding current user)
        $check_stmt = $pdo->prepare("SELECT id FROM users WHERE username = ? AND id != ?");
        $check_stmt->execute([$username, $user_id]);
        
        if ($check_stmt->rowCount() > 0) {
            echo json_encode(['success' => false, 'error' => 'Username already exists']);
            exit;
        }
        
        // Prepare SQL based on whether password is being updated
        if (!empty($password)) {
            $hashed_password = password_hash($password, PASSWORD_DEFAULT);
            $sql = "UPDATE users SET 
                    username = ?, password = ?, full_name = ?, email = ?, role = ?, is_active = ?, updated_at = CURRENT_TIMESTAMP 
                    WHERE id = ?";
            $params = [$username, $hashed_password, $full_name, $email, $role, $is_active, $user_id];
        } else {
            $sql = "UPDATE users SET 
                    username = ?, full_name = ?, email = ?, role = ?, is_active = ?, updated_at = CURRENT_TIMESTAMP 
                    WHERE id = ?";
            $params = [$username, $full_name, $email, $role, $is_active, $user_id];
        }
        
        $stmt = $pdo->prepare($sql);
        $stmt->execute($params);
        
        if ($stmt->rowCount() > 0) {
            echo json_encode(['success' => true, 'message' => 'User updated successfully']);
        } else {
            echo json_encode(['success' => false, 'error' => 'User not found or no changes made']);
        }
    }
    
} catch(PDOException $e) {
    http_response_code(500);
    echo json_encode(['success' => false, 'error' => $e->getMessage()]);
}
?>