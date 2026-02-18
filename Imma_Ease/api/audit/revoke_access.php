<?php
// revoke_access.php - Revoke audit access from staff

header('Content-Type: application/json');

// Database connection
require_once '../../config/database.php';
$db = getPDO();

// Get POST data
$data = json_decode(file_get_contents('php://input'), true);

$user_id = $data['user_id'] ?? 0;
$revoked_by = $data['revoked_by'] ?? 0;

if (!$user_id || !$revoked_by) {
    echo json_encode(['success' => false, 'error' => 'Missing required fields']);
    exit;
}

try {
    // Update permission to inactive
    $stmt = $db->prepare("UPDATE audit_permissions SET is_active = 0 WHERE user_id = ?");
    $stmt->execute([$user_id]);
    
    // Log this action in audit_logs
    $stmt = $db->prepare("
        INSERT INTO audit_logs (user_id, username, action, module, details, ip_address)
        VALUES (?, ?, ?, ?, ?, ?)
    ");
    
    // Get revoker info
    $stmt2 = $db->prepare("SELECT username FROM users WHERE id = ?");
    $stmt2->execute([$revoked_by]);
    $revoker = $stmt2->fetch(PDO::FETCH_ASSOC);
    
    // Get user info
    $stmt2 = $db->prepare("SELECT username FROM users WHERE id = ?");
    $stmt2->execute([$user_id]);
    $target = $stmt2->fetch(PDO::FETCH_ASSOC);
    
    $details = json_encode([
        'target_user_id' => $user_id,
        'target_username' => $target['username']
    ]);
    
    $stmt->execute([
        $revoked_by,
        $revoker['username'],
        'REVOKE_AUDIT_ACCESS',
        'AUDIT',
        $details,
        $_SERVER['REMOTE_ADDR'] ?? '127.0.0.1'
    ]);
    
    echo json_encode(['success' => true, 'message' => 'Audit access revoked successfully']);
    
} catch (Exception $e) {
    echo json_encode(['success' => false, 'error' => $e->getMessage()]);
}
?>