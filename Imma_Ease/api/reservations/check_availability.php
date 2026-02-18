<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');
header('Access-Control-Allow-Headers: Content-Type');

include __DIR__ . '/../../config/database.php';

$facility_id = $_GET['facility_id'] ?? null;
$date = $_GET['date'] ?? null;

try {
    $database = new Database();
    $pdo = $database->getConnection();
    
    if ($facility_id && $date) {
        // Get all reservations for the facility on the given date
        $sql = "SELECT start_time, end_time 
                FROM reservations 
                WHERE facility_id = ? 
                AND reservation_date = ? 
                AND status IN ('pending', 'approved')
                ORDER BY start_time";
        
        $stmt = $pdo->prepare($sql);
        $stmt->execute([$facility_id, $date]);
        $booked_slots = $stmt->fetchAll(PDO::FETCH_ASSOC);
        
        echo json_encode(['success' => true, 'data' => $booked_slots]);
    } else {
        echo json_encode(['success' => false, 'error' => 'Facility ID and date are required']);
    }
    
} catch(PDOException $e) {
    http_response_code(500);
    echo json_encode(['success' => false, 'error' => $e->getMessage()]);
}
?>