-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 14, 2025 at 09:35 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.1.25

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
(1, 1, 'Blood Pressure', '120', '80', '2023-10-18 23:30:00'),
(11, 2, 'Blood Pressure', '130', '85', '2023-10-18 23:45:00'),
(12, 2, 'Heart Rate', '80', NULL, '2023-10-18 23:47:25'),
(13, 2, 'Blood Sugar', '110', NULL, '2023-10-18 23:50:10'),
(14, 2, 'Blood Pressure', '128', '82', '2023-10-20 08:00:00'),
(15, 2, 'Heart Rate', '75', NULL, '2023-10-20 08:02:15'),
(16, 2, 'Blood Sugar', '105', NULL, '2023-10-20 08:05:00'),
(17, 2, 'Blood Pressure', '135', '90', '2023-10-21 06:30:00'),
(18, 2, 'Heart Rate', '78', NULL, '2023-10-21 06:32:05'),
(19, 2, 'Blood Sugar', '108', NULL, '2023-10-21 06:35:30'),
(20, 2, 'Blood Pressure', '125', '80', '2023-10-22 07:20:00'),
(24, 1, 'Heart Rate', '130', NULL, '2024-12-22 01:51:47'),
(25, 1, 'Blood Sugar', '120', NULL, '2024-12-22 01:52:06'),
(26, 1, 'Blood Sugar', 'asddasd', NULL, '2024-12-22 01:52:11'),
(27, 1, 'Heart Rate', '110', NULL, '2024-12-22 02:25:40'),
(28, 1, 'Heart Rate', '111', NULL, '2024-12-22 02:27:28'),
(29, 1, 'Blood Pressure', '120', '90', '2024-12-22 02:29:16'),
(31, 1, 'Heart Rate', '120', NULL, '2024-12-24 02:19:22'),
(33, 1, 'Heart Rate', '140', NULL, '2025-01-01 04:47:14'),
(35, 2, 'Heart Rate', '120', NULL, '2025-01-02 04:04:50'),
(36, 2, 'Heart Rate', '95', NULL, '2025-02-03 09:00:42'),
(37, 2, 'Blood Sugar', '110', NULL, '2025-02-03 09:00:53'),
(38, 2, 'Heart Rate', '99', NULL, '2025-02-03 09:01:04'),
(39, 1, 'Heart Rate', '124', NULL, '2025-03-16 03:40:43'),
(40, 1, 'Heart Rate', '95', NULL, '2025-03-16 03:40:58'),
(41, 2, 'Heart Rate', '55', NULL, '2025-04-12 13:22:52'),
(42, 2, 'Blood Pressure', '150', '105', '2025-04-12 13:23:10'),
(43, 2, 'Blood Sugar', '105', NULL, '2025-04-12 13:23:44'),
(44, 2, 'Heart Rate', '95', NULL, '2025-04-12 13:43:18');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `metrics`
--
ALTER TABLE `metrics`
  ADD PRIMARY KEY (`metric_id`),
  ADD KEY `user_id` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `metrics`
--
ALTER TABLE `metrics`
  MODIFY `metric_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `metrics`
--
ALTER TABLE `metrics`
  ADD CONSTRAINT `metrics_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`users_id`);
COMMIT;
