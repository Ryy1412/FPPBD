-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jul 25, 2025 at 04:22 AM
-- Server version: 8.0.30
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pace_mobil`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `daftar_sewa_hari_ini` ()   BEGIN
    SELECT * FROM sewa WHERE tanggal_sewa = CURDATE();
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tambah_sewa` (IN `p_nama` VARCHAR(250), IN `p_jumlah_hari` INT)   BEGIN
    DECLARE v_harga DECIMAL(18,0);
    DECLARE v_total DECIMAL(18,0);
    
    -- Set harga default
    SET v_harga = 250000;
    
    -- Jika sewa lebih dari 3 hari, dapat diskon 10%
    IF p_jumlah_hari > 3 THEN
        SET v_total = p_jumlah_hari * v_harga * 0.9;
    ELSE
        SET v_total = p_jumlah_hari * v_harga;
    END IF;
    
    INSERT INTO sewa (id_pelanggan, nama, email, tanggal_sewa, jumlah_hari, mobil, harga, total)
    VALUES (CONCAT('PLG', FLOOR(RAND() * 10000)), p_nama, CONCAT(p_nama, '@example.com'), CURDATE(), p_jumlah_hari, 'Toyota Avanza', v_harga, v_total);
    
    SELECT * FROM sewa ORDER BY id DESC LIMIT 1;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `hitung_total_sewa` (`jumlah_hari` INT, `harga_per_hari` DECIMAL(18,0)) RETURNS DECIMAL(18,0) DETERMINISTIC BEGIN
    DECLARE total DECIMAL(18,0);
    SET total = jumlah_hari * harga_per_hari;
    RETURN total;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `total_sewa_hari_ini` () RETURNS INT DETERMINISTIC BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total FROM sewa WHERE tanggal_sewa = CURDATE();
    RETURN total;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Stand-in structure for view `info_pelanggan`
-- (See below for the actual view)
--
CREATE TABLE `info_pelanggan` (
`email` varchar(100)
,`id_pelanggan` varchar(50)
,`nama` varchar(250)
);

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `mobil`
--

CREATE TABLE `mobil` (
  `id` int NOT NULL,
  `merk` varchar(50) DEFAULT NULL,
  `model` varchar(50) DEFAULT NULL,
  `tahun` int DEFAULT NULL,
  `harga` decimal(18,0) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('EgDmGze7o0unF1c32CelcaaekR4E2LfU6yEh5yui', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNmdWNTNORXg2OERsUER6VEhSbTJNRjFiUEdFQ0dQZk92OHRvbUFrSiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjg6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9yZW50YWwiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750850332),
('sRTRG82IrwmAWxWoWjeFpltLYbwrcGPaGvnzUbh7', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidEtlSklWbktFTXFpTFlnZEpZdTVadTdsMDNCWmlyVEMwZ0RzVUs5ZyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjg6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9yZW50YWwiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750924660);

-- --------------------------------------------------------

--
-- Table structure for table `sewa`
--

CREATE TABLE `sewa` (
  `id` int NOT NULL,
  `id_pelanggan` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `nama` varchar(250) COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `tanggal_sewa` date NOT NULL,
  `jumlah_hari` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `mobil` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `harga` decimal(18,0) NOT NULL,
  `total` decimal(18,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sewa`
--

INSERT INTO `sewa` (`id`, `id_pelanggan`, `nama`, `email`, `tanggal_sewa`, `jumlah_hari`, `mobil`, `harga`, `total`) VALUES
(3, 'PLG124', 'Another User', 'another@example.com', '2025-07-25', '5', 'Toyota Alphard', '1000000', '5000000'),
(2, 'PLG1694', 'Budi', 'Budi@example.com', '2025-07-25', '5', 'Toyota Avanza', '250000', '1125000'),
(1, 'PLG3384', 'John Doe', 'John Doe@example.com', '2025-07-25', '5', 'Toyota Avanza', '250000', '1125000');

--
-- Triggers `sewa`
--
DELIMITER $$
CREATE TRIGGER `after_sewa_delete` AFTER DELETE ON `sewa` FOR EACH ROW BEGIN
    -- Log sudah dibuat di BEFORE DELETE
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_sewa_insert` AFTER INSERT ON `sewa` FOR EACH ROW BEGIN
    INSERT INTO sewa_log (action, id_pelanggan, nama)
    VALUES ('INSERT', NEW.id_pelanggan, NEW.nama);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_sewa_update` AFTER UPDATE ON `sewa` FOR EACH ROW BEGIN
    INSERT INTO sewa_log (action, id_pelanggan, nama)
    VALUES ('UPDATE', NEW.id_pelanggan, NEW.nama);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_sewa_delete` BEFORE DELETE ON `sewa` FOR EACH ROW BEGIN
    INSERT INTO sewa_log (action, id_pelanggan, nama)
    VALUES ('DELETE', OLD.id_pelanggan, OLD.nama);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_sewa_insert` BEFORE INSERT ON `sewa` FOR EACH ROW BEGIN
    IF NEW.jumlah_hari < 1 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Jumlah hari sewa minimal 1';
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_sewa_update` BEFORE UPDATE ON `sewa` FOR EACH ROW BEGIN
    IF NEW.total < 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Total tidak boleh negatif';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `sewa_log`
--

CREATE TABLE `sewa_log` (
  `id` int NOT NULL,
  `action` varchar(10) DEFAULT NULL,
  `id_pelanggan` varchar(50) DEFAULT NULL,
  `nama` varchar(250) DEFAULT NULL,
  `changed_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `sewa_log`
--

INSERT INTO `sewa_log` (`id`, `action`, `id_pelanggan`, `nama`, `changed_at`) VALUES
(1, 'INSERT', 'PLG124', 'Another User', '2025-07-25 03:28:02');

-- --------------------------------------------------------

--
-- Stand-in structure for view `sewa_mobil_mahal`
-- (See below for the actual view)
--
CREATE TABLE `sewa_mobil_mahal` (
`email` varchar(100)
,`harga` decimal(18,0)
,`id` int
,`id_pelanggan` varchar(50)
,`jumlah_hari` varchar(50)
,`mobil` varchar(50)
,`nama` varchar(250)
,`tanggal_sewa` date
,`total` decimal(18,0)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `sewa_mobil_mahal_local`
-- (See below for the actual view)
--
CREATE TABLE `sewa_mobil_mahal_local` (
`email` varchar(100)
,`harga` decimal(18,0)
,`id` int
,`id_pelanggan` varchar(50)
,`jumlah_hari` varchar(50)
,`mobil` varchar(50)
,`nama` varchar(250)
,`tanggal_sewa` date
,`total` decimal(18,0)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `sewa_terbaru`
-- (See below for the actual view)
--
CREATE TABLE `sewa_terbaru` (
`email` varchar(100)
,`harga` decimal(18,0)
,`id` int
,`id_pelanggan` varchar(50)
,`jumlah_hari` varchar(50)
,`mobil` varchar(50)
,`nama` varchar(250)
,`tanggal_sewa` date
,`total` decimal(18,0)
);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure for view `info_pelanggan`
--
DROP TABLE IF EXISTS `info_pelanggan`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `info_pelanggan`  AS SELECT `sewa`.`id_pelanggan` AS `id_pelanggan`, `sewa`.`nama` AS `nama`, `sewa`.`email` AS `email` FROM `sewa``sewa`  ;

-- --------------------------------------------------------

--
-- Structure for view `sewa_mobil_mahal`
--
DROP TABLE IF EXISTS `sewa_mobil_mahal`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `sewa_mobil_mahal`  AS SELECT `sewa_terbaru`.`id` AS `id`, `sewa_terbaru`.`id_pelanggan` AS `id_pelanggan`, `sewa_terbaru`.`nama` AS `nama`, `sewa_terbaru`.`email` AS `email`, `sewa_terbaru`.`tanggal_sewa` AS `tanggal_sewa`, `sewa_terbaru`.`jumlah_hari` AS `jumlah_hari`, `sewa_terbaru`.`mobil` AS `mobil`, `sewa_terbaru`.`harga` AS `harga`, `sewa_terbaru`.`total` AS `total` FROM `sewa_terbaru` WHERE (`sewa_terbaru`.`total` > 1000000) WITH CASCADED CHECK OPTION  ;

-- --------------------------------------------------------

--
-- Structure for view `sewa_mobil_mahal_local`
--
DROP TABLE IF EXISTS `sewa_mobil_mahal_local`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `sewa_mobil_mahal_local`  AS SELECT `sewa_mobil_mahal`.`id` AS `id`, `sewa_mobil_mahal`.`id_pelanggan` AS `id_pelanggan`, `sewa_mobil_mahal`.`nama` AS `nama`, `sewa_mobil_mahal`.`email` AS `email`, `sewa_mobil_mahal`.`tanggal_sewa` AS `tanggal_sewa`, `sewa_mobil_mahal`.`jumlah_hari` AS `jumlah_hari`, `sewa_mobil_mahal`.`mobil` AS `mobil`, `sewa_mobil_mahal`.`harga` AS `harga`, `sewa_mobil_mahal`.`total` AS `total` FROM `sewa_mobil_mahal` WHERE (`sewa_mobil_mahal`.`jumlah_hari` > 3) WITH LOCAL CHECK OPTION  ;

-- --------------------------------------------------------

--
-- Structure for view `sewa_terbaru`
--
DROP TABLE IF EXISTS `sewa_terbaru`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `sewa_terbaru`  AS SELECT `sewa`.`id` AS `id`, `sewa`.`id_pelanggan` AS `id_pelanggan`, `sewa`.`nama` AS `nama`, `sewa`.`email` AS `email`, `sewa`.`tanggal_sewa` AS `tanggal_sewa`, `sewa`.`jumlah_hari` AS `jumlah_hari`, `sewa`.`mobil` AS `mobil`, `sewa`.`harga` AS `harga`, `sewa`.`total` AS `total` FROM `sewa` WHERE (`sewa`.`tanggal_sewa` >= (curdate() - interval 30 day))  ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mobil`
--
ALTER TABLE `mobil`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_merk_model` (`merk`,`model`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `sewa`
--
ALTER TABLE `sewa`
  ADD PRIMARY KEY (`id_pelanggan`),
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `idx_nama_email` (`nama`,`email`),
  ADD KEY `idx_tanggal_jumlah` (`tanggal_sewa`,`jumlah_hari`);

--
-- Indexes for table `sewa_log`
--
ALTER TABLE `sewa_log`
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
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `mobil`
--
ALTER TABLE `mobil`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sewa`
--
ALTER TABLE `sewa`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `sewa_log`
--
ALTER TABLE `sewa_log`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
