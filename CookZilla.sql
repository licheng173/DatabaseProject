create database CookZilla;
use CookZilla;
-- MySQL dump 10.13  Distrib 5.7.9, for osx10.9 (x86_64)
--
-- Host: localhost    Database: CookZilla
-- ------------------------------------------------------
-- Server version	5.7.11

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
-- Table structure for table `Event`
--

DROP TABLE IF EXISTS `Event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Event` (
  `eid` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `gid` int(11) unsigned NOT NULL,
  `etime` datetime NOT NULL,
  `elocation` varchar(45) NOT NULL,
  `edescription` text,
  PRIMARY KEY (`eid`),
  KEY `gid` (`gid`),
  CONSTRAINT `gid_Event_GGroup` FOREIGN KEY (`gid`) REFERENCES `GGroup` (`gid`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Event`
--

LOCK TABLES `Event` WRITE;
/*!40000 ALTER TABLE `Event` DISABLE KEYS */;
INSERT INTO `Event` VALUES (1,1,'2016-11-15 10:16:38','central park',NULL),(2,2,'2016-11-09 14:13:06','bryant park',NULL),(3,1,'2016-12-15 08:17:05','Wall Street',NULL),(4,1,'2016-11-25 11:05:02','Roosevelt Island','llala'),(5,1,'2016-11-26 00:00:00','brooklyn bridge','cool');
/*!40000 ALTER TABLE `Event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GGroup`
--

DROP TABLE IF EXISTS `GGroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `GGroup` (
  `gid` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `gname` varchar(45) NOT NULL,
  `gnumber` int(11) unsigned DEFAULT NULL,
  `gdescription` text,
  PRIMARY KEY (`gid`),
  UNIQUE KEY `gname` (`gname`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GGroup`
--

LOCK TABLES `GGroup` WRITE;
/*!40000 ALTER TABLE `GGroup` DISABLE KEYS */;
INSERT INTO `GGroup` VALUES (1,'Park Slope Cake Club',NULL,NULL),(2,'Some forks',NULL,NULL);
/*!40000 ALTER TABLE `GGroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Ingredient`
--

DROP TABLE IF EXISTS `Ingredient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Ingredient` (
  `rid` int(11) unsigned NOT NULL,
  `iname` varchar(45) NOT NULL,
  `iquantity` int(11) unsigned NOT NULL,
  PRIMARY KEY (`rid`,`iname`),
  CONSTRAINT `rid_Ingredient_Recipe` FOREIGN KEY (`rid`) REFERENCES `Recipe` (`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Ingredient`
--

LOCK TABLES `Ingredient` WRITE;
/*!40000 ALTER TABLE `Ingredient` DISABLE KEYS */;
INSERT INTO `Ingredient` VALUES (7,'sugar',200);
/*!40000 ALTER TABLE `Ingredient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Join_Group`
--

DROP TABLE IF EXISTS `Join_Group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Join_Group` (
  `uid` int(11) unsigned NOT NULL,
  `gid` int(11) unsigned NOT NULL,
  PRIMARY KEY (`uid`,`gid`),
  KEY `uid_JG_GGroup` (`gid`),
  CONSTRAINT `uid_JG_GGroup` FOREIGN KEY (`gid`) REFERENCES `GGroup` (`gid`),
  CONSTRAINT `uid_JG_User` FOREIGN KEY (`uid`) REFERENCES `User` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Join_Group`
--

LOCK TABLES `Join_Group` WRITE;
/*!40000 ALTER TABLE `Join_Group` DISABLE KEYS */;
INSERT INTO `Join_Group` VALUES (1,1),(2,1),(3,1),(4,1),(1,2),(3,2),(4,2);
/*!40000 ALTER TABLE `Join_Group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Link_Recipe`
--

DROP TABLE IF EXISTS `Link_Recipe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Link_Recipe` (
  `rid` int(11) unsigned NOT NULL,
  `rid_link` int(11) unsigned NOT NULL,
  PRIMARY KEY (`rid`,`rid_link`),
  KEY `rid_link_LR_Recipe` (`rid_link`),
  CONSTRAINT `rid_LR_Recipe` FOREIGN KEY (`rid`) REFERENCES `Recipe` (`rid`),
  CONSTRAINT `rid_link_LR_Recipe` FOREIGN KEY (`rid_link`) REFERENCES `Recipe` (`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Link_Recipe`
--

LOCK TABLES `Link_Recipe` WRITE;
/*!40000 ALTER TABLE `Link_Recipe` DISABLE KEYS */;
INSERT INTO `Link_Recipe` VALUES (8,3),(6,7),(4,9),(5,9),(3,10);
/*!40000 ALTER TABLE `Link_Recipe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Rate`
--

DROP TABLE IF EXISTS `Rate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Rate` (
  `rank` int(1) unsigned NOT NULL,
  PRIMARY KEY (`rank`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Rate`
--

LOCK TABLES `Rate` WRITE;
/*!40000 ALTER TABLE `Rate` DISABLE KEYS */;
INSERT INTO `Rate` VALUES (1),(2),(3),(4),(5);
/*!40000 ALTER TABLE `Rate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Recipe`
--

DROP TABLE IF EXISTS `Recipe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Recipe` (
  `rid` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) unsigned NOT NULL,
  `rtitle` varchar(45) NOT NULL,
  `rserving` int(2) unsigned NOT NULL,
  `rdescription` text NOT NULL,
  PRIMARY KEY (`rid`),
  KEY `uid` (`uid`),
  CONSTRAINT `uid_Recipe_User` FOREIGN KEY (`uid`) REFERENCES `User` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Recipe`
--

LOCK TABLES `Recipe` WRITE;
/*!40000 ALTER TABLE `Recipe` DISABLE KEYS */;
INSERT INTO `Recipe` VALUES (3,1,'Good Stuff',2,'broccoli with shrimp'),(4,3,'Zuo Zong Ji',3,'it is actually chicken broccoli.'),(5,5,'Tasty Soup ',1,'Cheese Soup'),(6,2,'cool food',3,'Broccoli fried rice.'),(7,2,'Key lime pie',2,'Key lime pie, cake.'),(8,4,'Grandma’s Fettuccini Alfredo',3,'nobody know what that is'),(9,2,'Some fish dish',2,'mainly tuna, some vegetables'),(10,3,'Daddy\'s secret dish',3,'lots of tuna');
/*!40000 ALTER TABLE `Recipe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Recipe_Picture`
--

DROP TABLE IF EXISTS `Recipe_Picture`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Recipe_Picture` (
  `pid` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `rid` int(11) unsigned NOT NULL,
  `content` mediumblob NOT NULL,
  PRIMARY KEY (`pid`),
  KEY `rid` (`rid`),
  CONSTRAINT `rid_RP_Recipe` FOREIGN KEY (`rid`) REFERENCES `Recipe` (`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Recipe_Picture`
--

LOCK TABLES `Recipe_Picture` WRITE;
/*!40000 ALTER TABLE `Recipe_Picture` DISABLE KEYS */;
/*!40000 ALTER TABLE `Recipe_Picture` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Recipe_Tag`
--

DROP TABLE IF EXISTS `Recipe_Tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Recipe_Tag` (
  `rid` int(11) unsigned NOT NULL,
  `tid` int(11) unsigned NOT NULL,
  PRIMARY KEY (`rid`,`tid`),
  KEY `tid_RT_Tag` (`tid`),
  CONSTRAINT `rid_RT_Recipe` FOREIGN KEY (`rid`) REFERENCES `Recipe` (`rid`),
  CONSTRAINT `tid_RT_Tag` FOREIGN KEY (`tid`) REFERENCES `Tag` (`tid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Recipe_Tag`
--

LOCK TABLES `Recipe_Tag` WRITE;
/*!40000 ALTER TABLE `Recipe_Tag` DISABLE KEYS */;
INSERT INTO `Recipe_Tag` VALUES (3,1),(6,1),(4,2),(5,4),(7,6);
/*!40000 ALTER TABLE `Recipe_Tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Report`
--

DROP TABLE IF EXISTS `Report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Report` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) unsigned NOT NULL,
  `eid` int(11) unsigned NOT NULL,
  `content` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  KEY `eid` (`eid`),
  CONSTRAINT `eid_Report_Event` FOREIGN KEY (`eid`) REFERENCES `Event` (`eid`),
  CONSTRAINT `uid_Report_User` FOREIGN KEY (`uid`) REFERENCES `User` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Report`
--

LOCK TABLES `Report` WRITE;
/*!40000 ALTER TABLE `Report` DISABLE KEYS */;
INSERT INTO `Report` VALUES (1,1,2,'interesting'),(2,2,4,'not bad'),(3,3,3,'had a good day');
/*!40000 ALTER TABLE `Report` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Report_Photo`
--

DROP TABLE IF EXISTS `Report_Photo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Report_Photo` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `rpid` int(11) unsigned NOT NULL,
  `photo` mediumblob NOT NULL,
  PRIMARY KEY (`id`),
  KEY `rpid` (`rpid`),
  CONSTRAINT `rpid_RP_Report` FOREIGN KEY (`rpid`) REFERENCES `Report` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Report_Photo`
--

LOCK TABLES `Report_Photo` WRITE;
/*!40000 ALTER TABLE `Report_Photo` DISABLE KEYS */;
/*!40000 ALTER TABLE `Report_Photo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Reserve`
--

DROP TABLE IF EXISTS `Reserve`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Reserve` (
  `eid` int(11) unsigned NOT NULL,
  `uid` int(11) unsigned NOT NULL,
  PRIMARY KEY (`eid`,`uid`),
  KEY `uid_Reserve_User` (`uid`),
  CONSTRAINT `eid_Reserve_Event` FOREIGN KEY (`eid`) REFERENCES `Event` (`eid`),
  CONSTRAINT `uid_Reserve_User` FOREIGN KEY (`uid`) REFERENCES `User` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Reserve`
--

LOCK TABLES `Reserve` WRITE;
/*!40000 ALTER TABLE `Reserve` DISABLE KEYS */;
INSERT INTO `Reserve` VALUES (2,1),(5,1),(4,2),(1,3),(2,3),(3,3),(4,3),(5,3),(1,4),(2,4);
/*!40000 ALTER TABLE `Reserve` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Review`
--

DROP TABLE IF EXISTS `Review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Review` (
  `r_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `rid` int(11) unsigned NOT NULL,
  `uid` int(11) unsigned NOT NULL,
  `rrate` int(1) unsigned DEFAULT NULL,
  `rtext` text NOT NULL,
  `rvtitle` varchar(45) NOT NULL,
  PRIMARY KEY (`r_id`),
  KEY `rid` (`rid`),
  KEY `rrate` (`rrate`),
  KEY `uid` (`uid`),
  CONSTRAINT `rid_Review_Recipe` FOREIGN KEY (`rid`) REFERENCES `Recipe` (`rid`),
  CONSTRAINT `rrate_Review_Rate` FOREIGN KEY (`rrate`) REFERENCES `Rate` (`rank`),
  CONSTRAINT `uid_Review_User` FOREIGN KEY (`uid`) REFERENCES `User` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Review`
--

LOCK TABLES `Review` WRITE;
/*!40000 ALTER TABLE `Review` DISABLE KEYS */;
INSERT INTO `Review` VALUES (2,8,3,5,'Really, really, tasty!','Yummy!'),(3,8,3,5,'Really, really, tasty!','Yummy!'),(4,9,1,4,'good',''),(5,9,5,3,'not bad',''),(6,10,1,3,'ok',''),(7,10,2,1,'awful','');
/*!40000 ALTER TABLE `Review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Review_Photo`
--

DROP TABLE IF EXISTS `Review_Photo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Review_Photo` (
  `p_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `r_id` int(11) unsigned NOT NULL,
  `photo` mediumblob NOT NULL,
  PRIMARY KEY (`p_id`),
  KEY `r_id` (`r_id`),
  CONSTRAINT `r_id_RP_Review` FOREIGN KEY (`r_id`) REFERENCES `Review` (`r_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Review_Photo`
--

LOCK TABLES `Review_Photo` WRITE;
/*!40000 ALTER TABLE `Review_Photo` DISABLE KEYS */;
/*!40000 ALTER TABLE `Review_Photo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Review_Suggestion`
--

DROP TABLE IF EXISTS `Review_Suggestion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Review_Suggestion` (
  `sid` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `r_id` int(11) unsigned NOT NULL,
  `content` text NOT NULL,
  PRIMARY KEY (`sid`),
  KEY `r_id` (`r_id`),
  CONSTRAINT `r_id_RS_Review` FOREIGN KEY (`r_id`) REFERENCES `Review` (`r_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Review_Suggestion`
--

LOCK TABLES `Review_Suggestion` WRITE;
/*!40000 ALTER TABLE `Review_Suggestion` DISABLE KEYS */;
INSERT INTO `Review_Suggestion` VALUES (1,4,'less water'),(2,5,'more spicy'),(3,5,'less sugar');
/*!40000 ALTER TABLE `Review_Suggestion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Tag`
--

DROP TABLE IF EXISTS `Tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Tag` (
  `tid` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ttitle` varchar(20) NOT NULL,
  PRIMARY KEY (`tid`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Tag`
--

LOCK TABLES `Tag` WRITE;
/*!40000 ALTER TABLE `Tag` DISABLE KEYS */;
INSERT INTO `Tag` VALUES (1,'italian'),(2,'chinese'),(3,'vegan'),(4,'soup'),(5,'spicy'),(6,'cake');
/*!40000 ALTER TABLE `Tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Unit_Conversion`
--

DROP TABLE IF EXISTS `Unit_Conversion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Unit_Conversion` (
  `unit_name` varchar(20) NOT NULL,
  `quantity_in_gram` double unsigned NOT NULL,
  PRIMARY KEY (`unit_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Unit_Conversion`
--

LOCK TABLES `Unit_Conversion` WRITE;
/*!40000 ALTER TABLE `Unit_Conversion` DISABLE KEYS */;
INSERT INTO `Unit_Conversion` VALUES ('ounce',28.3),('pinch',0.25),('teaspoon',5);
/*!40000 ALTER TABLE `Unit_Conversion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `User` (
  `uid` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uname` varchar(45) NOT NULL,
  `upassword` varchar(45) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `uprofile` text,
  PRIMARY KEY (`uid`),
  UNIQUE KEY `uname` (`uname`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User`
--

LOCK TABLES `User` WRITE;
/*!40000 ALTER TABLE `User` DISABLE KEYS */;
INSERT INTO `User` VALUES (1,'lululiu008','123456','Yiwei Liu',NULL),(2,'licheng173','123456','Cheng Li',NULL),(3,'fgl','123456','Gulin Fu',NULL),(4,'cl','asdf','Changyuan Li',NULL),(5,'yds','df34ty','Yandong Sun',NULL);
/*!40000 ALTER TABLE `User` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-11-18 19:31:04
