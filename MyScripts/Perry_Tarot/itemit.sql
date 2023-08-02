-- --------------------------------------------------------
-- Verkkotietokone:              127.0.0.1
-- Palvelinversio:               10.5.9-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Versio:              11.2.0.6213
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for vorpv2
CREATE DATABASE IF NOT EXISTS `vorpv2` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `vorpv2`;

-- Dumping structure for taulu vorpv2.items
CREATE TABLE IF NOT EXISTS `items` (
  `item` varchar(50) NOT NULL,
  `label` varchar(50) NOT NULL,
  `limit` int(11) NOT NULL DEFAULT 1,
  `can_remove` tinyint(1) NOT NULL DEFAULT 1,
  `type` varchar(50) DEFAULT NULL,
  `usable` tinyint(1) DEFAULT NULL,
  `desc` varchar(5550) NOT NULL DEFAULT 'nice item',
  PRIMARY KEY (`item`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- Dumping data for table vorpv2.items: ~734 rows (suunnilleen)
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` (`item`, `label`, `limit`, `can_remove`, `type`, `usable`, `desc`) VALUES
	('tarot1', 'Maljojen kymmenen (Tarot)', 10, 1, 'item_standard', 1, 'nice item'),
	('tarot10', 'Lanttien kolmonen (Tarot)', 10, 1, 'item_standard', 1, 'nice item'),
	('tarot11', 'Miekkojen kolmonen (Tarot)', 10, 1, 'item_standard', 1, 'nice item'),
	('tarot12', 'Sauvojen kolmonen (Tarot)', 10, 1, 'item_standard', 1, 'nice item'),
	('tarot13', 'Maljojen kolmonen (Tarot)', 10, 1, 'item_standard', 1, 'nice item'),
	('tarot14', 'Lanttien nelonen (Tarot)', 10, 1, 'item_standard', 1, 'nice item'),
	('tarot15', 'Miekkojen nelonen (Tarot)', 10, 1, 'item_standard', 1, 'nice item'),
	('tarot16', 'Sauvojen nelonen (Tarot)', 10, 1, 'item_standard', 1, 'nice item'),
	('tarot17', 'Maljojen vitonen (Tarot)', 10, 1, 'item_standard', 1, 'nice item'),
	('tarot18', 'Lanttien vitonen (Tarot)', 10, 1, 'item_standard', 1, 'nice item'),
	('tarot19', 'Miekkojen vitonen (Tarot)', 10, 1, 'item_standard', 1, 'nice item'),
	('tarot2', 'Lanttien kymmenen (Tarot)', 10, 1, 'item_standard', 1, 'nice item'),
	('tarot20', 'Sauvojen vitonen (Tarot)', 10, 1, 'item_standard', 1, 'nice item'),
	('tarot21', 'Maljojen kutonen (Tarot)', 10, 1, 'item_standard', 1, 'nice item'),
	('tarot22', 'Lanttien kutonen (Tarot)', 10, 1, 'item_standard', 1, 'nice item'),
	('tarot23', 'Miekkojen kutonen (Tarot)', 10, 1, 'item_standard', 1, 'nice item'),
	('tarot24', 'Sauvojen kutonen (Tarot)', 10, 1, 'item_standard', 1, 'nice item'),
	('tarot25', 'Maljojen seitsemän (Tarot)', 10, 1, 'item_standard', 1, 'nice item'),
	('tarot26', 'Lanttien seitsemän (Tarot)', 10, 1, 'item_standard', 1, 'nice item'),
	('tarot27', 'miekkojen seitsemän (Tarot)', 10, 1, 'item_standard', 1, 'nice item'),
	('tarot28', 'Sauvojen seitsemän (Tarot)', 10, 1, 'item_standard', 1, 'nice item'),
	('tarot29', 'Maljojen kahdeksan (Tarot)', 10, 1, 'item_standard', 1, 'nice item'),
	('tarot3', 'Miekkojen kymmenen (Tarot)', 10, 1, 'item_standard', 1, 'nice item'),
	('tarot30', 'Lanttien kahdeksan (Tarot)', 10, 1, 'item_standard', 1, 'nice item'),
	('tarot31', 'Miekkojen kahdeksan (Tarot)', 10, 1, 'item_standard', 1, 'nice item'),
	('tarot32', 'Sauvojen kahdeksan (Tarot)', 10, 1, 'item_standard', 1, 'nice item'),
	('tarot33', 'Maljojen yhdeksän (Tarot)', 10, 1, 'item_standard', 1, 'nice item'),
	('tarot34', 'Lanttien yhdeksän (Tarot)', 10, 1, 'item_standard', 1, 'nice item'),
	('tarot35', 'Miekkojen yhdeksän (Tarot)', 10, 1, 'item_standard', 1, 'nice item'),
	('tarot36', 'Sauvojen yhdeksän (Tarot)', 10, 1, 'item_standard', 1, 'nice item'),
	('tarot37', 'Maljojen ässä (Tarot)', 10, 1, 'item_standard', 1, 'nice item'),
	('tarot38', 'Lanttien ässä (Tarot)', 10, 1, 'item_standard', 1, 'nice item'),
	('tarot39', 'Miekkojen ässä (Tarot)', 10, 1, 'item_standard', 1, 'nice item'),
	('tarot4', 'Sauvojen kymmenen (Tarot)', 10, 1, 'item_standard', 1, 'nice item'),
	('tarot40', 'Sauvojen ässä (Tarot)', 10, 1, 'item_standard', 1, 'nice item'),
	('tarot41', 'Maljojen kuningas (Tarot)', 10, 1, 'item_standard', 1, 'nice item'),
	('tarot42', 'Lanttien kuningas (Tarot)', 10, 1, 'item_standard', 1, 'nice item'),
	('tarot43', 'Miekkojen kuningas (Tarot)', 10, 1, 'item_standard', 1, 'nice item'),
	('tarot44', 'Sauvojen kuningas (Tarot)', 10, 1, 'item_standard', 1, 'nice item'),
	('tarot45', 'Maljojen ritari (Tarot)', 10, 1, 'item_standard', 1, 'nice item'),
	('tarot46', 'Lanttien ritari (Tarot)', 10, 1, 'item_standard', 1, 'nice item'),
	('tarot47', 'Miekkojen ritari (Tarot)', 10, 1, 'item_standard', 1, 'nice item'),
	('tarot48', 'Sauvojen ritari (Tarot)', 10, 1, 'item_standard', 1, 'nice item'),
	('tarot49', 'Maljojen lähetti (Tarot)', 10, 1, 'item_standard', 1, 'nice item'),
	('tarot5', 'Maljojen kakkonen (Tarot)', 10, 1, 'item_standard', 1, 'nice item'),
	('tarot50', 'Lanttien lähetti (Tarot)', 10, 1, 'item_standard', 1, 'nice item'),
	('tarot51', 'Miekkojen lähetti (Tarot)', 10, 1, 'item_standard', 1, 'nice item'),
	('tarot52', 'Sauvojen lähetti (Tarot)', 10, 1, 'item_standard', 1, 'nice item'),
	('tarot53', 'Maljojen kuningatar (Tarot)', 10, 1, 'item_standard', 1, 'nice item'),
	('tarot54', 'Lanttien kuningatar (Tarot)', 10, 1, 'item_standard', 1, 'nice item'),
	('tarot55', 'Miekkojen kuningatar (Tarot)', 10, 1, 'item_standard', 1, 'nice item'),
	('tarot56', 'Sauvojen kuningatar (Tarot)', 10, 1, 'item_standard', 1, 'nice item'),
	('tarot6', 'Lanttien kakkonen (Tarot)', 10, 1, 'item_standard', 1, 'nice item'),
	('tarot7', 'Miekkojen kakkonen (Tarot)', 10, 1, 'item_standard', 1, 'nice item'),
	('tarot8', 'Sauvojen kakkonen (Tarot)', 10, 1, 'item_standard', 1, 'nice item'),
	('tarot9', 'Maljojen kolmonen (Tarot)', 10, 1, 'item_standard', 1, 'nice item'),
	('tarotpakka', 'Korttipakka (Tarot)', 10, 1, 'item_standard', 1, 'nice item');
/*!40000 ALTER TABLE `items` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
