<?php
// grant_access.php - Grant audit access to staff

header('Content-Type: application/json');

// Database connection
require_once '../../config/database.php';
$db = getPDO();

// Get POST data
$data = json_decode(file_get_contents('php://input'), true);

$user_id = $data['user_id'] ?? 0;
$access_level = $data['access_level'] ?? 'VIEW_ONLY';
$expires_at = $data['expires_at'] ?? null;
$reason = $data['reason'] ?? '';
$granted_by = $data['granted_by'] ?? 0;

if (!$user_id || !$granted_by) {
    echo json_encode(['success' => false, 'error' => 'Missing required fields']);
    exit;
}

try {
    // Check if user exists and is staff
    $stmt = $db->prepare("SELECT role FROM users WHERE id = ?");
    $stmt->execute([$user_id]);
    $user = $stmt->fetch(PDO::FETCH_ASSOC);
    
    if (!$user) {
        echo json_encode(['success' => false, 'error' => 'User not found']);
        exit;
    }
    
    // Don't grant to super_admin (they already have access)
    if ($user['role'] === 'super_admin') {
        echo json_encode(['success' => false, 'error' => 'Super admin already has access']);
        exit;
    }
    
    // Check if permission already exists
    $stmt = $db->prepare("SELECT permission_id FROM audit_permissions WHERE user_id = ?");
    $stmt->execute([$user_id]);
    $existing = $stmt->fetch(PDO::FETCH_ASSOC);
    
    if ($existing) {
        // Update existing permission
        $stmt = $db->prepare("
            UPDATE audit_permissions 
            SET access_level = ?, expires_at = ?, is_active = 1, granted_by = ?, granted_at = NOW(), notes = ?
            WHERE user_id = ?
        ");
        $stmt->execute([$access_level, $expires_at, $granted_by, $reason, $user_id]);
    } else {
        // Insert new permission
        $stmt = $db->prepare("
            INSERT INTO audit_permissions (user_id, granted_by, access_level, expires_at, notes, is_active)
            VALUES (?, ?, ?, ?, ?, 1)
        ");
        $stmt->execute([$user_id, $granted_by, $access_level, $expires_at, $reason]);
    }
    
    // Log this action in audit_logs
    $stmt = $db->prepare("
        INSERT INTO audit_logs (user_id, username, action, module, details, ip_address)
        VALUES (?, ?, ?, ?, ?, ?)
    ");
    
    // Get granter info
    $stmt2 = $db->prepare("SELECT username FROM users WHERE id = ?");
    $stmt2->execute([$granted_by]);
    $granter = $stmt2->fetch(PDO::FETCH_ASSOC);
    
    // Get user info
    $stmt2 = $db->prepare("SELECT username FROM users WHERE id = ?");
    $stmt2->execute([$user_id]);
    $target = $stmt2->fetch(PDO::FETCH_ASSOC);
    
    $details = json_encode([
        'target_user_id' => $user_id,
        'target_username' => $target['username'],
        'access_level' => $access_level,
        'expires_at' => $expires_at,
        'reason' => $reason
    ]);
    
    $stmt->execute([
        $granted_by,
        $granter['username'],
        'GRANT_AUDIT_ACCESS',
        'AUDIT',
        $details,
        $_SERVER['REMOTE_ADDR'] ?? '127.0.0.1'
    ]);
    
    echo json_encode(['success' => true, 'message' => 'Audit access granted successfully']);
    
} catch (Exception $e) {
    echo json_encode(['success' => false, 'error' => $e->getMessage()]);
}
?>