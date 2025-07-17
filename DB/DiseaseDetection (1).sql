-- phpMyAdmin SQL Dump
-- version 3.2.4
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Feb 22, 2023 at 11:41 AM
-- Server version: 5.1.41
-- PHP Version: 5.3.1

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `diseasedetection`
--
CREATE DATABASE `diseasedetection` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `diseasedetection`;

-- --------------------------------------------------------

--
-- Table structure for table `diseasedetails`
--

CREATE TABLE IF NOT EXISTS `diseasedetails` (
  `DiseaseId` int(11) NOT NULL AUTO_INCREMENT,
  `DiseaseName` varchar(250) NOT NULL,
  `Recorded_Date` date NOT NULL,
  PRIMARY KEY (`DiseaseId`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `diseasedetails`
--

INSERT INTO `diseasedetails` (`DiseaseId`, `DiseaseName`, `Recorded_Date`) VALUES
(1, 'Brain Tumor', '2023-01-07'),
(2, 'COVID-19', '2023-01-07'),
(3, 'Lung Cancer', '2023-01-07'),
(4, 'Lymphoblastic', '2023-01-07'),
(5, 'Pneumonia', '2023-01-07'),
(6, 'Tuberculosis', '2023-01-07');

-- --------------------------------------------------------

--
-- Table structure for table `genderdetails`
--

CREATE TABLE IF NOT EXISTS `genderdetails` (
  `GenderId` int(11) NOT NULL AUTO_INCREMENT,
  `GenderName` varchar(250) NOT NULL,
  `Recorded_Date` date NOT NULL,
  PRIMARY KEY (`GenderId`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `genderdetails`
--

INSERT INTO `genderdetails` (`GenderId`, `GenderName`, `Recorded_Date`) VALUES
(1, 'Male', '2023-01-07'),
(2, 'Female', '2023-01-07');

-- --------------------------------------------------------

--
-- Table structure for table `personaldetails`
--

CREATE TABLE IF NOT EXISTS `personaldetails` (
  `PersonId` int(11) NOT NULL AUTO_INCREMENT,
  `Firstname` varchar(250) NOT NULL,
  `Lastname` varchar(250) NOT NULL,
  `Phoneno` bigint(250) NOT NULL,
  `Emailid` varchar(250) NOT NULL,
  `Address` varchar(250) NOT NULL,
  `UserType` varchar(250) NOT NULL,
  `Username` varchar(250) NOT NULL,
  `Password` varchar(250) NOT NULL,
  `Recorded_Date` date NOT NULL,
  PRIMARY KEY (`PersonId`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=14 ;

--
-- Dumping data for table `personaldetails`
--

INSERT INTO `personaldetails` (`PersonId`, `Firstname`, `Lastname`, `Phoneno`, `Emailid`, `Address`, `UserType`, `Username`, `Password`, `Recorded_Date`) VALUES
(13, 'kiruba', 'v', 9043963074, 'kirubakarans2009@gmail.com', 'chennai', 'Farmer', 'kiruba', 'kiruba', '2022-06-24');

-- --------------------------------------------------------

--
-- Table structure for table `uploaddetails`
--

CREATE TABLE IF NOT EXISTS `uploaddetails` (
  `UploadId` int(11) NOT NULL AUTO_INCREMENT,
  `PersonId` int(11) NOT NULL,
  `DiseaseId` int(11) NOT NULL,
  `Firstname` varchar(250) NOT NULL,
  `Lastname` varchar(250) NOT NULL,
  `Phoneno` bigint(20) NOT NULL,
  `Emailid` varchar(250) NOT NULL,
  `GenderId` int(11) NOT NULL,
  `Age` int(11) NOT NULL,
  `ImagePath` varchar(250) NOT NULL,
  `Recorded_Date` date NOT NULL,
  PRIMARY KEY (`UploadId`),
  KEY `DiseaseId` (`DiseaseId`),
  KEY `GenderId` (`GenderId`),
  KEY `PersonId` (`PersonId`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=28 ;

--
-- Dumping data for table `uploaddetails`
--

INSERT INTO `uploaddetails` (`UploadId`, `PersonId`, `DiseaseId`, `Firstname`, `Lastname`, `Phoneno`, `Emailid`, `GenderId`, `Age`, `ImagePath`, `Recorded_Date`) VALUES
(4, 13, 1, 'kiruba', 's', 9043963074, 'kirubakarans2009@gmail.com', 1, 34, 'antenna.png', '2023-01-07'),
(5, 13, 1, 'kiruba', 's', 9043963074, 'kirubakarans2009@gmail.com', 1, 34, 'antenna.png', '2023-01-07'),
(6, 13, 1, 'kiruba', 's', 9043963074, 'kirubakarans2009@gmail.com', 1, 34, 'antenna3.png', '2023-01-07'),
(7, 13, 1, 'kiruba', 's', 9043963074, 'kirubakarans2009@gmail.com', 1, 34, 'antenna3.png', '2023-01-07'),
(8, 13, 1, 'kiruba', 's', 9043963074, 'kirubakarans2009@gmail.com', 1, 34, 'antenna.png', '2023-01-07'),
(9, 13, 2, 'kiruba', 's', 9043963074, 'kirubakarans2009@gmail.com', 1, 34, 'Peer_to_peer.jpg', '2023-01-07'),
(10, 13, 2, 'kiruba', 's', 9043963074, 'kirubakarans2009@gmail.com', 1, 34, 'Peer_to_peer.jpg', '2023-01-07'),
(11, 13, 3, 'kiruba', 's', 9043963074, 'kirubakarans2009@gmail.com', 1, 34, 'antenna3.png', '2023-01-07'),
(12, 13, 3, 'kiruba', 's', 9043963074, 'kirubakarans2009@gmail.com', 1, 34, 'antenna3.png', '2023-01-07'),
(13, 13, 3, 'kiruba', 's', 9043963074, 'kirubakarans2009@gmail.com', 1, 34, 'antenna3.png', '2023-01-07'),
(14, 13, 4, 'kiruba', 's', 9043963074, 'kirubakarans2009@gmail.com', 1, 34, 'LINE4.png', '2023-01-07'),
(15, 13, 4, 'kiruba', 's', 9043963074, 'kirubakarans2009@gmail.com', 1, 34, 'LINE4.png', '2023-01-07'),
(16, 13, 4, 'kiruba', 's', 9043963074, 'kirubakarans2009@gmail.com', 1, 34, 'LINE4.png', '2023-01-07'),
(17, 13, 6, 'kiruba', 's', 9043963074, 'kirubakarans2009@gmail.com', 1, 34, 'LINE5.png', '2023-01-07'),
(18, 13, 1, 'kiruba', 's', 9043963074, 'kirubakarans2009@gmail.com', 1, 34, 'antenna.png', '2023-01-21'),
(19, 13, 1, 'kiruba', 's', 9043963074, 'kirubakarans2009@gmail.com', 1, 34, 'antenna.png', '2023-01-21'),
(20, 13, 2, 'kiruba', 's', 9043963074, 'kirubakarans2009@gmail.com', 1, 34, 'antenna3.png', '2023-01-21'),
(21, 13, 3, 'kiruba', 's', 9043963074, 'kirubakarans2009@gmail.com', 1, 34, 'antenna.png', '2023-01-21'),
(22, 13, 4, 'kiruba', 's', 9043963074, 'kirubakarans2009@gmail.com', 1, 34, 'antenna3.png', '2023-01-21'),
(23, 13, 5, 'kiruba', 's', 9043963074, 'kirubakarans2009@gmail.com', 1, 34, 'antenna.png', '2023-01-21'),
(24, 13, 6, 'kiruba', 's', 9043963074, 'kirubakarans2009@gmail.com', 1, 34, 'antenna3.png', '2023-01-21'),
(25, 13, 6, 'kiruba', 's', 9043963074, 'kirubakarans2009@gmail.com', 1, 34, 'antenna3.png', '2023-01-21'),
(26, 13, 1, 'kiruba', 's', 9043963074, 'kirubakarans2009@gmail.com', 1, 34, 'antenna.png', '2023-01-21'),
(27, 13, 1, 'kiruba', 's', 9043963074, 'kirubakarans2009@gmail.com', 1, 34, 'Test.png', '2023-01-22');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `uploaddetails`
--
ALTER TABLE `uploaddetails`
  ADD CONSTRAINT `uploaddetails_ibfk_1` FOREIGN KEY (`PersonId`) REFERENCES `personaldetails` (`PersonId`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `uploaddetails_ibfk_2` FOREIGN KEY (`DiseaseId`) REFERENCES `diseasedetails` (`DiseaseId`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `uploaddetails_ibfk_3` FOREIGN KEY (`GenderId`) REFERENCES `genderdetails` (`GenderId`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
