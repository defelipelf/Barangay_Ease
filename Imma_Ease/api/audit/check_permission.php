<?php
// check_permission.php - Check if user has audit access

header('Content-Type: application/json');

// Database connection
require_once '../../config/database.php';
$db = getPDO();

// Get user_id from request
$user_id = isset($_GET['user_id']) ? (int)$_GET['user_id'] : 0;

if (!$user_id) {
    echo json_encode(['success' => false, 'error' => 'User ID required']);
    exit;
}

try {
    // Check if user exists and is not super_admin (super_admin always has access)
    $stmt = $db->prepare("SELECT role FROM users WHERE id = ?");
    $stmt->execute([$user_id]);
    $user = $stmt->fetch(PDO::FETCH_ASSOC);
    
    if (!$user) {
        echo json_encode(['success' => false, 'error' => 'User not found']);
        exit;
    }
    
    // Super admin always has access
    if ($user['role'] === 'super_admin') {
        echo json_encode([
            'success' => true,
            'has_permission' => true,
            'access_level' => 'FULL',
            'is_super_admin' => true
        ]);
        exit;
    }
    
    // Check audit_permissions table
    $stmt = $db->prepare("
        SELECT * FROM audit_permissions 
        WHERE user_id = ? AND is_active = 1 
        AND (expires_at IS NULL OR expires_at > NOW())
    ");
    $stmt->execute([$user_id]);
    $permission = $stmt->fetch(PDO::FETCH_ASSOC);
    
    echo json_encode([
        'success' => true,
        'has_permission' => $permission ? true : false,
        'access_level' => $permission ? $permission['access_level'] : null,
        'expires_at' => $permission ? $permission['expires_at'] : null
    ]);
    
} catch (Exception $e) {
    echo json_encode(['success' => false, 'error' => $e->getMessage()]);
}
?>