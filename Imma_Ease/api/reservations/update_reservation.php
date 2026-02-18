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
    
    if ($_SERVER['REQUEST_METHOD'] === 'PUT') {
        // Check for time conflicts (excluding current reservation)
        $check_sql = "SELECT id FROM reservations 
                      WHERE facility_id = ? 
                      AND reservation_date = ? 
                      AND status != 'cancelled'
                      AND id != ?
                      AND ((start_time <= ? AND end_time > ?) 
                           OR (start_time < ? AND end_time >= ?)
                           OR (start_time >= ? AND end_time <= ?))";
        
        $check_stmt = $pdo->prepare($check_sql);
        $check_stmt->execute([
            $input['facility_id'],
            $input['reservation_date'],
            $input['reservation_id'],
            $input['start_time'], $input['start_time'],
            $input['end_time'], $input['end_time'],
            $input['start_time'], $input['end_time']
        ]);
        
        if ($check_stmt->rowCount() > 0) {
            echo json_encode(['success' => false, 'error' => 'Time slot already reserved for this facility']);
            exit;
        }
        
        // Check if date is in the past
        $today = date('Y-m-d');
        if ($input['reservation_date'] < $today) {
            echo json_encode(['success' => false, 'error' => 'Cannot update to past dates']);
            exit;
        }
        
        // Update reservation
        $sql = "UPDATE reservations SET 
                facility_id = ?, reservation_date = ?, start_time = ?, end_time = ?, purpose = ?
                WHERE id = ?";
        
        $stmt = $pdo->prepare($sql);
        $stmt->execute([
            $input['facility_id'],
            $input['reservation_date'],
            $input['start_time'],
            $input['end_time'],
            $input['purpose'],
            $input['reservation_id']
        ]);
        
        if ($stmt->rowCount() > 0) {
            echo json_encode(['success' => true, 'message' => 'Reservation updated successfully']);
        } else {
            echo json_encode(['success' => false, 'error' => 'Reservation not found']);
        }
    }
    
} catch(PDOException $e) {
    http_response_code(500);
    echo json_encode(['success' => false, 'error' => $e->getMessage()]);
}
?>