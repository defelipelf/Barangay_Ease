<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');
header('Access-Control-Allow-Headers: Content-Type');

include '../../config/database.php';

try {
    $database = new Database();
    $pdo = $database->getConnection();
    
    $stmt = $pdo->query("
        SELECT 
            r.*,
            h.blood_type,
            h.vaccination_status,
            h.known_allergies,
            h.pre_existing_conditions,
            h.emergency_contact_name,
            h.emergency_contact_number,
            e.highest_education,
            e.employment_status,
            e.occupation,
            v.is_registered,
            v.precinct_number
        FROM residents r
        LEFT JOIN health_info h ON r.resident_id = h.resident_id
        LEFT JOIN education_employment e ON r.resident_id = e.resident_id
        LEFT JOIN voter_info v ON r.resident_id = v.resident_id
        ORDER BY r.last_name, r.first_name
    ");
    $residents = $stmt->fetchAll(PDO::FETCH_ASSOC);
    echo json_encode(['success' => true, 'data' => $residents]);
    
} catch(PDOException $e) {
    http_response_code(500);
    echo json_encode(['success' => false, 'error' => $e->getMessage()]);
}
?>