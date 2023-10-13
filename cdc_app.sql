-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 13, 2023 at 10:11 AM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cdc_app`
--

-- --------------------------------------------------------

--
-- Table structure for table `profil`
--

CREATE TABLE `profil` (
  `uid` int(11) NOT NULL,
  `ufullname` varchar(150) NOT NULL,
  `uttl` varchar(255) NOT NULL,
  `unik` varchar(17) NOT NULL,
  `ualamat` varchar(500) NOT NULL,
  `uemail` varchar(255) NOT NULL,
  `utelepon` varchar(15) NOT NULL,
  `upassword` varchar(255) NOT NULL,
  `ufoto` varchar(255) DEFAULT NULL,
  `ulinkedin` varchar(255) DEFAULT NULL,
  `uinstagram` varchar(255) DEFAULT NULL,
  `ufacebook` varchar(255) DEFAULT NULL,
  `utwitter` varchar(255) DEFAULT NULL,
  `level` enum('admin','member') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `profil`
--

INSERT INTO `profil` (`uid`, `ufullname`, `uttl`, `unik`, `ualamat`, `uemail`, `utelepon`, `upassword`, `ufoto`, `ulinkedin`, `uinstagram`, `ufacebook`, `utwitter`, `level`) VALUES
(11, 'Zhaqian Rouf Alfauzi', 'Pacitan, 18 September 2003', '3501040107030020', 'Jl Bunga Nusa Indah No 8, Kelurahan Baleharjo, Lingkungan Kwarasan, Pacitan', 'zhaqianroufa@gmail.com', '89509512660', '1234567', NULL, NULL, NULL, NULL, NULL, 'admin'),
(14, 'night', 'pacitan', '100000', '1234567', 'nightcorenest@gmail.com', '89509512660', '1234567', NULL, NULL, NULL, NULL, NULL, 'member'),
(15, '', '', '', '', '', '', '', NULL, NULL, NULL, NULL, NULL, ''),
(16, '', '', '', '', '', '', '', NULL, NULL, NULL, NULL, NULL, '');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `profil`
--
ALTER TABLE `profil`
  ADD PRIMARY KEY (`uid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `profil`
--
ALTER TABLE `profil`
  MODIFY `uid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
