-- MySQL dump 10.16  Distrib 10.1.36-MariaDB, for Win32 (AMD64)
--
-- Host: localhost    Database: dspfish
-- ------------------------------------------------------
-- Server version	10.1.36-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `fishing_rod`
--

DROP TABLE IF EXISTS `fishing_rod`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fishing_rod` (
  `rodid` int(10) unsigned NOT NULL,
  `name` varchar(64) NOT NULL,
  `material` tinyint(2) unsigned NOT NULL,
  `size_type` tinyint(3) unsigned NOT NULL,
  `flags` int(11) unsigned NOT NULL DEFAULT '0',
  `durability` tinyint(3) unsigned NOT NULL DEFAULT '10',
  `fish_attack` tinyint(3) unsigned NOT NULL,
  `lgd_bonus_attack` tinyint(3) unsigned NOT NULL,
  `miss_regen` tinyint(3) unsigned NOT NULL,
  `lgd_miss_regen` tinyint(3) unsigned NOT NULL,
  `fish_time` tinyint(3) unsigned NOT NULL,
  `lgd_bonus_time` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `sm_delay_bonus` tinyint(2) unsigned NOT NULL,
  `sm_move_bonus` tinyint(2) unsigned NOT NULL,
  `lg_delay_bonus` tinyint(2) unsigned NOT NULL,
  `lg_move_bonus` tinyint(2) unsigned NOT NULL,
  `multiplier` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `breakable` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `broken_rodid` int(10) unsigned NOT NULL,
  `mmm` tinyint(2) unsigned NOT NULL,
  PRIMARY KEY (`rodid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fishing_rod`
--

LOCK TABLES `fishing_rod` WRITE;
/*!40000 ALTER TABLE `fishing_rod` DISABLE KEYS */;
INSERT INTO `fishing_rod` VALUES (17011,'Ebisu Fishing Rod',1,2,4,40,0,50,50,125,30,10,2,1,1,0,3,0,0,0);
INSERT INTO `fishing_rod` VALUES (17012,'Judges Rod',1,2,0,50,100,100,10,50,60,30,2,1,1,0,5,0,0,0);
INSERT INTO `fishing_rod` VALUES (17014,'Hume Fishing Rod',0,0,2,22,25,0,90,0,30,0,2,1,0,2,3,1,1832,0);
INSERT INTO `fishing_rod` VALUES (17015,'Halcyon Rod',1,0,2,26,0,0,50,0,41,0,2,1,0,2,3,1,1833,0);
INSERT INTO `fishing_rod` VALUES (17380,'Mithran Fishing Rod',0,1,1,32,30,0,65,0,30,0,0,0,1,0,3,1,483,0);
INSERT INTO `fishing_rod` VALUES (17381,'Composite Fishing Rod',1,1,1,34,0,0,50,0,43,0,0,0,1,0,2,1,473,0);
INSERT INTO `fishing_rod` VALUES (17382,'Single Hook Fishing Rod',1,1,1,30,0,0,50,0,45,0,0,0,1,0,3,1,472,0);
INSERT INTO `fishing_rod` VALUES (17383,'Clothespole',0,1,1,28,70,0,70,0,30,0,0,0,1,0,3,1,482,0);
INSERT INTO `fishing_rod` VALUES (17384,'Carbon Fishing Rod',1,0,0,20,0,0,50,0,43,0,2,1,1,0,4,1,490,0);
INSERT INTO `fishing_rod` VALUES (17385,'Glass Fiber Fishing Rod',1,0,0,24,0,0,50,0,45,0,2,1,1,0,4,1,491,0);
INSERT INTO `fishing_rod` VALUES (17386,'Lu Shang\'s Fishing Rod',0,2,0,38,10,20,120,110,40,10,2,1,1,0,2,1,489,0);
INSERT INTO `fishing_rod` VALUES (17387,'Tarutaru Fishing Rod',0,0,0,18,30,0,80,0,30,0,2,1,1,0,4,1,484,0);
INSERT INTO `fishing_rod` VALUES (17388,'Fastwater Fishing Rod',0,0,0,16,35,0,75,0,30,0,2,1,1,0,2,1,488,0);
INSERT INTO `fishing_rod` VALUES (17389,'Bamboo Fishing Rod',0,0,0,14,40,0,70,0,30,0,2,1,1,0,2,1,487,0);
INSERT INTO `fishing_rod` VALUES (17390,'Yew Fishing Rod',0,0,0,10,45,0,55,0,30,0,2,1,1,0,2,1,486,0);
INSERT INTO `fishing_rod` VALUES (17391,'Willow Fishing Rod',0,0,0,12,50,0,50,0,30,0,2,1,1,0,2,1,485,0);
INSERT INTO `fishing_rod` VALUES (19319,'Maze Monger Fishing Rod',1,2,0,30,0,0,100,0,30,0,2,1,1,10,2,1,2526,1);
INSERT INTO `fishing_rod` VALUES (19320,'Lu Shang\'s Fishing Rod +1',0,2,0,38,10,20,120,110,50,10,2,1,1,0,2,1,9091,0);
INSERT INTO `fishing_rod` VALUES (19321,'Ebisu Fishing Rod +1',1,2,4,40,0,50,50,125,40,10,2,1,1,0,3,0,0,0);
/*!40000 ALTER TABLE `fishing_rod` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-12-17 13:47:01
