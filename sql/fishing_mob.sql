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
-- Table structure for table `fishing_mob`
--

DROP TABLE IF EXISTS `fishing_mob`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fishing_mob` (
  `mobid` int(10) unsigned NOT NULL,
  `name` varchar(64) NOT NULL,
  `zoneid` smallint(5) unsigned NOT NULL,
  `level` tinyint(3) unsigned NOT NULL,
  `size` tinyint(3) unsigned NOT NULL,
  `base_delay` tinyint(2) unsigned NOT NULL,
  `base_move` tinyint(2) unsigned NOT NULL,
  `log` tinyint(3) unsigned NOT NULL DEFAULT '255',
  `quest` tinyint(3) unsigned NOT NULL DEFAULT '255',
  `nm` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `nm_flags` int(11) unsigned NOT NULL DEFAULT '0',
  `areaid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `rarity` smallint(5) unsigned NOT NULL DEFAULT '0',
  `min_respawn` int(10) unsigned NOT NULL DEFAULT '0',
  `required_lureid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `required_key_item` smallint(5) unsigned NOT NULL DEFAULT '0',
  `disabled` tinyint(2) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`mobid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fishing_mob`
--

LOCK TABLES `fishing_mob` WRITE;
/*!40000 ALTER TABLE `fishing_mob` DISABLE KEYS */;
INSERT INTO `fishing_mob` VALUES (17252353,'Palm_Crab',116,10,16,14,15,255,255,0,0,0,0,0,0,0,0);
INSERT INTO `fishing_mob` VALUES (17252354,'Savanna_Crab',116,20,15,11,15,255,255,0,0,0,0,0,0,0,0);
INSERT INTO `fishing_mob` VALUES (17252355,'Mud_Pugil',116,30,16,10,15,255,255,0,0,0,0,0,0,0,0);
INSERT INTO `fishing_mob` VALUES (17252356,'Pug_Pugil',116,40,17,9,15,255,255,0,0,0,0,0,0,0,0);
INSERT INTO `fishing_mob` VALUES (17252357,'Fighting_Pugil',116,50,19,8,15,255,255,0,0,0,0,0,0,0,0);
INSERT INTO `fishing_mob` VALUES (17396141,'Odontotyrannus',151,20,15,10,15,0,91,1,0,1,0,0,17001,0,0);
INSERT INTO `fishing_mob` VALUES (17489921,'Scavenger Crab',174,20,15,11,15,255,255,0,0,0,0,0,0,0,0);
INSERT INTO `fishing_mob` VALUES (17489922,'Scavenger Crab',174,20,15,11,15,255,255,0,0,0,0,0,0,0,0);
INSERT INTO `fishing_mob` VALUES (17489923,'Stygian Pugil',174,30,16,10,15,255,255,0,0,0,0,0,0,0,0);
INSERT INTO `fishing_mob` VALUES (17489924,'Stygian Pugil',174,30,16,10,15,255,255,0,0,0,0,0,0,0,0);
INSERT INTO `fishing_mob` VALUES (17489925,'Devil Manta',174,50,19,8,15,255,255,1,106,1,0,600,0,0,0);
INSERT INTO `fishing_mob` VALUES (17678337,'Sea Pugil',220,10,16,14,15,255,255,0,0,0,0,0,0,0,0);
INSERT INTO `fishing_mob` VALUES (17678338,'Ocean Crab',220,40,17,9,15,255,255,0,0,0,0,0,0,0,0);
INSERT INTO `fishing_mob` VALUES (17678339,'Ocean Pugil',220,30,16,10,15,255,255,0,0,0,0,0,0,0,0);
INSERT INTO `fishing_mob` VALUES (17678340,'Pirate Pugil',220,40,17,9,15,255,255,0,0,0,0,0,0,0,0);
INSERT INTO `fishing_mob` VALUES (17682433,'Sea Pugil',221,10,16,14,15,255,255,0,0,0,0,0,0,0,0);
INSERT INTO `fishing_mob` VALUES (17682434,'Ocean Crab',221,40,17,9,15,255,255,0,0,0,0,0,0,0,0);
INSERT INTO `fishing_mob` VALUES (17682435,'Ocean Pugil',221,30,16,10,15,255,255,0,0,0,0,0,0,0,0);
INSERT INTO `fishing_mob` VALUES (17682436,'Pirate Pugil',221,40,17,9,15,255,255,0,0,0,0,0,0,0,0);
/*!40000 ALTER TABLE `fishing_mob` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-12-02 20:00:44
