-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 10, 2025 at 02:41 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.1.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

-- --------------------------------------------------------

--
-- Structure for view `view_medications`
--

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_medications`  AS SELECT `m`.`id` AS `medication_id`, `m`.`name` AS `medication_name`, `m`.`class` AS `medication_class`, `m`.`type` AS `medication_type`, `m`.`dosage` AS `medication_dosage`, `m`.`frequency` AS `medication_frequency`, `m`.`health_condition` AS `medication_health_condition`, `m`.`date_create` AS `medication_date_create`, `u`.`users_id` AS `user_id`, `u`.`users_name` AS `user_name`, `u`.`users_email` AS `user_email`, `u`.`users_phone` AS `user_phone` FROM (`medications` `m` join `users` `u` on(`m`.`users_id` = `u`.`users_id`)) ;

--
-- VIEW `view_medications`
-- Data: None
--

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
