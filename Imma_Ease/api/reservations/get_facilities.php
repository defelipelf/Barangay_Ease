<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');
header('Access-Control-Allow-Headers: Content-Type');

include __DIR__ . '/../../config/database.php';
try {
    $database = new Database();
    $pdo = $database->getConnection();
    
    $stmt = $pdo->query("SELECT * FROM facilities WHERE is_active = 1");
    $facilities = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    echo json_encode(['success' => true, 'data' => $facilities]);
    
} catch(PDOException $e) {
    http_response_code(500);
    echo json_encode(['success' => false, 'error' => $e->getMessage()]);
}
?>