-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 14, 2025 at 09:35 PM
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
-- Database: `medicaredb`
--

-- --------------------------------------------------------

--
-- Structure for view `view_metrics`
--

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_metrics`  AS SELECT `m`.`metric_id` AS `metric_id`, `m`.`user_id` AS `user_id`, `m`.`metric_type` AS `metric_type`, `m`.`value1` AS `metric_value1`, `m`.`value2` AS `metric_value2`, `m`.`timestamp` AS `metric_timestamp`, `u`.`users_name` AS `user_name`, `u`.`users_email` AS `user_email`, `u`.`users_phone` AS `user_phone` FROM (`metrics` `m` join `users` `u` on(`m`.`user_id` = `u`.`users_id`)) ;

--
-- VIEW `view_metrics`
-- Data: None
--

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
