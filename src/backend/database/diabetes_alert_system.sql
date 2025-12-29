-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 05, 2025 at 09:53 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.1.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `diabetes_alert_system`
--

-- --------------------------------------------------------

--
-- Table structure for table `activities`
--

CREATE TABLE `activities` (
  `activity_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `category` varchar(100) NOT NULL,
  `activity_type` varchar(50) DEFAULT NULL,
  `duration_hours` int(11) NOT NULL,
  `duration_minutes` int(11) NOT NULL,
  `duration_seconds` int(11) NOT NULL,
  `user_weight` int(11) DEFAULT NULL,
  `calories_burned` float DEFAULT NULL,
  `activity_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `activities`
--

INSERT INTO `activities` (`activity_id`, `user_id`, `category`, `activity_type`, `duration_hours`, `duration_minutes`, `duration_seconds`, `user_weight`, `calories_burned`, `activity_date`) VALUES
(1, 1, 'General activities & cardio', 'Walking', 0, 0, 0, 70, 120.5, '2025-08-01 08:30:00'),
(2, 1, 'General activities & cardio', 'Running', 0, 0, 0, 70, 300.2, '2025-08-02 07:15:00'),
(3, 2, 'General activities & cardio', 'Cycling', 0, 0, 0, 80, 450, '2025-08-03 18:45:00'),
(4, 2, 'General activities & cardio', 'Swimming', 0, 0, 0, 80, 350.7, '2025-08-04 09:10:00'),
(5, 1, 'Other', 'Strength Training', 0, 0, 0, 65, 280.6, '2025-08-06 17:20:00'),
(6, 1, 'General activities & cardio', 'Walking', 0, 0, 0, 90, 150.4, '2025-08-07 08:00:00'),
(7, 2, 'General activities & cardio', 'Running', 0, 0, 0, 90, 320.1, '2025-08-08 19:00:00'),
(8, 2, 'General activities & cardio', 'Cycling', 0, 0, 0, 75, 410.8, '2025-08-09 07:30:00'),
(9, 1, 'Core exercises', 'Bicycle Crunch', 0, 0, 0, 75, 365.9, '2025-08-10 16:50:00'),
(10, 1, 'Core exercises', 'Dips', 0, 0, 0, 77, 22.33, '2025-08-22 22:09:15'),
(11, 1, 'Strength &amp; bodyweight', 'Dips', 0, 0, 5, 95, 0.8, '2025-08-23 02:52:36'),
(12, 1, 'General activities &amp; cardio', 'Swimming', 0, 0, 4, 71, 0.6, '2025-08-23 03:49:40'),
(13, 1, 'Strength &amp; bodyweight', 'Squats', 0, 0, 6, 100, 0.8, '2025-08-23 04:09:15'),
(14, 1, 'Strength &amp; bodyweight', 'Situps', 0, 0, 3, 100, 0.5, '2025-08-23 04:21:09'),
(15, 1, 'Strength and bodyweight', 'Pushups', 0, 0, 5, 100, 1.1, '2025-08-23 04:24:54'),
(16, 1, 'General activities and cardio', 'Running', 0, 0, 8, 100, 2.2, '2025-08-23 04:33:53'),
(17, 1, 'General activities &amp; cardio', 'Swimming', 0, 0, 2, 100, 0.4, '2025-08-25 23:57:31'),
(18, 1, 'Strength & bodyweight', 'Plank', 0, 0, 6, 100, 0.5, '2025-08-26 00:20:56'),
(19, 1, 'General activities & cardio', 'Cycling', 0, 0, 12, 71, 1.8, '2025-08-26 00:21:30'),
(20, 1, 'General activities & cardio', 'Jump Rope', 0, 0, 5, 90, 1.5, '2025-08-26 00:22:58'),
(23, 1, 'General activities & cardio', 'Walking', 0, 0, 4, 85, 0.3, '2025-08-26 01:02:05'),
(24, 2, 'General activities & cardio', 'Walking', 0, 0, 21, 70, 1.4, '2025-12-05 23:45:03'),
(25, 2, 'Strength & bodyweight', 'Situps', 0, 0, 41, 70, 4.8, '2025-12-05 23:47:04'),
(26, 2, 'Strength & bodyweight', 'Pushups', 0, 0, 35, 78, 6.1, '2025-12-05 23:48:17');

-- --------------------------------------------------------

--
-- Table structure for table `alarms`
--

CREATE TABLE `alarms` (
  `id` int(11) NOT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `is_ringing` tinyint(1) DEFAULT 0,
  `name_of_alarm` varchar(255) NOT NULL,
  `alarm_time_hour` int(11) NOT NULL,
  `alarm_time_minute` int(11) NOT NULL,
  `alarm_date` datetime NOT NULL,
  `is_recurrent` tinyint(1) DEFAULT 0,
  `weekday_recurrence` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`weekday_recurrence`)),
  `challenge_mode` tinyint(1) DEFAULT 0,
  `users_id` int(11) NOT NULL,
  `medications_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `alarms`
--

INSERT INTO `alarms` (`id`, `is_active`, `is_ringing`, `name_of_alarm`, `alarm_time_hour`, `alarm_time_minute`, `alarm_date`, `is_recurrent`, `weekday_recurrence`, `challenge_mode`, `users_id`, `medications_id`) VALUES
(82, 0, 0, 'Paracetamol Reminder', 20, 58, '2025-08-20 00:00:00', 0, '[false, false, true, false, true, false, false]', 0, 1, 1),
(83, 0, 0, 'Hydrocortisone Reminder', 21, 2, '2025-08-19 00:00:00', 0, '[false, false, false, false, false, false, false]', 0, 1, 18),
(84, 0, 0, 'Hydrocortisone Reminder', 17, 39, '2025-08-20 00:00:00', 0, '[false, false, false, false, false, false, false]', 0, 1, 18),
(85, 0, 0, 'Antiseptic Gel Reminder', 17, 43, '2025-08-21 00:00:00', 0, '[true, true, true, true, true, true, true]', 0, 1, 12),
(86, 0, 0, 'Vitamin B12 Injection Reminder', 17, 54, '2025-08-20 00:00:00', 0, '[false, false, false, false, false, false, false]', 0, 1, 7),
(87, 0, 0, 'Antiseptic Gel Reminder', 17, 53, '2025-08-20 00:00:00', 0, '[false, false, false, false, false, false, false]', 0, 1, 12),
(88, 0, 0, 'Antiseptic Gel Reminder', 18, 35, '2025-08-20 00:00:00', 0, '[false, false, false, false, false, false, false]', 0, 1, 12),
(90, 0, 0, 'Antiseptic Gel Reminder', 18, 40, '2025-08-21 00:00:00', 0, '[true, true, true, true, true, true, true]', 0, 1, 12),
(91, 0, 0, 'Paracetamol Reminder', 18, 43, '2025-08-20 00:00:00', 0, '[false, false, false, false, false, false, false]', 0, 1, 1),
(92, 0, 0, 'Eye Drops Reminder', 18, 45, '2025-08-20 00:00:00', 0, '[false, false, false, false, false, false, false]', 0, 1, 33),
(93, 0, 0, 'Vitamin B12 Injection Reminder', 23, 22, '2025-08-20 00:00:00', 0, '[false, false, false, false, false, false, false]', 0, 1, 7),
(94, 0, 0, 'Vitamin B12 Injection Reminder', 23, 26, '2025-08-20 00:00:00', 0, '[false, false, false, false, false, false, false]', 0, 1, 7),
(95, 0, 0, 'Vitamin B12 Injection Reminder', 23, 30, '2025-08-20 00:00:00', 0, '[false, false, false, false, false, false, false]', 0, 1, 7),
(98, 0, 0, 'Hydrocortisone Reminder', 13, 15, '2025-08-24 00:00:00', 0, '[true, true, true, true, true, true, true]', 0, 1, 18),
(99, 0, 0, 'Moisturizing Cream Reminder', 7, 54, '2025-08-24 00:00:00', 0, '[false, false, false, false, false, false, false]', 0, 1, 6),
(100, 0, 0, 'Antiseptic Gel Reminder', 7, 55, '2025-08-24 00:00:00', 0, '[false, false, false, false, false, false, false]', 0, 1, 12),
(101, 0, 0, 'panadol Reminder', 2, 40, '2025-10-24 00:00:00', 0, '[false, true, false, true, false, false, true]', 0, 2, 25),
(102, 0, 0, 'Insuline Reminder', 23, 49, '2025-12-06 00:00:00', 0, '[true, true, true, true, true, true, true]', 0, 2, 22),
(103, 0, 0, 'Eye Drops Reminder', 23, 51, '2025-12-06 00:00:00', 0, '[true, false, true, false, true, false, false]', 0, 2, 8);

-- --------------------------------------------------------

--
-- Table structure for table `medications`
--

CREATE TABLE `medications` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `class` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `dosage` varchar(255) DEFAULT NULL,
  `frequency` varchar(255) DEFAULT NULL,
  `users_id` int(11) NOT NULL,
  `health_condition` varchar(255) DEFAULT NULL,
  `date_create` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `medications`
--

INSERT INTO `medications` (`id`, `name`, `class`, `type`, `dosage`, `frequency`, `users_id`, `health_condition`, `date_create`) VALUES
(1, 'Paracetamol', 'Analgesic', 'Tablet', '500mg', 'Twice a day', 1, 'Fever', '2024-12-20 09:50:35'),
(2, 'Cough Syrup', 'Expectorant', 'Syrup', '10ml', 'Three times a day', 1, 'Cough', '2024-12-20 09:50:35'),
(4, 'Aloe Vera Gel', 'Topical', 'Gel', 'Apply thin layer', 'Twice daily', 2, 'Skin Care', '2024-12-20 09:50:35'),
(5, 'Hydrocortisone Ointment', 'Corticosteroid', 'Ointment', 'Apply thin layer', 'Once daily', 2, 'Skin Inflammation', '2024-12-20 09:50:35'),
(6, 'Moisturizing Cream', 'Emollient', 'Cream', 'Apply generous amount', 'Twice daily', 1, 'Dry Skin', '2024-12-20 09:50:35'),
(7, 'Vitamin B12 Injection', 'Vitamin Supplement', 'Injection', '1ml', 'Weekly', 1, 'Vitamin Deficiency', '2024-12-20 09:50:35'),
(8, 'Eye Drops', 'Ophthalmic', 'Drops', '1-2 drops per eye', 'Three times a day', 2, 'Eye Irritation', '2024-12-20 09:50:35'),
(9, 'Nasal Spray', 'Decongestant', 'Spray', '1 spray per nostril', 'Twice a day', 2, 'Nasal Congestion', '2024-12-20 09:50:35'),
(12, 'Antiseptic Gel', 'Topical', 'Gel', 'Apply small amount', 'As needed', 1, 'Wound Care', '2024-12-20 09:50:35'),
(14, 'dasdasdas', 'dasdasd', 'dasdasddas', 'sadasdas', 'dasdasdads', 2, NULL, '2024-12-21 03:37:49'),
(15, 'asokaslkask', 'Antibiotic', 'Syrup', 'fsfssfsf', 'jaksjksaasasas', 2, NULL, '2024-12-21 05:07:13'),
(17, 'adasd', 'Vitamin', 'Drops', 'dasdasd', 'dasdasd', 2, NULL, '2024-12-21 05:11:45'),
(18, 'Hydrocortisone', 'Other', 'Ointment', 'Apply thin layer', 'Once daily', 1, NULL, '2024-12-21 06:51:52'),
(20, 'testt', 'Antibiotic', 'Capsule', 'asasa', 'assa', 2, NULL, '2025-01-02 06:52:21'),
(22, 'Insuline', 'Endocrine', 'Injection', '1000 ', 'Twoce', 2, NULL, '2025-02-03 12:00:20'),
(25, 'panadol', 'Antihistamine', 'Tablet', '250', 'once', 2, NULL, '2025-03-16 06:37:34'),
(33, 'Eye Drops', 'Ophthalmic', 'Drops', 'Drops', 'Three times a day', 1, NULL, '2025-08-13 03:50:13');

-- --------------------------------------------------------

--
-- Table structure for table `metrics`
--

CREATE TABLE `metrics` (
  `metric_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `metric_type` enum('Blood Pressure','Heart Rate','Blood Sugar') NOT NULL,
  `value1` varchar(50) DEFAULT NULL,
  `value2` varchar(50) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `metrics`
--

INSERT INTO `metrics` (`metric_id`, `user_id`, `metric_type`, `value1`, `value2`, `timestamp`) VALUES
(1, 1, 'Blood Pressure', '120', '80', '2023-10-18 20:30:00'),
(11, 2, 'Blood Pressure', '130', '85', '2023-10-18 20:45:00'),
(12, 2, 'Heart Rate', '80', NULL, '2023-10-18 20:47:25'),
(13, 2, 'Blood Sugar', '110', NULL, '2023-10-18 20:50:10'),
(14, 2, 'Blood Pressure', '128', '82', '2023-10-20 05:00:00'),
(15, 2, 'Heart Rate', '75', NULL, '2023-10-20 05:02:15'),
(16, 2, 'Blood Sugar', '105', NULL, '2023-10-20 05:05:00'),
(17, 2, 'Blood Pressure', '135', '90', '2023-10-21 03:30:00'),
(18, 2, 'Heart Rate', '78', NULL, '2023-10-21 03:32:05'),
(19, 2, 'Blood Sugar', '108', NULL, '2023-10-21 03:35:30'),
(20, 2, 'Blood Pressure', '125', '80', '2023-10-22 04:20:00'),
(24, 1, 'Heart Rate', '130', NULL, '2024-12-21 22:51:47'),
(26, 1, 'Blood Sugar', 'asddasd', NULL, '2024-12-21 22:52:11'),
(27, 1, 'Heart Rate', '110', NULL, '2024-12-21 23:25:40'),
(28, 1, 'Heart Rate', '111', NULL, '2024-12-21 23:27:28'),
(29, 1, 'Blood Pressure', '120', '90', '2024-12-21 23:29:16'),
(31, 1, 'Heart Rate', '120', NULL, '2024-12-23 23:19:22'),
(33, 1, 'Heart Rate', '140', NULL, '2025-01-01 01:47:14'),
(35, 2, 'Heart Rate', '120', NULL, '2025-01-02 01:04:50'),
(36, 2, 'Heart Rate', '95', NULL, '2025-02-03 06:00:42'),
(37, 2, 'Blood Sugar', '110', NULL, '2025-02-03 06:00:53'),
(38, 2, 'Heart Rate', '99', NULL, '2025-02-03 06:01:04'),
(41, 2, 'Heart Rate', '55', NULL, '2025-04-12 10:22:52'),
(45, 1, 'Blood Sugar', '99', NULL, '2025-08-15 20:50:39'),
(46, 1, 'Blood Sugar', '68', NULL, '2025-08-17 18:35:58'),
(47, 1, 'Blood Sugar', '122', NULL, '2025-08-17 18:45:27'),
(48, 2, 'Blood Sugar', '122', NULL, '2025-11-12 04:28:03'),
(49, 2, 'Heart Rate', '100', NULL, '2025-11-12 04:28:28');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `users_id` int(11) NOT NULL,
  `users_name` varchar(100) NOT NULL,
  `users_password` varchar(255) NOT NULL,
  `users_email` varchar(100) NOT NULL,
  `users_phone` varchar(255) DEFAULT NULL,
  `users_verfiycode` int(11) NOT NULL,
  `users_approve` tinyint(4) NOT NULL DEFAULT 0,
  `users_role` int(11) NOT NULL DEFAULT 1,
  `users_create` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`users_id`, `users_name`, `users_password`, `users_email`, `users_phone`, `users_verfiycode`, `users_approve`, `users_role`, `users_create`) VALUES
(1, 'Tawaf Mesar', '7c4a8d09ca3762af61e59520943dc26494f8941b', 'tawafmesar@gmail.com', NULL, 23281, 1, 1, '2025-01-29 18:17:11'),
(2, 'LAYAN AhMED', '7c4a8d09ca3762af61e59520943dc26494f8941b', 'layan.m7744@gmail.com', NULL, 60526, 1, 1, '2025-02-07 11:42:09'),
(3, 'Emergency Services', '7c4a8d09ca3762af61e59520943dc26494f8941b', 'emergencyservices@gmail.com', '911', 11313, 1, 3, '2025-02-22 04:35:32'),
(6, 'Reem Al-Fahad', '5ebe2294ecd0e0f08eab7690d2a6ee69', 'reem.fahad@example.com', '0506789012', 567890, 1, 1, '2025-02-26 00:38:41'),
(7, 'Nasser Al-Otaibi', '7c6a180b36896a0a8c02787eeafb0e4c', 'nasser.otaibi@example.com', '0517890123', 678901, 1, 1, '2025-02-26 00:38:41'),
(8, 'Aisha Al-Rashid', '6c8349cc7260ae62e3b1396831a8398f', 'aisha.rashid@example.com', '0528901234', 789012, 1, 1, '2025-02-26 00:38:41'),
(9, 'Hassan Al-Ghamdi', 'c4ca4238a0b923820dcc509a6f75849b', 'hassan.ghamdi@example.com', '0539012345', 890123, 1, 1, '2025-02-26 00:38:41'),
(10, 'Latifa Al-Sulami', 'c81e728d9d4c2f636f067f89cc14862c', 'latifa.sulami@example.com', '0540123456', 901234, 1, 1, '2025-02-26 00:38:41'),
(11, 'Mohammed Al-Juhani', 'eccbc87e4b5ce2fe28308fd9f2a7baf3', 'mohammed.juhani@example.com', '0551234567', 123456, 1, 1, '2025-02-26 00:38:41'),
(12, 'Huda Al-Shahrani', 'a87ff679a2f3e71d9181a67b7542122c', 'huda.shahrani@example.com', '0562345678', 234567, 1, 1, '2025-02-26 00:38:41'),
(13, 'Badr Al-Saadi', 'e4da3b7fbbce2345d7772b0674a318d5', 'badr.saadi@example.com', '0573456789', 345678, 1, 1, '2025-02-26 00:38:41'),
(14, 'Salma Al-Tamimi', '1679091c5a880faf6fb5e6087eb1b2dc', 'salma.tamimi@example.com', '0584567890', 456789, 1, 1, '2025-02-26 00:38:41'),
(15, 'Yousef Al-Ahmari', '8f14e45fceea167a5a36dedd4bea2543', 'yousef.ahmari@example.com', '0595678901', 567890, 1, 1, '2025-02-26 00:38:41'),
(16, 'Fahad Al-Qahtani', 'e99a18c428cb38d5f260853678922e03', 'fahad.qahtani@example.com', '0551234567', 123456, 1, 1, '2025-02-26 00:38:41'),
(17, 'Maha Al-Shehri', '25d55ad283aa400af464c76d713c07ad', 'maha.shehri@example.com', '0562345678', 654321, 1, 1, '2025-02-26 00:38:41'),
(18, 'Saad Al-Mutairi', '098f6bcd4621d373cade4e832627b4f6', 'saad.mutairi@example.com', '0573456789', 789012, 1, 1, '2025-02-26 00:38:41'),
(19, 'Nouf Al-Harbi', '5f4dcc3b5aa765d61d8327deb882cf99', 'nouf.harbi@example.com', '0584567890', 345678, 1, 1, '2025-02-26 00:38:41'),
(20, 'Abdulaziz Al-Dosari', 'd8578edf8458ce06fbc5bb76a58c5ca4', 'abdulaziz.dosari@example.com', '0595678901', 901234, 1, 1, '2025-02-26 00:38:41'),
(1113, 'Tawaf Mesar', '20eabe5d64b0e216796e834f52d61fd0b70332fc', 'tawafmesffar@gmail.com', NULL, 37705, 1, 1, '2025-08-12 23:53:21');

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_medications`
-- (See below for the actual view)
--
CREATE TABLE `view_medications` (
`medication_id` int(11)
,`medication_name` varchar(255)
,`medication_class` varchar(255)
,`medication_type` varchar(255)
,`medication_dosage` varchar(255)
,`medication_frequency` varchar(255)
,`medication_health_condition` varchar(255)
,`medication_date_create` datetime
,`user_id` int(11)
,`user_name` varchar(100)
,`user_email` varchar(100)
,`user_phone` varchar(255)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_metrics`
-- (See below for the actual view)
--
CREATE TABLE `view_metrics` (
`metric_id` int(11)
,`user_id` int(11)
,`metric_type` enum('Blood Pressure','Heart Rate','Blood Sugar')
,`metric_value1` varchar(50)
,`metric_value2` varchar(50)
,`metric_timestamp` timestamp
,`user_name` varchar(100)
,`user_email` varchar(100)
,`user_phone` varchar(255)
);

-- --------------------------------------------------------

--
-- Structure for view `view_medications`
--
DROP TABLE IF EXISTS `view_medications`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_medications`  AS SELECT `m`.`id` AS `medication_id`, `m`.`name` AS `medication_name`, `m`.`class` AS `medication_class`, `m`.`type` AS `medication_type`, `m`.`dosage` AS `medication_dosage`, `m`.`frequency` AS `medication_frequency`, `m`.`health_condition` AS `medication_health_condition`, `m`.`date_create` AS `medication_date_create`, `u`.`users_id` AS `user_id`, `u`.`users_name` AS `user_name`, `u`.`users_email` AS `user_email`, `u`.`users_phone` AS `user_phone` FROM (`medications` `m` join `users` `u` on(`m`.`users_id` = `u`.`users_id`)) ;

-- --------------------------------------------------------

--
-- Structure for view `view_metrics`
--
DROP TABLE IF EXISTS `view_metrics`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_metrics`  AS SELECT `m`.`metric_id` AS `metric_id`, `m`.`user_id` AS `user_id`, `m`.`metric_type` AS `metric_type`, `m`.`value1` AS `metric_value1`, `m`.`value2` AS `metric_value2`, `m`.`timestamp` AS `metric_timestamp`, `u`.`users_name` AS `user_name`, `u`.`users_email` AS `user_email`, `u`.`users_phone` AS `user_phone` FROM (`metrics` `m` join `users` `u` on(`m`.`user_id` = `u`.`users_id`)) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `activities`
--
ALTER TABLE `activities`
  ADD PRIMARY KEY (`activity_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `alarms`
--
ALTER TABLE `alarms`
  ADD PRIMARY KEY (`id`),
  ADD KEY `users_id` (`users_id`),
  ADD KEY `medications_id` (`medications_id`);

--
-- Indexes for table `medications`
--
ALTER TABLE `medications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `users_id` (`users_id`);

--
-- Indexes for table `metrics`
--
ALTER TABLE `metrics`
  ADD PRIMARY KEY (`metric_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`users_id`),
  ADD UNIQUE KEY `users_email` (`users_email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activities`
--
ALTER TABLE `activities`
  MODIFY `activity_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `alarms`
--
ALTER TABLE `alarms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=104;

--
-- AUTO_INCREMENT for table `medications`
--
ALTER TABLE `medications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `metrics`
--
ALTER TABLE `metrics`
  MODIFY `metric_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `users_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1114;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `activities`
--
ALTER TABLE `activities`
  ADD CONSTRAINT `activities_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`users_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `alarms`
--
ALTER TABLE `alarms`
  ADD CONSTRAINT `alarms_ibfk_1` FOREIGN KEY (`users_id`) REFERENCES `users` (`users_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `alarms_ibfk_2` FOREIGN KEY (`medications_id`) REFERENCES `medications` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `medications`
--
ALTER TABLE `medications`
  ADD CONSTRAINT `medications_ibfk_1` FOREIGN KEY (`users_id`) REFERENCES `users` (`users_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `metrics`
--
ALTER TABLE `metrics`
  ADD CONSTRAINT `metrics_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`users_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
