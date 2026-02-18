<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');
header('Access-Control-Allow-Headers: Content-Type');

include __DIR__ . '/../../config/database.php';

try {
    $database = new Database();
    $pdo = $database->getConnection();
    
    $stmt = $pdo->query("
        SELECT r.*, 
               f.name as facility_name,
               res.first_name, 
               res.last_name,
               res.contact_number
        FROM reservations r
        JOIN facilities f ON r.facility_id = f.id
        JOIN residents res ON r.resident_id = res.resident_id
        ORDER BY r.reservation_date, r.start_time
    ");
    $reservations = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    echo json_encode(['success' => true, 'data' => $reservations]);
    
} catch(PDOException $e) {
    http_response_code(500);
    echo json_encode(['success' => false, 'error' => $e->getMessage()]);
}
?>