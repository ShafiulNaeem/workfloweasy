-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 26, 2020 at 08:48 AM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `irdc`
--

-- --------------------------------------------------------

--
-- Table structure for table `corporate_clients`
--

CREATE TABLE `corporate_clients` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `company_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_person_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_person_mobile` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_person_email` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('ACTIVE','INACTIVE') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ACTIVE',
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `corporate_clients`
--

INSERT INTO `corporate_clients` (`id`, `company_name`, `address`, `contact_person_name`, `contact_person_mobile`, `contact_person_email`, `status`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'HBC', 'abc', 'raton', '01757236912', 'ratoncse24@gmail.com', 'ACTIVE', NULL, NULL, '2020-11-18 05:26:43', '2020-11-18 05:26:58', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `corporate_client_discounts`
--

CREATE TABLE `corporate_client_discounts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `corporate_client_id` bigint(20) UNSIGNED NOT NULL,
  `hospital_id` bigint(20) UNSIGNED NOT NULL,
  `service_id` bigint(20) UNSIGNED DEFAULT NULL,
  `service_package_id` bigint(20) UNSIGNED DEFAULT NULL,
  `discount_percentage` int(11) DEFAULT NULL,
  `discount_amount` int(11) DEFAULT NULL,
  `status` enum('ACTIVE','INACTIVE') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ACTIVE',
  `discount_category` enum('OPDSERVICES','IPDSERVICES') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'OPDSERVICES',
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `corporate_client_discounts`
--

INSERT INTO `corporate_client_discounts` (`id`, `corporate_client_id`, `hospital_id`, `service_id`, `service_package_id`, `discount_percentage`, `discount_amount`, `status`, `discount_category`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 1, 1, NULL, NULL, 33, 'ACTIVE', 'OPDSERVICES', NULL, NULL, '2020-11-19 02:42:56', '2020-11-19 07:51:17', NULL),
(8, 1, 2, 2, NULL, 10, 0, 'ACTIVE', 'OPDSERVICES', NULL, NULL, '2020-11-28 03:59:39', '2020-12-02 05:27:04', NULL),
(9, 1, 1, 1, NULL, 10, NULL, 'ACTIVE', 'IPDSERVICES', NULL, NULL, '2020-12-02 05:35:25', '2020-12-02 05:35:25', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dept_head_id` bigint(20) UNSIGNED NOT NULL,
  `dept_admin_id` bigint(20) UNSIGNED NOT NULL,
  `status` enum('ACTIVE','INACTIVE') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ACTIVE',
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `hospital_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `departments`
--

INSERT INTO `departments` (`id`, `name`, `dept_head_id`, `dept_admin_id`, `status`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`, `hospital_id`) VALUES
(1, 'Dep', 1, 1, 'ACTIVE', NULL, NULL, '2020-11-15 10:29:20', '2020-11-15 10:29:20', NULL, 1),
(2, 'EEE', 1, 1, 'ACTIVE', NULL, NULL, '2020-11-16 02:30:58', '2020-11-16 02:30:58', NULL, 1),
(3, 'EEE', 1, 1, 'ACTIVE', NULL, NULL, '2020-11-16 02:37:05', '2020-11-16 02:37:05', NULL, 1),
(4, 'Ra', 1, 1, 'ACTIVE', NULL, NULL, '2020-11-16 02:39:50', '2020-11-16 02:39:50', NULL, 1),
(5, 'Ae', 1, 1, 'ACTIVE', NULL, NULL, '2020-11-16 02:43:41', '2020-11-16 02:43:41', NULL, 1),
(6, 'ER', 1, 1, 'ACTIVE', NULL, NULL, '2020-11-16 02:47:07', '2020-11-16 02:47:07', NULL, 1),
(7, 'ww', 1, 1, 'ACTIVE', NULL, NULL, '2020-11-17 02:57:06', '2020-11-17 02:57:06', NULL, 1),
(8, 'EEE', 1, 1, 'ACTIVE', NULL, NULL, '2020-11-17 02:59:06', '2020-11-17 02:59:06', NULL, 1),
(9, 'ER', 1, 1, 'ACTIVE', NULL, NULL, '2020-11-17 03:02:16', '2020-11-17 03:02:16', NULL, 2),
(10, 'EE', 1, 1, 'ACTIVE', NULL, NULL, '2020-11-17 03:15:05', '2020-11-17 03:15:05', NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `department_consumptions`
--

CREATE TABLE `department_consumptions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `hospital_id` bigint(20) UNSIGNED NOT NULL,
  `department_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `product_qty` int(11) NOT NULL,
  `product_for` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remarks` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('ACTIVE','INACTIVE') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ACTIVE',
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `department_consumptions`
--

INSERT INTO `department_consumptions` (`id`, `hospital_id`, `department_id`, `product_id`, `product_qty`, `product_for`, `remarks`, `status`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`) VALUES
(4, 1, 1, 1, 10, 'afs', 'dd', 'ACTIVE', NULL, NULL, '2020-12-01 10:59:26', '2020-12-01 10:59:57', '2020-12-01 10:59:57'),
(5, 1, 1, 1, 15, 'q', NULL, 'ACTIVE', NULL, NULL, '2020-12-01 11:02:12', '2020-12-01 11:02:32', '2020-12-01 11:02:32'),
(6, 1, 1, 1, 222, 'aa', NULL, 'ACTIVE', NULL, NULL, '2020-12-20 08:10:02', '2020-12-20 08:10:02', NULL),
(7, 1, 1, 1, 33, '33', NULL, 'ACTIVE', NULL, NULL, '2020-12-20 08:52:21', '2020-12-20 08:52:21', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `designations`
--

CREATE TABLE `designations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('ACTIVE','INACTIVE') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ACTIVE',
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `hospital_id` bigint(20) UNSIGNED NOT NULL,
  `department_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `designations`
--

INSERT INTO `designations` (`id`, `title`, `description`, `status`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`, `hospital_id`, `department_id`) VALUES
(1, 'Dev', 'ddd', 'ACTIVE', NULL, NULL, '2020-11-16 03:12:52', '2020-11-16 03:12:52', NULL, 1, 3),
(2, 'RRR', '44', 'ACTIVE', NULL, NULL, '2020-11-16 04:33:32', '2020-11-16 04:33:32', NULL, 2, 3),
(3, 'aa', 'dd', 'ACTIVE', NULL, NULL, '2020-11-16 04:35:31', '2020-11-16 04:35:31', NULL, 1, 3),
(4, 'RWW', 'eee', 'ACTIVE', NULL, NULL, '2020-11-17 03:04:27', '2020-11-17 03:04:27', NULL, 1, 3),
(5, 'ee', 'aadd', 'ACTIVE', NULL, NULL, '2020-11-17 03:15:23', '2020-11-17 03:15:23', NULL, 2, 4),
(6, 'aa', 'dd', 'ACTIVE', NULL, NULL, '2020-11-17 12:07:25', '2020-11-17 12:07:25', NULL, 1, 2);

-- --------------------------------------------------------

--
-- Table structure for table `doctors`
--

CREATE TABLE `doctors` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` enum('INHOUSE','VISITING') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'INHOUSE',
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `bmdc_id` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mobile` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `institute_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `chamber_address` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `photo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('ACTIVE','INACTIVE') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ACTIVE',
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `hospital_id` bigint(20) UNSIGNED DEFAULT NULL,
  `department_id` bigint(20) UNSIGNED DEFAULT NULL,
  `doctors_specialities_id` bigint(20) UNSIGNED NOT NULL,
  `designation_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `doctors`
--

INSERT INTO `doctors` (`id`, `code`, `type`, `name`, `bmdc_id`, `mobile`, `email`, `institute_name`, `chamber_address`, `photo`, `status`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`, `hospital_id`, `department_id`, `doctors_specialities_id`, `designation_id`) VALUES
(1, '645342', 'INHOUSE', 'sdf', '24', '234234', NULL, 'rwe', 'rwer', NULL, 'ACTIVE', NULL, NULL, '2020-11-16 05:31:32', '2020-12-06 06:03:04', NULL, 1, 3, 2, 2),
(2, '57087323', 'INHOUSE', 'Doc', '33333', '01757236912', NULL, 'institute', 'cambar adderss', NULL, 'ACTIVE', NULL, NULL, '2020-12-06 10:17:32', '2020-12-06 10:17:32', NULL, 2, 7, 2, 3),
(3, '57087323', 'INHOUSE', 'Doc', '33333', '01757236912', NULL, 'institute', 'cambar adderss', NULL, 'ACTIVE', NULL, NULL, '2020-12-06 10:17:35', '2020-12-06 10:17:35', NULL, 2, 7, 2, 3),
(4, '57087323', 'INHOUSE', 'Doc', '33333', '01757236912', NULL, 'institute', 'cambar adderss', NULL, 'ACTIVE', NULL, NULL, '2020-12-06 10:17:45', '2020-12-06 10:17:45', NULL, 2, 7, 2, 3),
(5, '44522310', 'INHOUSE', 'Robin', '222', NULL, NULL, 'aaa', 'bbb', NULL, 'ACTIVE', NULL, NULL, '2020-12-06 10:19:59', '2020-12-06 10:19:59', NULL, 1, 3, 2, 2),
(6, '94134700', 'INHOUSE', 'aaa', '333', NULL, NULL, 'abbbs', 'cabar', NULL, 'ACTIVE', NULL, NULL, '2020-12-06 10:21:58', '2020-12-06 10:21:58', NULL, 1, 2, 2, 2),
(7, '22949386', 'INHOUSE', 'yy', NULL, NULL, NULL, 'yy', 'uuu', '', 'ACTIVE', NULL, NULL, '2020-12-06 11:08:39', '2020-12-06 11:08:39', NULL, 1, 3, 2, 2),
(8, '32002358', 'INHOUSE', '3', NULL, NULL, NULL, NULL, NULL, '', 'ACTIVE', NULL, NULL, '2020-12-06 11:10:19', '2020-12-06 11:10:19', NULL, 3, 2, 2, 2),
(9, '92019692', 'VISITING', 'ttttttt', NULL, NULL, NULL, NULL, NULL, '/storage/uploads/1607277130_logo.jpg', 'ACTIVE', NULL, NULL, '2020-12-06 11:24:06', '2020-12-06 11:52:10', NULL, NULL, NULL, 2, 2);

-- --------------------------------------------------------

--
-- Table structure for table `doctors_specialities`
--

CREATE TABLE `doctors_specialities` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('ACTIVE','INACTIVE') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ACTIVE',
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `doctors_specialities`
--

INSERT INTO `doctors_specialities` (`id`, `name`, `description`, `status`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'EE', 'AARR', 'ACTIVE', NULL, NULL, '2020-11-16 03:29:33', '2020-11-16 03:29:33', NULL),
(2, 'ERRR', 'ABCCCCC', 'ACTIVE', NULL, NULL, '2020-11-17 03:06:35', '2020-11-17 03:06:35', NULL),
(3, 'ggg', 'saa', 'ACTIVE', NULL, NULL, '2020-11-17 03:09:22', '2020-11-17 03:09:22', NULL),
(4, 'ee', NULL, 'ACTIVE', NULL, NULL, '2020-11-17 03:15:36', '2020-11-17 03:15:36', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hospitals`
--

CREATE TABLE `hospitals` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `district` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `website_url` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo_image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mobile_no` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tnt_no` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_person_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_person_mobile` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('ACTIVE','INACTIVE') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ACTIVE',
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `hospitals`
--

INSERT INTO `hospitals` (`id`, `code`, `name`, `district`, `address`, `contact`, `email`, `website_url`, `logo_image`, `mobile_no`, `tnt_no`, `contact_person_name`, `contact_person_mobile`, `status`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, '635032', 'Abb', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ACTIVE', NULL, NULL, '2020-11-15 10:28:11', '2020-11-15 10:28:11', NULL),
(2, '675502', 'Demo', 'Dhaka', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ACTIVE', NULL, NULL, '2020-11-16 02:18:55', '2020-11-16 02:18:55', NULL),
(3, '207955', 'aaa', 'eee', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ACTIVE', NULL, NULL, '2020-11-16 02:43:18', '2020-11-16 02:43:18', NULL),
(4, '362218', 'aa', 'Naogaon', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ACTIVE', NULL, NULL, '2020-11-17 03:14:46', '2020-11-17 03:14:46', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `inventories`
--

CREATE TABLE `inventories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `hospital_id` bigint(20) UNSIGNED DEFAULT NULL,
  `department_id` bigint(20) UNSIGNED DEFAULT NULL,
  `product_id` bigint(20) UNSIGNED DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `batch_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `mfg_date` date DEFAULT NULL,
  `exp_date` date DEFAULT NULL,
  `status` enum('ACTIVE','INACTIVE') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ACTIVE',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `inventories`
--

INSERT INTO `inventories` (`id`, `hospital_id`, `department_id`, `product_id`, `type`, `batch_no`, `quantity`, `mfg_date`, `exp_date`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 1, 1, 1, '1', -165, NULL, NULL, 'ACTIVE', '2020-12-01 16:58:11', '2020-12-20 08:52:21', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `ipd_billings`
--

CREATE TABLE `ipd_billings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `patient_admission_id` bigint(20) UNSIGNED NOT NULL,
  `bill_no` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_bill_amount` double NOT NULL,
  `total_discount_amount` double NOT NULL,
  `total_paid_amount` double NOT NULL,
  `total_due_amount` double NOT NULL,
  `total_advance_amount` double NOT NULL,
  `payment_status` enum('DUE','PAID','PARTIAL') COLLATE utf8mb4_unicode_ci NOT NULL,
  `remarks` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('COMPLETE','INCOMPLETE','INITIATE') COLLATE utf8mb4_unicode_ci NOT NULL,
  `discount_type` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `discount_value` int(11) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ipd_billings`
--

INSERT INTO `ipd_billings` (`id`, `patient_admission_id`, `bill_no`, `total_bill_amount`, `total_discount_amount`, `total_paid_amount`, `total_due_amount`, `total_advance_amount`, `payment_status`, `remarks`, `status`, `discount_type`, `discount_value`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`) VALUES
(7, 1, '900819', 1332, 0, 0, 1332, 0, 'DUE', NULL, 'COMPLETE', NULL, NULL, NULL, NULL, '2020-12-03 11:26:48', '2020-12-03 11:42:16', NULL),
(8, 1, '293273', 4884, 0, 0, 4884, 0, 'DUE', NULL, 'COMPLETE', NULL, NULL, NULL, NULL, '2020-12-03 11:45:26', '2020-12-04 23:54:43', NULL),
(9, 1, '838666', 0, 0, 0, 0, 0, 'DUE', NULL, 'INITIATE', NULL, NULL, NULL, NULL, '2020-12-04 23:55:16', '2020-12-04 23:55:16', NULL),
(10, 3, '139539', 78, 0, 78, 0, 0, 'PAID', NULL, 'COMPLETE', NULL, NULL, NULL, NULL, '2020-12-08 10:20:56', '2020-12-08 10:20:56', NULL),
(11, 4, '910758', 78, 0, 78, 0, 0, 'PAID', NULL, 'COMPLETE', NULL, NULL, NULL, NULL, '2020-12-08 10:21:16', '2020-12-08 10:21:16', NULL),
(12, 5, '659741', 78, 0, 44, 0, 0, 'PAID', NULL, 'COMPLETE', NULL, NULL, NULL, NULL, '2020-12-08 10:33:55', '2020-12-08 10:33:55', NULL),
(13, 6, '383149', 78, 0, 78, 0, 0, 'PAID', NULL, 'COMPLETE', NULL, NULL, NULL, NULL, '2020-12-08 10:41:33', '2020-12-08 10:41:33', NULL),
(14, 8, '137483', 78, 0, 78, 0, 0, 'DUE', NULL, 'INCOMPLETE', NULL, NULL, NULL, NULL, '2020-12-09 08:53:08', '2020-12-09 08:53:08', NULL),
(15, 9, '627569', 966, 0, 78, 888, 0, 'DUE', NULL, 'INCOMPLETE', NULL, NULL, NULL, NULL, '2020-12-09 09:03:40', '2020-12-20 08:32:34', NULL),
(17, 7, '118211', 5383.5, 499.5, 0, 5383.5, 0, 'DUE', NULL, 'INCOMPLETE', NULL, NULL, NULL, NULL, '2020-12-09 12:13:59', '2020-12-09 13:06:36', NULL),
(18, 10, '456524', 1529.025, 80.475, 0, 1529.025, 0, 'DUE', NULL, 'INCOMPLETE', 'Percentage', 5, NULL, NULL, '2020-12-20 08:31:56', '2020-12-23 11:49:10', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `ipd_bill_details`
--

CREATE TABLE `ipd_bill_details` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `ipd_billing_id` bigint(20) UNSIGNED DEFAULT NULL,
  `item_type` enum('SERVICE','LABTEST','MEDICINE','OTHERS','PACKAGE') COLLATE utf8mb4_unicode_ci NOT NULL,
  `item_id` bigint(20) UNSIGNED NOT NULL,
  `item_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `item_qty` double DEFAULT NULL,
  `unit_tarrif` double NOT NULL,
  `total_tarrif` double NOT NULL,
  `discount` double DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `remarks` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('ACTIVE','INACTIVE','INITIATE') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ipd_bill_details`
--

INSERT INTO `ipd_bill_details` (`id`, `ipd_billing_id`, `item_type`, `item_id`, `item_name`, `item_qty`, `unit_tarrif`, `total_tarrif`, `discount`, `start_time`, `end_time`, `remarks`, `status`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`) VALUES
(10, 7, 'SERVICE', 2, 'Test', 3, 444, 1332, 0, NULL, NULL, NULL, 'ACTIVE', NULL, NULL, '2020-12-03 11:26:48', '2020-12-03 11:42:09', NULL),
(11, 8, 'SERVICE', 2, 'Test', 27, 444, 11988, 0, NULL, NULL, NULL, 'ACTIVE', NULL, NULL, '2020-12-03 12:18:40', '2020-12-04 22:57:52', '2020-12-04 22:57:52'),
(12, 8, 'SERVICE', 2, 'Test', 11, 444, 4884, 0, NULL, NULL, NULL, 'ACTIVE', NULL, NULL, '2020-12-04 22:57:56', '2020-12-04 23:45:59', NULL),
(13, 9, 'SERVICE', 1, 'IPD service', 1, 555, 249.75, 27.75, '2020-12-05 10:10:00', '2020-12-05 16:10:00', NULL, 'ACTIVE', NULL, NULL, '2020-12-05 05:15:16', '2020-12-05 05:15:27', '2020-12-05 05:15:27'),
(14, 9, 'SERVICE', 1, 'IPD service', 6, 555, 2997, 333, '2020-12-05 10:10:00', '2020-12-05 16:10:00', NULL, 'ACTIVE', NULL, NULL, '2020-12-05 05:15:30', '2020-12-05 05:16:45', '2020-12-05 05:16:45'),
(15, 9, 'SERVICE', 1, 'IPD service', 2, 555, 749.25, 83.25, '2020-12-04 17:17:00', '2020-12-05 17:17:00', NULL, 'ACTIVE', NULL, NULL, '2020-12-05 05:18:00', '2020-12-05 05:19:11', '2020-12-05 05:19:11'),
(16, 9, 'SERVICE', 1, 'IPD service', 1.5, 555, 749.25, 83.25, '2020-12-04 17:17:00', '2020-12-05 17:17:00', NULL, 'ACTIVE', NULL, NULL, '2020-12-05 05:19:15', '2020-12-05 05:19:16', NULL),
(17, 10, 'PACKAGE', 1, 'Ipd service package', 1, 78, 78, NULL, NULL, NULL, NULL, 'ACTIVE', NULL, NULL, '2020-12-08 10:20:56', '2020-12-08 10:20:56', NULL),
(18, 11, 'PACKAGE', 1, 'Ipd service package', 1, 78, 78, NULL, NULL, NULL, NULL, 'ACTIVE', NULL, NULL, '2020-12-08 10:21:16', '2020-12-08 10:21:16', NULL),
(19, 12, 'PACKAGE', 1, 'Ipd service package', 1, 78, 78, NULL, NULL, NULL, NULL, 'ACTIVE', NULL, NULL, '2020-12-08 10:33:55', '2020-12-08 10:33:55', NULL),
(20, 13, 'PACKAGE', 1, 'Ipd service package', 1, 78, 78, NULL, NULL, NULL, NULL, 'ACTIVE', NULL, NULL, '2020-12-08 10:41:33', '2020-12-08 10:41:33', NULL),
(21, 14, 'PACKAGE', 1, 'Ipd service package', 1, 78, 78, NULL, NULL, NULL, NULL, 'ACTIVE', NULL, NULL, '2020-12-09 08:53:08', '2020-12-09 08:53:08', NULL),
(22, 15, 'PACKAGE', 1, 'Ipd service package', 1, 78, 78, 0, NULL, NULL, NULL, 'ACTIVE', NULL, NULL, '2020-12-09 09:03:40', '2020-12-09 11:37:45', NULL),
(24, 15, 'SERVICE', 2, 'Test', 2, 444, 888, 0, NULL, NULL, NULL, 'ACTIVE', NULL, NULL, '2020-12-09 09:56:14', '2020-12-20 08:32:34', NULL),
(25, 15, 'SERVICE', 1, 'IPD service', 8, 555, 4440, 0, '2020-12-01 22:57:00', '2020-12-09 22:57:00', NULL, 'ACTIVE', NULL, NULL, '2020-12-09 10:57:40', '2020-12-09 11:38:24', '2020-12-09 11:38:24'),
(26, 17, 'SERVICE', 2, 'Test', 2, 444, 888, 0, NULL, NULL, NULL, 'ACTIVE', NULL, NULL, '2020-12-09 12:13:59', '2020-12-09 13:06:36', NULL),
(27, 17, 'SERVICE', 1, 'IPD service', 9, 555, 4495.5, 499.5, '2020-12-01 01:00:00', '2020-12-10 01:00:00', NULL, 'ACTIVE', NULL, NULL, '2020-12-09 13:00:55', '2020-12-09 13:00:55', NULL),
(28, 18, 'SERVICE', 2, 'Test', 2, 444, 888, 0, NULL, NULL, NULL, 'ACTIVE', NULL, NULL, '2020-12-20 08:31:56', '2020-12-20 08:43:02', '2020-12-20 08:43:02'),
(29, 18, 'SERVICE', 1, 'IPD service', 1.5, 555, 832.5, 0, '2020-12-19 20:44:00', '2020-12-19 21:44:00', NULL, 'ACTIVE', NULL, NULL, '2020-12-20 08:43:19', '2020-12-20 08:45:11', '2020-12-20 08:45:11'),
(30, 18, 'SERVICE', 2, 'Test', 1, 444, 444, 0, NULL, NULL, NULL, 'ACTIVE', NULL, NULL, '2020-12-20 08:44:05', '2020-12-20 08:45:19', '2020-12-20 08:45:19'),
(31, 18, 'SERVICE', 2, 'Test', 3, 444, 1332, 0, NULL, NULL, NULL, 'ACTIVE', NULL, NULL, '2020-12-20 08:45:23', '2020-12-23 11:37:16', NULL),
(32, 18, 'SERVICE', 1, 'IPD service', 0.5, 555, 277.5, 0, '2020-12-20 19:45:00', '2020-12-20 20:45:00', NULL, 'ACTIVE', NULL, NULL, '2020-12-20 08:45:36', '2020-12-20 08:45:36', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `ipd_services`
--

CREATE TABLE `ipd_services` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_hourly` tinyint(1) NOT NULL DEFAULT 0,
  `tariff` decimal(12,2) DEFAULT NULL,
  `status` enum('ACTIVE','INACTIVE') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ACTIVE',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `hospital_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ipd_services`
--

INSERT INTO `ipd_services` (`id`, `code`, `name`, `description`, `is_hourly`, `tariff`, `status`, `created_at`, `updated_at`, `deleted_at`, `hospital_id`) VALUES
(1, '290341', 'IPD service', NULL, 1, '555.00', 'ACTIVE', '2020-11-15 05:51:28', '2020-11-15 05:51:28', NULL, NULL),
(2, '412585', 'Test', NULL, 0, '444.00', 'ACTIVE', '2020-11-15 10:21:15', '2020-11-15 10:21:15', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `ipd_service_packages`
--

CREATE TABLE `ipd_service_packages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `hospital_id` bigint(20) UNSIGNED DEFAULT NULL,
  `code` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `services` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`services`)),
  `tariff` decimal(12,2) DEFAULT NULL,
  `status` enum('ACTIVE','INACTIVE') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ACTIVE',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ipd_service_packages`
--

INSERT INTO `ipd_service_packages` (`id`, `hospital_id`, `code`, `name`, `services`, `tariff`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, NULL, '462990', 'Ipd service package', '[1,2]', '78.00', 'ACTIVE', '2020-11-18 21:06:57', '2020-11-18 21:06:57', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `medicines`
--

CREATE TABLE `medicines` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `company_id` bigint(20) UNSIGNED NOT NULL,
  `medicine_type_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `generic_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `strength` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tp_per_box` double(15,2) NOT NULL DEFAULT 0.00,
  `vat_per_box` double(15,2) NOT NULL DEFAULT 0.00,
  `mrp_per_box` double(15,2) NOT NULL DEFAULT 0.00,
  `pcs_per_box` int(11) DEFAULT NULL,
  `pcs_per_strip` int(11) DEFAULT NULL,
  `price_per_box` varchar(11) COLLATE utf8mb4_unicode_ci DEFAULT '0',
  `price_per_strip` int(11) NOT NULL DEFAULT 0,
  `price_per_pcs` int(11) NOT NULL DEFAULT 0,
  `dar_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_imported` tinyint(1) NOT NULL DEFAULT 0,
  `is_antibiotic` tinyint(1) NOT NULL DEFAULT 0,
  `product_type` int(11) NOT NULL DEFAULT 0,
  `status` enum('ACTIVE','INACTIVE') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ACTIVE',
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `medicines`
--

INSERT INTO `medicines` (`id`, `company_id`, `medicine_type_id`, `name`, `generic_name`, `strength`, `tp_per_box`, `vat_per_box`, `mrp_per_box`, `pcs_per_box`, `pcs_per_strip`, `price_per_box`, `price_per_strip`, `price_per_pcs`, `dar_no`, `is_imported`, `is_antibiotic`, `product_type`, `status`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1256, 8, 16, 'Al-Lev Vet', 'Levamisole', '30 %', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0205-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1257, 8, 16, 'Oxytetracin-Vet', 'Oxytetracycline', '20 gm/100 gm', 0.00, 0.00, 0.00, 0, 0, '82.81 Tk', 0, 0, '096-0207-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1258, 8, 16, 'Doxin-Al Powder (Vet)', 'Doxycycline', '100 mg/gm', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0220-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1259, 8, 16, 'Tylox-Al Vet', 'Tylosin', '20 gm/100 gm', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0237-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1260, 8, 16, 'Albimix-Plus Vet', 'Sodium Sulfachloropyridazine + Trimethoprim', '10 gm + 2 gm/100 gm', 0.00, 0.00, 0.00, 0, 0, '161.18 Tk', 0, 0, '096-0240-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1261, 8, 16, 'Albi-S 30%', 'Sulfaclozine', '30 %', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0270-007', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1262, 8, 16, 'Alcoxi-CK Vet', 'Diaverdin + Nicotinamide + Sulphadimethoxine Sodium + Sulphadimidine + Vitamin K', '3 gm + 3 gm + 2 gm + 20 gm + 2 gm/100 gm', 0.00, 0.00, 0.00, 0, 0, '170.00 Tk', 0, 0, '096-0275-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1263, 8, 16, 'Amolium 20% Vet', 'Amprolium', '20 %', 0.00, 0.00, 0.00, 0, 0, '196.10 Tk', 0, 0, '096-0272-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1264, 8, 16, 'Amolium Plus (Vet)', 'Amprolium + Sulfaquinoxaline Sodium + Vitamin K', '170 gm + 170 gm + 1 gm/KG', 0.00, 0.00, 0.00, 0, 0, '274.00 Tk', 0, 0, '096-0273-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1265, 8, 16, 'Nagavon Plus (Vet)', 'Trichlorfon', '100 %', 0.00, 0.00, 0.00, 0, 0, '35.00 Tk', 0, 0, '096-0284-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1266, 8, 16, 'Mimox 15% Vet', 'Amoxicillin', '15 %', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0288-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1267, 8, 16, 'Mimox 30% Powder Vet', 'Amoxicillin', '30 %', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0315-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1268, 8, 16, 'tiamulin-Al 45% Vet', 'Tiamulin Hydrogen Fumerate', '45 %', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0318-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1269, 8, 16, 'Ciptec-Al 20% Vet', 'Ciprofloxacin', '200 gm/Kg', 0.00, 0.00, 0.00, 0, 0, '243.62 Tk', 0, 0, '096-0343-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1270, 8, 16, 'Erotid (Vet)', 'Erythromycin Thiocyanate + Sulphadiazine + Trimethoprim', '18 gm + 15 gm + 3 gm/100 gm', 0.00, 0.00, 0.00, 0, 0, '365.00 Tk', 0, 0, '096-0345-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1271, 8, 64, 'Farmberry Oral Powder', 'Ispaghula Husk', '3.5 gm', 0.00, 0.00, 0.00, 0, 0, '4.00 Tk', 0, 0, '096-0266-060', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1272, 8, 17, 'Ciptec-AL', 'Ciprofloxacin', '10 gm/100 ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0261-007', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1273, 8, 17, 'Enromax 10% Vet', 'Enrofloxacin', '100 mg/ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0300-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1274, 8, 17, 'I-Pour Vet', 'Ivermectin', '1 gm/100 gm', 0.00, 0.00, 0.00, 0, 0, '42.00 Tk', 0, 0, '096-0356-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1275, 8, 10, 'Dylin', 'Metronidazole', '200 mg/5 ml', 0.00, 0.00, 0.00, 0, 0, '24.00 Tk', 0, 0, '096-0016-027', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1276, 8, 10, 'Griseofulvin', 'Griseofulvin', '125 mg/5 ml', 0.00, 0.00, 0.00, 0, 0, '18.57 Tk', 0, 0, '096-0057-020', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1278, 8, 10, 'Minisol', 'Pyrantel Pamoate', '500 mg/10 ml', 0.00, 0.00, 0.00, 0, 0, '12.00 Tk', 0, 0, '096-0021-008', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1279, 8, 10, 'Pentocil', 'Aluminium Oxide + Magnesium Hydroxide', '175 mg + 225 mg/5 ml', 0.00, 0.00, 0.00, 0, 0, '30.50 Tk', 0, 0, '096-0019-007', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1280, 8, 10, 'Albutrim', 'Sulphamethoxazole + Trimethoprim', '200 mg + 40 mg/5 ml', 0.00, 0.00, 0.00, 0, 0, '20.00 Tk', 0, 0, '096-0017-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1281, 8, 10, 'Antacid', 'Aluminium Oxide + Magnesium Hydroxide + Simethicone', '200 mg + 400 mg + 30 mg/5 ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0024-007', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1282, 8, 10, 'Domp', 'Domperidone', '5 mg/5 ml', 0.00, 0.00, 0.00, 0, 0, '38.00 Tk', 0, 0, '096-0043-018', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1283, 8, 10, 'Ibuprofen', 'Ibuprofen', '100 mg/5 ml', 0.00, 0.00, 0.00, 0, 0, '18.56 Tk', 0, 0, '096-0044-064', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1284, 8, 10, 'Para-AL', 'Paracetamol', '120 mg/5 ml', 0.00, 0.00, 0.00, 0, 0, '11.30 Tk', 0, 0, '096-0046-006', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1285, 8, 10, 'Lorafast', 'Loratadine', '5 mg/5 ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0159-021', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1286, 8, 10, 'Fexoril', 'Fexofenadine Hydrochloride', '30 mg/5 ml', 0.00, 0.00, 0.00, 0, 0, '46.00 Tk', 0, 0, '096-0394-021', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1287, 8, 11, 'Dextromethophan', 'Dextromethorphan Hydrobromide', '10 mg/5 ml', 0.00, 0.00, 0.00, 0, 0, '18.75 Tk', 0, 0, '096-0018-031', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1288, 8, 11, 'Dicalat', 'Ferrous Sulphate', '200 mg/5 ml', 0.00, 0.00, 0.00, 0, 0, '24.50 Tk', 0, 0, '096-0014-045', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1289, 8, 11, 'Diphenhydramin', 'Diphenhydramine Hydrochloride', '10 mg/5 ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0055-021', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1290, 8, 11, 'Gevril', 'Chlorpromazine Hydrochloride', '25 mg/5 ml', 0.00, 0.00, 0.00, 0, 0, '15.00 Tk', 0, 0, '096-0029-018', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1292, 8, 11, 'Malorin', 'Chloroquine Phosphate', '80 mg/5 ml', 0.00, 0.00, 0.00, 0, 0, '12.50 Tk', 0, 0, '096-0015-024', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1293, 8, 11, 'Migen', 'Metoclopramide Hydrochloride', '5 mg/5 ml', 0.00, 0.00, 0.00, 0, 0, '13.70 Tk', 0, 0, '096-0020-018', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1294, 8, 11, 'Misole 4mg/5ml', 'Zinc', '4.05 mg/5 ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0038-062', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1295, 8, 11, 'Montil', 'Promethazine Hydrochloride', '5 mg/5 ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0031-021', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1296, 8, 11, 'Alvit-B Forte', 'Nicotinamide + Pyridoxine Hydrochloride + Riboflavin + Vitamin B1', '20 mg + 2 mg + 2 mg + 5 mg/5 ml', 0.00, 0.00, 0.00, 0, 0, '0.57 Tk', 0, 0, '096-0032-078', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1297, 8, 11, 'Ranitidine', 'Ranitidine', '75 mg/5 ml', 0.00, 0.00, 0.00, 0, 0, '70.00 Tk', 0, 0, '096-0039-055', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1299, 8, 11, 'Alvit Gold', 'Ascorbic Acid + Biotin + Calcium + Choline Bitartrate + Chromium + Cyanocobalamin + Inositol + Iodine + Magnesium + Manganese + Pantothenic acid + Para-Amino-Benzoic Acid + Pottassium + Riboflavin + Selenium + Vitamin A + Vitamin B1 + Vitamin D3 + Vitamin', '1350 mg + 650 mcg + 550 mg + 200 mg + 70 mcg + 60 mcg + 200 mg + 500 mcg + 150 mg + 15 mg + 70 mg +', 0.00, 0.00, 0.00, 0, 0, '85.00 Tk', 0, 0, '096-0209-078', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1300, 8, 11, 'Bromhex', 'Bromhexine Hydrochloride', '4 mg/5 ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0074-031', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1301, 8, 11, 'Desofast', 'Desloratadine', '2.5 mg/5 ml', 0.00, 0.00, 0.00, 0, 0, '24.00 Tk', 0, 0, '096-0410-021', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1302, 8, 2, 'Ciprofloxacin-500', 'Ciprofloxacin', '500 mg', 0.00, 0.00, 0.00, 0, 0, '14.00 Tk', 0, 0, '096-0012-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1307, 8, 2, 'Boncal 500', 'Calcium Carbonate', '1250 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0018-062', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1308, 8, 2, 'Albutrim', 'Sulphamethoxazole + Trimethoprim', '800 mg + 160 mg', 0.00, 0.00, 0.00, 0, 0, '2.00 Tk', 0, 0, '096-0086-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1309, 8, 2, 'Albutrim', 'Sulphamethoxazole + Trimethoprim', '400 mg + 80 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0086-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1310, 8, 2, 'Ranitidine-150', 'Ranitidine', '150 mg', 0.00, 0.00, 0.00, 0, 0, '2.00 Tk', 0, 0, '096-0092-055', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1311, 8, 2, 'Rycin K', 'Phenoxymethyl Penicillin', '250 mg', 0.00, 0.00, 0.00, 0, 0, '1.54 Tk', 0, 0, '096-0090-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1312, 8, 2, 'Griscofalvin', 'Phenoxymethyl Penicillin', '500 mg', 0.00, 0.00, 0.00, 0, 0, '5.56 Tk', 0, 0, '096-0089-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1313, 8, 2, 'Domp', 'Domperidone', '10 mg', 0.00, 0.00, 0.00, 0, 0, '2.00 Tk', 0, 0, '096-0093-018', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1314, 8, 2, 'Alflam-400', 'Ibuprofen', '400 mg', 0.00, 0.00, 0.00, 0, 0, '1.42 Tk', 0, 0, '096-0091-064', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1315, 8, 2, 'Polyvit-M', 'Ascorbic Acid + Calcium Pantothenate + Cupric Sulphate + Cyanocobalamin + Ferrous Sulphate + Folic Acid + Manganese Sulphate + Nicotinamide + Potassium Iodide + Potassium Sulphate + Pyridoxine Hydrochloride + Riboflavin + Vitamin A + Vitamin B1 + Vitamin', '60 mg + 10.92 mg + 2 mg + 6 mcg + 50 mg + 400 mcg + 1 mg + 20 mg + 196 mcg + 11.141 mg + 2 mg + 1.7', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0099-078', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1316, 8, 2, 'Polyvit-B', 'Nicotinamide + Pyridoxine Hydrochloride + Riboflavin + Vitamin B1', '20 mg + 2 mg + 2 mg + 5 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0100-078', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1317, 8, 2, 'Albiquin', 'Quinine Sulphate', '300 mg', 0.00, 0.00, 0.00, 0, 0, '6.40 Tk', 0, 0, '096-0102-024', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1318, 8, 2, 'Albendazole-DS', 'Albendazole', '400 mg', 0.00, 0.00, 0.00, 0, 0, '4.00 Tk', 0, 0, '096-0105-008', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1319, 8, 2, 'Alvita', 'Cyanocobalamin + Pyridoxine Hydrochloride + Vitamin B1', '200 mcg + 200 mg + 100 mg', 0.00, 0.00, 0.00, 0, 0, '5.00 Tk', 0, 0, '096-0106-078', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1320, 8, 2, 'Aceclofenac', 'Aceclofenac', '100 mg', 0.00, 0.00, 0.00, 0, 0, '2.50 Tk', 0, 0, '096-0108-064', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1321, 8, 2, 'Polyvit', 'Vitamin E', '200 mg', 0.00, 0.00, 0.00, 0, 0, '4.00 Tk', 0, 0, '096-0109-078', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1322, 8, 2, 'Calcium Forte Plus', 'Boron + Calcium + Copper + Magnesium + Manganese + Vitamin D3 + Zinc', '250 mcg + 600 mg + 1 mg + 40 mg + 1.8 mg + 5 mcg + 7.5 mg', 0.00, 0.00, 0.00, 0, 0, '3.30 Tk', 0, 0, '096-0118-062', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1323, 8, 2, 'Altapan 10', 'Hyoscine Butyl Bromide', '10 mg', 0.00, 0.00, 0.00, 0, 0, '1.83 Tk', 0, 0, '096-0115-011', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1324, 8, 2, 'Nitram', 'Nitrazepam', '5 mg', 0.00, 0.00, 0.00, 0, 0, '0.69 Tk', 0, 0, '096-0116-057', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1325, 8, 2, 'Pantoprazole 40', 'Pantoprazole', '40 mg', 0.00, 0.00, 0.00, 0, 0, '5.00 Tk', 0, 0, '096-0128-067', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1326, 8, 2, 'Pantoprazole 20', 'Pantoprazole', '20 mg', 0.00, 0.00, 0.00, 0, 0, '3.00 Tk', 0, 0, '096-0129-067', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1329, 8, 2, 'Losartan 25', 'Losartan Potassium', '25 mg', 0.00, 0.00, 0.00, 0, 0, '4.00 Tk', 0, 0, '096-0132-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1330, 8, 2, 'Tanpot 50', 'Losartan Potassium', '50 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0133-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1331, 8, 2, 'Korac', 'Ketorolac Tromethamine', '10 mg', 0.00, 0.00, 0.00, 0, 0, '10.00 Tk', 0, 0, '096-0134-064', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1332, 8, 2, 'Venlin 2 mg', 'Salbutamol', '2 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0135-044', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1333, 8, 2, 'Venlin 4 mg', 'Salbutamol', '4 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0136-044', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1336, 8, 2, 'Famotidine 20', 'Famotidine', '20 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0144-055', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1337, 8, 2, 'Famotidine 40', 'Famotidine', '40 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0145-055', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1338, 8, 2, 'Zium', 'Clobazam', '10 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0146-046', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1339, 8, 2, 'Ketoprofen 50', 'Ketoprofen', '50 mg', 0.00, 0.00, 0.00, 0, 0, '3.50 Tk', 0, 0, '096-0147-064', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1342, 8, 2, 'Ketoprofen 100', 'Ketoprofen', '100 mg', 0.00, 0.00, 0.00, 0, 0, '6.00 Tk', 0, 0, '096-0151-064', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1343, 8, 2, 'Aexidal', 'Mebhydrolin', '50 mg', 0.00, 0.00, 0.00, 0, 0, '2.00 Tk', 0, 0, '096-0152-021', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1344, 8, 2, 'Etoricoxib 90', 'Etoricoxib', '90 mg', 0.00, 0.00, 0.00, 0, 0, '12.00 Tk', 0, 0, '096-0164-064', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1345, 8, 2, 'Etoricoxib', 'Etoricoxib', '60 mg', 0.00, 0.00, 0.00, 0, 0, '7.00 Tk', 0, 0, '096-0165-064', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1346, 8, 2, 'Rabeprazole 20', 'Rabeprazole Sodium', '20 mg', 0.00, 0.00, 0.00, 0, 0, '5.00 Tk', 0, 0, '096-0166-067', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1347, 8, 2, 'Aenixit', 'Flupenthixol + Melitracen', '500 mcg + 10 mg', 0.00, 0.00, 0.00, 0, 0, '3.50 Tk', 0, 0, '096-0167-028', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1348, 8, 2, 'Amofast 10', 'Amlodipine', '10 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0168-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1349, 8, 2, 'Amofast Plus 25', 'Amlodipine + Atenolol', '5 mg + 25 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0169-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1350, 8, 2, 'Amofast Plus 50', 'Amlodipine + Atenolol', '5 mg + 50 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0170-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1351, 8, 2, 'Glibenol', 'Glibenclamide', '5 mg', 0.00, 0.00, 0.00, 0, 0, '0.30 Tk', 0, 0, '096-0171-015', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1352, 8, 2, 'M-Fort 500', 'Metformin Hydrochloride', '500 mg', 0.00, 0.00, 0.00, 0, 0, '3.50 Tk', 0, 0, '096-0172-015', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1353, 8, 2, 'Losartan 100', 'Losartan Potassium', '100 mg', 0.00, 0.00, 0.00, 0, 0, '10.00 Tk', 0, 0, '096-0173-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1354, 8, 2, 'Diltiazem 30', 'Diltiazem Hydrochloride', '30 mg', 0.00, 0.00, 0.00, 0, 0, '2.00 Tk', 0, 0, '096-0174-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1355, 8, 2, 'Diltiazem 60', 'Diltiazem Hydrochloride', '60 mg', 0.00, 0.00, 0.00, 0, 0, '3.80 Tk', 0, 0, '096-0175-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1356, 8, 2, 'Allerge 120', 'Fexofenadine Hydrochloride', '120 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0176-021', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1357, 8, 2, 'Allerge 180', 'Fexofenadine Hydrochloride', '180 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0177-021', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1358, 8, 2, 'Brom', 'Bromazepam', '3 mg', 0.00, 0.00, 0.00, 0, 0, '5.00 Tk', 0, 0, '096-0178-057', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1359, 8, 2, 'Etoricoxib 120', 'Etoricoxib', '120 mg', 0.00, 0.00, 0.00, 0, 0, '14.00 Tk', 0, 0, '096-0179-064', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1360, 8, 2, 'Altovas-10', 'Atorvastatin', '10 mg', 0.00, 0.00, 0.00, 0, 0, '10.00 Tk', 0, 0, '096-0180-061', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1361, 8, 2, 'Altovas-20', 'Atorvastatin', '20 mg', 0.00, 0.00, 0.00, 0, 0, '18.00 Tk', 0, 0, '096-0181-061', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1362, 8, 2, 'Cefuxim-250', 'Cefuroxime', '250 mg', 0.00, 0.00, 0.00, 0, 0, '25.00 Tk', 0, 0, '096-0182-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1363, 8, 2, 'Cefuxim-500', 'Cefuroxime', '500 mg', 0.00, 0.00, 0.00, 0, 0, '45.00 Tk', 0, 0, '096-0183-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1364, 8, 2, 'Reptylin 10', 'Amitriptyline Hydrochloride', '10 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0184-014', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1365, 8, 2, 'Reptylin 25', 'Amitriptyline Hydrochloride', '25 mg', 0.00, 0.00, 0.00, 0, 0, '1.00 Tk', 0, 0, '096-0185-014', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1366, 8, 2, 'Alprazol 0.25', 'Alprazolam', '.25 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0186-057', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1367, 8, 2, 'M-Fort 850', 'Metformin Hydrochloride', '850 mg', 0.00, 0.00, 0.00, 0, 0, '5.00 Tk', 0, 0, '096-0187-015', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1368, 8, 2, 'Desloratadine', 'Desloratadine', '5 mg', 0.00, 0.00, 0.00, 0, 0, '2.50 Tk', 0, 0, '096-0196-021', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1369, 8, 2, 'Albipen-10', 'Baclofen', '10 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0197-070', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1370, 8, 2, 'Alprazole 0.5', 'Alprazolam', '.5 mg', 0.00, 0.00, 0.00, 0, 0, '2.00 Tk', 0, 0, '096-0199-057', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1371, 8, 2, 'Haloperidol 5', 'Haloperidol', '5 mg', 0.00, 0.00, 0.00, 0, 0, '1.00 Tk', 0, 0, '096-0200-028', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1373, 8, 2, 'Cinnarizine 15', 'Cinnarizine', '15 mg', 0.00, 0.00, 0.00, 0, 0, '1.00 Tk', 0, 0, '096-0202-021', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1374, 8, 2, 'Nifedipine 10', 'Nifedipine', '10 mg', 0.00, 0.00, 0.00, 0, 0, '0.34 Tk', 0, 0, '096-0203-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1375, 8, 2, 'Gabapentin 300', 'Gabapentin', '300 mg', 0.00, 0.00, 0.00, 0, 0, '16.00 Tk', 0, 0, '096-0208-046', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1376, 8, 2, 'Polyvit Plus A to Z Silver', 'Ascorbic Acid + Biotin + Boron + Calcium Carbonate + Chromium + Copper + Cyanocobalamin + Diabasic Calcium Phosphate + Elemental Iron + Folic Acid + Iodine + Lutein + Magnesium + Manganese + Molybdenum + Niacin + Nickel + Pantothenic acid + Potassium Chlo', '60 mg + 30 mcg + 150 mcg + 52.49 mg + 120 mcg + 2 mg + 6 mcg + 478.695 mg + 18 mg + 400 mcg + 150 mc', 0.00, 0.00, 0.00, 0, 0, '6.00 Tk', 0, 0, '096-0216-078', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1378, 8, 2, 'Glimepiride 1', 'Glimepiride', '1 mg', 0.00, 0.00, 0.00, 0, 0, '3.00 Tk', 0, 0, '096-0211-015', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1379, 8, 2, 'Mebeverine 135', 'Mebeverine Hydrochloride', '135 mg', 0.00, 0.00, 0.00, 0, 0, '6.00 Tk', 0, 0, '096-0212-011', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1381, 8, 2, 'Azithromycin 500', 'Azithromycin', '500 mg', 0.00, 0.00, 0.00, 0, 0, '30.00 Tk', 0, 0, '096-0214-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1383, 8, 2, 'Gabapentin 600', 'Gabapentin', '600 mg', 0.00, 0.00, 0.00, 0, 0, '30.00 Tk', 0, 0, '096-0225-046', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1384, 8, 2, 'Lorazepam 1', 'Lorazepam', '1 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0226-057', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1386, 8, 2, 'Terbinafine 250', 'Terbinafine', '250 mg', 0.00, 0.00, 0.00, 0, 0, '50.00 Tk', 0, 0, '096-0228-020', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1387, 8, 2, 'Enalapril 5', 'Enalapril Maleate', '5 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0229-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1388, 8, 2, 'Enalapril 10', 'Enalapril Maleate', '10 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0230-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1389, 8, 2, 'Losapot-H', 'Hydrochlorothiazide + Losartan Potassium', '12.5 mg + 50 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0231-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1391, 8, 2, 'Glimepiride 2', 'Glimepiride', '2 mg', 0.00, 0.00, 0.00, 0, 0, '5.01 Tk', 0, 0, '096-0233-015', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1392, 8, 2, 'Phenobarbital 30', 'Phenobarbitone', '30 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0234-046', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1393, 8, 2, 'Phenobarbital 60', 'Phenobarbitone', '60 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0235-046', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1395, 8, 2, 'Vitamin B1', 'Thiamine Hydrochloride', '100 mg', 0.00, 0.00, 0.00, 0, 0, '0.74 Tk', 0, 0, '096-0258-078', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1396, 8, 2, 'Phenobarbital 15', 'Phenobarbitone', '15 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0262-046', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1397, 8, 2, 'Captopril 25', 'Captopril', '25 mg', 0.00, 0.00, 0.00, 0, 0, '3.00 Tk', 0, 0, '096-0263-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1398, 8, 2, 'Simvastatin 10', 'Simvastatin', '10 mg', 0.00, 0.00, 0.00, 0, 0, '15.00 Tk', 0, 0, '096-0265-061', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1399, 8, 2, 'Verapamil 80', 'Verapamil Hydrochloride', '80 mg', 0.00, 0.00, 0.00, 0, 0, '3.00 Tk', 0, 0, '096-0267-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1400, 8, 2, 'Dexibuprofen 300', 'Dexibuprofen (S Ibuprofen)', '300 mg', 0.00, 0.00, 0.00, 0, 0, '4.00 Tk', 0, 0, '096-0269-064', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1401, 8, 2, 'Esofour 20', 'Esomeprazole', '20 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0157-067', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1402, 8, 2, 'Esofour 40', 'Esomeprazole', '40 mg', 0.00, 0.00, 0.00, 0, 0, '7.00 Tk', 0, 0, '096-0274-067', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1403, 8, 2, 'Altason-5', 'Prednisolone', '5 mg', 0.00, 0.00, 0.00, 0, 0, '1.14 Tk', 0, 0, '096-0276-072', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1404, 8, 2, 'Altason-10', 'Prednisolone', '10 mg', 0.00, 0.00, 0.00, 0, 0, '2.07 Tk', 0, 0, '096-0277-072', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1405, 8, 2, 'Altason-20', 'Prednisolone', '20 mg', 0.00, 0.00, 0.00, 0, 0, '3.73 Tk', 0, 0, '096-0278-072', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1407, 8, 2, 'Trazapin-15', 'Mirtazapine', '15 mg', 0.00, 0.00, 0.00, 0, 0, '8.00 Tk', 0, 0, '096-0297-014', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1408, 8, 2, 'Amofast 5', 'Amlodipine', '5 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0162-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1409, 8, 2, 'Monkon-4', 'Montelukast', '4 mg', 0.00, 0.00, 0.00, 0, 0, '7.00 Tk', 0, 0, '096-0301-044', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1410, 8, 2, 'Sparfloxacin 200', 'Sparfloxacin', '200 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0302-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1411, 8, 2, 'Epram-5', 'Escitalopram', '5 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0306-014', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1412, 8, 2, 'Rozavas 10', 'Rosuvastatin', '10 mg', 0.00, 0.00, 0.00, 0, 0, '20.07 Tk', 0, 0, '096-0307-061', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1413, 8, 2, 'Olme-H 20', 'Hydrochlorothiazide + Olmesartan Medoxomil', '12.5 mg + 20 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0308-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1414, 8, 2, 'Tadalafil 20', 'Tadalafil', '20 mg', 0.00, 0.00, 0.00, 0, 0, '60.00 Tk', 0, 0, '096-0309-043', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1415, 8, 2, 'Powergra 50', 'Sildenafil', '50 mg', 0.00, 0.00, 0.00, 0, 0, '30.00 Tk', 0, 0, '096-0310-043', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1416, 8, 2, 'Powergra 100', 'Sildenafil', '100 mg', 0.00, 0.00, 0.00, 0, 0, '50.00 Tk', 0, 0, '096-0311-043', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1417, 8, 2, 'Cilmox 500', 'Amoxicillin', '500 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0102-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1418, 8, 2, 'Cilmox 250', 'Amoxicillin', '250 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0101-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1419, 8, 2, 'Naproxen Plus 500', 'Esomeprazole + Naproxen', '20 mg + 500 mg', 0.00, 0.00, 0.00, 0, 0, '10.00 Tk', 0, 0, '096-0312-064', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1420, 8, 2, 'Epival', 'Sodium Valproate', '200 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0319-046', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1421, 8, 2, 'Clozapin 25', 'Clozapine', '25 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0320-014', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1422, 8, 2, 'Lithium SR', 'Lithium Carbonate', '400 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0321-028', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1423, 8, 2, 'Livacor 300', 'Ursodeoxycholic Acid', '300 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0322-075', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1424, 8, 2, 'Rislock 2', 'Risperidone', '2 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0323-028', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1425, 8, 2, 'Glirol-80', 'Gliclazide', '80 mg', 0.00, 0.00, 0.00, 0, 0, '6.00 Tk', 0, 0, '096-0160-015', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1427, 8, 2, 'Rozavas 5', 'Rosuvastatin', '5 mg', 0.00, 0.00, 0.00, 0, 0, '8.00 Tk', 0, 0, '096-0325-061', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1428, 8, 2, 'Epram 10', 'Escitalopram', '10 mg', 0.00, 0.00, 0.00, 0, 0, '10.00 Tk', 0, 0, '096-0326-014', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1429, 8, 2, 'Olme 40', 'Olmesartan Medoxomil', '40 mg', 0.00, 0.00, 0.00, 0, 0, '15.00 Tk', 0, 0, '096-0327-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1430, 8, 2, 'Olme 20', 'Olmesartan Medoxomil', '20 mg', 0.00, 0.00, 0.00, 0, 0, '8.00 Tk', 0, 0, '096-0328-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1431, 8, 2, 'Livacor 150', 'Ursodeoxycholic Acid', '150 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0329-075', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1432, 8, 2, 'Aldopa 275', 'Carbidopa + Levodopa', '25 mg + 250 mg', 0.00, 0.00, 0.00, 0, 0, '6.00 Tk', 0, 0, '096-0330-025', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1433, 8, 2, 'Rislock-4', 'Risperidone', '4 mg', 0.00, 0.00, 0.00, 0, 0, '9.00 Tk', 0, 0, '096-0331-028', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1434, 8, 2, 'Olanza 10', 'Olanzapine', '10 mg', 0.00, 0.00, 0.00, 0, 0, '4.52 Tk', 0, 0, '096-0333-028', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1435, 8, 2, 'Quetinil 100', 'Quetiapine', '100 mg', 0.00, 0.00, 0.00, 0, 0, '10.50 Tk', 0, 0, '096-0334-028', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1436, 8, 2, 'Sertlin 50', 'Sertraline', '50 mg', 0.00, 0.00, 0.00, 0, 0, '6.00 Tk', 0, 0, '096-0335-014', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1437, 8, 2, 'Rislock 1', 'Risperidone', '1 mg', 0.00, 0.00, 0.00, 0, 0, '3.00 Tk', 0, 0, '096-0337-028', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1438, 8, 2, 'Epival Chrono 300 CR', 'Sodium Valproate', '300 mg', 0.00, 0.00, 0.00, 0, 0, '7.00 Tk', 0, 0, '096-0338-046', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1439, 8, 2, 'Epival Chrono 500 CR', 'Sodium Valproate', '500 mg', 0.00, 0.00, 0.00, 0, 0, '11.00 Tk', 0, 0, '096-0339-046', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1440, 8, 2, 'Clozapin 100', 'Clozapine', '100 mg', 0.00, 0.00, 0.00, 0, 0, '9.55 Tk', 0, 0, '096-0342-014', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1441, 8, 2, 'Olme-AM', 'Amlodipine + Olmesartan Medoxomil', '5 mg + 20 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0344-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1442, 8, 2, 'Plator Plus', 'Aspirin + Clopidogrel', '75 mg + 75 mg', 0.00, 0.00, 0.00, 0, 0, '12.00 Tk', 0, 0, '096-0346-026', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1443, 8, 2, 'Osteonil', 'Ibandronic Acid', '150 mg', 0.00, 0.00, 0.00, 0, 0, '1500.00 Tk', 0, 0, '096-0347-048', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1444, 8, 2, 'Olme 10', 'Olmesartan Medoxomil', '10 mg', 0.00, 0.00, 0.00, 0, 0, '5.00 Tk', 0, 0, '096-0348-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1445, 8, 2, 'Monkon 10', 'Montelukast', '10 mg', 0.00, 0.00, 0.00, 0, 0, '14.00 Tk', 0, 0, '096-0349-044', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1446, 8, 2, 'Sertlin-25', 'Sertraline', '25 mg', 0.00, 0.00, 0.00, 0, 0, '3.00 Tk', 0, 0, '096-0350-014', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1447, 8, 2, 'Sertlin-100', 'Sertraline', '100 mg', 0.00, 0.00, 0.00, 0, 0, '10.00 Tk', 0, 0, '096-0351-014', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1448, 8, 2, 'Quetinil 25', 'Quetiapine', '25 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0352-028', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1449, 8, 2, 'Olanza-5', 'Olanzapine', '5 mg', 0.00, 0.00, 0.00, 0, 0, '2.55 Tk', 0, 0, '096-0353-028', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1450, 8, 2, 'Aldopa-110', 'Carbidopa + Levodopa', '10 mg + 100 mg', 0.00, 0.00, 0.00, 0, 0, '7.00 Tk', 0, 0, '096-0354-025', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1451, 8, 2, 'Plator', 'Clopidogrel', '75 mg', 0.00, 0.00, 0.00, 0, 0, '12.00 Tk', 0, 0, '096-0355-026', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1452, 8, 2, 'Reclevus-50 F. C', 'Vildagliptin', '50 mg', 0.00, 0.00, 0.00, 0, 0, '17.50 Tk', 0, 0, '096-0363-015', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1453, 8, 2, 'Reclevus Met F. C', 'Metformin Hydrochloride + Vildagliptin', '500 mg + 50 mg', 0.00, 0.00, 0.00, 0, 0, '20.50 Tk', 0, 0, '096-0364-015', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1454, 8, 2, 'Monkon-5', 'Montelukast', '5 mg', 0.00, 0.00, 0.00, 0, 0, '8.00 Tk', 0, 0, '096-0367-044', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1455, 8, 2, 'Isolol-2.5', 'Bisoprolol Hemifumarate', '2.5 mg', 0.00, 0.00, 0.00, 0, 0, '6.02 Tk', 0, 0, '096-0368-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1456, 8, 2, 'Isolol-5 F.C', 'Bisoprolol Hemifumarate', '5 mg', 0.00, 0.00, 0.00, 0, 0, '10.00 Tk', 0, 0, '096-0369-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1457, 8, 2, 'Inco SR', 'Indapamide', '1.5 mg', 0.00, 0.00, 0.00, 0, 0, '5.00 Tk', 0, 0, '096-0370-042', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1458, 8, 2, 'Bpcare-80', 'Valsartan', '80 mg', 0.00, 0.00, 0.00, 0, 0, '10.00 Tk', 0, 0, '096-0371-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1459, 8, 2, 'Felo-5', 'Baclofen', '5 mg', 0.00, 0.00, 0.00, 0, 0, '4.52 Tk', 0, 0, '096-0372-070', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1460, 8, 2, 'Bpcare-160', 'Valsartan', '160 mg', 0.00, 0.00, 0.00, 0, 0, '17.50 Tk', 0, 0, '096-0373-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1461, 8, 2, 'Floxtat 40', 'Febuxostat', '40 mg', 0.00, 0.00, 0.00, 0, 0, '12.00 Tk', 0, 0, '096-0379-076', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1462, 8, 2, 'Reclevus Met 50 mg/850 mg', 'Metformin Hydrochloride + Vildagliptin', '850 mg + 50 mg', 0.00, 0.00, 0.00, 0, 0, '22.00 Tk', 0, 0, '096-0381-015', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1463, 8, 2, 'N-Aspa', 'Drotaverine Hydrochloride', '40 mg', 0.00, 0.00, 0.00, 0, 0, '1.81 Tk', 0, 0, '096-0154-011', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1464, 8, 2, 'Trazapin 30', 'Mirtazapine', '30 mg', 0.00, 0.00, 0.00, 0, 0, '15.00 Tk', 0, 0, '096-0385-014', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1465, 8, 2, 'Cetirizine Tablet', 'Cetirizine Dihydrochloride', '10 mg', 0.00, 0.00, 0.00, 0, 0, '2.50 Tk', 0, 0, '096-0094-021', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1466, 8, 2, 'Amoxy-CP-375', 'Amoxicillin + Clavulanic Acid', '250 mg + 125 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0242-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1467, 8, 2, 'Amoxy-CP 625', 'Amoxicillin + Clavulanic Acid', '500 mg + 125 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0247-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1468, 8, 2, 'Calcium-D', 'Calcium + Vitamin D3', '500 mg + 200 IU', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0104-062', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1469, 8, 2, 'Trazapin 7.5', 'Mirtazapine', '7.5 mg', 0.00, 0.00, 0.00, 0, 0, '6.00 Tk', 0, 0, '096-0388-014', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1470, 8, 2, 'Calfast DX', 'Calcium + Cholecalciferol (Vit. D3)', '600 mg + 400 IU', 0.00, 0.00, 0.00, 0, 0, '8.00 Tk', 0, 0, '096-0390-062', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1471, 8, 2, 'Alcavir-0.5', 'Entecavir', '.5 mg', 0.00, 0.00, 0.00, 0, 0, '45.00 Tk', 0, 0, '096-0392-032', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1472, 8, 2, 'Oxipine 300', 'Oxcarbazepine', '300 mg', 0.00, 0.00, 0.00, 0, 0, '11.00 Tk', 0, 0, '096-0393-046', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1473, 8, 2, 'BPCARE AM 5/80', 'Amlodipine + Valsartan', '5 mg + 80 mg', 0.00, 0.00, 0.00, 0, 0, '8.50 Tk', 0, 0, '096-0395-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1474, 8, 2, 'Albizox 500', 'Nitazoxanide', '500 mg', 0.00, 0.00, 0.00, 0, 0, '9.00 Tk', 0, 0, '096-0396-027', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1475, 8, 2, 'BPCARE AM 5/160', 'Amlodipine + Valsartan', '5 mg + 160 mg', 0.00, 0.00, 0.00, 0, 0, '15.00 Tk', 0, 0, '096-0397-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1476, 8, 2, 'Tysul', 'Tiemonium Methylsulphate', '50 mg', 0.00, 0.00, 0.00, 0, 0, '5.00 Tk', 0, 0, '096-0411-011', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1477, 8, 2, 'Levocetirizine', 'Levocetirizine Hydrochloride', '5 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0420-021', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1478, 8, 2, 'Alvit A TO Z Gold', 'Ascorbic Acid + Biotin + Boron + Calcium + Chromium + Copper + Cyanocobalamin + Elemental Iron + Folic Acid + Iodine + Lutein + Magnesium + Manganese + Molybdenum + Niacin + Nickel + Pantothenic acid + Phosphorous + Pottassium + Pyridoxine Hydrochloride +', '60 mg + 30 mcg + 150 mcg + 162 mg + 120 mcg + 2 mg + 6 mcg + 18 mg + 400 mcg + 150 mcg + 250 mcg + 1', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0423-078', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1479, 8, 2, 'Cefuximclav-250', 'Cefuroxime + Clavulanic Acid', '250 mg + 62.5 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0430-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1480, 8, 2, 'Cefuximclav-500', 'Cefuroxime + Clavulanic Acid', '500 mg + 125 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0431-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1481, 8, 2, 'Renaliv-5', 'Linagliptin', '5 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0425-015', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1482, 8, 2, 'Renaliv Met 2.5/500', 'Linagliptin + Metformin Hydrochloride', '2.5 mg + 500 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0426-015', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1483, 8, 19, 'Para-AL Vet', 'Paracetamol', '2 gm', 0.00, 0.00, 0.00, 0, 0, '2.25 Tk', 0, 0, '096-0188-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1484, 8, 19, 'Oxytetracin', 'Oxytetracycline', '500 mg', 0.00, 0.00, 0.00, 0, 0, '3.00 Tk', 0, 0, '096-0189-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1485, 8, 19, 'Al-Sul3 Vet', 'Sulphadiazine + Sulphadimidine + Sulphapyridine', '1.666 gm + 1.666 gm + 1.666 gm', 0.00, 0.00, 0.00, 0, 0, '16.50 Tk', 0, 0, '096-0191-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1486, 8, 19, 'Bendol-Al', 'Albendazole', '600 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0192-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1487, 8, 19, 'Albutrim Vet', 'Sulphamethoxazole + Trimethoprim', '1000 mg + 200 mg', 0.00, 0.00, 0.00, 0, 0, '2.15 Tk', 0, 0, '096-0193-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1488, 8, 19, 'AL-Lev Vet', 'Levamisole', '600 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0194-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1489, 8, 19, 'Al-Metro', 'Metronidazole', '2 gm', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0206-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1490, 8, 19, 'Albinid Vet', 'Oxyclozanide + Tetramisole Hydrochloride', '1.4 gm + 2 gm', 0.00, 0.00, 0.00, 0, 0, '20.23 Tk', 0, 0, '096-0217-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1491, 8, 19, 'Albixon (Vet)', 'Choline + Cobalt + Cyanocobalamin + Ferrous Sulphate + Vitamin B1', '9.1 mg + 50 mg + 20 mcg + 100 mg + 25 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0218-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1492, 8, 19, 'Altrim (Vet)', 'Sulphadiazine + Trimethoprim', '1000 mg + 200 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0219-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1493, 8, 19, 'Ciptec-Al Vet', 'Ciprofloxacin', '750 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0221-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1494, 8, 19, 'Fenbendazole 250', 'Fenbendazole', '250 mg', 0.00, 0.00, 0.00, 0, 0, '5.75 Tk', 0, 0, '096-0238-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1495, 8, 19, 'Albidex Vet', 'Levamisole + Triclabendazole', '600 mg + 900 mg', 0.00, 0.00, 0.00, 0, 0, '24.50 Tk', 0, 0, '096-0268-007', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1496, 8, 19, 'Albenton-Vet', 'Antimony Potassium Tartrate + Ferrous Sulphate', '2 gm + 2 gm', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0291-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1497, 8, 19, 'Dexason-Vet', 'Dexamethasone', '10 mg', 0.00, 0.00, 0.00, 0, 0, '4.38 Tk', 0, 0, '096-0295-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1498, 8, 19, 'Meloxicam Vet', 'Meloxicam', '100 mg', 0.00, 0.00, 0.00, 0, 0, '6.00 Tk', 0, 0, '096-0296-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1499, 8, 19, 'Prom-Al Vet', 'Promethazine Hydrochloride', '150 mg', 0.00, 0.00, 0.00, 0, 0, '3.32 Tk', 0, 0, '096-0340-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1500, 8, 19, 'Ciptec-Al Vet', 'Ciprofloxacin', '1 gm', 0.00, 0.00, 0.00, 0, 0, '20.08 Tk', 0, 0, '096-0341-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1501, 8, 19, 'Mimox Vet', 'Amoxicillin', '500 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0357-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1502, 8, 19, 'AL-KETO (VET0', 'Ketoprofen', '400 mg', 0.00, 0.00, 0.00, 0, 0, '9.00 Tk', 0, 0, '096-0375-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1503, 8, 19, 'Sulnid (Vet)', 'Sulphadimidine', '5 gm', 0.00, 0.00, 0.00, 0, 0, '9.68 Tk', 0, 0, '096-0378-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1504, 8, 19, 'Albixon-DS (Vet)', 'Choline Bitartrate + Cobalt Sulfate + Cyanocobalamin + Ferrous Sulphate + Thiamine Mononitrate (B1)', '18.2 mg + 100 mg + 40 mcg + 200 mg + 50 mg', 0.00, 0.00, 0.00, 0, 0, '3.25 Tk', 0, 0, '096-0387-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1505, 8, 20, 'Chloramphenical E/E', 'Chloramphenicol', '5 mg/ml', 0.00, 0.00, 0.00, 0, 0, '25.00 Tk', 0, 0, '096-0027-052', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1506, 8, 20, 'Zeprox', 'Ciprofloxacin', '300 mg/100 ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0427-052', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1507, 8, 14, 'Forticef 1 gm IM', 'Ceftriaxone', '1 gm', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0401-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1508, 8, 14, 'Relnac Plus', 'Diclofenac + Lidocaine Hydrochloride', '75 mg + 20 mg/2 ml', 0.00, 0.00, 0.00, 0, 0, '14.00 Tk', 0, 0, '096-0403-064', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1509, 8, 14, 'Forticef 1 gm IV', 'Ceftriaxone', '1 gm', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0404-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1510, 8, 12, 'Oral Saline', 'Dextrose Anhydrous + Potassium Chloride + Sodium Chloride + Trisodium Citrate', '10 gm + 750 gm + 1.75 gm + 1.45 gm/500 ml', 0.00, 0.00, 0.00, 0, 0, '3.20 Tk', 0, 0, '096-0041-079', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1511, 8, 12, 'Oral Saline Albion', 'Dextrose Anhydrous + Potassium Chloride + Sodium Chloride + Trisodium Citrate', '10 gm + 750 gm + 1.75 gm + 1.45 gm/500 ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096--079', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1512, 8, 12, 'Albion Oralsaline', 'Anhydrous Glucose + Potassium Chloride + Sodium Chloride + Trisodium Citrate', '6.75 gm + 750 mg + 1.3 gm + 1.45 gm', 0.00, 0.00, 0.00, 0, 0, '5.00 Tk', 0, 0, '096-0417-079', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1513, 8, 13, 'Cefradine', 'Cephradine', '125 mg/1.25 ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0064-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1514, 8, 13, 'Polyvit', 'Nicotinamide + Pantothenic acid + Pyridoxine Hydrochloride + Riboflavin + Vitamin A + Vitamin B1 + Vitamin C + Vitamin D', '10 mg + 5 mg + 1 mg + 1 mg + 5000 IU + 1.6 mg + 50 mg + 1000 IU/ml', 0.00, 0.00, 0.00, 0, 0, '14.20 Tk', 0, 0, '096-0022-078', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1515, 8, 13, 'Cefpodoxime', 'Cefpodoxime', '20 mg/ml', 0.00, 0.00, 0.00, 0, 0, '60.00 Tk', 0, 0, '096-0140-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL);
INSERT INTO `medicines` (`id`, `company_id`, `medicine_type_id`, `name`, `generic_name`, `strength`, `tp_per_box`, `vat_per_box`, `mrp_per_box`, `pcs_per_box`, `pcs_per_strip`, `price_per_box`, `price_per_strip`, `price_per_pcs`, `dar_no`, `is_imported`, `is_antibiotic`, `product_type`, `status`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1516, 8, 4, 'Cefradine', 'Cephradine', '125 mg/5 ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0063-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1517, 8, 4, 'Alfux-DS', 'Flucloxacillin', '125 mg/5 ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0052-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1518, 8, 4, 'Mimox', 'Amoxicillin', '125 mg/5 ml', 0.00, 0.00, 0.00, 0, 0, '46.00 Tk', 0, 0, '096-0048-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1521, 8, 4, 'Azithron', 'Azithromycin', '200 mg/5 ml', 0.00, 0.00, 0.00, 0, 0, '85.00 Tk', 0, 0, '096-0104-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1522, 8, 4, 'Cefiac', 'Cefixime', '100 mg/5 ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0142-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1523, 8, 4, 'Cefuxim', 'Cefuroxime', '125 mg/5 ml', 0.00, 0.00, 0.00, 0, 0, '198.00 Tk', 0, 0, '096-0223-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1524, 8, 4, 'Cepox', 'Cefpodoxime', '40 mg/5 ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '096-0112-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(1526, 8, 4, 'Erythromycin DS', 'Erythromycin', '125 mg/5 ml', 0.00, 0.00, 0.00, 0, 0, '60.00 Tk', 0, 0, '096-0059-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(2816, 18, 2, 'Acliz', 'Meclizine Hydrochloride', '50 mg', 187.41, 32.61, 250.00, 100, 0, '2.50 Tk', 0, 0, '143-0224-018', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:19', '2019-10-30 04:37:19', NULL),
(2817, 18, 2, 'Actine 5', 'Glipizide', '5 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '143-0233-015', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(2818, 18, 2, 'Agoxin', 'Digoxin', '250 mcg', 81.71, 14.22, 109.00, 100, 0, '1.09 Tk', 0, 0, '143-0232-035', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:19', '2019-10-30 04:37:19', NULL),
(2819, 18, 2, 'Alexid 200', 'Pivmecillinam', '200 mg', 562.22, 97.83, 750.00, 50, 0, '15.00 Tk', 0, 0, '143-0184-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:19', '2019-10-30 04:37:19', NULL),
(2820, 18, 2, 'Alfa E 200', 'Vitamin E', '200 mg', 56.22, 9.78, 75.00, 15, 0, '5.00 Tk', 0, 0, '143-0108-078', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:19', '2019-10-30 04:37:19', NULL),
(2821, 18, 2, 'Ametil', 'Prochlorperazine Maleate', '5 mg', 172.41, 30.00, 229.99, 500, 0, '0.46 Tk', 0, 0, '143-0030-018', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:19', '2019-10-30 04:37:19', NULL),
(2822, 18, 2, 'Anfree', 'Flupenthixol + Melitracen', '500 mcg + 10 mg', 374.81, 65.22, 500.00, 100, 0, '5.00 Tk', 0, 0, '143-0248-028', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:19', '2019-10-30 04:37:19', NULL),
(2823, 18, 2, 'Aplet 100', 'Cilostazol', '100 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '143-0256-036', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(2824, 18, 2, 'Aplet 50', 'Cilostazol', '50 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '143-0255-036', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(2825, 18, 2, 'Aprocin 250', 'Ciprofloxacin', '250 mg', 0.00, 0.00, 0.00, 0, 0, '8.50 Tk', 0, 0, '143-0049-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(2826, 18, 2, 'Aprocin 500', 'Ciprofloxacin', '500 mg', 337.33, 58.70, 450.00, 30, 0, '15.00 Tk', 0, 0, '143-0079-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(2827, 18, 2, 'Aprozil 500', 'Cefprozil', '500 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '143-0283-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(2828, 18, 2, 'Apuldon', 'Domperidone', '10 mg', 187.41, 32.61, 250.00, 100, 0, '2.50 Tk', 0, 0, '143-0147-018', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(2829, 18, 2, 'Arotril 0.5', 'Clonazepam', '.5 mg', 449.78, 78.26, 600.01, 100, 0, '', 0, 0, '143-0210-046', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(2830, 18, 2, 'Arotril 2', 'Clonazepam', '2 mg', 224.89, 39.13, 300.00, 30, 0, '10.00 Tk', 0, 0, '143-0209-046', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(2831, 18, 2, 'Aspin 75', 'Aspirin', '75 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '143-0067-026', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(2834, 18, 2, 'Bactacin', 'Sulphamethoxazole + Trimethoprim', '800 mg + 160 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '143-0055-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(2835, 18, 2, 'Calbon 500', 'Calcium Carbonate', '1250 mg', 168.68, 29.35, 225.02, 45, 0, '5.00 Tk', 0, 0, '143-0133-062', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(2837, 18, 2, 'Caljuven Chewable 250', 'Calcium Carbonate', '625 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '143-0146-062', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(2838, 18, 2, 'Carmaz 200', 'Carbamazepine', '200 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '143-0236-046', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(2839, 18, 2, 'Clovul 50', 'Clomiphene Citrate', '50 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '143-0218-053', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(2840, 18, 2, 'Contine CR 250', 'Theophylline', '250 mg', 0.00, 0.00, 0.00, 0, 0, '1.77 Tk', 0, 0, '143-0211-044', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(2841, 18, 2, 'Contine CR 400', 'Theophylline', '400 mg', 223.39, 38.87, 298.00, 100, 0, '2.98 Tk', 0, 0, '143-0212-044', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(2842, 18, 2, 'Digel', 'Aluminium Hydroxide + Magnesium Hydroxide', '250 mg + 400 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '143-0022-007', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(2843, 18, 2, 'Emep 20', 'Esomeprazole', '20 mg', 224.89, 39.13, 300.00, 60, 0, '5.00 Tk', 0, 0, '143-0261-067', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(2844, 18, 2, 'Evalin 5', 'Diazepam', '5 mg', 254.87, 44.35, 340.00, 500, 0, '0.68 Tk', 0, 0, '143-0015-057', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(2845, 18, 2, 'Fruselac 20/50', 'Frusemide + Spironolactone', '20 mg + 50 mg', 0.00, 0.00, 0.00, 0, 0, '5.00 Tk', 0, 0, '143-0271-042', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(2846, 18, 2, 'Fruselac PLUS 40/50', 'Frusemide + Spironolactone', '40 mg + 50 mg', 0.00, 0.00, 0.00, 0, 0, '8.00 Tk', 0, 0, '143-0272-042', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(2847, 18, 2, 'Fusidate', 'Sodium Fusidate', '250 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '143-0159-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(2848, 18, 2, 'Giran 16', 'Candesartan Cilexetil', '16 mg', 247.38, 43.04, 330.00, 30, 0, '11.00 Tk', 0, 0, '143-0222-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(2849, 18, 2, 'Giran 8', 'Candesartan Cilexetil', '8 mg', 134.93, 23.48, 180.00, 30, 0, '6.00 Tk', 0, 0, '143-0221-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(2850, 18, 2, 'Glucomet 850', 'Metformin Hydrochloride', '850 mg', 269.87, 46.96, 360.01, 60, 0, '6.00 Tk', 0, 0, '143-0111-015', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(2851, 18, 2, 'Glucomet XR 500', 'Metformin Hydrochloride', '500 mg', 224.89, 39.13, 300.00, 50, 0, '6.00 Tk', 0, 0, '143-0282-015', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(2852, 18, 2, 'Glucomet 500', 'Metformin Hydrochloride', '500 mg', 299.85, 52.17, 400.00, 100, 0, '4.00 Tk', 0, 0, '143-0039-015', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(2853, 18, 2, 'Gluconor 1', 'Glimepiride', '1 mg', 224.89, 39.13, 300.00, 50, 0, '4.50 Tk', 0, 0, '143-0253-015', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(2854, 18, 2, 'Gluconor 2', 'Glimepiride', '2 mg', 202.40, 35.22, 270.00, 30, 0, '8.00 Tk', 0, 0, '143-0254-015', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(2855, 18, 2, 'Glucozid 80', 'Gliclazide', '80 mg', 262.37, 45.65, 350.00, 50, 0, '7.00 Tk', 0, 0, '143-0107-015', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(2856, 18, 2, 'Glucozon 15', 'Pioglitazone', '15 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '143-0163-015', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(2857, 18, 2, 'Ipec PLUS', 'Ferrous Sulphate + Folic Acid + Zinc', '150 mg + 500 mcg + 22.5 mg', 262.37, 45.65, 350.00, 100, 0, '3.50 Tk', 0, 0, '143-0264-045', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(2858, 18, 2, 'ISM 20', 'Isosorbide Mononitrate', '20 mg', 0.00, 0.00, 0.00, 0, 0, '1.20 Tk', 0, 0, '143-0077-040', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(2859, 18, 2, 'Lodicard 5/50', 'Amlodipine + Atenolol', '5 mg + 50 mg', 269.87, 46.96, 360.01, 60, 0, '6.00 Tk', 0, 0, '143-0281-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(2860, 18, 2, 'Lomeflox', 'Lomefloxacin', '400 mg', 224.89, 39.13, 300.00, 20, 0, '15.00 Tk', 0, 0, '143-0100-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(2861, 18, 2, 'TCL R 20', 'Atorvastatin', '20 mg', 269.87, 46.96, 360.01, 20, 0, '18.00 Tk', 0, 0, '143-0155-061', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:21', '2019-10-30 04:37:21', NULL),
(2862, 18, 2, 'Loradin', 'Loratadine', '10 mg', 0.00, 0.00, 0.00, 0, 0, '3.00 Tk', 0, 0, '143-0125-021', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(2863, 18, 2, 'Lumeran 150', 'Ranitidine', '150 mg', 0.00, 0.00, 0.00, 0, 0, '2.00 Tk', 0, 0, '143-0027-055', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(2864, 18, 2, 'Lumeran 300', 'Ranitidine', '300 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '143-0053-055', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(2865, 18, 2, 'Malarium', 'Mefloquine', '250 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '143-0239-024', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(2866, 18, 2, 'Mecol', 'Mecobalamin', '.5 mg', 149.93, 26.09, 200.01, 50, 0, '4.00 Tk', 0, 0, '143-0262-078', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(2867, 18, 2, 'Mervan', 'Aceclofenac', '100 mg', 299.85, 52.17, 400.00, 100, 0, '5.00 Tk', 0, 0, '143-0217-064', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(2868, 18, 2, 'Metrodol 400', 'Metronidazole', '400 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '143-0220-027', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(2869, 18, 2, 'Musclex 50', 'Tolperisone Hydrochloride', '50 mg', 187.41, 32.61, 250.00, 50, 0, '5.00 Tk', 0, 0, '143-0270-070', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(2870, 18, 2, 'Nalix', 'Nalidixic Acid', '500 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '143-0082-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(2871, 18, 2, 'Napro 250', 'Naproxen', '250 mg', 157.42, 27.39, 210.00, 50, 0, '4.20 Tk', 0, 0, '143-0056-064', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(2872, 18, 2, 'Napro 500', 'Naproxen', '500 mg', 157.42, 27.39, 210.00, 30, 0, '7.00 Tk', 0, 0, '143-0072-064', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(2873, 18, 2, 'Nezox 400', 'Linezolid', '400 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '143-0229-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(2874, 18, 2, 'Nezox 600', 'Linezolid', '600 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '143-0250-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(2875, 18, 2, 'Nitrocard SR 2.6', 'Glyceryl Trinitrate', '2.6 mg', 224.89, 39.13, 300.00, 60, 0, '5.00 Tk', 0, 0, '143-0274-040', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(2876, 18, 2, 'Lacicard-2', 'Lacidipine', '2 mg', 179.91, 31.30, 240.00, 60, 0, '', 0, 0, '143-0257-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(2877, 18, 2, 'Lacicard-4', 'Lacidipine', '4 mg', 134.93, 23.48, 180.00, 30, 0, '', 0, 0, '143-0258-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(2878, 18, 2, 'Notens', 'Bromazepam', '3 mg', 187.41, 32.61, 250.00, 50, 0, '5.00 Tk', 0, 0, '143-0219-057', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(2879, 18, 2, 'Omniflox 200', 'Sparfloxacin', '200 mg', 0.00, 0.00, 0.00, 0, 0, '18.00 Tk', 0, 0, '143-0110-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(2880, 18, 2, 'Optimox', 'Moxifloxacin', '400 mg', 299.85, 52.17, 400.00, 10, 0, '40.00 Tk', 0, 0, '143-0247-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(2881, 18, 2, 'Oradol 10', 'Ketorolac Tromethamine', '10 mg', 224.89, 39.13, 300.00, 30, 0, '10.00 Tk', 0, 0, '143-0120-064', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(2882, 18, 2, 'Osartan 50', 'Losartan Potassium', '50 mg', 179.91, 31.30, 240.00, 30, 0, '8.00 Tk', 0, 0, '143-0143-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(2883, 18, 2, 'Ovel 500', 'Levofloxacin', '500 mg', 337.33, 58.70, 450.00, 30, 0, '15.00 Tk', 0, 0, '143-0260-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(2884, 18, 2, 'Pinor', 'Imipramine Hydrochloride', '25 mg', 299.85, 52.17, 400.00, 100, 0, '4.00 Tk', 0, 0, '143-0223-014', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(2885, 18, 2, 'Proton P 40', 'Pantoprazole', '40 mg', 314.84, 54.78, 420.00, 60, 0, '7.00 Tk', 0, 0, '143-0151-067', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(2886, 18, 2, 'Proton P 20', 'Pantoprazole', '20 mg', 224.89, 39.13, 300.00, 60, 0, '5.00 Tk', 0, 0, '143-0183-067', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(2887, 18, 2, 'Rehaf', 'Levocetirizine Hydrochloride', '5 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '143-0249-021', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(2888, 18, 2, 'Rejoin', 'Chondroitin + Glucosamine', '200 mg + 250 mg', 0.00, 0.00, 0.00, 0, 0, '8.00 Tk', 0, 0, '143-0269-064', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(2889, 18, 2, 'Rhinil 10', 'Cetirizine Dihydrochloride', '10 mg', 224.89, 39.13, 300.00, 100, 0, '3.00 Tk', 0, 0, '143-0096-021', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:21', '2019-10-30 04:37:21', NULL),
(2890, 18, 2, 'Soval 200', 'Sodium Valproate', '200 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '143-0226-046', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(2891, 18, 2, 'Stafen', 'Ketotifen', '1 mg', 187.41, 32.61, 250.00, 100, 0, '2.50 Tk', 0, 0, '143-0051-021', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:21', '2019-10-30 04:37:21', NULL),
(2892, 18, 2, 'TCL 10', 'Atorvastatin', '10 mg', 0.00, 0.00, 0.00, 0, 0, '10.00 Tk', 0, 0, '143-0154-061', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(2893, 18, 2, 'Xpa', 'Paracetamol', '500 mg', 149.93, 26.09, 200.01, 250, 0, '0.80 Tk', 0, 0, '143-0016-006', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:21', '2019-10-30 04:37:21', NULL),
(2894, 18, 2, 'Tenocard 50', 'Atenolol', '50 mg', 56.22, 9.78, 75.00, 100, 0, '0.75 Tk', 0, 0, '143-0040-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:21', '2019-10-30 04:37:21', NULL),
(2895, 18, 2, 'Terbifin', 'Terbinafine', '250 mg', 449.78, 78.26, 600.01, 12, 0, '50.00 Tk', 0, 0, '143-0149-020', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:21', '2019-10-30 04:37:21', NULL),
(2896, 18, 2, 'Thiobion 100', 'Thiamine Hydrochloride', '100 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '143-0065-078', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(2897, 18, 2, 'Univit PLUS', 'Ascorbic Acid + Calcium Pantothenate + Cupric Sulphate + Cyanocobalamin + Ferrous Sulphate + Folic Acid + Manganese Sulphate + Nicotinamide + Potassium Iodide + Potassium Sulphate + Pyridoxine Hydrochloride + Riboflavin + Vitamin A + Vitamin B1 + Vitamin', '60 mg + 10.92 mg + 2 mg + 6 mcg + 50 mg + 400 mcg + 1 mg + 20 mg + 196 mcg + 11.141 mg + 2 mg + 1.7', 44.94, 7.82, 59.95, 30, 0, '2.00 Tk', 0, 0, '143-0093-078', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:21', '2019-10-30 04:37:21', NULL),
(2898, 18, 2, 'Univit B', 'Nicotinamide + Pyridoxine Hydrochloride + Riboflavin + Vitamin B1', '20 mg + 2 mg + 2 mg + 5 mg', 20.91, 3.64, 27.89, 45, 0, '0.62 Tk', 0, 0, '143-0038-078', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:21', '2019-10-30 04:37:21', NULL),
(2899, 18, 2, 'VC 250', 'Vitamin C', '250 mg', 284.86, 49.57, 380.00, 200, 0, '1.90 Tk', 0, 0, '143-0068-078', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:21', '2019-10-30 04:37:21', NULL),
(2900, 18, 2, 'Vinton 5', 'Vinpocetine', '5 mg', 299.85, 52.17, 400.00, 100, 0, '4.00 Tk', 0, 0, '143-0074-036', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:21', '2019-10-30 04:37:21', NULL),
(2901, 18, 2, 'Vitace', 'Betacarotene + Vitamin C + Vitamin E', '6 mg + 200 mg + 50 mg', 0.00, 0.00, 0.00, 0, 0, '3.00 Tk', 0, 0, '143-0102-078', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(2902, 18, 2, 'Vitace M', 'Ascorbic Acid + Copper + Manganese + Selenium + Vitamin A + Vitamin E + Vitamin K + Zinc', '200 mg + 1 mg + 3 mg + 70 mcg + 2000 IU + 50 IU + 75 mcg + 15 mg', 0.00, 0.00, 0.00, 0, 0, '4.00 Tk', 0, 0, '143-0277-078', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(2903, 18, 2, 'Zincin', 'Cinnarizine', '15 mg', 0.00, 0.00, 0.00, 0, 0, '1.00 Tk', 0, 0, '143-0052-021', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(2904, 18, 2, 'Zofen 0.5', 'Pizotifen', '500 mcg', 139.43, 24.26, 186.00, 60, 0, '3.10 Tk', 0, 0, '143-0121-047', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:21', '2019-10-30 04:37:21', NULL),
(2905, 18, 2, 'Zofen TS 1.5', 'Pizotifen', '1.5 mg', 161.92, 28.17, 216.00, 30, 0, '7.20 Tk', 0, 0, '143-0136-047', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:21', '2019-10-30 04:37:21', NULL),
(2906, 18, 2, 'Aristo GOLD', 'Ascorbic Acid + Biotin + Boron + Calcium + Chromium + Copper + Cyanocobalamin + Elemental Iron + Folic Acid + Iodine + Lutein + Magnesium + Manganese + Molybdenum + Niacin + Nickel + Pantothenic acid + Phosphorous + Pottassium + Pyridoxine Hydrochloride +', '60 mg + 30 mcg + 150 mcg + 162 mg + 120 mcg + 2 mg + 6 mcg + 18 mg + 400 mcg + 150 mcg + 250 mcg + 1', 78.71, 13.70, 105.00, 15, 0, '7.00 Tk', 0, 0, '143-0285-078', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(2907, 18, 2, 'Calbon D', 'Calcium + Vitamin D3', '500 mg + 200 IU', 78.71, 13.70, 105.00, 15, 0, '7.00 Tk', 0, 0, '143-0294-062', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(2908, 18, 2, 'Giran H', 'Candesartan Cilexetil + Hydrochlorothiazide', '8 mg + 12.5 mg', 134.93, 23.48, 180.00, 30, 0, '6.00 Tk', 0, 0, '143-0288-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(2910, 18, 2, 'Oralzin 20', 'Zinc', '20 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '143-0287-062', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(2911, 18, 2, 'Giran HP', 'Candesartan Cilexetil + Hydrochlorothiazide', '16 mg + 12.5 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '143-0289-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(2912, 18, 2, 'Aspin PLUS', 'Aspirin + Clopidogrel', '75 mg + 75 mg', 247.38, 43.04, 330.00, 30, 0, '11.00 Tk', 0, 0, '143-0298-026', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(2913, 18, 2, 'Neobion', 'Cyanocobalamin + Pyridoxine Hydrochloride + Vitamin B1', '200 mcg + 200 mg + 100 mg', 329.82, 57.39, 439.98, 60, 0, '8.00 Tk', 0, 0, '143-0299-078', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(2914, 18, 2, 'Veralgin', 'Tiemonium Methylsulphate', '50 mg', 224.89, 39.13, 300.00, 50, 0, '6.00 Tk', 0, 0, '143-0307-011', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:21', '2019-10-30 04:37:21', NULL),
(2915, 18, 2, 'Xpa C', 'Caffeine + Paracetamol', '65 mg + 500 mg', 374.81, 65.22, 500.00, 200, 0, '2.50 Tk', 0, 0, '143-0308-006', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:21', '2019-10-30 04:37:21', NULL),
(2916, 18, 2, 'Osartan 25', 'Losartan Potassium', '25 mg', 0.00, 0.00, 0.00, 0, 0, '4.50 Tk', 0, 0, '143-0334-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(2917, 18, 2, 'Osartan HZ 12.5/50', 'Hydrochlorothiazide + Losartan Potassium', '12.5 mg + 50 mg', 179.91, 31.30, 240.00, 30, 0, '8.00 Tk', 0, 0, '143-0335-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(2918, 18, 2, 'Athorel 75', 'Clopidogrel', '75 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '143-0337-026', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(2919, 18, 2, 'Ivactin 3', 'Ivermectin', '3 mg', 0.00, 0.00, 0.00, 0, 0, '6.00 Tk', 0, 0, '143-0325-008', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(2920, 18, 2, 'Sleepil 1', 'Eszopiclone', '1 mg', 449.78, 78.26, 600.01, 30, 0, '', 0, 0, '143-0344-057', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:21', '2019-10-30 04:37:21', NULL),
(2921, 18, 2, 'Sleepil 2', 'Eszopiclone', '2 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '143-0345-057', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(2922, 18, 2, 'Calbon M', 'Boron + Calcium + Copper + Magnesium + Manganese + Vitamin D + Zinc', '250 mcg + 600 mg + 1 mg + 40 mg + 1.8 mg + 200 IU + 7 mg', 0.00, 0.00, 0.00, 0, 0, '5.00 Tk', 0, 0, '143-0327-062', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(2923, 18, 2, 'Nitoxin 500', 'Nitazoxanide', '500 mg', 224.89, 39.13, 300.00, 30, 0, '10.00 Tk', 0, 0, '143-0336-027', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(2924, 18, 2, 'Metacard MR', 'Trimetazidine Dihydrochloride', '35 mg', 314.84, 54.78, 420.00, 60, 0, '6.00 Tk', 0, 0, '143-0338-040', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(2925, 18, 2, 'Asmolex L', 'Levosalbutamol', '1 mg', 0.00, 0.00, 0.00, 0, 0, '0.80 Tk', 0, 0, '143-0341-044', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(2926, 18, 2, 'Asmolex L', 'Levosalbutamol', '2 mg', 0.00, 0.00, 0.00, 0, 0, '1.50 Tk', 0, 0, '143-0342-044', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(2927, 18, 2, 'Calbon PLUS', 'Ascorbic Acid + Boron + Calcium + Copper + Magnesium + Manganese + Vitamin D3 + Vitamin E + Zinc', '60 mg + 250 mcg + 600 mg + 1 mg + 20 mg + 1 mg + 200 IU + 15 IU + 7.5 mg', 0.00, 0.00, 0.00, 0, 0, '5.50 Tk', 0, 0, '143-0353-062', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(2928, 18, 2, 'ZnF', 'Folic Acid + Zinc', '5 mg + 20 mg', 149.93, 26.09, 200.01, 100, 0, '2.00 Tk', 0, 0, '143-0354-045', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:21', '2019-10-30 04:37:21', NULL),
(2929, 18, 2, 'Acliz PLUS', 'Meclizine Hydrochloride + Pyridoxine Hydrochloride', '25 mg + 50 mg', 224.89, 39.13, 300.00, 100, 0, '3.00 Tk', 0, 0, '143-0362-018', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:19', '2019-10-30 04:37:19', NULL),
(2930, 18, 2, 'PFC', 'Cyanocobalamin + Folic Acid + Pyridoxine Hydrochloride', '2 mg + 2.5 mg + 25 mg', 0.00, 0.00, 0.00, 0, 0, '6.00 Tk', 0, 0, '143-0363-045', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(2931, 18, 2, 'Az 250', 'Azithromycin', '250 mg', 187.41, 32.61, 250.00, 10, 0, '25.00 Tk', 0, 0, '143-0371-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(2932, 18, 2, 'Az 500', 'Azithromycin', '500 mg', 314.84, 54.78, 420.00, 12, 0, '35.00 Tk', 0, 0, '143-0372-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(2933, 18, 2, 'Nimodol SR 600', 'Etodolac', '600 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '143-0379-064', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(2934, 18, 2, 'Armomet 1', 'Metformin Hydrochloride + Rosiglitazone', '500 mg + 1 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '143-0382-015', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(2935, 18, 2, 'Reumazin', 'Sulfasalazine', '500 mg', 194.90, 33.91, 260.00, 50, 0, '5.20 Tk', 0, 0, '143-0388-064', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:21', '2019-10-30 04:37:21', NULL),
(2936, 18, 2, 'Baclovan', 'Baclofen', '10 mg', 0.00, 0.00, 0.00, 0, 0, '8.00 Tk', 0, 0, '143-0389-070', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(2937, 18, 2, 'Vazlepe', 'Glucosamine', '500 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '143-0390-064', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(2938, 18, 2, 'Aprocin 750', 'Ciprofloxacin', '750 mg', 0.00, 0.00, 0.00, 0, 0, '18.00 Tk', 0, 0, '143-0392-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(2939, 18, 2, 'Ramilok 2.5', 'Ramipril', '2.5 mg', 0.00, 0.00, 0.00, 0, 0, '5.00 Tk', 0, 0, '143-0395-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(2940, 18, 2, 'Ramilok 5', 'Ramipril', '5 mg', 0.00, 0.00, 0.00, 0, 0, '8.00 Tk', 0, 0, '143-0396-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(2941, 18, 2, 'Xicotil F/C', 'Tenoxicam', '20 mg', 179.91, 31.30, 240.00, 30, 0, '8.00 Tk', 0, 0, '143-0397-064', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:21', '2019-10-30 04:37:21', NULL),
(2942, 18, 2, 'Xelix SR', 'Indapamide', '1.5 mg', 112.44, 19.56, 149.99, 30, 0, '5.00 Tk', 0, 0, '143-0398-042', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:21', '2019-10-30 04:37:21', NULL),
(2943, 18, 2, 'Ancor 2.5 F/C', 'Bisoprolol Hemifumarate', '2.5 mg', 134.93, 23.48, 180.00, 30, 0, '6.00 Tk', 0, 0, '143-0399-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:19', '2019-10-30 04:37:19', NULL),
(2944, 18, 2, 'Ancor 5 F/C', 'Bisoprolol Hemifumarate', '5 mg', 224.89, 39.13, 300.00, 30, 0, '10.00 Tk', 0, 0, '143-0400-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:19', '2019-10-30 04:37:19', NULL),
(2947, 18, 2, 'Hemoral', 'Diosmin + Hesperidin', '450 mg + 50 mg', 179.91, 31.30, 240.00, 30, 0, '8.00 Tk', 0, 0, '143-0404-075', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(2948, 18, 2, 'Rabe 20', 'Rabeprazole Sodium', '20 mg', 374.81, 65.22, 500.00, 100, 0, '5.00 Tk', 0, 0, '143-0405-067', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:21', '2019-10-30 04:37:21', NULL),
(2949, 18, 2, 'Epalres F/C', 'Epalrestat', '50 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '143-0410-076', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(2950, 18, 2, 'Axofen 60', 'Fexofenadine Hydrochloride', '60 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '143-0411-021', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(2951, 18, 2, 'Axofen 120', 'Fexofenadine Hydrochloride', '120 mg', 179.91, 31.30, 240.00, 30, 0, '8.00 Tk', 0, 0, '143-0412-021', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(2952, 18, 2, 'Axofen 180', 'Fexofenadine Hydrochloride', '180 mg', 149.93, 26.09, 200.01, 20, 0, '10.00 Tk', 0, 0, '143-0413-021', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(2953, 18, 2, 'Digel Plus', 'Aluminium Hydroxide + Magnesium Hydroxide + Simethicone', '400 mg + 400 mg + 30 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '143-0414-007', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(2954, 18, 2, 'Ruvastin 5', 'Rosuvastatin', '5 mg', 224.89, 39.13, 300.00, 30, 0, '10.00 Tk', 0, 0, '143-0417-061', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:21', '2019-10-30 04:37:21', NULL),
(2955, 18, 2, 'Ruvastin 10', 'Rosuvastatin', '10 mg', 449.78, 78.26, 600.01, 30, 0, '20.00 Tk', 0, 0, '143-0418-061', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:21', '2019-10-30 04:37:21', NULL),
(2956, 18, 2, 'Montril 4', 'Montelukast', '4 mg', 157.42, 27.39, 210.00, 30, 0, '7.00 Tk', 0, 0, '143-0419-044', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(2957, 18, 2, 'Montril 5', 'Montelukast', '5 mg', 159.91, 27.82, 213.32, 30, 0, '8.00 Tk', 0, 0, '143-0420-044', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(2958, 18, 2, 'Montril 10', 'Montelukast', '10 mg', 337.33, 58.70, 450.00, 30, 0, '15.00 Tk', 0, 0, '143-0421-044', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(2959, 18, 2, 'Etovan 60', 'Etoricoxib', '60 mg', 157.42, 27.39, 210.00, 30, 0, '7.00 Tk', 0, 0, '143-0428-064', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(2960, 18, 2, 'Etovan 90', 'Etoricoxib', '90 mg', 269.87, 46.96, 360.01, 30, 0, '12.00 Tk', 0, 0, '143-0429-064', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(2961, 18, 2, 'Etovan 120', 'Etoricoxib', '120 mg', 209.90, 36.52, 280.01, 20, 0, '14.00 Tk', 0, 0, '143-0430-064', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(2962, 18, 2, 'Pilogen', 'Pilocarpine Hydrochloride', '5 mg', 224.89, 39.13, 300.00, 30, 0, '10.00 Tk', 0, 0, '143-0431-037', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(2963, 18, 2, 'Xolam 0.5 XR', 'Alprazolam', '.5 mg', 0.00, 0.00, 0.00, 0, 0, '2.00 Tk', 0, 0, '143-0442-057', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(2964, 18, 2, 'Ancor-10', 'Bisoprolol Hemifumarate', '10 mg', 119.94, 20.87, 160.00, 10, 0, '16.00 Tk', 0, 0, '143-0444-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:19', '2019-10-30 04:37:19', NULL),
(2965, 18, 2, 'Tecavir 0.5', 'Entecavir', '.5 mg', 359.82, 62.61, 480.00, 10, 0, '48.00 Tk', 0, 0, '143-0447-032', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:21', '2019-10-30 04:37:21', NULL),
(2966, 18, 2, 'Tecavir 1', 'Entecavir', '1 mg', 0.00, 0.00, 0.00, 0, 0, '90.00 Tk', 0, 0, '143-0448-032', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(2967, 18, 2, 'Ivacard 5', 'Ivabradine', '5 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '143-0449-040', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(2968, 18, 2, 'Ivacard 7.5', 'Ivabradine', '7.5 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '143-0450-040', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(2969, 18, 2, 'Aristo Mom', 'Beta Carotene + Calcium + Cholecalciferol (Vit. D3) + Cyanocobalamin + Folic Acid + Iodine + Iron + Magnesium + Nicotinamide + Phosphorous + Pyridoxine Hydrochloride + Riboflavin + Thiamine Nitrate + Vitamin C + Vitamin E + Zinc', '3 mg + 59 mg + 250 IU + 1.5 mcg + 250 mcg + 125 mcg + 5 mg + 15 mg + 7.5 mg + 45.6 mg + 750 mcg + 75', 112.44, 19.56, 149.99, 50, 0, '3.00 Tk', 0, 0, '143-0452-078', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(2970, 18, 2, 'Dormax', 'Midazolam', '7.5 mg', 0.00, 0.00, 0.00, 0, 0, '10.00 Tk', 0, 0, '143-0455-057', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(2971, 18, 2, 'Betacard', 'Metoprolol Tartrate', '50 mg', 149.93, 26.09, 200.01, 100, 0, '2.00 Tk', 0, 0, '143-0467-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(2972, 18, 2, 'Cortisol 5', 'Prednisolone', '5 mg', 254.87, 44.35, 340.00, 200, 0, '1.70 Tk', 0, 0, '143-0494-072', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(2973, 18, 2, 'Cortisol 10', 'Prednisolone', '10 mg', 239.88, 41.74, 320.00, 100, 0, '3.20 Tk', 0, 0, '143-0495-072', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(2974, 18, 2, 'Cortisol 20', 'Prednisolone', '20 mg', 234.26, 40.76, 312.50, 50, 0, '6.25 Tk', 0, 0, '143-0496-072', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(2975, 18, 2, 'Piramax', 'Piracetam', '800 mg', 0.00, 0.00, 0.00, 0, 0, '6.00 Tk', 0, 0, '143-0504-075', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(2976, 18, 2, 'Contine-200 CR', 'Theophylline', '200 mg', 119.94, 20.87, 160.00, 100, 0, '1.60 Tk', 0, 0, '143-0508-044', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(2977, 18, 2, 'Contine 300 CR', 'Theophylline', '300 mg', 176.16, 30.65, 235.00, 100, 0, '2.35 Tk', 0, 0, '143-0509-044', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(2978, 18, 2, 'Solifen', 'Solifenacin Succinate', '5 mg', 0.00, 0.00, 0.00, 0, 0, '20.00 Tk', 0, 0, '143-0512-011', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(2980, 18, 2, 'Febux 80', 'Febuxostat', '80 mg', 0.00, 0.00, 0.00, 0, 0, '22.00 Tk', 0, 0, '143-0514-076', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(2981, 18, 2, 'Arotril', 'Clonazepam', '1 mg', 299.85, 52.17, 400.00, 50, 0, '8.00 Tk', 0, 0, '143-0522-046', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(2982, 18, 2, 'Neso 375/20', 'Esomeprazole + Naproxen', '20 mg + 375 mg', 299.85, 52.17, 400.00, 50, 0, '12.00 Tk', 0, 0, '143-0523-064', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(2983, 18, 2, 'Neso 500/20', 'Esomeprazole + Naproxen', '20 mg + 500 mg', 374.81, 65.22, 500.00, 50, 0, '13.00 Tk', 0, 0, '143-0524-064', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(2984, 18, 2, 'Rupa', 'Rupatadine', '10 mg', 224.89, 39.13, 300.00, 30, 0, '12.00 Tk', 0, 0, '143-0525-021', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:21', '2019-10-30 04:37:21', NULL),
(2985, 18, 2, 'Pitavas', 'Pitavastatin', '2 mg', 224.89, 39.13, 300.00, 30, 0, '10.00 Tk', 0, 0, '143-0526-061', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(2986, 18, 2, 'Prasucard 5', 'Prasugrel', '5 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '143-0535-026', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(2987, 18, 2, 'Prasucard 10', 'Prasugrel', '10 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '143-0536-026', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(2988, 18, 2, 'Gluvan', 'Vildagliptin', '50 mg', 419.79, 73.04, 560.00, 28, 0, '20.00 Tk', 0, 0, '143-0537-015', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(2989, 18, 2, 'Lodipin-10', 'Amlodipine', '10 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '143-0539-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(2990, 18, 2, 'Loditor', 'Amlodipine + Atorvastatin', '5 mg + 10 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '143-0540-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(2991, 18, 2, 'Ancor Plus 2.5', 'Bisoprolol Hemifumarate + Hydrochlorothiazide', '5 mg + 6.25 mg', 134.93, 23.48, 180.00, 30, 0, '6.00 Tk', 0, 0, '143-0550-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:19', '2019-10-30 04:37:19', NULL),
(2992, 18, 2, 'Ancor Plus 5', 'Bisoprolol Hemifumarate + Hydrochlorothiazide', '2.5 mg + 6.25 mg', 224.89, 39.13, 300.00, 30, 0, '10.00 Tk', 0, 0, '143-0551-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:19', '2019-10-30 04:37:19', NULL),
(2993, 18, 2, 'Tenvira', 'Tenofovir Disoproxil Fumarate', '300 mg', 637.18, 110.87, 850.00, 10, 0, '85.00 Tk', 0, 0, '143-0557-032', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:21', '2019-10-30 04:37:21', NULL),
(2994, 18, 2, 'Hepaximin 200', 'Rifaximin', '200 mg', 300.00, 52.20, 400.20, 20, 0, '20.00 Tk', 0, 0, '143-0560-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(2995, 18, 2, 'Hepaximin 550', 'Rifaximin', '550 mg', 337.33, 58.70, 450.00, 10, 0, '45.00 Tk', 0, 0, '143-0561-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(2996, 18, 2, 'V-Gra 100 mg', 'Sildenafil', '100 mg', 0.00, 0.00, 0.00, 0, 0, '50.00 Tk', 0, 0, '143-0570-043', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(2997, 18, 2, 'V-Gra 50 mg', 'Sildenafil', '50 mg', 0.00, 0.00, 0.00, 0, 0, '30.00 Tk', 0, 0, '143-0571-043', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(2998, 18, 2, 'V-Gra 25 mg', 'Sildenafil', '25 mg', 0.00, 0.00, 0.00, 0, 0, '16.00 Tk', 0, 0, '143-0572-043', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(2999, 18, 2, 'Pawar-20', 'Tadalafil', '20 mg', 0.00, 0.00, 0.00, 0, 0, '60.00 Tk', 0, 0, '143-0573-043', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(3000, 18, 2, 'Pawar-10', 'Tadalafil', '10 mg', 0.00, 0.00, 0.00, 0, 0, '35.00 Tk', 0, 0, '143-0574-043', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(3001, 18, 2, 'Pawar-5', 'Tadalafil', '5 mg', 0.00, 0.00, 0.00, 0, 0, '18.00 Tk', 0, 0, '143-0575-043', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(3002, 18, 2, 'Arolast', 'Roflumilast', '500 mcg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '143-0576-044', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(3003, 18, 2, 'Gluvan Plus 500', 'Metformin Hydrochloride + Vildagliptin', '500 mg + 50 mg', 314.89, 54.79, 420.06, 20, 0, '21.00 Tk', 0, 0, '143-0577-015', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(3004, 18, 2, 'Gluvan Plus 850', 'Metformin Hydrochloride + Vildagliptin', '850 mg + 50 mg', 329.84, 57.39, 440.01, 20, 0, '22.00 Tk', 0, 0, '143-0578-015', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(3005, 18, 2, 'Alginet Chewable Tablet', 'Potassium Bicarbonate + Sodium Alginate', '100 mg + 500 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '143-0580-007', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(3006, 18, 2, 'Linaglip', 'Linagliptin', '5 mg', 299.85, 52.17, 400.00, 20, 0, '20.00 Tk', 0, 0, '143-0592-015', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(3007, 18, 2, 'Ibandron', 'Ibandronic Acid', '150 mg', 899.55, 156.52, 1200.00, 1, 0, '1200.00 Tk', 0, 0, '143-0593-048', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(3008, 18, 2, 'Apulset 4', 'Ondansetron', '4 mg', 0.00, 0.00, 0.00, 0, 0, '6.00 Tk', 0, 0, '143-0595-018', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(3009, 18, 2, 'Apulset 8', 'Ondansetron', '8 mg', 224.89, 39.13, 300.00, 30, 0, '10.00 Tk', 0, 0, '143-0596-018', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(3010, 18, 2, 'Aristo Silver', 'Ascorbic Acid + Biotin + Boron + Calcium Carbonate + Chromium + Copper + Cyanocobalamin + Diabasic Calcium Phosphate + Elemental Iron + Folic Acid + Iodine + Lutein + Magnesium + Manganese + Molybdenum + Niacin + Nickel + Pantothenic acid + Potassium Chlo', '60 mg + 30 mcg + 150 mcg + 52.49 mg + 120 mcg + 2 mg + 6 mcg + 478.695 mg + 18 mg + 400 mcg + 150 mc', 157.42, 27.39, 210.00, 30, 0, '7.00 Tk', 0, 0, '143-0600-078', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(3011, 18, 2, 'Fossical-D', 'Calcium + Vitamin D', '500 mg + 200 IU', 449.78, 78.26, 600.01, 60, 0, '10.00 Tk', 0, 0, '143-0606-062', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(3012, 18, 2, 'Aromatin', 'Anastrozol', '1 mg', 1293.00, 224.98, 1724.86, 30, 0, '50.00 Tk', 0, 0, '143-0607-010', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(3013, 18, 2, 'Thormon', 'Levothyroxine Sodium', '50 mcg', 119.94, 20.87, 160.00, 100, 0, '', 0, 0, '143-0610-074', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:21', '2019-10-30 04:37:21', NULL),
(3014, 18, 2, 'Lorenzo', 'Letrozole', '2.5 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '143-0611-010', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(3015, 18, 2, 'Docopa', 'Doxophylline', '400 mg', 359.82, 62.61, 480.00, 60, 0, '8.00 Tk', 0, 0, '143-0612-044', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(3016, 18, 2, 'Fossical-DX', 'Calcium + Cholecalciferol (Vit. D3)', '600 mg + 400 IU', 337.33, 58.70, 450.00, 30, 0, '15.00 Tk', 0, 0, '143-0620-062', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(3017, 18, 2, 'Flacort', 'Deflazacort', '6 mg', 179.91, 31.30, 240.00, 30, 0, '8.00 Tk', 0, 0, '143-0621-072', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(3018, 18, 2, 'Presulock', 'Olmesartan Medoxomil', '20 mg', 179.91, 31.30, 240.00, 30, 0, '', 0, 0, '143-0623-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(3019, 18, 2, 'Duoblock 5/20', 'Amlodipine + Olmesartan Medoxomil', '5 mg + 20 mg', 179.91, 31.30, 240.00, 30, 0, '', 0, 0, '143-0624-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(3020, 18, 2, 'Duoblock 5/40', 'Amlodipine + Olmesartan Medoxomil', '5 mg + 40 mg', 337.33, 58.70, 450.00, 30, 0, '', 0, 0, '143-0625-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(3021, 18, 2, 'Dualvir', 'Ledipasvir + Sofosbuvir', '90 mg + 400 mg', 6034.00, 1049.92, 8049.36, 7, 0, '1000.00 Tk', 0, 0, '143-0631-', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(3022, 18, 2, 'Docopa 200', 'Doxophylline', '200 mg', 224.89, 39.13, 300.00, 60, 0, '6.00 Tk', 0, 0, '143-0632-044', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(3023, 18, 2, 'Sofo-C', 'Sofosbuvir', '400 mg', 0.00, 0.00, 0.00, 0, 0, '600.00 Tk', 0, 0, '143-0634-032', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(3024, 18, 2, 'Maxineb 2.5', 'Nebivolol', '2.5 mg', 157.42, 27.39, 210.00, 30, 0, '7.00 Tk', 0, 0, '143-0637-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(3025, 18, 2, 'Maxineb 5', 'Nebivolol', '5 mg', 224.89, 39.13, 300.00, 30, 0, '10.00 Tk', 0, 0, '143-0638-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(3026, 18, 2, 'Azistar 40', 'Azilsartan Medoxomil', '40 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '143-0639-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(3027, 18, 2, 'Azistar 80', 'Azilsartan Medoxomil', '80 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '143-0640-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(3028, 18, 2, 'Ticacard', 'Ticagrelor', '90 mg', 562.22, 97.83, 750.00, 10, 0, '75.00 Tk', 0, 0, '143-0641-026', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:21', '2019-10-30 04:37:21', NULL),
(3029, 18, 2, 'Beclovan 5', 'Baclofen', '5 mg', 123.69, 21.52, 165.00, 30, 0, '5.50 Tk', 0, 0, '143-0644-070', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(3030, 18, 2, 'Linaglip Plus 500', 'Linagliptin + Metformin Hydrochloride', '2.5 mg + 500 mg', 269.87, 46.96, 360.01, 30, 0, '12.00 Tk', 0, 0, '143-0648-015', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(3031, 18, 2, 'Linaglip Plus 850', 'Linagliptin + Metformin Hydrochloride', '2.5 mg + 850 mg', 209.90, 36.52, 280.01, 20, 0, '14.00 Tk', 0, 0, '143-0649-015', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(3032, 18, 2, 'Sonexa 4', 'Dexamethasone', '4 mg', 164.92, 28.70, 220.00, 20, 0, '11.00 Tk', 0, 0, '143-0651-072', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:21', '2019-10-30 04:37:21', NULL),
(3033, 18, 2, 'Apetiz', 'Megestrol Acetate', '160 mg', 2327.40, 404.97, 3104.75, 30, 0, '90.00 Tk', 0, 0, '143-0652-056', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(3034, 18, 2, 'Aristomox CV 375', 'Amoxicillin + Clavulanic Acid', '250 mg + 125 mg', 0.00, 0.00, 0.00, 0, 0, '20.00 Tk', 0, 0, '143-0653-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(3035, 18, 2, 'Aristomox CV 635', 'Amoxicillin + Clavulanic Acid', '500 mg + 125 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '143-0654-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(3036, 18, 2, 'Aristomox CV 1 G', 'Amoxicillin + Clavulanic Acid', '875 mg + 125 mg', 0.00, 0.00, 0.00, 0, 0, '35.00 Tk', 0, 0, '143-0655-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(3037, 18, 2, 'Acyvir 200', 'Acyclovir', '200 mg', 0.00, 0.00, 0.00, 0, 0, '14.00 Tk', 0, 0, '143-0659-032', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(3038, 18, 2, 'Acyvir 400', 'Acyclovir', '400 mg', 0.00, 0.00, 0.00, 0, 0, '22.00 Tk', 0, 0, '143-0660-032', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(3039, 18, 2, 'Rejoin-D', 'Diacerein + Glucosamine Sulphate', '50 mg + 750 mg', 269.57, 46.91, 359.61, 30, 0, '12.00 Tk', 0, 0, '143-0664-064', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:21', '2019-10-30 04:37:21', NULL),
(3040, 18, 2, 'TCL-R 40', 'Atorvastatin', '40 mg', 179.91, 31.30, 240.00, 10, 0, '24.00 Tk', 0, 0, '143-0665-061', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:21', '2019-10-30 04:37:21', NULL),
(3041, 18, 2, 'Ertinib 100 Tablet', 'Erlotinib', '100 mg', 4741.00, 0.00, 5499.56, 10, 0, '550.00 Tk', 0, 0, '143-0669-010', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(3042, 18, 2, 'Ertinib 150 Tablet', 'Erlotinib', '150 mg', 6034.00, 0.00, 6999.44, 10, 0, '700.00 Tk', 0, 0, '143-0670-010', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(3043, 18, 2, 'Lodipin-5', 'Amlodipine', '5 mg', 224.89, 39.13, 300.00, 60, 0, '', 0, 0, '143-0075-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(3044, 18, 2, 'Cilnipin 5', 'Cilnidipine', '5 mg', 157.42, 27.39, 210.00, 30, 0, '7.00 Tk', 0, 0, '143-0677-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(3045, 18, 2, 'Cilnipin 10', 'Cilnidipine', '10 mg', 202.40, 35.22, 270.00, 30, 0, '9.00 Tk', 0, 0, '143-0678-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(3046, 18, 2, 'Aristo D3 2000', 'Cholecalciferol (Vit. D3)', '2000 IU', 0.00, 0.00, 0.00, 0, 0, '2.50 Tk', 0, 0, '143-0680-078', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(3047, 18, 2, 'Empaglif 10', 'Empagliflozin', '10 mg', 562.22, 97.83, 750.00, 30, 0, '25.00 Tk', 0, 0, '143-0683-015', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(3048, 18, 2, 'Empaglif 25', 'Empagliflozin', '25 mg', 299.85, 52.17, 400.00, 30, 0, '40.00 Tk', 0, 0, '143-0684-015', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(3049, 18, 2, 'Flacort 24', 'Deflazacort', '24 mg', 449.78, 78.26, 600.01, 20, 0, '30.00 Tk', 0, 0, '143-0685-072', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(3050, 18, 2, 'Ruvastin-20', 'Rosuvastatin', '20 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '143-0690-061', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(3051, 18, 2, 'Arthanib', 'Tofacitinib', '5 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '143-0692-058', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(3052, 18, 2, 'Balancia', 'Citicoline', '500 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '143-0694-036', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL);
INSERT INTO `medicines` (`id`, `company_id`, `medicine_type_id`, `name`, `generic_name`, `strength`, `tp_per_box`, `vat_per_box`, `mrp_per_box`, `pcs_per_box`, `pcs_per_strip`, `price_per_box`, `price_per_strip`, `price_per_pcs`, `dar_no`, `is_imported`, `is_antibiotic`, `product_type`, `status`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`) VALUES
(3053, 18, 68, 'Aprocin HC', 'Ciprofloxacin + Hydrocortisone Acetate', '300 mg + 1 gm/100 ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '143-0178-052', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(3054, 18, 68, 'Flumetanol', 'Clioquinol + Flumetasone Pivalate', '1 gm + .02 gm/100 ml', 74.96, 13.04, 100.00, 1, 0, '100.00 Tk', 0, 0, '143-0435-050', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(3055, 18, 20, 'Aprodex', 'Ciprofloxacin + Dexamethasone', '300 mg + 100 mg/100 ml', 56.22, 9.78, 75.00, 1, 0, '75.00 Tk', 0, 0, '143-0267-052', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(3056, 18, 20, 'Vista', 'Ofloxacin', '3 mg/ml', 0.00, 0.00, 0.00, 0, 0, '85.00 Tk', 0, 0, '143-0387-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(3057, 18, 21, 'Aristobet N', 'Betamethasone Sodium Phosphate + Neomycin Sulphate', '100 mg + 500 mg/100 ml', 0.00, 0.00, 0.00, 0, 0, '35.00 Tk', 0, 0, '143-0174-050', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(3058, 18, 8, 'Aprocin', 'Ciprofloxacin', '300 mg/100 gm', 26.24, 4.57, 35.00, 1, 0, '35.00 Tk', 0, 0, '143-0181-052', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(3059, 18, 8, 'Aristophen', 'Chloramphenicol', '1 gm/100 gm', 0.00, 0.00, 0.00, 0, 0, '8.39 Tk', 0, 0, '143-0180-052', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(3060, 18, 8, 'Polydex N', 'Dexamethasone + Neomycin + Polymixin', '100 mg + 350 mg + 6000 IU/100 gm', 0.00, 0.00, 0.00, 0, 0, '50.00 Tk', 0, 0, '143-0179-052', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(3061, 18, 8, 'Sonexa', 'Dexamethasone', '.05 gm/100 gm', 60.00, 10.44, 80.04, 1, 0, '80.00 Tk', 0, 0, '143-0213-052', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:21', '2019-10-30 04:37:21', NULL),
(3062, 18, 8, 'T Mycin 0.3%', 'Tobramycin', '3 mg/gm', 7.00, 1.22, 9.34, 1, 0, '80.00 Tk', 0, 0, '143-0312-052', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:21', '2019-10-30 04:37:21', NULL),
(3063, 18, 8, 'T Mycin PLUS', 'Dexamethasone + Tobramycin', '100 mg + 300 mg/100 gm', 86.21, 15.00, 115.00, 1, 0, '115.00 Tk', 0, 0, '143-0314-052', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:21', '2019-10-30 04:37:21', NULL),
(3064, 18, 8, 'Acyvir', 'Acyclovir', '3 gm/100 gm', 93.70, 16.30, 125.00, 1, 0, '125.00 Tk', 0, 0, '143-0315-052', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:19', '2019-10-30 04:37:19', NULL),
(3065, 18, 8, 'AFM', 'Fluorometholone + Gentamicin', '100 mg + 300 mg/100 ml', 0.00, 0.00, 0.00, 0, 0, '130.00 Tk', 0, 0, '143-0374-052', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(3066, 18, 8, 'Aristen', 'Clotrimazole', '10 mg/gm', 60.00, 10.44, 80.04, 1, 0, '80.00 Tk', 0, 0, '143-0531-052', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-10-30 04:37:20', '2019-10-30 04:37:20', NULL),
(5877, 35, 2, 'Cenet 500', 'Calcium Carbonate', '1250 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '060-0058-062', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5878, 35, 2, 'KPR', 'Ketorolac Tromethamine', '10 mg', 0.00, 0.00, 0.00, 0, 0, '10.00 Tk', 0, 0, '060-0075-064', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5879, 35, 2, 'OST', 'Cyanocobalamin + Pyridoxine Hydrochloride + Vitamin B1', '200 mcg + 200 mg + 100 mg', 0.00, 0.00, 0.00, 0, 0, '4.00 Tk', 0, 0, '060-0077-078', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5880, 35, 2, 'DOS', 'Calcium + Vitamin D3', '500 mg + 200 IU', 0.00, 0.00, 0.00, 0, 0, '4.00 Tk', 0, 0, '060-0076-062', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5881, 35, 2, 'Azitor 500 mg', 'Azithromycin', '500 mg', 0.00, 0.00, 0.00, 0, 0, '30.00 Tk', 0, 0, '060-0067-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5882, 35, 2, 'Centamol Plus', 'Caffeine + Paracetamol', '65 mg + 500 mg', 0.00, 0.00, 0.00, 0, 0, '1.90 Tk', 0, 0, '060-0078-006', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5883, 35, 2, 'GL-80', 'Gliclazide', '80 mg', 0.00, 0.00, 0.00, 0, 0, '7.00 Tk', 0, 0, '060-0081-015', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5884, 35, 2, 'M-Form', 'Metformin Hydrochloride', '850 mg', 0.00, 0.00, 0.00, 0, 0, '5.50 Tk', 0, 0, '060-0082-015', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5885, 35, 2, 'Central Gold', 'Ascorbic Acid + Biotin + Boron + Calcium + Chromium + Copper + Cyanocobalamin + Elemental Iron + Folic Acid + Iodine + Lutein + Magnesium + Manganese + Molybdenum + Niacin + Nickel + Pantothenic acid + Phosphorous + Pottassium + Pyridoxine Hydrochloride +', '60 mg + 30 mcg + 150 mcg + 162 mg + 120 mcg + 2 mg + 6 mcg + 18 mg + 400 mcg + 150 mcg + 250 mcg + 1', 0.00, 0.00, 0.00, 0, 0, '6.50 Tk', 0, 0, '060-0083-078', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5886, 35, 2, 'PC-20', 'Pantoprazole', '20 mg', 0.00, 0.00, 0.00, 0, 0, '4.00 Tk', 0, 0, '060-0089-067', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5887, 35, 2, 'Via-Gram 50', 'Sildenafil', '50 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '060-0095-043', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5888, 35, 2, 'Via-Gram 100', 'Sildenafil', '100 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '060-0096-043', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5889, 35, 12, 'Easy ORS', 'Dextrose Anhydrous + Potassium Chloride + Sodium Chloride + Trisodium Citrate', '6.75 gm + 750 mg + 1.3 gm + 1.45 gm/500 ml', 0.00, 0.00, 0.00, 0, 0, '4.58 Tk', 0, 0, '060-0087-079', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5890, 35, 12, 'Easy ORS Plus', 'Potassium Chloride + Rice Powder (Pregelatineized) + Sodium Chloride + Trisodium Citrate', '.75 gm + 25 gm + 1.3 gm + 1.45 gm/500 ml', 0.00, 0.00, 0.00, 0, 0, '12.00 Tk', 0, 0, '060-0088-079', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5891, 35, 13, 'Cytaplex M', 'Nicotinamide + Pantothenic acid + Pyridoxine Hydrochloride + Riboflavin + Vitamin A + Vitamin B1 + Vitamin C + Vitamin D', '10 mg + 5 mg + 1 mg + 1 mg + 5000 IU + 1.6 mg + 50 mg + 1000 IU/ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '060-0057-078', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5892, 35, 4, 'Cemoxin', 'Amoxicillin', '125 mg/5 ml', 0.00, 0.00, 0.00, 0, 0, '45.00 Tk', 0, 0, '060-0026-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5893, 35, 4, 'Cypor', 'Cephalexin', '125 mg/5 ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '060-0038-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5894, 35, 4, 'Penclox', 'Cloxacillin', '125 mg/5 ml', 0.00, 0.00, 0.00, 0, 0, '43.00 Tk', 0, 0, '060-0028-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5895, 35, 4, 'Isoflu', 'Flucloxacillin', '125 mg/5 ml', 0.00, 0.00, 0.00, 0, 0, '60.00 Tk', 0, 0, '060-0059-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5896, 35, 4, 'Azitor', 'Azithromycin', '200 mg/5 ml', 0.00, 0.00, 0.00, 0, 0, '140.00 Tk', 0, 0, '060-0080-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5897, 36, 1, 'Abac 500', 'Cephalexin', '500 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0115-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5898, 36, 1, 'Chemosef 250', 'Cephalexin', '250 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0074-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5899, 36, 1, 'Chemoxillin 250', 'Amoxicillin', '250 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0063-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5900, 36, 1, 'Doxi C 100', 'Doxycycline', '100 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0062-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5901, 36, 1, 'Ferafol SR', 'Ferrous Fumarate + Folic Acid', '200 mg + 200 mcg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0100-045', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5902, 36, 1, 'Omecap 20', 'Omeprazole', '20 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0113-067', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5904, 36, 1, 'Excef 200', 'Cefixime', '200 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0176-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5905, 36, 1, 'Podoxi 100', 'Cefpodoxime', '100 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0192-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5906, 36, 1, 'Azithin 500', 'Azithromycin', '500 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0200-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5907, 36, 1, 'Pregneed', 'Ascorbic Acid + Elemental Iron + Folic Acid + Nicotinamide + Pyridoxine Hydrochloride + Riboflavin + Vitamin B1 + Zinc', '50 mg + 47 mg + 500 mcg + 10 mg + 1 mg + 2 mg + 2 mg + 22.5 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0222-078', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5908, 36, 1, 'Lansozol', 'Lansoprazole', '30 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0227-067', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5909, 36, 1, 'C-Fenac TR', 'Diclofenac Sodium', '100 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0253-064', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5910, 36, 1, 'Omecap 40', 'Omeprazole', '40 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0252-067', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5911, 36, 1, 'Lumidol', 'Tramadol Hydrochloride', '50 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0291-065', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5912, 36, 1, 'Cadotril', 'Racecadrotil', '100 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0326-016', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5913, 36, 1, 'Promox 500', 'Amoxicillin', '500 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0343-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5914, 36, 1, 'Fluking 250', 'Flucloxacillin', '250 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0346-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5915, 36, 1, 'Fluking 500', 'Flucloxacillin', '500 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0347-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5916, 36, 1, 'Excef', 'Cefixime', '400 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0348-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5917, 36, 5, 'Scabid', 'Permethrin', '5 gm/100 gm', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0116-071', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5918, 36, 5, 'Silvazin 1%', 'Silver Sulphadiazine', '1 %', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0129-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5919, 36, 5, 'Fungison', 'Econazole Nitrate + Triamcinolone Acetonide', '1 gm + 100 mg/100 gm', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0120-071', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5920, 36, 5, 'Polydin', 'Povidone Iodine', '6 gm/100 gm', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0155-071', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5921, 36, 5, 'Clozol', 'Clotrimazole', '10 mg/gm', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0210-071', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5922, 36, 5, 'Dermabac', 'Fusidic Acid + Hydrocortisone Acetate', '2 gm + 1 gm/100 gm', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0303-071', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5923, 36, 5, 'Melacare', 'Fluocinolone + Hydroquinone + Tretinoin', '.01 gm + 4 gm + .05 gm/100 gm', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0320-071', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5924, 36, 6, 'Lidogel', 'Lidocaine Hydrochloride', '20 mg/gm', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0332-071', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5926, 36, 14, 'C Fenac', 'Diclofenac Sodium', '75 mg/3 ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0078-064', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5928, 36, 14, 'Chemo C', 'Vitamin C', '500 mg/5 ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '5-0086-078', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5929, 36, 14, 'Chemycin 100', 'Lidocaine Hydrochloride + Oxytetracycline', '2 gm + 10 gm/100 ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0140-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5930, 36, 14, 'Chemycin', 'Oxytetracycline', '5 gm/100 ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0145-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5931, 36, 14, 'Chemycin LA', 'Oxytetracycline', '20 gm/100 ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0141-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5932, 36, 14, 'Cynovit 1', 'Cyanocobalamin', '1 mg/ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0101-078', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5933, 36, 14, 'Dexan', 'Dexamethasone Sodium Phosphate', '5 mg/ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0064-072', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5934, 36, 14, 'Dexaphos', 'Dexamethasone Sodium Phosphate', '5 mg/ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0125-072', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5935, 36, 14, 'Gentasone', 'Gentamicin', '50 mg/ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0124-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5936, 36, 14, 'Hemolysin', 'Aminocaproic Acid', '1 gm/5ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0104-033', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5937, 36, 14, 'Narvit', 'Thiamine Hydrochloride', '100 mg/ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0099-078', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5938, 36, 14, 'Nurobix', 'D-Panthenol + Nicotinamide + Pyridoxine Hydrochloride + Riboflavin + Vitamin B1', '5 mg + 100 mg + 10 mg + 4 mg + 50 mg/2 ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0139-078', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5939, 36, 14, 'Relapan', 'Hyoscine Butyl Bromide', '20 mg/ml', 0.00, 0.00, 0.00, 0, 0, '3.51 Tk', 0, 0, '050-0034-011', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5940, 36, 14, 'Sedium', 'Diazepam', '10 mg/2 ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0051-057', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5941, 36, 14, 'Vita S', 'D-Panthenol + Nicotinamide + Pyridoxine Hydrochloride + Riboflavin + Vitamin B1', '5 mg + 100 mg + 10 mg + 4 mg + 50 mg/2 ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0077-078', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5942, 36, 14, 'Vitamin B1', 'Thiamine Hydrochloride', '25 mg/ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0052-078', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5944, 36, 14, 'Ranix', 'Ranitidine', '50 mg/2 ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0166-055', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5945, 36, 14, 'Vita S', 'Cyanocobalamin + Nicotinamide + Pantothenic acid + Pyridoxine Hydrochloride + Riboflavin + Vitamin A + Vitamin B1 + Vitamin D + Vitamin E', '50 mcg + 35 mg + 25 mg + 3 mg + 5 mg + 15 Lac IU + 10 mg + 1 Lac IU + 20 mg/100 ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0168-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5946, 36, 14, 'Histanol', 'Pheniramine Maleate', '22.75 mg/ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0169-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5947, 36, 14, 'Promodin', 'Promethazine Hydrochloride', '50 mg/2 ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0170-021', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5948, 36, 14, 'Tylochem', 'Tylosin', '20 gm/100 ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0174-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5949, 36, 14, 'Kelac 30 mg', 'Ketorolac Tromethamine', '30 mg/ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0190-064', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5950, 36, 14, 'Kelac 10', 'Ketorolac Tromethamine', '10 mg/ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0191-064', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5951, 36, 14, 'Hyvolin', 'Nandrolone', '25 mg/ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0185-048', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5952, 36, 14, 'Hydeca', 'Nandrolone', '50 mg/ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0184-048', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5953, 36, 14, 'Pitocin', 'Oxytocin', '5 IU/ml', 0.00, 0.00, 0.00, 0, 0, '8.35 Tk', 0, 0, '050-0151-049', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5954, 36, 14, 'Urgotin', 'Methyl Ergometrine Maleate', '200 mcg/ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0152-049', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5955, 36, 14, 'Ivertin', 'Ivermectin', '10 mg/ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0156-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5956, 36, 14, 'Dexaphos PLUS', 'Dexamethasone + Prednisolone', '250 mg + 750 mg/100 ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0157-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5957, 36, 14, 'Trimcort', 'Triamcinolone Acetonide', '40 mg/ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0212-072', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5958, 36, 14, 'Bupicaine', 'Bupivacaine', '2.5 mg/5ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0214-005', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5959, 36, 14, 'Prostig', 'Neostigmine Methyl Sulphate', '500 mcg/ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0205-037', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5960, 36, 14, 'Nurobix Plus', 'Cyanocobalamin + Pyridoxine Hydrochloride + Vitamin B1', '1 mg + 100 mg + 100 mg/3 ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0202-078', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5961, 36, 14, 'Suxa', 'Suxamethonium Chloride', '100 mg/2 ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0206-063', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5962, 36, 14, 'Ketam', 'Ketamine', '50 mg/ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0223-004', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5963, 36, 14, 'C-Phedrin', 'Ephedrine Hydrochloride', '25 mg/5 ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0225-001', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5964, 36, 14, 'Bupicaine Heavy', 'Bupivacaine + Dextrose', '20 mg + 320 mg/4 ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0224-005', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5965, 36, 14, 'Moody', 'Fluphenazine Decanoate', '25 mg/ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0234-028', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5966, 36, 14, 'Helo', 'Sodium Hyaluronate', '20 mg/2 ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0237-064', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5967, 36, 14, 'Metagen', 'Toldimfos Sodium', '200 mg/ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0235-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5968, 36, 14, 'Atrium', 'Atracurium Besylate', '25 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0233-063', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5969, 36, 14, 'Pamin', 'Dopamine Hydrochloride', '200 mg/5 ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0228-001', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5970, 36, 14, 'Nitronil', 'Nitroxynil', '25 gm/100 ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0229-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5972, 36, 14, 'Nitronil 34% Vet', 'Nitroxynil', '34 gm/100 ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0250-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5973, 36, 14, 'Uni-Medrol', 'Methyl Prednisolone Acetate', '40 mg/ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0251-072', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5974, 36, 14, 'Norcurium IV', 'Vecuronium Bromide', '10 mg/ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0259-063', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5975, 36, 14, 'Hycort', 'Hydrocortisone', '100 mg/vial', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0026-072', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5976, 36, 14, 'Meronem IV', 'Meropenem', '500 mg/vial', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0261-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5977, 36, 14, 'Meronem IV', 'Meropenem', '1 gm/vial', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0262-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5978, 36, 14, 'Pentothal', 'Thiopentone Sodium', '500 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0263-004', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5979, 36, 14, 'Pentothal IV', 'Thiopentone Sodium', '1 gm', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0264-004', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5980, 36, 14, 'Ketochem', 'Ketoprofen', '100 mg/1 ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0282-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5981, 36, 14, 'Butavet', 'Butaphosphan + Cyanocobalamin', '10 gm + 5 mg/100 ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0281-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5982, 36, 14, 'Magnesium', 'Magnesium Sulphate', '2.5 gm/5 ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0279-062', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5983, 36, 14, 'Nospasm', 'Drotaverine Hydrochloride', '40 mg/2 ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0273-011', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5984, 36, 14, 'AD3ESOL Vet', 'Vitamin A + Vitamin D3 + Vitamin E', '5 Lac IU + 75000 IU + 50 mg/ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0289-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5985, 36, 14, 'Lumidol', 'Tramadol Hydrochloride', '100 mg/2 ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0001-065', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5986, 36, 14, 'M P (Vet)', 'Meloxicam + Paracetamol', '20 mg + 150 mg/ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0298-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5987, 36, 14, 'Nefrofer', 'Iron Sucrose (Iron (Iii) Hydroxide Sucrose Complex)', '100 mg/5 ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0300-045', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5988, 36, 14, 'Ivertin Plus', 'Clorsulon + Ivermectin', '500 mg + 50 mg/5 ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0305-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5989, 36, 14, 'Supercef Injection (Vet)', 'Cefquinome', '2.5 gm/100 ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0310-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5990, 36, 14, 'Gonavet', 'Gonadorelin', '100 mcg/ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0322-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5991, 36, 14, 'Lidocaine Inj', 'Lidocaine Hydrochloride', '35 mg/3.5 ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0246-005', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5992, 36, 14, 'Vomitof', 'Ondansetron', '8 mg/4 ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0333-018', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5993, 36, 14, 'Tienum', 'Tiemonium Methylsulphate', '5 mg/2 ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0269-011', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5994, 36, 14, 'Chemocain', 'Lidocaine Hydrochloride', '20 mg/ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0337-005', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5995, 36, 14, 'Chemocain-A', 'Adrenaline + Lidocaine Hydrochloride', '5 mcg + 20 mg/ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0338-005', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5996, 36, 61, 'Lipsol', 'Vitamin A + Vitamin D3 + Vitamin E', '100 Lac IU + 20 Lac IU + 2 gm', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0142-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5997, 36, 8, 'Fungalin', 'Benzoic Acid + Salicylic Acid', '60 mg + 30 mg/gm', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0069-071', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5998, 36, 8, 'Germicin', 'Bacitracin Zinc + Neomycin Sulphate', '500 IU + 5 mg/gm', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0128-071', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(5999, 36, 8, 'Betnison', 'Betamethasone', '100 mg/100 gm', 0.00, 0.00, 0.00, 0, 0, '45.50 Tk', 0, 0, '050-0208-071', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6000, 36, 8, 'Gentasone', 'Gentamicin', '300 mg/100 gm', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0209-071', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6001, 36, 15, 'Dulac Oral Solution', 'Lactulose', '68 %', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0213-060', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6002, 36, 16, 'Amoxycil 10%', 'Amoxicillin', '10 %', 0.00, 0.00, 0.00, 0, 0, '112.81 Tk', 0, 0, '050-0133-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6003, 36, 16, 'Bioclean', 'Benzalkonium Chloride', '40 gm', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0137-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6004, 36, 16, 'Negotox', 'Trichlorfon', '100 %', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0136-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6005, 36, 16, 'Chemycin', 'Oxytetracycline', '20 %', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0231-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6006, 36, 16, 'Tiam Vet', 'Tiamulin Hydrogen Fumerate', '45 %', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0254-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6007, 36, 16, 'CTC 200', 'Chlortetracycline Hydrochloride', '20 gm/100 gm', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0280-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6008, 36, 16, 'Piperin-WS', 'Piperazine', '100 %', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0275-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6009, 36, 16, 'Germicin Oral Powder', 'Neomycin Sulphate', '70 gm/100 gm', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0339-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6010, 36, 64, 'Tylochem', 'Tylosin', '20 %', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0162-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6011, 36, 17, 'Orciflox 10%', 'Ciprofloxacin', '10 gm', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0132-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6012, 36, 17, 'Ipratropium', 'Ipratropium Bromide', '250 mcg/ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0276-044', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6013, 36, 17, 'Chemist Sodicarb Vet', 'Sodium Carbonate', '4 gm/100 ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0293-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6014, 36, 10, 'Chemagyl', 'Metronidazole', '200 mg/5 ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0038-027', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6015, 36, 10, 'Diodrox', 'Aluminium Oxide + Magnesium Hydroxide', '175 mg + 225 mg/5 ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0017-007', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6016, 36, 10, 'Metrim', 'Sulphamethoxazole + Trimethoprim', '200 mg + 40 mg/5 ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0033-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6017, 36, 10, 'Avomit', 'Domperidone', '5 mg/5 ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0126-018', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6018, 36, 10, 'Para C', 'Paracetamol', '120 mg/5 ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0095-006', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6019, 36, 10, 'Bioclean PLUS', 'Benzalkonium Chloride + Glutaraldehyde', '100 mg + 150 mg/100 ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0172-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6020, 36, 10, 'Levamisole PLUS', 'Levamisole + Oxyclozanide', '15 mg + 30 mg/ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0173-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6021, 36, 10, 'Fegra', 'Fexofenadine Hydrochloride', '30 mg/5 ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0302-021', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6022, 36, 11, 'Cetril', 'Cetirizine Dihydrochloride', '5 mg/5 ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0107-021', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6023, 36, 11, 'Histanol', 'Chlorpheniramine Maleate', '2 mg/5 ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0068-021', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6024, 36, 11, 'Metocil', 'Metoclopramide Hydrochloride', '5 mg/5 ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0083-018', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6025, 36, 11, 'Polyferon', 'Iron Hydroxide Polymaltose', '50 mg/5 ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0150-045', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6026, 36, 11, 'Promodin', 'Promethazine Hydrochloride', '5 mg/5 ml', 0.00, 0.00, 0.00, 0, 0, '77.50 Tk', 0, 0, '050-0066-021', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6027, 36, 11, 'Vita S', 'Nicotinamide + Pyridoxine Hydrochloride + Riboflavin + Vitamin B1', '20 mg + 2 mg + 2 mg + 5 mg/5 ml', 0.00, 0.00, 0.00, 0, 0, '20.90 Tk', 0, 0, '050-0087-078', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6028, 36, 11, 'Zeenee 10mg/5ml', 'Zinc', '10 mg/5 ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0148-062', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6029, 36, 11, 'Vita-Z', 'Nicotinamide + Pyridoxine Hydrochloride + Riboflavin + Vitamin B1 + Zinc', '400 mg + 40 mg + 50 mg + 100 mg + 200 mg/100 ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0288-078', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6030, 36, 11, 'King Seas', 'Ascorbic Acid + Cod Liver Oil + Nicotinamide + Pyridoxine Hydrochloride + Riboflavin + Vitamin A + Vitamin B1 + Vitamin D3 + Vitamin E', '17.5 mg + 100 mg + 9 mg + .35 mg + .85 mg + 2000 IU + .7 mg + 200 IU + 1.5 mg/5 ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0297-078', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6031, 36, 11, 'Winkof', 'Ambroxol', '15 mg/5 ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0313-031', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6032, 36, 11, 'Ticofen', 'Ketotifen', '1 mg/5 ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0323-021', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6033, 36, 11, 'Vomitof Solution', 'Ondansetron', '4 mg/5 ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0331-018', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6034, 36, 11, 'Drikof', 'Dextromethorphan Hydrobromide', '10 mg/5 ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0342-031', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6036, 36, 2, 'Ipin 5', 'Amlodipine', '5 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0118-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6037, 36, 2, 'Avomit', 'Domperidone', '10 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0127-018', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6038, 36, 2, 'C Fenac 50', 'Diclofenac Sodium', '50 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0081-064', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6039, 36, 2, 'Calciton 500', 'Calcium Carbonate', '1250 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0149-062', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6040, 36, 2, 'Cetox', 'Vitamin C + Vitamin E', '250 mg + 200 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0114-078', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6041, 36, 2, 'Cetril 10', 'Cetirizine Dihydrochloride', '10 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0106-021', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6042, 36, 2, 'Chemagyl 200', 'Metronidazole', '200 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0020-027', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6043, 36, 2, 'Chemagyl 400', 'Metronidazole', '400 mg', 0.00, 0.00, 0.00, 0, 0, '1.10 Tk', 0, 0, '050-0071-027', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6044, 36, 2, 'Chemo C 250', 'Vitamin C', '250 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0046-078', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6045, 36, 2, 'Chemofen 200', 'Ibuprofen', '200 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0059-064', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6046, 36, 2, 'Chemofen 400', 'Ibuprofen', '400 mg', 0.00, 0.00, 0.00, 0, 0, '1.40 Tk', 0, 0, '050-0070-064', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6047, 36, 2, 'Chemosef 500', 'Cephalexin', '500 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0102-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6048, 36, 2, 'Chemovit', 'Ascorbic Acid + Calcium Pantothenate + Cupric Sulphate + Cyanocobalamin + Ferrous Sulphate + Folic Acid + Manganese Sulphate + Nicotinamide + Potassium Iodide + Potassium Sulphate + Pyridoxine Hydrochloride + Riboflavin + Vitamin A + Vitamin B1 + Vitamin', '60 mg + 10.92 mg + 2 mg + 6 mcg + 50 mg + 400 mcg + 1 mg + 20 mg + 196 mcg + 11.141 mg + 2 mg + 1.7', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0103-078', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6049, 36, 2, 'Cipro C 500', 'Ciprofloxacin', '500 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0096-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6050, 36, 2, 'Dexan', 'Dexamethasone', '.5 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0061-072', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6051, 36, 2, 'Diodrox', 'Aluminium Hydroxide + Magnesium Hydroxide', '250 mg + 400 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0027-007', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6052, 36, 2, 'Griseofulvin', 'Griseofulvin', '500 mg', 0.00, 0.00, 0.00, 0, 0, '6.50 Tk', 0, 0, '050-0043-020', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6053, 36, 2, 'Histanol', 'Chlorpheniramine Maleate', '4 mg', 0.00, 0.00, 0.00, 0, 0, '0.20 Tk', 0, 0, '050-0026-021', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6054, 36, 2, 'Leucodar 50', 'Fluconazole', '50 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0119-020', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6055, 36, 2, 'Metrim', 'Sulphamethoxazole + Trimethoprim', '400 mg + 80 mg', 0.00, 0.00, 0.00, 0, 0, '1.40 Tk', 0, 0, '050-0030-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6056, 36, 2, 'Metrim', 'Sulphamethoxazole + Trimethoprim', '800 mg + 160 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0097-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6057, 36, 2, 'Nematox DS 400', 'Albendazole', '400 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0109-008', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6058, 36, 2, 'Para C', 'Paracetamol', '500 mg', 0.00, 0.00, 0.00, 0, 0, '0.80 Tk', 0, 0, '050-0022-006', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6059, 36, 2, 'Pen C 250', 'Phenoxymethyl Penicillin', '250 mg', 0.00, 0.00, 0.00, 0, 0, '2.20 Tk', 0, 0, '050-0042-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6060, 36, 2, 'Promox 500', 'Amoxicillin', '500 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0110-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6061, 36, 2, 'Ranix 150', 'Ranitidine', '150 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0089-055', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6062, 36, 2, 'Relapan 10', 'Hyoscine Butyl Bromide', '10 mg', 0.00, 0.00, 0.00, 0, 0, '1.80 Tk', 0, 0, '050-0058-011', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6064, 36, 2, 'Sparcin 200', 'Sparfloxacin', '200 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0120-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6065, 36, 2, 'Vermitox 100', 'Mebendazole', '100 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0028-008', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6066, 36, 2, 'Kelac 10', 'Ketorolac Tromethamine', '10 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0189-064', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6067, 36, 2, 'Levocetril', 'Levocetirizine Hydrochloride', '5 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0194-021', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6068, 36, 2, 'Urgotin', 'Methyl Ergometrine Maleate', '125 mcg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0181-049', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6069, 36, 2, 'Vesertan 8', 'Candesartan Cilexetil', '8 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0195-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6070, 36, 2, 'Dinxi', 'Flupenthixol + Melitracen', '500 mcg + 10 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0196-028', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6071, 36, 2, 'Letab 500', 'Levofloxacin', '500 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0182-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6072, 36, 2, 'Rmazid 4', 'Ethambutol + Isoniazid + Pyrazinamide + Rifampicin', '275 mg + 75 mg + 400 mg + 150 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0188-030', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6073, 36, 2, 'Rimazid 3', 'Isoniazid + Pyrazinamide + Rifampicin', '75 mg + 400 mg + 150 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0187-030', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6074, 36, 2, 'Rimazid 150/150', 'Isoniazid + Rifampicin', '150 mg + 150 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0186-030', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6075, 36, 2, 'Camin 100', 'Diethylcarbamazine Citrate', '100 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0153-008', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6076, 36, 2, 'Bambutol 10', 'Bambuterol Hydrochloride', '10 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0158-044', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6077, 36, 2, 'Etham', 'Ethambutol', '400 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0160-030', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6078, 36, 2, 'Antivert', 'Meclizine Hydrochloride', '50 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0163-018', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6079, 36, 2, 'Painex', 'Aceclofenac', '100 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0161-064', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6080, 36, 2, 'Dupha', 'Dydrogesterone', '10 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0211-056', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6081, 36, 2, 'Prexan 5', 'Prednisolone', '5 mg', 0.00, 0.00, 0.00, 0, 0, '1.15 Tk', 0, 0, '050-0203-072', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6082, 36, 2, 'Migriz', 'Rizatriptan', '5 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0183-047', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6083, 36, 2, 'Vita-S', 'Nicotinamide + Pyridoxine Hydrochloride + Riboflavin + Vitamin B1', '20 mg + 2 mg + 2 mg + 5 mg', 0.00, 0.00, 0.00, 0, 0, '38.10 Tk', 0, 0, '050-0226-078', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6084, 36, 2, 'C-Bac', 'Baclofen', '10 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0232-070', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6085, 36, 2, 'Cefurxet', 'Cefuroxime', '250 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0230-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6086, 36, 2, 'Rimazid 2', 'Isoniazid + Rifampicin', '75 mg + 150 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0278-030', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6087, 36, 2, 'Nospasm', 'Drotaverine Hydrochloride', '40 mg', 0.00, 0.00, 0.00, 0, 0, '1.75 Tk', 0, 0, '050-0274-011', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6088, 36, 2, 'Joint Plus', 'Chondroitin + Glucosamine', '200 mg + 250 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0283-064', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6089, 36, 2, 'Pilesnil', 'Diosmin + Hesperidin', '450 mg + 50 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0284-075', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6090, 36, 2, 'Pantochem 40', 'Pantoprazole', '40 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0285-067', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6091, 36, 2, 'Pantochem', 'Pantoprazole', '20 mg', 0.00, 0.00, 0.00, 0, 0, '4.75 Tk', 0, 0, '050-0286-067', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6092, 36, 2, 'Exome', 'Esomeprazole', '20 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0287-067', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6093, 36, 2, 'Nidagest', 'Allystrenol', '5 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0301-049', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6094, 36, 2, 'Fegra', 'Fexofenadine Hydrochloride', '120 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0299-021', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6095, 36, 2, 'Rago', 'Esomeprazole + Naproxen', '20 mg + 375 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0309-064', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6096, 36, 2, 'IPIN Plus', 'Amlodipine + Atenolol', '5 mg + 50 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0317-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6097, 36, 2, 'Angitan Plus', 'Hydrochlorothiazide + Losartan Potassium', '12.5 mg + 50 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0318-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6098, 36, 2, 'Angitan', 'Losartan Potassium', '50 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0319-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6099, 36, 2, 'Menobon', 'Tibolone', '2.5 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0327-056', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6100, 36, 2, 'Nurobix Plus', 'Cyanocobalamin + Pyridoxine Hydrochloride + Vitamin B1', '200 mcg + 200 mg + 100 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0325-078', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6101, 36, 2, 'Ticofen', 'Ketotifen', '1 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0324-021', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6102, 36, 2, 'Tienum', 'Tiemonium Methylsulphate', '50 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0270-011', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6103, 36, 2, 'Bazoka', 'Amlodipine + Olmesartan Medoxomil', '5 mg + 20 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0336-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6104, 36, 2, 'Easycal', 'Calcium Orotate', '400 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0335-062', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6105, 36, 2, 'Mygan', 'Tolfenamic Acid', '200 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0341-047', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6106, 36, 2, 'Cefuxet Plus', 'Cefuroxime + Clavulanic Acid', '500 mg + 125 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0349-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6107, 36, 2, 'Bio Gold', 'Ascorbic Acid + Biotin + Boron + Calcium + Chromium + Copper + Cyanocobalamin + Elemental Iron + Folic Acid + Iodine + Lutein + Magnesium + Manganese + Molybdenum + Niacin + Nickel + Pantothenic acid + Phosphorous + Pottassium + Pyridoxine Hydrochloride +', '60 mg + 30 mcg + 150 mcg + 162 mg + 120 mcg + 2 mg + 6 mcg + 18 mg + 400 mcg + 150 mcg + 250 mcg + 1', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0350-078', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6108, 36, 2, 'Robust', 'Rabeprazole Sodium', '20 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0351-067', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL);
INSERT INTO `medicines` (`id`, `company_id`, `medicine_type_id`, `name`, `generic_name`, `strength`, `tp_per_box`, `vat_per_box`, `mrp_per_box`, `pcs_per_box`, `pcs_per_strip`, `price_per_box`, `price_per_strip`, `price_per_pcs`, `dar_no`, `is_imported`, `is_antibiotic`, `product_type`, `status`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`) VALUES
(6109, 36, 19, 'Albencid', 'Albendazole', '600 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0134-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6110, 36, 19, 'Amoxycil', 'Amoxicillin', '500 mg', 0.00, 0.00, 0.00, 0, 0, '6.21 Tk', 0, 0, '050-0146-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6111, 36, 19, 'Chemycin', 'Oxytetracycline', '500 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0130-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6112, 36, 19, 'Chemycin DS', 'Oxytetracycline', '1 gm', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0131-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6113, 36, 19, 'Mivit', 'Choline + Cobalt + Cyanocobalamin + Iron + Vitamin B1', '9.1 mg + 50 mg + 20 mcg + 100 mg + 25 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0143-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6114, 36, 19, 'Trox', 'Oxyclozanide + Tetramisole Hydrochloride', '1.4 gm + 2 gm', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0135-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6115, 36, 19, 'Niclosam', 'Niclosamide', '1 gm', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0171-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6116, 36, 19, 'Para-C', 'Paracetamol', '2 gm', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0236-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6117, 36, 19, 'Niclosam Plus', 'Levamisole + Niclosamide', '75 mg + 1 gm', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0255-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6118, 36, 19, 'Orciflox Vet', 'Ciprofloxacin', '750 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0290-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6119, 36, 19, 'Metrodon', 'Metronidazole', '2 gm', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0295-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6120, 36, 19, 'MP Bolus', 'Meloxicam', '100 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0306-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6121, 36, 19, 'Rumcure', 'Antimony Potassium Tartrate + Ferrous Sulphate', '2 gm + 2 gm', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0321-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6122, 36, 19, 'Triolev', 'Levamisole + Triclabendazole', '600 mg + 900 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0219-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6123, 36, 19, 'Fe-Vet', 'Fenbendazole', '250 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0340-077', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6124, 36, 8, 'Chemophnicol', 'Chloramphenicol', '1 gm/100 gm', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0178-052', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6125, 36, 66, 'Cabisol', 'Benzyl Benzoate', '1.25 gm/5 ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0057-071', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6126, 36, 14, 'C Fenac PLUS', 'Diclofenac + Lidocaine Hydrochloride', '75 mg + 20 mg/2 ml', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0098-064', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6127, 36, 14, 'Powercef 1G IM', 'Ceftriaxone', '1 gm', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0242-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6128, 36, 14, 'Powercef 500 IM', 'Ceftriaxone', '500 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0240-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6129, 36, 14, 'Powercef 250 IM', 'Ceftriaxone', '250 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0244-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6130, 36, 14, 'Powercef 2 G', 'Ceftriaxone', '2 gm', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0245-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(6131, 36, 14, 'Powercef 1G IV', 'Ceftriaxone', '1 gm', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '050-0243-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7411, 47, 2, 'Ditrim', 'Sulphamethoxazole + Trimethoprim', '800 mg + 160 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '210-0091-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7412, 47, 2, 'Divastin 10', 'Atorvastatin', '10 mg', 230.88, 40.17, 307.99, 28, 0, '11.00 Tk', 0, 0, '210-0148-061', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7413, 47, 2, 'Dronet', 'Alendronic Acid', '10 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '210-0145-048', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7414, 47, 2, 'Famotid 20', 'Famotidine', '20 mg', 153.67, 26.74, 205.00, 100, 0, '2.05 Tk', 0, 0, '210-0064-055', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7415, 47, 2, 'Famotid 40', 'Famotidine', '40 mg', 303.60, 52.83, 405.00, 100, 0, '4.05 Tk', 0, 0, '210-0065-055', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7416, 47, 2, 'Fenat', 'Ketotifen', '1 mg', 153.67, 26.74, 205.00, 100, 0, '2.05 Tk', 0, 0, '210-0076-021', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7417, 47, 2, 'Fenaton 500', 'Mefenamic Acid', '500 mg', 69.72, 12.13, 93.01, 60, 0, '1.55 Tk', 0, 0, '210-0151-064', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7418, 47, 2, 'Furex 250', 'Cefuroxime', '250 mg', 0.00, 0.00, 0.00, 0, 0, '25.10 Tk', 0, 0, '210-0195-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7419, 47, 2, 'Geludrox HS', 'Aluminium Hydroxide + Magnesium Hydroxide + Simethicone', '400 mg + 400 mg + 30 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '210-0068-007', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7420, 47, 2, 'Glimerol 5', 'Glipizide', '5 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '210-0286-015', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7421, 47, 2, 'Glimet 1', 'Repaglinide', '1 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '210-0157-015', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7422, 47, 2, 'AH-400 Chewable', 'Albendazole', '400 mg', 90.85, 15.81, 121.19, 24, 0, '5.05 Tk', 0, 0, '210-0275-008', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:09', '2019-11-07 03:25:09', NULL),
(7423, 47, 2, 'Limpet 1', 'Glimepiride', '1 mg', 128.04, 22.28, 170.81, 56, 0, '3.05 Tk', 0, 0, '210-0228-015', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7424, 47, 2, 'Limpet 2', 'Glimepiride', '2 mg', 211.99, 36.89, 282.79, 56, 0, '5.05 Tk', 0, 0, '210-0159-015', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7425, 47, 2, 'Lorat', 'Loratadine', '10 mg', 228.64, 39.78, 305.01, 100, 0, '3.05 Tk', 0, 0, '210-0106-021', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7426, 47, 2, 'Losardil 50', 'Losartan Potassium', '50 mg', 168.97, 29.40, 225.41, 28, 0, '8.05 Tk', 0, 0, '210-0146-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7427, 47, 2, 'Losardil 25', 'Losartan Potassium', '25 mg', 191.00, 33.23, 254.79, 56, 0, '4.55 Tk', 0, 0, '210-0206-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7428, 47, 2, 'Losardil 25/12.5', 'Hydrochlorothiazide + Losartan Potassium', '12.5 mg + 25 mg', 211.99, 36.89, 282.79, 56, 0, '5.05 Tk', 0, 0, '210-0312-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7429, 47, 2, 'Losardil 50/12.5', 'Hydrochlorothiazide + Losartan Potassium', '12.5 mg + 50 mg', 337.93, 58.80, 450.80, 56, 0, '8.05 Tk', 0, 0, '210-0313-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7430, 47, 2, 'Luretic 5', 'Torasemide', '5 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '210-0227-042', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7431, 47, 2, 'Luretic 2.5', 'Torasemide', '2.5 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '210-0226-042', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7432, 47, 2, 'Mecolin', 'Mecobalamin', '.5 mg', 151.80, 26.41, 202.50, 50, 0, '4.05 Tk', 0, 0, '210-0273-078', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7433, 47, 2, 'Meverine', 'Mebeverine Hydrochloride', '135 mg', 226.76, 39.46, 302.50, 50, 0, '6.05 Tk', 0, 0, '210-0087-011', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7434, 47, 2, 'Monocard 10', 'Isosorbide Mononitrate', '10 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '210-0080-040', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7435, 47, 2, 'Neuropen 300', 'Gabapentin', '300 mg', 360.95, 62.81, 481.51, 30, 0, '16.05 Tk', 0, 0, '210-0252-046', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7436, 47, 2, 'Nidocard Retard 6.4', 'Glyceryl Trinitrate', '6.4 mg', 295.95, 51.50, 394.80, 56, 0, '7.05 Tk', 0, 0, '210-0243-040', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7437, 47, 2, 'Angicard 0.5', 'Glyceryl Trinitrate', '.5 mg', 96.03, 16.71, 128.10, 42, 0, '3.05 Tk', 0, 0, '210-0162-040', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:09', '2019-11-07 03:25:09', NULL),
(7438, 47, 2, 'Nidocard Retard', 'Glyceryl Trinitrate', '2.6 mg', 209.90, 36.52, 280.01, 56, 0, '5.00 Tk', 0, 0, '210-0161-040', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7439, 47, 2, 'Nofenac', 'Aceclofenac', '100 mg', 151.80, 26.41, 202.50, 50, 0, '4.05 Tk', 0, 0, '210-0264-064', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7440, 47, 2, 'Nomosic', 'Meclizine Hydrochloride', '50 mg', 95.58, 16.63, 127.50, 50, 0, '2.55 Tk', 0, 0, '210-0284-018', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7441, 47, 2, 'Nopain 25', 'Diclofenac Sodium', '25 mg', 153.67, 26.74, 205.00, 100, 0, '2.05 Tk', 0, 0, '210-0078-064', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7442, 47, 2, 'Nopain 50', 'Diclofenac Potassium', '50 mg', 153.67, 26.74, 205.00, 100, 0, '4.05 Tk', 0, 0, '210-0079-064', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7443, 47, 2, 'Novastin 10', 'Simvastatin', '10 mg', 0.00, 0.00, 0.00, 0, 0, '11.05 Tk', 0, 0, '210-0138-061', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7444, 47, 2, 'Novirax 400', 'Acyclovir', '400 mg', 331.33, 57.65, 441.99, 20, 0, '22.10 Tk', 0, 0, '210-0285-032', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7445, 47, 2, 'Novirax 200', 'Acyclovir', '200 mg', 315.97, 54.98, 421.50, 30, 0, '14.50 Tk', 0, 0, '210-0150-032', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7446, 47, 2, 'Oflacin 200', 'Ofloxacin', '200 mg', 180.66, 31.43, 241.00, 20, 0, '12.05 Tk', 0, 0, '210-0060-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7447, 47, 2, 'Oflacin 400', 'Ofloxacin', '400 mg', 301.35, 52.43, 402.00, 20, 0, '20.10 Tk', 0, 0, '210-0113-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7448, 47, 2, 'Oramet SR 500', 'Metformin Hydrochloride', '500 mg', 189.28, 32.93, 252.50, 50, 0, '5.05 Tk', 0, 0, '210-0235-015', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:11', '2019-11-07 03:25:11', NULL),
(7449, 47, 2, 'Ornid 500', 'Ornidazole', '500 mg', 264.25, 45.98, 352.51, 50, 0, '7.05 Tk', 0, 0, '210-0160-027', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:11', '2019-11-07 03:25:11', NULL),
(7450, 47, 2, 'Pansec 20', 'Pantoprazole', '20 mg', 211.99, 36.89, 282.79, 56, 0, '5.05 Tk', 0, 0, '210-0180-067', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:11', '2019-11-07 03:25:11', NULL),
(7451, 47, 2, 'Paridon 10', 'Domperidone', '10 mg', 150.60, 26.20, 200.90, 98, 0, '2.05 Tk', 0, 0, '210-0140-018', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:11', '2019-11-07 03:25:11', NULL),
(7452, 47, 2, 'Peflox 400', 'Pefloxacin', '400 mg', 194.67, 33.87, 259.69, 20, 0, '11.05 Tk', 0, 0, '210-0073-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:11', '2019-11-07 03:25:11', NULL),
(7453, 47, 2, 'Piozena 15', 'Pioglitazone', '15 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '210-0224-015', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7454, 47, 2, 'Ramicard 10', 'Ramipril', '10 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '210-0229-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7455, 47, 2, 'Ramicard 2.5', 'Ramipril', '2.5 mg', 0.00, 0.00, 0.00, 0, 0, '5.05 Tk', 0, 0, '210-0208-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7456, 47, 2, 'Ramicard 5', 'Ramipril', '5 mg', 337.93, 58.80, 450.80, 56, 0, '8.05 Tk', 0, 0, '210-0209-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:11', '2019-11-07 03:25:11', NULL),
(7457, 47, 2, 'Resco-1', 'Risperidone', '1 mg', 58.10, 10.11, 77.51, 50, 0, '1.55 Tk', 0, 0, '210-0248-028', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:11', '2019-11-07 03:25:11', NULL),
(7458, 47, 2, 'Resco-2', 'Risperidone', '2 mg', 76.84, 13.37, 102.50, 50, 0, '2.05 Tk', 0, 0, '210-0249-028', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:11', '2019-11-07 03:25:11', NULL),
(7459, 47, 2, 'Sertal 50', 'Sertraline', '50 mg', 189.28, 32.93, 252.50, 50, 0, '5.05 Tk', 0, 0, '210-0156-014', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:11', '2019-11-07 03:25:11', NULL),
(7460, 47, 2, 'Sparoxen 200', 'Sparfloxacin', '200 mg', 0.00, 0.00, 0.00, 0, 0, '18.10 Tk', 0, 0, '210-0198-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7461, 47, 2, 'Sumatan 50', 'Sumatriptan', '50 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '210-0295-047', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7462, 47, 2, 'Tenatrol 3', 'Bromazepam', '3 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '210-0135-057', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7463, 47, 2, 'Theovent RETARD', 'Theophylline', '250 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '210-0277-044', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7464, 47, 2, 'Theovent SR', 'Theophylline', '400 mg', 101.20, 17.61, 135.00, 50, 0, '2.70 Tk', 0, 0, '210-0276-044', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:11', '2019-11-07 03:25:11', NULL),
(7465, 47, 2, 'Ticlopid 250', 'Ticlopidine Hydrochloride', '250 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '210-0088-026', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7466, 47, 2, 'Pair 30 30', 'Ketorolac Tromethamine', '30 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '210-0134-064', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7467, 47, 2, 'Trimet', 'Trimetazidine Dihydrochloride', '20 mg', 114.32, 19.89, 152.50, 50, 0, '3.05 Tk', 0, 0, '210-0300-040', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:11', '2019-11-07 03:25:11', NULL),
(7468, 47, 2, 'Ulcar 150', 'Ranitidine', '150 mg', 191.15, 33.26, 254.99, 100, 0, '2.55 Tk', 0, 0, '210-0053-055', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:11', '2019-11-07 03:25:11', NULL),
(7469, 47, 2, 'Ulcar 300', 'Ranitidine', '300 mg', 151.80, 26.41, 202.50, 50, 0, '8.05 Tk', 0, 0, '210-0074-055', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:11', '2019-11-07 03:25:11', NULL),
(7470, 47, 2, 'Varizil 400', 'Metronidazole', '400 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '210-0011-027', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7471, 47, 2, 'Xinac 300', 'Roxithromycin', '300 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '210-0172-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7472, 47, 2, 'M Kast 4', 'Montelukast', '4 mg', 159.00, 27.67, 212.11, 42, 0, '5.05 Tk', 0, 0, '210-0320-044', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7473, 47, 2, 'Glucotin Plus', 'Chondroitin + Glucosamine', '200 mg + 250 mg', 181.04, 31.50, 241.51, 30, 0, '8.05 Tk', 0, 0, '210-0322-064', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7474, 47, 2, 'Indapa SR', 'Indapamide', '1.5 mg', 159.00, 27.67, 212.11, 42, 0, '5.05 Tk', 0, 0, '210-0324-042', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7475, 47, 2, 'D-Dopa 110', 'Carbidopa + Levodopa', '10 mg + 100 mg', 0.00, 0.00, 0.00, 0, 0, '5.05 Tk', 0, 0, '210-0325-025', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7476, 47, 2, 'D-Dopa 275', 'Carbidopa + Levodopa', '25 mg + 250 mg', 113.57, 19.76, 151.50, 30, 0, '6.05 Tk', 0, 0, '210-0326-025', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7477, 47, 2, 'Diproxen CR 500', 'Naproxen', '500 mg', 0.00, 0.00, 0.00, 0, 0, '10.05 Tk', 0, 0, '210-0327-064', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7478, 47, 2, 'D-Fen 0.5', 'Pizotifen', '500 mcg', 114.32, 19.89, 152.50, 50, 0, '3.05 Tk', 0, 0, '210-0329-047', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7479, 47, 2, 'D-Fen 1.5', 'Pizotifen', '1.5 mg', 189.28, 32.93, 252.50, 50, 0, '5.05 Tk', 0, 0, '210-0330-047', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7480, 47, 2, 'Telmicard', 'Telmisartan', '40 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '210-0377-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7481, 47, 2, 'Erybac 250', 'Erythromycin', '250 mg', 151.80, 26.41, 202.50, 50, 0, '4.05 Tk', 0, 0, '210-0379-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7482, 47, 2, 'Erybac 500', 'Erythromycin', '500 mg', 181.02, 31.50, 241.48, 30, 0, '8.05 Tk', 0, 0, '210-0380-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7483, 47, 2, 'Supra B', 'Cyanocobalamin + Pyridoxine Hydrochloride + Vitamin B1', '200 mcg + 200 mg + 100 mg', 299.85, 52.17, 400.00, 50, 0, '7.00 Tk', 0, 0, '210-0384-078', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:11', '2019-11-07 03:25:11', NULL),
(7484, 47, 2, 'Caldil', 'Calcium Carbonate', '1250 mg', 0.00, 0.00, 0.00, 0, 0, '3.05 Tk', 0, 0, '210-0255-062', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7485, 47, 2, 'Levoflox 500', 'Levofloxacin', '500 mg', 225.64, 39.26, 301.00, 20, 0, '15.05 Tk', 0, 0, '210-0182-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7486, 47, 2, 'Pronex 20', 'Esomeprazole', '20 mg', 211.99, 36.89, 282.79, 56, 0, '5.05 Tk', 0, 0, '210-0197-067', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:11', '2019-11-07 03:25:11', NULL),
(7487, 47, 2, 'Caldil PLUS', 'Calcium + Vitamin D3', '500 mg + 200 IU', 269.87, 46.96, 360.01, 60, 0, '6.00 Tk', 0, 0, '210-0370-062', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7489, 47, 2, 'Clarin 500', 'Clarithromycin', '500 mg', 300.98, 52.37, 401.51, 10, 0, '40.15 Tk', 0, 0, '210-0355-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7490, 47, 2, 'Spador 10', 'Escitalopram', '10 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '210-0361-014', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7491, 47, 2, 'Spador 5', 'Escitalopram', '5 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '210-0360-014', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7492, 47, 2, 'E Coxib 60', 'Etoricoxib', '60 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '210-0365-064', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7493, 47, 2, 'E Coxib 90', 'Etoricoxib', '90 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '210-0366-064', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7494, 47, 2, 'Carniten', 'Levocarnitine', '330 mg', 146.93, 25.57, 196.00, 49, 0, '4.00 Tk', 0, 0, '210-0371-075', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7495, 47, 2, 'Linzo 400', 'Linezolid', '400 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '210-0336-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7496, 47, 2, 'Oramet 500', 'Metformin Hydrochloride', '500 mg', 149.93, 26.09, 200.01, 50, 0, '4.00 Tk', 0, 0, '210-0354-015', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:11', '2019-11-07 03:25:11', NULL),
(7497, 47, 2, 'Betaloc XR 50', 'Metoprolol Tartrate', '50 mg', 303.60, 52.83, 405.00, 100, 0, '', 0, 0, '210-0345-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7498, 47, 2, 'Betaloc XR 100', 'Metoprolol Tartrate', '100 mg', 226.76, 39.46, 302.50, 50, 0, '6.05 Tk', 0, 0, '210-0346-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7499, 47, 2, 'M Kast 5', 'Montelukast', '5 mg', 221.59, 38.56, 295.60, 42, 0, '7.05 Tk', 0, 0, '210-0321-044', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7500, 47, 2, 'Misopep 200', 'Misoprostol', '200 mcg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '210-0274-049', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7501, 47, 2, 'Cardival', 'Valsartan', '80 mg', 226.01, 39.33, 301.50, 30, 0, '10.05 Tk', 0, 0, '210-0334-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7502, 47, 2, 'Miotrol 2.5', 'Zolmitriptan', '2.5 mg', 564.10, 98.15, 752.51, 50, 0, '15.05 Tk', 0, 0, '210-0335-047', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7503, 47, 2, 'Lexaton 50', 'Tolperisone Hydrochloride', '50 mg', 128.04, 22.28, 170.81, 56, 0, '3.05 Tk', 0, 0, '210-0342-070', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7504, 47, 2, 'Pansec 40', 'Pantoprazole', '40 mg', 295.95, 51.50, 394.80, 56, 0, '7.05 Tk', 0, 0, '210-0357-067', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:11', '2019-11-07 03:25:11', NULL),
(7505, 47, 2, 'Visonium', 'Tiemonium Methylsulphate', '50 mg', 187.41, 32.61, 250.00, 50, 0, '5.00 Tk', 0, 0, '210-0362-011', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:11', '2019-11-07 03:25:11', NULL),
(7506, 47, 2, 'Indapa Plus 2', 'Indapamide + Perindopril Erbumine', '625 mcg + 2 mg', 90.70, 15.78, 120.99, 20, 0, '6.05 Tk', 0, 0, '210-0372-042', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7507, 47, 2, 'Indapa Plus 4', 'Indapamide + Perindopril Erbumine', '1.25 mg + 4 mg', 90.33, 15.72, 120.50, 10, 0, '12.05 Tk', 0, 0, '210-0373-042', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7508, 47, 2, 'Monocard 20', 'Isosorbide Mononitrate', '20 mg', 107.20, 18.65, 143.00, 100, 0, '1.43 Tk', 0, 0, '210-0061-040', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7509, 47, 2, 'Pronex 40', 'Esomeprazole', '40 mg', 337.93, 58.80, 450.80, 56, 0, '8.05 Tk', 0, 0, '210-0358-067', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:11', '2019-11-07 03:25:11', NULL),
(7510, 47, 2, 'Pair 10', 'Ketorolac Tromethamine', '10 mg', 226.01, 39.33, 301.50, 30, 0, '10.05 Tk', 0, 0, '210-0391-064', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:11', '2019-11-07 03:25:11', NULL),
(7511, 47, 2, 'Olapine 5', 'Olanzapine', '5 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '210-0397-028', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7512, 47, 2, 'Olapin 10', 'Olanzapine', '10 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '210-0398-028', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7513, 47, 2, 'Resco 4', 'Risperidone', '4 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '210-0400-028', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7514, 47, 2, 'Sertal-25', 'Sertraline', '25 mg', 114.32, 19.89, 152.50, 50, 0, '3.05 Tk', 0, 0, '210-0401-014', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:11', '2019-11-07 03:25:11', NULL),
(7515, 47, 2, 'Sertal-100', 'Sertraline', '100 mg', 181.02, 31.50, 241.48, 30, 0, '8.05 Tk', 0, 0, '210-0402-014', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:11', '2019-11-07 03:25:11', NULL),
(7516, 47, 2, 'M Kast 10', 'Montelukast', '10 mg', 440.78, 76.70, 588.00, 42, 0, '13.00 Tk', 0, 0, '210-0404-044', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7517, 47, 2, 'Divastin 20', 'Atorvastatin', '20 mg', 379.91, 66.10, 506.80, 28, 0, '18.10 Tk', 0, 0, '210-0405-061', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7518, 47, 2, 'Niapid', 'Niacin', '500 mg', 0.00, 0.00, 0.00, 0, 0, '6.05 Tk', 0, 0, '210-0409-078', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7519, 47, 2, 'Fenenil', 'Caffeine + Paracetamol', '65 mg + 500 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '210-0412-006', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7520, 47, 2, 'Levoflox 750', 'Levofloxacin', '750 mg', 150.68, 26.22, 201.01, 10, 0, '20.10 Tk', 0, 0, '210-0415-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7521, 47, 2, 'Nitanid 500', 'Nitazoxanide', '500 mg', 0.00, 0.00, 0.00, 20, 0, '10.05 Tk', 0, 0, '210-0418-027', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7522, 47, 2, 'Trimet MR', 'Trimetazidine Dihydrochloride', '35 mg', 106.00, 18.44, 141.40, 28, 0, '5.05 Tk', 0, 0, '210-0421-040', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:11', '2019-11-07 03:25:11', NULL),
(7523, 47, 2, 'Entavir 0.5', 'Entecavir', '.5 mg', 473.84, 82.45, 632.10, 14, 0, '45.15 Tk', 0, 0, '210-0425-032', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7524, 47, 2, 'Entavir 1', 'Entecavir', '1 mg', 676.91, 117.78, 903.00, 10, 0, '90.30 Tk', 0, 0, '210-0426-032', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7525, 47, 2, 'Betaloc 25', 'Metoprolol Tartrate', '25 mg', 113.87, 19.81, 151.90, 98, 0, '1.55 Tk', 0, 0, '210-0431-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7526, 47, 2, 'Purinol', 'Allopurinol', '100 mg', 151.80, 26.41, 202.50, 50, 0, '4.05 Tk', 0, 0, '210-0430-076', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:11', '2019-11-07 03:25:11', NULL),
(7527, 47, 2, 'L-Cardin 2', 'Lacidipine', '2 mg', 0.00, 0.00, 0.00, 0, 0, '3.05 Tk', 0, 0, '210-0436-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7528, 47, 2, 'L-Cardin 4', 'Lacidipine', '4 mg', 0.00, 0.00, 0.00, 0, 0, '5.05 Tk', 0, 0, '210-0437-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7529, 47, 2, 'Ramicard 2.5 Plus', 'Hydrochlorothiazide + Ramipril', '12.5 mg + 2.5 mg', 211.99, 36.89, 282.79, 56, 0, '5.05 Tk', 0, 0, '210-0440-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:11', '2019-11-07 03:25:11', NULL),
(7530, 47, 2, 'Ramicard 5 Plus', 'Hydrochlorothiazide + Ramipril', '25 mg + 5 mg', 168.97, 29.40, 225.41, 28, 0, '8.05 Tk', 0, 0, '210-0441-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:11', '2019-11-07 03:25:11', NULL),
(7531, 47, 2, 'Ondason 8', 'Ondansetron', '8 mg', 226.01, 39.33, 301.50, 30, 0, '10.05 Tk', 0, 0, '210-0442-018', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:11', '2019-11-07 03:25:11', NULL),
(7532, 47, 2, 'Tenobis 2.5', 'Bisoprolol Hemifumarate', '2.5 mg', 253.97, 44.19, 338.80, 56, 0, '6.05 Tk', 0, 0, '210-0446-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:11', '2019-11-07 03:25:11', NULL),
(7533, 47, 2, 'Tenobis 5', 'Bisoprolol Hemifumarate', '5 mg', 316.42, 55.06, 422.10, 42, 0, '10.05 Tk', 0, 0, '210-0447-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:11', '2019-11-07 03:25:11', NULL),
(7534, 47, 2, 'AV-5', 'Amlodipine + Valsartan', '5 mg + 160 mg', 149.93, 26.09, 200.01, 20, 0, '10.00 Tk', 0, 0, '210-0448-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:09', '2019-11-07 03:25:09', NULL),
(7535, 47, 2, 'AV-10', 'Amlodipine + Valsartan', '10 mg + 160 mg', 194.91, 33.91, 260.01, 20, 0, '13.00 Tk', 0, 0, '210-0449-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:09', '2019-11-07 03:25:09', NULL),
(7536, 47, 2, 'Cytivir', 'Lamivudine', '100 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '210-0451-032', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7537, 47, 2, 'Zidovir Plus', 'Lamivudine + Zidovudine', '150 mg + 300 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '210-0452-032', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7538, 47, 2, 'Sulfacol', 'Sulfasalazine', '500 mg', 113.57, 19.76, 151.50, 30, 0, '5.05 Tk', 0, 0, '210-0453-064', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:11', '2019-11-07 03:25:11', NULL),
(7539, 47, 2, 'Rostatin', 'Rosuvastatin', '10 mg', 167.92, 29.22, 224.01, 28, 0, '8.00 Tk', 0, 0, '210-0454-061', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:11', '2019-11-07 03:25:11', NULL),
(7540, 47, 2, 'Rabesec', 'Rabeprazole Sodium', '20 mg', 211.99, 36.89, 282.79, 56, 0, '5.05 Tk', 0, 0, '210-0457-067', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:11', '2019-11-07 03:25:11', NULL),
(7541, 47, 2, 'Feripon', 'Deferiprone', '500 mg', 135.68, 23.61, 181.00, 10, 0, '18.10 Tk', 0, 0, '210-0458-045', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7542, 47, 2, 'Cardival Plus 80', 'Hydrochlorothiazide + Valsartan', '12.5 mg + 80 mg', 0.00, 0.00, 0.00, 0, 0, '8.05 Tk', 0, 0, '210-0459-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7543, 47, 2, 'Cardival Plus 160', 'Hydrochlorothiazide + Valsartan', '12.5 mg + 160 mg', 0.00, 0.00, 0.00, 0, 0, '16.05 Tk', 0, 0, '210-0460-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7544, 47, 2, 'Spiretic', 'Spironolactone', '25 mg', 113.57, 19.76, 151.50, 30, 0, '5.05 Tk', 0, 0, '210-0461-042', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:11', '2019-11-07 03:25:11', NULL),
(7545, 47, 2, 'Limpet 3', 'Glimepiride', '3 mg', 147.98, 25.75, 197.41, 28, 0, '7.05 Tk', 0, 0, '210-0462-015', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7546, 47, 2, 'Fexofast 120', 'Fexofenadine Hydrochloride', '120 mg', 158.15, 27.52, 210.97, 30, 0, '7.05 Tk', 0, 0, '210-0469-021', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7547, 47, 2, 'Fexofast 180', 'Fexofenadine Hydrochloride', '180 mg', 135.68, 23.61, 181.00, 20, 0, '9.05 Tk', 0, 0, '210-0470-021', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7548, 47, 2, 'Losardil 100/12.5', 'Hydrochlorothiazide + Losartan Potassium', '12.5 mg + 100 mg', 252.92, 44.01, 337.40, 28, 0, '', 0, 0, '210-0471-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7549, 47, 2, 'Losardil 100/25', 'Hydrochlorothiazide + Losartan Potassium', '25 mg + 100 mg', 180.66, 31.43, 241.00, 20, 0, '12.05 Tk', 0, 0, '210-0472-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7550, 47, 2, 'Ursolic 300', 'Ursodeoxycholic Acid', '300 mg', 150.68, 26.22, 201.01, 10, 0, '20.10 Tk', 0, 0, '210-0483-075', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:11', '2019-11-07 03:25:11', NULL),
(7551, 47, 2, 'Ursolic 150', 'Ursodeoxycholic Acid', '150 mg', 165.67, 28.83, 221.00, 20, 0, '11.05 Tk', 0, 0, '210-0482-075', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:11', '2019-11-07 03:25:11', NULL),
(7552, 47, 2, 'Divastin 40', 'Atorvastatin', '40 mg', 419.80, 73.05, 560.01, 28, 0, '20.00 Tk', 0, 0, '210-0473-061', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7553, 47, 2, 'D-Toin', 'Phenytoin Sodium', '100 mg', 224.89, 39.13, 300.00, 100, 0, '3.00 Tk', 0, 0, '210-0475-046', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7554, 47, 2, 'Maltrine', 'Artemether + Lumefantrine', '20 mg + 120 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '210-0477-024', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7555, 47, 2, 'Losardil 100', 'Losartan Potassium', '100 mg', 252.92, 44.01, 337.40, 28, 0, '12.05 Tk', 0, 0, '210-0481-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7556, 47, 2, 'Divastin Plus', 'Amlodipine + Atorvastatin', '5 mg + 10 mg', 0.00, 0.00, 0.00, 0, 0, '11.05 Tk', 0, 0, '210-0484-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7557, 47, 2, 'Gelcin', 'Gemefloxacin', '320 mg', 342.13, 59.53, 456.40, 7, 0, '65.20 Tk', 0, 0, '210-0486-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7558, 47, 2, 'Disartan', 'Amlodipine + Olmesartan Medoxomil', '5 mg + 20 mg', 187.41, 32.61, 250.00, 42, 0, '8.05 Tk', 0, 0, '210-0487-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7559, 47, 2, 'Nefivir', 'Nelfinavir', '250 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '210-0488-032', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7560, 47, 2, 'Olmetic Plus', 'Hydrochlorothiazide + Olmesartan Medoxomil', '12.5 mg + 20 mg', 253.45, 44.10, 338.10, 42, 0, '8.05 Tk', 0, 0, '210-0489-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:11', '2019-11-07 03:25:11', NULL),
(7561, 47, 2, 'T-Fovir', 'Tenofovir Disoproxil Fumarate', '300 mg', 447.60, 77.88, 597.10, 7, 0, '85.30 Tk', 0, 0, '210-0490-032', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:11', '2019-11-07 03:25:11', NULL),
(7562, 47, 2, 'Albasine', 'Almitrine Bismesylate + Raubasine', '30 mg + 10 mg', 379.38, 66.01, 506.09, 42, 0, '12.05 Tk', 0, 0, '210-0491-036', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:09', '2019-11-07 03:25:09', NULL),
(7563, 47, 2, 'Dialiptin', 'Vildagliptin', '50 mg', 473.84, 82.45, 632.10, 42, 0, '15.05 Tk', 0, 0, '210-0485-015', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7564, 47, 2, 'Sliptin', 'Sitagliptin', '100 mg', 0.00, 0.00, 0.00, 0, 0, '28.10 Tk', 0, 0, '210-0495-015', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7567, 47, 2, 'Rostatin 20', 'Rosuvastatin', '20 mg', 104.95, 18.26, 140.00, 14, 0, '10.00 Tk', 0, 0, '210-0500-061', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:11', '2019-11-07 03:25:11', NULL),
(7568, 47, 2, 'Theovent SR', 'Theophylline', '300 mg', 153.67, 26.74, 205.00, 100, 0, '2.05 Tk', 0, 0, '210-0501-044', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:11', '2019-11-07 03:25:11', NULL),
(7569, 47, 2, 'Cytivir 150', 'Lamivudine', '150 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '210-0502-032', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7570, 47, 2, 'Diamide', 'Glibenclamide', '5 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '210-0508-015', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7571, 47, 2, 'Thalide', 'Chlorthalidone', '25 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '210-0509-042', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7572, 47, 2, 'Limpet 4', 'Glimepiride', '4 mg', 189.96, 33.05, 253.41, 28, 0, '9.05 Tk', 0, 0, '210-0510-015', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7573, 47, 2, 'Piozena Plus 500', 'Metformin Hydrochloride + Pioglitazone', '500 mg + 15 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '210-0513-015', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7574, 47, 2, 'Piozena Plus 850', 'Metformin Hydrochloride + Pioglitazone', '850 mg + 15 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '210-0514-015', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7575, 47, 2, 'Spiracin 1.5', 'Spiramycine', '1.5 MIU', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '210-0516-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7576, 47, 2, 'Spiracin 3', 'Spiramycine', '3 MIU', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '210-0517-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7577, 47, 2, 'Fenatrol 145', 'Fenofibrate', '145 mg', 181.04, 31.50, 241.51, 30, 0, '8.05 Tk', 0, 0, '210-0518-061', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7578, 47, 2, 'Olmetic', 'Olmesartan Medoxomil', '20 mg', 253.45, 44.10, 338.10, 42, 0, '8.05 Tk', 0, 0, '210-0519-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:11', '2019-11-07 03:25:11', NULL),
(7579, 47, 2, 'Napsec 500', 'Esomeprazole + Naproxen', '20 mg + 500 mg', 226.01, 39.33, 301.50, 30, 0, '10.05 Tk', 0, 0, '210-0522-064', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7580, 47, 2, 'Napsec 375', 'Esomeprazole + Naproxen', '20 mg + 375 mg', 181.02, 31.50, 241.48, 30, 0, '8.05 Tk', 0, 0, '210-0522-064', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7581, 47, 2, 'Toldin', 'Tolterodine Tartrate', '2 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '210-0524-049', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7582, 47, 2, 'Nifetab SR', 'Nifedipine', '20 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '210-0525-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7583, 47, 2, 'D-Zole', 'Secnidazole', '1 gm', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '210-0526-027', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7584, 47, 2, 'Dialiptin-M 500', 'Metformin Hydrochloride + Vildagliptin', '500 mg + 50 mg', 168.44, 29.31, 224.70, 14, 0, '16.05 Tk', 0, 0, '210-0527-015', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7585, 47, 2, 'Prapid 5', 'Prasugrel', '5 mg', 180.66, 31.43, 241.00, 20, 0, '12.05 Tk', 0, 0, '210-0524-026', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:11', '2019-11-07 03:25:11', NULL),
(7586, 47, 2, 'Prapid 10', 'Prasugrel', '10 mg', 150.68, 26.22, 201.01, 10, 0, '20.10 Tk', 0, 0, '210-0529-026', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:11', '2019-11-07 03:25:11', NULL),
(7587, 47, 2, 'Dimerol 60', 'Gliclazide', '60 mg', 149.93, 26.09, 200.01, 20, 0, '10.00 Tk', 0, 0, '210-0530-015', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7588, 47, 2, 'Granison', 'Granisetron', '1 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '210-0531-018', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7589, 47, 2, 'Tenobis Plus 2.5', 'Bisoprolol Hemifumarate + Hydrochlorothiazide', '2.5 mg + 6.25 mg', 0.00, 0.00, 0.00, 0, 0, '6.05 Tk', 0, 0, '210-0533-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7590, 47, 2, 'Tenobis Plus 5', 'Bisoprolol Hemifumarate + Hydrochlorothiazide', '5 mg + 6.25 mg', 0.00, 0.00, 0.00, 0, 0, '10.05 Tk', 0, 0, '210-0534-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7591, 47, 2, 'Tenobis Plus 10', 'Bisoprolol Hemifumarate + Hydrochlorothiazide', '10 mg + 6.25 mg', 120.32, 20.94, 160.51, 10, 0, '16.05 Tk', 0, 0, '210-0535-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:11', '2019-11-07 03:25:11', NULL),
(7592, 47, 2, 'Dipa', 'Rupatadine', '10 mg', 181.04, 31.50, 241.51, 30, 0, '8.05 Tk', 0, 0, '210-0536-021', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7593, 47, 2, 'Theovent SR 200', 'Theophylline', '200 mg', 119.94, 20.87, 160.00, 100, 0, '1.60 Tk', 0, 0, '210-0537-044', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:11', '2019-11-07 03:25:11', NULL),
(7594, 47, 2, 'Lip Loss', 'Pitavastatin', '2 mg', 0.00, 0.00, 0.00, 0, 0, '10.05 Tk', 0, 0, '210-0538-061', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7595, 47, 2, 'Ivaten 5', 'Ivabradine', '5 mg', 188.16, 32.74, 251.01, 10, 0, '16.00 Tk', 0, 0, '210-0539-040', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7596, 47, 2, 'Ivaten 7.5', 'Ivabradine', '7.5 mg', 263.49, 45.85, 351.50, 10, 0, '25.00 Tk', 0, 0, '210-0540-040', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7597, 47, 2, 'Demoxicalv-1 gm', 'Amoxicillin + Clavulanic Acid', '875 mg + 125 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '210-0541-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7598, 47, 2, 'Sliptin-M 500', 'Metformin Hydrochloride + Sitagliptin', '500 mg + 50 mg', 168.44, 29.31, 224.70, 14, 0, '16.05 Tk', 0, 0, '210-0544-015', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:11', '2019-11-07 03:25:11', NULL),
(7599, 47, 2, 'Dialiptin M 850', 'Metformin Hydrochloride + Vildagliptin', '850 mg + 50 mg', 178.94, 31.14, 238.71, 14, 0, '17.05 Tk', 0, 0, '210-0545-015', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7600, 47, 2, 'Rinis', 'Ebastine', '10 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '210-0546-021', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7601, 47, 2, 'Rostatin 5', 'Rosuvastatin', '5 mg', 188.91, 32.87, 252.01, 42, 0, '6.00 Tk', 0, 0, '210-0548-061', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:11', '2019-11-07 03:25:11', NULL),
(7602, 47, 2, 'Fuclav-500', 'Cefuroxime + Clavulanic Acid', '500 mg + 125 mg', 0.00, 0.00, 0.00, 0, 0, '50.20 Tk', 0, 0, '210-0550-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7603, 47, 2, 'Fuclav-250', 'Cefuroxime + Clavulanic Acid', '250 mg + 62.5 mg', 0.00, 0.00, 0.00, 0, 0, '30.10 Tk', 0, 0, '210-0551-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7604, 47, 2, 'Fuclav-125', 'Cefuroxime + Clavulanic Acid', '125 mg + 31.25 mg', 0.00, 0.00, 0.00, 0, 0, '18.10 Tk', 0, 0, '210-0552-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7605, 47, 2, 'Sliptin 25', 'Sitagliptin', '25 mg', 253.45, 44.10, 338.10, 42, 0, '8.05 Tk', 0, 0, '210-0554-015', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:11', '2019-11-07 03:25:11', NULL),
(7606, 47, 2, 'Sliptin 50', 'Sitagliptin', '50 mg', 315.90, 54.97, 421.41, 28, 0, '15.05 Tk', 0, 0, '210-0555-015', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:11', '2019-11-07 03:25:11', NULL),
(7607, 47, 2, 'Sliptin-M 1000', 'Metformin Hydrochloride + Sitagliptin', '1000 mg + 50 mg', 189.95, 33.05, 253.39, 14, 0, '18.10 Tk', 0, 0, '210-0556-015', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:11', '2019-11-07 03:25:11', NULL),
(7610, 47, 2, 'Faxan 200', 'Rifaximin', '200 mg', 210.95, 36.71, 281.41, 14, 0, '20.10 Tk', 0, 0, '210-0567-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7611, 47, 2, 'Faxan 550', 'Rifaximin', '550 mg', 210.68, 36.66, 281.05, 7, 0, '40.15 Tk', 0, 0, '210-0568-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7612, 47, 2, 'Tanox', 'Betacarotene + Vitamin C + Vitamin E', '6 mg + 200 mg + 50 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '210-0570-078', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7613, 47, 2, 'Tanox Plus', 'Beta Carotene + Copper + Manganese + Selenium + Vitamin C + Vitamin E + Vitamin K + Zinc', '6 mg + 1 mg + 3 mg + 70 mcg + 200 mg + 50 mg + 75 mcg + 15 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '210-0571-078', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7614, 47, 2, 'Ramicard 1.25', 'Ramipril', '1.25 mg', 107.05, 18.63, 142.80, 56, 0, '2.55 Tk', 0, 0, '210-0573-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:11', '2019-11-07 03:25:11', NULL),
(7615, 47, 2, 'Neuropen 100', 'Gabapentin', '100 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '210-0574-046', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7616, 47, 2, 'Tigarol', 'Ticagrelor', '90 mg', 787.11, 136.96, 1050.00, 14, 0, '75.00 Tk', 0, 0, '210-0576-026', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:11', '2019-11-07 03:25:11', NULL),
(7617, 47, 2, 'Bacmax 5', 'Baclofen', '5 mg', 170.02, 29.58, 226.81, 56, 0, '4.05 Tk', 0, 0, '210-0578-070', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7618, 47, 2, 'Bacmax 10', 'Baclofen', '10 mg', 168.97, 29.40, 225.41, 28, 0, '8.05 Tk', 0, 0, '210-0579-070', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7619, 47, 2, 'Dicaltrol Plus', 'Calcitriol + Calcium', '.25 mcg + 252 mg', 292.35, 50.87, 389.99, 30, 0, '12.05 Tk', 0, 0, '210-0580-078', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7620, 47, 2, 'Linarol', 'Linagliptin', '5 mg', 503.75, 87.65, 672.00, 42, 0, '15.05 Tk', 0, 0, '210-0586-015', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7621, 47, 2, 'Rofumil', 'Roflumilast', '500 mcg', 150.67, 26.22, 200.99, 20, 0, '10.05 Tk', 0, 0, '210-0588-044', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:11', '2019-11-07 03:25:11', NULL),
(7622, 47, 2, 'Caldil OT', 'Calcium Orotate', '400 mg', 181.04, 31.50, 241.51, 30, 0, '8.05 Tk', 0, 0, '210-0594-062', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7623, 47, 2, 'Ferotab', 'Elemental Iron + Folic Acid + Zinc Sulphate Monohydrate', '48 mg + 500 mcg + 61.8 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '210-0602-045', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7624, 47, 2, 'AV-5/80', 'Amlodipine + Valsartan', '5 mg + 80 mg', 220.39, 38.35, 294.00, 42, 0, '7.00 Tk', 0, 0, '210-0601-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:09', '2019-11-07 03:25:09', NULL),
(7625, 47, 2, 'Sudac 100', 'Sulindac', '100 mg', 187.41, 32.61, 250.00, 50, 0, '5.00 Tk', 0, 0, '210-0603-064', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:11', '2019-11-07 03:25:11', NULL),
(7626, 47, 2, 'Sudac 200', 'Sulindac', '200 mg', 134.93, 23.48, 180.00, 20, 0, '9.00 Tk', 0, 0, '210-0604-064', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:11', '2019-11-07 03:25:11', NULL),
(7627, 47, 2, 'Fevedol', 'Paracetamol + Tramadol Hydrochloride', '325 mg + 37.5 mg', 112.45, 19.57, 150.01, 30, 0, '5.00 Tk', 0, 0, '210-0605-006', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7629, 47, 2, 'Glucotin Max', 'Diacerein + Glucosamine Sulphate', '50 mg + 750 mg', 188.91, 32.87, 252.01, 21, 0, '12.00 Tk', 0, 0, '210-0611-064', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7630, 47, 2, 'Ejalong 30', 'Dapoxetine', '30 mg', 89.96, 15.65, 120.01, 6, 0, '20.00 Tk', 0, 0, '210-0621-014', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7631, 47, 2, 'Ejalong 60', 'Dapoxetine', '60 mg', 179.91, 31.30, 240.00, 6, 0, '40.00 Tk', 0, 0, '210-0622-014', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7632, 47, 2, 'Disartan 5/40', 'Amlodipine + Olmesartan Medoxomil', '5 mg + 40 mg', 251.87, 43.83, 335.99, 28, 0, '', 0, 0, '210-0624-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7633, 47, 2, 'Mycofree 250', 'Terbinafine', '250 mg', 0.00, 0.00, 0.00, 0, 0, '28.00 Tk', 0, 0, '210-0623-020', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7634, 47, 2, 'Floxalone 400', 'Moxifloxacin', '400 mg', 157.42, 27.39, 210.00, 7, 0, '35.00 Tk', 0, 0, '210-0631-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7635, 47, 2, 'Block-T 500', 'Tranexamic Acid', '500 mg', 224.89, 39.13, 300.00, 20, 0, '15.00 Tk', 0, 0, '210-0633-019', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7636, 47, 2, 'Palnox 0.5', 'Palonosetron', '.5 mg', 314.85, 54.78, 420.01, 42, 0, '10.00 Tk', 0, 0, '210-0635-018', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:11', '2019-11-07 03:25:11', NULL),
(7637, 47, 2, 'Doxoma', 'Doxophylline', '400 mg', 143.93, 25.04, 192.00, 30, 0, '6.00 Tk', 0, 0, '210-0637-044', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7638, 47, 2, 'Fexofast 60', 'Fexofenadine Hydrochloride', '60 mg', 131.18, 22.83, 174.99, 50, 0, '3.50 Tk', 0, 0, '210-0639-021', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL);
INSERT INTO `medicines` (`id`, `company_id`, `medicine_type_id`, `name`, `generic_name`, `strength`, `tp_per_box`, `vat_per_box`, `mrp_per_box`, `pcs_per_box`, `pcs_per_strip`, `price_per_box`, `price_per_strip`, `price_per_pcs`, `dar_no`, `is_imported`, `is_antibiotic`, `product_type`, `status`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`) VALUES
(7639, 47, 2, 'Fexofast 30', 'Fexofenadine Hydrochloride', '30 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '210-0640-021', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7640, 47, 2, 'Naturetic', 'Amiloride Hydrochloride + Hydrochlorothiazide', '5 mg + 50 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '210-0641-042', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7641, 47, 2, 'Ezitab', 'Ezetimibe', '10 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '210-0642-061', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7642, 47, 2, 'Sixtin 2.5', 'Saxagliptin', '2.5 mg', 167.92, 29.22, 224.01, 14, 0, '16.00 Tk', 0, 0, '210-0643-015', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:11', '2019-11-07 03:25:11', NULL),
(7643, 47, 2, 'Sixtin 5', 'Saxagliptin', '5 mg', 314.85, 54.78, 420.01, 14, 0, '30.00 Tk', 0, 0, '210-0644-015', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:11', '2019-11-07 03:25:11', NULL),
(7644, 47, 2, 'Dimezin', 'Cinnarizine + Dimenhydrinate', '20 mg + 40 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '210-0652-021', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7645, 47, 2, 'D-Pira', 'Piracetam', '800 mg', 134.93, 23.48, 180.00, 30, 0, '6.00 Tk', 0, 0, '210-0655-075', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7646, 47, 2, 'Anilic', 'Tolfenamic Acid', '200 mg', 179.91, 31.30, 240.00, 30, 0, '8.00 Tk', 0, 0, '210-0656-047', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:09', '2019-11-07 03:25:09', NULL),
(7647, 47, 2, 'HopSo', 'Sofosbuvir', '400 mg', 271.30, 0.00, 314.71, 7, 0, '450.00 Tk', 0, 0, '210-0658-032', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7648, 47, 2, 'Cikolin 500', 'Citicoline', '500 mg', 262.37, 45.65, 350.00, 7, 0, '50.00 Tk', 0, 0, '210-0662-036', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7649, 47, 2, 'Canarol-100', 'Canagliflozin', '100 mg', 449.78, 78.26, 600.01, 10, 0, '60.00 Tk', 0, 0, '210-0663-', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7650, 47, 2, 'Daparol', 'Dapagliflozin', '5 mg', 157.42, 27.39, 210.00, 14, 0, '15.00 Tk', 0, 0, '210-0665-015', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7651, 47, 2, 'Seacal-D', 'Calcium (Coral Calcium) + Vitamin D3', '500 mg + 200 IU', 0.00, 0.00, 0.00, 0, 0, '10.00 Tk', 0, 0, '210-0666-062', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7652, 47, 2, 'Migon-5', 'Flunarizine', '5 mg', 125.94, 21.91, 168.00, 56, 0, '5.00 Tk', 0, 0, '210-0667-047', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7653, 47, 2, 'Migon-10', 'Flunarizine', '10 mg', 209.90, 36.52, 280.01, 56, 0, '8.00 Tk', 0, 0, '210-0668-047', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7654, 47, 2, 'Ardium', 'Diosmin + Hesperidin', '450 mg + 50 mg', 179.91, 31.30, 240.00, 30, 0, '8.00 Tk', 0, 0, '210-0669-075', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:09', '2019-11-07 03:25:09', NULL),
(7655, 47, 2, 'Resant', 'Mirtazapine', '15 mg', 125.94, 21.91, 168.00, 28, 0, '6.00 Tk', 0, 0, '210-0670-014', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:11', '2019-11-07 03:25:11', NULL),
(7656, 47, 2, 'Nalipsy', 'Sodium Valproate', '200 mg', 224.89, 39.13, 300.00, 100, 0, '3.00 Tk', 0, 0, '210-0671-046', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7657, 47, 2, 'Pancil', 'Cilostazol', '100 mg', 251.87, 43.83, 335.99, 28, 0, '12.00 Tk', 0, 0, '210-0672-036', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:11', '2019-11-07 03:25:11', NULL),
(7658, 47, 2, 'Tanzil', 'Azilsartan Medoxomil', '40 mg', 125.94, 21.91, 168.00, 14, 0, '12.00 Tk', 0, 0, '210-0681-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:11', '2019-11-07 03:25:11', NULL),
(7659, 47, 2, 'Nebifast 2.5', 'Nebivolol', '2.5 mg', 125.94, 21.91, 168.00, 28, 0, '6.00 Tk', 0, 0, '210-0682-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7660, 47, 2, 'Nebifast-5', 'Nebivolol', '5 mg', 167.92, 29.22, 224.01, 28, 0, '8.00 Tk', 0, 0, '210-0683-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7661, 47, 2, 'SeaCal-DX', 'Calcium + Cholecalciferol (Vit. D3)', '600 mg + 400 IU', 0.00, 0.00, 0.00, 0, 0, '12.00 Tk', 0, 0, '210-0684-062', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7662, 47, 2, 'Rantoin', 'Nitrofurantoin', '100 mg', 134.93, 23.48, 180.00, 30, 0, '6.00 Tk', 0, 0, '210-0693-023', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:11', '2019-11-07 03:25:11', NULL),
(7663, 47, 2, 'Cavelon 3.125', 'Carvedilol', '3.125 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '210-0694-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7664, 47, 2, 'Doxoma 200', 'Doxophylline', '200 mg', 149.93, 26.09, 200.01, 50, 0, '4.00 Tk', 0, 0, '210-0702-044', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL),
(7665, 47, 2, 'Nimoral', 'Nimodipine', '30 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '210-0704-022', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7666, 47, 2, 'Irricol', 'Dicycloverine Hydrochloride', '10 mg', 0.00, 0.00, 0.00, 0, 0, '', 0, 0, '210-0706-011', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-09-29 03:49:05', '2019-08-22 02:57:37', NULL),
(7667, 47, 2, 'Linarol-M 500', 'Linagliptin + Metformin Hydrochloride', '2.5 mg + 500 mg', 125.94, 21.91, 168.00, 14, 0, '12.00 Tk', 0, 0, '210-0711-015', 0, 0, 1, 'ACTIVE', NULL, NULL, '2019-11-07 03:25:10', '2019-11-07 03:25:10', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `medicine_companies`
--

CREATE TABLE `medicine_companies` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `company_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('ACTIVE','INACTIVE') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ACTIVE',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `medicine_companies`
--

INSERT INTO `medicine_companies` (`id`, `company_name`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'ACI HealthCare Limited', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(2, 'Acmunio International Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(4, 'Ad-din Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(5, 'ACI Limited', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(6, 'Advent Pharma Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(7, 'Al-Madina Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(8, 'Albion Laboratories Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(9, 'Alco Pharma Limited', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(10, 'Alkad Laboratories', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(11, 'Allied Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(12, 'Ambee Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(13, 'Amico Laboratories Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(14, 'Amulet Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(15, 'APC Pharma Limited', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(16, 'Apex Pharma Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(17, 'Apollo Pharmaceutical Laboratories Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(18, 'Aristopharma Limited', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(19, 'Asiatic Laboratories Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(20, 'Astra Biopharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(21, 'Aztec Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(22, 'Bangladesh Antibiotic Industries Limited', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(23, 'Beacon Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(24, 'Belsen Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(25, 'Bengal Drugs & Chemical Works Pharm. Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(26, 'Bengal Remedies Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(27, 'Benham Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(28, 'Beximco Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(29, 'Biogen Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(30, 'Biopharma Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(31, 'Bios Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(32, 'Bridge Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(33, 'Bristol Pharma Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(34, 'Centeon Pharma Limited', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(35, 'Central Pharmaceutical Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(36, 'Chemist Laboratories Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(37, 'Cipla Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(38, 'Concord Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(39, 'Cosmic Pharma Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(40, 'Cosmo Pharma Laboratories Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(41, 'Decent Pharma Laboratories Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(42, 'Delta Chemicals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(43, 'Delta Pharma Limited', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(44, 'Desh Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(45, 'Doctor Tims Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(46, 'Doctors Chemicals Works Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(47, 'Drug International Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(48, 'EDCL', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(49, 'Edruc Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(50, 'EMCS Pharma Limited', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(51, 'Eon Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(52, 'Eskayef Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(53, 'Ethical Drug Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(54, 'Euro Pharma Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(55, 'Everest Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(56, 'FnF Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(57, 'G. A. Company Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(58, 'General Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(59, 'Gentry Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(60, 'Genvio Pharma Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(61, 'Get Well Limited', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(62, 'Global Capsules Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(63, 'Global Heavy Chemicals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(64, 'Globe Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(65, 'Globex Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(66, 'Gonoshasthaya Antibiotic Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(67, 'Gonoshasthaya Basic Chemical Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(68, 'Gonoshasthaya Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(69, 'Goodman Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(70, 'Greenland Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(71, 'Guardian Healthcare Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(72, 'Hallmark Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(73, 'Healthcare Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(74, 'Hope Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(75, 'Hudson Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(76, 'Ibn Sina Pharmaceutical Ind. Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(77, 'Incepta Chemicals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(78, 'Incepta Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(79, 'Incepta Vaccine Limited', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(80, 'Indo-Bangla Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(81, 'Institute of Public Health', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(82, 'Islam Oxygen (Pvt) Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(83, 'Jalalabad Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(84, 'Jayson Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(85, 'JMI Industrial Gas Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(86, 'JMI Syringes & Medical Devices Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(87, 'Julphar Bangladesh Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(88, 'Kemiko Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(89, 'Kumudini Pharma Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(90, 'Labaid Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(91, 'Leon Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(92, 'Libra Pharmaceuticls Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(93, 'Linde Bangladesh Limited', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(94, 'Maks Drugs Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(95, 'Marker Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(96, 'Marksman Pharmaceutical Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(97, 'Medicon Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(98, 'Medimet Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(99, 'MedRx Life Science Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(100, 'Millat Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(101, 'Modern Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(102, 'Momotaz Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(103, 'Monicopharma Limited', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(104, 'Monomedi Bangladesh Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(105, 'MSF Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(106, 'MST Pharma and Healthcare Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(107, 'Mundipharma (Bangladesh) Pvt. Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(108, 'Naafco Pharma Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(109, 'National Laboratories Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(110, 'Navana Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(111, 'Newtec Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(112, 'Nip Chemicals And Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(113, 'Nipa Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(114, 'NIPRO JMI Company Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(115, 'NIPRO JMI Pharma Limited', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(116, 'Novartis (Bangladesh) Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(117, 'Novelta Bestway Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(118, 'Novo Healthcare and Pharma Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(119, 'Novus Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(120, 'Nuvista Pharma Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(121, 'One Pharma Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(122, 'Opso Saline Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(123, 'Opsonin Bulk Drugs Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(124, 'Opsonin Pharma Limited', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(125, 'Orbit Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(126, 'Organic Health Care', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(127, 'Orion Infusion Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(128, 'Orion Pharma Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(129, 'Oyster Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(130, 'Pacific Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(131, 'Peoples Pharma Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(132, 'Pharmacil Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(133, 'Pharmadesh Laboratories Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(134, 'Pharmasia Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(135, 'Pharmatek Chemicals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(136, 'Pharmik Laboratories Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(137, 'Phoenix Chemicals Laboratory (BD) Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(138, 'Popular Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(139, 'Premier Pharmaceuticals', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(140, 'Prime Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(141, 'Quality Pharmaceuticals (Pvt) Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(142, 'Radiant Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(143, 'Rahman Chemicals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(144, 'Rampart-Power Bangladesh Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(145, 'Rangs Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(146, 'Reckitt Benckiser Bangladesh Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(147, 'Reliance Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(148, 'Reman Drug Laboratories Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(149, 'Remo Chemical Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(150, 'Renata Limited', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(151, 'Renata Oncology Limited', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(152, 'Rephco Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(153, 'RN Pharmaceuticals', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(154, 'S. N. Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(155, 'Salton Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(156, 'Sanofi Bangladesh Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(157, 'Save Pharmaceutical', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(158, 'Seba Laboratories Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(159, 'Seema Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(160, 'Sharif Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(161, 'Silco Pharmaceuticlas Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(162, 'Silva Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(163, 'SMC Enterprise Limited', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(164, 'Sodical Chemical Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(165, 'Somatec Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(166, 'Spectra Oxygen Limited', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(167, 'Square Cephalosporins Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(168, 'Square Formulations Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(169, 'Square Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(170, 'Standard Laboratories Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(171, 'Sun Pharmaceutical (Bangladesh) Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(172, 'Sunman-Birdem Pharma Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(173, 'Super Power Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(174, 'Supreme Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(175, 'Team Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(176, 'Techno Drugs Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(177, 'The ACME Laboratories Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(178, 'The White Horse Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(179, 'Unimed Unihealth Manufacturers Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(180, 'Union Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(181, 'Unique Pharmaceutical Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(182, 'United Chemicals & Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(183, 'Veritas Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(184, 'Virgo Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(185, 'World Chemical Industry Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(186, 'Zenith Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(187, 'Ziska Pharmaceuticals Ltd', 'ACTIVE', '2019-06-24 18:25:31', '0000-00-00 00:00:00', NULL),
(188, 'GlaxoSmithKline Bangladesh Ltd.', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(189, 'Nestle Bangladesh Ltd.', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(190, 'Square Toiletries Ltd', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(191, 'ACI Consumer Ltd.', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(192, 'Procter & Gamble Bangladesh Private Ltd. (P&G)', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(193, 'Bashundhara Paper Mills Ltd.', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(194, 'Anfords Bangladesh Ltd.', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(195, 'Reckitt Benckiser Bangladesh Ltd.', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(196, 'Pro Dental B Sdn.Bhd', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(197, 'Colgate Palmolive India Ltd.', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(198, 'Bangladesh Silicone Corporation.', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(199, 'Universal Hygiene Care.', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(200, 'Yelowcare Ltd.', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(201, 'Dabur Nepal Pvt. Ltd.', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(202, 'Parl International Bangladesh.', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(203, 'Acme Lab', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(204, 'Incepta Pharmaceuticals Limited', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(205, 'MultiBrands Ltd Dhaka.Bangladesh', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(206, 'Smart Distribution', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(207, 'Evergreen International', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(208, 'SSN Medical Product.SDN.BHD', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(209, 'Life Link International', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(210, 'Social Marketing Company Bangladesh', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(211, 'Arena Consumer Products', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(212, 'Classic Brand Co. Dhaka.Bangladesh', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(213, 'Changzhou Operson IMP & EXP Co.Ltd', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(214, 'Marketed By Thailand', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(215, 'Get Well Bangladesh Ltd', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(216, 'Hindustan Syringes & Medical Devices Ltd', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(217, 'Novo Nordisk Pharmaceutical Company', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(218, 'Medicare Dependent Ltd', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(219, 'Sevincler Turkiye Ltd', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(220, 'Others', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(221, 'Unilever Bangladesh Limited', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(222, 'General Pharmaceuticals Limited', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(224, 'Square Pharmaceutical Limited', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(225, 'Fulijaya Manufacturing Sdn. Bhd.', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(226, 'UniMed & UniHealth Mfg. Ltd.', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(227, 'Emami Bangladesh Ltd', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(228, 'Remesco Handelsges.M.B.H', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(229, 'The Aman Surgical Dressings Co Ltd', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(230, 'Shanto Enterprise', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(231, 'SMIC Brand', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(232, 'Mediklin Ltd', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(233, 'HealthWay Ltd', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(234, 'GlaxoSmithKline India Ltd', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(235, 'Vijaya Laboratories India Ltd', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(236, 'Kazi & Kazi Tea', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(237, 'SQUARE Herbal & Nutraceuticals Ltd', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(238, 'Czechpak Manufacturing S.R.O', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(239, 'Unilever Bangladesh Ltd.', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(240, 'Johnson & Johnson', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(241, 'Himalaya Herbal Healthcare.India', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(242, 'Fay Industries Ltd', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(243, 'Jolly Chemical', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(244, 'JMS Sigapore PTE LTD', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(245, 'Marketed By China', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(246, 'JMI Syringes & Medical Devices Ltd', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(247, 'BMH International Co. Ltd', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(248, 'Nivea India Pvt Ltd', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(249, 'Marico Bangladesh Ltd', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(250, 'kohinoor chemical co.', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(251, 'Emami Ltd.india', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(252, 'Garnier India Ltd', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(253, 'UNIQUE Europe', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(254, 'International Brands Limited Bangladesh', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(255, 'Helen of Troy Limited', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(256, 'ITC India Pvt Ltd', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(257, 'Adidas Toiletries Ltd', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(258, 'Altadis USA Ltd', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(259, 'wipro unza holdings pte Ltd', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(260, 'Mcnroe Consumer Products Private Limited', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(261, 'keya Cosmetics Ltd', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(262, 'ACI Godrej Agrovet Private Limited', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(263, 'Rohto-Mentholatum (Bangladesh) Limited', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(264, 'Revlon Pvt Ltd', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(265, 'Gatsby Global Pvt Ltd', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(266, 'Hemas Holdings PLC', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(267, 'G & H Cosmetics Ltd (Farmasi)', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(268, 'Hygienic Research Institute Pvt Ltd', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(269, 'Pepper Sion Pte. Ltd.', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(270, 'Pentagon International Limited', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(271, 'Mousumi Industries Ltd.', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(272, 'London Cosmetics BD', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(273, 'Zydus Wellness Ltd', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(274, 'Avonee Bangladesh Ltd', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(275, 'InterMESH Ltd.', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(276, 'Mamypoko Malaysia Ltd', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(277, 'HAYAT KIMYA Ltd', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(278, 'Asian Consumar Care.', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(279, 'Bangladesh Silicone Corporation', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(280, 'Fasska', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(281, 'Sunshine Pharma', 'ACTIVE', '2019-08-28 02:18:38', '2019-08-27 14:23:02', NULL),
(282, 'Acme Labortories Ltd. (Herbal Division)', 'ACTIVE', '2019-09-10 21:52:54', '2019-09-10 21:52:54', NULL),
(283, 'Alien Pharma (Herbal)', 'ACTIVE', '2019-09-10 21:53:48', '2019-09-10 21:53:48', NULL),
(284, 'APS Laboratories (Herbal)', 'ACTIVE', '2019-09-10 21:53:48', '2019-09-10 21:53:48', NULL),
(285, 'Aryan Herbal', 'ACTIVE', '2019-09-10 21:53:48', '2019-09-10 21:53:48', NULL),
(286, 'Ashoka Laboratories (Herbal)', 'ACTIVE', '2019-09-10 21:53:48', '2019-09-10 21:53:48', NULL),
(287, 'Bexter Herbal & Nutraceuticals (Herbal)', 'ACTIVE', '2019-09-10 21:53:48', '2019-09-10 21:53:48', NULL),
(288, 'Chemist Herbal Care & Nutraceuticals Ltd.', 'ACTIVE', '2019-09-10 21:53:48', '2019-09-10 21:53:48', NULL),
(289, 'Deeplaid Herbal Laboratories Ltd. (Herbal Division)', 'ACTIVE', '2019-09-10 21:53:49', '2019-09-10 21:53:49', NULL),
(290, 'Drug International Ltd. (Herbal Division)', 'ACTIVE', '2019-09-10 21:53:49', '2019-09-10 21:53:49', NULL),
(291, 'Esetec Incorporation (Herbal)', 'ACTIVE', '2019-09-10 21:53:49', '2019-09-10 21:53:49', NULL),
(292, 'Hamdard Laboratories (Waqf) Bangladesh (Herbal Division)', 'ACTIVE', '2019-09-10 21:53:49', '2019-09-10 21:53:49', NULL),
(293, 'Ibn Haisam Herbal and Neutraceuticals', 'ACTIVE', '2019-09-10 21:53:49', '2019-09-10 21:53:49', NULL),
(294, 'Ibn Sina Natural Medicine Ltd. (Herbal)', 'ACTIVE', '2019-09-10 21:53:49', '2019-09-10 21:53:49', NULL),
(295, 'Idrul Herbal and Nutraceuticals', 'ACTIVE', '2019-09-10 21:53:49', '2019-09-10 21:53:49', NULL),
(296, 'Incepta Herbal & Nutricare Ltd.', 'ACTIVE', '2019-09-10 21:53:49', '2019-09-10 21:53:49', NULL),
(297, 'Kemiko Pharmaceuticals Ltd. (Herbal Division)', 'ACTIVE', '2019-09-10 21:53:49', '2019-09-10 21:53:49', NULL),
(298, 'Medimet Herbal and Nutraceuticals', 'ACTIVE', '2019-09-10 21:53:49', '2019-09-10 21:53:49', NULL),
(299, 'Mirco Neutricare (Herbal)', 'ACTIVE', '2019-09-10 21:53:49', '2019-09-10 21:53:49', NULL),
(300, 'Modern Drug (Herbal)', 'ACTIVE', '2019-09-10 21:53:49', '2019-09-10 21:53:49', NULL),
(301, 'Modern Herbal Pharmaceuticals', 'ACTIVE', '2019-09-10 21:53:49', '2019-09-10 21:53:49', NULL),
(302, 'Parent Herbal Laboratories', 'ACTIVE', '2019-09-10 21:53:49', '2019-09-10 21:53:49', NULL),
(303, 'Popular Pharmaceuticals Ltd. (Herbal Division)', 'ACTIVE', '2019-09-10 21:53:49', '2019-09-10 21:53:49', NULL),
(304, 'Radiant Nutraceuticals Ltd. (Herbal Division)', 'ACTIVE', '2019-09-10 21:53:49', '2019-09-10 21:53:49', NULL),
(305, 'Renata Limited (Herbal Division)', 'ACTIVE', '2019-09-10 21:53:49', '2019-09-10 21:53:49', NULL),
(306, 'S. B. Herbal and Nutraceuticals', 'ACTIVE', '2019-09-10 21:53:49', '2019-09-10 21:53:49', NULL),
(307, 'Safe Herbal Ltd.', 'ACTIVE', '2019-09-10 21:53:49', '2019-09-10 21:53:49', NULL),
(308, 'Square Pharmaceuticals Ltd. (Herbal Division)', 'ACTIVE', '2019-09-10 21:53:49', '2019-09-10 21:53:49', NULL),
(309, 'Total Herbal and Nutraceuticals', 'ACTIVE', '2019-09-10 21:53:49', '2019-09-10 21:53:49', NULL),
(310, 'Unity Pharmaceuticals (Herbal)', 'ACTIVE', '2019-09-10 21:53:49', '2019-09-10 21:53:49', NULL),
(311, 'Western Pharmaceuticals (Herbal)', 'ACTIVE', '2019-09-10 21:53:49', '2019-09-10 21:53:49', NULL),
(312, 'Winstar Pharmaceuticals (Herbal)', 'ACTIVE', '2019-09-10 21:53:49', '2019-09-10 21:53:49', NULL),
(316, 'G K Pharmaceuticals Ltd', 'ACTIVE', '2019-11-17 18:44:50', '2019-11-17 18:44:50', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `medicine_types`
--

CREATE TABLE `medicine_types` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `medicine_types`
--

INSERT INTO `medicine_types` (`id`, `name`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Capsule', NULL, NULL, NULL),
(2, 'Tablet', NULL, NULL, NULL),
(3, 'Syringe', NULL, NULL, NULL),
(4, 'Powder For Suspension', NULL, NULL, NULL),
(5, 'Cream', NULL, NULL, NULL),
(6, 'Gel', NULL, NULL, NULL),
(7, 'Lotion', NULL, NULL, NULL),
(8, 'Ointment', NULL, NULL, NULL),
(9, 'Suppository', NULL, NULL, NULL),
(10, 'Suspension', NULL, NULL, NULL),
(11, 'Syrup', NULL, NULL, NULL),
(12, 'Oral Saline', NULL, NULL, NULL),
(13, 'Paediatric Drops', NULL, NULL, NULL),
(14, 'Injection', NULL, NULL, NULL),
(15, 'Oral Solution', NULL, NULL, NULL),
(16, 'Powder', NULL, NULL, NULL),
(17, 'Solution', NULL, NULL, NULL),
(18, 'Spray', NULL, NULL, NULL),
(19, 'Bolus', NULL, NULL, NULL),
(20, 'Eye and Ear Drops', NULL, NULL, NULL),
(21, 'Eye, Ear & Nasal Drops', NULL, NULL, NULL),
(22, 'Eye Ointment', NULL, NULL, NULL),
(23, 'Gargle & Mouth Wash', NULL, NULL, NULL),
(24, 'IM Injection', NULL, NULL, NULL),
(25, 'IV Injection', NULL, NULL, NULL),
(26, 'IV/IM Injection', NULL, NULL, NULL),
(27, 'Hand Rub', NULL, NULL, NULL),
(28, 'IV Infusion', NULL, NULL, NULL),
(29, 'Mouth Wash', NULL, NULL, NULL),
(30, 'Nasal Drops', NULL, NULL, NULL),
(31, 'Nasal Spray', NULL, NULL, NULL),
(32, 'Oral Gel', NULL, NULL, NULL),
(33, 'Pellets', NULL, NULL, NULL),
(34, 'Raw Materials', NULL, NULL, NULL),
(35, 'Scalp Lotion', NULL, NULL, NULL),
(36, 'Topical Solution', NULL, NULL, NULL),
(37, 'Vaginal Tablet', NULL, NULL, NULL),
(38, 'Eye Drops', NULL, NULL, NULL),
(39, 'Nebuliser Solution', NULL, NULL, NULL),
(40, 'Dispersible Tablet', NULL, NULL, NULL),
(41, 'Oral Paste', NULL, NULL, NULL),
(42, 'Inhalation Solution', NULL, NULL, NULL),
(43, 'Aerosol Inhalation', NULL, NULL, NULL),
(44, 'Inhalation Capsule', NULL, NULL, NULL),
(45, 'Ors Tablet', NULL, NULL, NULL),
(46, 'Cr Tablet', NULL, NULL, NULL),
(47, 'Sr Capsule', NULL, NULL, NULL),
(48, 'Inhaler', NULL, NULL, NULL),
(49, 'Chewable Tablet', NULL, NULL, NULL),
(50, 'Cozycap', NULL, NULL, NULL),
(51, 'Oral Powder', NULL, NULL, NULL),
(52, 'Xr Tablet', NULL, NULL, NULL),
(53, 'Er Tablet', NULL, NULL, NULL),
(54, 'Inhalation Aerosol', NULL, NULL, NULL),
(55, 'Orodispersible Tablet', NULL, NULL, NULL),
(56, 'Sr Tablet', NULL, NULL, NULL),
(57, 'Granules For Suspension', NULL, NULL, NULL),
(58, 'Dr Tablet', NULL, NULL, NULL),
(59, 'Oral Drops', NULL, NULL, NULL),
(60, 'Water Soluble Powder', NULL, NULL, NULL),
(61, 'Liquid', NULL, NULL, NULL),
(62, 'Pellets For Suspension', NULL, NULL, NULL),
(63, 'Elixir', NULL, NULL, NULL),
(64, 'Sachet', NULL, NULL, NULL),
(65, 'Linctus', NULL, NULL, NULL),
(66, 'Emulsion', NULL, NULL, NULL),
(67, 'Sached Powder', NULL, NULL, NULL),
(68, 'Ear Drop', NULL, NULL, NULL),
(69, 'Shampoo', NULL, NULL, NULL),
(70, 'Eye & Nasal Drops', NULL, NULL, NULL),
(71, 'Eye Gel', NULL, NULL, NULL),
(72, 'Solution For Injection', NULL, NULL, NULL),
(73, 'Ophthalmic Emulsion', NULL, NULL, NULL),
(74, 'Soft Gelatin Capsule', NULL, NULL, NULL),
(75, 'Solution For Infusion', NULL, NULL, NULL),
(76, 'Irrigation Solution', NULL, NULL, NULL),
(77, 'Rectal Ointment', NULL, NULL, NULL),
(78, 'Vaginal Cream', NULL, NULL, NULL),
(79, 'Emulgel', NULL, NULL, NULL),
(80, 'Resperitory Solution', NULL, NULL, NULL),
(81, 'Oral Emulsion', NULL, NULL, NULL),
(82, 'Respirator Suspension', NULL, NULL, NULL),
(83, 'Oral Soluble Film', NULL, NULL, NULL),
(84, 'Mouth Dissolving Tablet', NULL, NULL, NULL),
(85, 'Rapid Tablet', NULL, NULL, NULL),
(86, 'Powder for Pedriatric Drop', NULL, NULL, NULL),
(87, 'Mouth Wash Antiseptic', NULL, NULL, NULL),
(88, 'Dialysis Solution', NULL, NULL, NULL),
(89, 'Per Rectal', NULL, NULL, NULL),
(90, 'Vaginal Gel', NULL, NULL, NULL),
(91, 'Pr Tablet', NULL, NULL, NULL),
(92, 'Dr Granules For Suspension', NULL, NULL, NULL),
(93, 'Gummy Tablet', NULL, NULL, NULL),
(94, 'Vaccine', NULL, NULL, NULL),
(95, 'Blood bag', NULL, NULL, NULL),
(96, 'Gas', NULL, NULL, NULL),
(97, 'Scrub', NULL, NULL, NULL),
(98, 'Tincture', NULL, NULL, NULL),
(99, 'Pvc Bag', NULL, NULL, NULL),
(100, 'Powder for Solution', NULL, NULL, NULL),
(101, 'Blood Tubing Set', NULL, NULL, NULL),
(102, 'Needle for Syringe', NULL, NULL, NULL),
(103, 'Butterfly', NULL, NULL, NULL),
(104, 'Er Capsule', NULL, NULL, NULL),
(105, 'Powder For Oral Solution', NULL, NULL, NULL),
(106, 'Oral Liquid', NULL, NULL, NULL),
(107, 'Eye Cleanser Solution', NULL, NULL, NULL),
(108, 'Eye and Ear Ointment', NULL, NULL, NULL),
(109, 'Vaginal Pessary', NULL, NULL, NULL),
(110, 'Gum', NULL, NULL, NULL),
(111, 'Oral Dental Gel', NULL, NULL, NULL),
(112, 'Topical Suspension', NULL, NULL, NULL),
(113, 'Cr Capsule', NULL, NULL, NULL),
(114, 'Md Tablet', NULL, NULL, NULL),
(115, 'Inhalation Liquid', NULL, NULL, NULL),
(116, 'Viscoelastic Solution', NULL, NULL, NULL),
(117, 'Drops', NULL, NULL, NULL),
(118, 'Vaginal Suppository', NULL, NULL, NULL),
(119, 'Mups Tablet', NULL, NULL, NULL),
(120, 'Scalp Ointment', NULL, NULL, NULL),
(121, 'Sprinkle Capsule', NULL, NULL, NULL),
(122, 'Effervescent Granules', NULL, NULL, NULL),
(123, 'M R Capsule', NULL, NULL, NULL),
(124, 'Repacking', NULL, NULL, NULL),
(125, 'Consumer products', NULL, NULL, NULL),
(126, 'Granules', NULL, NULL, NULL),
(127, 'Muscle Rub', NULL, NULL, NULL),
(128, 'Face Wash', NULL, NULL, NULL),
(129, 'Soap Bar', NULL, NULL, NULL),
(131, 'Diapant', NULL, NULL, NULL),
(133, 'Nutrition Drink', NULL, NULL, NULL),
(134, 'Feminine Care', NULL, NULL, NULL),
(135, 'Aerosol', NULL, NULL, NULL),
(136, 'Air Freshner', NULL, NULL, NULL),
(137, 'Paper Napkin', NULL, NULL, NULL),
(138, 'Toothpaste', NULL, NULL, NULL),
(139, 'Antiseptic', NULL, NULL, NULL),
(140, 'Tube', NULL, NULL, NULL),
(141, 'Diapers', NULL, NULL, NULL),
(142, 'Feeder', NULL, NULL, NULL),
(143, 'Pump', NULL, NULL, NULL),
(144, 'Silicone Nipple', NULL, NULL, NULL),
(145, 'Bottle', NULL, NULL, NULL),
(146, 'Box', NULL, NULL, NULL),
(147, 'Wet Wipes', NULL, NULL, NULL),
(148, 'Pampers', NULL, NULL, NULL),
(149, 'Cotton Buds', NULL, NULL, NULL),
(150, 'Condom', NULL, NULL, NULL),
(151, 'Olive Oil', NULL, NULL, NULL),
(152, 'Surgical Item', NULL, NULL, NULL),
(153, 'Water Bag', NULL, NULL, NULL),
(154, 'Soap', NULL, NULL, NULL),
(155, 'Body Care', NULL, NULL, NULL),
(156, 'Vaporub', NULL, NULL, NULL),
(157, 'Mouthwash', NULL, NULL, NULL),
(158, 'Pot', NULL, NULL, NULL),
(159, 'Hair-care', NULL, NULL, NULL),
(160, 'Eno', NULL, NULL, NULL),
(161, 'Balm', NULL, NULL, NULL),
(162, 'Others', NULL, NULL, NULL),
(163, 'Skin-Care', NULL, NULL, NULL),
(164, 'Deodorants', NULL, NULL, NULL),
(165, 'Shaving-Needs', NULL, NULL, NULL),
(166, 'Oral-Care', NULL, NULL, NULL),
(167, 'Body-Care', NULL, NULL, NULL),
(168, 'Diaper', NULL, NULL, NULL),
(169, 'Medical Device', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2014_10_12_200000_add_two_factor_columns_to_users_table', 1),
(4, '2019_08_19_000000_create_failed_jobs_table', 1),
(5, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(6, '2020_11_09_090255_create_sessions_table', 1),
(7, '2020_11_11_010323_create_hospitals_table', 1),
(8, '2020_11_12_105055_create_departments_table', 1),
(9, '2020_11_12_105317_create_designations_table', 1),
(10, '2020_11_12_142330_create_doctors_specialities_table', 1),
(11, '2020_11_12_142457_create_stores_table', 1),
(12, '2020_11_12_142520_create_suppliers_table', 1),
(13, '2020_11_12_142656_create_product_categories_table', 1),
(14, '2020_11_12_142740_create_product_brands_table', 1),
(15, '2020_11_13_055756_create_roles_table', 1),
(16, '2020_11_14_063125_create_doctors_table', 1),
(17, '2020_11_14_095220_create_pathologies_table', 1),
(18, '2020_11_15_011756_create_opd_services_table', 1),
(19, '2020_11_15_020754_create_ipd_services_table', 1),
(20, '2020_11_15_072440_create_product_models_table', 2),
(21, '2020_11_15_072453_create_products_table', 2),
(22, '2020_11_15_072524_create_requisition_categories_table', 2),
(23, '2020_11_15_023038_create_opd_service_packages_table', 3),
(24, '2020_11_15_023057_create_ipd_service_packages_table', 3),
(25, '2020_11_17_001434_create_patients_table', 3),
(26, '2020_11_17_160946_create_patient_admissions_table', 4),
(27, '2020_11_18_032026_create_requisitions_table', 4),
(28, '2020_11_18_032044_create_requisition_details_table', 4),
(29, '2020_11_18_100700_create_corporate_clients_table', 4),
(31, '2020_11_18_101001_create_corporate_client_discounts_table', 5),
(32, '2020_11_20_094406_create_payment_histories_table', 6),
(34, '2020_11_20_165054_create_opd_billings_table', 7),
(36, '2020_11_20_165010_create_ipd_billings_table', 8),
(37, '2020_11_23_143744_create_opd_bill_details_table', 9),
(38, '2020_11_29_175726_create_ipd_bill_details_table', 10),
(39, '2020_12_01_155922_create_department_consumptions_table', 11),
(40, '2020_11_27_034337_create_inventories_table', 12),
(41, '2020_12_02_100619_create_medicine_types_table', 13),
(42, '2020_12_02_100642_create_medicine_companies_table', 13),
(43, '2020_12_02_100658_create_medicines_table', 13),
(44, '2020_12_07_163209_create_rooms_table', 14);

-- --------------------------------------------------------

--
-- Table structure for table `opd_billings`
--

CREATE TABLE `opd_billings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `bill_no` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `patient_id` bigint(20) UNSIGNED NOT NULL,
  `doctor_id` bigint(20) UNSIGNED NOT NULL,
  `total_bill_amount` double NOT NULL,
  `total_discount_amount` double NOT NULL,
  `total_paid_amount` double NOT NULL,
  `total_due_amount` double NOT NULL,
  `payment_status` enum('DUE','PAID','PARTIAL') COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment_method` enum('CASH','CARD','BANKTRANSFER','CHEQUE') COLLATE utf8mb4_unicode_ci NOT NULL,
  `remarks` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('COMPLETE','INCOMPLETE','INITIATE') COLLATE utf8mb4_unicode_ci NOT NULL,
  `discount_type` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `discount_value` int(11) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `opd_billings`
--

INSERT INTO `opd_billings` (`id`, `bill_no`, `patient_id`, `doctor_id`, `total_bill_amount`, `total_discount_amount`, `total_paid_amount`, `total_due_amount`, `payment_status`, `payment_method`, `remarks`, `status`, `discount_type`, `discount_value`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`) VALUES
(30, '196508', 1, 1, 1332, 0, 0, 1332, 'DUE', 'CASH', NULL, 'INCOMPLETE', NULL, NULL, NULL, NULL, '2020-12-09 12:46:21', '2020-12-09 13:05:47', NULL),
(31, '255086', 1, 1, 2785, 85, 0, 2785, 'DUE', 'CASH', NULL, 'INCOMPLETE', NULL, NULL, NULL, NULL, '2020-12-12 10:31:23', '2020-12-23 11:18:53', NULL),
(32, '883357', 2, 2, 0, 0, 0, 0, 'DUE', 'CASH', NULL, 'INITIATE', NULL, NULL, NULL, NULL, '2020-12-12 11:52:28', '2020-12-12 11:52:28', NULL),
(33, '690999', 1, 3, 219.6, 24.4, 0, 219.6, 'DUE', 'CASH', NULL, 'INCOMPLETE', 'Percentage', 10, NULL, NULL, '2020-12-23 11:23:59', '2020-12-23 11:26:01', NULL),
(34, '410648', 1, 2, 190, 10, 0, 190, 'DUE', 'CASH', NULL, 'INCOMPLETE', 'Fixed', 10, NULL, NULL, '2020-12-23 11:26:23', '2020-12-23 11:26:30', NULL),
(35, '346650', 1, 2, 390, 10, 0, 390, 'DUE', 'CASH', NULL, 'INCOMPLETE', 'Fixed', 10, NULL, NULL, '2020-12-23 11:49:42', '2020-12-23 11:51:07', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `opd_bill_details`
--

CREATE TABLE `opd_bill_details` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `opd_billing_id` bigint(20) UNSIGNED DEFAULT NULL,
  `item_type` enum('SERVICE','LABTEST','MEDICINE','OTHERS','PACKAGE') COLLATE utf8mb4_unicode_ci NOT NULL,
  `item_id` bigint(20) UNSIGNED NOT NULL,
  `item_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `item_qty` int(11) NOT NULL,
  `unit_tarrif` double NOT NULL,
  `total_tarrif` double NOT NULL,
  `discount` double DEFAULT NULL,
  `remarks` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('ACTIVE','INACTIVE','INITIATE') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ACTIVE',
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `opd_bill_details`
--

INSERT INTO `opd_bill_details` (`id`, `opd_billing_id`, `item_type`, `item_id`, `item_name`, `item_qty`, `unit_tarrif`, `total_tarrif`, `discount`, `remarks`, `status`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`) VALUES
(45, 30, 'SERVICE', 1, 'Opd Service', 3, 44, 132, 0, NULL, 'ACTIVE', NULL, NULL, '2020-12-09 12:46:21', '2020-12-09 13:05:47', NULL),
(46, 30, 'SERVICE', 2, 'Test 1', 6, 200, 1200, 0, NULL, 'ACTIVE', NULL, NULL, '2020-12-09 12:46:49', '2020-12-09 13:05:13', NULL),
(47, 31, 'SERVICE', 1, 'Opd Service', 8, 44, 352, 0, NULL, 'ACTIVE', NULL, NULL, '2020-12-12 10:31:23', '2020-12-18 09:42:58', NULL),
(48, 32, 'SERVICE', 3, 'Test 2', 1, 200, 200, 0, NULL, 'ACTIVE', NULL, NULL, '2020-12-12 11:52:28', '2020-12-12 11:52:28', NULL),
(49, 31, 'SERVICE', 2, 'Test 1', 12, 200, 2400, 0, NULL, 'ACTIVE', NULL, NULL, '2020-12-18 08:21:29', '2020-12-18 09:44:10', NULL),
(50, 31, 'LABTEST', 1, 'Pat', 1, 33, 33, 0, NULL, 'ACTIVE', NULL, NULL, '2020-12-18 09:53:26', '2020-12-18 09:53:26', NULL),
(51, 33, 'SERVICE', 1, 'Opd Service', 1, 44, 44, 0, NULL, 'ACTIVE', NULL, NULL, '2020-12-23 11:23:59', '2020-12-23 11:23:59', NULL),
(52, 33, 'SERVICE', 2, 'Test 1', 1, 200, 200, 0, NULL, 'ACTIVE', NULL, NULL, '2020-12-23 11:24:03', '2020-12-23 11:24:03', NULL),
(53, 34, 'SERVICE', 2, 'Test 1', 1, 200, 200, 0, NULL, 'ACTIVE', NULL, NULL, '2020-12-23 11:26:23', '2020-12-23 11:26:23', NULL),
(54, 35, 'SERVICE', 3, 'Test 2', 1, 200, 200, 0, NULL, 'ACTIVE', NULL, NULL, '2020-12-23 11:49:42', '2020-12-23 11:49:42', NULL),
(55, 35, 'SERVICE', 2, 'Test 1', 1, 200, 200, 0, NULL, 'ACTIVE', NULL, NULL, '2020-12-23 11:49:46', '2020-12-23 11:49:46', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `opd_services`
--

CREATE TABLE `opd_services` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tariff` decimal(12,2) DEFAULT NULL,
  `status` enum('ACTIVE','INACTIVE') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ACTIVE',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `hospital_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `opd_services`
--

INSERT INTO `opd_services` (`id`, `code`, `name`, `description`, `tariff`, `status`, `created_at`, `updated_at`, `deleted_at`, `hospital_id`) VALUES
(1, '739911', 'Opd Service', NULL, '44.00', 'ACTIVE', '2020-11-18 21:05:57', '2020-11-18 21:05:57', NULL, NULL),
(2, '555666', 'Test 1', 'Test 1', '200.00', 'ACTIVE', '2020-11-25 14:30:16', '2020-11-25 14:30:16', NULL, 3),
(3, '666222', 'Test 2', 'Test 1', '200.00', 'ACTIVE', '2020-11-25 14:30:16', '2020-11-25 14:30:16', NULL, 3);

-- --------------------------------------------------------

--
-- Table structure for table `opd_service_packages`
--

CREATE TABLE `opd_service_packages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `hospital_id` bigint(20) UNSIGNED DEFAULT NULL,
  `code` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `services` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`services`)),
  `tariff` decimal(12,2) DEFAULT NULL,
  `status` enum('ACTIVE','INACTIVE') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ACTIVE',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `opd_service_packages`
--

INSERT INTO `opd_service_packages` (`id`, `hospital_id`, `code`, `name`, `services`, `tariff`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, NULL, '142092', 'Opd service package', '[1]', '6.00', 'ACTIVE', '2020-11-18 21:06:30', '2020-11-18 21:06:30', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pathologies`
--

CREATE TABLE `pathologies` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sample_type` enum('BLOOD','URINE','STOOL','OTHER') COLLATE utf8mb4_unicode_ci NOT NULL,
  `tariff` double(100,2) NOT NULL,
  `status` enum('ACTIVE','INACTIVE') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ACTIVE',
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `hospital_id` bigint(20) UNSIGNED NOT NULL,
  `department_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pathologies`
--

INSERT INTO `pathologies` (`id`, `code`, `name`, `description`, `sample_type`, `tariff`, `status`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`, `hospital_id`, `department_id`) VALUES
(1, '450240', 'Pat', 'Dept', 'BLOOD', 33.00, 'ACTIVE', NULL, NULL, '2020-11-15 10:29:54', '2020-11-15 10:29:54', NULL, 1, 1),
(2, '640153', 'eee', NULL, 'BLOOD', 1.00, 'ACTIVE', NULL, NULL, '2020-11-15 10:32:19', '2020-11-15 10:32:19', NULL, 1, 1),
(3, '127691', 'dd', NULL, 'BLOOD', 1.00, 'ACTIVE', NULL, NULL, '2020-11-15 10:39:18', '2020-11-15 10:39:18', NULL, 1, 1),
(4, '665741', 'aa', NULL, 'BLOOD', 111.00, 'ACTIVE', NULL, NULL, '2020-11-15 10:40:15', '2020-11-15 10:40:15', NULL, 1, 1),
(5, '557642', 'aaa', NULL, 'BLOOD', 1.00, 'ACTIVE', NULL, NULL, '2020-11-15 10:41:33', '2020-11-15 10:41:33', NULL, 1, 1),
(6, '466271', 'aaa', NULL, 'BLOOD', 3.00, 'ACTIVE', NULL, NULL, '2020-11-15 10:43:59', '2020-11-15 10:43:59', NULL, 1, 1),
(7, '222042', 'AEE', NULL, 'BLOOD', 44.00, 'ACTIVE', NULL, NULL, '2020-11-15 10:45:09', '2020-11-15 10:45:09', NULL, 1, 1),
(8, '322720', 'aaa', '4', 'BLOOD', 44.00, 'ACTIVE', NULL, NULL, '2020-11-15 10:51:04', '2020-11-15 10:51:04', NULL, 1, 1),
(9, '344340', 'aa', NULL, 'BLOOD', 22.00, 'ACTIVE', NULL, NULL, '2020-11-15 10:56:13', '2020-11-15 10:56:13', NULL, 1, 1),
(10, '876139', 'Try', 'ddd', 'BLOOD', 3.00, 'ACTIVE', NULL, NULL, '2020-11-15 11:00:50', '2020-11-15 11:00:50', NULL, 1, 1),
(11, '276181', 'wer', NULL, 'BLOOD', 22.00, 'ACTIVE', NULL, NULL, '2020-11-15 11:29:32', '2020-11-15 11:29:32', NULL, 1, 1),
(12, '717029', 'Ra', '33', 'BLOOD', 2.00, 'ACTIVE', NULL, NULL, '2020-11-15 11:52:33', '2020-11-15 11:52:33', NULL, 1, 1),
(13, '586359', 'Rat', NULL, 'BLOOD', 22.00, 'ACTIVE', NULL, NULL, '2020-11-16 02:10:33', '2020-11-16 02:10:33', NULL, 1, 1),
(14, '493210', 'ee', NULL, 'BLOOD', 4.00, 'ACTIVE', NULL, NULL, '2020-11-16 03:38:06', '2020-11-16 03:38:06', NULL, 1, 3),
(15, '994616', 'ttt', NULL, 'BLOOD', 3.00, 'ACTIVE', NULL, NULL, '2020-11-16 03:39:46', '2020-11-16 03:39:46', NULL, 1, 2),
(16, '993171', 'a', NULL, 'BLOOD', 4.00, 'ACTIVE', NULL, NULL, '2020-11-16 03:40:38', '2020-11-16 03:40:38', NULL, 1, 2),
(17, '289003', 'sdf', NULL, 'BLOOD', 4.00, 'ACTIVE', NULL, NULL, '2020-11-16 03:49:29', '2020-11-16 03:49:29', NULL, 2, 3),
(18, '197773', 'dsf', NULL, 'BLOOD', 33.00, 'ACTIVE', NULL, NULL, '2020-11-17 03:15:49', '2020-11-17 03:15:49', NULL, 1, 4);

-- --------------------------------------------------------

--
-- Table structure for table `patients`
--

CREATE TABLE `patients` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `hospital_id` bigint(20) UNSIGNED DEFAULT NULL,
  `doctor_id` bigint(20) UNSIGNED DEFAULT NULL,
  `uhid` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `father_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mother_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mobile` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gender` enum('MALE','FEMALE','OTHER') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'MALE',
  `age` int(11) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `blood_group` enum('A+','A-','B+','B-','O+','O-','AB+','AB-') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `occupation` enum('Business','Service','Doctor','Engineer','Agriculture','Housewife','Student','Teacher','Others') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `photo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_person_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_person_mobile` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `contact_person_relation` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_person_address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `corporate_client_id` int(11) DEFAULT NULL,
  `employee_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('ACTIVE','INACTIVE') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ACTIVE',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `patients`
--

INSERT INTO `patients` (`id`, `hospital_id`, `doctor_id`, `uhid`, `code`, `name`, `father_name`, `mother_name`, `mobile`, `email`, `address`, `gender`, `age`, `dob`, `blood_group`, `nid`, `occupation`, `photo`, `contact_person_name`, `contact_person_mobile`, `contact_person_relation`, `contact_person_address`, `corporate_client_id`, `employee_id`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, NULL, NULL, '154509', '263579', 'Ratib', NULL, NULL, NULL, NULL, NULL, 'FEMALE', NULL, NULL, 'O+', NULL, 'Doctor', NULL, 'aaa', '333333', NULL, NULL, NULL, NULL, 'ACTIVE', '2020-11-20 04:04:28', '2020-11-20 04:04:28', NULL),
(2, NULL, NULL, '620649', '862668', 'Habib', NULL, NULL, '01757236912', NULL, NULL, 'MALE', 25, '2017-12-09', 'A+', NULL, 'Business', NULL, 'Contact Person', '01757236912', NULL, NULL, 1, NULL, 'ACTIVE', '2020-11-28 04:22:31', '2020-11-28 04:22:31', NULL),
(3, NULL, NULL, '830321', '95412845', 'ee', NULL, NULL, '43534', NULL, 'add', 'MALE', 3, '2017-12-07', 'A+', NULL, 'Business', NULL, 'sf', '24234', 'ab', NULL, 1, 'aaa', 'ACTIVE', '2020-12-07 09:00:05', '2020-12-07 09:00:05', NULL),
(4, NULL, NULL, '559472', '83874366', 'aa bb', NULL, 'aa bb', '242342', NULL, 'address', 'MALE', 0, '2020-12-07', 'A+', NULL, 'Business', NULL, 'aaa', '223', 'abc', 'sssd', NULL, NULL, 'ACTIVE', '2020-12-07 09:48:12', '2020-12-07 09:49:54', NULL),
(5, NULL, NULL, '406565', '34073465', 'sfs', 'sdfsd', 'sdfsd', '2423423', NULL, 'sdfsdf', 'MALE', 0, '2020-12-08', 'A+', NULL, 'Business', '', 'sdfsdf', '23423423', 'sdfsdf', NULL, NULL, NULL, 'ACTIVE', '2020-12-08 11:17:51', '2020-12-08 11:17:51', NULL),
(6, NULL, NULL, '255189', '40896433', 'Raton', 'Bokul', 'Khoursheda', '01757236912', NULL, 'Dhamoirhat, Naogaon', 'MALE', 0, '2020-12-09', 'A+', NULL, 'Business', '', 'Rubel', '55555555555555', 'Brother', NULL, NULL, NULL, 'ACTIVE', '2020-12-09 09:02:01', '2020-12-09 09:02:01', NULL),
(7, NULL, NULL, '600597', '67650931', 'aa', 's', 'a', '224234', NULL, 'adf', 'MALE', 0, '2020-12-23', 'A+', NULL, 'Business', '', 'aa', '222', 'aaa', NULL, NULL, NULL, 'ACTIVE', '2020-12-23 09:57:33', '2020-12-23 09:57:33', NULL),
(8, NULL, NULL, '452449', '49641562', 'sdf', 'sdf', 'sdf', '32323', NULL, 'as', 'MALE', NULL, NULL, 'A+', NULL, 'Business', '', 'ab', '232323', 'br', NULL, NULL, NULL, 'ACTIVE', '2020-12-23 10:01:04', '2020-12-23 10:01:04', NULL),
(9, NULL, NULL, '666910', '57879686', 'as', 'as', 'as', '4333', NULL, 'ss', 'MALE', 10, '2010-12-23', 'A+', NULL, 'Business', '', 'srr', 'dtt', 'sf', NULL, NULL, NULL, 'ACTIVE', '2020-12-23 10:07:01', '2020-12-23 10:07:01', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `patient_admissions`
--

CREATE TABLE `patient_admissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `patient_id` bigint(20) UNSIGNED DEFAULT NULL,
  `hospital_id` bigint(20) UNSIGNED DEFAULT NULL,
  `doctor_id` bigint(20) UNSIGNED DEFAULT NULL,
  `bill_no` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `floor` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `room` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `admission_date` date DEFAULT NULL,
  `release_date` date DEFAULT NULL,
  `status` enum('Admission','Release') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Admission',
  `referred_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `under_package` enum('Yes','No') COLLATE utf8mb4_unicode_ci DEFAULT 'No',
  `package_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `patient_admissions`
--

INSERT INTO `patient_admissions` (`id`, `patient_id`, `hospital_id`, `doctor_id`, `bill_no`, `floor`, `room`, `description`, `admission_date`, `release_date`, `status`, `referred_by`, `under_package`, `package_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 2, 3, 1, '33333', '333', '3', '33', NULL, NULL, 'Admission', NULL, 'No', NULL, '2020-11-20 04:04:53', '2020-11-20 04:04:53', NULL),
(2, 1, 4, 5, NULL, NULL, '02', 'aaddr', '2020-12-06', '2020-12-08', 'Admission', 'aaa', 'Yes', 1, '2020-12-07 11:34:00', '2020-12-07 11:36:30', NULL),
(3, 1, 1, 2, NULL, NULL, '02', 'sdfsdf', '2020-12-07', NULL, 'Admission', 'sdfsd', 'Yes', 1, '2020-12-08 10:20:56', '2020-12-08 10:20:56', NULL),
(4, 1, 1, 2, NULL, NULL, '02', 'sdfsdf', '2020-12-07', NULL, 'Admission', 'sdfsd', 'Yes', 1, '2020-12-08 10:21:16', '2020-12-08 10:21:16', NULL),
(5, 1, 4, 2, NULL, NULL, '02', 'sdfsdf', '2020-12-07', NULL, 'Admission', 'sdfsd', 'Yes', 1, '2020-12-08 10:33:55', '2020-12-08 10:33:55', NULL),
(6, 2, 4, 3, '2222222', '33', '01', 'ad', '2020-12-06', '2020-12-10', 'Admission', 'dfd', 'Yes', 1, '2020-12-08 10:41:33', '2020-12-08 10:42:46', NULL),
(7, 2, 1, 2, '533233', NULL, '01', 'dfds', '2020-12-08', NULL, 'Admission', 'aaa', 'No', NULL, '2020-12-09 08:52:43', '2020-12-09 08:52:43', NULL),
(8, 2, 1, 3, '734994', NULL, '01', 'aaa', '2020-12-08', NULL, 'Admission', 'sdfs', 'Yes', 1, '2020-12-09 08:53:08', '2020-12-09 08:53:08', NULL),
(9, 6, 1, 4, '280866', NULL, '01', 'Some problem', '2020-12-08', NULL, 'Admission', 'Some name', 'Yes', 1, '2020-12-09 09:03:40', '2020-12-09 09:03:40', NULL),
(10, 6, 1, 9, '168384', NULL, '02', '66', '2020-12-11', NULL, 'Admission', '33', 'No', NULL, '2020-12-13 10:14:41', '2020-12-13 10:15:27', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `payment_histories`
--

CREATE TABLE `payment_histories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `billing_type` enum('OPD','IPD') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'OPD',
  `billing_id` int(11) NOT NULL,
  `payment_amount` double NOT NULL,
  `payment_method` enum('CASH','CARD','MBANKING') COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment_date` date DEFAULT NULL,
  `remarks` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('FULL','PARTIAL') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `barcode_no` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `generic_name` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `measurement_unit` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `photo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('ACTIVE','INACTIVE') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ACTIVE',
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `product_category_id` bigint(20) UNSIGNED NOT NULL,
  `product_brand_id` bigint(20) UNSIGNED NOT NULL,
  `product_model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `code`, `barcode_no`, `name`, `description`, `generic_name`, `measurement_unit`, `photo`, `status`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`, `product_category_id`, `product_brand_id`, `product_model_id`) VALUES
(1, '779831', 'BBGD', 'Napa', 'okm', 'paracitmol', 'pcs', NULL, 'ACTIVE', NULL, NULL, '2020-11-16 04:59:57', '2020-11-16 04:59:57', NULL, 1, 2, 2);

-- --------------------------------------------------------

--
-- Table structure for table `product_brands`
--

CREATE TABLE `product_brands` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('ACTIVE','INACTIVE') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ACTIVE',
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `product_category_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_brands`
--

INSERT INTO `product_brands` (`id`, `name`, `description`, `status`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`, `product_category_id`) VALUES
(1, 'Br', 'aa', 'ACTIVE', NULL, NULL, '2020-11-15 05:36:01', '2020-11-15 05:36:01', NULL, 1),
(2, 'sdf', NULL, 'ACTIVE', NULL, NULL, '2020-11-16 04:25:51', '2020-11-16 04:25:51', NULL, 1),
(3, 'EE', 'aa', 'ACTIVE', NULL, NULL, '2020-11-16 04:34:37', '2020-11-16 04:34:37', NULL, 1),
(4, 'adf', NULL, 'ACTIVE', NULL, NULL, '2020-11-17 03:16:39', '2020-11-17 03:16:39', NULL, 2);

-- --------------------------------------------------------

--
-- Table structure for table `product_categories`
--

CREATE TABLE `product_categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('ACTIVE','INACTIVE') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ACTIVE',
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_categories`
--

INSERT INTO `product_categories` (`id`, `name`, `description`, `status`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Duy', 'ab', 'ACTIVE', NULL, NULL, '2020-11-15 05:35:45', '2020-11-15 05:35:45', NULL),
(2, 'aaa', NULL, 'ACTIVE', NULL, NULL, '2020-11-16 04:25:36', '2020-11-16 04:25:36', NULL),
(3, 'aa', NULL, 'ACTIVE', NULL, NULL, '2020-11-17 03:16:24', '2020-11-17 03:16:24', NULL),
(4, 'raton', NULL, 'ACTIVE', NULL, NULL, '2020-11-30 10:05:01', '2020-11-30 10:05:01', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `product_models`
--

CREATE TABLE `product_models` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('ACTIVE','INACTIVE') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ACTIVE',
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `product_category_id` bigint(20) UNSIGNED NOT NULL,
  `product_brand_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_models`
--

INSERT INTO `product_models` (`id`, `name`, `description`, `status`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`, `product_category_id`, `product_brand_id`) VALUES
(1, 'EEE', NULL, 'ACTIVE', NULL, NULL, '2020-11-15 05:36:17', '2020-11-15 05:36:17', NULL, 1, 1),
(2, 'eee', NULL, 'ACTIVE', NULL, NULL, '2020-11-16 04:26:09', '2020-11-16 04:26:09', NULL, 1, 1),
(3, 'eee', NULL, 'ACTIVE', NULL, NULL, '2020-11-16 04:26:20', '2020-11-16 04:26:20', NULL, 1, 2),
(4, 'E', NULL, 'ACTIVE', NULL, NULL, '2020-11-16 04:34:25', '2020-11-16 04:34:25', NULL, 2, 1),
(5, 'ee', NULL, 'ACTIVE', NULL, NULL, '2020-11-17 03:16:51', '2020-11-17 03:16:51', NULL, 1, 3);

-- --------------------------------------------------------

--
-- Table structure for table `requisitions`
--

CREATE TABLE `requisitions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `requisition_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hospital_id` bigint(20) UNSIGNED DEFAULT NULL,
  `department_id` bigint(20) UNSIGNED DEFAULT NULL,
  `requisition_category_id` bigint(20) UNSIGNED DEFAULT NULL,
  `expected_date` date DEFAULT NULL,
  `receive_date` timestamp NULL DEFAULT NULL,
  `total_value` decimal(12,2) DEFAULT NULL,
  `attached_hard_copy` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('INITIATING','INITIATED','APPROVED','ACCEPTED','REJECTED','PROCESSING','DELIVERED','RECEIVED','ARCHIVED') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'INITIATING',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `type` int(11) DEFAULT NULL COMMENT '1=S2H, 2=D2S'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `requisitions`
--

INSERT INTO `requisitions` (`id`, `requisition_no`, `hospital_id`, `department_id`, `requisition_category_id`, `expected_date`, `receive_date`, `total_value`, `attached_hard_copy`, `status`, `created_at`, `updated_at`, `deleted_at`, `type`) VALUES
(1, NULL, 1, 1, 1, NULL, NULL, NULL, NULL, 'INITIATED', '2020-11-18 05:30:43', '2020-11-26 09:43:01', '2020-11-26 09:43:01', NULL),
(2, NULL, 1, 1, 1, NULL, NULL, NULL, NULL, 'INITIATING', '2020-11-23 12:02:34', '2020-11-26 09:42:56', '2020-11-26 09:42:56', NULL),
(3, NULL, 1, 1, 1, NULL, NULL, NULL, NULL, 'INITIATED', '2020-11-26 09:44:39', '2020-11-26 09:45:04', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `requisition_categories`
--

CREATE TABLE `requisition_categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('ACTIVE','INACTIVE') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ACTIVE',
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `requisition_categories`
--

INSERT INTO `requisition_categories` (`id`, `name`, `status`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Emergency', 'ACTIVE', NULL, NULL, '2020-11-16 05:05:06', '2020-11-16 05:05:06', NULL),
(2, 'aa', 'ACTIVE', NULL, NULL, '2020-11-17 03:17:01', '2020-11-17 03:17:01', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `requisition_details`
--

CREATE TABLE `requisition_details` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `requisition_id` bigint(20) UNSIGNED DEFAULT NULL,
  `product_id` bigint(20) UNSIGNED DEFAULT NULL,
  `supplier_id` bigint(20) UNSIGNED DEFAULT NULL,
  `expected_quantity` int(11) DEFAULT NULL,
  `received_quantity` int(11) DEFAULT NULL,
  `return_quantity` int(11) DEFAULT NULL,
  `damaged_quantity` int(11) DEFAULT NULL,
  `purchase_price` decimal(12,2) DEFAULT NULL,
  `status` enum('UNAVAILABLE','AVAILABLE') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'AVAILABLE',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `requisition_details`
--

INSERT INTO `requisition_details` (`id`, `requisition_id`, `product_id`, `supplier_id`, `expected_quantity`, `received_quantity`, `return_quantity`, `damaged_quantity`, `purchase_price`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 1, NULL, 340, NULL, NULL, NULL, NULL, 'AVAILABLE', '2020-11-22 07:46:26', '2020-11-23 11:56:19', NULL),
(2, 3, 1, NULL, 143, NULL, NULL, NULL, NULL, 'AVAILABLE', '2020-11-26 09:44:46', '2020-11-26 09:44:58', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('ACTIVE','INACTIVE') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ACTIVE',
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `status`, `description`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Test', 'ACTIVE', NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `rooms`
--

CREATE TABLE `rooms` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `room_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `rooms`
--

INSERT INTO `rooms` (`id`, `name`, `room_number`, `created_at`, `updated_at`) VALUES
(1, NULL, '01', NULL, NULL),
(2, NULL, '02', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payload` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('gChDJotQVp2878JM74pmYx6oFsaiFnFH5SjnUJCN', 1, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.198 Safari/537.36', 'YTo2OntzOjY6Il90b2tlbiI7czo0MDoiSzY0TkxVQm9rTnh2WEdiZzZIR014cWlwVk5XOTJBdEhoaHhjeDM3NSI7czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTtzOjE3OiJwYXNzd29yZF9oYXNoX3dlYiI7czo2MDoiJDJ5JDEwJDZqR1Zsbjl6Y2thTzBmbjN5aUNCTmVheHpCcWo3OURkd1JjMHY0cDMzNk5mbjJxejBnODdlIjtzOjk6Il9wcmV2aW91cyI7YToxOntzOjM6InVybCI7czozMzoiaHR0cDovLzEyNy4wLjAuMTo4MDAwL29wZEJpbGxpbmdzIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czoyMToicGFzc3dvcmRfaGFzaF9zYW5jdHVtIjtzOjYwOiIkMnkkMTAkNmpHVmxuOXpja2FPMGZuM3lpQ0JOZWF4ekJxajc5RGR3UmMwdjRwMzM2TmZuMnF6MGc4N2UiO30=', 1608745876),
('PShngnTuAPrFPp6BVYpdKPxb3V4KSIIBsDGQW9co', 1, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.198 Safari/537.36', 'YTo2OntzOjY6Il90b2tlbiI7czo0MDoiaHExTUhiRVlFWGRNY2s5MXRLRVBuVzFQQzhVSzduQmtyWVlyRGRYNyI7czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTtzOjE3OiJwYXNzd29yZF9oYXNoX3dlYiI7czo2MDoiJDJ5JDEwJDZqR1Zsbjl6Y2thTzBmbjN5aUNCTmVheHpCcWo3OURkd1JjMHY0cDMzNk5mbjJxejBnODdlIjtzOjk6Il9wcmV2aW91cyI7YToxOntzOjM6InVybCI7czozMToiaHR0cDovLzEyNy4wLjAuMTo4MDAwL2Rhc2hib2FyZCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6MjE6InBhc3N3b3JkX2hhc2hfc2FuY3R1bSI7czo2MDoiJDJ5JDEwJDZqR1Zsbjl6Y2thTzBmbjN5aUNCTmVheHpCcWo3OURkd1JjMHY0cDMzNk5mbjJxejBnODdlIjt9', 1608968412);

-- --------------------------------------------------------

--
-- Table structure for table `stores`
--

CREATE TABLE `stores` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('ACTIVE','INACTIVE') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ACTIVE',
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `hospital_id` bigint(20) UNSIGNED NOT NULL,
  `department_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `stores`
--

INSERT INTO `stores` (`id`, `code`, `name`, `description`, `status`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`, `hospital_id`, `department_id`) VALUES
(1, '476790', 'Rat', NULL, 'ACTIVE', NULL, NULL, '2020-11-16 04:25:19', '2020-11-16 04:25:19', NULL, 2, 2),
(2, '887903', 'REE', NULL, 'ACTIVE', NULL, NULL, '2020-11-16 04:29:08', '2020-11-16 04:29:08', NULL, 2, 2),
(3, '447460', 'eer', 'aa', 'ACTIVE', NULL, NULL, '2020-11-17 03:16:15', '2020-11-17 03:16:15', NULL, 2, 3);

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_person_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_person_mobile` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('ACTIVE','INACTIVE') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ACTIVE',
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`id`, `code`, `name`, `address`, `contact_person_name`, `contact_person_mobile`, `status`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, '194369', 'AAA', NULL, 'Rat', '017', 'ACTIVE', NULL, NULL, '2020-11-16 04:13:11', '2020-11-16 04:13:11', NULL),
(2, '207184', 'AG', NULL, 'eee', '333', 'ACTIVE', NULL, NULL, '2020-11-16 04:24:48', '2020-11-16 04:24:48', NULL),
(3, '939104', 'eew', NULL, 'aa', '425234', 'ACTIVE', NULL, NULL, '2020-11-17 03:16:00', '2020-11-17 03:16:00', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `two_factor_secret` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `two_factor_recovery_codes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `profile_photo_path` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('ACTIVE','INACTIVE') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ACTIVE',
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `two_factor_secret`, `two_factor_recovery_codes`, `remember_token`, `profile_photo_path`, `status`, `created_by`, `updated_by`, `created_at`, `updated_at`, `deleted_at`, `role_id`) VALUES
(1, 'Raton', 'ratoncse24@gmail.com', NULL, '$2y$10$6jGVln9zckaO0fn3yiCBNeaxzBqj79DdwRc0v4p336Nfn2qz0g87e', NULL, NULL, '1KCRC3UShk1e6sD6N2QUtAeuBPxvFPi43ZUfjO2xCScGNB8dQjmabCFCrFrN', NULL, 'ACTIVE', NULL, NULL, '2020-11-15 01:08:49', '2020-11-15 01:08:49', NULL, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `corporate_clients`
--
ALTER TABLE `corporate_clients`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `corporate_client_discounts`
--
ALTER TABLE `corporate_client_discounts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `corporate_client_discounts_corporate_client_id_index` (`corporate_client_id`),
  ADD KEY `corporate_client_discounts_hospital_id_index` (`hospital_id`);

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `departments_hospital_id_index` (`hospital_id`);

--
-- Indexes for table `department_consumptions`
--
ALTER TABLE `department_consumptions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `department_consumptions_department_id_foreign` (`department_id`),
  ADD KEY `department_consumptions_hospital_id_index` (`hospital_id`),
  ADD KEY `department_consumptions_product_id_index` (`product_id`);

--
-- Indexes for table `designations`
--
ALTER TABLE `designations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `designations_department_id_foreign` (`department_id`),
  ADD KEY `designations_hospital_id_index` (`hospital_id`);

--
-- Indexes for table `doctors`
--
ALTER TABLE `doctors`
  ADD PRIMARY KEY (`id`),
  ADD KEY `doctors_department_id_foreign` (`department_id`),
  ADD KEY `doctors_doctors_specialities_id_foreign` (`doctors_specialities_id`),
  ADD KEY `doctors_designation_id_foreign` (`designation_id`),
  ADD KEY `doctors_hospital_id_index` (`hospital_id`);

--
-- Indexes for table `doctors_specialities`
--
ALTER TABLE `doctors_specialities`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `hospitals`
--
ALTER TABLE `hospitals`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `inventories`
--
ALTER TABLE `inventories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `inventories_hospital_id_index` (`hospital_id`),
  ADD KEY `inventories_department_id_index` (`department_id`),
  ADD KEY `inventories_product_id_index` (`product_id`);

--
-- Indexes for table `ipd_billings`
--
ALTER TABLE `ipd_billings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ipd_billings_patient_admission_id_index` (`patient_admission_id`);

--
-- Indexes for table `ipd_bill_details`
--
ALTER TABLE `ipd_bill_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ipd_bill_details_ipd_billing_id_index` (`ipd_billing_id`),
  ADD KEY `ipd_bill_details_item_id_index` (`item_id`);

--
-- Indexes for table `ipd_services`
--
ALTER TABLE `ipd_services`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ipd_services_hospital_id_index` (`hospital_id`);

--
-- Indexes for table `ipd_service_packages`
--
ALTER TABLE `ipd_service_packages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ipd_service_packages_hospital_id_index` (`hospital_id`);

--
-- Indexes for table `medicines`
--
ALTER TABLE `medicines`
  ADD PRIMARY KEY (`id`),
  ADD KEY `medicines_company_id_index` (`company_id`),
  ADD KEY `medicines_medicine_type_id_index` (`medicine_type_id`);

--
-- Indexes for table `medicine_companies`
--
ALTER TABLE `medicine_companies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `medicine_types`
--
ALTER TABLE `medicine_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `opd_billings`
--
ALTER TABLE `opd_billings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `opd_billings_patient_id_index` (`patient_id`),
  ADD KEY `opd_billings_doctor_id_index` (`doctor_id`);

--
-- Indexes for table `opd_bill_details`
--
ALTER TABLE `opd_bill_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `opd_bill_details_opd_billing_id_index` (`opd_billing_id`),
  ADD KEY `opd_bill_details_item_id_index` (`item_id`);

--
-- Indexes for table `opd_services`
--
ALTER TABLE `opd_services`
  ADD PRIMARY KEY (`id`),
  ADD KEY `opd_services_hospital_id_index` (`hospital_id`);

--
-- Indexes for table `opd_service_packages`
--
ALTER TABLE `opd_service_packages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `opd_service_packages_hospital_id_index` (`hospital_id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `pathologies`
--
ALTER TABLE `pathologies`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pathologies_department_id_foreign` (`department_id`),
  ADD KEY `pathologies_hospital_id_index` (`hospital_id`);

--
-- Indexes for table `patients`
--
ALTER TABLE `patients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `patients_hospital_id_index` (`hospital_id`),
  ADD KEY `patients_doctor_id_index` (`doctor_id`);

--
-- Indexes for table `patient_admissions`
--
ALTER TABLE `patient_admissions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `patient_admissions_patient_id_index` (`patient_id`),
  ADD KEY `patient_admissions_hospital_id_index` (`hospital_id`),
  ADD KEY `patient_admissions_doctor_id_index` (`doctor_id`);

--
-- Indexes for table `payment_histories`
--
ALTER TABLE `payment_histories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `products_product_category_id_index` (`product_category_id`),
  ADD KEY `products_product_brand_id_index` (`product_brand_id`),
  ADD KEY `products_product_model_id_index` (`product_model_id`);

--
-- Indexes for table `product_brands`
--
ALTER TABLE `product_brands`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_brands_product_category_id_index` (`product_category_id`);

--
-- Indexes for table `product_categories`
--
ALTER TABLE `product_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_models`
--
ALTER TABLE `product_models`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_models_product_category_id_index` (`product_category_id`),
  ADD KEY `product_models_product_brand_id_index` (`product_brand_id`);

--
-- Indexes for table `requisitions`
--
ALTER TABLE `requisitions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `requisitions_hospital_id_index` (`hospital_id`),
  ADD KEY `requisitions_department_id_index` (`department_id`),
  ADD KEY `requisitions_requisition_category_id_index` (`requisition_category_id`);

--
-- Indexes for table `requisition_categories`
--
ALTER TABLE `requisition_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `requisition_details`
--
ALTER TABLE `requisition_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `requisition_details_requisition_id_index` (`requisition_id`),
  ADD KEY `requisition_details_product_id_index` (`product_id`),
  ADD KEY `requisition_details_supplier_id_index` (`supplier_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rooms`
--
ALTER TABLE `rooms`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `stores`
--
ALTER TABLE `stores`
  ADD PRIMARY KEY (`id`),
  ADD KEY `stores_department_id_foreign` (`department_id`),
  ADD KEY `stores_hospital_id_index` (`hospital_id`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `corporate_clients`
--
ALTER TABLE `corporate_clients`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `corporate_client_discounts`
--
ALTER TABLE `corporate_client_discounts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `department_consumptions`
--
ALTER TABLE `department_consumptions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `designations`
--
ALTER TABLE `designations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `doctors`
--
ALTER TABLE `doctors`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `doctors_specialities`
--
ALTER TABLE `doctors_specialities`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hospitals`
--
ALTER TABLE `hospitals`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `inventories`
--
ALTER TABLE `inventories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `ipd_billings`
--
ALTER TABLE `ipd_billings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `ipd_bill_details`
--
ALTER TABLE `ipd_bill_details`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `ipd_services`
--
ALTER TABLE `ipd_services`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `ipd_service_packages`
--
ALTER TABLE `ipd_service_packages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `medicines`
--
ALTER TABLE `medicines`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12949;

--
-- AUTO_INCREMENT for table `medicine_companies`
--
ALTER TABLE `medicine_companies`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=317;

--
-- AUTO_INCREMENT for table `medicine_types`
--
ALTER TABLE `medicine_types`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=170;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `opd_billings`
--
ALTER TABLE `opd_billings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `opd_bill_details`
--
ALTER TABLE `opd_bill_details`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT for table `opd_services`
--
ALTER TABLE `opd_services`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `opd_service_packages`
--
ALTER TABLE `opd_service_packages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `pathologies`
--
ALTER TABLE `pathologies`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `patients`
--
ALTER TABLE `patients`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `patient_admissions`
--
ALTER TABLE `patient_admissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `payment_histories`
--
ALTER TABLE `payment_histories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `product_brands`
--
ALTER TABLE `product_brands`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `product_categories`
--
ALTER TABLE `product_categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `product_models`
--
ALTER TABLE `product_models`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `requisitions`
--
ALTER TABLE `requisitions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `requisition_categories`
--
ALTER TABLE `requisition_categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `requisition_details`
--
ALTER TABLE `requisition_details`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `rooms`
--
ALTER TABLE `rooms`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `stores`
--
ALTER TABLE `stores`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `corporate_client_discounts`
--
ALTER TABLE `corporate_client_discounts`
  ADD CONSTRAINT `corporate_client_discounts_corporate_client_id_foreign` FOREIGN KEY (`corporate_client_id`) REFERENCES `corporate_clients` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `corporate_client_discounts_hospital_id_foreign` FOREIGN KEY (`hospital_id`) REFERENCES `hospitals` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `departments`
--
ALTER TABLE `departments`
  ADD CONSTRAINT `departments_hospital_id_foreign` FOREIGN KEY (`hospital_id`) REFERENCES `hospitals` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `department_consumptions`
--
ALTER TABLE `department_consumptions`
  ADD CONSTRAINT `department_consumptions_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`),
  ADD CONSTRAINT `department_consumptions_hospital_id_foreign` FOREIGN KEY (`hospital_id`) REFERENCES `hospitals` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `department_consumptions_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `designations`
--
ALTER TABLE `designations`
  ADD CONSTRAINT `designations_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`),
  ADD CONSTRAINT `designations_hospital_id_foreign` FOREIGN KEY (`hospital_id`) REFERENCES `hospitals` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `doctors`
--
ALTER TABLE `doctors`
  ADD CONSTRAINT `doctors_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`),
  ADD CONSTRAINT `doctors_designation_id_foreign` FOREIGN KEY (`designation_id`) REFERENCES `designations` (`id`),
  ADD CONSTRAINT `doctors_doctors_specialities_id_foreign` FOREIGN KEY (`doctors_specialities_id`) REFERENCES `doctors_specialities` (`id`),
  ADD CONSTRAINT `doctors_hospital_id_foreign` FOREIGN KEY (`hospital_id`) REFERENCES `hospitals` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `inventories`
--
ALTER TABLE `inventories`
  ADD CONSTRAINT `inventories_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `inventories_hospital_id_foreign` FOREIGN KEY (`hospital_id`) REFERENCES `hospitals` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `inventories_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `ipd_billings`
--
ALTER TABLE `ipd_billings`
  ADD CONSTRAINT `ipd_billings_patient_admission_id_foreign` FOREIGN KEY (`patient_admission_id`) REFERENCES `patient_admissions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `ipd_bill_details`
--
ALTER TABLE `ipd_bill_details`
  ADD CONSTRAINT `ipd_bill_details_ipd_billing_id_foreign` FOREIGN KEY (`ipd_billing_id`) REFERENCES `ipd_billings` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `ipd_services`
--
ALTER TABLE `ipd_services`
  ADD CONSTRAINT `ipd_services_hospital_id_foreign` FOREIGN KEY (`hospital_id`) REFERENCES `hospitals` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `ipd_service_packages`
--
ALTER TABLE `ipd_service_packages`
  ADD CONSTRAINT `ipd_service_packages_hospital_id_foreign` FOREIGN KEY (`hospital_id`) REFERENCES `hospitals` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `medicines`
--
ALTER TABLE `medicines`
  ADD CONSTRAINT `medicines_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `medicine_companies` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `medicines_medicine_type_id_foreign` FOREIGN KEY (`medicine_type_id`) REFERENCES `medicine_types` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `opd_billings`
--
ALTER TABLE `opd_billings`
  ADD CONSTRAINT `opd_billings_doctor_id_foreign` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `opd_billings_patient_id_foreign` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `opd_bill_details`
--
ALTER TABLE `opd_bill_details`
  ADD CONSTRAINT `opd_bill_details_opd_billing_id_foreign` FOREIGN KEY (`opd_billing_id`) REFERENCES `opd_billings` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `opd_services`
--
ALTER TABLE `opd_services`
  ADD CONSTRAINT `opd_services_hospital_id_foreign` FOREIGN KEY (`hospital_id`) REFERENCES `hospitals` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `opd_service_packages`
--
ALTER TABLE `opd_service_packages`
  ADD CONSTRAINT `opd_service_packages_hospital_id_foreign` FOREIGN KEY (`hospital_id`) REFERENCES `hospitals` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `pathologies`
--
ALTER TABLE `pathologies`
  ADD CONSTRAINT `pathologies_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`),
  ADD CONSTRAINT `pathologies_hospital_id_foreign` FOREIGN KEY (`hospital_id`) REFERENCES `hospitals` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `patients`
--
ALTER TABLE `patients`
  ADD CONSTRAINT `patients_doctor_id_foreign` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `patients_hospital_id_foreign` FOREIGN KEY (`hospital_id`) REFERENCES `hospitals` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `patient_admissions`
--
ALTER TABLE `patient_admissions`
  ADD CONSTRAINT `patient_admissions_doctor_id_foreign` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `patient_admissions_hospital_id_foreign` FOREIGN KEY (`hospital_id`) REFERENCES `hospitals` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `patient_admissions_patient_id_foreign` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_product_brand_id_foreign` FOREIGN KEY (`product_brand_id`) REFERENCES `product_brands` (`id`),
  ADD CONSTRAINT `products_product_category_id_foreign` FOREIGN KEY (`product_category_id`) REFERENCES `product_categories` (`id`),
  ADD CONSTRAINT `products_product_model_id_foreign` FOREIGN KEY (`product_model_id`) REFERENCES `product_models` (`id`);

--
-- Constraints for table `product_brands`
--
ALTER TABLE `product_brands`
  ADD CONSTRAINT `product_brands_product_category_id_foreign` FOREIGN KEY (`product_category_id`) REFERENCES `product_categories` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `product_models`
--
ALTER TABLE `product_models`
  ADD CONSTRAINT `product_models_product_brand_id_foreign` FOREIGN KEY (`product_brand_id`) REFERENCES `product_brands` (`id`),
  ADD CONSTRAINT `product_models_product_category_id_foreign` FOREIGN KEY (`product_category_id`) REFERENCES `product_categories` (`id`);

--
-- Constraints for table `requisitions`
--
ALTER TABLE `requisitions`
  ADD CONSTRAINT `requisitions_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `requisitions_hospital_id_foreign` FOREIGN KEY (`hospital_id`) REFERENCES `hospitals` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `requisitions_requisition_category_id_foreign` FOREIGN KEY (`requisition_category_id`) REFERENCES `requisition_categories` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `requisition_details`
--
ALTER TABLE `requisition_details`
  ADD CONSTRAINT `requisition_details_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `requisition_details_requisition_id_foreign` FOREIGN KEY (`requisition_id`) REFERENCES `requisitions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `requisition_details_supplier_id_foreign` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `stores`
--
ALTER TABLE `stores`
  ADD CONSTRAINT `stores_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`),
  ADD CONSTRAINT `stores_hospital_id_foreign` FOREIGN KEY (`hospital_id`) REFERENCES `hospitals` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
