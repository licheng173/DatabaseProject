create database CookZilla;
use CookZilla;
-- MySQL dump 10.13  Distrib 5.7.11, for osx10.9 (x86_64)
--
-- Host: localhost    Database: cookzilla
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
  `gid` varchar(13) NOT NULL,
  `etime` datetime NOT NULL,
  `elocation` varchar(45) NOT NULL,
  `edescription` text,
  `ecuid` int(11) unsigned DEFAULT NULL,
  `etitle` varchar(45) NOT NULL,
  PRIMARY KEY (`eid`),
  KEY `gid` (`gid`),
  KEY `ecuid` (`ecuid`),
  CONSTRAINT `ecuid_event_user` FOREIGN KEY (`ecuid`) REFERENCES `User` (`uid`) ON DELETE SET NULL ON UPDATE SET NULL,
  CONSTRAINT `gid_event_ggroup` FOREIGN KEY (`gid`) REFERENCES `GGroup` (`gid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `GGroup`
--

DROP TABLE IF EXISTS `GGroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `GGroup` (
  `gid` varchar(13) NOT NULL,
  `gname` varchar(45) NOT NULL,
  `cuid` int(11) unsigned DEFAULT NULL,
  `gdescription` text,
  PRIMARY KEY (`gid`),
  UNIQUE KEY `gname` (`gname`),
  KEY `uid` (`cuid`),
  CONSTRAINT `uid_ggroup_user` FOREIGN KEY (`cuid`) REFERENCES `User` (`uid`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Ingredient`
--

DROP TABLE IF EXISTS `Ingredient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Ingredient` (
  `rid` varchar(13) NOT NULL,
  `iname` varchar(45) NOT NULL,
  `iquantity` double unsigned NOT NULL,
  PRIMARY KEY (`rid`,`iname`),
  CONSTRAINT `rid_ingredient_recipe` FOREIGN KEY (`rid`) REFERENCES `Recipe` (`rid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Join_Group`
--

DROP TABLE IF EXISTS `Join_Group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Join_Group` (
  `uid` int(11) unsigned NOT NULL,
  `gid` varchar(13) NOT NULL,
  PRIMARY KEY (`uid`,`gid`),
  KEY `uid_JG_GGroup` (`gid`),
  CONSTRAINT `gid_JG_ggroup` FOREIGN KEY (`gid`) REFERENCES `GGroup` (`gid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `uid_JG_User` FOREIGN KEY (`uid`) REFERENCES `User` (`uid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Link_Recipe`
--

DROP TABLE IF EXISTS `Link_Recipe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Link_Recipe` (
  `rid` varchar(13) NOT NULL,
  `rid_link` varchar(13) NOT NULL,
  PRIMARY KEY (`rid`,`rid_link`),
  KEY `rid_link_LR_Recipe` (`rid_link`),
  CONSTRAINT `rid_lr_recipe` FOREIGN KEY (`rid`) REFERENCES `Recipe` (`rid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ridl_lr_recipe` FOREIGN KEY (`rid_link`) REFERENCES `Recipe` (`rid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

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
-- Table structure for table `Recipe`
--

DROP TABLE IF EXISTS `Recipe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Recipe` (
  `rid` varchar(13) NOT NULL,
  `uid` int(11) unsigned NOT NULL,
  `rtitle` varchar(45) NOT NULL,
  `rserving` int(2) unsigned NOT NULL,
  `rdescription` text NOT NULL,
  PRIMARY KEY (`rid`),
  KEY `uid` (`uid`),
  CONSTRAINT `uid_Recipe_User` FOREIGN KEY (`uid`) REFERENCES `User` (`uid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Recipe_Picture`
--

DROP TABLE IF EXISTS `Recipe_Picture`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Recipe_Picture` (
  `pid` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `rid` varchar(13) NOT NULL,
  `content` mediumblob NOT NULL,
  PRIMARY KEY (`pid`),
  KEY `rid` (`rid`),
  CONSTRAINT `rid_rp_recipe` FOREIGN KEY (`rid`) REFERENCES `Recipe` (`rid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Recipe_Tag`
--

DROP TABLE IF EXISTS `Recipe_Tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Recipe_Tag` (
  `rid` varchar(13) NOT NULL,
  `tid` int(11) unsigned NOT NULL,
  PRIMARY KEY (`rid`,`tid`),
  KEY `tid_RT_Tag` (`tid`),
  CONSTRAINT `rid_rt_recipe` FOREIGN KEY (`rid`) REFERENCES `Recipe` (`rid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tid_RT_Tag` FOREIGN KEY (`tid`) REFERENCES `Tag` (`tid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Recipe_View`
--

DROP TABLE IF EXISTS `Recipe_View`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Recipe_View` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) unsigned NOT NULL,
  `rid` varchar(13) NOT NULL,
  `vtime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  KEY `rid` (`rid`),
  CONSTRAINT `rid_RV_Recipe` FOREIGN KEY (`rid`) REFERENCES `Recipe` (`rid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `uid_RV_User` FOREIGN KEY (`uid`) REFERENCES `User` (`uid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Report`
--

DROP TABLE IF EXISTS `Report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Report` (
  `id` varchar(13) NOT NULL,
  `uid` int(11) unsigned NOT NULL,
  `eid` int(11) unsigned NOT NULL,
  `content` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  KEY `eid` (`eid`),
  CONSTRAINT `eid_Report_Event` FOREIGN KEY (`eid`) REFERENCES `Event` (`eid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `uid_Report_User` FOREIGN KEY (`uid`) REFERENCES `User` (`uid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Report_Photo`
--

DROP TABLE IF EXISTS `Report_Photo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Report_Photo` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `rpid` varchar(13) NOT NULL,
  `photo` mediumblob NOT NULL,
  PRIMARY KEY (`id`),
  KEY `rpid` (`rpid`),
  CONSTRAINT `rpid_rp_report` FOREIGN KEY (`rpid`) REFERENCES `Report` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  CONSTRAINT `eid_Reserve_Event` FOREIGN KEY (`eid`) REFERENCES `Event` (`eid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `uid_Reserve_User` FOREIGN KEY (`uid`) REFERENCES `User` (`uid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Review`
--

DROP TABLE IF EXISTS `Review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Review` (
  `r_id` varchar(13) NOT NULL,
  `rid` varchar(13) NOT NULL,
  `uid` int(11) unsigned NOT NULL,
  `rrate` int(1) unsigned DEFAULT NULL,
  `rtext` text NOT NULL,
  `rvtitle` varchar(45) NOT NULL,
  PRIMARY KEY (`r_id`),
  KEY `rid` (`rid`),
  KEY `rrate` (`rrate`),
  KEY `uid` (`uid`),
  CONSTRAINT `rid_reivew_recipe` FOREIGN KEY (`rid`) REFERENCES `Recipe` (`rid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rrate_Review_Rate` FOREIGN KEY (`rrate`) REFERENCES `Rate` (`rank`),
  CONSTRAINT `uid_Review_User` FOREIGN KEY (`uid`) REFERENCES `User` (`uid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Review_Photo`
--

DROP TABLE IF EXISTS `Review_Photo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Review_Photo` (
  `p_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `r_id` varchar(13) NOT NULL,
  `photo` mediumblob NOT NULL,
  PRIMARY KEY (`p_id`),
  KEY `r_id` (`r_id`),
  CONSTRAINT `r_id_RP_Review` FOREIGN KEY (`r_id`) REFERENCES `Review` (`r_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Review_Suggestion`
--

DROP TABLE IF EXISTS `Review_Suggestion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Review_Suggestion` (
  `sid` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `r_id` varchar(13) NOT NULL,
  `content` text NOT NULL,
  PRIMARY KEY (`sid`),
  KEY `r_id` (`r_id`),
  CONSTRAINT `r_id_RS_Review` FOREIGN KEY (`r_id`) REFERENCES `Review` (`r_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Search`
--

DROP TABLE IF EXISTS `Search`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Search` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) unsigned NOT NULL,
  `keyword` varchar(30) NOT NULL,
  `stime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  CONSTRAINT `uid_Search_User` FOREIGN KEY (`uid`) REFERENCES `User` (`uid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

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
-- Table structure for table `Tag_Click`
--

DROP TABLE IF EXISTS `Tag_Click`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Tag_Click` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `tid` int(11) unsigned NOT NULL,
  `uid` int(11) unsigned NOT NULL,
  `tctime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tid` (`tid`),
  KEY `uid` (`uid`),
  CONSTRAINT `tid_TC_Tag` FOREIGN KEY (`tid`) REFERENCES `Tag` (`tid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `uid_TC_User` FOREIGN KEY (`uid`) REFERENCES `User` (`uid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-12-08 17:25:40
