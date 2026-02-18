<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');
header('Access-Control-Allow-Headers: Content-Type');

include __DIR__ . '/../../config/database.php';

$input = json_decode(file_get_contents('php://input'), true);

try {
    $database = new Database();
    $pdo = $database->getConnection();
    
    if ($_SERVER['REQUEST_METHOD'] === 'DELETE') {
        $sql = "DELETE FROM reservations WHERE id = ?";
        $stmt = $pdo->prepare($sql);
        $stmt->execute([$input['reservation_id']]);
        
        if ($stmt->rowCount() > 0) {
            echo json_encode(['success' => true, 'message' => 'Reservation deleted successfully']);
        } else {
            echo json_encode(['success' => false, 'error' => 'Reservation not found']);
        }
    }
    
} catch(PDOException $e) {
    http_response_code(500);
    echo json_encode(['success' => false, 'error' => $e->getMessage()]);
}
?>