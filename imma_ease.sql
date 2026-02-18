-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 18, 2026 at 03:20 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `imma_ease`
--

-- --------------------------------------------------------

--
-- Table structure for table `audit_logs`
--

CREATE TABLE `audit_logs` (
  `log_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `action` varchar(100) DEFAULT NULL,
  `module` varchar(50) DEFAULT NULL,
  `details` text DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `timestamp` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `audit_logs`
--

INSERT INTO `audit_logs` (`log_id`, `user_id`, `username`, `action`, `module`, `details`, `ip_address`, `timestamp`) VALUES
(1, NULL, 'test_user', 'TEST_ENTRY', 'AUDIT', 'This is a test log entry', '127.0.0.1', '2026-02-16 14:25:31'),
(2, NULL, 'unknown', 'unknown_action', 'unknown_module', NULL, '127.0.0.1', '2026-02-16 14:42:14'),
(3, 1, 'test_user', 'CREATE_RESIDENT', 'RESIDENT', '{\"resident_id\":123,\"name\":\"Juan Dela Cruz\",\"address\":\"123 Manila St.\"}', '127.0.0.1', '2026-02-16 14:43:14'),
(4, 1, 'test_user', 'APPROVE_RESERVATION', 'RESERVATION', '{\"reservation_id\":456,\"facility\":\"Basketball Court\",\"date\":\"2026-02-16\"}', '127.0.0.1', '2026-02-16 14:43:27'),
(5, 1, 'test_user', 'GENERATE_DOCUMENT', 'DOCUMENT', '{\"document_id\":789,\"type\":\"Barangay Clearance\",\"resident\":\"Maria Santos\"}', '127.0.0.1', '2026-02-16 14:43:28'),
(6, 1, 'test_user', 'CREATE_USER', 'USER', '{\"user_id\":10,\"username\":\"newstaff\",\"role\":\"staff\"}', '127.0.0.1', '2026-02-16 14:43:28'),
(7, 3, 'adminlance', 'TEST', 'DEBUG', '{\"message\":\"Testing from profiling\"}', '127.0.0.1', '2026-02-16 15:55:36'),
(8, 3, 'adminlance', 'CREATE_RESIDENT', 'RESIDENT', '{\"resident_id\":\"\",\"name\":\"fafdaf adfasfaf\",\"address\":\"44 Denver\"}', '127.0.0.1', '2026-02-16 16:01:03'),
(9, 3, 'adminlance', 'CREATE_RESERVATION', 'RESERVATION', '{\"facility\":\"Basketball Court 3\",\"resident\":\"Karl Ebarle\",\"date\":\"2026-02-17\",\"time\":\"08:00 - 09:00\",\"purpose\":\"Basketball\"}', '127.0.0.1', '2026-02-16 16:23:46'),
(10, 3, 'adminlance', 'DELETE_RESERVATION', 'RESERVATION', '{\"reservation_id\":36,\"facility\":\"Basketball Court 3\",\"resident\":\"Karl Ebarle\",\"date\":\"2026-02-17\",\"deleted_by\":\"adminlance\"}', '127.0.0.1', '2026-02-16 16:23:59'),
(11, 3, 'adminlance', 'APPROVED_RESERVATION', 'RESERVATION', '{\"reservation_id\":33,\"facility\":\"Basketball Court 2\",\"resident\":\"Zed Villanueva\",\"date\":\"2026-02-17\",\"approved_by\":\"adminlance\"}', '127.0.0.1', '2026-02-16 16:24:05'),
(12, 11, 'test', 'GENERATE_DOCUMENT', 'DOCUMENT', '{\"document_type\":\"Certificate of Indigency\",\"document_code\":\"indigency_certificate\",\"resident_id\":7,\"resident_name\":\"Zed Villanueva\",\"purpose\":\"School\",\"years_residing\":\"N\\/A\",\"filename\":\"certificate_of_indigency_villanueva_1771230887063.pdf\"}', '127.0.0.1', '2026-02-16 16:34:47'),
(13, 11, 'test', 'PRINT_DOCUMENT', 'DOCUMENT', '{\"document_type\":\"Certificate of Indigency\",\"resident_name\":\"Zed Villanueva\"}', '127.0.0.1', '2026-02-16 16:34:54'),
(14, 11, 'test', 'DOWNLOAD_PDF', 'DOCUMENT', '{\"document_type\":\"Certificate of Indigency\",\"resident_name\":\"Zed Villanueva\",\"filename\":\"certificate_of_indigency_villanueva_1771230907609.pdf\"}', '127.0.0.1', '2026-02-16 16:35:07'),
(15, 11, 'test', 'UPDATE_USER', 'USER', '{\"user_id\":\"10\",\"username\":\"adminzed\",\"full_name\":\"Zed Villanueva\",\"role\":\"admin\",\"is_active\":false,\"changed_by\":\"test\"}', '127.0.0.1', '2026-02-16 16:41:22'),
(16, 11, 'test', 'UPDATE_USER', 'USER', '{\"user_id\":\"10\",\"username\":\"adminzed\",\"full_name\":\"Zed Villanueva\",\"role\":\"admin\",\"is_active\":true,\"changed_by\":\"test\"}', '127.0.0.1', '2026-02-16 16:41:36'),
(17, 11, 'test', 'CREATE_USER', 'USER', '{\"user_id\":\"\",\"username\":\"ronielyn\",\"full_name\":\"Ronielyn Mayonado\",\"role\":\"super_admin\",\"is_active\":true,\"changed_by\":\"test\"}', '127.0.0.1', '2026-02-16 16:42:33'),
(18, 3, 'adminlance', 'LOGIN_SUCCESS', 'AUTH', '{\"username\":\"adminlance\",\"user_id\":3,\"user_role\":\"super_admin\",\"ip_address\":\"112.203.161.29\",\"user_agent\":\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/143.0.0.0 Safari\\/537.36 OPR\\/127.0.0.0\"}', '127.0.0.1', '2026-02-16 16:46:15'),
(19, NULL, 'system', 'LOGIN_FAILED', 'AUTH', '{\"username\":\"asdfasf\",\"reason\":\"Invalid username or password\",\"ip_address\":\"112.203.161.29\",\"user_agent\":\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/143.0.0.0 Safari\\/537.36 OPR\\/127.0.0.0\"}', '127.0.0.1', '2026-02-16 16:46:29'),
(20, NULL, 'system', 'LOGIN_FAILED', 'AUTH', '{\"username\":\"adminlance\",\"reason\":\"Invalid username or password\",\"ip_address\":\"112.203.161.29\",\"user_agent\":\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/143.0.0.0 Safari\\/537.36 OPR\\/127.0.0.0\"}', '127.0.0.1', '2026-02-16 16:46:41'),
(21, 3, 'adminlance', 'LOGIN_SUCCESS', 'AUTH', '{\"username\":\"adminlance\",\"user_id\":3,\"user_role\":\"super_admin\",\"ip_address\":\"112.203.161.29\",\"user_agent\":\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/143.0.0.0 Safari\\/537.36 OPR\\/127.0.0.0\"}', '127.0.0.1', '2026-02-16 16:46:55'),
(22, NULL, 'system', 'LOGIN_FAILED', 'AUTH', '{\"username\":\"adminlance\",\"reason\":\"Invalid username or password\",\"ip_address\":\"112.203.161.29\",\"user_agent\":\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/143.0.0.0 Safari\\/537.36 OPR\\/127.0.0.0\"}', '127.0.0.1', '2026-02-16 16:47:33'),
(23, 3, 'adminlance', 'LOGIN_SUCCESS', 'AUTH', '{\"username\":\"adminlance\",\"user_id\":3,\"user_role\":\"super_admin\",\"ip_address\":\"112.203.161.29\",\"user_agent\":\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/143.0.0.0 Safari\\/537.36 OPR\\/127.0.0.0\"}', '127.0.0.1', '2026-02-16 16:47:56'),
(24, 3, 'adminlance', 'CREATE_RESERVATION', 'RESERVATION', '{\"facility\":\"Basketball Court 3\",\"resident\":\"Don Alba\",\"date\":\"2026-02-17\",\"time\":\"08:00 - 09:00\",\"purpose\":\"kakain\"}', '127.0.0.1', '2026-02-16 16:48:13'),
(25, 3, 'adminlance', 'DELETE_RESERVATION', 'RESERVATION', '{\"reservation_id\":37,\"facility\":\"Basketball Court 3\",\"resident\":\"Don Alba\",\"date\":\"2026-02-17\",\"deleted_by\":\"adminlance\"}', '127.0.0.1', '2026-02-16 16:48:53'),
(26, 3, 'adminlance', 'CREATE_RESIDENT', 'RESIDENT', '{\"resident_id\":\"\",\"name\":\"James Garden\",\"address\":\"34 Miami\"}', '127.0.0.1', '2026-02-16 16:49:40'),
(27, 3, 'adminlance', 'CREATE_RESIDENT', 'RESIDENT', '{\"resident_id\":\"6\",\"name\":\"Gabriel Paolo Adducul\",\"address\":\"67-a Felix Manalo\"}', '127.0.0.1', '2026-02-16 16:49:59'),
(28, 3, 'adminlance', 'CREATE_RESIDENT', 'RESIDENT', '{\"resident_id\":\"6\",\"name\":\"Gabriel Paolo Adducul\",\"address\":\"67-a Felix Manalo\"}', '127.0.0.1', '2026-02-16 16:50:13'),
(29, 3, 'adminlance', 'GENERATE_DOCUMENT', 'DOCUMENT', '{\"document_type\":\"Certificate of Indigency\",\"document_code\":\"indigency_certificate\",\"resident_id\":13,\"resident_name\":\"Don Alba\",\"purpose\":\"School\",\"years_residing\":\"N\\/A\",\"filename\":\"certificate_of_indigency_alba_1771231835926.pdf\"}', '127.0.0.1', '2026-02-16 16:50:35'),
(30, 3, 'adminlance', 'DOWNLOAD_PDF', 'DOCUMENT', '{\"document_type\":\"Certificate of Indigency\",\"resident_name\":\"Don Alba\",\"filename\":\"certificate_of_indigency_alba_1771231841629.pdf\"}', '127.0.0.1', '2026-02-16 16:50:41'),
(31, 3, 'adminlance', 'CREATE_USER', 'USER', '{\"user_id\":\"\",\"username\":\"don\",\"full_name\":\"Don Alba\",\"role\":\"admin\",\"is_active\":true,\"changed_by\":\"adminlance\"}', '127.0.0.1', '2026-02-16 16:51:07'),
(32, 3, 'adminlance', 'UPDATE_USER', 'USER', '{\"user_id\":\"13\",\"username\":\"don\",\"full_name\":\"Don Alba\",\"role\":\"super_admin\",\"is_active\":true,\"changed_by\":\"adminlance\"}', '127.0.0.1', '2026-02-16 16:51:18'),
(33, 3, 'adminlance', 'UPDATE_USER', 'USER', '{\"user_id\":\"13\",\"username\":\"don\",\"full_name\":\"Don Alba\",\"role\":\"admin\",\"is_active\":true,\"changed_by\":\"adminlance\"}', '127.0.0.1', '2026-02-16 16:51:33'),
(34, 3, 'adminlance', 'LOGOUT', 'AUTH', '{\"username\":\"adminlance\",\"user_id\":3}', '127.0.0.1', '2026-02-16 16:59:33'),
(35, 13, 'don', 'LOGIN_SUCCESS', 'AUTH', '{\"username\":\"don\",\"user_id\":13,\"user_role\":\"admin\",\"ip_address\":\"112.203.161.29\",\"user_agent\":\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/143.0.0.0 Safari\\/537.36 OPR\\/127.0.0.0\"}', '127.0.0.1', '2026-02-16 16:59:38'),
(36, 13, 'don', 'LOGOUT', 'AUTH', '{\"username\":\"don\",\"user_id\":13}', '127.0.0.1', '2026-02-16 17:00:06'),
(37, 3, 'adminlance', 'LOGIN_SUCCESS', 'AUTH', '{\"username\":\"adminlance\",\"user_id\":3,\"user_role\":\"super_admin\",\"ip_address\":\"112.203.161.29\",\"user_agent\":\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/143.0.0.0 Safari\\/537.36 OPR\\/127.0.0.0\"}', '127.0.0.1', '2026-02-16 17:00:11'),
(38, 3, 'adminlance', 'GRANT_AUDIT_ACCESS', 'AUDIT', '{\"target_user_id\":\"13\",\"target_username\":\"don\",\"access_level\":\"VIEW_ONLY\",\"expires_at\":null,\"reason\":\"\"}', '127.0.0.1', '2026-02-16 17:11:25'),
(39, 3, 'adminlance', 'GRANT_AUDIT_ACCESS', 'AUDIT', '{\"user_id\":\"13\",\"access_level\":\"VIEW_ONLY\",\"expires_at\":null,\"reason\":\"\",\"granted_by\":\"adminlance\"}', '127.0.0.1', '2026-02-16 17:11:25'),
(40, 3, 'adminlance', 'LOGOUT', 'AUTH', '{\"username\":\"adminlance\",\"user_id\":3}', '127.0.0.1', '2026-02-16 17:11:38'),
(41, 2, 'staff', 'LOGIN_SUCCESS', 'AUTH', '{\"username\":\"staff\",\"user_id\":2,\"user_role\":\"admin\",\"ip_address\":\"112.203.161.29\",\"user_agent\":\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/143.0.0.0 Safari\\/537.36 OPR\\/127.0.0.0\"}', '127.0.0.1', '2026-02-16 17:11:43'),
(42, 2, 'staff', 'LOGOUT', 'AUTH', '{\"username\":\"staff\",\"user_id\":2}', '127.0.0.1', '2026-02-16 17:11:46'),
(43, 13, 'don', 'LOGIN_SUCCESS', 'AUTH', '{\"username\":\"don\",\"user_id\":13,\"user_role\":\"admin\",\"ip_address\":\"112.203.161.29\",\"user_agent\":\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/143.0.0.0 Safari\\/537.36 OPR\\/127.0.0.0\"}', '127.0.0.1', '2026-02-16 17:11:50'),
(44, 13, 'don', 'LOGOUT', 'AUTH', '{\"username\":\"don\",\"user_id\":13}', '127.0.0.1', '2026-02-16 17:11:58'),
(45, 3, 'adminlance', 'LOGIN_SUCCESS', 'AUTH', '{\"username\":\"adminlance\",\"user_id\":3,\"user_role\":\"super_admin\",\"ip_address\":\"112.203.161.29\",\"user_agent\":\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/143.0.0.0 Safari\\/537.36 OPR\\/127.0.0.0\"}', '127.0.0.1', '2026-02-16 17:12:05'),
(46, 3, 'adminlance', 'GRANT_AUDIT_ACCESS', 'AUDIT', '{\"target_user_id\":\"13\",\"target_username\":\"don\",\"access_level\":\"VIEW_ONLY\",\"expires_at\":null,\"reason\":\"\"}', '127.0.0.1', '2026-02-16 17:12:49'),
(47, 3, 'adminlance', 'GRANT_AUDIT_ACCESS', 'AUDIT', '{\"user_id\":\"13\",\"access_level\":\"VIEW_ONLY\",\"expires_at\":null,\"reason\":\"\",\"granted_by\":\"adminlance\"}', '127.0.0.1', '2026-02-16 17:12:49'),
(48, 3, 'adminlance', 'UPDATE_USER', 'USER', '{\"user_id\":\"13\",\"username\":\"don\",\"full_name\":\"Don Alba\",\"role\":\"admin\",\"is_active\":false,\"changed_by\":\"adminlance\"}', '127.0.0.1', '2026-02-16 17:19:14'),
(49, 3, 'adminlance', 'UPDATE_USER', 'USER', '{\"user_id\":\"13\",\"username\":\"don\",\"full_name\":\"Don Alba\",\"role\":\"admin\",\"is_active\":true,\"changed_by\":\"adminlance\"}', '127.0.0.1', '2026-02-16 17:19:19'),
(50, 3, 'adminlance', 'GRANT_AUDIT_ACCESS', 'AUDIT', '{\"target_user_id\":\"13\",\"target_username\":\"don\",\"access_level\":\"FULL\",\"expires_at\":null,\"reason\":\"\"}', '127.0.0.1', '2026-02-16 17:27:19'),
(51, 3, 'adminlance', 'GRANT_AUDIT_ACCESS', 'AUDIT', '{\"user_id\":\"13\",\"access_level\":\"FULL\",\"expires_at\":null,\"reason\":\"\",\"granted_by\":\"adminlance\"}', '127.0.0.1', '2026-02-16 17:27:19'),
(52, 3, 'adminlance', 'GRANT_AUDIT_ACCESS', 'AUDIT', '{\"target_user_id\":\"13\",\"target_username\":\"don\",\"access_level\":\"VIEW_ONLY\",\"expires_at\":null,\"reason\":\"\"}', '127.0.0.1', '2026-02-16 17:27:22'),
(53, 3, 'adminlance', 'GRANT_AUDIT_ACCESS', 'AUDIT', '{\"user_id\":\"13\",\"access_level\":\"VIEW_ONLY\",\"expires_at\":null,\"reason\":\"\",\"granted_by\":\"adminlance\"}', '127.0.0.1', '2026-02-16 17:27:22'),
(54, 3, 'adminlance', 'LOGOUT', 'AUTH', '{\"username\":\"adminlance\",\"user_id\":3}', '127.0.0.1', '2026-02-16 17:29:01'),
(55, NULL, 'system', 'LOGIN_FAILED', 'AUTH', '{\"username\":\"don\",\"reason\":\"Invalid username or password\",\"ip_address\":\"112.203.161.29\",\"user_agent\":\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/143.0.0.0 Safari\\/537.36 OPR\\/127.0.0.0\"}', '127.0.0.1', '2026-02-16 17:29:05'),
(56, 13, 'don', 'LOGIN_SUCCESS', 'AUTH', '{\"username\":\"don\",\"user_id\":13,\"user_role\":\"admin\",\"ip_address\":\"112.203.161.29\",\"user_agent\":\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/143.0.0.0 Safari\\/537.36 OPR\\/127.0.0.0\"}', '127.0.0.1', '2026-02-16 17:29:09'),
(57, 13, 'don', 'LOGOUT', 'AUTH', '{\"username\":\"don\",\"user_id\":13}', '127.0.0.1', '2026-02-16 17:29:20'),
(58, 3, 'adminlance', 'LOGIN_SUCCESS', 'AUTH', '{\"username\":\"adminlance\",\"user_id\":3,\"user_role\":\"super_admin\",\"ip_address\":\"112.203.161.29\",\"user_agent\":\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/143.0.0.0 Safari\\/537.36 OPR\\/127.0.0.0\"}', '127.0.0.1', '2026-02-16 17:29:25'),
(59, 3, 'adminlance', 'DELETE_USER', 'USER', '{\"user_id\":13,\"username\":\"don\",\"full_name\":\"Don Alba\",\"role\":\"admin\",\"deleted_by\":\"adminlance\"}', '127.0.0.1', '2026-02-16 17:34:15'),
(60, 3, 'adminlance', 'UPDATE_USER', 'USER', '{\"user_id\":\"11\",\"username\":\"test\",\"full_name\":\"test\",\"role\":\"admin\",\"is_active\":true,\"changed_by\":\"adminlance\"}', '127.0.0.1', '2026-02-16 17:34:23'),
(61, 3, 'adminlance', 'GRANT_AUDIT_ACCESS', 'AUDIT', '{\"target_user_id\":\"11\",\"target_username\":\"test\",\"access_level\":\"VIEW_ONLY\",\"expires_at\":\"2026-02-16T17:40\",\"reason\":\"Review\"}', '127.0.0.1', '2026-02-16 17:36:10'),
(62, 3, 'adminlance', 'GRANT_AUDIT_ACCESS', 'AUDIT', '{\"user_id\":\"11\",\"access_level\":\"VIEW_ONLY\",\"expires_at\":\"2026-02-16T17:40\",\"reason\":\"Review\",\"granted_by\":\"adminlance\"}', '127.0.0.1', '2026-02-16 17:36:10'),
(63, NULL, 'system', 'LOGIN_FAILED', 'AUTH', '{\"username\":\"test\",\"reason\":\"Invalid username or password\",\"ip_address\":\"112.203.161.29\",\"user_agent\":\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/143.0.0.0 Safari\\/537.36 OPR\\/127.0.0.0\"}', '127.0.0.1', '2026-02-16 17:37:26'),
(64, 11, 'test', 'LOGIN_SUCCESS', 'AUTH', '{\"username\":\"test\",\"user_id\":11,\"user_role\":\"admin\",\"ip_address\":\"112.203.161.29\",\"user_agent\":\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/143.0.0.0 Safari\\/537.36 OPR\\/127.0.0.0\"}', '127.0.0.1', '2026-02-16 17:37:30'),
(65, 3, 'adminlance', 'REVOKE_AUDIT_ACCESS', 'AUDIT', '{\"target_user_id\":11,\"target_username\":\"test\"}', '127.0.0.1', '2026-02-16 18:02:50'),
(66, 3, 'adminlance', 'REVOKE_AUDIT_ACCESS', 'AUDIT', '{\"user_id\":11,\"revoked_by\":\"adminlance\"}', '127.0.0.1', '2026-02-16 18:02:50'),
(67, 3, 'adminlance', 'GRANT_AUDIT_ACCESS', 'AUDIT', '{\"target_user_id\":11,\"target_username\":\"test\",\"access_level\":\"VIEW_ONLY\",\"expires_at\":null,\"reason\":\"\"}', '127.0.0.1', '2026-02-16 18:03:07'),
(68, 3, 'adminlance', 'GRANT_AUDIT_ACCESS', 'AUDIT', '{\"user_id\":11,\"access_level\":\"VIEW_ONLY\",\"expires_at\":null,\"reason\":\"\",\"granted_by\":\"adminlance\"}', '127.0.0.1', '2026-02-16 18:03:07'),
(69, 3, 'adminlance', 'UPDATE_USER', 'USER', '{\"user_id\":\"11\",\"username\":\"test\",\"full_name\":\"test\",\"role\":\"admin\",\"is_active\":true,\"changed_by\":\"adminlance\"}', '127.0.0.1', '2026-02-16 18:03:09'),
(70, 3, 'adminlance', 'LOGOUT', 'AUTH', '{\"username\":\"adminlance\",\"user_id\":3}', '127.0.0.1', '2026-02-16 18:03:14'),
(71, 3, 'adminlance', 'LOGIN_SUCCESS', 'AUTH', '{\"username\":\"adminlance\",\"user_id\":3,\"user_role\":\"super_admin\",\"ip_address\":\"112.203.161.29\",\"user_agent\":\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/143.0.0.0 Safari\\/537.36 OPR\\/127.0.0.0\"}', '127.0.0.1', '2026-02-16 18:03:28'),
(72, 3, 'adminlance', 'REVOKE_AUDIT_ACCESS', 'AUDIT', '{\"target_user_id\":11,\"target_username\":\"test\"}', '127.0.0.1', '2026-02-16 18:03:45'),
(73, 3, 'adminlance', 'REVOKE_AUDIT_ACCESS', 'AUDIT', '{\"user_id\":11,\"revoked_by\":\"adminlance\"}', '127.0.0.1', '2026-02-16 18:03:45'),
(74, 3, 'adminlance', 'GRANT_AUDIT_ACCESS', 'AUDIT', '{\"target_user_id\":11,\"target_username\":\"test\",\"access_level\":\"VIEW_ONLY\",\"expires_at\":null,\"reason\":\"\"}', '127.0.0.1', '2026-02-16 18:04:05'),
(75, 3, 'adminlance', 'GRANT_AUDIT_ACCESS', 'AUDIT', '{\"user_id\":11,\"access_level\":\"VIEW_ONLY\",\"expires_at\":null,\"reason\":\"\",\"granted_by\":\"adminlance\"}', '127.0.0.1', '2026-02-16 18:04:05'),
(76, 3, 'adminlance', 'UPDATE_USER', 'USER', '{\"user_id\":\"11\",\"username\":\"test\",\"full_name\":\"test\",\"role\":\"admin\",\"is_active\":true,\"changed_by\":\"adminlance\"}', '127.0.0.1', '2026-02-16 18:04:06'),
(77, 3, 'adminlance', 'REVOKE_AUDIT_ACCESS', 'AUDIT', '{\"target_user_id\":11,\"target_username\":\"test\"}', '127.0.0.1', '2026-02-16 18:04:12'),
(78, 3, 'adminlance', 'REVOKE_AUDIT_ACCESS', 'AUDIT', '{\"user_id\":11,\"revoked_by\":\"adminlance\"}', '127.0.0.1', '2026-02-16 18:04:12'),
(79, 3, 'adminlance', 'GRANT_AUDIT_ACCESS', 'AUDIT', '{\"target_user_id\":11,\"target_username\":\"test\",\"access_level\":\"VIEW_ONLY\",\"expires_at\":null,\"reason\":\"\"}', '127.0.0.1', '2026-02-16 18:06:09'),
(80, 3, 'adminlance', 'GRANT_AUDIT_ACCESS', 'AUDIT', '{\"user_id\":11,\"access_level\":\"VIEW_ONLY\",\"expires_at\":null,\"reason\":\"\",\"granted_by\":\"adminlance\"}', '127.0.0.1', '2026-02-16 18:06:09'),
(81, 3, 'adminlance', 'UPDATE_USER', 'USER', '{\"user_id\":\"11\",\"username\":\"test\",\"full_name\":\"test\",\"role\":\"admin\",\"is_active\":true,\"changed_by\":\"adminlance\"}', '127.0.0.1', '2026-02-16 18:06:10'),
(82, 3, 'adminlance', 'REVOKE_AUDIT_ACCESS', 'AUDIT', '{\"target_user_id\":11,\"target_username\":\"test\"}', '127.0.0.1', '2026-02-16 18:06:37'),
(83, 3, 'adminlance', 'REVOKE_AUDIT_ACCESS', 'AUDIT', '{\"user_id\":11,\"revoked_by\":\"adminlance\"}', '127.0.0.1', '2026-02-16 18:06:37'),
(84, 3, 'adminlance', 'GRANT_AUDIT_ACCESS', 'AUDIT', '{\"target_user_id\":11,\"target_username\":\"test\",\"access_level\":\"VIEW_ONLY\",\"expires_at\":null,\"reason\":\"\"}', '127.0.0.1', '2026-02-16 18:08:26'),
(85, 3, 'adminlance', 'GRANT_AUDIT_ACCESS', 'AUDIT', '{\"user_id\":11,\"access_level\":\"VIEW_ONLY\",\"expires_at\":null,\"reason\":\"\",\"granted_by\":\"adminlance\"}', '127.0.0.1', '2026-02-16 18:08:26'),
(86, 3, 'adminlance', 'UPDATE_USER', 'USER', '{\"user_id\":\"11\",\"username\":\"test\",\"full_name\":\"test\",\"role\":\"admin\",\"is_active\":true,\"changed_by\":\"adminlance\"}', '127.0.0.1', '2026-02-16 18:08:32'),
(87, 3, 'adminlance', 'REVOKE_AUDIT_ACCESS', 'AUDIT', '{\"target_user_id\":11,\"target_username\":\"test\"}', '127.0.0.1', '2026-02-16 18:08:40'),
(88, 3, 'adminlance', 'REVOKE_AUDIT_ACCESS', 'AUDIT', '{\"user_id\":11,\"revoked_by\":\"adminlance\"}', '127.0.0.1', '2026-02-16 18:08:40'),
(89, NULL, 'system', 'LOGIN_ERROR', 'AUTH', '{\"username\":\"adminlance\",\"error\":\"Unexpected token \'<\', \\\"<br \\/>\\n<b>\\\"... is not valid JSON\",\"ip_address\":\"112.203.161.29\",\"user_agent\":\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/143.0.0.0 Safari\\/537.36 OPR\\/127.0.0.0\"}', '::1', '2026-02-18 08:43:41'),
(90, 3, 'adminlance', 'LOGIN_ERROR', 'AUTH', '{\"username\":\"adminlance\",\"error\":\"Unexpected token \'<\', \\\"<br \\/>\\n<b>\\\"... is not valid JSON\",\"ip_address\":\"112.203.161.29\",\"user_agent\":\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/143.0.0.0 Safari\\/537.36 OPR\\/127.0.0.0\"}', '127.0.0.1', '2026-02-18 08:45:49'),
(91, 3, 'adminlance', 'LOGIN_ERROR', 'AUTH', '{\"username\":\"adminlance\",\"error\":\"Unexpected token \'<\', \\\"<br \\/>\\n<b>\\\"... is not valid JSON\",\"ip_address\":\"112.203.161.29\",\"user_agent\":\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/143.0.0.0 Safari\\/537.36 OPR\\/127.0.0.0\"}', '127.0.0.1', '2026-02-18 08:45:59'),
(92, 3, 'adminlance', 'LOGIN_FAILED', 'AUTH', '{\"username\":\"adminlance\",\"reason\":\"Invalid username or password\",\"ip_address\":\"112.203.161.29\",\"user_agent\":\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/143.0.0.0 Safari\\/537.36 OPR\\/127.0.0.0\"}', '127.0.0.1', '2026-02-18 08:50:18'),
(93, 3, 'adminlance', 'LOGIN_SUCCESS', 'AUTH', '{\"username\":\"adminlance\",\"user_id\":3,\"user_role\":\"super_admin\",\"ip_address\":\"112.203.161.29\",\"user_agent\":\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/143.0.0.0 Safari\\/537.36 OPR\\/127.0.0.0\"}', '127.0.0.1', '2026-02-18 08:50:25'),
(94, 11, 'test', 'LOGIN_SUCCESS', 'AUTH', '{\"username\":\"test\",\"user_id\":11,\"user_role\":\"admin\",\"ip_address\":\"112.203.161.29\",\"user_agent\":\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/143.0.0.0 Safari\\/537.36 OPR\\/127.0.0.0\"}', '127.0.0.1', '2026-02-18 09:08:02'),
(95, 3, 'adminlance', 'GRANT_AUDIT_ACCESS', 'AUDIT', '{\"target_user_id\":11,\"target_username\":\"test\",\"access_level\":\"VIEW_ONLY\",\"expires_at\":null,\"reason\":\"\"}', '127.0.0.1', '2026-02-18 09:08:10'),
(96, 3, 'adminlance', 'GRANT_AUDIT_ACCESS', 'AUDIT', '{\"user_id\":11,\"access_level\":\"VIEW_ONLY\",\"expires_at\":null,\"reason\":\"\",\"granted_by\":\"adminlance\"}', '127.0.0.1', '2026-02-18 09:08:10'),
(97, 3, 'adminlance', 'UPDATE_USER', 'USER', '{\"user_id\":\"11\",\"username\":\"test\",\"full_name\":\"test\",\"role\":\"admin\",\"is_active\":true,\"changed_by\":\"adminlance\"}', '127.0.0.1', '2026-02-18 09:08:12'),
(98, 3, 'adminlance', 'REVOKE_AUDIT_ACCESS', 'AUDIT', '{\"target_user_id\":11,\"target_username\":\"test\"}', '127.0.0.1', '2026-02-18 09:08:24'),
(99, 3, 'adminlance', 'REVOKE_AUDIT_ACCESS', 'AUDIT', '{\"user_id\":11,\"revoked_by\":\"adminlance\"}', '127.0.0.1', '2026-02-18 09:08:24'),
(100, NULL, 'system', 'LOGIN_FAILED', 'AUTH', '{\"username\":\"adminlance\",\"reason\":\"Invalid username or password\",\"ip_address\":\"112.203.161.29\",\"user_agent\":\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/143.0.0.0 Safari\\/537.36 OPR\\/127.0.0.0\"}', '::1', '2026-02-18 09:59:55'),
(101, 3, 'adminlance', 'LOGIN_SUCCESS', 'AUTH', '{\"username\":\"adminlance\",\"user_id\":3,\"user_role\":\"super_admin\",\"ip_address\":\"112.203.161.29\",\"user_agent\":\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/143.0.0.0 Safari\\/537.36 OPR\\/127.0.0.0\"}', '::1', '2026-02-18 09:59:59');

-- --------------------------------------------------------

--
-- Table structure for table `audit_permissions`
--

CREATE TABLE `audit_permissions` (
  `permission_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `granted_by` int(11) NOT NULL,
  `granted_at` datetime DEFAULT current_timestamp(),
  `expires_at` datetime DEFAULT NULL,
  `access_level` enum('VIEW_ONLY','EXPORT','FULL') DEFAULT 'VIEW_ONLY',
  `is_active` tinyint(1) DEFAULT 1,
  `notes` text DEFAULT NULL,
  `last_accessed` datetime DEFAULT NULL,
  `access_count` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `audit_permissions`
--

INSERT INTO `audit_permissions` (`permission_id`, `user_id`, `granted_by`, `granted_at`, `expires_at`, `access_level`, `is_active`, `notes`, `last_accessed`, `access_count`) VALUES
(2, 11, 3, '2026-02-18 09:08:10', NULL, 'VIEW_ONLY', 0, '', NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `education_employment`
--

CREATE TABLE `education_employment` (
  `edu_emp_id` int(11) NOT NULL,
  `resident_id` int(11) NOT NULL,
  `highest_education` varchar(100) DEFAULT NULL,
  `employment_status` enum('Employed','Unemployed','Student','Retired') DEFAULT NULL,
  `occupation` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `education_employment`
--

INSERT INTO `education_employment` (`edu_emp_id`, `resident_id`, `highest_education`, `employment_status`, `occupation`) VALUES
(3, 3, 'College', 'Employed', 'Office worker'),
(4, 7, 'College', 'Unemployed', ''),
(5, 6, 'College', 'Unemployed', ''),
(6, 8, 'College', 'Unemployed', ''),
(8, 10, 'College', 'Unemployed', ''),
(9, 11, 'College', 'Student', ''),
(10, 12, 'College', 'Student', ''),
(11, 13, 'College', 'Unemployed', ''),
(12, 14, 'College', 'Student', ''),
(13, 15, 'College', 'Student', ''),
(14, 16, 'College', 'Unemployed', ''),
(15, 17, 'College', 'Unemployed', ''),
(18, 20, '', '', ''),
(20, 22, '', '', ''),
(26, 28, '', '', ''),
(30, 33, '', '', ''),
(32, 32, '', '', ''),
(39, 41, '', '', ''),
(40, 42, 'College', 'Student', ''),
(43, 45, '', '', ''),
(44, 46, '', '', ''),
(45, 47, '', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `facilities`
--

CREATE TABLE `facilities` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `max_capacity` int(11) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `facilities`
--

INSERT INTO `facilities` (`id`, `name`, `description`, `max_capacity`, `is_active`, `created_at`) VALUES
(1, 'Basketball Court 1', 'Main basketball court with covered area', 50, 1, '2025-11-21 19:22:13'),
(2, 'Basketball Court 2', 'Secondary basketball court near park', 40, 1, '2025-11-21 19:22:13'),
(3, 'Basketball Court 3', 'Open court near community center', 35, 1, '2025-11-21 19:22:13'),
(4, 'Farmville 1', 'Event area with garden and seating', 100, 1, '2025-11-21 19:22:13'),
(5, 'Farmville 2', 'Multi-purpose gathering space with roof', 80, 1, '2025-11-21 19:22:13');

-- --------------------------------------------------------

--
-- Table structure for table `health_info`
--

CREATE TABLE `health_info` (
  `health_id` int(11) NOT NULL,
  `resident_id` int(11) NOT NULL,
  `blood_type` enum('A+','A-','B+','B-','AB+','AB-','O+','O-') DEFAULT NULL,
  `known_allergies` text DEFAULT NULL,
  `pre_existing_conditions` text DEFAULT NULL,
  `emergency_contact_name` varchar(100) DEFAULT NULL,
  `emergency_contact_number` varchar(20) DEFAULT NULL,
  `vaccination_status` enum('Fully Vaccinated','Partially Vaccinated','Not Vaccinated') DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `health_info`
--

INSERT INTO `health_info` (`health_id`, `resident_id`, `blood_type`, `known_allergies`, `pre_existing_conditions`, `emergency_contact_name`, `emergency_contact_number`, `vaccination_status`, `created_at`, `updated_at`) VALUES
(3, 3, 'B-', '', '', '', '', 'Fully Vaccinated', '2025-11-20 01:28:19', '2025-11-20 02:47:48'),
(4, 7, 'A+', '', '', '', '', 'Fully Vaccinated', '2025-11-21 16:39:43', '2025-11-21 16:39:43'),
(5, 6, 'A+', '', '', '', '', 'Fully Vaccinated', '2025-11-21 16:40:04', '2025-11-21 16:40:04'),
(6, 8, 'B+', 'qwe', 'qwe', 'qwe', '0909093232', 'Fully Vaccinated', '2025-11-21 18:15:11', '2025-11-21 18:15:11'),
(8, 10, 'A-', '', '', '', '', 'Fully Vaccinated', '2025-11-21 20:12:59', '2025-11-21 20:12:59'),
(9, 11, 'AB-', '', '', '', '', 'Fully Vaccinated', '2025-11-21 20:27:06', '2025-11-21 20:27:06'),
(10, 12, '', '', '', '', '', 'Fully Vaccinated', '2025-11-22 13:09:38', '2025-11-22 13:09:38'),
(11, 13, '', '', '', '', '', 'Fully Vaccinated', '2025-11-23 10:55:39', '2025-11-23 10:55:39'),
(12, 14, 'A-', '', '', '', '', 'Fully Vaccinated', '2025-11-26 15:28:47', '2025-11-26 15:28:47'),
(13, 15, 'AB+', '', '', '', '', 'Fully Vaccinated', '2025-11-26 15:30:51', '2025-11-26 15:30:51'),
(14, 16, 'B+', '', '', '', '', 'Fully Vaccinated', '2025-12-07 05:31:10', '2025-12-07 05:31:10'),
(15, 17, 'B+', '', '', '', '', 'Not Vaccinated', '2025-12-16 15:39:10', '2025-12-16 15:40:03'),
(18, 20, '', '', '', '', '', '', '2026-01-27 17:02:15', '2026-01-27 17:02:15'),
(20, 22, '', '', '', '', '', '', '2026-01-29 15:36:37', '2026-01-29 15:36:37'),
(26, 28, '', '', '', '', '', '', '2026-02-11 15:56:26', '2026-02-11 15:56:26'),
(30, 32, '', '', '', '', '', '', '2026-02-11 16:40:53', '2026-02-11 16:40:53'),
(31, 33, '', '', '', '', '', '', '2026-02-11 16:40:53', '2026-02-11 16:40:53'),
(39, 41, '', '', '', '', '', '', '2026-02-14 08:15:40', '2026-02-14 08:15:40'),
(40, 42, 'B+', '', '', '', '', 'Fully Vaccinated', '2026-02-14 09:39:26', '2026-02-14 09:39:26'),
(43, 45, '', '', '', '', '', '', '2026-02-16 07:51:14', '2026-02-16 07:51:14'),
(44, 46, '', '', '', '', '', '', '2026-02-16 08:01:03', '2026-02-16 08:01:03'),
(45, 47, '', '', '', '', '', '', '2026-02-16 08:49:40', '2026-02-16 08:49:40');

-- --------------------------------------------------------

--
-- Table structure for table `households`
--

CREATE TABLE `households` (
  `household_id` int(11) NOT NULL,
  `head_id` int(11) NOT NULL,
  `total_members` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reservations`
--

CREATE TABLE `reservations` (
  `id` int(11) NOT NULL,
  `facility_id` int(11) NOT NULL,
  `resident_id` int(11) NOT NULL,
  `reservation_date` date NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `purpose` text NOT NULL,
  `status` enum('pending','approved','rejected','cancelled') DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reservations`
--

INSERT INTO `reservations` (`id`, `facility_id`, `resident_id`, `reservation_date`, `start_time`, `end_time`, `purpose`, `status`, `created_at`, `updated_at`) VALUES
(4, 4, 11, '2025-11-22', '08:00:00', '09:00:00', 'practice', 'approved', '2025-11-21 20:30:30', '2025-11-22 13:12:51'),
(5, 2, 12, '2025-11-23', '08:00:00', '09:00:00', 'zumba', 'approved', '2025-11-22 13:12:18', '2025-11-22 13:12:54'),
(6, 1, 8, '2025-11-27', '08:00:00', '09:00:00', 'basketball', 'approved', '2025-11-26 12:22:56', '2025-11-26 12:24:37'),
(7, 1, 3, '2025-11-27', '09:00:00', '10:00:00', 'basketball', 'approved', '2025-11-26 15:26:36', '2025-11-26 15:26:40'),
(8, 1, 16, '2025-12-08', '08:00:00', '09:00:00', 'basketball', 'approved', '2025-12-07 05:32:03', '2026-02-13 10:23:48'),
(9, 1, 17, '2025-12-17', '08:00:00', '09:00:00', 'zumba', 'approved', '2025-12-16 15:41:57', '2026-02-13 10:23:45'),
(22, 2, 3, '2026-02-13', '23:00:00', '23:30:00', 'zumba', 'approved', '2026-02-13 14:35:27', '2026-02-13 15:00:46'),
(25, 1, 7, '2026-02-15', '08:00:00', '09:00:00', 'Basketball', 'approved', '2026-02-14 01:47:44', '2026-02-15 02:42:37'),
(26, 2, 8, '2026-02-16', '08:00:00', '09:00:00', 'Basketball', 'approved', '2026-02-14 01:48:01', '2026-02-15 02:42:39'),
(28, 1, 20, '2026-02-18', '08:00:00', '09:00:00', 'basketball', 'pending', '2026-02-16 02:08:11', '2026-02-16 02:08:11'),
(29, 1, 7, '2026-02-19', '08:00:00', '09:00:00', 'Basketball', 'pending', '2026-02-16 07:30:33', '2026-02-16 07:30:33'),
(30, 1, 7, '2026-02-20', '08:00:00', '09:00:00', 'Basketball', 'pending', '2026-02-16 07:33:00', '2026-02-16 07:33:00'),
(31, 1, 3, '2026-02-17', '08:00:00', '09:00:00', 'BasketBall', 'pending', '2026-02-16 07:37:59', '2026-02-16 07:37:59'),
(33, 2, 7, '2026-02-17', '08:00:00', '09:00:00', 'afafsf', 'approved', '2026-02-16 07:44:16', '2026-02-16 08:24:05');

-- --------------------------------------------------------

--
-- Table structure for table `residents`
--

CREATE TABLE `residents` (
  `resident_id` int(11) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `middle_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) NOT NULL,
  `profile_picture` varchar(255) DEFAULT NULL,
  `birth_date` date NOT NULL,
  `sex` enum('Male','Female') NOT NULL,
  `civil_status` enum('Single','Married','Widowed','Separated') NOT NULL,
  `contact_number` varchar(20) DEFAULT NULL,
  `house_no` varchar(50) NOT NULL,
  `street` varchar(100) NOT NULL,
  `is_pwd` tinyint(1) DEFAULT 0,
  `is_senior` tinyint(1) DEFAULT 0,
  `is_solo_parent` tinyint(1) DEFAULT 0,
  `is_4ps` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `household_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `residents`
--

INSERT INTO `residents` (`resident_id`, `first_name`, `middle_name`, `last_name`, `profile_picture`, `birth_date`, `sex`, `civil_status`, `contact_number`, `house_no`, `street`, `is_pwd`, `is_senior`, `is_solo_parent`, `is_4ps`, `created_at`, `household_id`) VALUES
(3, 'Ronielyn', 'R.', 'Mayonado ', NULL, '2004-06-18', 'Female', 'Single', '', '34', 'Felix Manalo', 0, 0, 0, 1, '2025-11-19 22:19:56', NULL),
(6, 'Gabriel Paolo', 'P', 'Adducul', NULL, '2004-11-29', 'Male', 'Single', '09123456789', '67-a', 'Felix Manalo', 1, 0, 0, 0, '2025-11-21 16:36:53', NULL),
(7, 'Zed', '', 'Villanueva', NULL, '2002-11-11', 'Male', 'Single', '09361840125', '45-c', 'Felix Manalo', 1, 0, 0, 0, '2025-11-21 16:39:43', NULL),
(8, 'Karl', 'R', 'Ebarle', NULL, '2001-07-22', 'Male', 'Single', '09483784980', '45-e', 'Felix Manalo', 1, 0, 0, 0, '2025-11-21 18:15:11', NULL),
(10, 'Terrence ', '', 'Tutunog', NULL, '2002-12-29', 'Male', 'Single', '09323254342', '699-a', 'Chicago', 0, 0, 0, 1, '2025-11-21 20:12:59', NULL),
(11, 'Rainier Anthony', 'A', 'Alejandria', NULL, '1999-02-16', 'Male', 'Single', '', '87', 'Denver', 0, 0, 1, 0, '2025-11-21 20:27:06', NULL),
(12, 'Christian ', '', 'Doringo', NULL, '1998-02-19', 'Male', 'Single', '09232328328', '55-a', 'Felix Manalo', 1, 0, 0, 0, '2025-11-22 13:09:38', NULL),
(13, 'Don', '', 'Alba', NULL, '1996-07-11', 'Male', 'Single', '', '88', 'Denver', 0, 0, 0, 1, '2025-11-23 10:55:39', NULL),
(14, 'Christian ', '', 'Pepito', NULL, '1986-06-18', 'Male', 'Single', '', '88', 'Felix Manalo', 0, 0, 0, 1, '2025-11-26 15:28:47', NULL),
(15, 'John Michael', '', 'Isaac', NULL, '1996-01-24', 'Male', 'Single', '', '99', 'Miami', 0, 0, 0, 1, '2025-11-26 15:30:51', NULL),
(16, 'Mat', '', 'Gonzaga', NULL, '1996-06-12', 'Male', 'Single', '09283838388', '36', 'Felix Manalo', 1, 0, 0, 0, '2025-12-07 05:31:10', NULL),
(17, 'Justine ', '', 'Alcala', NULL, '1999-06-17', 'Male', 'Single', '09232323434', '23', 'Gensan', 1, 1, 1, 1, '2025-12-16 15:39:10', NULL),
(20, 'Lance Frederic', 'V', 'De Felipe', NULL, '2004-08-16', 'Male', 'Single', '', '27-a', 'Denver', 0, 0, 0, 0, '2026-01-27 17:02:15', NULL),
(22, 'Sasuke', '', 'Shipuden', NULL, '2000-11-30', 'Male', 'Single', '', '2231312', 'Denver', 0, 0, 0, 0, '2026-01-29 15:36:37', NULL),
(28, 'john', '', 'micheal', NULL, '2004-09-17', 'Male', 'Single', '', '33', 'miami', 0, 0, 0, 0, '2026-02-11 15:56:26', NULL),
(32, 'Miley', '', 'E', NULL, '2004-08-09', 'Female', 'Single', '', '23', 'miami', 0, 0, 0, 0, '2026-02-11 16:40:53', NULL),
(33, 'Adam', '', 'Cabrera', NULL, '2004-09-17', 'Male', 'Single', '', '33', 'miami', 0, 0, 0, 0, '2026-02-11 16:40:53', NULL),
(41, 'Inday', '', 'Bakal', NULL, '2004-06-16', 'Female', 'Single', '09093092039', '324', 'Miami', 1, 0, 0, 0, '2026-02-14 08:15:40', NULL),
(42, 'James', '', 'Charles', NULL, '1999-09-11', 'Male', 'Single', '09232321424', '69', 'Denver', 1, 0, 0, 0, '2026-02-14 09:39:26', NULL),
(45, 'adfasdf', '', 'asdfasfds', NULL, '2004-09-14', 'Male', 'Single', '09232313233', '34', 'Miami', 0, 0, 0, 0, '2026-02-16 07:51:14', NULL),
(46, 'fafdaf', '', 'adfasfaf', NULL, '2003-02-22', 'Female', 'Single', '09637263276', '44', 'Denver', 0, 0, 0, 0, '2026-02-16 08:01:03', NULL),
(47, 'James', '', 'Garden', NULL, '2000-01-30', 'Male', 'Single', '09237237627', '34', 'Miami', 0, 0, 0, 0, '2026-02-16 08:49:40', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `role` enum('super_admin','admin') DEFAULT 'admin',
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `full_name`, `email`, `role`, `is_active`, `created_at`, `updated_at`) VALUES
(2, 'staff', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Administrator', 'admin@barangay.com', 'admin', 1, '2025-11-23 13:40:56', '2026-02-16 04:32:56'),
(3, 'adminlance', '$2y$10$3Q0ZzXWY1HEebriGBbjQ4eHjuOGxfdzsanaLKNK5FpW.zRYr7pm82', 'Lance De Felipe', '', 'super_admin', 1, '2025-11-26 14:23:16', '2026-01-15 13:06:18'),
(7, 'adminkarl', '$2y$10$5yN7G42VFgJy5h5qH.Cu5.vJFQRpwqbvoFCIufZaxtbsWG6vELth2', 'Karl Ebarle', '', 'super_admin', 1, '2026-01-29 13:39:48', '2026-01-29 13:57:47'),
(10, 'adminzed', '$2y$10$a0GOm72oxNAxGCIB497k7Ou/ovyLYR.dlcz4MMuS7j3OA0aGfmwCm', 'Zed Villanueva', '', 'admin', 1, '2026-01-29 14:39:59', '2026-02-16 08:41:36'),
(11, 'test', '$2y$10$OCAI3We5k93PKOJkVSo23.S1/2d.jz4woPViOTljOr1MkGk9dFpoG', 'test', '', 'admin', 1, '2026-02-16 06:01:50', '2026-02-18 01:08:12'),
(12, 'ronielyn', '$2y$10$aju8f3cyAoOYdU8myRunU.g3bsUEM4tjuAuBBVaR.Ef1TR0KZqndW', 'Ronielyn Mayonado', '', 'super_admin', 1, '2026-02-16 08:42:33', '2026-02-16 08:42:33');

-- --------------------------------------------------------

--
-- Table structure for table `voter_info`
--

CREATE TABLE `voter_info` (
  `voter_id` int(11) NOT NULL,
  `resident_id` int(11) NOT NULL,
  `is_registered` tinyint(1) NOT NULL DEFAULT 0,
  `precinct_number` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `voter_info`
--

INSERT INTO `voter_info` (`voter_id`, `resident_id`, `is_registered`, `precinct_number`) VALUES
(3, 3, 0, ''),
(4, 7, 1, '16456423'),
(5, 6, 1, '16456423'),
(6, 8, 1, '25657443'),
(8, 10, 0, ''),
(9, 11, 1, '3423423424'),
(10, 12, 1, '2312314131'),
(11, 13, 1, '53223332'),
(12, 14, 1, '23123232'),
(13, 15, 0, ''),
(14, 16, 1, '23231224423'),
(15, 17, 0, ''),
(18, 20, 0, ''),
(20, 22, 0, ''),
(26, 28, 0, ''),
(30, 33, 0, ''),
(32, 32, 0, ''),
(39, 41, 0, ''),
(40, 42, 1, '213213123S123'),
(43, 45, 0, ''),
(44, 46, 0, ''),
(45, 47, 0, '');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `idx_timestamp` (`timestamp`),
  ADD KEY `idx_module` (`module`),
  ADD KEY `idx_user` (`user_id`);

--
-- Indexes for table `audit_permissions`
--
ALTER TABLE `audit_permissions`
  ADD PRIMARY KEY (`permission_id`),
  ADD KEY `granted_by` (`granted_by`),
  ADD KEY `idx_user_active` (`user_id`,`is_active`);

--
-- Indexes for table `education_employment`
--
ALTER TABLE `education_employment`
  ADD PRIMARY KEY (`edu_emp_id`),
  ADD UNIQUE KEY `unique_resident_education` (`resident_id`);

--
-- Indexes for table `facilities`
--
ALTER TABLE `facilities`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `health_info`
--
ALTER TABLE `health_info`
  ADD PRIMARY KEY (`health_id`),
  ADD UNIQUE KEY `unique_resident_health` (`resident_id`);

--
-- Indexes for table `households`
--
ALTER TABLE `households`
  ADD PRIMARY KEY (`household_id`),
  ADD KEY `head_id` (`head_id`);

--
-- Indexes for table `reservations`
--
ALTER TABLE `reservations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `facility_id` (`facility_id`),
  ADD KEY `resident_id` (`resident_id`);

--
-- Indexes for table `residents`
--
ALTER TABLE `residents`
  ADD PRIMARY KEY (`resident_id`),
  ADD KEY `fk_resident_household` (`household_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `voter_info`
--
ALTER TABLE `voter_info`
  ADD PRIMARY KEY (`voter_id`),
  ADD UNIQUE KEY `unique_resident_voter` (`resident_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `audit_logs`
--
ALTER TABLE `audit_logs`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=102;

--
-- AUTO_INCREMENT for table `audit_permissions`
--
ALTER TABLE `audit_permissions`
  MODIFY `permission_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `education_employment`
--
ALTER TABLE `education_employment`
  MODIFY `edu_emp_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `facilities`
--
ALTER TABLE `facilities`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `health_info`
--
ALTER TABLE `health_info`
  MODIFY `health_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `households`
--
ALTER TABLE `households`
  MODIFY `household_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reservations`
--
ALTER TABLE `reservations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `residents`
--
ALTER TABLE `residents`
  MODIFY `resident_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `voter_info`
--
ALTER TABLE `voter_info`
  MODIFY `voter_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `audit_permissions`
--
ALTER TABLE `audit_permissions`
  ADD CONSTRAINT `audit_permissions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `audit_permissions_ibfk_2` FOREIGN KEY (`granted_by`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `education_employment`
--
ALTER TABLE `education_employment`
  ADD CONSTRAINT `education_employment_ibfk_1` FOREIGN KEY (`resident_id`) REFERENCES `residents` (`resident_id`) ON DELETE CASCADE;

--
-- Constraints for table `health_info`
--
ALTER TABLE `health_info`
  ADD CONSTRAINT `health_info_ibfk_1` FOREIGN KEY (`resident_id`) REFERENCES `residents` (`resident_id`) ON DELETE CASCADE;

--
-- Constraints for table `households`
--
ALTER TABLE `households`
  ADD CONSTRAINT `households_ibfk_1` FOREIGN KEY (`head_id`) REFERENCES `residents` (`resident_id`);

--
-- Constraints for table `reservations`
--
ALTER TABLE `reservations`
  ADD CONSTRAINT `reservations_ibfk_1` FOREIGN KEY (`facility_id`) REFERENCES `facilities` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `reservations_ibfk_2` FOREIGN KEY (`resident_id`) REFERENCES `residents` (`resident_id`) ON DELETE CASCADE;

--
-- Constraints for table `residents`
--
ALTER TABLE `residents`
  ADD CONSTRAINT `fk_resident_household` FOREIGN KEY (`household_id`) REFERENCES `households` (`household_id`);

--
-- Constraints for table `voter_info`
--
ALTER TABLE `voter_info`
  ADD CONSTRAINT `voter_info_ibfk_1` FOREIGN KEY (`resident_id`) REFERENCES `residents` (`resident_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
