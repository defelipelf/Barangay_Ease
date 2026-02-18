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
        $sql = "DELETE FROM residents WHERE resident_id = ?";
        $stmt = $pdo->prepare($sql);
        $stmt->execute([$input['resident_id']]);
        
        // Check if any row was actually deleted
        if ($stmt->rowCount() > 0) {
            echo json_encode(['success' => true, 'message' => 'Resident deleted successfully']);
        } else {
            echo json_encode(['success' => false, 'message' => 'No resident found with that ID']);
        }
    }
    
} catch(PDOException $e) {
    http_response_code(500);
    echo json_encode(['success' => false, 'error' => $e->getMessage()]);
}
?>