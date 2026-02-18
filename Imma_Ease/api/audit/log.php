<?php
// WORKING AUDIT LOG.PHP - Copy this exactly

// Turn off error display (prevents HTML errors breaking JSON)
ini_set('display_errors', 0);
error_reporting(0);

// Set JSON header FIRST
header('Content-Type: application/json');

try {
    // Get database connection
    require_once '../../config/database.php';
    $db = getPDO();
    
    // Get POST data
    $input = json_decode(file_get_contents('php://input'), true);
    
    // Set defaults if missing
    $user_id = $input['user_id'] ?? null;
    $username = $input['username'] ?? 'unknown';
    $action = $input['action'] ?? 'unknown_action';
    $module = $input['module'] ?? 'unknown_module';
    $details = isset($input['details']) ? json_encode($input['details']) : null;
    $ip = $_SERVER['REMOTE_ADDR'] ?? '0.0.0.0';
    
    // Insert into database
    $sql = "INSERT INTO audit_logs (user_id, username, action, module, details, ip_address) 
            VALUES (?, ?, ?, ?, ?, ?)";
    
    $stmt = $db->prepare($sql);
    $stmt->execute([$user_id, $username, $action, $module, $details, $ip]);
    
    // Return success
    echo json_encode([
        'success' => true,
        'message' => 'Log saved',
        'id' => $db->lastInsertId()
    ]);
    
} catch (Exception $e) {
    // Return error as JSON
    echo json_encode([
        'success' => false,
        'error' => $e->getMessage()
    ]);
}
?>