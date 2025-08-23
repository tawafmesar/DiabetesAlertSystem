-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 17, 2025 at 11:57 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.1.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


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
-- Indexes for dumped tables
--

--
-- Indexes for table `alarms`
--
ALTER TABLE `alarms`
  ADD PRIMARY KEY (`id`),
  ADD KEY `users_id` (`users_id`),
  ADD KEY `medications_id` (`medications_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `alarms`
--
ALTER TABLE `alarms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=82;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `alarms`
--
ALTER TABLE `alarms`
  ADD CONSTRAINT `alarms_ibfk_1` FOREIGN KEY (`users_id`) REFERENCES `users` (`users_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `alarms_ibfk_2` FOREIGN KEY (`medications_id`) REFERENCES `medications` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;
