<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');
header('Access-Control-Allow-Headers: Content-Type');

include __DIR__ . '/../../config/database.php';

$resident_id = $_GET['resident_id'] ?? null;

try {
    $database = new Database();
    $pdo = $database->getConnection();
    
    if ($resident_id) {
        // Get resident basic info
        $stmt = $pdo->prepare("SELECT * FROM residents WHERE resident_id = ?");
        $stmt->execute([$resident_id]);
        $resident = $stmt->fetch(PDO::FETCH_ASSOC);

        // Get health info
        $health_stmt = $pdo->prepare("SELECT * FROM health_info WHERE resident_id = ?");
        $health_stmt->execute([$resident_id]);
        $health_info = $health_stmt->fetch(PDO::FETCH_ASSOC);

        // Get education info
        $edu_stmt = $pdo->prepare("SELECT * FROM education_employment WHERE resident_id = ?");
        $edu_stmt->execute([$resident_id]);
        $education_info = $edu_stmt->fetch(PDO::FETCH_ASSOC);

        // Get voter info
        $voter_stmt = $pdo->prepare("SELECT * FROM voter_info WHERE resident_id = ?");
        $voter_stmt->execute([$resident_id]);
        $voter_info = $voter_stmt->fetch(PDO::FETCH_ASSOC);

        // Calculate age
        $birth_date = new DateTime($resident['birth_date']);
        $today = new DateTime();
        $age = $today->diff($birth_date)->y;

        // Format data for documents
        $document_data = [
            'resident_id' => $resident['resident_id'],
            'full_name' => trim($resident['first_name'] . ' ' . ($resident['middle_name'] ? $resident['middle_name'] . ' ' : '') . $resident['last_name']),
            'first_name' => $resident['first_name'],
            'middle_name' => $resident['middle_name'],
            'last_name' => $resident['last_name'],
            'birth_date' => $resident['birth_date'],
            'formatted_birth_date' => date('F d, Y', strtotime($resident['birth_date'])),
            'age' => $age,
            'sex' => $resident['sex'],
            'civil_status' => $resident['civil_status'],
            'contact_number' => $resident['contact_number'],
            'address' => $resident['house_no'] . ' ' . $resident['street'] . ', Barangay Immaculate',
            'house_no' => $resident['house_no'],
            'street' => $resident['street'],
            'is_pwd' => $resident['is_pwd'],
            'is_senior' => $resident['is_senior'],
            'is_solo_parent' => $resident['is_solo_parent'],
            'is_4ps' => $resident['is_4ps'],
            'blood_type' => $health_info['blood_type'] ?? 'N/A',
            'occupation' => $education_info['occupation'] ?? 'N/A',
            'employment_status' => $education_info['employment_status'] ?? 'N/A',
            'highest_education' => $education_info['highest_education'] ?? 'N/A',
            'is_registered_voter' => $voter_info['is_registered'] ?? 0,
            'precinct_number' => $voter_info['precinct_number'] ?? 'N/A',
            'date_issued' => date('F d, Y'),
            'current_year' => date('Y')
        ];

        echo json_encode(['success' => true, 'data' => $document_data]);
    } else {
        echo json_encode(['success' => false, 'error' => 'Resident ID is required']);
    }
    
} catch(PDOException $e) {
    http_response_code(500);
    echo json_encode(['success' => false, 'error' => $e->getMessage()]);
}
?>