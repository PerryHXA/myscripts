-- --------------------------------------------------------
-- Verkkotietokone:              127.0.0.1
-- Palvelinversio:               11.4.0-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Versio:              12.6.0.6765
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for vorpv2
CREATE DATABASE IF NOT EXISTS `vorpv2` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `vorpv2`;

-- Dumping structure for taulu vorpv2.addon_account
CREATE TABLE IF NOT EXISTS `addon_account` (
  `name` varchar(60) NOT NULL,
  `label` varchar(100) NOT NULL,
  `shared` int(11) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table vorpv2.addon_account: ~10 rows (suunnilleen)
INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES
	('society_ahma', 'Panttilainaamo', 1),
	('society_gunsmith', 'Aseseppä', 1),
	('society_huonekaluliike', 'Huonekaluliike', 1),
	('society_intiaani', 'Intiaani', 1),
	('society_liitto', 'Liittovaltio', 1),
	('society_police', 'Poliisi', 1),
	('society_saluuna', 'Saluuna', 1),
	('society_sheriff', 'Sheriffi', 1),
	('society_teatteri', 'Teatteri', 1),
	('society_tohtori', 'Tohtori', 1);

-- Dumping structure for taulu vorpv2.addon_account_data
CREATE TABLE IF NOT EXISTS `addon_account_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_name` varchar(100) DEFAULT NULL,
  `money` int(11) NOT NULL,
  `owner` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_addon_account_data_account_name_owner` (`account_name`,`owner`),
  KEY `index_addon_account_data_account_name` (`account_name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table vorpv2.addon_account_data: ~10 rows (suunnilleen)
INSERT INTO `addon_account_data` (`id`, `account_name`, `money`, `owner`) VALUES
	(1, 'society_police', 1052, NULL),
	(2, 'society_saluuna', 3, NULL),
	(3, 'society_tohtori', 150, NULL),
	(4, 'society_huonekaluliike', 0, NULL),
	(5, 'society_liitto', 0, NULL),
	(6, 'society_intiaani', 61, NULL),
	(7, 'society_sheriff', 0, NULL),
	(8, 'society_ahma', 100, NULL),
	(9, 'society_gunsmith', 26, NULL),
	(10, 'society_teatteri', 0, NULL);

-- Dumping structure for taulu vorpv2.billing
CREATE TABLE IF NOT EXISTS `billing` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(40) NOT NULL,
  `sender` varchar(40) NOT NULL,
  `target_type` varchar(50) NOT NULL,
  `target` varchar(40) NOT NULL,
  `label` varchar(255) NOT NULL,
  `amount` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table vorpv2.billing: ~0 rows (suunnilleen)

-- Dumping structure for taulu vorpv2.bills
CREATE TABLE IF NOT EXISTS `bills` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job` longtext DEFAULT NULL,
  `playername` longtext DEFAULT NULL,
  `identifier` varchar(50) DEFAULT NULL,
  `charidentifier` int(11) DEFAULT NULL,
  `issuer` longtext DEFAULT NULL,
  `amount` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table vorpv2.bills: ~0 rows (suunnilleen)

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
