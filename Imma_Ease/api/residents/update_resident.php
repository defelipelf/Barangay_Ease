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
    
    if ($_SERVER['REQUEST_METHOD'] === 'PUT') {
        $pdo->beginTransaction();
        
        // Update resident
        $sql = "UPDATE residents SET 
                first_name = ?, middle_name = ?, last_name = ?, birth_date = ?, sex = ?, 
                civil_status = ?, contact_number = ?, house_no = ?, street = ?, 
                is_pwd = ?, is_senior = ?, is_solo_parent = ?, is_4ps = ? 
                WHERE resident_id = ?";
        
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
            $input['is_4ps'],
            $input['resident_id']
        ]);
        
        $resident_id = $input['resident_id'];
        
        // Update or insert health info
        if (isset($input['health_info'])) {
            // Check if health info already exists
            $check_health = $pdo->prepare("SELECT health_id FROM health_info WHERE resident_id = ?");
            $check_health->execute([$resident_id]);
            
            if ($check_health->rowCount() > 0) {
                // Update existing health info
                $health_sql = "UPDATE health_info SET 
                              blood_type = ?, known_allergies = ?, pre_existing_conditions = ?, 
                              emergency_contact_name = ?, emergency_contact_number = ?, vaccination_status = ?
                              WHERE resident_id = ?";
            } else {
                // Insert new health info
                $health_sql = "INSERT INTO health_info (blood_type, known_allergies, pre_existing_conditions, 
                              emergency_contact_name, emergency_contact_number, vaccination_status, resident_id) 
                              VALUES (?, ?, ?, ?, ?, ?, ?)";
            }
            
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
        
        // Update or insert education & employment info
        if (isset($input['education_info'])) {
            // Check if education info already exists
            $check_edu = $pdo->prepare("SELECT edu_emp_id FROM education_employment WHERE resident_id = ?");
            $check_edu->execute([$resident_id]);
            
            if ($check_edu->rowCount() > 0) {
                // Update existing education info
                $edu_sql = "UPDATE education_employment SET 
                           highest_education = ?, employment_status = ?, occupation = ?
                           WHERE resident_id = ?";
            } else {
                // Insert new education info
                $edu_sql = "INSERT INTO education_employment (highest_education, employment_status, occupation, resident_id) 
                           VALUES (?, ?, ?, ?)";
            }
            
            $edu_stmt = $pdo->prepare($edu_sql);
            $edu_stmt->execute([
                $input['education_info']['highest_education'] ?? null,
                $input['education_info']['employment_status'] ?? null,
                $input['education_info']['occupation'] ?? null,
                $resident_id
            ]);
        }
        
        // Update or insert voter info
        if (isset($input['voter_info'])) {
            // Check if voter info already exists
            $check_voter = $pdo->prepare("SELECT voter_id FROM voter_info WHERE resident_id = ?");
            $check_voter->execute([$resident_id]);
            
            if ($check_voter->rowCount() > 0) {
                // Update existing voter info
                $voter_sql = "UPDATE voter_info SET 
                             is_registered = ?, precinct_number = ?
                             WHERE resident_id = ?";
            } else {
                // Insert new voter info
                $voter_sql = "INSERT INTO voter_info (is_registered, precinct_number, resident_id) 
                             VALUES (?, ?, ?)";
            }
            
            $voter_stmt = $pdo->prepare($voter_sql);
            $voter_stmt->execute([
                $input['voter_info']['is_registered'] ?? 0,
                $input['voter_info']['precinct_number'] ?? null,
                $resident_id
            ]);
        }
        
        $pdo->commit();
        echo json_encode(['success' => true, 'message' => 'Resident updated successfully']);
    }
    
} catch(PDOException $e) {
    $pdo->rollBack();
    http_response_code(500);
    echo json_encode(['success' => false, 'error' => $e->getMessage()]);
}
?>