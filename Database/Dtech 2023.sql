-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.7.40-log - MySQL Community Server (GPL)
-- Server OS:                    Win64
-- HeidiSQL Version:             12.0.0.6468
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for dtech hotel
CREATE DATABASE IF NOT EXISTS `dtech hotel` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `dtech hotel`;

-- Dumping structure for table dtech hotel.accounts
CREATE TABLE IF NOT EXISTS `accounts` (
  `accountid` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(50) DEFAULT NULL,
  `fullname` varchar(50) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `phone` varchar(12) DEFAULT NULL,
  `ic` varchar(12) DEFAULT NULL,
  `citizen` varchar(3) DEFAULT NULL COMMENT 'yes, no',
  `gender` varchar(50) DEFAULT NULL COMMENT 'male, female',
  `age` int(11) DEFAULT NULL,
  PRIMARY KEY (`accountid`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table dtech hotel.categories
CREATE TABLE IF NOT EXISTS `categories` (
  `categoryid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  `sqft` float DEFAULT NULL,
  `suitable` varchar(50) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `deposit` float DEFAULT NULL,
  `image` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`categoryid`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table dtech hotel.categoryfacilities
CREATE TABLE IF NOT EXISTS `categoryfacilities` (
  `cfid` int(11) NOT NULL AUTO_INCREMENT,
  `categoryid` int(11) DEFAULT NULL,
  `facilityid` int(11) DEFAULT NULL,
  PRIMARY KEY (`cfid`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table dtech hotel.facilities
CREATE TABLE IF NOT EXISTS `facilities` (
  `facilityid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL,
  `icon` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`facilityid`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table dtech hotel.payments
CREATE TABLE IF NOT EXISTS `payments` (
  `paymentid` int(11) NOT NULL AUTO_INCREMENT,
  `accountid` int(11) DEFAULT NULL,
  `promotionid` int(11) DEFAULT NULL,
  `paymentdate` date DEFAULT NULL,
  `status` varchar(7) DEFAULT NULL,
  PRIMARY KEY (`paymentid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table dtech hotel.promotions
CREATE TABLE IF NOT EXISTS `promotions` (
  `promotionid` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) DEFAULT NULL,
  `description` varchar(50) DEFAULT NULL,
  `rate` float DEFAULT NULL,
  `off` int(11) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `promostart` date DEFAULT NULL,
  `promoend` date DEFAULT NULL,
  PRIMARY KEY (`promotionid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table dtech hotel.reservations
CREATE TABLE IF NOT EXISTS `reservations` (
  `reservationid` int(11) NOT NULL AUTO_INCREMENT,
  `datestart` varchar(50) DEFAULT NULL,
  `dateend` varchar(50) DEFAULT NULL,
  `accountid` int(11) DEFAULT NULL,
  `roomid` int(11) DEFAULT NULL,
  `paymentid` int(11) DEFAULT NULL,
  `total_adult` int(11) DEFAULT NULL,
  `total_child` int(11) DEFAULT NULL,
  `total_day` int(11) DEFAULT NULL,
  `total_price` float DEFAULT NULL,
  `staffid` int(11) DEFAULT NULL,
  PRIMARY KEY (`reservationid`)
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table dtech hotel.rooms
CREATE TABLE IF NOT EXISTS `rooms` (
  `roomid` int(11) NOT NULL AUTO_INCREMENT,
  `roomno` varchar(6) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `categoryid` int(11) DEFAULT NULL,
  PRIMARY KEY (`roomid`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

-- Dumping structure for table dtech hotel.staffs
CREATE TABLE IF NOT EXISTS `staffs` (
  `staffid` int(11) DEFAULT NULL,
  `fullname` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  `phone` varchar(12) DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL,
  `position` varchar(8) DEFAULT NULL,
  `status` varchar(3) DEFAULT NULL,
  `manager` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Data exporting was unselected.

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
