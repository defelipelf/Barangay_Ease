<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');
header('Access-Control-Allow-Headers: Content-Type');

include '../../config/database.php';

$resident_id = $_GET['id'] ?? null;

try {
    $database = new Database();
    $pdo = $database->getConnection();

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

    $result = [
        'resident' => $resident,
        'health_info' => $health_info ?: null,
        'education_info' => $education_info ?: null,
        'voter_info' => $voter_info ?: null
    ];

    echo json_encode(['success' => true, 'data' => $result]);
    
} catch(PDOException $e) {
    http_response_code(500);
    echo json_encode(['success' => false, 'error' => $e->getMessage()]);
}
?>