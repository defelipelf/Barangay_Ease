<?php
// get_permissions.php - Get all audit permissions

header('Content-Type: application/json');

// Database connection
require_once '../../config/database.php';
$db = getPDO();

try {
    // Get all active permissions with user info
    $stmt = $db->query("
        SELECT 
            ap.*,
            u.username,
            u.full_name,
            u.role,
            granter.username as granted_by_username
        FROM audit_permissions ap
        JOIN users u ON ap.user_id = u.id
        LEFT JOIN users granter ON ap.granted_by = granter.id
        WHERE ap.is_active = 1
        ORDER BY ap.granted_at DESC
    ");
    
    $permissions = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    echo json_encode([
        'success' => true,
        'data' => $permissions
    ]);
    
} catch (Exception $e) {
    echo json_encode(['success' => false, 'error' => $e->getMessage()]);
}
?>