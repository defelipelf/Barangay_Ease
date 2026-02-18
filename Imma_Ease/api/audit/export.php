<?php
// /Imma_Ease/api/audit/export.php
session_start();
error_reporting(E_ALL);
ini_set('display_errors', 1);

header('Content-Type: text/csv; charset=utf-8');
header('Content-Disposition: attachment; filename=audit_logs_' . date('Y-m-d_H-i-s') . '.csv');

// Create output stream
$output = fopen('php://output', 'w');

// Simplified headers (removed IP Address)
fputcsv($output, ['Log ID', 'Timestamp', 'User', 'Action', 'Module', 'Details']);

// Build query with filters
require_once '../../config/database.php';

// Create database instance and get connection
$database = new Database();
$db = $database->getConnection();

if (!$db) {
    fputcsv($output, ['Error: Database connection failed']);
    fclose($output);
    exit;
}

$where = ["1=1"];
$params = [];

if (!empty($_GET['user'])) {
    $where[] = "username LIKE ?";
    $params[] = "%" . $_GET['user'] . "%";
}
if (!empty($_GET['module'])) {
    $where[] = "module = ?";
    $params[] = $_GET['module'];
}
if (!empty($_GET['date'])) {
    $where[] = "DATE(timestamp) = ?";
    $params[] = $_GET['date'];
}

// Simple query - assuming username is directly in audit_logs table
// This avoids any JOIN issues
$sql = "SELECT log_id, timestamp, username, action, module, details 
        FROM audit_logs 
        WHERE " . implode(" AND ", $where) . "
        ORDER BY timestamp DESC";

try {
    $stmt = $db->prepare($sql);
    $stmt->execute($params);
    
    $rowCount = 0;
    
    // Write data rows
    while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
        $rowCount++;
        
        // Clean details for CSV
        $details = $row['details'] ?? '-';
        if ($details && $details !== '-') {
            // If it's JSON, format it nicely
            if (is_string($details) && isJson($details)) {
                $details = json_encode(json_decode($details), JSON_PRETTY_PRINT);
                // Remove line breaks for CSV
                $details = str_replace(["\r", "\n"], ' ', $details);
            }
        }
        
        fputcsv($output, [
            $row['log_id'],
            $row['timestamp'],
            $row['username'] ?? 'system',
            $row['action'] ?? 'N/A',
            $row['module'] ?? 'N/A',
            $details
        ]);
    }
    
    // If no rows found, add a message
    if ($rowCount === 0) {
        fputcsv($output, ['No logs found matching the criteria']);
    }
    
} catch (PDOException $e) {
    // If the simple query fails, let's try to see what columns exist
    fputcsv($output, ['Error: ' . $e->getMessage()]);
    
    // Debug: Show table structure
    try {
        $stmt = $db->query("DESCRIBE audit_logs");
        $columns = $stmt->fetchAll(PDO::FETCH_COLUMN);
        fputcsv($output, ['Available columns in audit_logs:', implode(', ', $columns)]);
    } catch (Exception $ex) {
        fputcsv($output, ['Could not get table structure']);
    }
}

fclose($output);

function isJson($string) {
    json_decode($string);
    return (json_last_error() == JSON_ERROR_NONE);
}
?>