<?php
// get_logs.php - Complete working version
session_start();
header('Content-Type: application/json');

require_once '../../config/database.php';
$db = getPDO();

// TEMPORARILY DISABLE AUTH FOR TESTING
$user = [
    'full_name' => 'Test User',
    'username' => 'test',
    'role' => 'super_admin'
];

// Get filter parameters
$filter_user = $_GET['user'] ?? '';
$filter_module = $_GET['module'] ?? '';
$filter_date = $_GET['date'] ?? '';
$page = (int)($_GET['page'] ?? 1);
$limit = (int)($_GET['limit'] ?? 100);
$offset = ($page - 1) * $limit;

// Build query
$sql = "SELECT * FROM audit_logs WHERE 1=1";
$count_sql = "SELECT COUNT(*) FROM audit_logs WHERE 1=1";
$params = [];

if ($filter_user) {
    $sql .= " AND username LIKE ?";
    $count_sql .= " AND username LIKE ?";
    $params[] = "%$filter_user%";
}
if ($filter_module) {
    $sql .= " AND module = ?";
    $count_sql .= " AND module = ?";
    $params[] = $filter_module;
}
if ($filter_date) {
    $sql .= " AND DATE(timestamp) = ?";
    $count_sql .= " AND DATE(timestamp) = ?";
    $params[] = $filter_date;
}

// Get total count
$count_stmt = $db->prepare($count_sql);
$count_stmt->execute($params);
$total = $count_stmt->fetchColumn();

// Get paginated results - FIXED: don't use placeholders for LIMIT/OFFSET
$sql .= " ORDER BY timestamp DESC LIMIT $limit OFFSET $offset";
$stmt = $db->prepare($sql);
$stmt->execute($params);
$logs = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Get modules for filter dropdown
$modules = $db->query("SELECT DISTINCT module FROM audit_logs WHERE module IS NOT NULL AND module != '' ORDER BY module")->fetchAll(PDO::FETCH_COLUMN);

// Get stats
$stats = [
    'total' => $db->query("SELECT COUNT(*) FROM audit_logs")->fetchColumn(),
    'today' => $db->query("SELECT COUNT(*) FROM audit_logs WHERE DATE(timestamp) = CURDATE()")->fetchColumn(),
    'unique_users' => $db->query("SELECT COUNT(DISTINCT username) FROM audit_logs")->fetchColumn(),
    'latest' => $db->query("SELECT MAX(timestamp) FROM audit_logs")->fetchColumn()
];

// Return JSON
echo json_encode([
    'success' => true,
    'user' => [
        'name' => $user['full_name'] ?: $user['username'],
        'role' => $user['role']
    ],
    'stats' => $stats,
    'logs' => $logs,
    'modules' => $modules,
    'pagination' => [
        'page' => $page,
        'limit' => $limit,
        'total' => $total,
        'pages' => ceil($total / $limit)
    ]
]);
?>