<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');
header('Access-Control-Allow-Headers: Content-Type');

include '../../config/database.php';

$user_id = $_GET['id'] ?? null;

try {
    $database = new Database();
    $pdo = $database->getConnection();
    
    if ($user_id) {
        $stmt = $pdo->prepare("
            SELECT id, username, full_name, email, role, is_active, created_at, updated_at 
            FROM users 
            WHERE id = ?
        ");
        $stmt->execute([$user_id]);
        $user = $stmt->fetch(PDO::FETCH_ASSOC);
        
        if ($user) {
            echo json_encode(['success' => true, 'data' => $user]);
        } else {
            echo json_encode(['success' => false, 'error' => 'User not found']);
        }
    } else {
        echo json_encode(['success' => false, 'error' => 'User ID is required']);
    }
    
} catch(PDOException $e) {
    http_response_code(500);
    echo json_encode(['success' => false, 'error' => $e->getMessage()]);
}
?>