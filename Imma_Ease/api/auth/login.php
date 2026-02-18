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
        
        // Find user by username
        $stmt = $pdo->prepare("SELECT * FROM users WHERE username = ? AND is_active = 1");
        $stmt->execute([$username]);
        $user = $stmt->fetch(PDO::FETCH_ASSOC);
        
        if ($user && password_verify($password, $user['password'])) {
            // Remove password from user data before sending to client
            unset($user['password']);
            
            echo json_encode([
                'success' => true, 
                'user' => $user,
                'message' => 'Login successful'
            ]);
        } else {
            echo json_encode([
                'success' => false, 
                'error' => 'Invalid username or password'
            ]);
        }
    }
    
} catch(PDOException $e) {
    http_response_code(500);
    echo json_encode(['success' => false, 'error' => $e->getMessage()]);
}
?>