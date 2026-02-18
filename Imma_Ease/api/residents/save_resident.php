<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');
header('Access-Control-Allow-Headers: Content-Type');

$input = json_decode(file_get_contents('php://input'), true);

try {
    // Use absolute path instead of relative path
    include '../../config/database.php';
    
    $database = new Database();
    $pdo = $database->getConnection();
    
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        $pdo->beginTransaction();
        
        // Insert basic resident info
        $sql = "INSERT INTO residents (first_name, middle_name, last_name, birth_date, sex, civil_status, contact_number, house_no, street, is_pwd, is_senior, is_solo_parent, is_4ps) 
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        $stmt = $pdo->prepare($sql);
        $stmt->execute([
            $input['first_name'],
            $input['middle_name'],
            $input['last_name'],
            $input['birth_date'],
            $input['sex'],
            $input['civil_status'],
            $input['contact_number'],
            $input['house_no'],
            $input['street'],
            $input['is_pwd'],
            $input['is_senior'],
            $input['is_solo_parent'],
            $input['is_4ps']
        ]);
        
        $resident_id = $pdo->lastInsertId();
        
        // Insert health info if provided
        if (isset($input['health_info'])) {
            $health_sql = "INSERT INTO health_info (blood_type, known_allergies, pre_existing_conditions, emergency_contact_name, emergency_contact_number, vaccination_status, resident_id) 
                          VALUES (?, ?, ?, ?, ?, ?, ?)";
            $health_stmt = $pdo->prepare($health_sql);
            $health_stmt->execute([
                $input['health_info']['blood_type'] ?? null,
                $input['health_info']['known_allergies'] ?? null,
                $input['health_info']['pre_existing_conditions'] ?? null,
                $input['health_info']['emergency_contact_name'] ?? null,
                $input['health_info']['emergency_contact_number'] ?? null,
                $input['health_info']['vaccination_status'] ?? null,
                $resident_id
            ]);
        }
        
        // Insert education & employment info if provided
        if (isset($input['education_info'])) {
            $edu_sql = "INSERT INTO education_employment (highest_education, employment_status, occupation, resident_id) 
                       VALUES (?, ?, ?, ?)";
            $edu_stmt = $pdo->prepare($edu_sql);
            $edu_stmt->execute([
                $input['education_info']['highest_education'] ?? null,
                $input['education_info']['employment_status'] ?? null,
                $input['education_info']['occupation'] ?? null,
                $resident_id
            ]);
        }
        
        // Insert voter info if provided
        if (isset($input['voter_info'])) {
            $voter_sql = "INSERT INTO voter_info (is_registered, precinct_number, resident_id) 
                         VALUES (?, ?, ?)";
            $voter_stmt = $pdo->prepare($voter_sql);
            $voter_stmt->execute([
                $input['voter_info']['is_registered'] ?? 0,
                $input['voter_info']['precinct_number'] ?? null,
                $resident_id
            ]);
        }
        
        $pdo->commit();
        echo json_encode(['success' => true, 'resident_id' => $resident_id, 'message' => 'Resident added successfully']);
    }
    
} catch(PDOException $e) {
    if (isset($pdo)) {
        $pdo->rollBack();
    }
    http_response_code(500);
    echo json_encode(['success' => false, 'error' => $e->getMessage()]);
}
?>