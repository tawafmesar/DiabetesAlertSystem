
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
(10, 'Ibuprofen', 'NSAID', 'Tablet', '200mg', 'Three times a day', 1, 'Pain Relief', '2024-12-20 09:50:35'),
(12, 'Antiseptic Gel', 'Topical', 'Gel', 'Apply small amount', 'As needed', 1, 'Wound Care', '2024-12-20 09:50:35'),
(14, 'dasdasdas', 'dasdasd', 'dasdasddas', 'sadasdas', 'dasdasdads', 2, NULL, '2024-12-21 03:37:49'),
(15, 'asokaslkask', 'Antibiotic', 'Syrup', 'fsfssfsf', 'jaksjksaasasas', 2, NULL, '2024-12-21 05:07:13'),
(17, 'adasd', 'Vitamin', 'Drops', 'dasdasd', 'dasdasd', 2, NULL, '2024-12-21 05:11:45'),
(18, 'Hydrocortisone', 'Other', 'Ointment', 'Apply thin layer', 'Once daily', 1, NULL, '2024-12-21 06:51:52'),
(20, 'testt', 'Antibiotic', 'Capsule', 'asasa', 'assa', 2, NULL, '2025-01-02 06:52:21'),
(21, 'Asprin', 'Cardiac', 'Tablet', '75 mg', 'One in day', 1, NULL, '2025-02-03 11:59:29'),
(22, 'Insuline', 'Endocrine', 'Injection', '1000 ', 'Twoce', 2, NULL, '2025-02-03 12:00:20'),
(23, 'test', 'Antibiotic', 'Capsule', 'ttest', 'dassda', 1, NULL, '2025-02-03 12:01:34'),
(25, 'panadol', 'Antihistamine', 'Tablet', '250', 'once', 2, NULL, '2025-03-16 06:37:34'),
(27, 'gdgdg', 'Neurological', 'Syrup', 'sdfvsdv', 'sdsdf', 1, NULL, '2025-03-16 06:38:44'),
(28, 'dfadasda', 'Dermatological', 'Injection', 'afasd', 'asdasd', 1, NULL, '2025-03-16 06:38:58'),
(29, 'Insulin Pan', 'Antibiotic', 'Injection', '1000', 'one', 1, NULL, '2025-04-12 16:41:10');


ALTER TABLE `medications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `users_id` (`users_id`);

ALTER TABLE `medications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

ALTER TABLE `medications`
  ADD CONSTRAINT `medications_ibfk_1` FOREIGN KEY (`users_id`) REFERENCES `users` (`users_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;
