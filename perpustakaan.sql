-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Aug 15, 2019 at 10:09 PM
-- Server version: 10.3.16-MariaDB
-- PHP Version: 7.3.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `perpustakaan`
--

-- --------------------------------------------------------

--
-- Table structure for table `book`
--

CREATE TABLE `book` (
  `id` int(11) NOT NULL,
  `title` varchar(25) NOT NULL,
  `stock` int(11) NOT NULL,
  `borrowed` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `book`
--

INSERT INTO `book` (`id`, `title`, `stock`, `borrowed`) VALUES
(1, 'In Search of Lost Time', 10, 4),
(2, 'Don Quixote', 10, 1),
(3, 'Ulysses', 10, 1),
(4, 'The Great Gatsby', 10, 0),
(5, 'Moby Dick', 10, 0),
(6, 'Hamlet', 10, 0),
(7, 'War and Peace', 10, 0),
(8, 'The Odyssey', 10, 2),
(9, 'One Hundred Years', 10, 0),
(10, 'The Divine Comedy', 10, 0),
(11, 'The Brothers Karamazov', 10, 1),
(12, 'Madame Bovary', 10, 2);

-- --------------------------------------------------------

--
-- Table structure for table `borrowed`
--

CREATE TABLE `borrowed` (
  `id` int(11) NOT NULL,
  `id_book` int(11) NOT NULL,
  `id_student` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `borrowed`
--

INSERT INTO `borrowed` (`id`, `id_book`, `id_student`) VALUES
(18, 1, 1),
(19, 8, 6),
(20, 3, 8),
(21, 11, 8),
(22, 1, 8),
(23, 1, 7),
(24, 12, 7),
(25, 12, 11);

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `id` int(11) NOT NULL,
  `name` varchar(25) NOT NULL,
  `borrow` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `student`
--

INSERT INTO `student` (`id`, `name`, `borrow`) VALUES
(1, 'Alaina Jarvis', NULL),
(2, 'Virgil Foley', NULL),
(3, 'Mccauley Acosta', NULL),
(4, 'Deanne Spears', NULL),
(5, 'Lyndsey Arnold', NULL),
(6, 'Olivier Metcalfe', NULL),
(7, 'Rosanna Peacock', NULL),
(8, 'Iain Cuevas', NULL),
(9, 'Elisha Mccullough', NULL),
(10, 'Sue Welch', NULL),
(11, 'Aiesha Worthington', NULL),
(12, 'Benito Welch', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `book`
--
ALTER TABLE `book`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `borrowed`
--
ALTER TABLE `borrowed`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `book`
--
ALTER TABLE `book`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `borrowed`
--
ALTER TABLE `borrowed`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `student`
--
ALTER TABLE `student`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
