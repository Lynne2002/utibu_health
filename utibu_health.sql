-- phpMyAdmin SQL Dump
-- version 6.0.0-dev+20230719.d53d0612a6
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 03, 2024 at 04:12 PM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `utibu_health`
--

-- --------------------------------------------------------

--
-- Table structure for table `login`
--

CREATE TABLE `login` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `login`
--

INSERT INTO `login` (`id`, `username`, `password`, `email`, `created_at`) VALUES
(7, 'tanya', '$2y$10$g2ElkBPy.xvFRYoJD3GRWe3cWSEpnpg3LqOtIQxURFk75MfZ3nPYm', 'tanya@gmail.com', '2024-04-03 05:21:10'),
(8, 'zena', '$2y$10$1/NEXQ9DqqWg3rRH5fa9k.2XIDevI4pYTo5gKd3x2KDvLE2YEzShi', 'zena@gmail.com', '2024-04-03 05:27:37'),
(9, 'Folabi', '$2y$10$vHJ47w45m37Zu0XRFHt7EeYTWOjp.4mO1uMC.I2wLCcmbpdmybE06', 'folabi@gmail.com', '2024-04-03 13:00:33'),
(10, 'Trent', '$2y$10$Oj2obso7ZDuQbH63uWGE8OMKtG8Ri2I7kDL8Vq.X4F.aj.ptxDs7q', 'trent@gmail.com', '2024-04-03 13:07:44');

-- --------------------------------------------------------

--
-- Table structure for table `medicine_stock`
--

CREATE TABLE `medicine_stock` (
  `id` int(11) NOT NULL,
  `medicine_name` varchar(255) NOT NULL,
  `quantity` int(11) NOT NULL,
  `expiry_date` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `medicine_stock`
--

INSERT INTO `medicine_stock` (`id`, `medicine_name`, `quantity`, `expiry_date`, `created_at`) VALUES
(1, 'Omiprazole', 74, '10/24', '2024-04-03 05:44:32'),
(2, 'Panadol', 90, '12/3', '2024-04-03 05:45:16'),
(3, 'Buscopan', 43, '12/3', '2024-04-03 06:30:39'),
(4, 'Ascoril', 28, '1/23', '2024-04-03 06:30:39'),
(5, 'Paracetamol', 39, '12/3', '2024-04-03 12:53:11'),
(6, 'Mara Moja', 46, '3/12', '2024-04-03 12:53:11');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `medicine_name` varchar(255) NOT NULL,
  `quantity` int(11) NOT NULL,
  `fullname` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `medicine_name`, `quantity`, `fullname`, `created_at`) VALUES
(15, 'Ascoril', 2, 'Tanya Javobs', '2024-04-03 12:54:39'),
(16, 'Paracetamol', 6, 'Folabi Samuel', '2024-04-03 13:01:13'),
(17, 'Buscopan', 2, 'Folabi Samuel', '2024-04-03 13:02:11'),
(18, 'Mara Moja', 3, 'Trent Alex', '2024-04-03 13:08:23');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `login`
--
ALTER TABLE `login`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `medicine_stock`
--
ALTER TABLE `medicine_stock`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `login`
--
ALTER TABLE `login`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `medicine_stock`
--
ALTER TABLE `medicine_stock`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
