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
    
    if ($_SERVER['REQUEST_METHOD'] === 'DELETE') {
        $user_id = $input['id'] ?? '';
        
        // Prevent deleting the last super admin
        $check_stmt = $pdo->prepare("
            SELECT COUNT(*) as super_admin_count 
            FROM users 
            WHERE role = 'super_admin' AND id != ?
        ");
        $check_stmt->execute([$user_id]);
        $result = $check_stmt->fetch(PDO::FETCH_ASSOC);
        
        if ($result['super_admin_count'] == 0) {
            echo json_encode(['success' => false, 'error' => 'Cannot delete the last super admin']);
            exit;
        }
        
        $sql = "DELETE FROM users WHERE id = ?";
        $stmt = $pdo->prepare($sql);
        $stmt->execute([$user_id]);
        
        if ($stmt->rowCount() > 0) {
            echo json_encode(['success' => true, 'message' => 'User deleted successfully']);
        } else {
            echo json_encode(['success' => false, 'error' => 'User not found']);
        }
    }
    
} catch(PDOException $e) {
    http_response_code(500);
    echo json_encode(['success' => false, 'error' => $e->getMessage()]);
}
?>