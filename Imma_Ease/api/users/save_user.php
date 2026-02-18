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
    
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        $username = $input['username'] ?? '';
        $password = $input['password'] ?? '';
        $full_name = $input['full_name'] ?? '';
        $email = $input['email'] ?? '';
        $role = $input['role'] ?? 'admin';
        $is_active = $input['is_active'] ?? 1;
        
        // Validate required fields
        if (empty($username) || empty($password) || empty($full_name)) {
            echo json_encode(['success' => false, 'error' => 'Username, password, and full name are required']);
            exit;
        }
        
        // Check if username already exists
        $check_stmt = $pdo->prepare("SELECT id FROM users WHERE username = ?");
        $check_stmt->execute([$username]);
        
        if ($check_stmt->rowCount() > 0) {
            echo json_encode(['success' => false, 'error' => 'Username already exists']);
            exit;
        }
        
        // Hash password
        $hashed_password = password_hash($password, PASSWORD_DEFAULT);
        
        // Insert new user
        $sql = "INSERT INTO users (username, password, full_name, email, role, is_active) 
                VALUES (?, ?, ?, ?, ?, ?)";
        
        $stmt = $pdo->prepare($sql);
        $stmt->execute([
            $username,
            $hashed_password,
            $full_name,
            $email,
            $role,
            $is_active
        ]);
        
        $user_id = $pdo->lastInsertId();
        echo json_encode([
            'success' => true, 
            'user_id' => $user_id, 
            'message' => 'User created successfully'
        ]);
    }
    
} catch(PDOException $e) {
    http_response_code(500);
    echo json_encode(['success' => false, 'error' => $e->getMessage()]);
}
?>