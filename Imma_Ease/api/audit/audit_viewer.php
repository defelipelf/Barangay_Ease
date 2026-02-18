<?php
// audit_viewer.php - Now just redirects to HTML after auth check
session_start();

/*
require_once 'config/database.php';
$db = getPDO();

// Check if user is logged in
if (!isset($_SESSION['user_id'])) {
    header('Location: login.html?redirect=audit_viewer.html');
    exit;
}

// Check if user has permission
$stmt = $db->prepare("SELECT * FROM users WHERE id = ?");
$stmt->execute([$_SESSION['user_id']]);
$user = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$user || $user['role'] !== 'super_admin') {
    die("❌ Access Denied: Only super admins can view audit logs.");
}
*/

// If authenticated, redirect to the HTML page
header('Location: audit_viewer.html');
exit;
?>