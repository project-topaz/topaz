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
-- Table structure for table `fishing_fish`
--

DROP TABLE IF EXISTS `fishing_fish`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fishing_fish` (
  `fishid` int(10) unsigned NOT NULL,
  `name` varchar(64) NOT NULL,
  `min_skill_level` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `skill_level` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `size` tinyint(3) unsigned NOT NULL,
  `base_delay` tinyint(2) unsigned NOT NULL,
  `base_move` tinyint(2) unsigned NOT NULL,
  `min_length` smallint(5) unsigned NOT NULL DEFAULT '1',
  `max_length` smallint(5) unsigned NOT NULL DEFAULT '1',
  `size_type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `water_type` tinyint(2) unsigned NOT NULL,
  `log` tinyint(3) unsigned NOT NULL DEFAULT '255',
  `quest` tinyint(3) unsigned NOT NULL DEFAULT '255',
  `flags` int(11) unsigned NOT NULL DEFAULT '0',
  `legendary` int(2) unsigned NOT NULL DEFAULT '0',
  `legendary_flags` int(11) unsigned NOT NULL DEFAULT '0',
  `item` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `max_hook` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `rarity` smallint(5) unsigned NOT NULL DEFAULT '0',
  `required_keyitem` smallint(5) unsigned NOT NULL,
  `required_catches` blob NOT NULL,
  `disabled` tinyint(2) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`fishid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=23;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fishing_fish`
--

LOCK TABLES `fishing_fish` WRITE;
/*!40000 ALTER TABLE `fishing_fish` DISABLE KEYS */;
INSERT INTO `fishing_fish` VALUES (5476,'Abaia',90,100,32,7,13,269,317,1,0,255,255,0,1,0,0,1,500,0,'',0);
INSERT INTO `fishing_fish` VALUES (5455,'Ahtapot',0,90,31,8,7,54,144,1,0,255,255,0,0,0,0,1,500,0,'',0);
INSERT INTO `fishing_fish` VALUES (5461,'Alabaligi',0,37,16,5,11,1,1,0,0,255,255,0,0,0,0,1,0,0,'',0);
INSERT INTO `fishing_fish` VALUES (4316,'Armored Pisces',90,108,31,9,12,52,124,1,0,255,255,0,0,0,0,1,500,0,'',0);
INSERT INTO `fishing_fish` VALUES (688,'Arrowwood Log',0,4,18,13,2,1,1,1,0,255,255,0,0,0,1,1,500,0,'',0);
INSERT INTO `fishing_fish` VALUES (4461,'Bastore Bream',0,86,31,7,9,1,1,0,0,255,255,0,0,0,0,1,250,0,'',0);
INSERT INTO `fishing_fish` VALUES (4360,'Bastore Sardine',0,9,21,11,6,1,1,0,0,255,255,1,0,0,0,3,0,0,'',0);
INSERT INTO `fishing_fish` VALUES (5473,'Bastore Sweeper',0,9,27,10,9,1,1,0,0,255,255,0,0,0,0,1,950,0,'',0);
INSERT INTO `fishing_fish` VALUES (5139,'Betta',0,68,15,10,10,1,1,0,0,255,255,0,0,0,0,1,600,0,'',0);
INSERT INTO `fishing_fish` VALUES (4479,'Bhefhel Marlin',0,61,28,10,11,61,140,1,0,255,255,0,0,0,0,1,700,0,'',0);
INSERT INTO `fishing_fish` VALUES (4318,'Bibiki Urchin',0,3,24,13,1,1,1,0,1,255,255,0,0,0,1,1,100,0,'',0);
INSERT INTO `fishing_fish` VALUES (4314,'Bibikibo',0,8,22,12,3,1,1,0,1,255,255,0,0,0,0,1,850,0,'',0);
INSERT INTO `fishing_fish` VALUES (4429,'Black Eel',0,47,24,5,8,1,1,0,0,255,255,0,0,0,0,1,800,0,'',0);
INSERT INTO `fishing_fish` VALUES (5138,'Black Ghost',0,88,31,9,11,1,1,0,0,255,255,0,0,0,0,1,450,0,'',0);
INSERT INTO `fishing_fish` VALUES (4384,'Black Sole',0,96,33,5,11,1,1,0,0,255,255,0,0,0,0,1,750,0,'',0);
INSERT INTO `fishing_fish` VALUES (4471,'Bladefish',0,71,21,6,12,49,116,1,0,255,255,0,0,0,0,1,750,0,'',0);
INSERT INTO `fishing_fish` VALUES (4313,'Blindfish',0,28,18,6,8,1,1,0,0,255,255,0,0,0,0,1,750,0,'',0);
INSERT INTO `fishing_fish` VALUES (4399,'Bluetail',0,55,24,4,12,1,1,0,0,255,255,0,0,0,0,1,650,0,'',0);
INSERT INTO `fishing_fish` VALUES (5469,'Brass Loach',0,42,17,11,7,1,1,0,0,255,255,0,0,0,0,1,750,0,'',0);
INSERT INTO `fishing_fish` VALUES (5474,'Ca Cuong',0,73,16,12,6,12,1,0,0,255,255,0,0,0,0,1,500,0,'',0);
INSERT INTO `fishing_fish` VALUES (5465,'Caedarva Frog',0,30,17,6,13,1,1,0,0,255,255,0,0,0,0,1,0,0,'',0);
INSERT INTO `fishing_fish` VALUES (4309,'Cave Cherax',90,130,36,7,4,118,232,1,0,255,255,0,1,0,0,1,500,0,'',0);
INSERT INTO `fishing_fish` VALUES (4379,'Cheval Salmon',0,21,21,7,7,1,1,0,0,255,255,0,0,0,0,1,0,0,'',0);
INSERT INTO `fishing_fish` VALUES (4443,'Cobalt Jellyfish',0,5,28,13,0,1,1,0,0,255,255,0,0,0,0,1,0,0,'',0);
INSERT INTO `fishing_fish` VALUES (5128,'Cone Calamary',0,48,40,10,5,1,1,0,0,255,255,1,0,0,0,3,850,0,'',0);
INSERT INTO `fishing_fish` VALUES (4515,'Copper Frog',0,16,22,8,4,1,1,0,0,255,255,0,0,0,0,1,0,0,'',0);
INSERT INTO `fishing_fish` VALUES (13454,'Copper ring',0,3,40,13,2,1,1,0,0,255,255,1,0,0,1,1,800,0,'',0);
INSERT INTO `fishing_fish` VALUES (4580,'Coral Butterfly',0,40,28,10,8,1,1,0,0,255,255,0,0,0,0,1,900,0,'',0);
INSERT INTO `fishing_fish` VALUES (887,'Coral Fragment',0,40,30,13,2,1,1,0,0,255,255,1,0,0,1,1,200,0,'',0);
INSERT INTO `fishing_fish` VALUES (4472,'Crayfish',0,7,24,13,6,1,1,0,0,255,255,0,0,0,0,1,0,0,'',0);
INSERT INTO `fishing_fish` VALUES (4473,'Crescent Fish',0,69,28,7,8,1,1,0,0,255,255,0,0,0,0,1,450,0,'',0);
INSERT INTO `fishing_fish` VALUES (4528,'Crystal Bass',0,35,31,7,12,1,1,0,0,255,255,0,0,0,0,1,0,0,'',0);
INSERT INTO `fishing_fish` VALUES (1210,'Damp Scroll',0,7,15,13,2,1,1,0,0,255,255,0,0,0,1,1,0,0,'',0);
INSERT INTO `fishing_fish` VALUES (4428,'Dark Bass',0,33,23,7,8,1,1,0,0,255,255,0,0,0,0,1,0,0,'',0);
INSERT INTO `fishing_fish` VALUES (5447,'Denizanasi',0,5,28,13,0,1,1,0,0,255,255,0,0,0,0,1,0,0,'',0);
INSERT INTO `fishing_fish` VALUES (5457,'Dil',0,96,33,5,11,1,1,0,0,255,255,0,0,0,0,1,750,0,'',0);
INSERT INTO `fishing_fish` VALUES (4290,'Elshimo Frog',0,30,16,6,13,1,1,0,0,255,255,0,0,0,0,1,0,0,'',0);
INSERT INTO `fishing_fish` VALUES (4579,'Elshimo Newt',0,60,16,8,11,1,1,0,0,255,255,0,0,0,0,1,900,0,'',0);
INSERT INTO `fishing_fish` VALUES (4454,'Emperor Fish',0,91,36,4,13,64,179,1,0,255,255,0,0,0,0,1,200,0,'',0);
INSERT INTO `fishing_fish` VALUES (4501,'Fat Greedie',0,23,18,10,8,1,1,0,1,255,255,0,0,0,0,1,0,0,'',0);
INSERT INTO `fishing_fish` VALUES (12316,'Fish Scale Shield',0,7,15,13,2,1,1,0,0,255,255,0,0,0,1,1,500,0,'',0);
INSERT INTO `fishing_fish` VALUES (4289,'Forest Carp',0,20,21,9,11,1,1,0,0,255,255,0,0,0,0,1,0,0,'',0);
INSERT INTO `fishing_fish` VALUES (5472,'Garpike',0,83,22,11,7,1,1,0,0,255,255,0,0,0,0,1,0,0,'',0);
INSERT INTO `fishing_fish` VALUES (4477,'Gavial Fish',0,81,30,14,15,40,133,1,0,255,255,0,0,0,0,1,550,0,'',0);
INSERT INTO `fishing_fish` VALUES (5471,'Gerrothorax',90,100,38,7,8,210,250,1,0,255,255,0,1,0,0,1,500,0,'',0);
INSERT INTO `fishing_fish` VALUES (4469,'Giant Catfish',0,31,13,6,12,41,126,1,0,255,255,0,0,0,0,1,900,0,'',0);
INSERT INTO `fishing_fish` VALUES (4308,'Giant Chirai',90,110,25,4,15,76,166,1,0,255,255,0,1,0,0,1,500,0,'',0);
INSERT INTO `fishing_fish` VALUES (4306,'Giant Donko',0,50,17,14,8,44,148,1,0,255,255,0,0,0,0,1,900,0,'',0);
INSERT INTO `fishing_fish` VALUES (5475,'Gigant Octopus',0,80,33,6,9,88,167,1,0,255,255,0,0,0,0,1,0,0,'',0);
INSERT INTO `fishing_fish` VALUES (4474,'Gigant Squid',0,91,34,7,13,79,172,1,0,255,255,0,0,0,0,1,100,0,'',0);
INSERT INTO `fishing_fish` VALUES (4427,'Gold Carp',0,56,18,10,14,1,1,0,0,255,255,0,0,0,0,1,750,0,'',0);
INSERT INTO `fishing_fish` VALUES (4383,'Gold Lobster',0,46,35,4,3,1,1,0,0,255,255,1,0,0,0,1,800,0,'',0);
INSERT INTO `fishing_fish` VALUES (4500,'Greedie',0,14,10,7,14,1,1,0,1,255,255,0,0,0,0,1,0,0,'',0);
INSERT INTO `fishing_fish` VALUES (4304,'Grimmonite',0,90,31,8,7,57,144,1,0,255,255,0,0,0,0,1,450,0,'',0);
INSERT INTO `fishing_fish` VALUES (4480,'Gugru Tuna',0,41,16,6,13,39,121,1,1,255,255,16,0,0,0,1,900,0,'',0);
INSERT INTO `fishing_fish` VALUES (5127,'Gugrusaurus',90,140,39,6,5,149,423,1,1,255,255,0,1,7,0,1,700,1977,'',0);
INSERT INTO `fishing_fish` VALUES (5132,'Gurnard',0,16,14,11,9,1,1,0,0,255,255,0,0,0,0,1,550,0,'',0);
INSERT INTO `fishing_fish` VALUES (5449,'Hamsi',0,9,21,11,6,1,1,0,0,255,255,1,0,0,0,3,0,0,'',0);
INSERT INTO `fishing_fish` VALUES (2341,'Hydrogauge',0,7,25,13,2,1,1,0,0,6,25,0,0,0,1,1,0,0,'',0);
INSERT INTO `fishing_fish` VALUES (4470,'Icefish',0,49,24,11,7,1,1,0,0,255,255,0,0,0,0,3,900,0,'',0);
INSERT INTO `fishing_fish` VALUES (5453,'Istakoz',0,46,35,4,3,1,1,0,0,255,255,0,0,0,0,1,0,0,'',0);
INSERT INTO `fishing_fish` VALUES (5136,'Istavrit',0,37,19,11,5,1,1,1,0,255,255,0,0,0,0,1,0,0,'',0);
INSERT INTO `fishing_fish` VALUES (5456,'Istiridye',0,53,27,13,2,1,1,0,0,255,255,0,0,0,0,1,850,0,'',0);
INSERT INTO `fishing_fish` VALUES (4307,'Jungle Catfish',0,80,29,9,11,45,111,1,0,255,255,0,0,0,0,1,500,0,'',0);
INSERT INTO `fishing_fish` VALUES (5448,'Kalamar',0,48,40,10,5,1,1,0,0,255,255,1,0,0,0,3,850,0,'',0);
INSERT INTO `fishing_fish` VALUES (5140,'Kalkanbaligi',90,105,19,6,12,85,116,1,1,255,255,16,1,0,0,1,500,0,'',0);
INSERT INTO `fishing_fish` VALUES (5464,'Kaplumbaga',0,53,28,8,5,1,1,0,0,255,255,0,0,0,0,1,800,0,'',0);
INSERT INTO `fishing_fish` VALUES (5460,'Kayabaligi',0,75,30,7,8,1,1,0,0,255,255,0,0,0,0,1,650,0,'',0);
INSERT INTO `fishing_fish` VALUES (5451,'Kilicbaligi',0,62,26,11,7,1,1,0,0,255,255,0,0,0,0,1,800,0,'',0);
INSERT INTO `fishing_fish` VALUES (5450,'Lakerda',0,41,16,6,13,56,98,1,0,255,255,0,0,0,0,1,900,0,'',0);
INSERT INTO `fishing_fish` VALUES (2216,'Lamp Marimo',0,0,10,13,2,1,1,0,0,255,255,0,0,0,0,1,0,0,'',0);
INSERT INTO `fishing_fish` VALUES (5129,'Lik',90,140,48,2,14,185,465,1,0,255,255,0,1,8,0,1,850,1977,'',0);
INSERT INTO `fishing_fish` VALUES (4315,'Lungfish',0,31,15,10,14,1,1,0,0,255,255,0,0,0,0,1,0,0,'',0);
INSERT INTO `fishing_fish` VALUES (5468,'Matsya',90,110,40,5,12,163,331,1,0,255,255,0,1,0,0,1,500,0,'',0);
INSERT INTO `fishing_fish` VALUES (5467,'Megalodon',0,87,34,10,11,446,625,1,0,255,255,0,0,0,0,1,0,0,'',0);
INSERT INTO `fishing_fish` VALUES (5454,'Mercanbaligi',0,86,31,7,9,1,1,0,0,255,255,0,0,0,0,1,400,0,'',0);
INSERT INTO `fishing_fish` VALUES (4401,'Moat Carp',0,11,16,10,9,1,1,0,0,255,255,0,0,0,0,1,0,0,'',0);
INSERT INTO `fishing_fish` VALUES (1638,'Moblin Mask',0,7,15,13,2,1,1,0,0,255,255,0,0,0,1,1,800,0,'',0);
INSERT INTO `fishing_fish` VALUES (5134,'Mola Mola',90,135,16,12,12,130,184,1,1,255,255,16,1,0,0,1,500,0,'',0);
INSERT INTO `fishing_fish` VALUES (4462,'Monke-Onke',0,51,17,11,9,49,115,1,0,255,255,0,0,0,0,1,550,0,'',0);
INSERT INTO `fishing_fish` VALUES (5121,'Moorish Idol',0,26,18,6,11,1,1,0,1,255,255,0,0,0,0,1,700,0,'',0);
INSERT INTO `fishing_fish` VALUES (5462,'Morinabaligi',0,94,36,4,13,1,1,0,0,255,255,0,0,0,0,1,450,0,'',0);
INSERT INTO `fishing_fish` VALUES (5126,'Muddy Siredon',0,18,23,12,11,1,1,0,0,255,255,0,0,0,0,1,0,0,'',0);
INSERT INTO `fishing_fish` VALUES (16451,'Mythril Dagger',0,7,15,13,2,1,1,0,0,255,255,0,0,0,1,1,80,0,'',0);
INSERT INTO `fishing_fish` VALUES (16537,'Mythril Sword',0,7,15,13,2,1,1,0,0,255,255,0,0,0,1,1,60,0,'',0);
INSERT INTO `fishing_fish` VALUES (4361,'Nebimonite',0,27,30,9,5,1,1,0,1,255,255,0,0,0,0,1,0,0,'',0);
INSERT INTO `fishing_fish` VALUES (4485,'Noble Lady',0,66,30,7,10,1,1,0,1,255,255,0,0,0,0,1,700,0,'',0);
INSERT INTO `fishing_fish` VALUES (1135,'Norg Shell',0,7,15,13,2,1,1,0,0,255,255,0,0,0,1,1,600,0,'',0);
INSERT INTO `fishing_fish` VALUES (4482,'Nosteau Herring',0,39,21,7,8,1,1,0,0,255,255,0,0,0,0,1,950,0,'',0);
INSERT INTO `fishing_fish` VALUES (4481,'Ogre Eel',0,35,29,13,11,1,1,0,0,255,255,0,0,0,0,1,0,0,'',0);
INSERT INTO `fishing_fish` VALUES (624,'Pamtam Kelp',0,5,24,13,2,1,1,0,0,255,255,0,0,0,1,1,0,0,'',0);
INSERT INTO `fishing_fish` VALUES (5125,'Phanauet Newt',0,4,13,10,11,1,1,0,0,255,255,0,0,0,0,1,0,0,'',0);
INSERT INTO `fishing_fish` VALUES (4464,'Pipira',0,29,11,6,14,1,1,0,0,255,255,0,0,0,0,1,0,0,'',0);
INSERT INTO `fishing_fish` VALUES (5470,'Pirarucu',0,89,21,6,11,161,210,1,0,255,255,0,0,0,0,1,0,0,'',0);
INSERT INTO `fishing_fish` VALUES (5133,'Pterygotus',0,99,33,8,7,24,264,1,0,255,255,0,0,0,0,1,400,0,'',0);
INSERT INTO `fishing_fish` VALUES (4514,'Quus',0,19,12,7,11,1,1,0,0,255,255,0,0,0,0,3,0,0,'',0);
INSERT INTO `fishing_fish` VALUES (4402,'Red Terrapin',0,53,28,8,5,1,1,0,0,255,255,0,0,0,0,1,750,0,'',0);
INSERT INTO `fishing_fish` VALUES (5135,'Rhinochimera',0,65,25,11,10,19,40,1,0,255,255,0,0,0,0,1,450,0,'',0);
INSERT INTO `fishing_fish` VALUES (90,'Rusty Bucket',0,1,19,13,2,1,1,0,0,255,255,9,0,0,1,1,900,0,'',0);
INSERT INTO `fishing_fish` VALUES (12522,'Rusty Cap',0,30,38,13,2,1,1,0,0,255,255,9,0,0,1,1,800,0,'',0);
INSERT INTO `fishing_fish` VALUES (16606,'Rusty Greatsword',0,7,15,13,2,1,1,0,0,255,255,8,0,0,1,1,400,0,'',0);
INSERT INTO `fishing_fish` VALUES (14117,'Rusty Leggings',0,7,26,13,2,1,1,0,0,255,255,9,0,0,1,1,500,0,'',0);
INSERT INTO `fishing_fish` VALUES (16655,'Rusty Pick',0,7,15,13,2,1,1,0,0,255,255,8,0,0,1,1,400,0,'',0);
INSERT INTO `fishing_fish` VALUES (14242,'Rusty Subligar',0,5,22,13,2,1,1,0,0,255,255,8,0,0,1,1,500,0,'',0);
INSERT INTO `fishing_fish` VALUES (4305,'Ryugu Titan',90,150,48,1,15,214,485,1,1,255,255,0,1,0,0,1,700,0,'',0);
INSERT INTO `fishing_fish` VALUES (4291,'Sandfish',0,50,36,3,10,1,1,0,0,255,255,1,0,0,0,3,0,0,'',0);
INSERT INTO `fishing_fish` VALUES (5459,'Sazanbaligi',0,56,18,10,14,1,1,0,0,255,255,0,0,0,0,1,650,0,'',0);
INSERT INTO `fishing_fish` VALUES (4475,'Sea Zombie',90,100,39,3,15,79,192,1,1,255,255,0,1,0,0,1,700,0,'',0);
INSERT INTO `fishing_fish` VALUES (4484,'Shall Shell',0,53,27,13,2,1,1,0,0,255,255,0,0,0,0,1,600,0,'',0);
INSERT INTO `fishing_fish` VALUES (4354,'Shining Trout',0,37,16,5,11,1,1,0,0,255,255,0,0,0,0,1,0,0,'',0);
INSERT INTO `fishing_fish` VALUES (13456,'Silver Ring',0,7,40,13,2,1,1,0,0,255,255,1,0,0,1,1,300,0,'',0);
INSERT INTO `fishing_fish` VALUES (4451,'Silver Shark',0,76,35,3,9,1,1,0,0,255,255,0,0,0,0,1,500,0,'',0);
INSERT INTO `fishing_fish` VALUES (4463,'Takitaro',90,101,18,3,14,59,127,1,0,255,255,16,1,0,0,1,500,0,'',0);
INSERT INTO `fishing_fish` VALUES (5130,'Tavnazian Goby',0,75,30,7,8,1,1,0,0,255,255,0,0,0,0,1,850,0,'',0);
INSERT INTO `fishing_fish` VALUES (4478,'Three-Eyed Fish',0,79,25,10,10,50,117,1,0,255,255,0,0,0,0,1,500,0,'',0);
INSERT INTO `fishing_fish` VALUES (4483,'Tiger Cod',0,29,23,9,9,1,1,0,0,255,255,0,0,0,0,1,0,0,'',0);
INSERT INTO `fishing_fish` VALUES (4310,'Tiny Goldfish',0,20,22,0,14,1,1,0,0,255,255,0,0,0,0,3,0,0,'',0);
INSERT INTO `fishing_fish` VALUES (5120,'Titanic Sawfish',90,125,39,6,13,86,145,1,1,255,255,0,1,0,0,1,500,0,'',0);
INSERT INTO `fishing_fish` VALUES (4476,'Titanictus',90,101,35,3,12,79,209,1,1,255,255,0,1,0,0,1,500,0,'',0);
INSERT INTO `fishing_fish` VALUES (4426,'Tricolored Carp',0,27,19,12,12,1,1,0,0,255,255,0,0,0,0,1,0,0,'',0);
INSERT INTO `fishing_fish` VALUES (4319,'Tricorn',90,100,25,11,9,109,181,1,0,255,255,0,1,0,0,1,500,0,'',0);
INSERT INTO `fishing_fish` VALUES (4317,'Trilobite',0,59,27,5,6,1,1,0,1,255,255,0,0,0,0,1,0,0,'',0);
INSERT INTO `fishing_fish` VALUES (5466,'Trumpet Shell',0,63,15,10,5,1,1,0,0,255,255,0,0,0,0,1,550,0,'',0);
INSERT INTO `fishing_fish` VALUES (5137,'Turnabaligi',0,96,15,7,12,75,174,1,0,255,255,16,0,0,0,1,450,0,'',0);
INSERT INTO `fishing_fish` VALUES (5452,'Uskumru',0,55,24,4,12,1,1,0,0,255,255,0,0,0,0,1,550,0,'',0);
INSERT INTO `fishing_fish` VALUES (5141,'Veydal Wrasse',0,35,18,11,5,50,124,1,0,255,255,0,0,0,0,1,400,0,'',0);
INSERT INTO `fishing_fish` VALUES (5131,'Vongola Clam',0,53,20,8,4,1,1,0,1,255,255,0,0,0,0,1,900,0,'',0);
INSERT INTO `fishing_fish` VALUES (5463,'Yayinbaligi',0,31,13,6,12,41,126,1,0,255,255,0,0,0,0,1,900,0,'',0);
INSERT INTO `fishing_fish` VALUES (4403,'Yellow Globe',0,17,17,8,8,1,1,0,0,255,255,0,0,0,0,3,0,0,'',0);
INSERT INTO `fishing_fish` VALUES (5458,'Yilanbaligi',0,47,24,5,8,1,1,0,0,255,255,0,0,0,0,1,800,0,'',0);
INSERT INTO `fishing_fish` VALUES (4385,'Zafmlug Bass',0,48,27,6,7,1,1,0,0,255,255,0,0,0,0,1,0,0,'',0);
INSERT INTO `fishing_fish` VALUES (4288,'Zebra Eel',0,71,24,10,10,1,1,0,0,255,255,0,0,0,0,1,800,0,'',0);
INSERT INTO `fishing_fish` VALUES (1624,'Bugbear Mask',0,7,15,13,2,1,1,0,0,255,255,0,0,0,1,1,700,0,'',0);
INSERT INTO `fishing_fish` VALUES (3965,'Adoulinian Kelp',0,5,24,13,2,1,1,0,0,255,255,0,0,0,1,1,0,0,'',0);
INSERT INTO `fishing_fish` VALUES (591,'Ripped cap',0,1,10,13,2,1,1,0,0,2,23,0,0,0,1,1,0,0,'',0);
INSERT INTO `fishing_fish` VALUES (65535,'Gil',0,7,15,13,2,1,1,0,0,255,255,0,0,0,1,1,0,0,'',0);
/*!40000 ALTER TABLE `fishing_fish` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-12-26 10:06:40
