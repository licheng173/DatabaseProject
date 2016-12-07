create database CookZilla;
use CookZilla;
-- MySQL dump 10.13  Distrib 5.7.11, for osx10.9 (x86_64)
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
  `rid` varchar(13) NOT NULL,
  `iname` varchar(45) NOT NULL,
  `iquantity` double unsigned NOT NULL,
  PRIMARY KEY (`rid`,`iname`),
  CONSTRAINT `rid_ingredient_recipe` FOREIGN KEY (`rid`) REFERENCES `Recipe` (`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Ingredient`
--

LOCK TABLES `Ingredient` WRITE;
/*!40000 ALTER TABLE `Ingredient` DISABLE KEYS */;
INSERT INTO `Ingredient` VALUES ('58472ecb001d5','mashroom',424.5),('58472ecb001d5','salt',0.5),('58472ecb001d5','sugar',5),('5847302218e09','salt',1),('584732be7985a','pepper',84.9),('584732be7985a','salt',0.5),('584732be7985a','toufu',100),('5847335393d21','apple',100),('5847335393d21','honey',28.3),('5847399c49feb','pepper',10),('5847399c49feb','salt',0.25);
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
  `rid` varchar(13) NOT NULL,
  `rid_link` varchar(13) NOT NULL,
  PRIMARY KEY (`rid`,`rid_link`),
  KEY `rid_link_LR_Recipe` (`rid_link`),
  CONSTRAINT `rid_lr_recipe` FOREIGN KEY (`rid`) REFERENCES `Recipe` (`rid`),
  CONSTRAINT `ridl_lr_recipe` FOREIGN KEY (`rid_link`) REFERENCES `Recipe` (`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Link_Recipe`
--

LOCK TABLES `Link_Recipe` WRITE;
/*!40000 ALTER TABLE `Link_Recipe` DISABLE KEYS */;
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
  `rid` varchar(13) NOT NULL,
  `uid` int(11) unsigned NOT NULL,
  `rtitle` varchar(45) NOT NULL,
  `rserving` int(2) unsigned NOT NULL,
  `rdescription` text NOT NULL,
  PRIMARY KEY (`rid`),
  KEY `uid` (`uid`),
  CONSTRAINT `uid_Recipe_User` FOREIGN KEY (`uid`) REFERENCES `User` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Recipe`
--

LOCK TABLES `Recipe` WRITE;
/*!40000 ALTER TABLE `Recipe` DISABLE KEYS */;
INSERT INTO `Recipe` VALUES ('10',3,'Daddy\'s secret dish',3,'lots of tuna'),('3',1,'Good Stuff',2,'broccoli with shrimp'),('4',3,'Zuo Zong Ji',3,'it is actually chicken broccoli.'),('5',5,'Tasty Soup ',1,'Cheese Soup'),('58472dba0bee1',2,'daddy\'s favorate',3,'good stuff'),('58472ecb001d5',2,'mommy\'s favorate',3,'very nice'),('5847302218e09',2,'a',1,'a'),('584732be7985a',2,'my favorate',3,'best'),('5847335393d21',2,'lalalala',5,'should be good'),('5847399c49feb',6,'lalal',3,'good'),('6',2,'cool food',3,'Broccoli fried rice.'),('7',2,'Key lime pie',2,'Key lime pie, cake.'),('8',4,'Grandma\'s Fettuccini Alfredo',3,'nobody know what that is'),('9',2,'Some fish dish',2,'mainly tuna, some vegetables');
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
  `rid` varchar(13) NOT NULL,
  `content` mediumblob NOT NULL,
  PRIMARY KEY (`pid`),
  KEY `rid` (`rid`),
  CONSTRAINT `rid_rp_recipe` FOREIGN KEY (`rid`) REFERENCES `Recipe` (`rid`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Recipe_Picture`
--

LOCK TABLES `Recipe_Picture` WRITE;
/*!40000 ALTER TABLE `Recipe_Picture` DISABLE KEYS */;
INSERT INTO `Recipe_Picture` VALUES (5,'58472dba0bee1',''),(6,'58472dba0bee1',''),(7,'58472ecb001d5',''),(8,'58472ecb001d5',''),(9,'5847302218e09',''),(10,'584732be7985a','ÿ\Øÿ\à\0JFIF\0\0`\0`\0\0ÿ\Û\0C\0		\r\r\r\r\Zÿ\Û\0C\n\nÿÀ\0\0ú\0ú\"\0ÿ\Ä\0\0\0\0\0\0\0\0\0\0\0	\nÿ\Ä\0µ\0\0\0}\0!1AQa\"q2‘¡#B±ÁR\Ñð$3br‚	\n\Z%&\'()*456789:CDEFGHIJSTUVWXYZcdefghijstuvwxyzƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹º\Â\Ã\Ä\Å\Æ\Ç\È\É\Ê\Ò\Ó\Ô\Õ\Ö\×\Ø\Ù\Ú\á\â\ã\ä\å\æ\ç\è\é\êñòóôõö÷øùúÿ\Ä\0\0\0\0\0\0\0\0	\nÿ\Ä\0µ\0\0w\0!1AQaq\"2B‘¡±Á	#3Rðbr\Ñ\n$4\á%ñ\Z&\'()*56789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz‚ƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹º\Â\Ã\Ä\Å\Æ\Ç\È\É\Ê\Ò\Ó\Ô\Õ\Ö\×\Ø\Ù\Ú\â\ã\ä\å\æ\ç\è\é\êòóôõö÷øùúÿ\Ú\0\0\0?\0øE\'¸+´\Î0\ç«8\\Ü•\Ý\ç\ÌOýu?\ãPõ\î:Ð™\Õ’ù÷ÿ\0‰†?\é«*]\\sûù¹ÿ\0¦þ5b+}irF…\0Hg¹^—3g\Ó\Ìoñ \\\\\ãþ>f\äôó[üi™OPÆšGPM	\r\Å\Ï9¹›\Û7øÒ‹‹Œ`\ÜL=?x\ß\ãQq\Ð\æ\Ê\àŽ;P\Í\Å\Èññ?ýýoñ¦y÷Éº›þþ7ø\ÐÞ¦˜¾\ä\Ð†{ƒƒö™ÿ\0\ï\ã#Os\Ð\\\Ì?\í£4“ƒŽ\é£;±\ë@}¢\à\Ë\Ìü\ÓVÿ\0\ZS=Á^.&\ëÿ\0=Oø\Ô]úÑ–\äc¥\08\Ü\Ü\Ï\Ìü\ÓVÿ\0\ZU¹¸?òñ7ýüoñ¦cŒž”\åÁ\ÇJ\0z\Ït\Ä\â\âsúh\ß\ãH..G[‰±ÿ\0][üi¿pœ\ÏZE`ü\í@}¦\ã\0ý¦lújÆœng´\Íÿ\0üi…@@ t¨Õ”œ\Ì\Ð¤ž\àœ›‰¿\ï\áÿ\0\Zd—*ü\\Mú\ê\ß\ãB‘\Å2S“€h\Æ\ê\äÿ\0\Ë\Ì\Ãþ\Ú7øÒ‰\î3Ÿ´Oú\ê\ß\ãP`“‚hrI\ãµ\0L.g›™‡ýµoñ¡®®:™³ÿ\0][üj-À\çŸzPNÞ‚˜ûUÀ\0‰²?\é£i¸ÿ\0žóóÿ\0Müj 22)\Ù\'ŒI \×7\0d\\O\Çý4oñ¥7XÈ¸›þþñ¨\É\Ï9\ëH\Ø\ìhQqr\Ùÿ\0J˜ú\è\ß\ãKö‹ùù›þþ7ø\Ô9$t\ãµ£P\áòƒNALRr1Ÿ­(bƒ“š\0•Y‡\Þ\\\Óz[ô¤BÁ²zc¥8cH$\Ð\ÅpS?JB®=)W ðM(\Ës@Á\Ü~^;S\ã3\Å”pGÿ\0ZŸV€\Z\àb£\Üwcõ©X~u=M\0;O=)½0j@Ú˜¾ý©\ì\0‘Žô\Ôž\Ôò\Ã#© ži\0\åÁ4Àlw©m\ã–i\Ò(bi$…DE,\Ì\Ä\à\0RM2Eh\çdu*\Êp\êF\nž\àŽÆ€\02{š\0ót©|Á\â˜AM\0<±8\Ç‘<ŠU#s`v¦¼ps\ï@¦ð¦L0ribcŠY\08\æ˜ ñIž~U\ëJü\ã4€\ã§R\0`\ÜcÚ•Uº’8£$\äž}(\Ï9\â€\äsž´ƒÉ§u¤%²Ü@\à:Ž¦”·¥4d0þT8\ç­\09[Ž´dzÎš1Ž\äw£)ý\Ê\0>”¹8¤\É\ëŠ^s@8úõ¥]\Ý3Šj’ZQŒPòX…\'\0{S™{8\íM\ã€Žph\Û<N@pz\ÓCƒŽÞ´\äa»ƒ@\n\Ù\ïÒµ|!\ámw\Å3\ÜA\áý6MB\â\Ù’A¯™´œeT[ž¸\Î*o‡É§I\ã½!5T†[\'¼Ež9ÿ\0Õº“Ñ¹+\é#Iðƒõ›xt«!¤jQK››«‹q’<| \ÎG¾k\ÃÎ³Ÿ\ì\ê~\ì¦Öšió8±xµA$•\Ûû˜´ÿ\0jòxº\ÛÃ—–’i—\×\"\Ûmüm\É\ÇÍ‘FO5\ê¾ýµ›SM¼\×u6\çG»–H\çþÌº/,n”\r•ÀŒúqšúS\\ðÎ‘\ãHlu‰V\ÇU—KŒ\Éc0ù´\àƒ»nq\È|ÀŒ…8\ã#\Ïl¯ÿ\0°¼M%­”\ÆKi[|a9\é\ìAñ•x\Ó\Ãÿ\0²%	¤Ô“\Ö\Ï]ž–î®¾óÏ¯šN\ÉCKÿ\0ZûA|ñ\'Â‹\Í:]Q^}3Wˆ½\ÛB\Ñ2°$¤C÷\\m\'‚A#\Ðp\Z,štz\Ä\r«Cq-ˆ“ý\";ir2÷\Ú\Ä\àkô\ãŸwñöb\Ô<9r\ÂOAn/4x§#|\Ò\Â\ç!ó¹Àu\Çrkó\ÊUh\å*\ê\È\è\Û]X`©`ŽÆ¾\Ó#\Ì\Öc„\æo\ÞZ;~~G¯B§´¦Ï¤|\áOÍ­\ézÏ…4\Ù ½XvA™\å1[…f9\0#\ÃWIÿ\0?…u?Zxƒ\Ä\ZMµ\Ü\ÚtR;\Å\"\0—¬~\è—û\äO={\×	û+kZ}¶Ž-4³ws¯\Å>N\ê#±ûµ\î:d“\Ã˜\ëô\ámJ\ãÌ²»m¥Ps\æ8\àœ\Ù\Î÷¯Í³üf+Œœ%ZZiv\Ý\ì÷ó¶»ÿ\0’>o\í\á]®f\Ú\Ó\ä|™ûK\É`|Sd¶\Z}ŽŸ”\ç\ìöv©\nò\ÝHP2N;úW™¹ý\ïCƒ_O|^øh\Þ\Õ|a¨ø\Îñ!®R\0¿¸h\Ô\Ü 9\é‡=Onk\ç\Ý+Q·Ñ­uk‹á±½’H­®0’:AõW\è|9™a1x(ÆNgu·}÷\Òûúùö\ni\ÑQ\æ»[”{gô¤û¤ÒŽ2\äRrX\äWÐƒÕŽaÚ‡lòF+\Öÿ\0f€šÿ\0Å·¼Ôš\ì¿\éÄ¥Î§)L¸Ï–™\ê@9lZ§ñW\á=\æ—\â™-<cª\ê\Ú\\6û\Ý\ÎÀÒ²’\×[U\å±\ë\\r\Ì0±¬\è\ÊiI}\ß~\ÆR­N3\än\Ìò\â?\nn\Õ-\îi\Î$eu`À\à«i3Ž@5\Øj&Àœšw$\0!\ÜNx¤ƒ‚\Ô\0\íÃ¹?…9‰$`ðj<\Ø\r\Å\0…<\ä\Ð\0\Ã\æ#µ*óFFOQ×¥\0&n(Ç¿\éHO½½\0\ã•&\Ð:ŒS@\êGJ\0\0\È\æ€0(Á\ëJ8 \Æ@\Å8.zW¸þ\É^ø!\ã½jx\â/Å¬\ÈQ§NüõP#Ü„19=júÅ¿ðO+\Ç7>øƒyeË¾;McMó=de?š\æ¸þ½KÚºN÷^]ÿ\0B9\×7)ðzŒu^i\ËÁ\é_Eø\ëö&øß \ÜÊšUž\âE„uÓ¯\Õ&P{˜\å\ÚG\ækÅµOø\×Lñ\rÖ‰¨xWVƒQ³p—\Íh\Å\ã\'9Z\Ú\éTW„“)j}û;|\Zøy\â?\0\Úø“N\Ôo¯šñw\â\Í ”\0$„¢±\Ùór¤d• “\Î°k\í—\Ãii£#ý\0†K\Å;¢û¹+÷}y\'\ì¥\â¯|0ð\Ô`\ëxŠ\à4z‹\î\âM\Äyf3\Ï\ËÀýq\Í}®\èþ(ñ––\Ìóÿ\0dÚ¿*ŽHs\Ç~•ð9\Î!Õ¯8\ê\ìô\Ðð««Õ•\Ûn\ç\Î\í}­xXû=ü1\Åt<\Ó\ä|\Ë2\ç{\Ó*q\é\Ívž-ñO‚¼G\áXd–\Ê\×\í‹\"&\Ùa~¤†¤\äûš£­x.x¦;­:OCy•òã‰¾Rx\Þ  óŒŒ\â¼\ë\âw‡¤Ð¼EsQ½²g+\'!{u¯–«\Ã\âk\Âm¸\ÍuZ_\É÷<\É\Þ\î\'µ|¹\Ó59l4K\Ý^#\ì$—+[ó¹\'ŽyÁõ=*ÿ\0Å¯‡?`ø‡«]\Ç\á=:ñ¯\í³s|¥\äó”‰\É\Ú¹e\0’sœ\×\Îz&¤öŽ†H\çsšH[9\ã õ¯A\Ñ|U}©XE¦\Æ\ì\ì¬v\Ë\"\È\çŽõ|&\'ª}Zn<\í^I´\ìº]t¾¬Òž\"t¡È·\ïú{¢ü,¾øy\ãˆ|SgzŸb’úA§\Ç\æ‰ÖŒ0À\åd\ÉJ÷HüMy­<_i‰l‘ ò\äU$»\ãœd÷\Íy¿f¹\ÓukKJK‹+°“Ÿ\0\Æ\èÀGn\Ï|UŸˆZ\Ìúe§—½Vg!\ÞFƒ\è=O­^b«fr£:\íJm4­¢òþµ.¥j•¬\äb\ÙMª\ëú\ç\Úm’d¶’å£‰\î\Ê\áO-‚s´{ú\Ô\ß|G4~›\Ã\Ð\Í\ìö±\Ê\Ål³Fò¶yU*r\Ç=qœó\\ü:\Í\Ý\Í\Å\Ónb	q.öPA;D\'\0d•\Å\Ú|p¾¶\Ô\Ö÷þ«9^\0#·S+*Âªxh\äÿ\0´rk\è0¹^\"µhÔ£Nê®–¾¯\æ*j“Ÿ5$ô·S\ÊÀ\Ãm+ƒœ{W«~ÌŸ/>(øƒíš¶ 4	YK·P\Ö%\ÞÃŸ&ý\éür{oöSøL¿~)\\>§ö‹M\Þc5Ø‰ó$\Î\ÌYmÑ9#9ld\êE}[ñGá¶­¥\ßiº·v:o„--¥–’\Û~\Í>ð\Ã7rrrsšú¼\ï<xXÊ•\ï­\ßH\ßó~G\Ñb+ºq¼U\Ùo\Å:ß€´†zw…´-f\ÏK\Ð-\ä6Öºn—‘rs$\î\Ä$òx‰\äö¯(ø³ñVž6\Ñü\Z<<Œ„þÙ›Oó%\ìÆŒ6®?½†öªPhSXjz•ðÕ´\ËýN•¢¶½(¡¯r~U	žô8\èA5‘ñg\Æ\Ú÷ÃÚˆ&²¶»\Ô\ÃIaü#\Ë³<˜bFG µñ8jU\ëcW+\ç›\ïµû½Ë¾‡	Ô¯Q]k÷ÿ\0Hù\Ï\Æö\ZÖ—\â[«¬\ß\Ú2?4“d´ûùz†\ÎsY»\Õ\ß\êwš\î½w«\ß\í7W³4²\ìP\Ä\ä\àd\à{U\0<\×\ëÔ”6ýl}oep\Ï^84€Œ\ç\ïoÒ‘«¤ñÀ¤##úP­\'µ\0;Þœ6…\â£Ri\Ø\"€{bœq\ÔR)ƒŒô 	6ç¸¤dP½~´Œ[$\0\Ô\ìzúš\0“\ÉO²	 ¹8\ÙÞ¡e \ã½9J\È8÷¥Á#\×ú\Ð[ð[\â_‰þx¯þ?\n›!~j\È<\è\Ðÿ\0x!!K`	8Áæ¾žøgûEüAñ¶‰>­\ãˆ—‹A\æK\áÿ\0\Çýš<¼\à›¥M\ã\'?$l>PN\î\Õñ \\¹\'~•ïŸ²ÿ\0ƒ&O\r\Ý\ë\Úülºu\îÖ±³\'eÿ\0–Ì½\nö_^Mx<AR–:\Î\\²\Ó\Õù/;Ã£»-\Éñ9®%a°\ÚIõì»³\í\rü`øm\à_\èÖ—š<\Ö\Ój±-ó\ÛZ@\Ï\ïošO5Ü´¤x’N:\×w­\ÜxŸ_\Óm¯|+¢hRi\×*&¶ûe»EtRUÀ\Èö\é_$|Vñšï„’)\ÖÍ®tõó!¸{uó6*‘\åo\06\Ó\Øg+­ý›¾?x\ç\Ä~)\Ðüqyfý\ÒÛµ\íâ´’ÆI\ãn8\0÷\Å|^,e¥Ì“\Ò\ê\Ê_o™\\G‘c2<R¡^^\ì•\ã%»\ï?‘\è~#øU\ã]KT’\î_‡^½y>sy$°\Ç1~Í¹b\È#{\nw…~üB\Ónb\ÕZÿ\0\Ãze\Ì,\Æ‚K\É\×¨`òl?]µ\ë.ñ(\Ñle¹’\ç|ÿ\0)202»z\àq^;¯þ\Ð&\äKg gŒ•O\Ý\0:ýN=8¨­K‡NS“]\ä\ß\æô>zt)^ó“oÌ»\â½\Æ^\Ó.¼G«ø§E&\Ö&\Ùp–Ò¼™#\à€>µ\å\ÖZ%—Œ¼,5¿x’\Ùc=®|¸·&y#w$nrOJg‹üI¯üO\Õ\ãðåž¡\ZipF³\ßNXG\å¦y@OWn€sù\n\Èø¥ð\Ç\Âq\èSZÁ¡YA\è\â‹JŽ\á\ß\æ\'sN\Ìdc\ì°¯\"sÀR«98¹l­)?]/o»SÎ¯NŸ2Q\Ù¿ˆô\ß\Ãwºí†¦’\Ø\Û(YUšYXø\é’;ö²þh~\'ñÎµm§\éð\Øé–¡¶µ\Ì6\Ï)OrA,\íù~ï‡–>ð¥øñ>±\æj:l‘ZZoÂõ¤ÁTžw“ž=kgAý <[¢Öš,:&‡jg`¢\Ê\ÅVl9\Æ‡$ñŒµz±¥5	F¾\×Ú’µ¼­\ÝÒ…%\'wsÆ¿	|Ig%\ì·Q\Éaa+\"_\Î>iAH±›§ny\ïU­¾\é~.ðüÁ®\êð\êv‰·\Ì3¦\è\Ó¬¤t÷\ã×½{\'€üF\Ú\îýKL{K\ËqlRWMÁÔ€7\'9c“\ÇÍžµ\ÌZ\ëR\è>2º³[{ˆ\"\é\å3F\é\ÏBQ•Á\È&¼j8\ÜD*6Õ”[¶šzÿ\0Z\Zò¦ù“>`ñ\'Â¿ˆºÌ’xkÄ²_Ge¥­\å\'ý’\Ãc~+Ê¼3\ág\Ä.ƒÃ¶VS­üól‘2<œ™˜vœ\×\é6¼©u\àý@\Ü\ê:Í²\ÄXM` #¡s“Šù—\Ä~0ñ\Ö\î´/†þ¿\Ôu³¶º\Ô\î­X€7\ã\å†!~l\à\ç5öY~}©N\æ\×Å¤R}\äÖ–ü^Ç£„•yI\Â0½ú¥o¼ô¿\r|o\á¿\èñx:\Æ\Åt\ËKwÉ½˜ª\Ë#ºW\Úw3’3À\0\0\0\àV7\í\Ûmñx‹Aƒ\Ä~!¸\Ó4\Ãi$0Kh¨#•\Ãnb\è¬]	\Èc\È\0ú\×-¤j?´\ï…r\Úk\×\ÖZ\Ü\Z¾Öš\ÞFŒÂžY\ÎB\ã\Üpõ«^ð÷‚µ»Cyñ7YÖ¬\ï%;`Ô¡•§iH\êX7Þ¼\ÊQ«C\êb¤¥$Úº÷¯\çm®†Uù\èO–¢wó\Ûñ8½6ûTð^“`\×~7\Óõ!$¥­´Õ‚–Jÿ\0­pW\å\ë\Æ[98«<A\âoø\îy-\î¼Ik§&c¸¼·\\\é\ÊÁCº\"ƒŽ€uÀ\ë]^«ð­t‡þ\Ûøg¨Ã¯ZJËª\éI#>	hlm=w 0k[@ø‡ñ\á\æ»‡\ÄO[\ÞG)VµI­uR½cTPòžü\×o´\äš\ÄÑ‚›N\îÖ‹}ô²üõ0Ô•T´]mþGÊ–>ñMöŸ5ýŸ‡ui¬\í£if¹[)<¨\ÑFK\Æ\0Þ±™;þF¿E¼Kñ‹@ñN…Ž¾¶·´»¡¸»\í\Èa‚ž€ýk\ä_\ÚW@ðv‡¨µ®\á«\í\'P–b\é*]±–,¸‡,O¨\ìe\\Nñ\Ø\ÙaeEÇªk]:\Þöz>Éž,\\gS‘DS9æ§sRù½\Ð# O5õ§Y\ÑÞž i\Å1\Í4‚:RY:`ƒBó\Çzo~)Àžø\ç­\0¤·›\Úu\01Ö˜rŒcñ¨ò7r?\n™He\ç?!…>ð8¡¡3.~\í(a\ÔpSN)µI,+Ù¿d„³ø\ã\Ärø£T„\èR˜È™[¹±‘\ZŽŒ›\Ó\å­sbñ4ð´%Z¦\ÉX<-L]xÐ§»þ®l~\Î?n\ì®\×\Æ7Ñ• Š4—K²¹\Ú\Âfa‘#¦O\0`…n\ç‘Ò»ÿ\0\ë„\Z q…\à\è+£ø“¯\r\îc?»q3\Ðv\Íx¿ŒµfYX³úóšüžXœNu‹öõ¾‹¢GôG”a2<\×\Å\Õõe\Ë\Ù\î5µš\Â¤™¶\ïÂœ`dý½sð]]øoÄ£\Þ\Ïgq©:Kk‘$NT©\ë‘×Š\å\×\Ä\×š\ìwÖ—e~\Î\à”\ê%\ä‘k\'R\×5}[\\’þiEÄ¹%cgû£=\0¯°\ÂdóŒ\Ù?\ÌüŸñx\\\Û\í#ñ\Æ\ÑO£Z¿\ÔúNó\Ç\ÚÖ±§¬2kó^#+#ÍžNzƒ\ïX,\ÔWM\Ñ\àŽ-4\ä E<\äð\0\ãþñ>©i}$6¬#ûLÁ\Ì3.vöÂ“\Ðtü«WUÖµ\äÕ…\ÄðE;¨1\"2Q‘†8\ìqß¨\ìEyò\ÈeN­š\ÜøH\à+It=;C·¿þÁþ \ÓkvýÍ­ˆ=NKn7°\ã\æ\ät\0ð+™ñ‰õ)­Gi\Ì\Ã\Ì\Ë7_Â¯x\ÃZ—ˆ?\âcš\Ú>“ü|]J\å”c\ïl$dûk¥ð¯…\í|_\ã˜\"T•t«gH\ÞVQ¸ ?ÅŽpx\Ç,<i\×u*\Åwµ¶<gAûF\å¿dy±Ô®†‚\És\ç\\\Î$\Â	*ˆ\0søŽÂª\\\ê1EÖ–n¤8dq¸(\Ç\\ÿ\0Jõß‹^²\Ö<U&\á€\Ö\ß÷j\r¢\Õ@‡\\žI=\ÎkŽ\Òþ\\Í«­±Q™	X\É\î\Ø\Î\Ð}p	\Ç|\ZÚ–\"‹‹”•·Ð˜ÒŒ\Ú;Ù\Æ7šj2*3<—±L\Ðo\Èx¼·Rƒ\Ódö\ì^-	}¦[jÖ¶\×Ye¯\Ú2¬OVp ñ\É\È\ê=+À£I>ø²\Ú\ã\\\Ó\'š+ˆdQl’2€W\Ø8cÛ¯¥{—|Ocñ\ÂvöšL^-ÁXÊ¥£@¯€Ç¦\áµy\ã9¯#0\ÃÔ”½ªøekz\íø“U%Y\Ç\Ýv_=¿C‘¾»\Z…¼º•“^i\×\ÈƒFdˆ·R\ZE\Æ\ßmËzô†²G®è‹«xŠ®.¦im^	—“°\0þaû †$0\èqÚ¼³\Ç6ž&\ÐõHõ-\æK;Ûˆ˜³Ë±\'•8aŽ@ÿ\0\nµ\à/jGÃ­a¯y‡QžQ$1-1“\0m+ž‚z\äzV˜J\Ã8\ÎKO=¾\î¿3\ê¸cVqxT´uMuõGu\á¿\nK\â{\ÛMVò\æKx.È¶’Dp\n\0T˜}\ç\ÚT\r£\0’+ñOƒ\ìo!O[\É\"DIH­ld\Äc\Ü\ç>õ\è[«M:Yµ}SÈ´º‰DXüÕˆ\Ü- ©Á\éÓ¾>©¦\Ém{º\Â\åIX\Äcº¶h¤:+Àg#Óž+×­€”a\ZÓ½Ÿ\Ü}4\Õ,Kp­+mu÷›|%‹M\Ò5”¿¼šó\å\Ñ\ÚþFž/N\íB‚Jò8\Îy­kún«K3i·íµ–\ãK`&Ž\Ý\ÉÛ¸/![Œ“œœ\Ýx«\ëk\ÍDa\rµ\ÌReˆ§•:pw@Á\é\ïSiW\ÃNŽ+\Éô› ¹]\ã\ÞA\è72	\Ç÷¦\Ü%G‘>Y>÷þ¯øy\n–7u\ã\Ñ$—ô¿^_\rÀu·\Ó4=M¿\Ñõ‘ù\î«°0\\¾õ.3œI\ÇL\×\Í_¶/Á¹ôV\çÅºK\Í,T\Ü[F˜\0 c ó\Ôö¯¡~#&­i¡Yø‡Á÷\Ñ\ÝK¨\Æbž‘\í\\®A\Ï³\\ˆ|S«N‘\Úø¢ö\rOÌ¬\ã„ÀG_©\Ï\Éü©\àdòú®¢¦\Õý,×—_ò\n¹ns•=®•¥;h|Z\ê\0\Ü2GjŒ‚{\Öö©¡\Þ[ø†ÿ\0I‚\Î\æsgrñnHY²ª\\iwVRl»¶šô\ÆWù\×\ßF¤%k3\â¥J¤ou±“\Êü­Þ–T8\éW¦ET\"\Ü}E2)¡e*\ÉÏ§¥]Œ\ÌõPs\íF1Û­hì›\î\í’[Xc;‰8#Š,3T©\ãjOø©¤·…Ÿ÷RŒ÷©>\Å/b(°\\…[€	ü\éK*¡\ë_M|)ý‹<¯n¼Uym ÚœúÉˆþB¾–ø[û(ü(ðrGqs¦l]\Æ7\ïŽ\á‘\ßoA^ulÎ…5£»ò\Z\Ôøoösøw¬ø›\Ä\ãY}*V\Ò4¥ó\åžd+¾@D¹\Ï<g¥}5¡\Ü\\\èþM\"KÁ%–g ¹v\É\0{Wq\â-gM]:\î\ËK‚{i.\ä1$1„\Â`\ÛB×“ø\ãRû-¹&Aód{\nü»;\Î+fõý”©«i\æ~\å\ÂY,N¤xõ»þº÷õ\0\É$…¸Bs\ì1\Ï5\áž%\Ô\çÖµ‡³†`‘Ž¬\Ün­/Š>2’ò\áô\ëI7)8‘×¹ô¬­*\ß\ì–l\ác‘¥P%BAÀúõö9Rðô•J‹^ˆð¸¯ˆ\ÕZ†–‹\âkò_©V=9!\ÊY˜’9\ëTž\ËÎ»Œ\"˜¦S\çî·¥t6‘,\Î\Ó\ØÃ¶H˜|\Ù_o\ê)u&\Úfócý\Ù`ƒ\'°ô<\î\'\çÒ§\í‘ƒamyq©\Å\Ã:6w¨Á Wu¢Gu\â\r*[³¶¹]ÀðIþ5CB´ž;;«ø£Qpbs—uóüÿ\0JŸÀ—¶\Ñi2À’ºK \É\0õ {W-yóÇ™©r>S¶\Ôü\â{\ßZhN‘iúd	k~Jª E\0± “\Ô\ç©5±ðG\âE—…¯ž\ßY\Òå¼³\Ôñ$w‘ÿ\0¬¶m¸hûÀ8Œ÷®j\Úh.`þ\ÏQ\åGx€H@\0ð8Ï¦O8\ãµOö›–W@/‘…J\ãþð\îø\×ZwM©\Æ\âyE\Z÷´R¹\Ñü-½øyªøŠ\ë\Ã:]½Î£¬[K3Ø°P–1§?h.\Ä\"ðA8$\ÖÍŠøÁ~´\Ô<h\Ñ\ëúÆ«3™¢š}ð½\ì\Ç±\Ïõ\Ä^Ynš\Â8¢\r•#Ä›7 \0\ã\Î9\Ï5\Äø£\Ä\ZŒ›\ï\åyQ\\º¡þ\Û·Z\Îü\ÒQ£>ý~Kü\Î\Ü>Q†\Ã/i$½?\àŸCxŸZøQ\â¿ZjWZO‘ub‚8tô»s•õcq,9%‹n\'=8â¸»\è\Þ7O\áE„·;‰	p\Î\ÄÛ´\Èüzó^,š£\È6—(¤q\Î\à;Æ®\é—ò\Ä\Û\íöŸŸ\Í\Î~ƒ·—Ô±.MÕ©u\Ú\É~Gkys§\É\nWü~ø-«i:n½dº¬Viú”Ê—a”@\åó³•Û’Bƒ–ƒŠö_Ÿƒöz\î£^X-\àsŒ¢/·_^:gs0”Hðo9\è:W\Éz[\êZ¦ˆ.\Ú\Þy--˜o¸T\Â!ð>Ÿ¥v¾øu\á’úŽŽö\Ï}\"\Ò\Úo(„‚\êñcŒöæº•«$”U¯½…O\í¯\È\Ú}“±ô~·\ã\Í\ÏAƒU]rý´«\"m\í,\'†\ÝfI’!„P2@\0\âª\Ãñúi\ì#K™‰€\ÎAÊ¢”M *\í\ä\Î3œú\×\Êú\çÄ›\Íc\Ä\Ð]j\ÒG8ŠI\ÙF\Ý\ã#õÁ§Yøª\Æmop‡\í%\rj7	 m9\ëÁ¬1œCþq¿¯ôŽˆe\Ôc¥MlzwŒ~3\r\Å\\}ž	–ò=\ßh0«\Éßœª°Á\à\Ï\çµg^|Uðüš§\Ú\ì,µ	m¸W¸o0\ã\' \Æwƒ91^%\ãI®Ÿ\ÄW\Ü³ü\Ü(öôúVDs\Ëk\Þc\ædgž¹\æ4£IE»õ\Ø\Ö0\í\ÞÖ·™ôo‡¼s \ÝÁ{u«]\Ïf\"ù\ãTÁÀ<‘Ö²<]«xU5Ø’\Ç]H¡\'‚\âóF ²\Æ\Ò	\ì:Šð\áx\×,\\N-‹\0#<)j³²¬\à\n©ad´¾ž}jU¢\Õõè±~\ê\Zv§i2Giš¾b\Ç\Ý\ÎI®A®›\Æ>ð7Š4¶Ó¼C¤E=»¼ùõƒ^uû2i\ÒXønn¯;L	ds1u1(\Ê\ÃrrkÑ–\×R‘’X¤“d„)u€µù¦2¿²\Ì\'*2\Õ>\×â²¡BU0±Wd\ÖÏ·\ä|‡ûB~\Ï\ZÇ‚#º\×ü5qý« ‡-\å*Ÿ´Z©<n\Ä÷…xÍ¾‘©\ê™m4Û©Bux\àf\ë_¦wºV­axbž\Ú@Ê®cû¤vúT:lZ&™¤J,ô8bDr&1\Ä\0ó1__„\ã,M\nNž.•\äº\ê´ûýO‰\Íøn„…—º÷¶«þ¡ù2\Í˜\æGFø”ŠQ<Œzô\í_f|{øy\áßˆšõ²Á\"iñ#þöh \0©=\È\Çøƒö-ñYh§ðßˆô\íJ\ÒnL²!\Ë_RzW\ÕeüG‚\ÆS\æ\æ³\í¹ò5ðu¨Ë–Hù ,\r¡B¾)žMÀ\ãqü\ë\ìþ\Ãw7–C\íþ.\Ûu³w\î`\Â`O&º¿a8Ä¦O^‡À\Ü>\Âx=\ë¯û_\Õ\Õß¢bXZ½¯dõ4\Ë\Ëc=œ\Ð\Úf‰7¡ Œþµhô\Å7“ÀÉ¯”SV\îagt|k\â9.ô)®4^7I­.\Z4%NHóŸCƒƒ^ñ\ç\â.\Ò\è\Úk±lbIW¢Ÿ@k\èø(_ôInCÐ­Ùµ»fû=õù%Qc>Jvfylq\ÓÖ¾\"\ÕÄ¢\è™NpÙ®<‡\éF»­Q\Ý-¼ü\Ï\Ññ\Ücˆ«—¨R,\å»ì¼½{ôüJQË‚þTRJO.UI#\Ü\×E\á˜\î\å´\È\ßû¬d\àm\Î3\Ï`\Øö8õ«:±\Ót\ß\í¹‘\ça†@\0\rœŒõ«{\ÂZcx“Xþ\Í_²\Ú\Í4$y²N!Rœ3`±¸¤Œ\×\Û9¦ùl|Li5\ï_R¶ˆ9\ÙÉ°\ÅÃ»2ð¨\ïô§\ë³E‰ Œ\ÂûÀH¸\å³×j\î~ ø.\ËÁ£M†\Î\ê;ù/!9D\Ú`sŒ\ç’2\Çd­s¶\Égc\×ú„Bynl\ÆøÀ\îlñúWz‰O’[³®Œy—<^\Æ^¡}\'•*ù\ËžM»8l/ #ÒŸ\ágŠ\ã_±±\Ó8\Ù\ä\Û;l\è3€*®-¤¿l\Ú\â\ÚF\Ù\Ë÷“\ßô¨-m>Ã¯\Ú\êvò°€Ë‰Hû\Êy\0S\ä\å¦\ÔX)~ñ9­:ž\âM?Ã¶1\Éfò\Íö\ì†wP\0p0;tŸ°¯<\Ö\î\ã—Rrn¡VÁ\ä\îÖ³õÿ\0­V{,€3pd\àúf±õnn·G6\î\ä\\T\èU“½C¾¦\"Œ\"£M\êh\Ü\ß]¨h£s\äg\å\ëø\Ó\0\ÉJ\çs}\å\Ç\n+GL¶‰´Ù®e HÍ‡€r8 þu“Ñ\Ù\ÙNø\È!\0\àw\ÅtS‚nñG5J¯K½¤q¤’0\Ï\ÎÀ†\ÏCK*ºIgPµ\'Ö¢[¤™¼øÁ\å	«S˜Ê‰HÛ¸\áNrGÖ®m¦U%M­N\Ë\Â~*–?\nJ³,jLˆ\ËÐƒ\Ôc§<dûW7|\×V\×/1†-\Ó\Ç8\âª\\j°s…T\\.\Õ\Çn¸¬Û‹­Ž\ï$®~@zšä§…|\Í\Ûs¶x\È\Å+\Z\î¡oñ”ùmV\ã…n¹\'Þ¡\Ó5«}=ÀC$Œ0£</°üj´ž#\Ö\ám\í„X\\8–X¶¼ö±œqT>Æ‰j&w ºž•\Õ\ZªzsÅµ.h\ZÉ¬\ÜK²9\\\å‹\ì)#»GÓ¥‹*[ƒ“\ÆNj‹j0\Çl-U 9F\0ö§\èvö·÷{d·—k€Œž\Ô*QŒ[j\É\í\ç9$µl|wn÷¦[É‰s·\æ¬\ÚjÑµù,K¬x\É#©>¢®_x]\ì\âÿ\0\ÎrŠ»‘—•\ç¶\ZÁ\Ë\Ér\ÆfPHö¥?e5\Íš«­YŸ]ü½3ü2\Ò\Â3+t.Xs\ÃŒc\ÜW¿ü&Ö¬%´š‰L¬@ \0±ž\0\äþ¦¾xý—\â–\ßá·•£\ÞÁto’iÃ¤+ÀI\Æ3œ‘ƒÓŽ‡5\ë\Ú>±·‰¤¶†þ5‚\å1³\Ã\Ç÷[h\ÈoB8\çšü¢­«f\Õ*Å«s?\Åùÿ\0Á\ÜýM\Ë\ë™U:rN\ê+ðGSª\ÊW\í&\âDo)\Êye¾bO9 cõ­…±X__]hºŠª¦ \Ã\'p\Ëü#\ê\éT|M¤µž‘k,¦Y$udŒ\0\ÃqLV>‘y>—ªZ\êCþ]d=\0<ñ[Æ¬¨\âµŽ\Úë®¿\Èó*a\ãŠÁN\Þÿ\0š\Ûñ=sHøS\á+Æ»†ÕŒ®Á™Ù¹&º‹mK¶O.4Œ.9^¹ú×Œ~\Ò_|S\á\Ùjž¶Yã»™CÍ‚YTŒ8Ï¯5À|1øý\âCÆš\\W2\Ã›4Š’‰‰o1Xá³ŽwÇŽ†¾º–7.\Ã\éJ•“\ë\Ðø¥•\ã\ë\Óu\\¶\é\Ôú\ÈAÀ‰\n\í;Q}•;,S’õ~\Îñ\ÊYVE\Æô8\àú\Z\Ï[\ëtP‹.F_µzu1T\ãkE~G•\ns}Jû}k˜ø\Ñ\â\Ëo|/\Ö<Qv\Åc±ƒ\å\Ú~r\ÌB¨_ö²xúWU´\\_\í\à\Øüsðw[\ÐØ•˜[5Õ«œK–‡\àY®	¯u\Ø\â¥\Ë\í#Íµ\Ï\Íˆ\Z\æ¡\â\r]nY\åŽÁ\îX¢9,7u,OV8\ë\\ð³y&	*Hm\Ë\Ðn>½«SS¹H£]ÌªÁ@Tw#i\Æ0Xð–© µ½Õ¾§\æ³L\Ã]yô ƒ\Î8ú\×\ÐR\åTâ¢¶=z‘Nv¾\ã|E¤i‹˜\Ó/¥»•m\Ã2ù;\Z$\ß\Ó=\êÏƒšCo%\ãB›asy\0r•dµ\Ù\Ú\×\ÌF…›l¨:ŒôcWuB[-\åÑ´ÁZQ³x\Æ@ÀTUrpiAAIH·y\ã;µ™¼É®\'*J¹l’\Þ\Ýðej:\Üö\Ïy\åa%;p½xõª]\Ù!å”“#H{	¿…Yž\Âfw»U€(A\Ãñ\Ë{s­J¥O™9jÈJ–÷,½\n1Lg&x]’L´œŒdp>œUˆ\r³@§\n\Ê\0\ØÄ¶;ñQ\Ä\çK\ÓXR \åx{\×/w¨\\\Ü^y¡aºÀj¤¥7hh/iEs\ërÖµ$3\ÜH¢-ù\êøûµ’mH‘ž5PˆG\0óZ\ÚBH·Iöˆ\ÕVv%H8ÿ\0\nÔ¹ðð”\â†d=#HÀ>µªœii&sTƒ«\ï$R[—\Zo”Ó°¡Jƒ÷©oî­¬\ì\ÉÜ<Ü²õ\ëTüE–\Ó$LJ\0û\ã\æ\æ±\Ìs«ù«œÖœ(©jž‚•w\r-©}\Ü<€£8vùˆ\Æ>k™\á‰<õI\à—\ÏOÿ\0]g:¸\\— À\è!Y\Õ\Ø\Ü\"ý\Ônükof›2U\ÚZ&Ô¥œ„€a³\Æ\ÑÖ£’)“\æb\Å\Ï8\0\ä\Z\Ñð–™&¯u$~Ê‘\ãq9cÀ]Ý³Úº9´8%\Ý¦\ê.	\ÜÞ€w÷5›p¦ì‹=Mn`ilÀ,~Q–Y9ÿ\0„zšÐ»º4q÷\éÔ“ÖŸq\Z9š\Ýd2H\Ã,ò`cžŸZ§o¬\Ã\â²\Ú,›A Œ¶8=øš\æi\Ê~\ê\Ð\éƒåŽ²3¢\Ó.%¼aY‚¾?rs‘ž O\á]†¡±Š\åœA<ódª\î8\ÛøzûUXn^ò\à\È\ÅUúŒ(R¾ø®\ã\á„u\Ï\Ù	#Y·\Úfa÷Y\ä+g¹8\é\Û5–aW\Ù\á\åQ»$›gfYA\Ï\nkW&’=»\áW\ÃO\Ùx^\Õüg¤¶©©\Ü2\â;‰R%#\"0€\Çrsžk\Ö|/7ti¢þ\ÊðÞ™k!\0Ž+H\Ð6:ò\0#\ëšó9õ-\ÌKI‡Ýž‡\éRCªpœœz\Zü~¶?ZM\Êz7{t_#öZ|7ƒökK;AC\â H“F\ê\Èüº²”\ãÓ½qŸ\îl4Ÿ\r?Œ4¥–7\ÓWu\Ë\"\í&3Á$/g9ô®MÕfP\Ìò>µ\×øgU‚xž\Æä¬¶\×jQ¡|2A0<‚k¡f2©\îUIFý7ùlò?¨\ÍV¤Û·G³]™\ã÷lþÂŸfšòöLmv¯\âkkÀ^9Õ¼Y}\r¢Ù²\\3uÉ®c\Ç-4½¤p”°k‚Ö³`ùK}\Õ\éÁÇµ{\ÂmÁ^\Ò-î¤–\Ê\îòe\Ìv\æ\é·\ßS+Á\Í\'\ìõ¼¤sbsuN›µ5w²Kü\Ïa\×|/¦\ëþ\ZƒF\×\íä¹ŒÆ™Š·a\ï)\ìk\ÈeýžtKE6›§´r¬\ã\Ìlƒ\Ï\Ý\Ü;þ\Úk,ô›(¥±x/ÁrŒŠH\0u\Îpjˆ¾)My¦—\Ó!–\Úv\\nR\Ôÿ\0³^½|F^\é¥)mÛ¯\Ü|NžeJMÁYJ\ç­_y·Z2Y¤6Ìª›K´Ÿp\ë\ë\í\\É±N\Ó\r‰#‚K¾O\é^)q\ã}n\r³^\ê—+»0.J39\ï\ÇZÉ“ÅŽ\Ò36³9$’I™«\n¹\Õ:¶\åƒ\ÓM\Òý\r(\äÕ©^óZúŸciúLqÚ”ºU“Ÿ§\ãV~\Ãl-\ä‰\"Dó¡ v#aª\à±nzšZý6zq’>ö?üm\à{ûO\êözµ•\Ìéš„¶rHü®®T“Ç¶kHð ûV\ç½H„`°.vo²ûâ¾ý»­\å›ö”ñV£A$(³G-Àa„’g…X\ê{w<×‰jZ%\äzÅž•©ùVwQ!Œ\Ï(EPÜ«9\çh\äu®:5_*ƒôýb!8©•¯‘t\èž\ÞI<\ëk\Åp# pGÐŠ\ÜÑ´aul¶±¸hdÁþm¿\Ý\É\è½f\ÞhS$Og{2™b\ÚûWxqÞ®h>-ÿ\0„jK»;	%™\îb0\Ìv;:`g¥aV£Â®wÓ§}\Ø\ê\á“D\Ñ,.¢\Õ4¤•\Ö5±E\ç%ª·A‘\ï\\_ˆ.4ñ¨,p±Ž\Ø>QX³R{ý4]k£RX\á_\Ü\'›ºG•°\ç\×¬iúR\ê\Z\Â\Çw{6×›U¤c¼Å†\nY”vÁ\Ï\áXSuj4¦\\¡J1¼u1/<\Ûû\æò‚\Ëm´HNZ ðƒ_[} ²Æ¨J\0üŒŽO¦k·ºð–¡¯k\â(n¤z\ÒB\ã?|ùpy\Âõõ®GUn\Ö\ã&YXˆÑ\rÛŽŸþªì„•9r\Ü\ä>xÝ­ˆ“OŽ\Þ\Î	&T@ÌŒª\Ã?ðn*\ÊÝ Y!¶\neP23\Ê\ÔZ}œÜ†žI”6V8£P]<ƒÀÀ\ï\ÍUº\Ðü©KCs²D\'!9‘W#”õ÷\ëZJ\nKVdÛ‹÷Q\ÐGký¨MB\Ò)dxn\â¹-\Â÷¶3M}¥¹ž;\ä‹2\\w\Ñ¯¬\åŠ\î|\Èü\Ï6%Ü›B1\ØóM¸\Õ\ÞKc,ÁW\årG\Ðú}\rrÚ­	\Þ&Ž­NA\íÁ’»\\\à\àr¿\áV\ìa\Ó\äš\ïmŸ0(D\Êü§\éQjh\Öòyð\n9\ÏŸˆ\äR$±\ÍsO?\Ý\à2¤Jôe%(\èp\Æ<’:xlSû>h´\Øÿ\0²\Ö6gý\ëœJq rI©4-fm=\Þ9&))ˆ‰!\È*\Ç#’ \çzû\Õ{v\ÛÀI\0by¡¦›ˆ„\ÌX©óÇ¿¥qJ\\¾\ã3¹BòºC/\"\Ó\î\ßGHÁ`\ÛÏ \ÏOÊª\ÞZ\Æöø—I–\Ü\Ç\Ï\Ú!`B~ŠtVööð¼¦\\9\È\Úþº]3\ÄW¶°Koö™<‚NS?tct\æ\ìúŽT\Ó\ßB.¾\Ëo¸\Þ\Ç)ó\0Ç”A\Û\ëŸ\\ö¯^ø\0c}Q\Ô\"¥\æDX\ä€Hü\Îk€\Çb{{[-V\ÊB\ÆÐ»C¢ ]\Än\'jòH\n=±\Åz\ß\Ãö°ÿ\0„6\È\é\Ö\"\Â\Þ\ët\ë9\ØS\ÔñÊ¾w‰«µ‚\äK\âi~¿¡õü†S\ÌÝ­\ß\èl‰\Ù[w=~\éjD”4%ƒ\Ä\ão÷}\ê\Ðc·cù¶\ài¢\\Iý\Þ:\Zø?gm\Õ%[\ÞÑ›6·N&\0¶ÀH\Ë/O­t\ZF p>b\ê\Ù-œ`Wg9/\"ƒœ©\ÇZÓ°¸+rƒpB\ÙÀ=+ž­-cEQKI³ªyZ·\ç6%“fD,Av\Æ	olv¯0Õµ[M±¯œ À\Ý\ru½\Ù2\ål„\Õ\ÍS\á\ÌZö¹6£¤\Ü\ØZ\Ç6\Ö1\\\å|\à…Ú¤SU…”j>I\éo\Äø\Ì\ã\r,$œ\ãª9\Ïx\ß\Â\ÚœÏ«\ÚN\Ê8/ä³Ÿ \Ç\âj?|Z\Òí­¼\ÝFi#),\Ò\rÿ\0\×]¦|1\Öm.‘\ãN–9¼\ÒñVO\í\'ð£Ä²x*4ý>\ÚK›BeCjÁ–\â<|Ê¬?ˆuÁæ½œ&Y½[üŽ\Æc*\Âw\Ú\ç‡üEø³\âX\í’+x\É\å®qøš\â\Û\Ç\Þ\"\Ü\âa\'_j·¢ø_\Äþ$»ž\ÇGðæ©¨\\ZŒ\ÏŽ\ïûÀ(“\áVFVðgˆ‚?³%\ãÿ\0¯ ¡„\ÂS+Š<\Ùcë½¤\Ï\Ö\Øu­2k…‚;\ØG8Uš½‘Šò+\Ù\é·K6«\Ú\"mÙ¾\éú\×c¬ø¢3\Ã\ët‰=\ÈL+\\g×–À¯G,\âZ•£S\ë”ý›Ž»\ßúg‹\Ëa«ÏšþV>/ÿ\0‚‡xJó\Â\ß—\Å	su5¯‰mŒ\é#Œ}žeU£W\î\0T`;Ç½xœ\Þ)xtK\Èu«x. ¸PŒk\æ–\ä©,9\ã’q“_q|aüSð¹Ñ¼Q¥]Km´¶\Ï\Z=»€r\èW?Ãœõu¯Ï¯ˆze¥¦¥s§\éWÿ\0o´v\Ý\Å6¸S\Ð:ÿ\0	\Æ8®l>gmiF•\Ôo½»ž\Í\ZN…«-QNk\ë\ÍU\å©U“\î@\ä¨\èø\Ö|\ÞMœ)º—i	\Ë\îù²?½\ë[Z*úo\Ùb”¼£•98ô¬}eV;÷Û½\Ë08œúW³I¤ôg-Fæ”™j\ßNû@Mòˆ±‡,\Ã%Ï¢¨&¯\é+NöÖŒ6#•\Üëµ²=Â­xoKiíŒ³\é·&\âLE\Èû\ß.2\Ãøõ\é~øG®Nº¤·)¥i\Æ@#vµ\Ý,‡n2S8\n>¹©\Åb¨Ñ\êJÆ´hI¿uoý¨\êZ„1A)bIB³0ôNõžžñ…\ç\Úg\Òô\É- d¾š?*\Ú4\æf•°Š?õõ‡\Ão…\Ú…®¡½ñ\0:„\ï’’M£8ùI\ÛÀ\çp+\Âÿ\0m¿Œ\Ò\ëÚ¬Ÿ<<ñÅ£\ØÈ§ThÕžd\é\ã¢!\Æ}X²+\Í\Âf4ñµ‡\Ã\Â\ïvõ\Ñwù\ßN¯\Ð\Ó	R¢\ç7§\êy6“}m.’E’+\Ä;¢˜9\ç\ÔÒ›ë‹‚°›ˆã·Œ\îwL“÷ˆ n”ŸþüBñ¼\Ï\á?\r\Ý\êv¶j^Y‰X\à@:ü\î@8\ïŒ\×\Ôÿ\0fOjzE¬^2›V¾¿P¦f†ôAm	#\æ¨\\’§û\ÙÏµ{¬vQFrWz%\Ô\ä\Ãak×¦\åìµ¿C\ç]\'Æº¾ƒ¢É£\Ú]mŽv`•Ns†\ÇéŽ•\É\Þ\Ê\Ò^M<3\È\ì\ç$3dœúšû+\â\ìs\á¸%›ÁZÎ­c.\Ðw2‰\×p\ê>l×½|\ïãŸ¾1ðÿ\0\ÄO\Ç¸–ú\Ü\ÍÔŠbjœ6ü\çn=s‘XC6\ÂNN2š¾ú+-õ\Ûñ5y~#•:q\æ¿mþ\íÿ\0\Í\ÖI.¬\n–I‡œž*8.6¢¬L>V“Ž\ä`g\ÜÊ½+\Ä?<u\á\Ý®®4µ\îBdkID¢!ž¸\ÆsŽr;W!q jQØ¯­»nd˜¿Ã°÷\éÇ½v\áñxzð\æ¡5%\ä\îp\â°\Õ\èM*\Ñiù¢M\èM\nÀ¤1\ÉS\Ã{{zÕ‹–’b\\þ\î%\Îñ\ßÚ±´\ë+\ËeMÑ€%\ÉRJµxn$…\íH\Ü;ž•x75sjU}Âµ\íò\ÝF¬ÁTF>Q\ÆG·Ö©¼\Åg\Û$\îÁ3\ÚK\Z(xYØŒ\ïôþ´—È±±±‚ÁoÂº £d\Îi9Iû\Æ|“¼{\ãð#RZúSÁ!ð¶›k‘º;D‰\ã\îñ5óîŸ¨X\Ûº²ž \ÌfHÊ†µô†‰O\Ø\Ç!\Ä	–¶\Ð+\æø¦<Ô©[»>Û§\Ë^µû/Í›÷Q3*\É\Z’7ü\ÞY\Ï8\'§\àj·›š¹Œúÿ\0:\'hòrs»pH©UFmùUc”8\ãü\æ¾;”ýU\Zz—„°\ÈYÊª9hEÚ§ò«V³„{\ÛsEž\Ù\ëYJ’.\Ñ\"»òœ\çvGó«vl\àHÁp±\Ðv\Åe5Õ›Òž›Ns\å\"\0\êr}w\Þ\Õ\ZK5ö\É\r\Ï\å^cn\é¼H09=n\èw\Íñ·°!À\Ç\"¼œL9Z’:kRŽ\"•ž\èõ\Ëk\èŒD\æ`}\ï\áÕ·¢\ë÷\Ö2\Çå²•?ò\Í\ÆC}Ey÷‡5D:°¶•‹‰#;vú\ãŽk¥³t7Ì‘€L\îùú’=k»\r6Ú”]Ÿ‘ñ\Ø\Ü,\áR7G¿ø2ûJÕ´\ß\í+h\"–`¿hV\Üñc¨ô5±\åGÿ\0<\Ç\å_5XøŽ\ê\Êé­ –`Ld²B\Å7r=ªÀñ&¸À0:‰\Ï9.ü\×\ÙÃ‹ðÔ©F5)^K{[¸øŠ\Ü!ˆu„\íµ\Ï`m$¼…I9&°<y\×VQX´Ž‹Ü‘(ùI\Ç\×bp\ÞdŽHn\ëT<C¦Ayj~\Ô;`\ã¼®/%†›\Ý>¨ñh\â¥\Z±u\ì|ÁñÅ—>¸J\ïµ\Ék)\ÙA,\n•ÊG=«\å?höúþ¹=õ™0+0i“=õýs_iüxð†—«\Þ\Úøy?l•L’\ãqˆ\×\ëŽk\Ïu/€~ðþ›q\ç\ß_\Þ\Ã?™•L\ê»@\Æ:\×KNxZSmÛ•÷º=üUz5”®ß–§€ü4\Ñ%Žø\Ãc	d`elc\Óo¯c\Åz7…¾[\êz\Ð\Ô/\"[h¡ 4B–Á\ì:\êq^‡ð\ËÁºV—AajV8˜¸c—b:\ä÷5\Ð\ß\Î%›\ì¶\Ä%¼`lg+ž¿Z\ÏœÖ•ù%dtCMYr«”ôxwN™u)T.$?4®ƒ \î$ût÷/\Ú$¾­”%,\à.F§—šªß‡±‰Ã€¥\ÉÀP:\Ö?‹|B\ÐÛµµ¸\\ùa7&\08\í^>#ª®g\'o\ß\Ìí¡†›’V&»\Ögš\ìYXšR‰`\ÄtÀ¯<øQû0\éÿ\0ð·ˆ~$I£¨\êS›\ÄÓ %l\×s;\ÉùŸ“\Ð\àqÞ½CÁqÅ¢lw8šI¶‚\Ç¿µw\Ö\×0\")\0±XE \äý?ú\Ôòºõ°Ê¤iM§+]õ\ë¢\äwc0¤\á\Ïò\í\ë\Þ\ß\æ7M†=/Jž+K$·†4+0¢¢¢€\ÐN\r\'†fh	\r…F\' \ã‚OZ]HfC,3´lw\îåŒŽ \×ñ©¬ VR¥au<\Çp?§ZëŠŸ2³\Ø9`©»­Í¸õVóv±¤’\Ù\æH¥Pÿ\0µÿ\0\ê®âž¨\êwöš\Ë\\‡–Ì•\ãF;ô\ÈvO$‘¢\ÇJ\Ð\íK¿#¸ô8©NŸ5\äR#\\m‘PðG^s\Û\"»qzN›»ô\îr\á«,-UV^¦#h\Ö\×ZZ¶\ä*a²¸Šù\Ã\â\'\ì\í\ã¿ø\î\ïNðNŸi%Š0œ\Ë5Ð‰-‹vù½y\Æ<{W\Ö)kko’\á÷	:tÒ­x^Xôo\ÚÊ³†ú/²¾s‚\Ù\Êg\èxüj°\åƒ\ÄÂªz=%úi\êrc\ë<F\ZpÝ­cýzø›ö:ø•\á¿F\Ý:ûjy·1It°˜7,v°\Ç·jò¶øU\ã¨\åÚº÷¬{,‘{H¤©ü\ëõ–KDº·h.¡YQ†]r\re\ëþð¶©n\Ë.…`ó¹-\Õw|k\íe\Z®.qü¯f\ß\ÝúŸb‹Q‘ù\Ýðg\á­wz\Þ(×­Ìº6œ|©m,\ç‰\î\æfT\Ã`g©#q\ÍzŽðºkM\â7\Â\×:™¢Z¤‰Â¬“\Ì°\Ä<€Ê¹aÀuš÷ýCöð}\åû]‹Y4ùºµ\Â+B1ƒW-~	x\Z\r§R{«ÓŒ»½m¸‹‘Çµy´±˜™EKØµn¯\Ì\î”ð¶w©{ù?ó>9øÖ–\Þ7ñ\"^h­qs.$4òBwRgToÉ£*F2=\ÍixO\áG\Ä-n2l¼/¨Ëˆ>Ñ½\íüãŽ›°{(ü}=¿\Ã\ß\ÂñZ\évBEU\Ãm\îaœ\Çükªð§ˆl5«!5®\äq\ÃB\Ãkš¤~¿_\Ù\âj¨½ùS»;p¹¥Lº“©†¤\Úz^_ð‚¼+—£\ë\Úo‰t\Ï/P1D—(W\Ép~a´\ã\r\Çz«\â)l\î/e66þZ’(×€ƒ<Zöo\Û\á=\Ô^\'»ñŽŒd¼‡R\Ïw\n©/høq#ø	žÇ­|õ\Ö-oü³‘‚\å¢\È%@þ.:Œw¯œ\Å`+R¯(§t¾Àfx|]\×OVµW\ÙõEÐgGc÷W¦\Þõ=»\Åi&(O(\r“CyngÏ’GC\ïI‹ Y3~•\ç\Îò\ÒÇ±JE¸\Zfc·$gþzÒ´t´òÿ\0\Ö1\ë\É\rT±\í¥Î¾l,p\Êz·\Z¾>\Éþ²\Õ]\Ï*NW\Õ\ÍZ)F\Í­\Zh™\Ñx&YŸÅ°4\rlÄ“\Ðm\Çõ¯F€F²l(dÝ¼¶H\ã=\nñý?SK\rf)™”	d“œ\0\Åz²™	\æ+À|›\nö\ã\0ó\ïùSÃ¥k\Øñ3\Ü\Óï –/5½ý\Ô\ÐNU\Ì8l0]ÉžF;ö¥8\Þ°ÜŽ”\Ë\è\å\âxIû©C·IÁ\É=9Á¬Ëµ¼Ž\îX\Ë\çc‘•`\àö«³\åµÚ·\êy\éBRm\ØúŠ\ÆWš\Ý7*ü¼\àz\×ñŸ\Ç#\Ã\Ð\ÛY\ÛY‹¶ºr“\É\æ\0¶\É\ê{“ž\Õ\Ãø\ß\Ä\Úú\è\ÂCTšg˜ù‚\Ö\Í|q†\ÇÍ‚y\äšóñe¨\êŽ$™(z/$\äö=\ë\Ý\Ìø‚T\èýZŠ¼\ÚWð\Ç\Ãeü<§?m^K•=¿\àMžµ¡©¼\×yŒ[–#<\ãôª~)¼º\×5-ª\\lHó\Ä)\Ç\êq\É\ïVôM\ê\æ#g¥¢<ð€d–i0 ñÔž¿J¯s\Zi³\Ëà²œ;žzÖ¾~XŒD0\Ê\Ò2{ô>¶=EB‡¶n\Zµøf’;xã²³c.Àöýz\É\Õn7í³µ$,Ÿ4¯ŒUý\\”½ò\ãL©µŠöþªÎ¹Å¢;“ó\Æ=ý­s6ù--Ž\ÊT\Õ\ï\Ô\Ï\Ô\äK+!\Zœ6\Þ\Ý\Zù\ç\â\Ï\Æ	¬õ\é4¿Eouöf\"\ê\æ\\²³wDÁ\í\ë\ë^¯ñ+T{\Ü2>Ù¦£<rF3øk\ço4·L¶—YÀb¯{‡0\Ø*Óž#²\Ò+§›¡9›\ÆÑ„i\á¼÷}W¡öŸ\Â\éu/i—–\ï°^Ù£§!²£?ýjôM28V\ÐI1P\Ðþñ\ÝF\ì\àw\Ç5ä¿³˜¹·ð•c;+\Ïe	‰Šðÿ\0LW«Ü½Õ¹WŠxº‰c zÞ¹°¿\í¬b\Ú^—\Ðõ1‰¾^ŽI2mK2¬3\ÂQ i2²F\ÙROC\Ç~Æ©Cyko©=­\ÓK\äÅ»\íD?\Î<\àô\Éµ¥dt\ëÉ­\Ü#B\Ã\n\Æ,\î,GË_^•\ËIa¬[xŠ\ê\Ê÷\ÉEf/<œ09\àž\äœ\n\ê\ÄNt\ÔjF<Í»y”#©S“µ•û=ÿ\0¯À\í<:T\Â\ÖÒ™a‘\ÈeY%ccœ\ß8<úS£¶Vc\å^Ü¨4«!lŽ„sXVúý½´€‰\"y—¹,\ÌÀ¸?—©\ÇJ\ÔÐµ®\å\Ûy\çq±Š\íEÂ &®¦3\ä©\Ç™\Ç*\áz;qº\Ãja½…p²)Ç™\éœô<\Ö&´—–‘\É”\Ç˜ù\Ü\Þ\Ø\íÒºy´h..mŒ‰—\Zf\áI\à°\ç\í\Æ9ô¬}\æ²Ò¾R+ˆ\ã¾søõ\ë\í[\â\éÍ¥NJ\Éè­¿M~G&\Z´U\êGVµŽÇ¢x#Å–Zµ¼—/\äj;´Rq\æ9e=þk¦\ÛÀ=\ë\Æ.,¯­¼Ae©$oö{•yQOðƒ“†ƒŽ\Õì–³\Åql—¸x\åP\èÃ¡k\ìòLu\\L%O½\è[^\ë¹ñù\Æ–q\î\Êúv}‡>\ß,\çÒ¼³Åºc\Ã\ãFÔ®.\Ý\Ò”\n\ÞGl¨`@\Åu¿¼Y¦xWG[½Nc\Z\Ê\â8U»\Êç¢ª¨\É5Àjš\Ãj‹4wù\Ã%f\08ô\È\Ïµó\ÜU™\Â…8|Q\ÕÎœ“UÞ¥½×¡\Åx“K\Õ\åÔ§—L™\îŒl]Ù›\Õy\í\ïõ¯BøA©\ä1*Gõ÷=ÿ\0\ZÁ2Gn†5`\Ï#ò\á²q\Óô­ß„öImw-±\0“z¾y9\í_„\ÄJXš^\Í\ÚJ_-ö>ŸÔ°’RZ$zˆ·Õ¤H\Ô3˜ã¯µxŸÅ¿~º–\ãY\Òô\ãhgm\×1\Ûð#\É\å\ãºò:W·A˜\Ð+õ¦]!\Ú\ØWú¦/KB\ÒV}\×G\Üø|2¶¯4%ÿ\0øO\âWƒ¢ð†¦–6v“¤ñq#\Ç, \àõ\ã\Ô\×*\Í\è]»‹Hlg8\í_K|rð¨÷\Ò\\Z$M	\ÜcÜ¹À=Ex³\á=oM³ûdk„\Ý$«Þ€ó\êYqZü\â´\åR½J|­Itý|\Ï\Ø2\\M*\ØhI\Í6ü\É4Ä–\â8l€‘Ë¾\Ø\Ñy9>•_U­¤1³•’\'*\ê\ÝWÚ¶’S¡1iaI\'–qž#?\ã\\Wˆ/\Ü\Î\î\ï–s¹«Î„\åUrKNñ•úxª\éœ\ì\ì¯¨+\Îk\×~ø´ø§\ÂVW+{\ç^„XœIÂŽŒ{W\Î>>\Õ$m\nP$€=)Ÿ³Š\æ\Òu-#¤¿)¸\è˜¯U\å\ÓúŒ«\Çx½»®¿\æ7ˆ¥W+ø\Úþ¼Ï®oO˜…ea\Îw\Ûÿ\0¯X\Í\ê±X\ïP(Ûœ\Ô\íTƒQµ\Ø&\n\nó¸ô>Ø­4²·(I>q\ÏÝ¯\Z\Þ\Ù)/\Ì\ä7Iò\ËFv¿%X’9n\Ö(œF\"†$\\±Ó¸¤÷®F\Æ)\ZÕ¤Œ\Ï\Î\ÌaA\è	=\ÍhøŽþ\çU\Öd\Ô.\ÑŸõq§E‡½S»\Ö\Zr%{Ž\n\æ«]}bs©&\Ûù3B•HÐ;\r¹€\é:t‹qu²JÀí·`ö\æ±\Ò\ëlfG\Ç\Îø\ï\êjž«¨\É.\çn§¡\ÍU.÷-\Zv`r\éXF·¶«xü(ô)\á\\ay\îÉ¯¤‰¶p\Ø\é\Íbêº‰û<Ž~vE;[mlGoupBZD\î\Ù\çb\ç\ëÒº¯øK›umBÜŒÁ\\}\ã\ïþ2J\Õb›4r£‡‡5F|÷y¢j^)Ô–\Üg$x\ëŸA\Ü\×Kaû=ø¦\Ò\Ô_In–ñ¹w¶\å_Qx3á¦kªÃ©µ¸ó\â\å\ã½\ëH·º¶Mu^\Ì8¯¶À\äø\Ú\Øf\Ó\å\ì»úŸ?\âzpª•(\Ýug\É_´û\ê`ºe/Ž½5 ”,®Už\Þ<8<\äd\Ï?¥g|eÓ¢²ñö\ëd‰\Z†!z·Súb§\Ó&¸}6\Ý\âs ±\å[<|§\×Ú¼œgJ¥JU\äŸN\ç\ÑÕª±8j8ˆ\ét.£òÛ¶¡§\Ä!’Ñ€`Œyö\Çs\Ô\Ó[Fk\Ø\Ìú\å\ã[5\Ã,\í[€[ž}»sW¢·\Ý$2™Z7\nß»l…\É\çúSüO«©\\\ÜchUUøwòsŽ8?\ä\×}\\#¨¹¥¶štë®–g\ÖZ„]¼úô\Òúõ)Ioe¥ †\ÂEHS÷ƒ#¹9\Ïø\Óàºž\Ù\ÄÄŽ¬0e_\á\ÆOò§\\F&v€)~ÙÃƒ÷‡^EEsqk‘\Ñ2B¼O?\n»†‚Œœ¾-3 ÑµVX$Ü¬Œ!*U\×;ò\ëƒVü9k5­±Ô¤;q(ÄŠ2@\Ç•\Ë\Þ\ÏVQµ»$»v·•\íß­oxBòþf@`ŒÁ#ò;\ç>„\ÕÒ±Œ\ÛvÛ®¯üŽ<E\ZRœ4O‘»n\è\Ò=Øº\Ë7˜\ÛsògŽ=s[þÔ¢\Óeo\Þ\\‘I’\ÞB0JûÉ®6Ya³\Ö]®mœD\è_Ž5X\Ô.\Ö\êMv\ÚU\0\n°`0Fs‘ô¯r†6ToV\Z\Ê;«½W]>\æxøœ¶‡$¾³\ÓG\ÓõGOã —L®Pv>\î}+ƒ½‹Ì¹Ø„\ÐJ\ë\ï\ï—WÒ–\ê\Õ÷+\0’§\Ð\×)sivóˆ@-É¯„\â\\G>5\Î[>ß¡®UeO‘\è\Ð^\é\Öö¤M*\É<ƒ2ªŒ˜ý>µÁ÷kmvc*UW=¹=?:¥™t*‡žù­\íC\Äbœ|²ðõÅ†\Å{lLc‡§e\ÑÁ:13‚¢\ÕI\Ü\ïlfómÀ”gŽ\rZQ8ª\Z\\B(„ný¾RÆ­[\î?0$W\ì\Ø\nµ=œ=ª»\Û\ÌøJñ3\åØƒZ°‚ò\Ô\Å*+:^Mñ?ÀQ¯-­¤óNX‡\Ë 0²ü+\Ù]YÀ\í\ß5ð>Sô\ÏcXfy-,t¹\â¹]·H\ìË³J\Ø)\'ò>ø•k¨\Ù\êe%´“¸\n}\ë\Ïu-W¼27“\"¨]\á•þW\èV­\à\Ý/U•¾\ße\Ør\ß:y÷¬\ÝW\Â\ÚdB\é*‚0V1\Å|uƒ†¼š\\««\Ðýýw¥:J\Ï\Þò>\0Ð¾x‡\ÅwðZZY\\O»šO)0W’NGVO\Ä/	\Í\á-a¼”$¸\'Q‘\Ó\0_ šO†\î,·\ÜhN‘ý ²È»@@¯vÎ¼\ï\ã\ï\Â\ãy\á‰\Ò;d”$G\Ë`£tg¯\â3UW‰\Ã\ÒMA¸\ßÞ²\Ò\Ý,úõ¾„\Ð\Îh\×\Å.iYô\×[ùŸ;ü=ñ3µ´SÁ¤÷¯J‡\Äö&-´£?/ÿ\0^¼3D\Óõ\rU–\ÒùXF\ÍÁ=«´D%°G½óØº\n[¥+&~‡M\Ò\ÅSŒ\ên}¡\è-qnždnHQ¿\æÁ¾+ª\Ó>hºh£“Š•.N?1[>\ÓVBŒ\Ê09®±g·²€“„U\î\ì\ä9%,E7W—/w¿\Èüg0\Í\ëF|´[O\È\á¢øO <n÷–+.ATÌŒ1\î\0©tO†\Ú6›s¾\åQ¢LlŒÀÜƒ]eŽ®—Á\ÞTrlzg½c\êò_Í©¤PÛ»»0\Ø;#BS^½|&Q†„\'F—7kuõ}|Ž8có\Z\Æu\Zùš\Ï\á\í&\î5Q;\îˆ\ÑTÊ¤³ðå¹A`y­>\Ý`€\"\ç\0T\Ò)eÀ\ã=\ëè¡–a¤•i\Ò\\\ÞG,Ukò)»\Çk`^*@>Z€ý»kmò†\Ê[\'Ÿz–Ì I´7|t¯BŒ \ì£¾V9\ç\ÍÕžWñ\ÛH3À.\Ò<\á°\î%G­p~y\"VÆŽ‘ÏžA\à_Zö‰Q˜ôi3\Z¼R)$³ð?õ\à\ÖO‹\Éy”´»UOËŸlûq_f°X|\Ù\Ûw­\Ò8r´«\à]\'²\Ø\ë¯dŠ3\'–#\ÞDr\ä‘ ø®rJ}”F\âÕ¡Ž|K*”!>c·‚;qžxªº,=·”×³\Äb+½eP#$\ç\Ãð[A©‡–\â$Ye\0…x\Ïô\ÅuO[M-?®\ÇD \ÒpoUýu*\êv—VŽ\r”@¢™‘×•Á\í\íU#¸\Ï»¶\0B¸$7lŒf·£e¾\Ó|»¥M² /Áù\Üv?ýjÆ¼…`t0YL…X‚	œö\äŽùü+:”\ÒJQzv.•G/vKUÔ•Sº„#HÀÇ¼ckw\Â\ç\é\ÍO§µ­¦£’•K8ÿ\0–‹\ê=GµV\Zc\\\ér\\ #\É.[p\ã¸\ãZš;»\'‰-\âYÁ]\ÞjaT\î\Ö¡%g%eºo¯\Ü]ù“Šw\ïn†ô›\ëotu8\Ë}º\×1ý¥5ªO¥Mj\æÕ§’!“\'§=¸®³Qiš8o¢Ž$epðOlvúW7­\Â\Ò_\\H\"IÀN=rúR‚¼^¿£#/”%¤ÖŸ“L\ê¼}~\"{Y$B·	°¨<#óÖ1˜\å`šòý$\Ü@±\É9””ù\Ó|\Ür7Â½£K‘f\Ó\áF<\Ø\Õñé‘œWVUƒ¥Œ¡Ym¯\Þ|\îyaª\Æp{\é÷!\Ò6•ó6òz\Z\ÑK4ˆU’8\æ¦U\Ý\Çó©À\0=«\è¨døZ)û8üÏœ©‰©-ÙŸw\ämÊŽ‡Ú´\í/<ãš\ãóW\rÀö©\Ða@®¼&Ò­)§£9\ëT\æ‚CÔžô\ì\ÓŽÔ§5\îBm+–°F+;SX¦F‡z\ínõ\'{U\rz\Í\æƒÎ…\Ë\Î\Ï\ïoz\å\Ç^t$\ãù\Z\ÐiM]\Ø4\È8–,‚TgQø–\Ùd°|F\ä#¡öªZ\r\Ê\Éx\Æ\Ý\ÃD>WMÜ£¼VÄ’C6`¡r›¶n±\Ó8\ëŒ×›„©FT\â­\Ðéª¥N²lùƒ\ãWÃ‹;\Ã-Ý¤9 )\ë^4|1®¡\Ø-¤\ÂñÒ¾\Ô\Ö4´\Z„\ÑL¡£•p\é\\Œ\Þ\r„\Ì\ä:`±5ù\ål\rNv–=W\ëó?B\Ë8ŽT)rIß±\è:Aa/ñŽ­O~\ÐÇˆ*\Æ\ã\çô¨´þ&¶QÀò\Ï•E\â ¿n„|¥ùºW\ÖT’£N+k/¿s\á\â¹\ë4ü\Èlt(WXŠ\â\Õ\Þ8\"\Éò\á\É\ï]4\0wm\Å%¢¨N\0zU¨úW­•eô)A¸­\Ýÿ\0\á»Ø¼EIµv\nœsO\n;Ð½)k\è\ã‘À!*3\ÇsR\ÑJt¡=\Ð\Óh\â¾$X\Ì\Ú4\Ïo’2\Ûs’~•ó¥õ\âA©aþP¤aO§|\×Õž&\0\éW\0ü‡µ|§\ãX\ãþØº-w€\Ç#­~Y\Ä\ØHQ\ÆÆ¤^­£ðUW>xH\Ü\Òu¶È¨\å’`F\Ãüg…\Ç\âk¥†W†D‰oy¬U‹ƒ\Üöö®Dùd³e\à‰r\í\ÍwNL\Ú}Ì²þñ\Íö7$ü£½,¤\éJm\êš>ƒ0£ÕŒ\ÏþÔ¾q,Š#\\—å¬¸¨ö¨\\%å€Û©T?,¨\Ü\ÄÞ‡üiÑª¶­ *\î\Ðr>µGE–S©Lå——\ä\ÜvþU\é\Ç\ß~§ƒ(òE[ÈŠ{7\Å} 1€;“\ê}\ê_\Ë$\Új\ÎbH’2²G\Ü\à~DV–Œ‰Á9¼Š£rÌ·\ë±X™~d\ny=Ed\áî´¶k·cH\Ô|\é½mú—\'}\ÚPfÂ˜ðª¬HÇ¢±þF²õ\'\Ú %¹Zžr|¹y<ÇµaÙ³—F[±®l\\¹¬Ÿc³	K•6™£\Í\Í\Ü\Ö\Úe½\ç™5Ó¬@(9PO?¦k\ÜlaŽX\à\"@€{Šñ/„Q\Æ~#®cS¶6+‘\Ðã¨¯r·^‡~ò5j\Ë{¥÷;\Å~\åjt£µ¯ó\åbdP£§4`\Îy=\Í8t¥{ð¯­i[C\ä±\ã \â@P\É÷\é¹r\Æö\"\×d\á†8\ì\Ôi÷<}\ê¨MÐ£ƒN™@\í[©4ˆJ\æv±§¥\Ê?”¢)\"D;½kš\Ôü+ww¬i:ôW\Ík¨\éSd6\Í\ÂX\ÎVHÛžU\Ôþ)\í]±=)Ž•\ÐW“_Nu=ªm?-\êX™\Æ<¥-R\Ñ.T8«ô©7œ\×Òº`–x\íQ3\ÐW\Ë\éV©\Î÷4£^p\\¨ÿ\Ù'),(11,'584732be7985a','ÿ\Øÿ\à\0JFIF\0\0`\0`\0\0ÿ\Û\0C\0		\r\r\r\r\Zÿ\Û\0C\n\nÿÀ\0\0ú\0ú\"\0ÿ\Ä\0\0\0\0\0\0\0\0\0\0\0	\nÿ\Ä\0µ\0\0\0}\0!1AQa\"q2‘¡#B±ÁR\Ñð$3br‚	\n\Z%&\'()*456789:CDEFGHIJSTUVWXYZcdefghijstuvwxyzƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹º\Â\Ã\Ä\Å\Æ\Ç\È\É\Ê\Ò\Ó\Ô\Õ\Ö\×\Ø\Ù\Ú\á\â\ã\ä\å\æ\ç\è\é\êñòóôõö÷øùúÿ\Ä\0\0\0\0\0\0\0\0	\nÿ\Ä\0µ\0\0w\0!1AQaq\"2B‘¡±Á	#3Rðbr\Ñ\n$4\á%ñ\Z&\'()*56789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz‚ƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹º\Â\Ã\Ä\Å\Æ\Ç\È\É\Ê\Ò\Ó\Ô\Õ\Ö\×\Ø\Ù\Ú\â\ã\ä\å\æ\ç\è\é\êòóôõö÷øùúÿ\Ú\0\0\0?\0\æþ|i\×l…®›a+\ÍeÉ–‚w\î„t>\Ý+\'â§Œ¼K\â}Vm/M¾xcq¹§’Sý\ÑTô\ß\êW·\"\çF‚T[»R\ë0M«‡}z\Z\ÖÐ¾xŒß›\íNþ\Î\ÆI`ò\äB\Ê©ðÐ•Gf‘õóÝ™\Æ|=\×\ÓÁ\ê,\Æ]r\î\î -\Ú\é\Ï\î\ÜžO@iŸ­õ_|P>%ñÀX­÷2@\Ì\Å„|¨\0=zTôo$3k²\Ü\î6À¡s\ì\rlxc\ÃZ†§Tœ]ùIò\Æ\Ö\ê\Ìz€+ª1®\âî–¿‘œ\êÐŽl\éô¯k7ò\Û\Ü\Ã{m%©;®‹g¢zþ5»ñ#D²—Ã‹„Ü˜—ý)¶\ÈHþ\é\Å3\ÂZŒz¦•­Gx›·œbA\ì@ÿ\0\n\Õ\Ö5¹\æ¹hFœ\ï0]À\Ä@\ävbkhÑ#Q\Ü\â•i9¦\ÎcÀwZlúcYË¨,ž[f\Ý]\Ê\Íþ\ëŽø­)&†\æú[co³¨,Ä‘×°\íQ\Ûx6[\ë\Ï\í›ûx\ìnŸ%¢´\Þ\ìH\ëôm¼5m¼ùŽ3½ù8õ¥JŒùm2*U‚•\ây\ß\í\á¸<Q\á5ŽFo\"`\Ö1\É\Óoò8ü«\Ë<9ð\ë\â]•Ú‹­:MªA\râ¾ù\Í{\ç‹-g†kks\ÄÁƒª†h\Ï÷—#¯·z\âüs\ãýj\Â\ím/­V(‰\Û\çC\ÂI\è\Ã\Øþ+ª0å…“k»\ìsz\'\Â\ê^1·¸ŽX4ø™óx¥÷‚½Ê¨=O\á\ëZ^-Ò¼K\á­¬6y¥Jø·\î\0|÷þøô\ï\×5\Úü=×š\Íb\Ôm™gC:¿ û}*ÏŒ¤²ñu\Ô\Þd+	=a\rò†\ê1\èGb9§\í\\d>GQ]œ.\ãÿ\0\ì\ÝA!º·º·S\Õd7\à;Šô­\ãO…tû5{Û‹´#¨ò	?ZócK³K%‡RhKy6–rD\Ðg¸#ªŸZ\Æñ—‡\í­|3-\Ü7™\ÐHÑ¯÷†\Ð	µ•Zô\×4uF*	¾YhÏ§~\nüO\Ð>\"\é\×wšó°\ÜfŠu\Ø\ê?…ñ\èÃ‘^…\r\â}3_|\Ö\âðŽ·y ø‡M½R‡l¨/6äƒ•“ù×°[üMñ\nÎžm©À\ä\íù²=±]Ô±P’W\Üã«†”$\í±ô\Ü7[±†ýjU¹ p\Çó¯>ð?ˆÎ¡¥EpX\åÀ5\Ô\Åxz\×Zw9™ò\íµ\à­K\Ã;“\Æ\Z`—û+\\”I+&JÁ?ñ©>o¼?Jñ½ó¥vW2\Ú]!Ê˜e`Á‡F\\n\Ý+ôK\Ä\Úf•\âM\ëD\Öm’\ê\Êò=’\Äß¡±A\í_\rütøQ®|7ñŒ\Ë}«JÌ–7LB<©Œ•ô½\ï×½}6UR^\Ê[þðO½\áü\Þi¬=_‰m\æ¿\Ì\Ýðo\í\ã\Ý\Ö;\Å‰´ô!A½n\0ö˜sŸ÷¨?hpx£\Âpi>]KJK\ÃPY\ÜnP:FŒ§•=\Ï•\ä\ï©:“x\å\ÈlõS\ï\\ç‹¤?\ÚqÁd\ÖD<.zŠ\ÛKMûE®‡ml·\Zêº§i.\Û_\Óaºf­s\r\Éq(\ç8ó\r{ŸÁŒ\Ö6¿\rõÿ\0	x\ÏT\á–\ÔÅ¥#~ñJ˜ó\ÙT\íažœ\×\Ìú£\\\Ú\Ý/(,Ok{E‚FFk€AT%Hþ*ó¨\×rN“Z\\\ÊnØ¼<\ãð´\ï\ÕXÝº»º]^Xå½•\çF\æy s\é[ž8ñUîœ–Wþ#Õž$M°\ï¼r¡z\0Fk™\Ô#/­\Û0r\ÈMF:~8¦;†\r¿\'<Šôi\É\Ã\Ýg³œW4v\Ø\ì>A«\ë^7\Ót-?S½š[û…B‘\\¸@Ÿ\Ä\Ä\Ð($\çÒ¾¡øññ\ÏOøk\Ð4[q}¬\Åª£œAh1ò\ï\î\Ç;G¶M|o\à\ÛýGD\Ö?¶tû¹\ì\çƒ\îK•a\Û\0\Ög‹üMw«j³\ß\ß\ÝKuup\å\å–V\Ë;z“\\\Õ\'^iü‘\ác°4±\ãSnH\ßN­ùùÅ‡\Åo]üM_\\ø¢ð\êq\È6H\\ùh\ãòúÿ\0\Ù\Zû?\á\ÅO\rø³\á\ì^\"\Ô5m?L’60\Þ\Åqr±ˆ¥\'nã’¤G\×«ó—H¼&\\’>cÛŸÒºm\ÎK›W‘ˆ\nX*Ž¬\Ç\Ðôa•<D9z÷#–\á1øxòû®=R\é\Øûƒ_ø\åð·Msÿ\0b\\ºœ¡C$¿¨ýk0~\Ó\ßÀÀ\ÔuRþ\Í~Zù«Àÿ\05-Uay‘U¦l\ÇŸ2bƒ©*¿tpylWN~i \à\ê6¹ôþƒú\ç]\ÑË¨µñ\Óáœº\Þô\å—ù\æ½\ã-z\î\êk]\Ê\Î\ÎþA4ªwgGZ£}i«\Ý\éQ\\\Év\×3/ú\Í\Ã\0þ\ê\ßb]6+»¨’+‡¶$³\n/û\àf®i\ÞšûNZUŒ¿u\\žkòZJ2n\'•RNš¹\æ>\Ð/uÁ%\éhm\Ôg\ËG!Z»\Ó\á©\îv\Ú\éè± ¼b·´¯\0\Ý\Û\\ÚŽø\Çð\ì®\ÓK°†\Â(Pq\Ô\×T)\ÛDŽ*Õœ\Ìx\×B´k’‰%ä«‰%+\Ï\Ó5e|9d·\Í(&S\ß•i[\Þ]\\x‰\ìX!8=InŸ…TÖ¾\Ó=Ç”’˜\â_½´r\ÇÒœZ¶\ß3ß©WU¾µ´M e‡ð¯õ®KR\Õ.¯n~\Ïgå¬Œq·©\×\Û\é¬žc!‘s\Ï5\ÑbŽ\ä\ÜDŠ²öy.w\Z‚G\ã\'T\Óm#–i\Ì\ì\é–\'\Ý>œ\×%{¦Z\ë\Zd\Ís†U$\ÛJ€3v<v>â½‡R\r3yŒ\ç¦k’\Õ<mq¨-ÔˆW\rò•\à³v\çµ¯\ZnòWEr7¢zž;\áM+\ÄZ±ukk§\Í{¥ÿ\0GŸ\Í!byW¯{\Zß˜N±C0\ä	ú^½¢i\ÖcFkx\â@Qˆ!zf¹_i_\ë#\0\ä\ãŽ(^þ¶\Ð\Ó\Ú8h™\Ç&‘%ý³\ÝMz£¾Þ£¸ õ\Ø\ì\Ú\ÒŽ\Ø\È\ÈyÙŒªúnâ›¨-õ‰*ÿ\0.\ïîœŠÁ¶Ôµ-2õV\Öö1\ÉóA9ùô_Cô®„\×-ŒnWe\r_á·…õ]_\í·\Z3A9m\ÒW1,\ÎTqùb½;\Â¡iZ2ZY\ÚE\ZF¼&9ýk&\Ï[±U¸ów…7¼er\È1úq\\<U¦-›\Ýi\×ñy\à}\Õnô¯+ûÀ\áÍ°ÿ\0üMO\rüR¶ú–£\0Hƒ8·”Œž~h\Û\ål¡÷¯[øQñ†\Ç\Ä\É$H‰41yžxRU\îv’v‘Á<÷¯<Nš–½\â­yDE*]£“Á\äž*\êZÆ˜%StöÐ°(\Â3´\Ã}\ë]¸zs•d¡-\ìiK\r\íùi\ÛW\Ô÷ŸŽ´oˆõ=Jm+À÷¯¦\é°1C{\Z>èŽ¥Iû‰\éŽMxÏˆ<c\â\rz³kúþ«¨Å»xŽ\êñ\ÝU½@\'\0\ÖTò[3`:…ôJY-Œ\'7&¾Þ’£F*0K\Ôû\Ì&†‚8+®¶\×\ï5\ä\Ë†õ\r•$ò8ª—N®ª\è¬$¿¨=©ñ!ž`¥ð?•& ¿eŒ§st½ENiA·±\Ô\à¬\Û\Ø\ë|#y\à¤ð$Öš\ï„4\íOU’7û=ô¦Uš \à¬€p@\"¹™¬|9¾ÿ\02úüòŠ9† sÏ¡cú\n\î&³ðô_\rô\Ë\í*p5TcòKŒò§•ö\Ïs\\Õ­´p^,\Ö\êe’^\î3ÿ\0\ê¬0”=ª“Žš\Ù\Ý?žûÿ\0Ã˜\àð	¹I{·zÜ±\á:\Ùô¡g¨\Ï$!\Ã9\Û\æV\Ç\ËÇ¹\ëXº…œ\Öò´n»H\äg¸õ\Ú\Åbð\ÛEt\íy§!7ø\Z\Ëñ+\Ë:”û4~Z!y\Zöª\á\éºi.ˆô\å\è¢üŽz\Ø=Å¤–«\n w=3T<\á/ø¦ö\î=&\Ê\Þqh\ß8–\â8\Ð#?…ké¡­oe‡GP:©\ê(’	¬õCu¥N!ó2Áò\"ž ú\Zñ18iJ*]Q\åc°U\'\Ê.\Í~&M¾š\Zõm Œ¿?\Ê1\'$08#z\ê<!¥\Ý\ë(ƒA³’8™\åò÷†\01\É=f\é¶wV,\Ó\Ã§\Îgp@Œ\àúû\×K\á/‡\ï\ã\Ô,\Ú\Ök„ÉzU>¸\Ï_­w\àp\Ò\æ\Õ[¿õù”pUy4ü9ôUŸ‚´¯\nxatK‹Ï·\Ý\Þ(?dÓ u–\ëƒóIó¨=\á{óU›À^\"v/¶V\èÜ¬>yý\Ðþ\ïŽ:q\ÅyDün«&\Íu­Œ§÷(Žý†\æ\ÆOô§\Âs\ãžþ,\ÔAÿ\0®ƒü+¶x|]ýÖ¾ðÇ‘[/\Íy¯	\Åz\Ýþ²üOM¸[ø\äMª\\ùQ$ÁÁ\Ïnq\Ï5\Ðx{\ÆÚ­Ò$\êhÖ£tB†t=~a\Ës\ëÒ¼\ëÁþ#×¥i Õ¬\âr¸\Û }\Ê}ø\ãðªö··_\Ûm»–&™\'\Ì„\ÇEcŽ‡Ò¿Ÿðõ\çC\âå¤1SŽ\"‡5µGµ\Ú\\\ëOi\\j7\ï,¼ƒñoJ\Õ\Ö<Mo\á_ý«W¾‘~Î›‹;\ì}½MoxV[-KÁ–z¢\Ã\Z4\è9Ã‚>™¯™l\ÝoS\×/\í|3¤¹\nX¼¬@‡µ}cÉ¯6\ç‘*ž\Õòò\Ú\ÇÒ¿¼Ea\ã	\é—&x/\×(\ì¸~§;»\ç>µ\Ð\ÚO’M»\î«v¯ý‘^?|\Ñí¶¸…šO´\ï?q‹žG·ø×²\Ø\\[\Ù\ß%\Ë\Å\æZ\ÌD›‡}G\ãJ2¹böf‹RmšS\éW\ÖÑ¿’¨Ž¢L\äpò¬}Fö\Þ\Í]®[`÷©|k\âØ¤žK\ÖÏ–£\äªök\Ê<U\â\ë]D‘5ÜbOÝjÍŒ{bµnÐˆ©[S±—UÓ®µ\Ød{²\ä\"¯¡\'’\n\è<ifñxr1hÁd‡\ç,:\ãÿ\0¯_>xª\í®Yaµ\ÖfÃŒ†’?+?Lô¯Eð\ï\Ä(\ïth4ma\Ýo’b8Ÿ\é’1ø\×=dœt5‚÷‘\ã>&øÇ­øs\Æ>]µ š™š)!•px°\'5\ëž\Ô\'ñ\'†­u;„	%\ÄAÊƒ¦kÀÿ\0i	|9‰Ulä³¹‚R>\Óo»3,2\0\ç\ß\"¾‰ý›´\ã{ð\Ú\Ó\ì¶WQ\Û\Ú\Ä¼Ñ=¹ÿ\0\Z\è¡Q´¢ñ\ánr‡ˆ¼>n c€0:\×	y\ácwxm\Ý\â\È`\Ê3´Ž\ãÞ¾:[”•C3\Ó\"¸ŸÁ¦\ì\Ó\Ò5‘¥\Ã¥S\Zž{Rƒ¨ùby,žº\Ó.\Zw’	Y\Ûoš$\Ø\ä€©<\Zòÿ\0Šž“I½kÄµ•`¼9*#\á[¯áž¿{¸\ë(y\î\æHž#ó!Lø÷­{\r\Æ\ïA&;»K\è®\ÖF]\Ê;\ã#éš¾h\ÕVµ“Ø¸\É\Òwn\ç\Êv 	ž{l#‰\ÇPj‡ˆZ\ÙYJ\Èð¼ƒn¾Uö\'ß¥}\â†–r\\o—KI\âH\0Vú:\×\ão„·’>Ÿt\èÝ¦?\0\ß\â+j%BjO¡\Õ\nñ\çS‹\Ôñ¤2Lv f§HH\è	*þ¡§\ê\Z¦l5h\'„“¶1*\å;£w\ëR¨yCü¹\äf¾«	\ÃÔ\Û\Ô÷ðù•4½ýGOVINÿ\0òiÌ­>¬©&\"Á\ÇlÖœZUÔ 40±ú\n­weqev\É,d1Á#ô¯J†\"& ¾¯©ß†\ÆGYB;-}Iü\à¨Ê£\åc\È\ëQ­\áI#\ÚG\Ê3\ÅC\"\Ê\0\'\éÁªºÊ‹sV\ã5\Ù[\ã®‡³Rº„nvú¢/t;›IUPn\ß\ìpîƒƒ\ÉíŽ¤\Õ	b\êeF\Ã8_Æ¹}>öbDi)U|ƒŒ×¢\ÜÍ§\É\á[K\Ø¾\ÌD7;N\Ò\î{\ÕøRKp\0 \nº8ˆ\Õ&5#£¶\ïúû\ÎLƒ\n3\ÐI\ïV|90Ž\Þ&`	œ¶üÀSõˆ\"6`DŒ¯pp?\ÃÔœ}*´%aP8F#\àûWZ·´º\Ù~ð\Çd\Zœü‘­fò<Zo/\Zóy\Ú=µg8’\ÚB\È\ÌqÒ¯Z	>\Ó\æ`ñË¥\\¿´\Ê  !—+žÆº\Z’[šÎª„”N›á¿‰ü44¯#Uylµ86w+\Z”\Éõ\ã$ÿ\0¼q\é\é^€¾7ð\ÉPdð\än\ä|\Íöø\×q\îq·¥|\ïª[\Ëg3«£A¡uY™@õ\çT”9\ß>ç—‰ÀS­>k¿¼\ìþ\Ý\Ü\\ø\"\ïS\Ô\î\å\Ýw;<EX.Œf»o:´+²\î2Ì£½3\ï^o\â†‹D\Ú-‘6,dq\Ó\Öx7\Ä‹4K¨±§\Ìc\'œ\×áµ°Ru½¬•‘òªr\Ò\åR\Ôú\n\×\\Ô¬¬\ÛN¶\Ôf‰%LŸ/¢ñ\ÜVV…£®©w\ç\Ü7™,ŸºwnI\0ü\Ç5\Íx\Ä\Ð\ê>$6w>z\ï\\ \Ï\Ðõ\ÍtË©¿‡õÁþ„ò\Å)\Û©ãž¤ý+\ÑS\åQ})GV­©\è¶òAi£ý¬KB¬2«\ÇSLV\æ—\â\è\äÛ¥[\Ë±©\Ç/8=FGÓ‘ùWŠx\ËÄ·7ºŒ6–2\æÓ*–A\än\éýj\rTó¼3sqªyðÁn\Èñ3\ä\îp?\ZÁVý\ãQ	aÛ‚o©\íóx¦\Â\ÒôX\ê\ÚT«4±JöÏ½j_øF9X\î-e¶˜	#b>tÏ­|\ç\àø‡\Æþ%\Óô»0X[\\0S7ú\ÇqœaE<zW½ø\ê\ÃW´ðòk¢†5\n\Ä\×rt\êE\ÝlqÖ¥V„”e£g5\â=KE4z(\Ú \ç\éY~$ðÂ«­¬‘K}\ìr	\êkgÁW>(,\Ï(†/+£ùôù\×K£\éwwÚ›p\æ\âG99Pû\0:\n\Æv\ç\åˆ);]žŸb>#__\ëS«-\ä\Ã\æL÷,\Ü\çð¯Uð­å®¤&”¿jû,hG$\Çi\Ôƒø\×cª\épZÃ¶\à\à°\Î\ÍrW\Öz\\W\n38?Z\èQi§s>nda_x¥ti\åŒ<V³|™\Éw¦{Uû!m\â+Y\'´ŸP7.8”9‘ŽG\r‘F£\rµ¢n–0\ç\'5\Øx\Z\ëO* (¹\ëŒUK\r\nŽ\ÒdýbPZ#\Ëu¯\ê\È\Î./.\à¡E\\zœõút¯5\×-o-up—M\ÌD®\è\ßi\àõÀ\èk\è?Ž—\Ðiú¸lr0¬9öü\ë\ã-cX—Z\Õo\Ú]Bq\äÜ¼a )\Î1Ÿ^õ2¡\Zk––ð.IMóOc\è\ï†=†ü.›y:\É2\r§8ù€\ïéš›Ç‘®¡|±[Å•ˆ\ØRqŸ\å^\r\à_øš\å›R\Ðf»\Ýö´\ãn\Ð\Ø\Î$gŽ¸õ¯W}_[‹\Ã~EÍ‰žò4\Ú3Á>™=\ëXM¯ˆ‰R\\×\Äø\Æÿ\0N“O¼\Ñu\ÛDº\ÖÁ†g£+J\älô”™X\Æ\éš\Ó\×no\'ÖÖ§g …\×$„£&:\ØýA«¶ri°[#$ñ¤EK\î?:\í\ÂV½[-\äù!\æ_ð2YY\Ê\"½@Tœ†\ÇJ\èü_ð\ÏL\×5\Ëmn{ùm´ö·]\".F\â\ç\Ó\0w4h^£ŽóU¹ð0!Q™$\à9®ªY\Ä^&’\ËO²/m\äºÂñövTw#²®x[¦jñ™…ZQ¶û\Ïò4\ÂÖ”*{E+hxo\Ä_	h\ÚV«s­A{kŠgY#ûA\ÈrüÍž;Á\'š‡Cð3x\Î\Ó\ì\Z4‹ö²\0ÁSœ8\ê=+\èdø£\Ë¹º¥¸‘+Fsœzg\'žµ\æºþ—ªü*ø§¯\áaleš\Û\Éx/W0´`ý\Ð8\àrÁÇ­U\Ó¡Q¹\'ów;kZ¬9õ[\\ðK\Ý6ûF\Önt½J\Ýàº³”\Ã4gª2œ\Z\×\Ò\î\Z9\â•J»ŒH»€\ê:Jô\ÏJ>\'x®KMÓ­uKˆ­§†Faþ\Þs»\êsŠ\ê¾ü$øY\â$–h¾\"Z›	wö7n¶ó\ÚÉœme|\Ï\\ƒ^ö[š\áÖŽ÷\ío\Äö0\Ù\Õ\Z4«{ùjyž“¨\ë$‚\æ\Ù%\"X\áD\É|©\Îk:`Pªƒ““\È\éŠû\Ç\á\ïÃ¿øN»\Ò\ãŠ\í\È\â\çpp\ßFW\Ç´.Œ¾ø·¯iqÆ±Z½\×Ú­‚Žnw\r¿L‘^–\Z§)}\æù>sF\"pJ\ÝOò3¼3(’H\ÔÆ®:\Ýy<~=\ë\Üüð~Ox\Z\å–E´Ô¡›Yd#r­\ì}{W‰|7°k\Ýb\Ú%•7\Éuc2H¼¶ÿ\0 \Ç\ê+\ïo†\ZZi>·ŽT3 g\ÔÑŒ\Æ\Ê®SŸˆsIa\åe+3âˆü_á©5]\éW<KfX›\Ü2\äW&Ÿp®T\Ã( \àþ\â¿K%Ki«¢²ž ŽµL\èú)9:e©\'þ˜ŠÁ\æ\Ü\Ú\Î\n\çŸO‹¦£û\Êi¿\'còz\Õ6KQ‹n\ÇÖ½\Ë\Ã~\Òô\ë(.œ¤·O¢\ÂÍ…\ÞN}º~5\Ç\ØøqS]·B‚²«ds\ï]\â\é×—ScK†au\"\"@fû£\è}kò\Ì^)\Ôj0G\Ègu¥Nq§\Ò\ï\æQ†\â\×Sñ\Äz^˜e»\ÕJ\äÁn¥Š¨þ&#\åLry=+­ñôš¾™g§\éú›\"fR\ÛV6i$\nFF8¿¸\ÍkxL\Ñ~x[·nüM«%ÔŽ¼—<…\0ô;úœW™x\ß\Ä÷WB\âúöi¼½¤\Îb\Éy9\É,{œŸ öªª\áO\ÜZ\É\ØÎžqV>ÎšZGK.¾¯RK\ÏÝ¥\ÅÌŸkH\Õd1\ì\Ü\nÊ˜ùH¨gÀ~3þ €]ý…ô\É.\îb¹o•yÇ¾:ñ\é\\w…ü5¨ø†\Â]~b>Ì‘\É$þhAJG\Ì2p\Ìs\ÐrH<Sõ_\ÝZ³\ÍGš5–E\ÈÀaÛ¿^µ›öT\æ\âþ}¹\ÂajbhFRiIôGyã¯Q\\x\Æ\Þ\ïG\ÒbÑ­¬®¶°\ÛGˆ¤Un³\É\ä\Ç\ë_Cü0ø\×áŸŠ¶GB\Ôc›K¿·³x\Ôù c-\æ\ëþ\×|™g°\Òþ\Å}¢\Ø\ß\ÛyebWd‹ž\âE\Ãdc9éŽ•\é|;‹\ãYI%•°¶w†”\Úò)R\Æ\Î$%qE\ÍkKN	û-S\Ü1¹}9As»Im\æ}\'{ZL{¦\ÓeKs’D7…³ŽGÖ¸ÿ\0ˆ^2³\Ð4¹5=Qch‡ðH2Ç²€{\Ö\çƒ~#Zj«µ\Õ\Ú\Ü\ÆK\08gÚºø<)£x¿K–ò\ÓN´»Š\'+,Œˆ|³Ôƒž•×‡Q®½Ç©\àVŒ¨?\ÞDñß†\ßm¼S¥ý³P\ÔbŠü\Îb[Vo˜§P\ËØŽG\ã]5Äˆ!gû3	\æ#¼gk\ã ÷«~7øk\á(4É®­ô»;Y¡Œ¿\Ù}NWÏ^%±\×t¶ðû\\\Å4ú~d·.\Ç™ù†z\ç8Ï®k¢§´r\åDRt¹\\’gœ|E\×gŠ­ |Œ2\Ç=Á®z\Ã\âú.–R{ig‰”¤~T\Â,9\áK9\n5\Ú|oÓ­\Å\Ý\Ý\Ôv\Ø[8	«þ»\àûŽy\ï^9\â¡÷‰®t\r\É\çZºƒ$÷#÷p\']\Ìø½‡S\\\n¼Ôµg¢\èBPN(\ï¼mu\â\Ù\Ûj?Ù·VZ8‰$··–eyX•Ã¹lŒƒŽ+\à?\Âo³üJ—Åºü)5·˜^\ÚÉ\Ëò0H\àzòj_\ÞK­¶Œ\æKˆ!\Úcc\Æö<Â½ƒOº‘,\Ó\Í\0‡5\ÛJ¬fÛ‹9ªÐ8û\È\ÝÕ´}.x–Hm#…Sœ\"…×DZ”–[)\ëò\Ôö>\\Ð´`„þÖ¤w¶ñÀB•\0¦+fµ\Ð\ã\ç\åG\âhw`\Æ\ÑÆ¯ ?(À\Ýøw¯øð\Î\Ë\Ã:™\Ö,ô5\',2±cü¾ý3^ò|Gqs\âIl$Òš1\ÊI¼\ê{ŠwŠ¬­\î-²ÁNGB)8\Ê\ZŽ®\ìxG†ôyõy\ãQ¹\Õ\â\ß $6\Ø\Ëÿ\0²O$¦+Ú¾\\xcEÓ¾\Ïo,„?8f\Ã\îO$ýj…tKIoK´9Œp	\çŸj\í-|=¤cpö\é#/?:ƒü\é\'\ÒÛ–’\\\ë’\Ü\Û¥Ú™À.\ã±ÿ\0¼{Wš|X\Ðôým£“\Ä7X\É\Ê×¿q“\ÔW 1µ8&•/\Ò\Ú\Ú‚¦M¼úu¯(ñ‡ž\âúH¼É®”9\Ã. g±¨w\Ícze)Z\çw¡h\ÞÕ­õm:[E\àÉŽ\Ý%\Ç-Á úz\Z\â¼o?†o¼Xuô³atG›ÿ\0!\Ý\Óq\Ï§·Ö½~\nyð\ÉeS\n\î\\žHö¯?ñ¿†.!¸ò\î`7HFc,3·ž•„\ç\íÚ“:£I´Tð_Šõø®\ÒmJ÷Z´Ó­\îE\Ã\Ù\Ø\ÈZ\ÖaŒ§NG|\Z>1ø\ÓÁ¿õu±\Ó>Ñ¦köˆ\Æk²¢\ìÿ\0\ËÀüŸ»»®q\Åg\Íe%„\n\Ü\\\\\íù¥\Ó.\×v\ßú\æÇ¦}3Y>\Ó\ìn<X·¾”Az[\"\Ö\æ5R®§\'a#žI\à\ã\ë^–õ}ˆ§:”êª±\Ýuÿ\03\Öÿ\0d‡—¶:\×ü$þ\'³{g²\Ö\ÎQó&:³|p+\éøµDÀ…xoƒ|ju\r=d•<›\Ä;/ ÁL\Ç<\ã¡Z\ê\ìu\ÂÀ\Ã?Zõ\å‰öÖšwG—˜bkb+¹\Õß·cÓ¡¾V\è\ÙüjÀ¸\Þ5Á\é\Ú\ÆH\ëYuEÀùýõI3†\Ç\Äu=KR\Ô?´5k™&E”\æyß™I\ê¾ü\çó¯]\Ö5K}&\Ú9ût\Íó™\å?\ÝÂ“ò¨|\Ä}+\Ëþ\Ûý“C‚}6\î\Ö%T6”=Nzƒ\ßÒ®xƒXº7\ækŒ-\Äc>w™¸?¸\Ï§\å_<T\ã)¸-\Ù\âÕ­*’¼½>\àñO‰WS¿g¼½®ˆ	\å™TP8P:þ½p_õ\ä\Ó\Ú\ÓO\Ô>ÎŽ¸{w\ÃI?¶Tp=õW\â6©¤^\ÙM–/$ûI„£vb\ç¥cü4\Ñ\Ú{–¼œ1‚\Ü\ç¦w¿a]Xl:§­Tn\ë£\ëóÿ\0€v\ápö‡\Öd\ì—\â}+û*\êº<þO\ëzl»Qn\"‘U\Ë\'\í0­Ÿ\â×ª|Fð7‡\'¶¾¹dƒJVòqz\ç-\"0\n\ï.Uv¯cÓ­|«\á[K@ñ<:\ä\í™Jð1Ü’\î‘\èEu¾7ø\Ý\â{û\Ûh¯Z=‘¸{h`#j8\è\ÄrN9\ÆxÞ¦~Ê´^²ò>™8T„iJòü\r¿Œ:>ƒm¢\ém¤´¿Ž\é`To>,ûp\Z\"ð\ã$gŽy¿j·Öš…¬‹sº\Æ9–79I\Ã`v\ã5”¶~%ñV®$\"òq\'Ï‚¾f02p	\Æ0+kRðN»\ái\"“RÓ¤®UMº™T—OR™\'®zgzW*r…>hô>Öœ\áZŸ³”•ÿ\0­}\Ñ<?§hzm\Ï\Ûc\"DGue%9\r·¿\Ê{zU}\\[k™n|;«˜\âœ–\ÝÜ„‘¿„º\ç·\\\×\àoŠ÷¶:*øoÅ±%Õ”HZ·¾·_ù\æ>n¼\çÒ°üg¯øXY]O§\ê\ÖinrÈ­\åÈ õ\êk£\r8¦¥Iÿ\0™\åW§5uY‘\è^>ñ¥p^Fl–7t`þDÌ§s\×p\Æ2:v\ï^; xž\Þ\Ã\â%´ú+\Í\0‚\à\0m\î?pô\ï\í\\Þ¹\â»\ítÉ§\èwºƒ ~\îw;³Õ†OÓš\ëgÿ\0†ó\Ìu9./ü½ðy\ì¦%p\Ù>c1\È\Ý\Ðuù«\×t«U…ú£Î½*]4;ßº\ä÷\Ú¾…¥©ŸQ»bò´|•~\ï\ëú\Õ‡~K\ØJ\\¾w\ÜIŽ%|óÏ¢ô\éŸ¾Ÿ¬\êòG>¡q\Ç\n\ã&0S;€ƒsÞº\Øü9kg¥£<[qÁ\Ís\Ë4½\íÞ¥\Ò\Ä\Â/\Ý\èy4žû6±kŸùŒ¥‰\é‘\éô¯Y\Zl0\Ú,m´8^ižÐj‚ðr~QŒõ\ïšß¸´\Êd®k|\'9w0\Ç\â=¤”S\Øä¢,£h\ã\ÜA$’Í’k:óRX¥16I\Æv¨\'5\Ø\\\é‹*‘‚Ò°5M\"[fi!›y\êc#ƒ]2“ZœI\'¹\Ï\Ïs\È/\â\ÜÀ ¯ò¨^†\éü—r®\n°Áü«n\Ë[+sy%£FË¨LŸ\ÃÞ¹=B+\ßx\ê+‹(„q”ÈŒ£<=j¥/v\í„\"¹­c¥\ÒKZ¡ò”\í\'8­ý?W‰­Y$1\ão­Y\Ó4‰~\Îm\í\ÝH\å‚\ì,~€\ãùV²©¤\êPÏ‘\ä\Ë!Á<¡£Óžµ<\ë¹\\·/\rXðýýž¯¦­\Üð´Án\Éhb\ÛõÁ\ÉV tþ!\\®»e«h?\Úú-ûF÷ó£+ÛÉ‰2\Û`tÃ§J\é¼Ate\Ó&Ó’ýp8h.ï¼£°\nÀy«ºñGˆ.µ+§ñ\ßlI™]\ÞD“b\í\ã\ÑF8\ë\ÍgRT\à¹õ\Üî¢§?}]ˆôy\î\ç\ÍòÔ¤ƒo\Î0\Ù\ÏsÚ¢ñN=ü…¬\íä•ƒ\ÇfMƒ¹;i’jv2–{iOðŒÇŸ\Ç\ëS\ë>3×´¿41\ë0Áf\Îcð:¥\Ë}p7`“\ëX\ÓpW¹¤\Ô\åk/ñr\Îx54cº7‰~G\ØC¯±‡z\â„þ!´š\Ö\áópHŸ*J=ýñ^£­ø‡E\Ö|=¨M«\ä\Ï\"(Á\0`!0GSÁ\É\ç9ük\Êü\r’x–\Úh›c\Û{g#úÓºž\îR‹„[\ì{\ïÄ‹ˆ­ \Ñ58n¡ŸV¸µ55Gfi\Î\Õm\ä¶6>EV^\â \Ð5\ëmF\Ð\\\é÷+4yÁ\ÚyS\Ü\Ô\Z_\è6ºÆ‰ja^\é¢)u3\Ü\ÓÀ®¨s\è1Ò¸\íWI¼ðÏˆF›¦\Ú-\ÃÍ±­o&C·€\Æ6\ç\æÀ\Èó\ÔÖ¸lT\èJQk\Ý\é\åý~g5l5:ð‹½¥ý^‡¥\Úk!\ëz\Ö]evŒ¼„\ãÖ¼ûÁþ ¶\×#ºò£’\Êo&`\Ýc¨ïŽ½pko\Ì>µ\ïF\\\Ê\èñ%fµ>~\Ñu848.cº-&ù‘…=¶‘×Œñ\ê(µ\×U\ä–5Ìˆ¼\äº=ý«…ƒZ»¿\Ðm´\ÎY®\"\Ä.#]\ß*ÿ\0\ì÷®»Gð\ÝÈ°ˆø“W´\ÓP?e€©¸pG\0œ€?S_#SsJ£³»Ó­»ž¥e®„WúCkš\Ò\È¿u$$g§\ËÀ\É\ç<þuÕ‹\ÑôXt\ÃpD2\Â4\0\Ê\çû\Ï\éøÕ­>\ê\ÛL\Ó\×û5*T¯žXe n ý?:\Ã\×.a{qñG\ZÝ¿qWcý\Ü\ç§|W\êÊ­ ž†³\ÄÔ•8\Òo\ÝE]vò\Ê\r>t–\àÀ\Äq\"J—ô9®\Â:ÕŽ‘\âô©d»´y7‰\ã;\ã=Á\ä~_… ‹Lþ\Ðcf\Òn†R	_~O9ªC\í±`ed­{x<=:t\Ü]\Ý\Ïw„ö0ö‘o^\ê\Ç\Þ_³1\Ð5¯>«–sD±DŸ3\ås\È\ëú]Å\Ç\âT6öº›Ø­šl‘\\´dœnÝ´ŽJ‘ô\ÇÖ¾.øs¯\ëþÔ’mô\Ä\ÊÁ\Þ\ËFO©¡úW\×>ñÖ‘\ã-\n\ËTž\æ6¾ŽDŽöÍ¤ù\í\æNI\È\Û\Ü\àŽ*Z„—³Š\Ðõ\á*”¦ª\'©\áž4Ó¤·\Ôdˆ\Û]\é\Ò&$’\Þ\åZ@ñ:“z†\år9<\ã„\×\áò%e–\Ø\ê6³¯¨\È<væ½—ö\Î\Zv«¬hº\ÌWª?\îÃ¤»•€\ÎôÁ\Çn•\åºH³d\Z~¢\ÑKmu0A+¿\Ülý\å~ ~˜\ë^5JQ¡W\Ý_\×s\ê¨ÖŽ#\n§.¿…Œ¿¼–Z\ä)l³˜¸§\0\ß•\îñÖ—\Ö7\Ö±º·ÿ\0^\ÐüÅˆ9^„ž„þU\âR‡\Ñ<B\Ð,¥GÇ¨5\ÛxÅ–w–q\ÛG‰‹²—\01Ü\Î\rz´qwŠ»±\ãbpœ²ºZ3\éÿ\0x\Â\ß]°Ž9,’;Ûˆ™]\ã4Žs·€¸ þu\Ù\\u\rGsg°¤`$\ê®FGLŽ¸>µò­§‰\í\ìe´Ž=ü\ç>\\‰V,üÇ¶k¿ð\ç‰/$\Ô,\áÒ¥i®\æ2Tó±\Ô\r\Ä\rÇ°\ï\ÍoZnjûžb¤\àûÙ¤i·Piò_GkhX+²Áô#­Všþýõˆ\à¶Ó¼\ËE\0\Í1nPŸº÷\èk\Î\Ä]R\ÓSq”\×)q\0ˆ\Ç*yWSÐJõ†ZÑ›T\Z\Â\Ûo³¸„üÀ\ç¦=Et`\å	+=,r\âc$\ï½\Éu‚\Äeg©\Îr72\ÜÜ¼\Â	\É®£ƒ\î+¢ø‰\âX¯5;ˆ\âžc\0ñ\Ó5¥\áÿ\0\rO?†\Åù\n \ÚHOÒŽhÔ›7{—$o#\Ëõ›wkQ»(PxcØšç´r\ë\æGŒ\ÉŸ,‹· ÷¯Fñ¦‘67[E¹\Ç<\ÖN“\áO\íýV\ÙõˆvV\Ê\Ì\ê:¹\Ç\0?Â‰AŽ5#\ÔÔ²ñVŸ}`²X_\Ç‡³BJÀñj[jöoö\â\Ë\æªð±\È\ï^}ñ«Á\ÒÀþf•ö•\Ø96\Ï\å±ƒ=OÖ¹¯†Ú®%\Ìr\Þjwª\äŽ\áÀ\íŽ\çÞ¸\ê\Æ5>&t\Ã\Ý\\\Ñ:Ÿß¬w7ze\å\á[¸˜ˆ%9\Û þ\é¡#¡ü¨½jcH<©¡k‡“+\Ê\çý\n\ä|b\×k‘\êPYNžd[g>Y\Æ\àx?‘\"ºß…Z\ä\êö§Q\Øö\Ë2–C\Ã.FE5N5RRz®¿\æi\íeN\íl\ÍM7FÓ¥²‘i¯l%\ÝzŸj\Ê×¼oq`Ð½»\Ü(\èFHS^·«O¢BŠútŠ¬ó<r[¹¢n U+\ÐûVSNeºX<\ÃvÁ\0\Ñ<\"†\ìP\ÆJOcÁ\î>Gq+,\ÒBªª’>™ÿ\0\n\Ñð¿\Âÿ\0i·\nòý­±µþ¤ö\ë^×ªZZ\Åj\Ò1%±€8¯-\×\çÔ…\î#·xY›%³\Î|þU\çó8\ËC¶Õ•›:ýW\á>Œ<7¶\Ñ\ÏôHq!\èN:k‹—Á+\r°º•#g9R¤t\Åz„WYþÆ†9n¥™JeC¾vý>´šÝœ«òÃ¨S\ÍoZ¤e\ËÑ‹„šr¹\å’ið\Å+‹k_.E\á™=\ê´(\á‰u\é]wˆb}+j\ì\Ù\çD\Ò.ñ\Ë+š’\æÜ»d¶O\Ì8=\ëL>*µ¥ø‘Z„*;³\æmwº·‘ô}ÎŒc÷s\Ç\å<~ÄƒOm*D‘õ;\ËI¤e\Ì{\Ê\Ã\ÉôúÔž²\Óô»V´µž0²\Îñ±2{ŒJ›û9//.t\ë–\Ø:,°0;Y_\Ã»cŽrk7	\ÊQv\Ê\í|¬|KÑ¶Ÿùœ\åÅ—ŠTG²7S$‡;Y\Âcù[£Âº¶³j_R¶ºVŒ’¿\n¼u9\ã\×ßšô?†^Ñ­­÷[y\äðeF¹%a‚\Ç	õ5\ßi\Þ\Õ|¸õ‹Dµ\Ôcµ\Þ\Æ\ÎB­\ã\0rp?\Æx\éZF­Z­J	z\ÛQ*™J;÷<KEøG¯_i©\Ùi:†¡m·t |\Çñ#s]V‹ðGTžç½µkeP¥¢Š#,\àŸ\á•Lý×ªøK\â\\2i\Ó\Ï™³-\å£E—‰÷”cwC‚=+¥\Ó~*øvY\Â\\Þ´H£x1¨P\ç±lÿ\0:ì¤©¥i\Ï\Þóý\r\å\Ä}©3Ì®>&•b\Ër Ó¢9D7ó™n&p:\"c:|«Ö¼\ëÆ¦o\ê?l·»0_\ÂWkØ¯–B\ç9-\Ó8 ûŠ÷	nüªxö\rVõRGtuÒ…\Ù?~B{ó\È=ñƒš»ñ\'QºþÁh^\Ñol\'ù\Åc@\ÚX¨Á\È\ÆN1‘P©Á¾döùþEP\Ä\ÍT¼\ä\í\Ú\ç\Ë>0ø?ˆô;q­@\ÍqhÌ«$\\+–\èqÓŒr:~uCG½ó\í’}B\åH\Î\Ôø\àu¬/\é·\ÚG‰¤±Ô’\Ú9ü\æ‘\ã¶#\Ë@z\0£\îý\rZ²hûCZ$›\0\ØN@‡jÖ­8ß¹ö¸ld¹+\Ðôñ`5;\Ð,\Öqªù[¤˜y\ãŽý;TZ<l“Feˆ\"\íùN2O¯\ãôôªõ{\Õ]\Òoo—c}Ý¾ŸJ\î%\Ñb¸¸ò´û1–C*[\Æx\r\ßosÛ¾kÁ\ÄRi{§§EŸ$È–©[s1š\\˜\ÑXÀ\äñ\í\ë\í[ú\n_	ü\Æò0\É$sý+)\"BK€b“&Gº&\éb±òUqœ\ï\ãv:\Z\é\ÂÁ\É]œ•¥m\r^­™ó Q8Y\ç9\èq^\ÙðƒS»¼ðlš\ÌBžFX£^ /Ÿ\Ç5ó­\Õ\ÌR\Þ\Ç1‹qRw‚\Ç\æ\Ïzöÿ\0\é}ð\î8ó™H\Ý\ÓN?\"+¦U9 \Ú8\êSN\Úµ9R]q›\nX6\ã^‰\à-­‚\Ùù¨¬³‡.\0px+ŽýµxÏ5msq*mŒ2õ\\ú\ë‰ÿ\0„\×X·ñ¾Ÿ¨ZÌ˜\ÒÕ®a\Ù~b¬ˆ?CF¤\ã>x\ìeV’”lÏ²®C_\é·B\ê\Ãa2Ç“Áa”‘‘Ozóø‚\ÏJ‰-¡ý\åÀoTePµŽŸJÚ‹\âE‰>™\ìP\ÙËªX—±!\Ãm\È\Ç×ƒý+\Ê4§c¾­\ÂXn=wŸ_ñ®œ\Ë\Z¡8Q¦õ—SŸ\r‡¼e9-º\ß\êWw†c(\ÒB~O,a}J÷ó\é\\\ävò\Î\Û>\ÐöŒŽHa÷d¦kB\ëU´³V73¬n“ŸN\Ç…b\ÞkIo<\Úl&m§\n \ä1öö5Ä \×\Ä\ît&\Þ\ÈØŠ;û{Y$¹\Í{rI\àmtÿ\0\Z‹\\\Ò\ì5Kh\îDf)8h\æŒ\0#úŽÿ\0J—À>#ƒ\Å–\ê)\íf·>E\ÔŽTã¯¸\ë\\Žµu¨\è²Èˆ²\Ë1\Ø:\íæ´‚J\Ö7¹WTñ>§ j_e\Ô\â2Ç·Ë‚\ê3… tŸn\ßJ\è|3\â\è\ïu]§ FÛžýª÷†ô3Zðüwºõ¼^d¤\ì†L£§#ÖŸ?4Ø­Ù´ûuYxò~\\þU\Õi\Ê-6E\ã{vºõ­\Ô\îg½µ‹bn\Øò…,G`z\Ò\Ô<_\á‹-+¬·Š$Š\ìÄžrN¼m\Ëv^;cž\Õ\ãz\í©\Ðn\æA$\0a—,ƒü÷§\Øjö‘Â·l\0ž\Ý®eO\Ùß¹¿?2G¤E\ãM&\Þ\Å\Ò	\â\\GGµc\\øú4¹Xtûµ7ò˜f\äb°\ã:Oˆ-Š2£2IÊŸ\\W;u¥¿„|EõÙŽ{\'a\ä\Þ%º¦\ÏöHP\0ú\Ô*\ë\Þu\Ø\ìõmR×‘X\ß\Ém4À\r\Än`8\Îfÿ\0ÂŒ\Ö\çþÜ½m\Ü\ç\ì\'Ÿ~µ\ß\è^ Ñ—\Âwþ!“Q²‰´\Û}\É –Ë…\Ç9Ó§j\á\âŒì¡š=q‰-ý¢«Ÿ|c¥:“¥‡iM\î:q©Y^=Ÿ\Ó\Ãú]\å\Ë\Ä!¸ŽVB‘\Çg8ñòŽ~^½\È\é\\5¯ˆõP»\Ðu›¶¸Šc\Þ`X[ýñ\Î}#Ö½÷\Ä>Î—ý­½`Î‘f;y!l>;PpO=Ey\'ÄŸ\êWZ¡‹Z°µ[˜\âXŒ¢%c,k¿8\áÀ\ÏŸ­^‚pª¯\Øø¬57\'\Ê\Î\Ã\á‹A©^Y$š¦\ÅVŒœ7só­{§‰ü-\âh<\r-¾\ãI\âbf0\Û\Û\Åš1\ÐÈ 8\ãÐŠù\Â~$}XŽ\î\0’F£\nTt\ã\ÔW\Ù~ñ¦“®xn\Â\á§X`xw$²8\Âó´ƒœ¿\ÈWN\Z„)Jkk\ê…^‹¥?&|ÀšöZˆ\ä\Ó%ŽB¡\ár\ÐNz\á\r\îzú\Ó//g…BÝ¦\Äp6H\ÊGc]§\í\áÉ¦ñ.ƒrŽ\É/šúlr†‚@yo|Ã®x8ö\ÅqZ;ÿ\0\ÂI\áô¹\Ò\á!­\Ð%Å¿$Dr@Rx\ã\é\\8Œ3q\æzµ¹“‡»p2·–	$óÙºŸj\Öð×‹o´\ë\Ô)¨m\0`¤£!}ù\éõ¯9ñP\Öt¨\æ³W;\"6a°N<©À\àŽ\rnxG»ñ…šö,ñ3Fþ^7FÞ„ž£sQK8Ú¤^·êŽš\n•yeuø¿}§øš\â7°°f¼ö-\ÄV7<­žNÏ¶GcT4\n\í¬\\4[™	À0=#ƒŠ\í¼\áä¾¶°½‡\ä†Á˜LG\Í$\ì\ìY}s´¯\å]–§gm¢Û˜\ï`†\Ô\Æ,+\Ù%R>ùÁ \äry\ï\ÅN/\é\Ê0KN\ç\Ù\åxxF…“»Gž\éž¸µ\Ï\n´Nø1±xõ\ÆkÑ´‘q<–ó†@P¯,q°ž?\ïY\Öoiu²?\0ðs\È\"­]K6hòZ/›v/\Î8€T“~÷C¦r\æ\Ñ\îtž+\ÒÆ£h\Ë5¼)$X\Úc\åKŒ9#žø\ãÒ¹\Ý6\áË˜‰a\Ôg¾p~˜­\ë—7›­\ï£[vh”°-½b>€Ž£\éY÷Žƒ^Gr#•2\'÷>ý¨Œ\ã\n‰tbQn>†Í«\Ú\É\\2\ï_^s\êMuÿ\0³¶£y\á\ë×€_Yd2(\'\Ø\Ã(\î ~\"¸]Z]Ó±K“q˜1À~ø¨´bXeûE«¼3F\à«! údc·½]EõÐžY8´rø‹£C¨\é\æ\çOO22\Ù\Ôòƒ¸½\ë\É^\Ú{g^!$V\ÎÀz²¸ÁB;dw«Ÿð±µy¯TY,\Ù\ã	2…Ú²\ã«m\é“\ß\0\éV\ì\ãÄ—h³OolË…÷\Ç8¨¥\Æ^\ãº3’\\¾þ\æ¿À=LB·^™—fŸ(š\Ì\ä“\Z9\å=€?Î½G\\Ó“\ìr]Æ¢À$•\Îú\Ç\Öð\Ö\ËF†+ý7P[»Æˆ9u\Î\Ð:”\è9\às\ê*Ö¥\ã\âß§\Ý$¨_\æ5ßƒ\ïŽÕŽ\"…Js\æ–ý„\ãW\àùž#ûFý¬\é2Id\Ói¶È±7\ÝLÿ\0*¡ð+W\Ô\ïü5(¾=½Œ§hÀ.\ìžOq•\èzW[ñBóDk×™u$K–Bqœ“Ø¯j¡ð“\ÂÉ¨j\Úå¥”²oû\Ú\n—\Æ\Þ\á˜w\Ï<zs]T\ëó\Æ*Ú\Ùr\ÞûøO\âZ\rþ§c¨T5\ÄeW™G	\ìL\Ò\è(Óµ\ët†thei\ÚGùŽÈ—À\Ï$\×\âÛ¨\ì|Cý—&I–0¸ßµ\ÆÂ¸9ÿ\01]\ßÁ?\ÚjZ\Ôw3$\ékl²™’f\0g (8\äwúq\\\Ó\ÄTU\Ò[p\Ã\Óö.RÜ“S\×c¹»e²2\Åmf€¢©\Ú\Ò6y\æ½k\áf³e®ømL²¢Nª”ú×Œ\êvLþ,¸ŠEUYfo•3€e]ë—¾¿–=:yHC»\å9Ï±ö®ü-YhÚ½\Î<E\ÉY;XöŠ\Z-¡€’Ð±˜`( –Û­|±\âX<C¤ø\Ò}0\Ïx-#›h\í\×s\ì=	\È\Åu^ø\â-kÆ³]\Ü4b*ˆ°QýGa\È\î+½\Zañ5®eA%\Ä@\î™Tû\Zï›§vŽ\Zq©{&yO…¼A¯\è7\Ï0Y g\ØÏ¼={Ÿq^«£\ë\Ð\ë\Þ\r»Ó¯öº\\\ÄÁƒ€Ã¦=+ŒºÐ ·\×L[9\ê?š)PYrªG\Íþ\èæº›\Ð\ØOgöh\ÍÔ®<\Ç·`8 c³\0y¬*\Æ2\Ò6NJZœ•«\É\á\Ù,%]ñY\ÊpÁ98=\Ïs[\Öþñ|¶ñÊºñ¡Úƒ9‡ŸÎº\í2\Æ\Ó\Âúd—-’f;\Ãô1w\ÏlsÚ±®\íbºº–\æ\êòO>g2K¹Ž\ârr@Á9=«ç±´Tª{ú¿¸öð•¢¡¢GžZx›Y°W·Òµ)\àm»i\Ì_pr8?Ò¹ˆ—WZ“+\\\Ø\ÇA¿w*I¹K†¸\Ï\\dŽ8­=røe\"[\'†TUb›v\í\r\ÈÇ·¿\áT†ŸwÍ»\íBKGƒ\È\çœg¥v\à\ÕER\Ò?5\Â\ßÚ«œrØ\ß(\â»?\êÚ„:zh\ä\È\Ñ\Ã\æ4*ŒaÜƒ<u\çZl\ZŠyŒñVJu\ça\ëGjõjC\ÚG•ž­Jq«V]ÓµQ=ªC¨(¶lIý\ì<‡\ÆqÇ½r¾–\ï\Ã.’]:\án´\É÷	#*W†”ÿ\0\É#ú\Ö\Å\å¿\Ù-¤¸•$cq	öÏ½q¯«jË¬£¬YŒ\È7\Ä*=3ô¥Jœ)\Þ+ñ9½*N\×n\çY¯\ÜXjŸN\Èe»?8(@Be\'¿\ä÷¬¿‡ú¾³\à‹yZ\Ì\Ä\Ï?\Ê\ë2\îF\îœds\ï\éZ\Z†¹¤[B\ï5•Âœþ\á~R\ÒS\Ï‘i¨Y\ê—B)bxT±!ø½k	¹S\îßºc9:I{7¡©}\â}V¹Š\êóS™v¶ø\ã„ùI\ÎrÔº¾¹,\×r\Ü5\Õ\Å\Ê0\Ù\ÆÐ¤œ’OSŸòkZ\Ôb³¸o™|‹´x\êsI}Z\è&÷Qs-\ÅÊ•²´o»\î²\êO|W/²Œ\ì\æ·\Ø\î\ÊñØŠU}ßµ§õ\ètšgˆ’)#Œ”µ·\åda\Ó=±\î*\îŸ\â›\Èl\Ú\á¤S1\0Md®=³Ú¼\Î\Â\ä½\ÊÛ¬¸iy@xÏ¶k«\Ð4½Rú\ÕLQ;v+¨á¨«AQ[\ÙqIBn\ì\ëtGw8X¤1\Ë{0¥¾º¹:\Òß£\"aµ”.\âMT›\á­õ¾ƒ¸\ÓEjþxE‰Ü¬’¬ƒø‡\Ê\Ùô\Åj\èúM\ìñù+’\È$J—!Ž7(\êq\è?J\à\ÄMs.Gs®•*i·¶=\Âú*ø‹L>L~d‘Ã™Ww\Þ«uôô®WQ\Ñ\ä\Ò5 &k\Ï2YŠ\ÆY.	ù¿»ø\×Oc¦j\Þ×¡¶Žw‘ƒG2ñ°žv\äHg\ë]Æq§^\ÚJš\í…\Î$“>`\âeaÑƒ`‚9\Î¥vFt\ë%­¤6r\í¬Y\äV×–\Ð^]gl\å¼\Ö®~\î}kY¯ä´ˆ\ê¶\Ð\\²\Éx—?>=½…7\ÇúV©c	\Ò/t¶O3u\Ôs©$¯<dpCø\Ö1MR\×N2\Éhñ\Å\ç\Ñ\ÚË¼Ÿ›Ád~~\Þ2\\©Ù™û\'ñ\îkøñ2\âk\Ö\æ2#\Ú0\ìps\î;Um~óK\ÖüI,zU\Ôöš“Ç½c/	\ï\Ø¡¯<Ó¥{kUy\Ý\Ñv\áI\ê~µ¯¤xš[&\Ç\0˜’Š\Ê\Ó\'¡ö­”ù’Rw99[qV!×¼3}®ngº·ZEü\Â:@À\ïV>\ë··½·’X¤’i½\Æ\Þ&\Ü0s\éÚ§ñ«­m¹7Á#GÑ˜|W)5½û\è:µ……¤÷w	–\ÜDFC9\Ç|`œö¬gu+G¯S¢›N+œÇ‹§\ê\Ï\ÑN\Þ]ÀS2!\æðÜŒp@\ZúLÑ¬l¼9\ÚlA§¼\Ù+\ÈwÙ\Çð¯”¼ð\Ç^×®m\ãñ¢l¬˜\'Ù¾g\ÚNIÿ\0h\é_Rø=\í­ü–u‰\ì X¢™ˆ\Þ\åF\Õ\ãÔŒ~&…MÆŸ¼Mj‘s´Y\ç¾+ðýÕŠÏž‚7‘E\Ä[U•¹À?y\×\Çx]4™n\í\"\Û$ˆVI‚1Ö¾‡ñeå¶£¢A¥\ê–Pý®\Ê%û%Ú±Ve\àÃ¾q\ÛÒ¼s\â|1Em<W =¬ŒA•NBçƒš\é\Ã8F\\©œõ\\Þ­SðƒL·¸òÏ˜ŸmÝ¸«Xf½sNº\Ôô+¦DW]\n¼ŒŒW\Ç5§†õ öI2JL4Y\Âöe=A\Ïò¯Yðÿ\0‹-\ï´(\à•˜\ÜAû¿2G\r¿o/§Òº±MÙ³\nrihoEƒÅ¾ž\äynŒ’„\0¨Ç¡µŸð³Ã—ºQ¿{©^t\Ê\ÈXœ\î`\Ö-Ïˆ®4û\é^\0Ì’.\Üd¾\ãz\×Ið\ÓY¿µ¸˜²L <‰Ý²y`{\×\"œT•\Í$§\Ê\ìAñ\Ú\å4¶u‘ü¢¹#•cLøƒyo¦\Û\Ûÿ\0f\è\Í\åD©™,Ô±ÀŸz\Æ\íE¿\á‘ \à\ÊÊ¬:\rydW³ùk”ˆœ’95šK\ÜÚ„\\©ÙŸI|iøeýw$ñ\Ûo…‰9\Åy³acc}®H ‰xÌŽnk\î\ÍcM¶Ô´æµ»@\êÀ€H\é_(þ\Ö\ßn\'´[\Ë 6Ú³È™!W9f=\0\ê~•ôX\ÊN”\\\à®|ÃºWGjš\ï\ìÕ£—[²W^B\\ÿ\0\ã \×3ªø\ãÁÐƒöw¼¹n\Â;m þ,Eqþ#·²Š_*+\ä\Åò‡\ÏúÓž\\\ÃÒ²ul­\á·q(x\äMûû¶x\àskÇŽ3/t\Ë\ë±½\ã\ßZ\ËohðY\âbv—ù\È\Ç9\í\×­rð_\Þ\Ý\Ø\\^4qGo\ÚB7\ÎX\àñøU=Js}*’¸\0laþ4º\Ì#Nðø€¶&÷Mót\Æ@QISN\Ü\ß\×\àc&\Þû³6\ãY¸yd28—v–\\m\Ð\n\Ýð\ÝÖ&™=ôú›\Û^YR\ÎXƒy\êp3Œ`ƒ’AWs“\Øf¯\ØÆ\Ù}©ÁidqÛž­^Œ\èC–\Ö7öi£°ñm”K¨X\\<Nc¸s,˜\ç\Ì\n2\ëYš\å\Ô\×\×+ª´…\Ç\Ý*½°;b®ørð\\\Íö[ý­.š\nA3q½s\ÆG¨\ìj=Iš\Öo´\Õ\ÌnÙ–. Ôjóh¸Óš¥Su¢~¿\Ò//c-wG}ðû\áö›¯i^½ÂºGŒ™2g \à\É\á^·\á\Ù\é:w\Ù\"‘™Y\"b6ó+¯\\\àq{pk\ç_…þ4:+þ]\Ù@\Ìg=²?Nõ\êúW\ÄnL{Â‘\Æ\ìp¼õ¸®\nñ©\nŽ5u]¥Ž.5¬£-{\ÜÉ¦\Ãf¢R\Ïlóxv6!0+\É\àö\éN¶\Ò\ì¢Ò´{û4e¹˜\Ü5\Ä\Íuˆ\ÜF\Ã[§\å?š÷®Z?A%›†9±\Ý\Z¿©>£“Öº‹\rHo­ªK„Fªca\î\ËóH_”:3ƒ\\!M·#¾•i¤“6<w§iúF¬\ÛIr’Cjw+¶\à\ÊP{–ù½1Ÿ~›Â“jø\rd·¸´šo0‡Š8Ï›2F\ìŽ\ã=2\ryÖµ­\ß¦ Š\ám\å\ß€N\ìŒ7^±J·ðY¾Ï­4—„L.\Ýr=ü\áQ%Z\ÑZI/øsy\ÚT/\'\ïE™?´]N\ëK‘5¥kVR…­\×\Ëe\Ç ƒŒn\ã¯^k†¶\ÕQ]\Ò\Í\å‰\"9¤\Ü\È>¤ýk\ëHa\Z„s¡‰RgA+üÿ\06\Î3•\ÈÇ§¼\Ç\ãgƒ4\ÍVmö\Z]µ\âò—61\ìŠc‘• \0	\ÆNp>µ´°µ!e+®Å‡\ÅÑ›\äœmùPúÖ£<)•Z2Ha³wn¹)·j\ßgóò\îr\Ãß±ªþ!ð—Š´ë‰†™,—ñC½š(\ÎT\ärƒ\Î>•ƒ{\'ˆ´¶Œ\ë$O‘‰!eEn\ä»\Ðñ\È8>\ÜÔ¨\ÎI\ë¯n§O°ŽŽ\r4i´—QÎ¬÷\Í:\0	\ìqÞ´!\Õ\'·³4„\á2\Ägôæ¹‰¼C§Ì§Ì‘¾A÷*ñ\Ç\ã\â-=`\Ìq‰cŒ©–V\'Œž£­(Æ·ò±Ê‘\é\Þñf©mó/\ï!CÀ~	õ8®ƒEø‘sg\â±¦Žö7[0ñ\Ä“\êTdg†¼¥.\Ö\ÝÕ£šG8Ê¬C$œzT««k\Ó}±­\ß\ì¡z\ì!³\îzUS\Ä6­&s\Ïwt©§»Ò¯´fºþ\Ú\Ó.\É\ÂG›ÔŠR¸\àl”«¦+\Æ|q®øz\Þ\ê\æ\ÎMB7grw©\ì{u®Z\Ôõý_F_²JPo¾\Ù8\É\Ï8$ôªi^µyš¦¤\ábQ\Ëzj\Öu©·\î\èL0n	ûI§‰.\ÓûG ùj\Ù199\ã\ÕÂ‹\â}@ˆ\íK\ÛC“ûÿ\0(·\ázô7Àv­^Kd¦\â\Ë5\ç\É\æ¸TQ“×°\Åm\Ù\Äldy,	´¡s—û¨ŸÁŸ\\æº½¤\ä¯=™„iM]œÖ‡ˆmlÈ¹p]²\Ì\ÒF	\'\Ðc±ý+®ð\ïö½ÕƒDFš6$!\'°Pyü*8\îFC\Ø\Ä`HGR}N*Ã¤öm5\Û\ì0‚ò\È_ŒO5”)J¤ý\Æ\Ì\åQ(û\Éúþ‘\âaE\Ë\êpOX&=À2IÀ\Ï8\Ås\Òj\ÈÑ‰\íÀRF$~8«6ó\êþ%¾}?E´û5œ¿*ª¯Í·¹cØš\ê­þI\ä&\é\Ø6Ñ|Wuºn\îN\ç=Ldˆû\écYúÞ›i©X½\ì,2)2\äôô­m¹â¢•9\Í}›J[Ÿ4|û\\~\Í~+o\ßøŸA¼²»³»#\ìö„ˆ\ÝT°g\åa\Ô\äc¯Jù—\Æ>\Õt\Ø-õt’\ÞY¡\Üz2ƒ’8=¿:ú£öÿ\0ø¨ú¿ŒuO†w^´Ht˜¤±\Ô\åy\í%hÕ\Ó)ƒmÁg®1ó%\åô¿e4\ÒÈ½v3’õ\Çc_!‹«\nu\å\n=ÿ\0®‡$\ÜyŒ/K6r\Ë+\Þý\ÙUb\ä\ç\êx¬ÿ\0$ó5ºÁžRÇ’q\ÎI\ïùV\Å\Ã\Æ\ìX6Ö¨\Zr¡˜>}H©§RjjoVŒœ­.cIð\ì—\æL§p*x¬\Zó\\Ž\Ö\Ä6d(ô-SM!ß¸J\Êq–\ÚqZ>¸H£h†–\Þ:ƒ\Ç_j\íúÄ’»:#[¹Ÿ”\Ô\\…\\™6ŸN8®\âÝ¬\æ\ÑJ4ñ+’\Êc\ËgŽ+“Ž\Ïe\àù\×ó)õ\ÍnY:|Ñ±,\Ê2¤vô?\âcZ¨Ô®qÊ«U9Ž;\Å>»ó¼\Ë<õ–\Ûþ±q\Û\Ü~µSH¿Ô´\é’ÿ\0/X¤8ükµK»G¸C%\Ú[³`H\à‚x8\ãwª\Ë=\Ì\ÐOr$R˜žQ\Ðc¸=²9\Åv\Ó\Ä\ÉÇ’´n‘\Þ\ç\Òh± k\Z}óü\×rX\\7B\íº2Ÿ¥t–:Þ©¥Y\ÙgŽ2Z)\"m\Ê	\ÆXŽÇùW#uá¥‚a-´\á\Ã`®õÀ#Þ–¿µ.´¯20p$³”¤‰øAü«™Ò¡R^ä®»=>\çþw=\nxŒM¹_4|õüNÍ¼R\0&#Ÿ@n}È¬I<a¯\é\Z\ßö¥„\Ï\Zó†R=¬‰Ž|nó\Æy9Ë™?\ÞCÁú‚E]¶6\Ëg[\'Tñõ\âº)a°P\Õ\Þþzþ‡WöµG£Hõ/üf\Ö\áµ\ÃC(3a›Ë—ƒŽ{ÿ\0\\\×SiñƒHû,Q1\0~\æD|ƒž„€9\Î}«\Â\Ú\æc2% ¶1©‰˜>Àv«Z\ÙþÑš\Ò8\Õ x\ÈfwBVC¸\r„Ž9ö\ÇSX\×T£QF‹Ó®º~\'%LÆ¢\Ù\'ýyL[x»ÁúÖžnl\á4ª\É: \Ú€v\äGøW7­xJ½´si£\Ï$‘…ÀŒ¶\äŽ@Pz×ŽX\Å5Á{;¹¡\0ð²¿•t6~+\Ô\ãˆC<Á€\0\ÇS\êqQW‰”T¥ý_\rŒ§dÔ¬\ßs¥¼ðF˜Í¾]<yrH\Ì†=pIüj-\'B\Òÿ\0¶n!‡@’\Ê\ÅdE\'\Ú”8\Æ†2Hç§¯jg‡|h¢p—ªƒ<+\àŒú\×H—V÷efQi<¹ý\Ñ\'s\×Z\àJKF¾G¦±\rõüCLÐ¬\äX\à\Ó ‘.\Ãlm\ã®{ö\â´²4\×Skw¥\Æ\è\Ão\02Ÿz4h¤±¹™ö\Ù\Æü€q\Î:`b®\Û\Þ[A -u¸—\ÎDyã¿¥L\'8?z6ù!Ë•ü/ü\ÈfðÆ“\r»\íb@Ÿ0R˜\ãñªZ|W\ÎÍ§GR•J@†{ƒ\ÔU\ïk¬\Â+[˜<\ï\\\í\ãù\×?.³t%ŒO2¼I»$‚2Çƒ\ß\àSž%F|°Vô\ntÜ£y?¼\Ö\Ò\â¿6\Ï&§|·7rn\"@wŽ\ÄçŠ©o—|³>}½+ÿ\0^·ižp±(!¯¿…X\Ò#\Öõ¤[}M–\á7sq!Ú£ñ®Š*U²•\ÙjB\Z­\rŽXIˆ\ãC\\õª\Z^“«ø÷Ä‹ed²\r*\Ø\æI\0ùYýI\ïŽ\Õ\ÞxC\áS\Î\Â\ç\ÅWŸh$\äZÀJ\Æ=‰\êkÓ´}>\ËK³K]:\Ö+xPaR5Àôx\\,R\Ù&#ví©‘\à\éž±H¡‰K¼\Ý\É÷®lcŒ=©Ë–8©„?\ìšô\Ô\Èóœ\Ûwg».Ö›\"\æ’#\ÛÒŸŸJ\ìÙ˜ž_ûF|ð‡\Å\í./\í7O\Õ\íe¦¯hŠfsŸ-Á\âHó\Î\Ó\Ðò\ç?)x\Ãö0ø“e\âI-´½#W\Ò\Õ\Å}=È´v$rGqŒ\ä\ç­}ö\Ýy¨f\n– \É,prW\Ëðõ\ß4•ŸtD©\ÆZ´|,¿±–¯¥h«øƒÄ¶RP¼–ºz±€2KK eük\ç_Šƒ\Â\ÖZ‘Ñ¼9\n\Ê#|Mx³3†>Šz¯JúKö\äý¡`ñ\×¼|‹…u[ø\ä\ãQu?êùd¤rŒA\Ï\ÊZ…ÕœlþC	gn„•×½|þ!Ð…_gE].§5Gò\Å—1¤F\âˆ\ç¨‡õ«\Ú9U£\06\Ð}Gÿ\0[5¨y¿hgffvl±=ë¦¶Ó¤o‡\ë¸\î\n0=\n“\×ð?Î´©M¸-BTÛŽ†´2[°•R¡‰B[õ\Ïj‘%D‰\Ùˆ\í\n\ä7#¯LqŸZ\æ¬o¤b#CûšÖ´”´j²m79\È\êEy•(8½N^WCšwÈ m9\Íciú\ÄW—w,LÑ¼¿¾Œ±ù½\Ôs\Í_\×o\rXTŒ“œõ¬¯\\[Çª5¼\ä*Ü€M\Ù\è~¹®ú1n›rW;`\ÔÞ¦\ë\\\Ê\ê“\Ú\È\Â	€m¼|¤t\è«X^-Å²J\ê¨J|\Ätf\î*)´ÿ\0+OŽ(¢\n¨\Äc\ÏQ‰®\í’KY#\0,„©ö®)\ÅIß±Ðª:vI“\ß\Ü\ÇYh÷\Ë!\êGµð\ÈdŒ\î‘\áds¹}V·ón.\Ö)œ0‹“\ÇQÚ´%À^1S7Ê¬†\ês;²H´ø®¥\ØT<‡8=ûJöw\ÖL$³(\å~ü\ä3cDò˜\ã9§’:ƒ]F-Ÿˆ4U–A¶\å\×e\ê¯¿Ò¸\êV4¤õ‰\Ë[I]ö³,ðù‰¡n<\È\ä¡þ¢†W2ª\Ë!PÇ‚¿\ÅT5y£\ê¸\éø«/øU«‹}RÐ´,#™Z<ô÷¢µU«SJP—»÷›Â¤š\ì\ËWv‚x\Äq8\0õ-Öµ¼3gcj $fX¹\ëXVw\Í\åJÊ¯Ø“€kR\Å$“LÜƒ‘ŽA®˜æœºVü\ÍaŒiò\ËC½ðú]~Í¨\ÞAƒü¶?o¾Ÿtð²ÿ\0h\È\Â@7n\0“øõ…yþ‘­j\Z| \Él“D;x5\ÖXx\ãF(¢\â9 lrWdqY~\"6vüŽºx©o	’\Å\áJRTjó¸•Ànmx\áð–q.£}<\çý·&¬øo\ÄZ\rüŠ–\×\Ñ\ï<mcƒ]Æ•e\\¡®º4¨oM+y\Z\ËQ\ï\"\rÁ¶\×O‰¤#\ÙHú\×U¤\ÙZ\ØÀ\"¶\"A\ÑUqUm\Ûh\Æj\ÔRž6ó]ÐŠŽ\Æœ¤õf‚°\Ç\Óô©#ËU[ei\ÆNjô’Cc™!±ž{WDcs	2fx¬\á3LÀcÖ²\Ä\ß9Ú®Fx<Vn­¨\Ëw),p€ð¿\Ô\Õ\ÇþEt\Æ)\"ª‰\Ã\ÇQNÝŽýj3Ê‘žGJEl­ka5xOü\á\Õÿ\0Žþ‹½\n\ÓX½\Öôk…kK=1\Îë„‘•eƒï€ 7|c\Ü×º)È¥k:´\ÕH8> \Õ\Ï\Ì?~\Ê|A§½õ·„¯t\á7Eª<vòMÿ\0\\Õ˜~ z\á|Aðÿ\0U\Ð> \ê\Þñ!I\Ôt”’K“r\ÙET\Ìe\ÎKŒ\ÆrX\nývqš\á¾?ø<{ð‹ÄžµKxu\r^À\Å\Ã È¤<a›\ÚYc^U\\­(^2wF¢š\Ñ\ê~NZ\é+¨j0\ÛÆ»ZwX\Ð0\èX€3ù\×Ò¾2øªx{Ã\ácnò\Û\ÇÅ¸Uá›©oûëš±ûþÏž(\Õ~)A\â?\Zxz\çNÐ¼?t]£½C^]Dp±¢žY\ÆY¾\éÛœ\×\Ü\Úe­\Ã9š‘\\ü\Ê\Ãõ–:´œ§§a\ÑM^\ç\ä‹<¯xU\êö\ê«+”G·GòÈ¨b>U®ò›‡\ÝV\Ï~Æ¿H>6ü\Ð<e¡\\\Ã÷£%W†V\ìG¡ðÿ\0Æ¯„\Ú\ï\Ãu\Åð3ZI1H\îW 0\è½qcpõ)=V†\é5ª\Øòj`[`~ˆZ\É\ï\ãÒ­^‡7L\0\Éfýi¶j¦P®B‡\à9þ\ï\í]4Ò„44„Tbužñ\Ä\ÐE§ß¶\æ_–)ˆûø\ìO­n\ê6²O¦¼\Öÿ\01ˆe\ÔHÿ\0\ëW`­c~\Ñ]\Û7˜911\Æ\ïF‘\Ùøú9X\Ä\Ó\É\r\È\Ï#?Ò¸qR–\Ãæ¾Œ\Æ\Ó$Ax%\'\nñ¬x\È\ÆE_Ž2\à\È\Ï\\÷­o\è†.ú\ÞûB9E\0+\ÇÖ±%·“O¹Ê†’)¢8\ÆO·Ò¸j%vº“\ÏmüŒ¸ù[¶jßZ\æN{xËˆ\åŒ\î+\Õ=\r\Z Kh/!a¸MÉ‘\Ó\Z±\á\Û\î<\É “\Ëe\0\\cÒ²”%8ºijËš\çI#¦¾´µ\Ôm\Ø\×\ÌDÀ#¨> ú\Z\ç\àð¼\ê\\Ú¼oµ²\Ê\ÙRW\ê:\×Y éšž¡,pÆ‘?y‹`Îº	j\Ó]5œöRAr±ˆ2\áeÿ\0tô5\æªX\ì>Š\ÏæŒ¹jCN‡›x‹Iò\î	…\\¡\ç\r\ÉO\Äuª\Þ2Y\ëkq#F“”·E?\á^¯¤øp\ê—k¥\\B°\ÝJv©q°\î\íYþ7ð¡,c’\ÅR\êÔ€.#S\ÈôlWN§µ¤\å(\é·üd\ÓWf`Šw“É‰RF½nø+\ÃZ\ì\×ñ\Í6iua¹dnÕ…\á(¯\ì\ï›E½µqueŒoOZ÷ßƒš-\ÅÝª\ÊU¼±\ÎH¯C•aªIN-§M%(–l~\èB¯ý—\n¹\ÇÌ«‚+r\Ë\ÃðiÑ±·B7u\É\ÍvV¶1ELcŽ\Ã9¨d…I*k\ê!‡„>W5\ÎE\í\Ü7Ëœt\äU›y˜ð„û\â·M”nÜŽ:R]4ø’7cZÆ›¸9šD±ƒs\à6?*\çu[\én¦%˜\í\Ï›«\Þ=ä¥· ð=k9\ä›·¨\Ít\Æ)\"mriž½©7û\Ô+.òAŽ\âœcÿ\0­Ut;W#\ä¤<7ùª\Ö2»[üš³ \Ê;WCVd&I*i\Êr>”\Ä\ÈQ\ïKšÍ \åi}i¹\Å;<f€!™I<\ä\â¢d\äüµe©‡4Ó°\Ó,«.\è\Î}:\×!ñ“À\ÚW\Ä/\ê¾»+kqjñEq·„~ª\Ç\Ôn#\Ó5\ÞJ¼\çªDLgj\äú\ÔÔ§\Z‘q’Ñ‡‘ù]ûD|×¾xº\ÛC\Ögµš\æ\â\ÍnÑ­CŠ–`B³¸‚¼ñÞ¼Õ­zUþPN=«õ\â‚´ˆ^¸ðÿ\0Št\è\'ó!x­/ü•k›l|ñ1\ä…$gµò7‡¿d/]ø\Æþ\×V³³þÈ³r‚õ.€ûr\ã\åhe‡l\ç9\×\Ï\×\Â×£R\ÑNI\í\å\êb\à\Ó\Óc\Çþ[\Û\êZ2h\'\Ð\æ‘\à]\ÐN\ès³<mq\È\ë\ë[šGÃˆ,u!weªJa<§ˆ·\Óp\Ç\ç^ß©ü3¿ð~Ÿ˜RgKt­(=N+Ÿ¹±’2C&1\×Ú³t´÷\Í-v\ëA†óI’\Æ|m•6\î•=ˆú\Z¥¨øN\ì\Ö\0»•T*\çªñŒƒÚº¡\Ã\Ç4õ\éQ:•\Û@\á\Ü\å4¯²øq4«Ð¤®\á‘\Î$ƒV|=\áht\ÛDŒ	%\Ï~k¤U\â \çÇ­(Ò„l\íªV\Z¶*hZp·\Ôc‘N>j÷¿\Ã\Új!\Ø3Ú¼V\"¡ƒt \æ½3á†¬»\"\Üýk¶…D†\Ù\ÝI\áý&òò‹‹y\'¶pð\È\È7#†µ\ì´M>$“ý?\Þò\ä¨;¾µZÜ¤€H>÷¯¥_‰\Û9ö®¨¥w¢\ÔN\Ö\Ð\Âñü1©]\Ãsq¦\Â\Ó[c.ü»VŽŸamaj-\íaX£^Š¢®7­5\Çq§¶\Ò\Ü\Ä\×&«J™lŽ•m\Ç\à*)ŠG‘\Îy«N\êDµ„\Ë!\à}\Ñ\ë\\–³s%\ìÄ–;}*î·¨5\Õ\É8>Xû¢³\ßct8ö5Ð \íp(K¦jCŠ\ÑdQ\ÎG\âj­À[ƒ“\è)Ø«Ü¬±±<\n”[\Ü\à|‚¥´†i\ßj)\×ÿ\0¯Z«¥Ï´~ýºzSJÀ\ä{ùù.8\Ý\×Ùªü¹9<Š\Ì\ë9Ï¨­P<\Åã¨­¥±	\èÔ§Ö¤AH\0\ÙÒ²¹|£A\î)\Ë\È\ÆicoAJ@Bw´\Z\Ü\Ò`Óˆ”\å´#\Æ\rE4J\ÊA\éVE&¥4\É0u\0~ej†\Í3´6\èEnÝ°ð+2@<\ÑÀ\ëZ\'tMoL°Õ­M¾¥l®p\àr+\È~$|$’%{­-|Ø -{”ª¾WAùS4€\r\Ó!\0©©\èx®jô!%r¢\ìÏ‹µý\æ\ÂfŽhr+¢+\Û5ô—\Ç;KQ+m8<ùb¼#XŠ!;\â4„W‰R*2hÑ®¦?\ç4¡\È `š³\"&GÈ¿•#¢t~U‹Ð—C“Ž†¶¼~\Ö\×\ë–À&³Qtuô§\éÊ¢\é0\0ù½*Tšz•X÷Ÿ^,öˆsÚ·\á;–¸O‡<ÚŒóÒ»˜\0\ÇJõ)Nñ3jÄ¹9P\Ø±§D˜8¦¸•µÁ\"$œ\×;\â]CÍ“\ìÑœF¿|úŸJè®¸³”Ž\Ú\ã¥\0Û‚@\Écž+ZJò¬UrŒ¼0?J­0$Ž¹}\éó\09\0ÂŸ\0Œýk¯˜,gÊ­œ(\ç8«Vv‰Ï†?N=U~\Ð>Q\×Ò´mU|Ïº:ŽÕœ¥¨5bÎ•d²òTV°Ó¸\ê)4µP8P:v­bz\nW$ÿ\Ù'),(12,'5847335393d21','ÿ\Øÿ\à\0JFIF\0\0`\0`\0\0ÿ\Û\0C\0		\r\r\r\r\Zÿ\Û\0C\n\nÿÀ\0\0ú\0ú\"\0ÿ\Ä\0\0\0\0\0\0\0\0\0\0\0	\nÿ\Ä\0µ\0\0\0}\0!1AQa\"q2‘¡#B±ÁR\Ñð$3br‚	\n\Z%&\'()*456789:CDEFGHIJSTUVWXYZcdefghijstuvwxyzƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹º\Â\Ã\Ä\Å\Æ\Ç\È\É\Ê\Ò\Ó\Ô\Õ\Ö\×\Ø\Ù\Ú\á\â\ã\ä\å\æ\ç\è\é\êñòóôõö÷øùúÿ\Ä\0\0\0\0\0\0\0\0	\nÿ\Ä\0µ\0\0w\0!1AQaq\"2B‘¡±Á	#3Rðbr\Ñ\n$4\á%ñ\Z&\'()*56789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz‚ƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹º\Â\Ã\Ä\Å\Æ\Ç\È\É\Ê\Ò\Ó\Ô\Õ\Ö\×\Ø\Ù\Ú\â\ã\ä\å\æ\ç\è\é\êòóôõö÷øùúÿ\Ú\0\0\0?\0\æþ|i\×l…®›a+\ÍeÉ–‚w\î„t>\Ý+\'â§Œ¼K\â}Vm/M¾xcq¹§’Sý\ÑTô\ß\êW·\"\çF‚T[»R\ë0M«‡}z\Z\ÖÐ¾xŒß›\íNþ\Î\ÆI`ò\äB\Ê©ðÐ•Gf‘õóÝ™\Æ|=\×\ÓÁ\ê,\Æ]r\î\î -\Ú\é\Ï\î\ÜžO@iŸ­õ_|P>%ñÀX­÷2@\Ì\Å„|¨\0=zTôo$3k²\Ü\î6À¡s\ì\rlxc\ÃZ†§Tœ]ùIò\Æ\Ö\ê\Ìz€+ª1®\âî–¿‘œ\êÐŽl\éô¯k7ò\Û\Ü\Ã{m%©;®‹g¢zþ5»ñ#D²—Ã‹„Ü˜—ý)¶\ÈHþ\é\Å3\ÂZŒz¦•­Gx›·œbA\ì@ÿ\0\n\Õ\Ö5¹\æ¹hFœ\ï0]À\Ä@\ävbkhÑ#Q\Ü\â•i9¦\ÎcÀwZlúcYË¨,ž[f\Ý]\Ê\Íþ\ëŽø­)&†\æú[co³¨,Ä‘×°\íQ\Ûx6[\ë\Ï\í›ûx\ìnŸ%¢´\Þ\ìH\ëôm¼5m¼ùŽ3½ù8õ¥JŒùm2*U‚•\ây\ß\í\á¸<Q\á5ŽFo\"`\Ö1\É\Óoò8ü«\Ë<9ð\ë\â]•Ú‹­:MªA\râ¾ù\Í{\ç‹-g†kks\ÄÁƒª†h\Ï÷—#¯·z\âüs\ãýj\Â\ím/­V(‰\Û\çC\ÂI\è\Ã\Øþ+ª0å…“k»\ìsz\'\Â\ê^1·¸ŽX4ø™óx¥÷‚½Ê¨=O\á\ëZ^-Ò¼K\á­¬6y¥Jø·\î\0|÷þøô\ï\×5\Úü=×š\Íb\Ôm™gC:¿ û}*ÏŒ¤²ñu\Ô\Þd+	=a\rò†\ê1\èGb9§\í\\d>GQ]œ.\ãÿ\0\ì\ÝA!º·º·S\Õd7\à;Šô­\ãO…tû5{Û‹´#¨ò	?ZócK³K%‡RhKy6–rD\Ðg¸#ªŸZ\Æñ—‡\í­|3-\Ü7™\ÐHÑ¯÷†\Ð	µ•Zô\×4uF*	¾YhÏ§~\nüO\Ð>\"\é\×wšó°\ÜfŠu\Ø\ê?…ñ\èÃ‘^…\r\â}3_|\Ö\âðŽ·y ø‡M½R‡l¨/6äƒ•“ù×°[üMñ\nÎžm©À\ä\íù²=±]Ô±P’W\Üã«†”$\í±ô\Ü7[±†ýjU¹ p\Çó¯>ð?ˆÎ¡¥EpX\åÀ5\Ô\Åxz\×Zw9™ò\íµ\à­K\Ã;“\Æ\Z`—û+\\”I+&JÁ?ñ©>o¼?Jñ½ó¥vW2\Ú]!Ê˜e`Á‡F\\n\Ý+ôK\Ä\Úf•\âM\ëD\Öm’\ê\Êò=’\Äß¡±A\í_\rütøQ®|7ñŒ\Ë}«JÌ–7LB<©Œ•ô½\ï×½}6UR^\Ê[þðO½\áü\Þi¬=_‰m\æ¿\Ì\Ýðo\í\ã\Ý\Ö;\Å‰´ô!A½n\0ö˜sŸ÷¨?hpx£\Âpi>]KJK\ÃPY\ÜnP:FŒ§•=\Ï•\ä\ï©:“x\å\ÈlõS\ï\\ç‹¤?\ÚqÁd\ÖD<.zŠ\ÛKMûE®‡ml·\Zêº§i.\Û_\Óaºf­s\r\Éq(\ç8ó\r{ŸÁŒ\Ö6¿\rõÿ\0	x\ÏT\á–\ÔÅ¥#~ñJ˜ó\ÙT\íažœ\×\Ìú£\\\Ú\Ý/(,Ok{E‚FFk€AT%Hþ*ó¨\×rN“Z\\\ÊnØ¼<\ãð´\ï\ÕXÝº»º]^Xå½•\çF\æy s\é[ž8ñUîœ–Wþ#Õž$M°\ï¼r¡z\0Fk™\Ô#/­\Û0r\ÈMF:~8¦;†\r¿\'<Šôi\É\Ã\Ýg³œW4v\Ø\ì>A«\ë^7\Ót-?S½š[û…B‘\\¸@Ÿ\Ä\Ä\Ð($\çÒ¾¡øññ\ÏOøk\Ð4[q}¬\Åª£œAh1ò\ï\î\Ç;G¶M|o\à\ÛýGD\Ö?¶tû¹\ì\çƒ\îK•a\Û\0\Ög‹üMw«j³\ß\ß\ÝKuup\å\å–V\Ë;z“\\\Õ\'^iü‘\ác°4±\ãSnH\ßN­ùùÅ‡\Åo]üM_\\ø¢ð\êq\È6H\\ùh\ãòúÿ\0\Ù\Zû?\á\ÅO\rø³\á\ì^\"\Ô5m?L’60\Þ\Åqr±ˆ¥\'nã’¤G\×«ó—H¼&\\’>cÛŸÒºm\ÎK›W‘ˆ\nX*Ž¬\Ç\Ðôa•<D9z÷#–\á1øxòû®=R\é\Øûƒ_ø\åð·Msÿ\0b\\ºœ¡C$¿¨ýk0~\Ó\ßÀÀ\ÔuRþ\Í~Zù«Àÿ\05-Uay‘U¦l\ÇŸ2bƒ©*¿tpylWN~i \à\ê6¹ôþƒú\ç]\ÑË¨µñ\Óáœº\Þô\å—ù\æ½\ã-z\î\êk]\Ê\Î\ÎþA4ªwgGZ£}i«\Ý\éQ\\\Év\×3/ú\Í\Ã\0þ\ê\ßb]6+»¨’+‡¶$³\n/û\àf®i\ÞšûNZUŒ¿u\\žkòZJ2n\'•RNš¹\æ>\Ð/uÁ%\éhm\Ôg\ËG!Z»\Ó\á©\îv\Ú\éè± ¼b·´¯\0\Ý\Û\\ÚŽø\Çð\ì®\ÓK°†\Â(Pq\Ô\×T)\ÛDŽ*Õœ\Ìx\×B´k’‰%ä«‰%+\Ï\Ó5e|9d·\Í(&S\ß•i[\Þ]\\x‰\ìX!8=InŸ…TÖ¾\Ó=Ç”’˜\â_½´r\ÇÒœZ¶\ß3ß©WU¾µ´M e‡ð¯õ®KR\Õ.¯n~\Ïgå¬Œq·©\×\Û\é¬žc!‘s\Ï5\ÑbŽ\ä\ÜDŠ²öy.w\Z‚G\ã\'T\Óm#–i\Ì\ì\é–\'\Ý>œ\×%{¦Z\ë\Zd\Ís†U$\ÛJ€3v<v>â½‡R\r3yŒ\ç¦k’\Õ<mq¨-ÔˆW\rò•\à³v\çµ¯\ZnòWEr7¢zž;\áM+\ÄZ±ukk§\Í{¥ÿ\0GŸ\Í!byW¯{\Zß˜N±C0\ä	ú^½¢i\ÖcFkx\â@Qˆ!zf¹_i_\ë#\0\ä\ãŽ(^þ¶\Ð\Ó\Ú8h™\Ç&‘%ý³\ÝMz£¾Þ£¸ õ\Ø\ì\Ú\ÒŽ\Ø\È\ÈyÙŒªúnâ›¨-õ‰*ÿ\0.\ïîœŠÁ¶Ôµ-2õV\Öö1\ÉóA9ùô_Cô®„\×-ŒnWe\r_á·…õ]_\í·\Z3A9m\ÒW1,\ÎTqùb½;\Â¡iZ2ZY\ÚE\ZF¼&9ýk&\Ï[±U¸ów…7¼er\È1úq\\<U¦-›\Ýi\×ñy\à}\Õnô¯+ûÀ\áÍ°ÿ\0üMO\rüR¶ú–£\0Hƒ8·”Œž~h\Û\ål¡÷¯[øQñ†\Ç\Ä\É$H‰41yžxRU\îv’v‘Á<÷¯<Nš–½\â­yDE*]£“Á\äž*\êZÆ˜%StöÐ°(\Â3´\Ã}\ë]¸zs•d¡-\ìiK\r\íùi\ÛW\Ô÷ŸŽ´oˆõ=Jm+À÷¯¦\é°1C{\Z>èŽ¥Iû‰\éŽMxÏˆ<c\â\rz³kúþ«¨Å»xŽ\êñ\ÝU½@\'\0\ÖTò[3`:…ôJY-Œ\'7&¾Þ’£F*0K\Ôû\Ì&†‚8+®¶\×\ï5\ä\Ë†õ\r•$ò8ª—N®ª\è¬$¿¨=©ñ!ž`¥ð?•& ¿eŒ§st½ENiA·±\Ô\à¬\Û\Ø\ë|#y\à¤ð$Öš\ï„4\íOU’7û=ô¦Uš \à¬€p@\"¹™¬|9¾ÿ\02úüòŠ9† sÏ¡cú\n\î&³ðô_\rô\Ë\í*p5TcòKŒò§•ö\Ïs\\Õ­´p^,\Ö\êe’^\î3ÿ\0\ê¬0”=ª“Žš\Ù\Ý?žûÿ\0Ã˜\àð	¹I{·zÜ±\á:\Ùô¡g¨\Ï$!\Ã9\Û\æV\Ç\ËÇ¹\ëXº…œ\Öò´n»H\äg¸õ\Ú\Åbð\ÛEt\íy§!7ø\Z\Ëñ+\Ë:”û4~Z!y\Zöª\á\éºi.ˆô\å\è¢üŽz\Ø=Å¤–«\n w=3T<\á/ø¦ö\î=&\Ê\Þqh\ß8–\â8\Ð#?…ké¡­oe‡GP:©\ê(’	¬õCu¥N!ó2Áò\"ž ú\Zñ18iJ*]Q\åc°U\'\Ê.\Í~&M¾š\Zõm Œ¿?\Ê1\'$08#z\ê<!¥\Ý\ë(ƒA³’8™\åò÷†\01\É=f\é¶wV,\Ó\Ã§\Îgp@Œ\àúû\×K\á/‡\ï\ã\Ô,\Ú\Ök„ÉzU>¸\Ï_­w\àp\Ò\æ\Õ[¿õù”pUy4ü9ôUŸ‚´¯\nxatK‹Ï·\Ý\Þ(?dÓ u–\ëƒóIó¨=\á{óU›À^\"v/¶V\èÜ¬>yý\Ðþ\ïŽ:q\ÅyDün«&\Íu­Œ§÷(Žý†\æ\ÆOô§\Âs\ãžþ,\ÔAÿ\0®ƒü+¶x|]ýÖ¾ðÇ‘[/\Íy¯	\Åz\Ýþ²üOM¸[ø\äMª\\ùQ$ÁÁ\Ïnq\Ï5\Ðx{\ÆÚ­Ò$\êhÖ£tB†t=~a\Ës\ëÒ¼\ëÁþ#×¥i Õ¬\âr¸\Û }\Ê}ø\ãðªö··_\Ûm»–&™\'\Ì„\ÇEcŽ‡Ò¿Ÿðõ\çC\âå¤1SŽ\"‡5µGµ\Ú\\\ëOi\\j7\ï,¼ƒñoJ\Õ\Ö<Mo\á_ý«W¾‘~Î›‹;\ì}½MoxV[-KÁ–z¢\Ã\Z4\è9Ã‚>™¯™l\ÝoS\×/\í|3¤¹\nX¼¬@‡µ}cÉ¯6\ç‘*ž\Õòò\Ú\ÇÒ¿¼Ea\ã	\é—&x/\×(\ì¸~§;»\ç>µ\Ð\ÚO’M»\î«v¯ý‘^?|\Ñí¶¸…šO´\ï?q‹žG·ø×²\Ø\\[\Ù\ß%\Ë\Å\æZ\ÌD›‡}G\ãJ2¹böf‹RmšS\éW\ÖÑ¿’¨Ž¢L\äpò¬}Fö\Þ\Í]®[`÷©|k\âØ¤žK\ÖÏ–£\äªök\Ê<U\â\ë]D‘5ÜbOÝjÍŒ{bµnÐˆ©[S±—UÓ®µ\Ød{²\ä\"¯¡\'’\n\è<ifñxr1hÁd‡\ç,:\ãÿ\0¯_>xª\í®Yaµ\ÖfÃŒ†’?+?Lô¯Eð\ï\Ä(\ïth4ma\Ýo’b8Ÿ\é’1ø\×=dœt5‚÷‘\ã>&øÇ­øs\Æ>]µ š™š)!•px°\'5\ëž\Ô\'ñ\'†­u;„	%\ÄAÊƒ¦kÀÿ\0i	|9‰Ulä³¹‚R>\Óo»3,2\0\ç\ß\"¾‰ý›´\ã{ð\Ú\Ó\ì¶WQ\Û\Ú\Ä¼Ñ=¹ÿ\0\Z\è¡Q´¢ñ\ánr‡ˆ¼>n c€0:\×	y\ácwxm\Ý\â\È`\Ê3´Ž\ãÞ¾:[”•C3\Ó\"¸ŸÁ¦\ì\Ó\Ò5‘¥\Ã¥S\Zž{Rƒ¨ùby,žº\Ó.\Zw’	Y\Ûoš$\Ø\ä€©<\Zòÿ\0Šž“I½kÄµ•`¼9*#\á[¯áž¿{¸\ë(y\î\æHž#ó!Lø÷­{\r\Æ\ïA&;»K\è®\ÖF]\Ê;\ã#éš¾h\ÕVµ“Ø¸\É\Òwn\ç\Êv 	ž{l#‰\ÇPj‡ˆZ\ÙYJ\Èð¼ƒn¾Uö\'ß¥}\â†–r\\o—KI\âH\0Vú:\×\ão„·’>Ÿt\èÝ¦?\0\ß\â+j%BjO¡\Õ\nñ\çS‹\Ôñ¤2Lv f§HH\è	*þ¡§\ê\Z¦l5h\'„“¶1*\å;£w\ëR¨yCü¹\äf¾«	\ÃÔ\Û\Ô÷ðù•4½ýGOVINÿ\0òiÌ­>¬©&\"Á\ÇlÖœZUÔ 40±ú\n­weqev\É,d1Á#ô¯J†\"& ¾¯©ß†\ÆGYB;-}Iü\à¨Ê£\åc\È\ëQ­\áI#\ÚG\Ê3\ÅC\"\Ê\0\'\éÁªºÊ‹sV\ã5\Ù[\ã®‡³Rº„nvú¢/t;›IUPn\ß\ìpîƒƒ\ÉíŽ¤\Õ	b\êeF\Ã8_Æ¹}>öbDi)U|ƒŒ×¢\ÜÍ§\É\á[K\Ø¾\ÌD7;N\Ò\î{\ÕøRKp\0 \nº8ˆ\Õ&5#£¶\ïúû\ÎLƒ\n3\ÐI\ïV|90Ž\Þ&`	œ¶üÀSõˆ\"6`DŒ¯pp?\ÃÔœ}*´%aP8F#\àûWZ·´º\Ù~ð\Çd\Zœü‘­fò<Zo/\Zóy\Ú=µg8’\ÚB\È\ÌqÒ¯Z	>\Ó\æ`ñË¥\\¿´\Ê  !—+žÆº\Z’[šÎª„”N›á¿‰ü44¯#Uylµ86w+\Z”\Éõ\ã$ÿ\0¼q\é\é^€¾7ð\ÉPdð\än\ä|\Íöø\×q\îq·¥|\ïª[\Ëg3«£A¡uY™@õ\çT”9\ß>ç—‰ÀS­>k¿¼\ìþ\Ý\Ü\\ø\"\ïS\Ô\î\å\Ýw;<EX.Œf»o:´+²\î2Ì£½3\ï^o\â†‹D\Ú-‘6,dq\Ó\Öx7\Ä‹4K¨±§\Ìc\'œ\×áµ°Ru½¬•‘òªr\Ò\åR\Ôú\n\×\\Ô¬¬\ÛN¶\Ôf‰%LŸ/¢ñ\ÜVV…£®©w\ç\Ü7™,ŸºwnI\0ü\Ç5\Íx\Ä\Ð\ê>$6w>z\ï\\ \Ï\Ðõ\ÍtË©¿‡õÁþ„ò\Å)\Û©ãž¤ý+\ÑS\åQ})GV­©\è¶òAi£ý¬KB¬2«\ÇSLV\æ—\â\è\äÛ¥[\Ë±©\Ç/8=FGÓ‘ùWŠx\ËÄ·7ºŒ6–2\æÓ*–A\än\éýj\rTó¼3sqªyðÁn\Èñ3\ä\îp?\ZÁVý\ãQ	aÛ‚o©\íóx¦\Â\ÒôX\ê\ÚT«4±JöÏ½j_øF9X\î-e¶˜	#b>tÏ­|\ç\àø‡\Æþ%\Óô»0X[\\0S7ú\ÇqœaE<zW½ø\ê\ÃW´ðòk¢†5\n\Ä\×rt\êE\ÝlqÖ¥V„”e£g5\â=KE4z(\Ú \ç\éY~$ðÂ«­¬‘K}\ìr	\êkgÁW>(,\Ï(†/+£ùôù\×K£\éwwÚ›p\æ\âG99Pû\0:\n\Æv\ç\åˆ);]žŸb>#__\ëS«-\ä\Ã\æL÷,\Ü\çð¯Uð­å®¤&”¿jû,hG$\Çi\Ôƒø\×cª\épZÃ¶\à\à°\Î\ÍrW\Öz\\W\n38?Z\èQi§s>nda_x¥ti\åŒ<V³|™\Éw¦{Uû!m\â+Y\'´ŸP7.8”9‘ŽG\r‘F£\rµ¢n–0\ç\'5\Øx\Z\ëO* (¹\ëŒUK\r\nŽ\ÒdýbPZ#\Ëu¯\ê\È\Î./.\à¡E\\zœõút¯5\×-o-up—M\ÌD®\è\ßi\àõÀ\èk\è?Ž—\Ðiú¸lr0¬9öü\ë\ã-cX—Z\Õo\Ú]Bq\äÜ¼a )\Î1Ÿ^õ2¡\Zk––ð.IMóOc\è\ï†=†ü.›y:\É2\r§8ù€\ïéš›Ç‘®¡|±[Å•ˆ\ØRqŸ\å^\r\à_øš\å›R\Ðf»\Ýö´\ãn\Ð\Ø\Î$gŽ¸õ¯W}_[‹\Ã~EÍ‰žò4\Ú3Á>™=\ëXM¯ˆ‰R\\×\Äø\Æÿ\0N“O¼\Ñu\ÛDº\ÖÁ†g£+J\älô”™X\Æ\éš\Ó\×no\'ÖÖ§g …\×$„£&:\ØýA«¶ri°[#$ñ¤EK\î?:\í\ÂV½[-\äù!\æ_ð2YY\Ê\"½@Tœ†\ÇJ\èü_ð\ÏL\×5\Ëmn{ùm´ö·]\".F\â\ç\Ó\0w4h^£ŽóU¹ð0!Q™$\à9®ªY\Ä^&’\ËO²/m\äºÂñövTw#²®x[¦jñ™…ZQ¶û\Ïò4\ÂÖ”*{E+hxo\Ä_	h\ÚV«s­A{kŠgY#ûA\ÈrüÍž;Á\'š‡Cð3x\Î\Ó\ì\Z4‹ö²\0ÁSœ8\ê=+\èdø£\Ë¹º¥¸‘+Fsœzg\'žµ\æºþ—ªü*ø§¯\áaleš\Û\Éx/W0´`ý\Ð8\àrÁÇ­U\Ó¡Q¹\'ów;kZ¬9õ[\\ðK\Ý6ûF\Önt½J\Ýàº³”\Ã4gª2œ\Z\×\Ò\î\Z9\â•J»ŒH»€\ê:Jô\ÏJ>\'x®KMÓ­uKˆ­§†Faþ\Þs»\êsŠ\ê¾ü$øY\â$–h¾\"Z›	wö7n¶ó\ÚÉœme|\Ï\\ƒ^ö[š\áÖŽ÷\ío\Äö0\Ù\Õ\Z4«{ùjyž“¨\ë$‚\æ\Ù%\"X\áD\É|©\Îk:`Pªƒ““\È\éŠû\Ç\á\ïÃ¿øN»\Ò\ãŠ\í\È\â\çpp\ßFW\Ç´.Œ¾ø·¯iqÆ±Z½\×Ú­‚Žnw\r¿L‘^–\Z§)}\æù>sF\"pJ\ÝOò3¼3(’H\ÔÆ®:\Ýy<~=\ë\Üüð~Ox\Z\å–E´Ô¡›Yd#r­\ì}{W‰|7°k\Ýb\Ú%•7\Éuc2H¼¶ÿ\0 \Ç\ê+\ïo†\ZZi>·ŽT3 g\ÔÑŒ\Æ\Ê®SŸˆsIa\åe+3âˆü_á©5]\éW<KfX›\Ü2\äW&Ÿp®T\Ã( \àþ\â¿K%Ki«¢²ž ŽµL\èú)9:e©\'þ˜ŠÁ\æ\Ü\Ú\Î\n\çŸO‹¦£û\Êi¿\'còz\Õ6KQ‹n\ÇÖ½\Ë\Ã~\Òô\ë(.œ¤·O¢\ÂÍ…\ÞN}º~5\Ç\ØøqS]·B‚²«ds\ï]\â\é×—ScK†au\"\"@fû£\è}kò\Ì^)\Ôj0G\Ègu¥Nq§\Ò\ï\æQ†\â\×Sñ\Äz^˜e»\ÕJ\äÁn¥Š¨þ&#\åLry=+­ñôš¾™g§\éú›\"fR\ÛV6i$\nFF8¿¸\ÍkxL\Ñ~x[·nüM«%ÔŽ¼—<…\0ô;úœW™x\ß\Ä÷WB\âúöi¼½¤\Îb\Éy9\É,{œŸ öªª\áO\ÜZ\É\ØÎžqV>ÎšZGK.¾¯RK\ÏÝ¥\ÅÌŸkH\Õd1\ì\Ü\nÊ˜ùH¨gÀ~3þ €]ý…ô\É.\îb¹o•yÇ¾:ñ\é\\w…ü5¨ø†\Â]~b>Ì‘\É$þhAJG\Ì2p\Ìs\ÐrH<Sõ_\ÝZ³\ÍGš5–E\ÈÀaÛ¿^µ›öT\æ\âþ}¹\ÂajbhFRiIôGyã¯Q\\x\Æ\Þ\ïG\ÒbÑ­¬®¶°\ÛGˆ¤Un³\É\ä\Ç\ë_Cü0ø\×áŸŠ¶GB\Ôc›K¿·³x\Ôù c-\æ\ëþ\×|™g°\Òþ\Å}¢\Ø\ß\ÛyebWd‹ž\âE\Ãdc9éŽ•\é|;‹\ãYI%•°¶w†”\Úò)R\Æ\Î$%qE\ÍkKN	û-S\Ü1¹}9As»Im\æ}\'{ZL{¦\ÓeKs’D7…³ŽGÖ¸ÿ\0ˆ^2³\Ð4¹5=Qch‡ðH2Ç²€{\Ö\çƒ~#Zj«µ\Õ\Ú\Ü\ÆK\08gÚºø<)£x¿K–ò\ÓN´»Š\'+,Œˆ|³Ôƒž•×‡Q®½Ç©\àVŒ¨?\ÞDñß†\ßm¼S¥ý³P\ÔbŠü\Îb[Vo˜§P\ËØŽG\ã]5Äˆ!gû3	\æ#¼gk\ã ÷«~7øk\á(4É®­ô»;Y¡Œ¿\Ù}NWÏ^%±\×t¶ðû\\\Å4ú~d·.\Ç™ù†z\ç8Ï®k¢§´r\åDRt¹\\’gœ|E\×gŠ­ |Œ2\Ç=Á®z\Ã\âú.–R{ig‰”¤~T\Â,9\áK9\n5\Ú|oÓ­\Å\Ý\Ý\Ôv\Ø[8	«þ»\àûŽy\ï^9\â¡÷‰®t\r\É\çZºƒ$÷#÷p\']\Ìø½‡S\\\n¼Ôµg¢\èBPN(\ï¼mu\â\Ù\Ûj?Ù·VZ8‰$··–eyX•Ã¹lŒƒŽ+\à?\Âo³üJ—Åºü)5·˜^\ÚÉ\Ëò0H\àzòj_\ÞK­¶Œ\æKˆ!\Úcc\Æö<Â½ƒOº‘,\Ó\Í\0‡5\ÛJ¬fÛ‹9ªÐ8û\È\ÝÕ´}.x–Hm#…Sœ\"…×DZ”–[)\ëò\Ôö>\\Ð´`„þÖ¤w¶ñÀB•\0¦+fµ\Ð\ã\ç\åG\âhw`\Æ\ÑÆ¯ ?(À\Ýøw¯øð\Î\Ë\Ã:™\Ö,ô5\',2±cü¾ý3^ò|Gqs\âIl$Òš1\ÊI¼\ê{ŠwŠ¬­\î-²ÁNGB)8\Ê\ZŽ®\ìxG†ôyõy\ãQ¹\Õ\â\ß $6\Ø\Ëÿ\0²O$¦+Ú¾\\xcEÓ¾\Ïo,„?8f\Ã\îO$ýj…tKIoK´9Œp	\çŸj\í-|=¤cpö\é#/?:ƒü\é\'\ÒÛ–’\\\ë’\Ü\Û¥Ú™À.\ã±ÿ\0¼{Wš|X\Ðôým£“\Ä7X\É\Ê×¿q“\ÔW 1µ8&•/\Ò\Ú\Ú‚¦M¼úu¯(ñ‡ž\âúH¼É®”9\Ã. g±¨w\Ícze)Z\çw¡h\ÞÕ­õm:[E\àÉŽ\Ý%\Ç-Á úz\Z\â¼o?†o¼Xuô³atG›ÿ\0!\Ý\Óq\Ï§·Ö½~\nyð\ÉeS\n\î\\žHö¯?ñ¿†.!¸ò\î`7HFc,3·ž•„\ç\íÚ“:£I´Tð_Šõø®\ÒmJ÷Z´Ó­\îE\Ã\Ù\Ø\ÈZ\ÖaŒ§NG|\Z>1ø\ÓÁ¿õu±\Ó>Ñ¦köˆ\Æk²¢\ìÿ\0\ËÀüŸ»»®q\Åg\Íe%„\n\Ü\\\\\íù¥\Ó.\×v\ßú\æÇ¦}3Y>\Ó\ìn<X·¾”Az[\"\Ö\æ5R®§\'a#žI\à\ã\ë^–õ}ˆ§:”êª±\Ýuÿ\03\Öÿ\0d‡—¶:\×ü$þ\'³{g²\Ö\ÎQó&:³|p+\éøµDÀ…xoƒ|ju\r=d•<›\Ä;/ ÁL\Ç<\ã¡Z\ê\ìu\ÂÀ\Ã?Zõ\å‰öÖšwG—˜bkb+¹\Õß·cÓ¡¾V\è\ÙüjÀ¸\Þ5Á\é\Ú\ÆH\ëYuEÀùýõI3†\Ç\Äu=KR\Ô?´5k™&E”\æyß™I\ê¾ü\çó¯]\Ö5K}&\Ú9ût\Íó™\å?\ÝÂ“ò¨|\Ä}+\Ëþ\Ûý“C‚}6\î\Ö%T6”=Nzƒ\ßÒ®xƒXº7\ækŒ-\Äc>w™¸?¸\Ï§\å_<T\ã)¸-\Ù\âÕ­*’¼½>\àñO‰WS¿g¼½®ˆ	\å™TP8P:þ½p_õ\ä\Ó\Ú\ÓO\Ô>ÎŽ¸{w\ÃI?¶Tp=õW\â6©¤^\ÙM–/$ûI„£vb\ç¥cü4\Ñ\Ú{–¼œ1‚\Ü\ç¦w¿a]Xl:§­Tn\ë£\ëóÿ\0€v\ápö‡\Öd\ì—\â}+û*\êº<þO\ëzl»Qn\"‘U\Ë\'\í0­Ÿ\â×ª|Fð7‡\'¶¾¹dƒJVòqz\ç-\"0\n\ï.Uv¯cÓ­|«\á[K@ñ<:\ä\í™Jð1Ü’\î‘\èEu¾7ø\Ý\â{û\Ûh¯Z=‘¸{h`#j8\è\ÄrN9\ÆxÞ¦~Ê´^²ò>™8T„iJòü\r¿Œ:>ƒm¢\ém¤´¿Ž\é`To>,ûp\Z\"ð\ã$gŽy¿j·Öš…¬‹sº\Æ9–79I\Ã`v\ã5”¶~%ñV®$\"òq\'Ï‚¾f02p	\Æ0+kRðN»\ái\"“RÓ¤®UMº™T—OR™\'®zgzW*r…>hô>Öœ\áZŸ³”•ÿ\0­}\Ñ<?§hzm\Ï\Ûc\"DGue%9\r·¿\Ê{zU}\\[k™n|;«˜\âœ–\ÝÜ„‘¿„º\ç·\\\×\àoŠ÷¶:*øoÅ±%Õ”HZ·¾·_ù\æ>n¼\çÒ°üg¯øXY]O§\ê\ÖinrÈ­\åÈ õ\êk£\r8¦¥Iÿ\0™\åW§5uY‘\è^>ñ¥p^Fl–7t`þDÌ§s\×p\Æ2:v\ï^; xž\Þ\Ã\â%´ú+\Í\0‚\à\0m\î?pô\ï\í\\Þ¹\â»\ítÉ§\èwºƒ ~\îw;³Õ†OÓš\ëgÿ\0†ó\Ìu9./ü½ðy\ì¦%p\Ù>c1\È\Ý\Ðuù«\×t«U…ú£Î½*]4;ßº\ä÷\Ú¾…¥©ŸQ»bò´|•~\ï\ëú\Õ‡~K\ØJ\\¾w\ÜIŽ%|óÏ¢ô\éŸ¾Ÿ¬\êòG>¡q\Ç\n\ã&0S;€ƒsÞº\Øü9kg¥£<[qÁ\Ís\Ë4½\íÞ¥\Ò\Ä\Â/\Ý\èy4žû6±kŸùŒ¥‰\é‘\éô¯Y\Zl0\Ú,m´8^ižÐj‚ðr~QŒõ\ïšß¸´\Êd®k|\'9w0\Ç\â=¤”S\Øä¢,£h\ã\ÜA$’Í’k:óRX¥16I\Æv¨\'5\Ø\\\é‹*‘‚Ò°5M\"[fi!›y\êc#ƒ]2“ZœI\'¹\Ï\Ïs\È/\â\ÜÀ ¯ò¨^†\éü—r®\n°Áü«n\Ë[+sy%£FË¨LŸ\ÃÞ¹=B+\ßx\ê+‹(„q”ÈŒ£<=j¥/v\í„\"¹­c¥\ÒKZ¡ò”\í\'8­ý?W‰­Y$1\ão­Y\Ó4‰~\Îm\í\ÝH\å‚\ì,~€\ãùV²©¤\êPÏ‘\ä\Ë!Á<¡£Óžµ<\ë¹\\·/\rXðýýž¯¦­\Üð´Án\Éhb\ÛõÁ\ÉV tþ!\\®»e«h?\Úú-ûF÷ó£+ÛÉ‰2\Û`tÃ§J\é¼Ate\Ó&Ó’ýp8h.ï¼£°\nÀy«ºñGˆ.µ+§ñ\ßlI™]\ÞD“b\í\ã\ÑF8\ë\ÍgRT\à¹õ\Üî¢§?}]ˆôy\î\ç\ÍòÔ¤ƒo\Î0\Ù\ÏsÚ¢ñN=ü…¬\íä•ƒ\ÇfMƒ¹;i’jv2–{iOðŒÇŸ\Ç\ëS\ë>3×´¿41\ë0Áf\Îcð:¥\Ë}p7`“\ëX\ÓpW¹¤\Ô\åk/ñr\Îx54cº7‰~G\ØC¯±‡z\â„þ!´š\Ö\áópHŸ*J=ýñ^£­ø‡E\Ö|=¨M«\ä\Ï\"(Á\0`!0GSÁ\É\ç9ük\Êü\r’x–\Úh›c\Û{g#úÓºž\îR‹„[\ì{\ïÄ‹ˆ­ \Ñ58n¡ŸV¸µ55Gfi\Î\Õm\ä¶6>EV^\â \Ð5\ëmF\Ð\\\é÷+4yÁ\ÚyS\Ü\Ô\Z_\è6ºÆ‰ja^\é¢)u3\Ü\ÓÀ®¨s\è1Ò¸\íWI¼ðÏˆF›¦\Ú-\ÃÍ±­o&C·€\Æ6\ç\æÀ\Èó\ÔÖ¸lT\èJQk\Ý\é\åý~g5l5:ð‹½¥ý^‡¥\Úk!\ëz\Ö]evŒ¼„\ãÖ¼ûÁþ ¶\×#ºò£’\Êo&`\Ýc¨ïŽ½pko\Ì>µ\ïF\\\Ê\èñ%fµ>~\Ñu848.cº-&ù‘…=¶‘×Œñ\ê(µ\×U\ä–5Ìˆ¼\äº=ý«…ƒZ»¿\Ðm´\ÎY®\"\Ä.#]\ß*ÿ\0\ì÷®»Gð\ÝÈ°ˆø“W´\ÓP?e€©¸pG\0œ€?S_#SsJ£³»Ó­»ž¥e®„WúCkš\Ò\È¿u$$g§\ËÀ\É\ç<þuÕ‹\ÑôXt\ÃpD2\Â4\0\Ê\çû\Ï\éøÕ­>\ê\ÛL\Ó\×û5*T¯žXe n ý?:\Ã\×.a{qñG\ZÝ¿qWcý\Ü\ç§|W\êÊ­ ž†³\ÄÔ•8\Òo\ÝE]vò\Ê\r>t–\àÀ\Äq\"J—ô9®\Â:ÕŽ‘\âô©d»´y7‰\ã;\ã=Á\ä~_… ‹Lþ\Ðcf\Òn†R	_~O9ªC\í±`ed­{x<=:t\Ü]\Ý\Ïw„ö0ö‘o^\ê\Ç\Þ_³1\Ð5¯>«–sD±DŸ3\ås\È\ëú]Å\Ç\âT6öº›Ø­šl‘\\´dœnÝ´ŽJ‘ô\ÇÖ¾.øs¯\ëþÔ’mô\Ä\ÊÁ\Þ\ËFO©¡úW\×>ñÖ‘\ã-\n\ËTž\æ6¾ŽDŽöÍ¤ù\í\æNI\È\Û\Ü\àŽ*Z„—³Š\Ðõ\á*”¦ª\'©\áž4Ó¤·\Ôdˆ\Û]\é\Ò&$’\Þ\åZ@ñ:“z†\år9<\ã„\×\áò%e–\Ø\ê6³¯¨\È<væ½—ö\Î\Zv«¬hº\ÌWª?\îÃ¤»•€\ÎôÁ\Çn•\åºH³d\Z~¢\ÑKmu0A+¿\Ülý\å~ ~˜\ë^5JQ¡W\Ý_\×s\ê¨ÖŽ#\n§.¿…Œ¿¼–Z\ä)l³˜¸§\0\ß•\îñÖ—\Ö7\Ö±º·ÿ\0^\ÐüÅˆ9^„ž„þU\âR‡\Ñ<B\Ð,¥GÇ¨5\ÛxÅ–w–q\ÛG‰‹²—\01Ü\Î\rz´qwŠ»±\ãbpœ²ºZ3\éÿ\0x\Â\ß]°Ž9,’;Ûˆ™]\ã4Žs·€¸ þu\Ù\\u\rGsg°¤`$\ê®FGLŽ¸>µò­§‰\í\ìe´Ž=ü\ç>\\‰V,üÇ¶k¿ð\ç‰/$\Ô,\áÒ¥i®\æ2Tó±\Ô\r\Ä\rÇ°\ï\ÍoZnjûžb¤\àûÙ¤i·Piò_GkhX+²Áô#­Všþýõˆ\à¶Ó¼\ËE\0\Í1nPŸº÷\èk\Î\Ä]R\ÓSq”\×)q\0ˆ\Ç*yWSÐJõ†ZÑ›T\Z\Â\Ûo³¸„üÀ\ç¦=Et`\å	+=,r\âc$\ï½\Éu‚\Äeg©\Îr72\ÜÜ¼\Â	\É®£ƒ\î+¢ø‰\âX¯5;ˆ\âžc\0ñ\Ó5¥\áÿ\0\rO?†\Åù\n \ÚHOÒŽhÔ›7{—$o#\Ëõ›wkQ»(PxcØšç´r\ë\æGŒ\ÉŸ,‹· ÷¯Fñ¦‘67[E¹\Ç<\ÖN“\áO\íýV\ÙõˆvV\Ê\Ì\ê:¹\Ç\0?Â‰AŽ5#\ÔÔ²ñVŸ}`²X_\Ç‡³BJÀñj[jöoö\â\Ë\æªð±\È\ï^}ñ«Á\ÒÀþf•ö•\Ø96\Ï\å±ƒ=OÖ¹¯†Ú®%\Ìr\Þjwª\äŽ\áÀ\íŽ\çÞ¸\ê\Æ5>&t\Ã\Ý\\\Ñ:Ÿß¬w7ze\å\á[¸˜ˆ%9\Û þ\é¡#¡ü¨½jcH<©¡k‡“+\Ê\çý\n\ä|b\×k‘\êPYNžd[g>Y\Æ\àx?‘\"ºß…Z\ä\êö§Q\Øö\Ë2–C\Ã.FE5N5RRz®¿\æi\íeN\íl\ÍM7FÓ¥²‘i¯l%\ÝzŸj\Ê×¼oq`Ð½»\Ü(\èFHS^·«O¢BŠútŠ¬ó<r[¹¢n U+\ÐûVSNeºX<\ÃvÁ\0\Ñ<\"†\ìP\ÆJOcÁ\î>Gq+,\ÒBªª’>™ÿ\0\n\Ñð¿\Âÿ\0i·\nòý­±µþ¤ö\ë^×ªZZ\Åj\Ò1%±€8¯-\×\çÔ…\î#·xY›%³\Î|þU\çó8\ËC¶Õ•›:ýW\á>Œ<7¶\Ñ\ÏôHq!\èN:k‹—Á+\r°º•#g9R¤t\Åz„WYþÆ†9n¥™JeC¾vý>´šÝœ«òÃ¨S\ÍoZ¤e\ËÑ‹„šr¹\å’ið\Å+‹k_.E\á™=\ê´(\á‰u\é]wˆb}+j\ì\Ù\çD\Ò.ñ\Ë+š’\æÜ»d¶O\Ì8=\ëL>*µ¥ø‘Z„*;³\æmwº·‘ô}ÎŒc÷s\Ç\å<~ÄƒOm*D‘õ;\ËI¤e\Ì{\Ê\Ã\ÉôúÔž²\Óô»V´µž0²\Îñ±2{ŒJ›û9//.t\ë–\Ø:,°0;Y_\Ã»cŽrk7	\ÊQv\Ê\í|¬|KÑ¶Ÿùœ\åÅ—ŠTG²7S$‡;Y\Âcù[£Âº¶³j_R¶ºVŒ’¿\n¼u9\ã\×ßšô?†^Ñ­­÷[y\äðeF¹%a‚\Ç	õ5\ßi\Þ\Õ|¸õ‹Dµ\Ôcµ\Þ\Æ\ÎB­\ã\0rp?\Æx\éZF­Z­J	z\ÛQ*™J;÷<KEøG¯_i©\Ùi:†¡m·t |\Çñ#s]V‹ðGTžç½µkeP¥¢Š#,\àŸ\á•Lý×ªøK\â\\2i\Ó\Ï™³-\å£E—‰÷”cwC‚=+¥\Ó~*øvY\Â\\Þ´H£x1¨P\ç±lÿ\0:ì¤©¥i\Ï\Þóý\r\å\Ä}©3Ì®>&•b\Ër Ó¢9D7ó™n&p:\"c:|«Ö¼\ëÆ¦o\ê?l·»0_\ÂWkØ¯–B\ç9-\Ó8 ûŠ÷	nüªxö\rVõRGtuÒ…\Ù?~B{ó\È=ñƒš»ñ\'QºþÁh^\Ñol\'ù\Åc@\ÚX¨Á\È\ÆN1‘P©Á¾döùþEP\Ä\ÍT¼\ä\í\Ú\ç\Ë>0ø?ˆô;q­@\ÍqhÌ«$\\+–\èqÓŒr:~uCG½ó\í’}B\åH\Î\Ôø\àu¬/\é·\ÚG‰¤±Ô’\Ú9ü\æ‘\ã¶#\Ë@z\0£\îý\rZ²hûCZ$›\0\ØN@‡jÖ­8ß¹ö¸ld¹+\Ðôñ`5;\Ð,\Öqªù[¤˜y\ãŽý;TZ<l“Feˆ\"\íùN2O¯\ãôôªõ{\Õ]\Òoo—c}Ý¾ŸJ\î%\Ñb¸¸ò´û1–C*[\Æx\r\ßosÛ¾kÁ\ÄRi{§§EŸ$È–©[s1š\\˜\ÑXÀ\äñ\í\ë\í[ú\n_	ü\Æò0\É$sý+)\"BK€b“&Gº&\éb±òUqœ\ï\ãv:\Z\é\ÂÁ\É]œ•¥m\r^­™ó Q8Y\ç9\èq^\ÙðƒS»¼ðlš\ÌBžFX£^ /Ÿ\Ç5ó­\Õ\ÌR\Þ\Ç1‹qRw‚\Ç\æ\Ïzöÿ\0\é}ð\î8ó™H\Ý\ÓN?\"+¦U9 \Ú8\êSN\Úµ9R]q›\nX6\ã^‰\à-­‚\Ùù¨¬³‡.\0px+ŽýµxÏ5msq*mŒ2õ\\ú\ë‰ÿ\0„\×X·ñ¾Ÿ¨ZÌ˜\ÒÕ®a\Ù~b¬ˆ?CF¤\ã>x\ìeV’”lÏ²®C_\é·B\ê\Ãa2Ç“Áa”‘‘Ozóø‚\ÏJ‰-¡ý\åÀoTePµŽŸJÚ‹\âE‰>™\ìP\ÙËªX—±!\Ãm\È\Ç×ƒý+\Ê4§c¾­\ÂXn=wŸ_ñ®œ\Ë\Z¡8Q¦õ—SŸ\r‡¼e9-º\ß\êWw†c(\ÒB~O,a}J÷ó\é\\\ävò\Î\Û>\ÐöŒŽHa÷d¦kB\ëU´³V73¬n“ŸN\Ç…b\ÞkIo<\Úl&m§\n \ä1öö5Ä \×\Ä\ît&\Þ\ÈØŠ;û{Y$¹\Í{rI\àmtÿ\0\Z‹\\\Ò\ì5Kh\îDf)8h\æŒ\0#úŽÿ\0J—À>#ƒ\Å–\ê)\íf·>E\ÔŽTã¯¸\ë\\Žµu¨\è²Èˆ²\Ë1\Ø:\íæ´‚J\Ö7¹WTñ>§ j_e\Ô\â2Ç·Ë‚\ê3… tŸn\ßJ\è|3\â\è\ïu]§ FÛžýª÷†ô3Zðüwºõ¼^d¤\ì†L£§#ÖŸ?4Ø­Ù´ûuYxò~\\þU\Õi\Ê-6E\ã{vºõ­\Ô\îg½µ‹bn\Øò…,G`z\Ò\Ô<_\á‹-+¬·Š$Š\ìÄžrN¼m\Ëv^;cž\Õ\ãz\í©\Ðn\æA$\0a—,ƒü÷§\Øjö‘Â·l\0ž\Ý®eO\Ùß¹¿?2G¤E\ãM&\Þ\Å\Ò	\â\\GGµc\\øú4¹Xtûµ7ò˜f\äb°\ã:Oˆ-Š2£2IÊŸ\\W;u¥¿„|EõÙŽ{\'a\ä\Þ%º¦\ÏöHP\0ú\Ô*\ë\Þu\Ø\ìõmR×‘X\ß\Ém4À\r\Än`8\Îfÿ\0ÂŒ\Ö\çþÜ½m\Ü\ç\ì\'Ÿ~µ\ß\è^ Ñ—\Âwþ!“Q²‰´\Û}\É –Ë…\Ç9Ó§j\á\âŒì¡š=q‰-ý¢«Ÿ|c¥:“¥‡iM\î:q©Y^=Ÿ\Ó\Ãú]\å\Ë\Ä!¸ŽVB‘\Çg8ñòŽ~^½\È\é\\5¯ˆõP»\Ðu›¶¸Šc\Þ`X[ýñ\Î}#Ö½÷\Ä>Î—ý­½`Î‘f;y!l>;PpO=Ey\'ÄŸ\êWZ¡‹Z°µ[˜\âXŒ¢%c,k¿8\áÀ\ÏŸ­^‚pª¯\Øø¬57\'\Ê\Î\Ã\á‹A©^Y$š¦\ÅVŒœ7só­{§‰ü-\âh<\r-¾\ãI\âbf0\Û\Û\Åš1\ÐÈ 8\ãÐŠù\Â~$}XŽ\î\0’F£\nTt\ã\ÔW\Ù~ñ¦“®xn\Â\á§X`xw$²8\Âó´ƒœ¿\ÈWN\Z„)Jkk\ê…^‹¥?&|ÀšöZˆ\ä\Ó%ŽB¡\ár\ÐNz\á\r\îzú\Ó//g…BÝ¦\Äp6H\ÊGc]§\í\áÉ¦ñ.ƒrŽ\É/šúlr†‚@yo|Ã®x8ö\ÅqZ;ÿ\0\ÂI\áô¹\Ò\á!­\Ð%Å¿$Dr@Rx\ã\é\\8Œ3q\æzµ¹“‡»p2·–	$óÙºŸj\Öð×‹o´\ë\Ô)¨m\0`¤£!}ù\éõ¯9ñP\Öt¨\æ³W;\"6a°N<©À\àŽ\rnxG»ñ…šö,ñ3Fþ^7FÞ„ž£sQK8Ú¤^·êŽš\n•yeuø¿}§øš\â7°°f¼ö-\ÄV7<­žNÏ¶GcT4\n\í¬\\4[™	À0=#ƒŠ\í¼\áä¾¶°½‡\ä†Á˜LG\Í$\ì\ìY}s´¯\å]–§gm¢Û˜\ï`†\Ô\Æ,+\Ù%R>ùÁ \äry\ï\ÅN/\é\Ê0KN\ç\Ù\åxxF…“»Gž\éž¸µ\Ï\n´Nø1±xõ\ÆkÑ´‘q<–ó†@P¯,q°ž?\ïY\Öoiu²?\0ðs\È\"­]K6hòZ/›v/\Î8€T“~÷C¦r\æ\Ñ\îtž+\ÒÆ£h\Ë5¼)$X\Úc\åKŒ9#žø\ãÒ¹\Ý6\áË˜‰a\Ôg¾p~˜­\ë—7›­\ï£[vh”°-½b>€Ž£\éY÷Žƒ^Gr#•2\'÷>ý¨Œ\ã\n‰tbQn>†Í«\Ú\É\\2\ï_^s\êMuÿ\0³¶£y\á\ë×€_Yd2(\'\Ø\Ã(\î ~\"¸]Z]Ó±K“q˜1À~ø¨´bXeûE«¼3F\à«! údc·½]EõÐžY8´rø‹£C¨\é\æ\çOO22\Ù\Ôòƒ¸½\ë\É^\Ú{g^!$V\ÎÀz²¸ÁB;dw«Ÿð±µy¯TY,\Ù\ã	2…Ú²\ã«m\é“\ß\0\éV\ì\ãÄ—h³OolË…÷\Ç8¨¥\Æ^\ãº3’\\¾þ\æ¿À=LB·^™—fŸ(š\Ì\ä“\Z9\å=€?Î½G\\Ó“\ìr]Æ¢À$•\Îú\Ç\Öð\Ö\ËF†+ý7P[»Æˆ9u\Î\Ð:”\è9\às\ê*Ö¥\ã\âß§\Ý$¨_\æ5ßƒ\ïŽÕŽ\"…Js\æ–ý„\ãW\àùž#ûFý¬\é2Id\Ói¶È±7\ÝLÿ\0*¡ð+W\Ô\ïü5(¾=½Œ§hÀ.\ìžOq•\èzW[ñBóDk×™u$K–Bqœ“Ø¯j¡ð“\ÂÉ¨j\Úå¥”²oû\Ú\n—\Æ\Þ\á˜w\Ï<zs]T\ëó\Æ*Ú\Ùr\ÞûøO\âZ\rþ§c¨T5\ÄeW™G	\ìL\Ò\è(Óµ\ët†thei\ÚGùŽÈ—À\Ï$\×\âÛ¨\ì|Cý—&I–0¸ßµ\ÆÂ¸9ÿ\01]\ßÁ?\ÚjZ\Ôw3$\ékl²™’f\0g (8\äwúq\\\Ó\ÄTU\Ò[p\Ã\Óö.RÜ“S\×c¹»e²2\Åmf€¢©\Ú\Ò6y\æ½k\áf³e®ømL²¢Nª”ú×Œ\êvLþ,¸ŠEUYfo•3€e]ë—¾¿–=:yHC»\å9Ï±ö®ü-YhÚ½\Î<E\ÉY;XöŠ\Z-¡€’Ð±˜`( –Û­|±\âX<C¤ø\Ò}0\Ïx-#›h\í\×s\ì=	\È\Åu^ø\â-kÆ³]\Ü4b*ˆ°QýGa\È\î+½\Zañ5®eA%\Ä@\î™Tû\Zï›§vŽ\Zq©{&yO…¼A¯\è7\Ï0Y g\ØÏ¼={Ÿq^«£\ë\Ð\ë\Þ\r»Ó¯öº\\\ÄÁƒ€Ã¦=+ŒºÐ ·\×L[9\ê?š)PYrªG\Íþ\èæº›\Ð\ØOgöh\ÍÔ®<\Ç·`8 c³\0y¬*\Æ2\Ò6NJZœ•«\É\á\Ù,%]ñY\ÊpÁ98=\Ïs[\Öþñ|¶ñÊºñ¡Úƒ9‡ŸÎº\í2\Æ\Ó\Âúd—-’f;\Ãô1w\ÏlsÚ±®\íbºº–\æ\êòO>g2K¹Ž\ârr@Á9=«ç±´Tª{ú¿¸öð•¢¡¢GžZx›Y°W·Òµ)\àm»i\Ì_pr8?Ò¹ˆ—WZ“+\\\Ø\ÇA¿w*I¹K†¸\Ï\\dŽ8­=røe\"[\'†TUb›v\í\r\ÈÇ·¿\áT†ŸwÍ»\íBKGƒ\È\çœg¥v\à\ÕER\Ò?5\Â\ßÚ«œrØ\ß(\â»?\êÚ„:zh\ä\È\Ñ\Ã\æ4*ŒaÜƒ<u\çZl\ZŠyŒñVJu\ça\ëGjõjC\ÚG•ž­Jq«V]ÓµQ=ªC¨(¶lIý\ì<‡\ÆqÇ½r¾–\ï\Ã.’]:\án´\É÷	#*W†”ÿ\0\É#ú\Ö\Å\å¿\Ù-¤¸•$cq	öÏ½q¯«jË¬£¬YŒ\È7\Ä*=3ô¥Jœ)\Þ+ñ9½*N\×n\çY¯\ÜXjŸN\Èe»?8(@Be\'¿\ä÷¬¿‡ú¾³\à‹yZ\Ì\Ä\Ï?\Ê\ë2\îF\îœds\ï\éZ\Z†¹¤[B\ï5•Âœþ\á~R\ÒS\Ï‘i¨Y\ê—B)bxT±!ø½k	¹S\îßºc9:I{7¡©}\â}V¹Š\êóS™v¶ø\ã„ùI\ÎrÔº¾¹,\×r\Ü5\Õ\Å\Ê0\Ù\ÆÐ¤œ’OSŸòkZ\Ôb³¸o™|‹´x\êsI}Z\è&÷Qs-\ÅÊ•²´o»\î²\êO|W/²Œ\ì\æ·\Ø\î\ÊñØŠU}ßµ§õ\ètšgˆ’)#Œ”µ·\åda\Ó=±\î*\îŸ\â›\Èl\Ú\á¤S1\0Md®=³Ú¼\Î\Â\ä½\ÊÛ¬¸iy@xÏ¶k«\Ð4½Rú\ÕLQ;v+¨á¨«AQ[\ÙqIBn\ì\ëtGw8X¤1\Ë{0¥¾º¹:\Òß£\"aµ”.\âMT›\á­õ¾ƒ¸\ÓEjþxE‰Ü¬’¬ƒø‡\Ê\Ùô\Åj\èúM\ìñù+’\È$J—!Ž7(\êq\è?J\à\ÄMs.Gs®•*i·¶=\Âú*ø‹L>L~d‘Ã™Ww\Þ«uôô®WQ\Ñ\ä\Ò5 &k\Ï2YŠ\ÆY.	ù¿»ø\×Oc¦j\Þ×¡¶Žw‘ƒG2ñ°žv\äHg\ë]Æq§^\ÚJš\í…\Î$“>`\âeaÑƒ`‚9\Î¥vFt\ë%­¤6r\í¬Y\äV×–\Ð^]gl\å¼\Ö®~\î}kY¯ä´ˆ\ê¶\Ð\\²\Éx—?>=½…7\ÇúV©c	\Ò/t¶O3u\Ôs©$¯<dpCø\Ö1MR\×N2\Éhñ\Å\ç\Ñ\ÚË¼Ÿ›Ád~~\Þ2\\©Ù™û\'ñ\îkøñ2\âk\Ö\æ2#\Ú0\ìps\î;Um~óK\ÖüI,zU\Ôöš“Ç½c/	\ï\Ø¡¯<Ó¥{kUy\Ý\Ñv\áI\ê~µ¯¤xš[&\Ç\0˜’Š\Ê\Ó\'¡ö­”ù’Rw99[qV!×¼3}®ngº·ZEü\Â:@À\ïV>\ë··½·’X¤’i½\Æ\Þ&\Ü0s\éÚ§ñ«­m¹7Á#GÑ˜|W)5½û\è:µ……¤÷w	–\ÜDFC9\Ç|`œö¬gu+G¯S¢›N+œÇ‹§\ê\Ï\ÑN\Þ]ÀS2!\æðÜŒp@\ZúLÑ¬l¼9\ÚlA§¼\Ù+\ÈwÙ\Çð¯”¼ð\Ç^×®m\ãñ¢l¬˜\'Ù¾g\ÚNIÿ\0h\é_Rø=\í­ü–u‰\ì X¢™ˆ\Þ\åF\Õ\ãÔŒ~&…MÆŸ¼Mj‘s´Y\ç¾+ðýÕŠÏž‚7‘E\Ä[U•¹À?y\×\Çx]4™n\í\"\Û$ˆVI‚1Ö¾‡ñeå¶£¢A¥\ê–Pý®\Ê%û%Ú±Ve\àÃ¾q\ÛÒ¼s\â|1Em<W =¬ŒA•NBçƒš\é\Ã8F\\©œõ\\Þ­SðƒL·¸òÏ˜ŸmÝ¸«Xf½sNº\Ôô+¦DW]\n¼ŒŒW\Ç5§†õ öI2JL4Y\Âöe=A\Ïò¯Yðÿ\0‹-\ï´(\à•˜\ÜAû¿2G\r¿o/§Òº±MÙ³\nrihoEƒÅ¾ž\äynŒ’„\0¨Ç¡µŸð³Ã—ºQ¿{©^t\Ê\ÈXœ\î`\Ö-Ïˆ®4û\é^\0Ì’.\Üd¾\ãz\×Ið\ÓY¿µ¸˜²L <‰Ý²y`{\×\"œT•\Í$§\Ê\ìAñ\Ú\å4¶u‘ü¢¹#•cLøƒyo¦\Û\Ûÿ\0f\è\Í\åD©™,Ô±ÀŸz\Æ\íE¿\á‘ \à\ÊÊ¬:\rydW³ùk”ˆœ’95šK\ÜÚ„\\©ÙŸI|iøeýw$ñ\Ûo…‰9\Åy³acc}®H ‰xÌŽnk\î\ÍcM¶Ô´æµ»@\êÀ€H\é_(þ\Ö\ßn\'´[\Ë 6Ú³È™!W9f=\0\ê~•ôX\ÊN”\\\à®|ÃºWGjš\ï\ìÕ£—[²W^B\\ÿ\0\ã \×3ªø\ãÁÐƒöw¼¹n\Â;m þ,Eqþ#·²Š_*+\ä\Åò‡\ÏúÓž\\\ÃÒ²ul­\á·q(x\äMûû¶x\àskÇŽ3/t\Ë\ë±½\ã\ßZ\ËohðY\âbv—ù\È\Ç9\í\×­rð_\Þ\Ý\Ø\\^4qGo\ÚB7\ÎX\àñøU=Js}*’¸\0laþ4º\Ì#Nðø€¶&÷Mót\Æ@QISN\Ü\ß\×\àc&\Þû³6\ãY¸yd28—v–\\m\Ð\n\Ýð\ÝÖ&™=ôú›\Û^YR\ÎXƒy\êp3Œ`ƒ’AWs“\Øf¯\ØÆ\Ù}©ÁidqÛž­^Œ\èC–\Ö7öi£°ñm”K¨X\\<Nc¸s,˜\ç\Ì\n2\ëYš\å\Ô\×\×+ª´…\Ç\Ý*½°;b®ørð\\\Íö[ý­.š\nA3q½s\ÆG¨\ìj=Iš\Öo´\Õ\ÌnÙ–. Ôjóh¸Óš¥Su¢~¿\Ò//c-wG}ðû\áö›¯i^½ÂºGŒ™2g \à\É\á^·\á\Ù\é:w\Ù\"‘™Y\"b6ó+¯\\\àq{pk\ç_…þ4:+þ]\Ù@\Ìg=²?Nõ\êúW\ÄnL{Â‘\Æ\ìp¼õ¸®\nñ©\nŽ5u]¥Ž.5¬£-{\ÜÉ¦\Ãf¢R\Ïlóxv6!0+\É\àö\éN¶\Ò\ì¢Ò´{û4e¹˜\Ü5\Ä\Íuˆ\ÜF\Ã[§\å?š÷®Z?A%›†9±\Ý\Z¿©>£“Öº‹\rHo­ªK„Fªca\î\ËóH_”:3ƒ\\!M·#¾•i¤“6<w§iúF¬\ÛIr’Cjw+¶\à\ÊP{–ù½1Ÿ~›Â“jø\rd·¸´šo0‡Š8Ï›2F\ìŽ\ã=2\ryÖµ­\ß¦ Š\ám\å\ß€N\ìŒ7^±J·ðY¾Ï­4—„L.\Ýr=ü\áQ%Z\ÑZI/øsy\ÚT/\'\ïE™?´]N\ëK‘5¥kVR…­\×\Ëe\Ç ƒŒn\ã¯^k†¶\ÕQ]\Ò\Í\å‰\"9¤\Ü\È>¤ýk\ëHa\Z„s¡‰RgA+üÿ\06\Î3•\ÈÇ§¼\Ç\ãgƒ4\ÍVmö\Z]µ\âò—61\ìŠc‘• \0	\ÆNp>µ´°µ!e+®Å‡\ÅÑ›\äœmùPúÖ£<)•Z2Ha³wn¹)·j\ßgóò\îr\Ãß±ªþ!ð—Š´ë‰†™,—ñC½š(\ÎT\ärƒ\Î>•ƒ{\'ˆ´¶Œ\ë$O‘‰!eEn\ä»\Ðñ\È8>\ÜÔ¨\ÎI\ë¯n§O°ŽŽ\r4i´—QÎ¬÷\Í:\0	\ìqÞ´!\Õ\'·³4„\á2\Ägôæ¹‰¼C§Ì§Ì‘¾A÷*ñ\Ç\ã\â-=`\Ìq‰cŒ©–V\'Œž£­(Æ·ò±Ê‘\é\Þñf©mó/\ï!CÀ~	õ8®ƒEø‘sg\â±¦Žö7[0ñ\Ä“\êTdg†¼¥.\Ö\ÝÕ£šG8Ê¬C$œzT««k\Ó}±­\ß\ì¡z\ì!³\îzUS\Ä6­&s\Ïwt©§»Ò¯´fºþ\Ú\Ó.\É\ÂG›ÔŠR¸\àl”«¦+\Æ|q®øz\Þ\ê\æ\ÎMB7grw©\ì{u®Z\Ôõý_F_²JPo¾\Ù8\É\Ï8$ôªi^µyš¦¤\ábQ\Ëzj\Öu©·\î\èL0n	ûI§‰.\ÓûG ùj\Ù199\ã\ÕÂ‹\â}@ˆ\íK\ÛC“ûÿ\0(·\ázô7Àv­^Kd¦\â\Ë5\ç\É\æ¸TQ“×°\Åm\Ù\Äldy,	´¡s—û¨ŸÁŸ\\æº½¤\ä¯=™„iM]œÖ‡ˆmlÈ¹p]²\Ì\ÒF	\'\Ðc±ý+®ð\ïö½ÕƒDFš6$!\'°Pyü*8\îFC\Ø\Ä`HGR}N*Ã¤öm5\Û\ì0‚ò\È_ŒO5”)J¤ý\Æ\Ì\åQ(û\Éúþ‘\âaE\Ë\êpOX&=À2IÀ\Ï8\Ås\Òj\ÈÑ‰\íÀRF$~8«6ó\êþ%¾}?E´û5œ¿*ª¯Í·¹cØš\ê­þI\ä&\é\Ø6Ñ|Wuºn\îN\ç=Ldˆû\écYúÞ›i©X½\ì,2)2\äôô­m¹â¢•9\Í}›J[Ÿ4|û\\~\Í~+o\ßøŸA¼²»³»#\ìö„ˆ\ÝT°g\åa\Ô\äc¯Jù—\Æ>\Õt\Ø-õt’\ÞY¡\Üz2ƒ’8=¿:ú£öÿ\0ø¨ú¿ŒuO†w^´Ht˜¤±\Ô\åy\í%hÕ\Ó)ƒmÁg®1ó%\åô¿e4\ÒÈ½v3’õ\Çc_!‹«\nu\å\n=ÿ\0®‡$\ÜyŒ/K6r\Ë+\Þý\ÙUb\ä\ç\êx¬ÿ\0$ó5ºÁžRÇ’q\ÎI\ïùV\Å\Ã\Æ\ìX6Ö¨\Zr¡˜>}H©§RjjoVŒœ­.cIð\ì—\æL§p*x¬\Zó\\Ž\Ö\Ä6d(ô-SM!ß¸J\Êq–\ÚqZ>¸H£h†–\Þ:ƒ\Ç_j\íúÄ’»:#[¹Ÿ”\Ô\\…\\™6ŸN8®\âÝ¬\æ\ÑJ4ñ+’\Êc\ËgŽ+“Ž\Ïe\àù\×ó)õ\ÍnY:|Ñ±,\Ê2¤vô?\âcZ¨Ô®qÊ«U9Ž;\Å>»ó¼\Ë<õ–\Ûþ±q\Û\Ü~µSH¿Ô´\é’ÿ\0/X¤8ükµK»G¸C%\Ú[³`H\à‚x8\ãwª\Ë=\Ì\ÐOr$R˜žQ\Ðc¸=²9\Åv\Ó\Ä\ÉÇ’´n‘\Þ\ç\Òh± k\Z}óü\×rX\\7B\íº2Ÿ¥t–:Þ©¥Y\ÙgŽ2Z)\"m\Ê	\ÆXŽÇùW#uá¥‚a-´\á\Ã`®õÀ#Þ–¿µ.´¯20p$³”¤‰øAü«™Ò¡R^ä®»=>\çþw=\nxŒM¹_4|õüNÍ¼R\0&#Ÿ@n}È¬I<a¯\é\Z\ßö¥„\Ï\Zó†R=¬‰Ž|nó\Æy9Ë™?\ÞCÁú‚E]¶6\Ëg[\'Tñõ\âº)a°P\Õ\Þþzþ‡WöµG£Hõ/üf\Ö\áµ\ÃC(3a›Ë—ƒŽ{ÿ\0\\\×SiñƒHû,Q1\0~\æD|ƒž„€9\Î}«\Â\Ú\æc2% ¶1©‰˜>Àv«Z\ÙþÑš\Ò8\Õ x\ÈfwBVC¸\r„Ž9ö\ÇSX\×T£QF‹Ó®º~\'%LÆ¢\Ù\'ýyL[x»ÁúÖžnl\á4ª\É: \Ú€v\äGøW7­xJ½´si£\Ï$‘…ÀŒ¶\äŽ@Pz×ŽX\Å5Á{;¹¡\0ð²¿•t6~+\Ô\ãˆC<Á€\0\ÇS\êqQW‰”T¥ý_\rŒ§dÔ¬\ßs¥¼ðF˜Í¾]<yrH\Ì†=pIüj-\'B\Òÿ\0¶n!‡@’\Ê\ÅdE\'\Ú”8\Æ†2Hç§¯jg‡|h¢p—ªƒ<+\àŒú\×H—V÷efQi<¹ý\Ñ\'s\×Z\àJKF¾G¦±\rõüCLÐ¬\äX\à\Ó ‘.\Ãlm\ã®{ö\â´²4\×Skw¥\Æ\è\Ão\02Ÿz4h¤±¹™ö\Ù\Æü€q\Î:`b®\Û\Þ[A -u¸—\ÎDyã¿¥L\'8?z6ù!Ë•ü/ü\ÈfðÆ“\r»\íb@Ÿ0R˜\ãñªZ|W\ÎÍ§GR•J@†{ƒ\ÔU\ïk¬\Â+[˜<\ï\\\í\ãù\×?.³t%ŒO2¼I»$‚2Çƒ\ß\àSž%F|°Vô\ntÜ£y?¼\Ö\Ò\â¿6\Ï&§|·7rn\"@wŽ\ÄçŠ©o—|³>}½+ÿ\0^·ižp±(!¯¿…X\Ò#\Öõ¤[}M–\á7sq!Ú£ñ®Š*U²•\ÙjB\Z­\rŽXIˆ\ãC\\õª\Z^“«ø÷Ä‹ed²\r*\Ø\æI\0ùYýI\ïŽ\Õ\ÞxC\áS\Î\Â\ç\ÅWŸh$\äZÀJ\Æ=‰\êkÓ´}>\ËK³K]:\Ö+xPaR5Àôx\\,R\Ù&#ví©‘\à\éž±H¡‰K¼\Ý\É÷®lcŒ=©Ë–8©„?\ìšô\Ô\Èóœ\Ûwg».Ö›\"\æ’#\ÛÒŸŸJ\ìÙ˜ž_ûF|ð‡\Å\í./\í7O\Õ\íe¦¯hŠfsŸ-Á\âHó\Î\Ó\Ðò\ç?)x\Ãö0ø“e\âI-´½#W\Ò\Õ\Å}=È´v$rGqŒ\ä\ç­}ö\Ýy¨f\n– \É,prW\Ëðõ\ß4•ŸtD©\ÆZ´|,¿±–¯¥h«øƒÄ¶RP¼–ºz±€2KK eük\ç_Šƒ\Â\ÖZ‘Ñ¼9\n\Ê#|Mx³3†>Šz¯JúKö\äý¡`ñ\×¼|‹…u[ø\ä\ãQu?êùd¤rŒA\Ï\ÊZ…ÕœlþC	gn„•×½|þ!Ð…_gE].§5Gò\Å—1¤F\âˆ\ç¨‡õ«\Ú9U£\06\Ð}Gÿ\0[5¨y¿hgffvl±=ë¦¶Ó¤o‡\ë¸\î\n0=\n“\×ð?Î´©M¸-BTÛŽ†´2[°•R¡‰B[õ\Ïj‘%D‰\Ùˆ\í\n\ä7#¯LqŸZ\æ¬o¤b#CûšÖ´”´j²m79\È\êEy•(8½N^WCšwÈ m9\Íciú\ÄW—w,LÑ¼¿¾Œ±ù½\Ôs\Í_\×o\rXTŒ“œõ¬¯\\[Çª5¼\ä*Ü€M\Ù\è~¹®ú1n›rW;`\ÔÞ¦\ë\\\Ê\ê“\Ú\È\Â	€m¼|¤t\è«X^-Å²J\ê¨J|\Ätf\î*)´ÿ\0+OŽ(¢\n¨\Äc\ÏQ‰®\í’KY#\0,„©ö®)\ÅIß±Ðª:vI“\ß\Ü\ÇYh÷\Ë!\êGµð\ÈdŒ\î‘\áds¹}V·ón.\Ö)œ0‹“\ÇQÚ´%À^1S7Ê¬†\ês;²H´ø®¥\ØT<‡8=ûJöw\ÖL$³(\å~ü\ä3cDò˜\ã9§’:ƒ]F-Ÿˆ4U–A¶\å\×e\ê¯¿Ò¸\êV4¤õ‰\Ë[I]ö³,ðù‰¡n<\È\ä¡þ¢†W2ª\Ë!PÇ‚¿\ÅT5y£\ê¸\éø«/øU«‹}RÐ´,#™Z<ô÷¢µU«SJP—»÷›Â¤š\ì\ËWv‚x\Äq8\0õ-Öµ¼3gcj $fX¹\ëXVw\Í\åJÊ¯Ø“€kR\Å$“LÜƒ‘ŽA®˜æœºVü\ÍaŒiò\ËC½ðú]~Í¨\ÞAƒü¶?o¾Ÿtð²ÿ\0h\È\Â@7n\0“øõ…yþ‘­j\Z| \Él“D;x5\ÖXx\ãF(¢\â9 lrWdqY~\"6vüŽºx©o	’\Å\áJRTjó¸•Ànmx\áð–q.£}<\çý·&¬øo\ÄZ\rüŠ–\×\Ñ\ï<mcƒ]Æ•e\\¡®º4¨oM+y\Z\ËQ\ï\"\rÁ¶\×O‰¤#\ÙHú\×U¤\ÙZ\ØÀ\"¶\"A\ÑUqUm\Ûh\Æj\ÔRž6ó]ÐŠŽ\Æœ¤õf‚°\Ç\Óô©#ËU[ei\ÆNjô’Cc™!±ž{WDcs	2fx¬\á3LÀcÖ²\Ä\ß9Ú®Fx<Vn­¨\Ëw),p€ð¿\Ô\Õ\ÇþEt\Æ)\"ª‰\Ã\ÇQNÝŽýj3Ê‘žGJEl­ka5xOü\á\Õÿ\0Žþ‹½\n\ÓX½\Öôk…kK=1\Îë„‘•eƒï€ 7|c\Ü×º)È¥k:´\ÕH8> \Õ\Ï\Ì?~\Ê|A§½õ·„¯t\á7Eª<vòMÿ\0\\Õ˜~ z\á|Aðÿ\0U\Ð> \ê\Þñ!I\Ôt”’K“r\ÙET\Ìe\ÎKŒ\ÆrX\nývqš\á¾?ø<{ð‹ÄžµKxu\r^À\Å\Ã È¤<a›\ÚYc^U\\­(^2wF¢š\Ñ\ê~NZ\é+¨j0\ÛÆ»ZwX\Ð0\èX€3ù\×Ò¾2øªx{Ã\ácnò\Û\ÇÅ¸Uá›©oûëš±ûþÏž(\Õ~)A\â?\Zxz\çNÐ¼?t]£½C^]Dp±¢žY\ÆY¾\éÛœ\×\Ü\Úe­\Ã9š‘\\ü\Ê\Ãõ–:´œ§§a\ÑM^\ç\ä‹<¯xU\êö\ê«+”G·GòÈ¨b>U®ò›‡\ÝV\Ï~Æ¿H>6ü\Ð<e¡\\\Ã÷£%W†V\ìG¡ðÿ\0Æ¯„\Ú\ï\Ãu\Åð3ZI1H\îW 0\è½qcpõ)=V†\é5ª\Øòj`[`~ˆZ\É\ï\ãÒ­^‡7L\0\Éfýi¶j¦P®B‡\à9þ\ï\í]4Ò„44„Tbužñ\Ä\ÐE§ß¶\æ_–)ˆûø\ìO­n\ê6²O¦¼\Öÿ\01ˆe\ÔHÿ\0\ëW`­c~\Ñ]\Û7˜911\Æ\ïF‘\Ùøú9X\Ä\Ó\É\r\È\Ï#?Ò¸qR–\Ãæ¾Œ\Æ\Ó$Ax%\'\nñ¬x\È\ÆE_Ž2\à\È\Ï\\÷­o\è†.ú\ÞûB9E\0+\ÇÖ±%·“O¹Ê†’)¢8\ÆO·Ò¸j%vº“\ÏmüŒ¸ù[¶jßZ\æN{xËˆ\åŒ\î+\Õ=\r\Z Kh/!a¸MÉ‘\Ó\Z±\á\Û\î<\É “\Ëe\0\\cÒ²”%8ºijËš\çI#¦¾´µ\Ôm\Ø\×\ÌDÀ#¨> ú\Z\ç\àð¼\ê\\Ú¼oµ²\Ê\ÙRW\ê:\×Y éšž¡,pÆ‘?y‹`Îº	j\Ó]5œöRAr±ˆ2\áeÿ\0tô5\æªX\ì>Š\ÏæŒ¹jCN‡›x‹Iò\î	…\\¡\ç\r\ÉO\Äuª\Þ2Y\ëkq#F“”·E?\á^¯¤øp\ê—k¥\\B°\ÝJv©q°\î\íYþ7ð¡,c’\ÅR\êÔ€.#S\ÈôlWN§µ¤\å(\é·üd\ÓWf`Šw“É‰RF½nø+\ÃZ\ì\×ñ\Í6iua¹dnÕ…\á(¯\ì\ï›E½µqueŒoOZ÷ßƒš-\ÅÝª\ÊU¼±\ÎH¯C•aªIN-§M%(–l~\èB¯ý—\n¹\ÇÌ«‚+r\Ë\ÃðiÑ±·B7u\É\ÍvV¶1ELcŽ\Ã9¨d…I*k\ê!‡„>W5\ÎE\í\Ü7Ëœt\äU›y˜ð„û\â·M”nÜŽ:R]4ø’7cZÆ›¸9šD±ƒs\à6?*\çu[\én¦%˜\í\Ï›«\Þ=ä¥· ð=k9\ä›·¨\Ít\Æ)\"mriž½©7û\Ô+.òAŽ\âœcÿ\0­Ut;W#\ä¤<7ùª\Ö2»[üš³ \Ê;WCVd&I*i\Êr>”\Ä\ÈQ\ïKšÍ \åi}i¹\Å;<f€!™I<\ä\â¢d\äüµe©‡4Ó°\Ó,«.\è\Î}:\×!ñ“À\ÚW\Ä/\ê¾»+kqjñEq·„~ª\Ç\Ôn#\Ó5\ÞJ¼\çªDLgj\äú\ÔÔ§\Z‘q’Ñ‡‘ù]ûD|×¾xº\ÛC\Ögµš\æ\â\ÍnÑ­CŠ–`B³¸‚¼ñÞ¼Õ­zUþPN=«õ\â‚´ˆ^¸ðÿ\0Št\è\'ó!x­/ü•k›l|ñ1\ä…$gµò7‡¿d/]ø\Æþ\×V³³þÈ³r‚õ.€ûr\ã\åhe‡l\ç9\×\Ï\×\Â×£R\ÑNI\í\å\êb\à\Ó\Óc\Çþ[\Û\êZ2h\'\Ð\æ‘\à]\ÐN\ès³<mq\È\ë\ë[šGÃˆ,u!weªJa<§ˆ·\Óp\Ç\ç^ß©ü3¿ð~Ÿ˜RgKt­(=N+Ÿ¹±’2C&1\×Ú³t´÷\Í-v\ëA†óI’\Æ|m•6\î•=ˆú\Z¥¨øN\ì\Ö\0»•T*\çªñŒƒÚº¡\Ã\Ç4õ\éQ:•\Û@\á\Ü\å4¯²øq4«Ð¤®\á‘\Î$ƒV|=\áht\ÛDŒ	%\Ï~k¤U\â \çÇ­(Ò„l\íªV\Z¶*hZp·\Ôc‘N>j÷¿\Ã\Új!\Ø3Ú¼V\"¡ƒt \æ½3á†¬»\"\Üýk¶…D†\Ù\ÝI\áý&òò‹‹y\'¶pð\È\È7#†µ\ì´M>$“ý?\Þò\ä¨;¾µZÜ¤€H>÷¯¥_‰\Û9ö®¨¥w¢\ÔN\Ö\Ð\Âñü1©]\Ãsq¦\Â\Ó[c.ü»VŽŸamaj-\íaX£^Š¢®7­5\Çq§¶\Ò\Ü\Ä\×&«J™lŽ•m\Ç\à*)ŠG‘\Îy«N\êDµ„\Ë!\à}\Ñ\ë\\–³s%\ìÄ–;}*î·¨5\Õ\É8>Xû¢³\ßct8ö5Ð \íp(K¦jCŠ\ÑdQ\ÎG\âj­À[ƒ“\è)Ø«Ü¬±±<\n”[\Ü\à|‚¥´†i\ßj)\×ÿ\0¯Z«¥Ï´~ýºzSJÀ\ä{ùù.8\Ý\×Ùªü¹9<Š\Ì\ë9Ï¨­P<\Åã¨­¥±	\èÔ§Ö¤AH\0\ÙÒ²¹|£A\î)\Ë\È\ÆicoAJ@Bw´\Z\Ü\Ò`Óˆ”\å´#\Æ\rE4J\ÊA\éVE&¥4\É0u\0~ej†\Í3´6\èEnÝ°ð+2@<\ÑÀ\ëZ\'tMoL°Õ­M¾¥l®p\àr+\È~$|$’%{­-|Ø -{”ª¾WAùS4€\r\Ó!\0©©\èx®jô!%r¢\ìÏ‹µý\æ\ÂfŽhr+¢+\Û5ô—\Ç;KQ+m8<ùb¼#XŠ!;\â4„W‰R*2hÑ®¦?\ç4¡\È `š³\"&GÈ¿•#¢t~U‹Ð—C“Ž†¶¼~\Ö\×\ë–À&³Qtuô§\éÊ¢\é0\0ù½*Tšz•X÷Ÿ^,öˆsÚ·\á;–¸O‡<ÚŒóÒ»˜\0\ÇJõ)Nñ3jÄ¹9P\Ø±§D˜8¦¸•µÁ\"$œ\×;\â]CÍ“\ìÑœF¿|úŸJè®¸³”Ž\Ú\ã¥\0Û‚@\Écž+ZJò¬UrŒ¼0?J­0$Ž¹}\éó\09\0ÂŸ\0Œýk¯˜,gÊ­œ(\ç8«Vv‰Ï†?N=U~\Ð>Q\×Ò´mU|Ïº:ŽÕœ¥¨5bÎ•d²òTV°Ó¸\ê)4µP8P:v­bz\nW$ÿ\Ù'),(13,'5847399c49feb','ÿ\Øÿ\à\0JFIF\0\0`\0`\0\0ÿ\Û\0C\0		\r\r\r\r\Zÿ\Û\0C\n\nÿÀ\0\0ú\0ú\"\0ÿ\Ä\0\0\0\0\0\0\0\0\0\0\0	\nÿ\Ä\0µ\0\0\0}\0!1AQa\"q2‘¡#B±ÁR\Ñð$3br‚	\n\Z%&\'()*456789:CDEFGHIJSTUVWXYZcdefghijstuvwxyzƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹º\Â\Ã\Ä\Å\Æ\Ç\È\É\Ê\Ò\Ó\Ô\Õ\Ö\×\Ø\Ù\Ú\á\â\ã\ä\å\æ\ç\è\é\êñòóôõö÷øùúÿ\Ä\0\0\0\0\0\0\0\0	\nÿ\Ä\0µ\0\0w\0!1AQaq\"2B‘¡±Á	#3Rðbr\Ñ\n$4\á%ñ\Z&\'()*56789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz‚ƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹º\Â\Ã\Ä\Å\Æ\Ç\È\É\Ê\Ò\Ó\Ô\Õ\Ö\×\Ø\Ù\Ú\â\ã\ä\å\æ\ç\è\é\êòóôõö÷øùúÿ\Ú\0\0\0?\0\æþ|i\×l…®›a+\ÍeÉ–‚w\î„t>\Ý+\'â§Œ¼K\â}Vm/M¾xcq¹§’Sý\ÑTô\ß\êW·\"\çF‚T[»R\ë0M«‡}z\Z\ÖÐ¾xŒß›\íNþ\Î\ÆI`ò\äB\Ê©ðÐ•Gf‘õóÝ™\Æ|=\×\ÓÁ\ê,\Æ]r\î\î -\Ú\é\Ï\î\ÜžO@iŸ­õ_|P>%ñÀX­÷2@\Ì\Å„|¨\0=zTôo$3k²\Ü\î6À¡s\ì\rlxc\ÃZ†§Tœ]ùIò\Æ\Ö\ê\Ìz€+ª1®\âî–¿‘œ\êÐŽl\éô¯k7ò\Û\Ü\Ã{m%©;®‹g¢zþ5»ñ#D²—Ã‹„Ü˜—ý)¶\ÈHþ\é\Å3\ÂZŒz¦•­Gx›·œbA\ì@ÿ\0\n\Õ\Ö5¹\æ¹hFœ\ï0]À\Ä@\ävbkhÑ#Q\Ü\â•i9¦\ÎcÀwZlúcYË¨,ž[f\Ý]\Ê\Íþ\ëŽø­)&†\æú[co³¨,Ä‘×°\íQ\Ûx6[\ë\Ï\í›ûx\ìnŸ%¢´\Þ\ìH\ëôm¼5m¼ùŽ3½ù8õ¥JŒùm2*U‚•\ây\ß\í\á¸<Q\á5ŽFo\"`\Ö1\É\Óoò8ü«\Ë<9ð\ë\â]•Ú‹­:MªA\râ¾ù\Í{\ç‹-g†kks\ÄÁƒª†h\Ï÷—#¯·z\âüs\ãýj\Â\ím/­V(‰\Û\çC\ÂI\è\Ã\Øþ+ª0å…“k»\ìsz\'\Â\ê^1·¸ŽX4ø™óx¥÷‚½Ê¨=O\á\ëZ^-Ò¼K\á­¬6y¥Jø·\î\0|÷þøô\ï\×5\Úü=×š\Íb\Ôm™gC:¿ û}*ÏŒ¤²ñu\Ô\Þd+	=a\rò†\ê1\èGb9§\í\\d>GQ]œ.\ãÿ\0\ì\ÝA!º·º·S\Õd7\à;Šô­\ãO…tû5{Û‹´#¨ò	?ZócK³K%‡RhKy6–rD\Ðg¸#ªŸZ\Æñ—‡\í­|3-\Ü7™\ÐHÑ¯÷†\Ð	µ•Zô\×4uF*	¾YhÏ§~\nüO\Ð>\"\é\×wšó°\ÜfŠu\Ø\ê?…ñ\èÃ‘^…\r\â}3_|\Ö\âðŽ·y ø‡M½R‡l¨/6äƒ•“ù×°[üMñ\nÎžm©À\ä\íù²=±]Ô±P’W\Üã«†”$\í±ô\Ü7[±†ýjU¹ p\Çó¯>ð?ˆÎ¡¥EpX\åÀ5\Ô\Åxz\×Zw9™ò\íµ\à­K\Ã;“\Æ\Z`—û+\\”I+&JÁ?ñ©>o¼?Jñ½ó¥vW2\Ú]!Ê˜e`Á‡F\\n\Ý+ôK\Ä\Úf•\âM\ëD\Öm’\ê\Êò=’\Äß¡±A\í_\rütøQ®|7ñŒ\Ë}«JÌ–7LB<©Œ•ô½\ï×½}6UR^\Ê[þðO½\áü\Þi¬=_‰m\æ¿\Ì\Ýðo\í\ã\Ý\Ö;\Å‰´ô!A½n\0ö˜sŸ÷¨?hpx£\Âpi>]KJK\ÃPY\ÜnP:FŒ§•=\Ï•\ä\ï©:“x\å\ÈlõS\ï\\ç‹¤?\ÚqÁd\ÖD<.zŠ\ÛKMûE®‡ml·\Zêº§i.\Û_\Óaºf­s\r\Éq(\ç8ó\r{ŸÁŒ\Ö6¿\rõÿ\0	x\ÏT\á–\ÔÅ¥#~ñJ˜ó\ÙT\íažœ\×\Ìú£\\\Ú\Ý/(,Ok{E‚FFk€AT%Hþ*ó¨\×rN“Z\\\ÊnØ¼<\ãð´\ï\ÕXÝº»º]^Xå½•\çF\æy s\é[ž8ñUîœ–Wþ#Õž$M°\ï¼r¡z\0Fk™\Ô#/­\Û0r\ÈMF:~8¦;†\r¿\'<Šôi\É\Ã\Ýg³œW4v\Ø\ì>A«\ë^7\Ót-?S½š[û…B‘\\¸@Ÿ\Ä\Ä\Ð($\çÒ¾¡øññ\ÏOøk\Ð4[q}¬\Åª£œAh1ò\ï\î\Ç;G¶M|o\à\ÛýGD\Ö?¶tû¹\ì\çƒ\îK•a\Û\0\Ög‹üMw«j³\ß\ß\ÝKuup\å\å–V\Ë;z“\\\Õ\'^iü‘\ác°4±\ãSnH\ßN­ùùÅ‡\Åo]üM_\\ø¢ð\êq\È6H\\ùh\ãòúÿ\0\Ù\Zû?\á\ÅO\rø³\á\ì^\"\Ô5m?L’60\Þ\Åqr±ˆ¥\'nã’¤G\×«ó—H¼&\\’>cÛŸÒºm\ÎK›W‘ˆ\nX*Ž¬\Ç\Ðôa•<D9z÷#–\á1øxòû®=R\é\Øûƒ_ø\åð·Msÿ\0b\\ºœ¡C$¿¨ýk0~\Ó\ßÀÀ\ÔuRþ\Í~Zù«Àÿ\05-Uay‘U¦l\ÇŸ2bƒ©*¿tpylWN~i \à\ê6¹ôþƒú\ç]\ÑË¨µñ\Óáœº\Þô\å—ù\æ½\ã-z\î\êk]\Ê\Î\ÎþA4ªwgGZ£}i«\Ý\éQ\\\Év\×3/ú\Í\Ã\0þ\ê\ßb]6+»¨’+‡¶$³\n/û\àf®i\ÞšûNZUŒ¿u\\žkòZJ2n\'•RNš¹\æ>\Ð/uÁ%\éhm\Ôg\ËG!Z»\Ó\á©\îv\Ú\éè± ¼b·´¯\0\Ý\Û\\ÚŽø\Çð\ì®\ÓK°†\Â(Pq\Ô\×T)\ÛDŽ*Õœ\Ìx\×B´k’‰%ä«‰%+\Ï\Ó5e|9d·\Í(&S\ß•i[\Þ]\\x‰\ìX!8=InŸ…TÖ¾\Ó=Ç”’˜\â_½´r\ÇÒœZ¶\ß3ß©WU¾µ´M e‡ð¯õ®KR\Õ.¯n~\Ïgå¬Œq·©\×\Û\é¬žc!‘s\Ï5\ÑbŽ\ä\ÜDŠ²öy.w\Z‚G\ã\'T\Óm#–i\Ì\ì\é–\'\Ý>œ\×%{¦Z\ë\Zd\Ís†U$\ÛJ€3v<v>â½‡R\r3yŒ\ç¦k’\Õ<mq¨-ÔˆW\rò•\à³v\çµ¯\ZnòWEr7¢zž;\áM+\ÄZ±ukk§\Í{¥ÿ\0GŸ\Í!byW¯{\Zß˜N±C0\ä	ú^½¢i\ÖcFkx\â@Qˆ!zf¹_i_\ë#\0\ä\ãŽ(^þ¶\Ð\Ó\Ú8h™\Ç&‘%ý³\ÝMz£¾Þ£¸ õ\Ø\ì\Ú\ÒŽ\Ø\È\ÈyÙŒªúnâ›¨-õ‰*ÿ\0.\ïîœŠÁ¶Ôµ-2õV\Öö1\ÉóA9ùô_Cô®„\×-ŒnWe\r_á·…õ]_\í·\Z3A9m\ÒW1,\ÎTqùb½;\Â¡iZ2ZY\ÚE\ZF¼&9ýk&\Ï[±U¸ów…7¼er\È1úq\\<U¦-›\Ýi\×ñy\à}\Õnô¯+ûÀ\áÍ°ÿ\0üMO\rüR¶ú–£\0Hƒ8·”Œž~h\Û\ål¡÷¯[øQñ†\Ç\Ä\É$H‰41yžxRU\îv’v‘Á<÷¯<Nš–½\â­yDE*]£“Á\äž*\êZÆ˜%StöÐ°(\Â3´\Ã}\ë]¸zs•d¡-\ìiK\r\íùi\ÛW\Ô÷ŸŽ´oˆõ=Jm+À÷¯¦\é°1C{\Z>èŽ¥Iû‰\éŽMxÏˆ<c\â\rz³kúþ«¨Å»xŽ\êñ\ÝU½@\'\0\ÖTò[3`:…ôJY-Œ\'7&¾Þ’£F*0K\Ôû\Ì&†‚8+®¶\×\ï5\ä\Ë†õ\r•$ò8ª—N®ª\è¬$¿¨=©ñ!ž`¥ð?•& ¿eŒ§st½ENiA·±\Ô\à¬\Û\Ø\ë|#y\à¤ð$Öš\ï„4\íOU’7û=ô¦Uš \à¬€p@\"¹™¬|9¾ÿ\02úüòŠ9† sÏ¡cú\n\î&³ðô_\rô\Ë\í*p5TcòKŒò§•ö\Ïs\\Õ­´p^,\Ö\êe’^\î3ÿ\0\ê¬0”=ª“Žš\Ù\Ý?žûÿ\0Ã˜\àð	¹I{·zÜ±\á:\Ùô¡g¨\Ï$!\Ã9\Û\æV\Ç\ËÇ¹\ëXº…œ\Öò´n»H\äg¸õ\Ú\Åbð\ÛEt\íy§!7ø\Z\Ëñ+\Ë:”û4~Z!y\Zöª\á\éºi.ˆô\å\è¢üŽz\Ø=Å¤–«\n w=3T<\á/ø¦ö\î=&\Ê\Þqh\ß8–\â8\Ð#?…ké¡­oe‡GP:©\ê(’	¬õCu¥N!ó2Áò\"ž ú\Zñ18iJ*]Q\åc°U\'\Ê.\Í~&M¾š\Zõm Œ¿?\Ê1\'$08#z\ê<!¥\Ý\ë(ƒA³’8™\åò÷†\01\É=f\é¶wV,\Ó\Ã§\Îgp@Œ\àúû\×K\á/‡\ï\ã\Ô,\Ú\Ök„ÉzU>¸\Ï_­w\àp\Ò\æ\Õ[¿õù”pUy4ü9ôUŸ‚´¯\nxatK‹Ï·\Ý\Þ(?dÓ u–\ëƒóIó¨=\á{óU›À^\"v/¶V\èÜ¬>yý\Ðþ\ïŽ:q\ÅyDün«&\Íu­Œ§÷(Žý†\æ\ÆOô§\Âs\ãžþ,\ÔAÿ\0®ƒü+¶x|]ýÖ¾ðÇ‘[/\Íy¯	\Åz\Ýþ²üOM¸[ø\äMª\\ùQ$ÁÁ\Ïnq\Ï5\Ðx{\ÆÚ­Ò$\êhÖ£tB†t=~a\Ës\ëÒ¼\ëÁþ#×¥i Õ¬\âr¸\Û }\Ê}ø\ãðªö··_\Ûm»–&™\'\Ì„\ÇEcŽ‡Ò¿Ÿðõ\çC\âå¤1SŽ\"‡5µGµ\Ú\\\ëOi\\j7\ï,¼ƒñoJ\Õ\Ö<Mo\á_ý«W¾‘~Î›‹;\ì}½MoxV[-KÁ–z¢\Ã\Z4\è9Ã‚>™¯™l\ÝoS\×/\í|3¤¹\nX¼¬@‡µ}cÉ¯6\ç‘*ž\Õòò\Ú\ÇÒ¿¼Ea\ã	\é—&x/\×(\ì¸~§;»\ç>µ\Ð\ÚO’M»\î«v¯ý‘^?|\Ñí¶¸…šO´\ï?q‹žG·ø×²\Ø\\[\Ù\ß%\Ë\Å\æZ\ÌD›‡}G\ãJ2¹böf‹RmšS\éW\ÖÑ¿’¨Ž¢L\äpò¬}Fö\Þ\Í]®[`÷©|k\âØ¤žK\ÖÏ–£\äªök\Ê<U\â\ë]D‘5ÜbOÝjÍŒ{bµnÐˆ©[S±—UÓ®µ\Ød{²\ä\"¯¡\'’\n\è<ifñxr1hÁd‡\ç,:\ãÿ\0¯_>xª\í®Yaµ\ÖfÃŒ†’?+?Lô¯Eð\ï\Ä(\ïth4ma\Ýo’b8Ÿ\é’1ø\×=dœt5‚÷‘\ã>&øÇ­øs\Æ>]µ š™š)!•px°\'5\ëž\Ô\'ñ\'†­u;„	%\ÄAÊƒ¦kÀÿ\0i	|9‰Ulä³¹‚R>\Óo»3,2\0\ç\ß\"¾‰ý›´\ã{ð\Ú\Ó\ì¶WQ\Û\Ú\Ä¼Ñ=¹ÿ\0\Z\è¡Q´¢ñ\ánr‡ˆ¼>n c€0:\×	y\ácwxm\Ý\â\È`\Ê3´Ž\ãÞ¾:[”•C3\Ó\"¸ŸÁ¦\ì\Ó\Ò5‘¥\Ã¥S\Zž{Rƒ¨ùby,žº\Ó.\Zw’	Y\Ûoš$\Ø\ä€©<\Zòÿ\0Šž“I½kÄµ•`¼9*#\á[¯áž¿{¸\ë(y\î\æHž#ó!Lø÷­{\r\Æ\ïA&;»K\è®\ÖF]\Ê;\ã#éš¾h\ÕVµ“Ø¸\É\Òwn\ç\Êv 	ž{l#‰\ÇPj‡ˆZ\ÙYJ\Èð¼ƒn¾Uö\'ß¥}\â†–r\\o—KI\âH\0Vú:\×\ão„·’>Ÿt\èÝ¦?\0\ß\â+j%BjO¡\Õ\nñ\çS‹\Ôñ¤2Lv f§HH\è	*þ¡§\ê\Z¦l5h\'„“¶1*\å;£w\ëR¨yCü¹\äf¾«	\ÃÔ\Û\Ô÷ðù•4½ýGOVINÿ\0òiÌ­>¬©&\"Á\ÇlÖœZUÔ 40±ú\n­weqev\É,d1Á#ô¯J†\"& ¾¯©ß†\ÆGYB;-}Iü\à¨Ê£\åc\È\ëQ­\áI#\ÚG\Ê3\ÅC\"\Ê\0\'\éÁªºÊ‹sV\ã5\Ù[\ã®‡³Rº„nvú¢/t;›IUPn\ß\ìpîƒƒ\ÉíŽ¤\Õ	b\êeF\Ã8_Æ¹}>öbDi)U|ƒŒ×¢\ÜÍ§\É\á[K\Ø¾\ÌD7;N\Ò\î{\ÕøRKp\0 \nº8ˆ\Õ&5#£¶\ïúû\ÎLƒ\n3\ÐI\ïV|90Ž\Þ&`	œ¶üÀSõˆ\"6`DŒ¯pp?\ÃÔœ}*´%aP8F#\àûWZ·´º\Ù~ð\Çd\Zœü‘­fò<Zo/\Zóy\Ú=µg8’\ÚB\È\ÌqÒ¯Z	>\Ó\æ`ñË¥\\¿´\Ê  !—+žÆº\Z’[šÎª„”N›á¿‰ü44¯#Uylµ86w+\Z”\Éõ\ã$ÿ\0¼q\é\é^€¾7ð\ÉPdð\än\ä|\Íöø\×q\îq·¥|\ïª[\Ëg3«£A¡uY™@õ\çT”9\ß>ç—‰ÀS­>k¿¼\ìþ\Ý\Ü\\ø\"\ïS\Ô\î\å\Ýw;<EX.Œf»o:´+²\î2Ì£½3\ï^o\â†‹D\Ú-‘6,dq\Ó\Öx7\Ä‹4K¨±§\Ìc\'œ\×áµ°Ru½¬•‘òªr\Ò\åR\Ôú\n\×\\Ô¬¬\ÛN¶\Ôf‰%LŸ/¢ñ\ÜVV…£®©w\ç\Ü7™,ŸºwnI\0ü\Ç5\Íx\Ä\Ð\ê>$6w>z\ï\\ \Ï\Ðõ\ÍtË©¿‡õÁþ„ò\Å)\Û©ãž¤ý+\ÑS\åQ})GV­©\è¶òAi£ý¬KB¬2«\ÇSLV\æ—\â\è\äÛ¥[\Ë±©\Ç/8=FGÓ‘ùWŠx\ËÄ·7ºŒ6–2\æÓ*–A\än\éýj\rTó¼3sqªyðÁn\Èñ3\ä\îp?\ZÁVý\ãQ	aÛ‚o©\íóx¦\Â\ÒôX\ê\ÚT«4±JöÏ½j_øF9X\î-e¶˜	#b>tÏ­|\ç\àø‡\Æþ%\Óô»0X[\\0S7ú\ÇqœaE<zW½ø\ê\ÃW´ðòk¢†5\n\Ä\×rt\êE\ÝlqÖ¥V„”e£g5\â=KE4z(\Ú \ç\éY~$ðÂ«­¬‘K}\ìr	\êkgÁW>(,\Ï(†/+£ùôù\×K£\éwwÚ›p\æ\âG99Pû\0:\n\Æv\ç\åˆ);]žŸb>#__\ëS«-\ä\Ã\æL÷,\Ü\çð¯Uð­å®¤&”¿jû,hG$\Çi\Ôƒø\×cª\épZÃ¶\à\à°\Î\ÍrW\Öz\\W\n38?Z\èQi§s>nda_x¥ti\åŒ<V³|™\Éw¦{Uû!m\â+Y\'´ŸP7.8”9‘ŽG\r‘F£\rµ¢n–0\ç\'5\Øx\Z\ëO* (¹\ëŒUK\r\nŽ\ÒdýbPZ#\Ëu¯\ê\È\Î./.\à¡E\\zœõút¯5\×-o-up—M\ÌD®\è\ßi\àõÀ\èk\è?Ž—\Ðiú¸lr0¬9öü\ë\ã-cX—Z\Õo\Ú]Bq\äÜ¼a )\Î1Ÿ^õ2¡\Zk––ð.IMóOc\è\ï†=†ü.›y:\É2\r§8ù€\ïéš›Ç‘®¡|±[Å•ˆ\ØRqŸ\å^\r\à_øš\å›R\Ðf»\Ýö´\ãn\Ð\Ø\Î$gŽ¸õ¯W}_[‹\Ã~EÍ‰žò4\Ú3Á>™=\ëXM¯ˆ‰R\\×\Äø\Æÿ\0N“O¼\Ñu\ÛDº\ÖÁ†g£+J\älô”™X\Æ\éš\Ó\×no\'ÖÖ§g …\×$„£&:\ØýA«¶ri°[#$ñ¤EK\î?:\í\ÂV½[-\äù!\æ_ð2YY\Ê\"½@Tœ†\ÇJ\èü_ð\ÏL\×5\Ëmn{ùm´ö·]\".F\â\ç\Ó\0w4h^£ŽóU¹ð0!Q™$\à9®ªY\Ä^&’\ËO²/m\äºÂñövTw#²®x[¦jñ™…ZQ¶û\Ïò4\ÂÖ”*{E+hxo\Ä_	h\ÚV«s­A{kŠgY#ûA\ÈrüÍž;Á\'š‡Cð3x\Î\Ó\ì\Z4‹ö²\0ÁSœ8\ê=+\èdø£\Ë¹º¥¸‘+Fsœzg\'žµ\æºþ—ªü*ø§¯\áaleš\Û\Éx/W0´`ý\Ð8\àrÁÇ­U\Ó¡Q¹\'ów;kZ¬9õ[\\ðK\Ý6ûF\Önt½J\Ýàº³”\Ã4gª2œ\Z\×\Ò\î\Z9\â•J»ŒH»€\ê:Jô\ÏJ>\'x®KMÓ­uKˆ­§†Faþ\Þs»\êsŠ\ê¾ü$øY\â$–h¾\"Z›	wö7n¶ó\ÚÉœme|\Ï\\ƒ^ö[š\áÖŽ÷\ío\Äö0\Ù\Õ\Z4«{ùjyž“¨\ë$‚\æ\Ù%\"X\áD\É|©\Îk:`Pªƒ““\È\éŠû\Ç\á\ïÃ¿øN»\Ò\ãŠ\í\È\â\çpp\ßFW\Ç´.Œ¾ø·¯iqÆ±Z½\×Ú­‚Žnw\r¿L‘^–\Z§)}\æù>sF\"pJ\ÝOò3¼3(’H\ÔÆ®:\Ýy<~=\ë\Üüð~Ox\Z\å–E´Ô¡›Yd#r­\ì}{W‰|7°k\Ýb\Ú%•7\Éuc2H¼¶ÿ\0 \Ç\ê+\ïo†\ZZi>·ŽT3 g\ÔÑŒ\Æ\Ê®SŸˆsIa\åe+3âˆü_á©5]\éW<KfX›\Ü2\äW&Ÿp®T\Ã( \àþ\â¿K%Ki«¢²ž ŽµL\èú)9:e©\'þ˜ŠÁ\æ\Ü\Ú\Î\n\çŸO‹¦£û\Êi¿\'còz\Õ6KQ‹n\ÇÖ½\Ë\Ã~\Òô\ë(.œ¤·O¢\ÂÍ…\ÞN}º~5\Ç\ØøqS]·B‚²«ds\ï]\â\é×—ScK†au\"\"@fû£\è}kò\Ì^)\Ôj0G\Ègu¥Nq§\Ò\ï\æQ†\â\×Sñ\Äz^˜e»\ÕJ\äÁn¥Š¨þ&#\åLry=+­ñôš¾™g§\éú›\"fR\ÛV6i$\nFF8¿¸\ÍkxL\Ñ~x[·nüM«%ÔŽ¼—<…\0ô;úœW™x\ß\Ä÷WB\âúöi¼½¤\Îb\Éy9\É,{œŸ öªª\áO\ÜZ\É\ØÎžqV>ÎšZGK.¾¯RK\ÏÝ¥\ÅÌŸkH\Õd1\ì\Ü\nÊ˜ùH¨gÀ~3þ €]ý…ô\É.\îb¹o•yÇ¾:ñ\é\\w…ü5¨ø†\Â]~b>Ì‘\É$þhAJG\Ì2p\Ìs\ÐrH<Sõ_\ÝZ³\ÍGš5–E\ÈÀaÛ¿^µ›öT\æ\âþ}¹\ÂajbhFRiIôGyã¯Q\\x\Æ\Þ\ïG\ÒbÑ­¬®¶°\ÛGˆ¤Un³\É\ä\Ç\ë_Cü0ø\×áŸŠ¶GB\Ôc›K¿·³x\Ôù c-\æ\ëþ\×|™g°\Òþ\Å}¢\Ø\ß\ÛyebWd‹ž\âE\Ãdc9éŽ•\é|;‹\ãYI%•°¶w†”\Úò)R\Æ\Î$%qE\ÍkKN	û-S\Ü1¹}9As»Im\æ}\'{ZL{¦\ÓeKs’D7…³ŽGÖ¸ÿ\0ˆ^2³\Ð4¹5=Qch‡ðH2Ç²€{\Ö\çƒ~#Zj«µ\Õ\Ú\Ü\ÆK\08gÚºø<)£x¿K–ò\ÓN´»Š\'+,Œˆ|³Ôƒž•×‡Q®½Ç©\àVŒ¨?\ÞDñß†\ßm¼S¥ý³P\ÔbŠü\Îb[Vo˜§P\ËØŽG\ã]5Äˆ!gû3	\æ#¼gk\ã ÷«~7øk\á(4É®­ô»;Y¡Œ¿\Ù}NWÏ^%±\×t¶ðû\\\Å4ú~d·.\Ç™ù†z\ç8Ï®k¢§´r\åDRt¹\\’gœ|E\×gŠ­ |Œ2\Ç=Á®z\Ã\âú.–R{ig‰”¤~T\Â,9\áK9\n5\Ú|oÓ­\Å\Ý\Ý\Ôv\Ø[8	«þ»\àûŽy\ï^9\â¡÷‰®t\r\É\çZºƒ$÷#÷p\']\Ìø½‡S\\\n¼Ôµg¢\èBPN(\ï¼mu\â\Ù\Ûj?Ù·VZ8‰$··–eyX•Ã¹lŒƒŽ+\à?\Âo³üJ—Åºü)5·˜^\ÚÉ\Ëò0H\àzòj_\ÞK­¶Œ\æKˆ!\Úcc\Æö<Â½ƒOº‘,\Ó\Í\0‡5\ÛJ¬fÛ‹9ªÐ8û\È\ÝÕ´}.x–Hm#…Sœ\"…×DZ”–[)\ëò\Ôö>\\Ð´`„þÖ¤w¶ñÀB•\0¦+fµ\Ð\ã\ç\åG\âhw`\Æ\ÑÆ¯ ?(À\Ýøw¯øð\Î\Ë\Ã:™\Ö,ô5\',2±cü¾ý3^ò|Gqs\âIl$Òš1\ÊI¼\ê{ŠwŠ¬­\î-²ÁNGB)8\Ê\ZŽ®\ìxG†ôyõy\ãQ¹\Õ\â\ß $6\Ø\Ëÿ\0²O$¦+Ú¾\\xcEÓ¾\Ïo,„?8f\Ã\îO$ýj…tKIoK´9Œp	\çŸj\í-|=¤cpö\é#/?:ƒü\é\'\ÒÛ–’\\\ë’\Ü\Û¥Ú™À.\ã±ÿ\0¼{Wš|X\Ðôým£“\Ä7X\É\Ê×¿q“\ÔW 1µ8&•/\Ò\Ú\Ú‚¦M¼úu¯(ñ‡ž\âúH¼É®”9\Ã. g±¨w\Ícze)Z\çw¡h\ÞÕ­õm:[E\àÉŽ\Ý%\Ç-Á úz\Z\â¼o?†o¼Xuô³atG›ÿ\0!\Ý\Óq\Ï§·Ö½~\nyð\ÉeS\n\î\\žHö¯?ñ¿†.!¸ò\î`7HFc,3·ž•„\ç\íÚ“:£I´Tð_Šõø®\ÒmJ÷Z´Ó­\îE\Ã\Ù\Ø\ÈZ\ÖaŒ§NG|\Z>1ø\ÓÁ¿õu±\Ó>Ñ¦köˆ\Æk²¢\ìÿ\0\ËÀüŸ»»®q\Åg\Íe%„\n\Ü\\\\\íù¥\Ó.\×v\ßú\æÇ¦}3Y>\Ó\ìn<X·¾”Az[\"\Ö\æ5R®§\'a#žI\à\ã\ë^–õ}ˆ§:”êª±\Ýuÿ\03\Öÿ\0d‡—¶:\×ü$þ\'³{g²\Ö\ÎQó&:³|p+\éøµDÀ…xoƒ|ju\r=d•<›\Ä;/ ÁL\Ç<\ã¡Z\ê\ìu\ÂÀ\Ã?Zõ\å‰öÖšwG—˜bkb+¹\Õß·cÓ¡¾V\è\ÙüjÀ¸\Þ5Á\é\Ú\ÆH\ëYuEÀùýõI3†\Ç\Äu=KR\Ô?´5k™&E”\æyß™I\ê¾ü\çó¯]\Ö5K}&\Ú9ût\Íó™\å?\ÝÂ“ò¨|\Ä}+\Ëþ\Ûý“C‚}6\î\Ö%T6”=Nzƒ\ßÒ®xƒXº7\ækŒ-\Äc>w™¸?¸\Ï§\å_<T\ã)¸-\Ù\âÕ­*’¼½>\àñO‰WS¿g¼½®ˆ	\å™TP8P:þ½p_õ\ä\Ó\Ú\ÓO\Ô>ÎŽ¸{w\ÃI?¶Tp=õW\â6©¤^\ÙM–/$ûI„£vb\ç¥cü4\Ñ\Ú{–¼œ1‚\Ü\ç¦w¿a]Xl:§­Tn\ë£\ëóÿ\0€v\ápö‡\Öd\ì—\â}+û*\êº<þO\ëzl»Qn\"‘U\Ë\'\í0­Ÿ\â×ª|Fð7‡\'¶¾¹dƒJVòqz\ç-\"0\n\ï.Uv¯cÓ­|«\á[K@ñ<:\ä\í™Jð1Ü’\î‘\èEu¾7ø\Ý\â{û\Ûh¯Z=‘¸{h`#j8\è\ÄrN9\ÆxÞ¦~Ê´^²ò>™8T„iJòü\r¿Œ:>ƒm¢\ém¤´¿Ž\é`To>,ûp\Z\"ð\ã$gŽy¿j·Öš…¬‹sº\Æ9–79I\Ã`v\ã5”¶~%ñV®$\"òq\'Ï‚¾f02p	\Æ0+kRðN»\ái\"“RÓ¤®UMº™T—OR™\'®zgzW*r…>hô>Öœ\áZŸ³”•ÿ\0­}\Ñ<?§hzm\Ï\Ûc\"DGue%9\r·¿\Ê{zU}\\[k™n|;«˜\âœ–\ÝÜ„‘¿„º\ç·\\\×\àoŠ÷¶:*øoÅ±%Õ”HZ·¾·_ù\æ>n¼\çÒ°üg¯øXY]O§\ê\ÖinrÈ­\åÈ õ\êk£\r8¦¥Iÿ\0™\åW§5uY‘\è^>ñ¥p^Fl–7t`þDÌ§s\×p\Æ2:v\ï^; xž\Þ\Ã\â%´ú+\Í\0‚\à\0m\î?pô\ï\í\\Þ¹\â»\ítÉ§\èwºƒ ~\îw;³Õ†OÓš\ëgÿ\0†ó\Ìu9./ü½ðy\ì¦%p\Ù>c1\È\Ý\Ðuù«\×t«U…ú£Î½*]4;ßº\ä÷\Ú¾…¥©ŸQ»bò´|•~\ï\ëú\Õ‡~K\ØJ\\¾w\ÜIŽ%|óÏ¢ô\éŸ¾Ÿ¬\êòG>¡q\Ç\n\ã&0S;€ƒsÞº\Øü9kg¥£<[qÁ\Ís\Ë4½\íÞ¥\Ò\Ä\Â/\Ý\èy4žû6±kŸùŒ¥‰\é‘\éô¯Y\Zl0\Ú,m´8^ižÐj‚ðr~QŒõ\ïšß¸´\Êd®k|\'9w0\Ç\â=¤”S\Øä¢,£h\ã\ÜA$’Í’k:óRX¥16I\Æv¨\'5\Ø\\\é‹*‘‚Ò°5M\"[fi!›y\êc#ƒ]2“ZœI\'¹\Ï\Ïs\È/\â\ÜÀ ¯ò¨^†\éü—r®\n°Áü«n\Ë[+sy%£FË¨LŸ\ÃÞ¹=B+\ßx\ê+‹(„q”ÈŒ£<=j¥/v\í„\"¹­c¥\ÒKZ¡ò”\í\'8­ý?W‰­Y$1\ão­Y\Ó4‰~\Îm\í\ÝH\å‚\ì,~€\ãùV²©¤\êPÏ‘\ä\Ë!Á<¡£Óžµ<\ë¹\\·/\rXðýýž¯¦­\Üð´Án\Éhb\ÛõÁ\ÉV tþ!\\®»e«h?\Úú-ûF÷ó£+ÛÉ‰2\Û`tÃ§J\é¼Ate\Ó&Ó’ýp8h.ï¼£°\nÀy«ºñGˆ.µ+§ñ\ßlI™]\ÞD“b\í\ã\ÑF8\ë\ÍgRT\à¹õ\Üî¢§?}]ˆôy\î\ç\ÍòÔ¤ƒo\Î0\Ù\ÏsÚ¢ñN=ü…¬\íä•ƒ\ÇfMƒ¹;i’jv2–{iOðŒÇŸ\Ç\ëS\ë>3×´¿41\ë0Áf\Îcð:¥\Ë}p7`“\ëX\ÓpW¹¤\Ô\åk/ñr\Îx54cº7‰~G\ØC¯±‡z\â„þ!´š\Ö\áópHŸ*J=ýñ^£­ø‡E\Ö|=¨M«\ä\Ï\"(Á\0`!0GSÁ\É\ç9ük\Êü\r’x–\Úh›c\Û{g#úÓºž\îR‹„[\ì{\ïÄ‹ˆ­ \Ñ58n¡ŸV¸µ55Gfi\Î\Õm\ä¶6>EV^\â \Ð5\ëmF\Ð\\\é÷+4yÁ\ÚyS\Ü\Ô\Z_\è6ºÆ‰ja^\é¢)u3\Ü\ÓÀ®¨s\è1Ò¸\íWI¼ðÏˆF›¦\Ú-\ÃÍ±­o&C·€\Æ6\ç\æÀ\Èó\ÔÖ¸lT\èJQk\Ý\é\åý~g5l5:ð‹½¥ý^‡¥\Úk!\ëz\Ö]evŒ¼„\ãÖ¼ûÁþ ¶\×#ºò£’\Êo&`\Ýc¨ïŽ½pko\Ì>µ\ïF\\\Ê\èñ%fµ>~\Ñu848.cº-&ù‘…=¶‘×Œñ\ê(µ\×U\ä–5Ìˆ¼\äº=ý«…ƒZ»¿\Ðm´\ÎY®\"\Ä.#]\ß*ÿ\0\ì÷®»Gð\ÝÈ°ˆø“W´\ÓP?e€©¸pG\0œ€?S_#SsJ£³»Ó­»ž¥e®„WúCkš\Ò\È¿u$$g§\ËÀ\É\ç<þuÕ‹\ÑôXt\ÃpD2\Â4\0\Ê\çû\Ï\éøÕ­>\ê\ÛL\Ó\×û5*T¯žXe n ý?:\Ã\×.a{qñG\ZÝ¿qWcý\Ü\ç§|W\êÊ­ ž†³\ÄÔ•8\Òo\ÝE]vò\Ê\r>t–\àÀ\Äq\"J—ô9®\Â:ÕŽ‘\âô©d»´y7‰\ã;\ã=Á\ä~_… ‹Lþ\Ðcf\Òn†R	_~O9ªC\í±`ed­{x<=:t\Ü]\Ý\Ïw„ö0ö‘o^\ê\Ç\Þ_³1\Ð5¯>«–sD±DŸ3\ås\È\ëú]Å\Ç\âT6öº›Ø­šl‘\\´dœnÝ´ŽJ‘ô\ÇÖ¾.øs¯\ëþÔ’mô\Ä\ÊÁ\Þ\ËFO©¡úW\×>ñÖ‘\ã-\n\ËTž\æ6¾ŽDŽöÍ¤ù\í\æNI\È\Û\Ü\àŽ*Z„—³Š\Ðõ\á*”¦ª\'©\áž4Ó¤·\Ôdˆ\Û]\é\Ò&$’\Þ\åZ@ñ:“z†\år9<\ã„\×\áò%e–\Ø\ê6³¯¨\È<væ½—ö\Î\Zv«¬hº\ÌWª?\îÃ¤»•€\ÎôÁ\Çn•\åºH³d\Z~¢\ÑKmu0A+¿\Ülý\å~ ~˜\ë^5JQ¡W\Ý_\×s\ê¨ÖŽ#\n§.¿…Œ¿¼–Z\ä)l³˜¸§\0\ß•\îñÖ—\Ö7\Ö±º·ÿ\0^\ÐüÅˆ9^„ž„þU\âR‡\Ñ<B\Ð,¥GÇ¨5\ÛxÅ–w–q\ÛG‰‹²—\01Ü\Î\rz´qwŠ»±\ãbpœ²ºZ3\éÿ\0x\Â\ß]°Ž9,’;Ûˆ™]\ã4Žs·€¸ þu\Ù\\u\rGsg°¤`$\ê®FGLŽ¸>µò­§‰\í\ìe´Ž=ü\ç>\\‰V,üÇ¶k¿ð\ç‰/$\Ô,\áÒ¥i®\æ2Tó±\Ô\r\Ä\rÇ°\ï\ÍoZnjûžb¤\àûÙ¤i·Piò_GkhX+²Áô#­Všþýõˆ\à¶Ó¼\ËE\0\Í1nPŸº÷\èk\Î\Ä]R\ÓSq”\×)q\0ˆ\Ç*yWSÐJõ†ZÑ›T\Z\Â\Ûo³¸„üÀ\ç¦=Et`\å	+=,r\âc$\ï½\Éu‚\Äeg©\Îr72\ÜÜ¼\Â	\É®£ƒ\î+¢ø‰\âX¯5;ˆ\âžc\0ñ\Ó5¥\áÿ\0\rO?†\Åù\n \ÚHOÒŽhÔ›7{—$o#\Ëõ›wkQ»(PxcØšç´r\ë\æGŒ\ÉŸ,‹· ÷¯Fñ¦‘67[E¹\Ç<\ÖN“\áO\íýV\ÙõˆvV\Ê\Ì\ê:¹\Ç\0?Â‰AŽ5#\ÔÔ²ñVŸ}`²X_\Ç‡³BJÀñj[jöoö\â\Ë\æªð±\È\ï^}ñ«Á\ÒÀþf•ö•\Ø96\Ï\å±ƒ=OÖ¹¯†Ú®%\Ìr\Þjwª\äŽ\áÀ\íŽ\çÞ¸\ê\Æ5>&t\Ã\Ý\\\Ñ:Ÿß¬w7ze\å\á[¸˜ˆ%9\Û þ\é¡#¡ü¨½jcH<©¡k‡“+\Ê\çý\n\ä|b\×k‘\êPYNžd[g>Y\Æ\àx?‘\"ºß…Z\ä\êö§Q\Øö\Ë2–C\Ã.FE5N5RRz®¿\æi\íeN\íl\ÍM7FÓ¥²‘i¯l%\ÝzŸj\Ê×¼oq`Ð½»\Ü(\èFHS^·«O¢BŠútŠ¬ó<r[¹¢n U+\ÐûVSNeºX<\ÃvÁ\0\Ñ<\"†\ìP\ÆJOcÁ\î>Gq+,\ÒBªª’>™ÿ\0\n\Ñð¿\Âÿ\0i·\nòý­±µþ¤ö\ë^×ªZZ\Åj\Ò1%±€8¯-\×\çÔ…\î#·xY›%³\Î|þU\çó8\ËC¶Õ•›:ýW\á>Œ<7¶\Ñ\ÏôHq!\èN:k‹—Á+\r°º•#g9R¤t\Åz„WYþÆ†9n¥™JeC¾vý>´šÝœ«òÃ¨S\ÍoZ¤e\ËÑ‹„šr¹\å’ið\Å+‹k_.E\á™=\ê´(\á‰u\é]wˆb}+j\ì\Ù\çD\Ò.ñ\Ë+š’\æÜ»d¶O\Ì8=\ëL>*µ¥ø‘Z„*;³\æmwº·‘ô}ÎŒc÷s\Ç\å<~ÄƒOm*D‘õ;\ËI¤e\Ì{\Ê\Ã\ÉôúÔž²\Óô»V´µž0²\Îñ±2{ŒJ›û9//.t\ë–\Ø:,°0;Y_\Ã»cŽrk7	\ÊQv\Ê\í|¬|KÑ¶Ÿùœ\åÅ—ŠTG²7S$‡;Y\Âcù[£Âº¶³j_R¶ºVŒ’¿\n¼u9\ã\×ßšô?†^Ñ­­÷[y\äðeF¹%a‚\Ç	õ5\ßi\Þ\Õ|¸õ‹Dµ\Ôcµ\Þ\Æ\ÎB­\ã\0rp?\Æx\éZF­Z­J	z\ÛQ*™J;÷<KEøG¯_i©\Ùi:†¡m·t |\Çñ#s]V‹ðGTžç½µkeP¥¢Š#,\àŸ\á•Lý×ªøK\â\\2i\Ó\Ï™³-\å£E—‰÷”cwC‚=+¥\Ó~*øvY\Â\\Þ´H£x1¨P\ç±lÿ\0:ì¤©¥i\Ï\Þóý\r\å\Ä}©3Ì®>&•b\Ër Ó¢9D7ó™n&p:\"c:|«Ö¼\ëÆ¦o\ê?l·»0_\ÂWkØ¯–B\ç9-\Ó8 ûŠ÷	nüªxö\rVõRGtuÒ…\Ù?~B{ó\È=ñƒš»ñ\'QºþÁh^\Ñol\'ù\Åc@\ÚX¨Á\È\ÆN1‘P©Á¾döùþEP\Ä\ÍT¼\ä\í\Ú\ç\Ë>0ø?ˆô;q­@\ÍqhÌ«$\\+–\èqÓŒr:~uCG½ó\í’}B\åH\Î\Ôø\àu¬/\é·\ÚG‰¤±Ô’\Ú9ü\æ‘\ã¶#\Ë@z\0£\îý\rZ²hûCZ$›\0\ØN@‡jÖ­8ß¹ö¸ld¹+\Ðôñ`5;\Ð,\Öqªù[¤˜y\ãŽý;TZ<l“Feˆ\"\íùN2O¯\ãôôªõ{\Õ]\Òoo—c}Ý¾ŸJ\î%\Ñb¸¸ò´û1–C*[\Æx\r\ßosÛ¾kÁ\ÄRi{§§EŸ$È–©[s1š\\˜\ÑXÀ\äñ\í\ë\í[ú\n_	ü\Æò0\É$sý+)\"BK€b“&Gº&\éb±òUqœ\ï\ãv:\Z\é\ÂÁ\É]œ•¥m\r^­™ó Q8Y\ç9\èq^\ÙðƒS»¼ðlš\ÌBžFX£^ /Ÿ\Ç5ó­\Õ\ÌR\Þ\Ç1‹qRw‚\Ç\æ\Ïzöÿ\0\é}ð\î8ó™H\Ý\ÓN?\"+¦U9 \Ú8\êSN\Úµ9R]q›\nX6\ã^‰\à-­‚\Ùù¨¬³‡.\0px+ŽýµxÏ5msq*mŒ2õ\\ú\ë‰ÿ\0„\×X·ñ¾Ÿ¨ZÌ˜\ÒÕ®a\Ù~b¬ˆ?CF¤\ã>x\ìeV’”lÏ²®C_\é·B\ê\Ãa2Ç“Áa”‘‘Ozóø‚\ÏJ‰-¡ý\åÀoTePµŽŸJÚ‹\âE‰>™\ìP\ÙËªX—±!\Ãm\È\Ç×ƒý+\Ê4§c¾­\ÂXn=wŸ_ñ®œ\Ë\Z¡8Q¦õ—SŸ\r‡¼e9-º\ß\êWw†c(\ÒB~O,a}J÷ó\é\\\ävò\Î\Û>\ÐöŒŽHa÷d¦kB\ëU´³V73¬n“ŸN\Ç…b\ÞkIo<\Úl&m§\n \ä1öö5Ä \×\Ä\ît&\Þ\ÈØŠ;û{Y$¹\Í{rI\àmtÿ\0\Z‹\\\Ò\ì5Kh\îDf)8h\æŒ\0#úŽÿ\0J—À>#ƒ\Å–\ê)\íf·>E\ÔŽTã¯¸\ë\\Žµu¨\è²Èˆ²\Ë1\Ø:\íæ´‚J\Ö7¹WTñ>§ j_e\Ô\â2Ç·Ë‚\ê3… tŸn\ßJ\è|3\â\è\ïu]§ FÛžýª÷†ô3Zðüwºõ¼^d¤\ì†L£§#ÖŸ?4Ø­Ù´ûuYxò~\\þU\Õi\Ê-6E\ã{vºõ­\Ô\îg½µ‹bn\Øò…,G`z\Ò\Ô<_\á‹-+¬·Š$Š\ìÄžrN¼m\Ëv^;cž\Õ\ãz\í©\Ðn\æA$\0a—,ƒü÷§\Øjö‘Â·l\0ž\Ý®eO\Ùß¹¿?2G¤E\ãM&\Þ\Å\Ò	\â\\GGµc\\øú4¹Xtûµ7ò˜f\äb°\ã:Oˆ-Š2£2IÊŸ\\W;u¥¿„|EõÙŽ{\'a\ä\Þ%º¦\ÏöHP\0ú\Ô*\ë\Þu\Ø\ìõmR×‘X\ß\Ém4À\r\Än`8\Îfÿ\0ÂŒ\Ö\çþÜ½m\Ü\ç\ì\'Ÿ~µ\ß\è^ Ñ—\Âwþ!“Q²‰´\Û}\É –Ë…\Ç9Ó§j\á\âŒì¡š=q‰-ý¢«Ÿ|c¥:“¥‡iM\î:q©Y^=Ÿ\Ó\Ãú]\å\Ë\Ä!¸ŽVB‘\Çg8ñòŽ~^½\È\é\\5¯ˆõP»\Ðu›¶¸Šc\Þ`X[ýñ\Î}#Ö½÷\Ä>Î—ý­½`Î‘f;y!l>;PpO=Ey\'ÄŸ\êWZ¡‹Z°µ[˜\âXŒ¢%c,k¿8\áÀ\ÏŸ­^‚pª¯\Øø¬57\'\Ê\Î\Ã\á‹A©^Y$š¦\ÅVŒœ7só­{§‰ü-\âh<\r-¾\ãI\âbf0\Û\Û\Åš1\ÐÈ 8\ãÐŠù\Â~$}XŽ\î\0’F£\nTt\ã\ÔW\Ù~ñ¦“®xn\Â\á§X`xw$²8\Âó´ƒœ¿\ÈWN\Z„)Jkk\ê…^‹¥?&|ÀšöZˆ\ä\Ó%ŽB¡\ár\ÐNz\á\r\îzú\Ó//g…BÝ¦\Äp6H\ÊGc]§\í\áÉ¦ñ.ƒrŽ\É/šúlr†‚@yo|Ã®x8ö\ÅqZ;ÿ\0\ÂI\áô¹\Ò\á!­\Ð%Å¿$Dr@Rx\ã\é\\8Œ3q\æzµ¹“‡»p2·–	$óÙºŸj\Öð×‹o´\ë\Ô)¨m\0`¤£!}ù\éõ¯9ñP\Öt¨\æ³W;\"6a°N<©À\àŽ\rnxG»ñ…šö,ñ3Fþ^7FÞ„ž£sQK8Ú¤^·êŽš\n•yeuø¿}§øš\â7°°f¼ö-\ÄV7<­žNÏ¶GcT4\n\í¬\\4[™	À0=#ƒŠ\í¼\áä¾¶°½‡\ä†Á˜LG\Í$\ì\ìY}s´¯\å]–§gm¢Û˜\ï`†\Ô\Æ,+\Ù%R>ùÁ \äry\ï\ÅN/\é\Ê0KN\ç\Ù\åxxF…“»Gž\éž¸µ\Ï\n´Nø1±xõ\ÆkÑ´‘q<–ó†@P¯,q°ž?\ïY\Öoiu²?\0ðs\È\"­]K6hòZ/›v/\Î8€T“~÷C¦r\æ\Ñ\îtž+\ÒÆ£h\Ë5¼)$X\Úc\åKŒ9#žø\ãÒ¹\Ý6\áË˜‰a\Ôg¾p~˜­\ë—7›­\ï£[vh”°-½b>€Ž£\éY÷Žƒ^Gr#•2\'÷>ý¨Œ\ã\n‰tbQn>†Í«\Ú\É\\2\ï_^s\êMuÿ\0³¶£y\á\ë×€_Yd2(\'\Ø\Ã(\î ~\"¸]Z]Ó±K“q˜1À~ø¨´bXeûE«¼3F\à«! údc·½]EõÐžY8´rø‹£C¨\é\æ\çOO22\Ù\Ôòƒ¸½\ë\É^\Ú{g^!$V\ÎÀz²¸ÁB;dw«Ÿð±µy¯TY,\Ù\ã	2…Ú²\ã«m\é“\ß\0\éV\ì\ãÄ—h³OolË…÷\Ç8¨¥\Æ^\ãº3’\\¾þ\æ¿À=LB·^™—fŸ(š\Ì\ä“\Z9\å=€?Î½G\\Ó“\ìr]Æ¢À$•\Îú\Ç\Öð\Ö\ËF†+ý7P[»Æˆ9u\Î\Ð:”\è9\às\ê*Ö¥\ã\âß§\Ý$¨_\æ5ßƒ\ïŽÕŽ\"…Js\æ–ý„\ãW\àùž#ûFý¬\é2Id\Ói¶È±7\ÝLÿ\0*¡ð+W\Ô\ïü5(¾=½Œ§hÀ.\ìžOq•\èzW[ñBóDk×™u$K–Bqœ“Ø¯j¡ð“\ÂÉ¨j\Úå¥”²oû\Ú\n—\Æ\Þ\á˜w\Ï<zs]T\ëó\Æ*Ú\Ùr\ÞûøO\âZ\rþ§c¨T5\ÄeW™G	\ìL\Ò\è(Óµ\ët†thei\ÚGùŽÈ—À\Ï$\×\âÛ¨\ì|Cý—&I–0¸ßµ\ÆÂ¸9ÿ\01]\ßÁ?\ÚjZ\Ôw3$\ékl²™’f\0g (8\äwúq\\\Ó\ÄTU\Ò[p\Ã\Óö.RÜ“S\×c¹»e²2\Åmf€¢©\Ú\Ò6y\æ½k\áf³e®ømL²¢Nª”ú×Œ\êvLþ,¸ŠEUYfo•3€e]ë—¾¿–=:yHC»\å9Ï±ö®ü-YhÚ½\Î<E\ÉY;XöŠ\Z-¡€’Ð±˜`( –Û­|±\âX<C¤ø\Ò}0\Ïx-#›h\í\×s\ì=	\È\Åu^ø\â-kÆ³]\Ü4b*ˆ°QýGa\È\î+½\Zañ5®eA%\Ä@\î™Tû\Zï›§vŽ\Zq©{&yO…¼A¯\è7\Ï0Y g\ØÏ¼={Ÿq^«£\ë\Ð\ë\Þ\r»Ó¯öº\\\ÄÁƒ€Ã¦=+ŒºÐ ·\×L[9\ê?š)PYrªG\Íþ\èæº›\Ð\ØOgöh\ÍÔ®<\Ç·`8 c³\0y¬*\Æ2\Ò6NJZœ•«\É\á\Ù,%]ñY\ÊpÁ98=\Ïs[\Öþñ|¶ñÊºñ¡Úƒ9‡ŸÎº\í2\Æ\Ó\Âúd—-’f;\Ãô1w\ÏlsÚ±®\íbºº–\æ\êòO>g2K¹Ž\ârr@Á9=«ç±´Tª{ú¿¸öð•¢¡¢GžZx›Y°W·Òµ)\àm»i\Ì_pr8?Ò¹ˆ—WZ“+\\\Ø\ÇA¿w*I¹K†¸\Ï\\dŽ8­=røe\"[\'†TUb›v\í\r\ÈÇ·¿\áT†ŸwÍ»\íBKGƒ\È\çœg¥v\à\ÕER\Ò?5\Â\ßÚ«œrØ\ß(\â»?\êÚ„:zh\ä\È\Ñ\Ã\æ4*ŒaÜƒ<u\çZl\ZŠyŒñVJu\ça\ëGjõjC\ÚG•ž­Jq«V]ÓµQ=ªC¨(¶lIý\ì<‡\ÆqÇ½r¾–\ï\Ã.’]:\án´\É÷	#*W†”ÿ\0\É#ú\Ö\Å\å¿\Ù-¤¸•$cq	öÏ½q¯«jË¬£¬YŒ\È7\Ä*=3ô¥Jœ)\Þ+ñ9½*N\×n\çY¯\ÜXjŸN\Èe»?8(@Be\'¿\ä÷¬¿‡ú¾³\à‹yZ\Ì\Ä\Ï?\Ê\ë2\îF\îœds\ï\éZ\Z†¹¤[B\ï5•Âœþ\á~R\ÒS\Ï‘i¨Y\ê—B)bxT±!ø½k	¹S\îßºc9:I{7¡©}\â}V¹Š\êóS™v¶ø\ã„ùI\ÎrÔº¾¹,\×r\Ü5\Õ\Å\Ê0\Ù\ÆÐ¤œ’OSŸòkZ\Ôb³¸o™|‹´x\êsI}Z\è&÷Qs-\ÅÊ•²´o»\î²\êO|W/²Œ\ì\æ·\Ø\î\ÊñØŠU}ßµ§õ\ètšgˆ’)#Œ”µ·\åda\Ó=±\î*\îŸ\â›\Èl\Ú\á¤S1\0Md®=³Ú¼\Î\Â\ä½\ÊÛ¬¸iy@xÏ¶k«\Ð4½Rú\ÕLQ;v+¨á¨«AQ[\ÙqIBn\ì\ëtGw8X¤1\Ë{0¥¾º¹:\Òß£\"aµ”.\âMT›\á­õ¾ƒ¸\ÓEjþxE‰Ü¬’¬ƒø‡\Ê\Ùô\Åj\èúM\ìñù+’\È$J—!Ž7(\êq\è?J\à\ÄMs.Gs®•*i·¶=\Âú*ø‹L>L~d‘Ã™Ww\Þ«uôô®WQ\Ñ\ä\Ò5 &k\Ï2YŠ\ÆY.	ù¿»ø\×Oc¦j\Þ×¡¶Žw‘ƒG2ñ°žv\äHg\ë]Æq§^\ÚJš\í…\Î$“>`\âeaÑƒ`‚9\Î¥vFt\ë%­¤6r\í¬Y\äV×–\Ð^]gl\å¼\Ö®~\î}kY¯ä´ˆ\ê¶\Ð\\²\Éx—?>=½…7\ÇúV©c	\Ò/t¶O3u\Ôs©$¯<dpCø\Ö1MR\×N2\Éhñ\Å\ç\Ñ\ÚË¼Ÿ›Ád~~\Þ2\\©Ù™û\'ñ\îkøñ2\âk\Ö\æ2#\Ú0\ìps\î;Um~óK\ÖüI,zU\Ôöš“Ç½c/	\ï\Ø¡¯<Ó¥{kUy\Ý\Ñv\áI\ê~µ¯¤xš[&\Ç\0˜’Š\Ê\Ó\'¡ö­”ù’Rw99[qV!×¼3}®ngº·ZEü\Â:@À\ïV>\ë··½·’X¤’i½\Æ\Þ&\Ü0s\éÚ§ñ«­m¹7Á#GÑ˜|W)5½û\è:µ……¤÷w	–\ÜDFC9\Ç|`œö¬gu+G¯S¢›N+œÇ‹§\ê\Ï\ÑN\Þ]ÀS2!\æðÜŒp@\ZúLÑ¬l¼9\ÚlA§¼\Ù+\ÈwÙ\Çð¯”¼ð\Ç^×®m\ãñ¢l¬˜\'Ù¾g\ÚNIÿ\0h\é_Rø=\í­ü–u‰\ì X¢™ˆ\Þ\åF\Õ\ãÔŒ~&…MÆŸ¼Mj‘s´Y\ç¾+ðýÕŠÏž‚7‘E\Ä[U•¹À?y\×\Çx]4™n\í\"\Û$ˆVI‚1Ö¾‡ñeå¶£¢A¥\ê–Pý®\Ê%û%Ú±Ve\àÃ¾q\ÛÒ¼s\â|1Em<W =¬ŒA•NBçƒš\é\Ã8F\\©œõ\\Þ­SðƒL·¸òÏ˜ŸmÝ¸«Xf½sNº\Ôô+¦DW]\n¼ŒŒW\Ç5§†õ öI2JL4Y\Âöe=A\Ïò¯Yðÿ\0‹-\ï´(\à•˜\ÜAû¿2G\r¿o/§Òº±MÙ³\nrihoEƒÅ¾ž\äynŒ’„\0¨Ç¡µŸð³Ã—ºQ¿{©^t\Ê\ÈXœ\î`\Ö-Ïˆ®4û\é^\0Ì’.\Üd¾\ãz\×Ið\ÓY¿µ¸˜²L <‰Ý²y`{\×\"œT•\Í$§\Ê\ìAñ\Ú\å4¶u‘ü¢¹#•cLøƒyo¦\Û\Ûÿ\0f\è\Í\åD©™,Ô±ÀŸz\Æ\íE¿\á‘ \à\ÊÊ¬:\rydW³ùk”ˆœ’95šK\ÜÚ„\\©ÙŸI|iøeýw$ñ\Ûo…‰9\Åy³acc}®H ‰xÌŽnk\î\ÍcM¶Ô´æµ»@\êÀ€H\é_(þ\Ö\ßn\'´[\Ë 6Ú³È™!W9f=\0\ê~•ôX\ÊN”\\\à®|ÃºWGjš\ï\ìÕ£—[²W^B\\ÿ\0\ã \×3ªø\ãÁÐƒöw¼¹n\Â;m þ,Eqþ#·²Š_*+\ä\Åò‡\ÏúÓž\\\ÃÒ²ul­\á·q(x\äMûû¶x\àskÇŽ3/t\Ë\ë±½\ã\ßZ\ËohðY\âbv—ù\È\Ç9\í\×­rð_\Þ\Ý\Ø\\^4qGo\ÚB7\ÎX\àñøU=Js}*’¸\0laþ4º\Ì#Nðø€¶&÷Mót\Æ@QISN\Ü\ß\×\àc&\Þû³6\ãY¸yd28—v–\\m\Ð\n\Ýð\ÝÖ&™=ôú›\Û^YR\ÎXƒy\êp3Œ`ƒ’AWs“\Øf¯\ØÆ\Ù}©ÁidqÛž­^Œ\èC–\Ö7öi£°ñm”K¨X\\<Nc¸s,˜\ç\Ì\n2\ëYš\å\Ô\×\×+ª´…\Ç\Ý*½°;b®ørð\\\Íö[ý­.š\nA3q½s\ÆG¨\ìj=Iš\Öo´\Õ\ÌnÙ–. Ôjóh¸Óš¥Su¢~¿\Ò//c-wG}ðû\áö›¯i^½ÂºGŒ™2g \à\É\á^·\á\Ù\é:w\Ù\"‘™Y\"b6ó+¯\\\àq{pk\ç_…þ4:+þ]\Ù@\Ìg=²?Nõ\êúW\ÄnL{Â‘\Æ\ìp¼õ¸®\nñ©\nŽ5u]¥Ž.5¬£-{\ÜÉ¦\Ãf¢R\Ïlóxv6!0+\É\àö\éN¶\Ò\ì¢Ò´{û4e¹˜\Ü5\Ä\Íuˆ\ÜF\Ã[§\å?š÷®Z?A%›†9±\Ý\Z¿©>£“Öº‹\rHo­ªK„Fªca\î\ËóH_”:3ƒ\\!M·#¾•i¤“6<w§iúF¬\ÛIr’Cjw+¶\à\ÊP{–ù½1Ÿ~›Â“jø\rd·¸´šo0‡Š8Ï›2F\ìŽ\ã=2\ryÖµ­\ß¦ Š\ám\å\ß€N\ìŒ7^±J·ðY¾Ï­4—„L.\Ýr=ü\áQ%Z\ÑZI/øsy\ÚT/\'\ïE™?´]N\ëK‘5¥kVR…­\×\Ëe\Ç ƒŒn\ã¯^k†¶\ÕQ]\Ò\Í\å‰\"9¤\Ü\È>¤ýk\ëHa\Z„s¡‰RgA+üÿ\06\Î3•\ÈÇ§¼\Ç\ãgƒ4\ÍVmö\Z]µ\âò—61\ìŠc‘• \0	\ÆNp>µ´°µ!e+®Å‡\ÅÑ›\äœmùPúÖ£<)•Z2Ha³wn¹)·j\ßgóò\îr\Ãß±ªþ!ð—Š´ë‰†™,—ñC½š(\ÎT\ärƒ\Î>•ƒ{\'ˆ´¶Œ\ë$O‘‰!eEn\ä»\Ðñ\È8>\ÜÔ¨\ÎI\ë¯n§O°ŽŽ\r4i´—QÎ¬÷\Í:\0	\ìqÞ´!\Õ\'·³4„\á2\Ägôæ¹‰¼C§Ì§Ì‘¾A÷*ñ\Ç\ã\â-=`\Ìq‰cŒ©–V\'Œž£­(Æ·ò±Ê‘\é\Þñf©mó/\ï!CÀ~	õ8®ƒEø‘sg\â±¦Žö7[0ñ\Ä“\êTdg†¼¥.\Ö\ÝÕ£šG8Ê¬C$œzT««k\Ó}±­\ß\ì¡z\ì!³\îzUS\Ä6­&s\Ïwt©§»Ò¯´fºþ\Ú\Ó.\É\ÂG›ÔŠR¸\àl”«¦+\Æ|q®øz\Þ\ê\æ\ÎMB7grw©\ì{u®Z\Ôõý_F_²JPo¾\Ù8\É\Ï8$ôªi^µyš¦¤\ábQ\Ëzj\Öu©·\î\èL0n	ûI§‰.\ÓûG ùj\Ù199\ã\ÕÂ‹\â}@ˆ\íK\ÛC“ûÿ\0(·\ázô7Àv­^Kd¦\â\Ë5\ç\É\æ¸TQ“×°\Åm\Ù\Äldy,	´¡s—û¨ŸÁŸ\\æº½¤\ä¯=™„iM]œÖ‡ˆmlÈ¹p]²\Ì\ÒF	\'\Ðc±ý+®ð\ïö½ÕƒDFš6$!\'°Pyü*8\îFC\Ø\Ä`HGR}N*Ã¤öm5\Û\ì0‚ò\È_ŒO5”)J¤ý\Æ\Ì\åQ(û\Éúþ‘\âaE\Ë\êpOX&=À2IÀ\Ï8\Ås\Òj\ÈÑ‰\íÀRF$~8«6ó\êþ%¾}?E´û5œ¿*ª¯Í·¹cØš\ê­þI\ä&\é\Ø6Ñ|Wuºn\îN\ç=Ldˆû\écYúÞ›i©X½\ì,2)2\äôô­m¹â¢•9\Í}›J[Ÿ4|û\\~\Í~+o\ßøŸA¼²»³»#\ìö„ˆ\ÝT°g\åa\Ô\äc¯Jù—\Æ>\Õt\Ø-õt’\ÞY¡\Üz2ƒ’8=¿:ú£öÿ\0ø¨ú¿ŒuO†w^´Ht˜¤±\Ô\åy\í%hÕ\Ó)ƒmÁg®1ó%\åô¿e4\ÒÈ½v3’õ\Çc_!‹«\nu\å\n=ÿ\0®‡$\ÜyŒ/K6r\Ë+\Þý\ÙUb\ä\ç\êx¬ÿ\0$ó5ºÁžRÇ’q\ÎI\ïùV\Å\Ã\Æ\ìX6Ö¨\Zr¡˜>}H©§RjjoVŒœ­.cIð\ì—\æL§p*x¬\Zó\\Ž\Ö\Ä6d(ô-SM!ß¸J\Êq–\ÚqZ>¸H£h†–\Þ:ƒ\Ç_j\íúÄ’»:#[¹Ÿ”\Ô\\…\\™6ŸN8®\âÝ¬\æ\ÑJ4ñ+’\Êc\ËgŽ+“Ž\Ïe\àù\×ó)õ\ÍnY:|Ñ±,\Ê2¤vô?\âcZ¨Ô®qÊ«U9Ž;\Å>»ó¼\Ë<õ–\Ûþ±q\Û\Ü~µSH¿Ô´\é’ÿ\0/X¤8ükµK»G¸C%\Ú[³`H\à‚x8\ãwª\Ë=\Ì\ÐOr$R˜žQ\Ðc¸=²9\Åv\Ó\Ä\ÉÇ’´n‘\Þ\ç\Òh± k\Z}óü\×rX\\7B\íº2Ÿ¥t–:Þ©¥Y\ÙgŽ2Z)\"m\Ê	\ÆXŽÇùW#uá¥‚a-´\á\Ã`®õÀ#Þ–¿µ.´¯20p$³”¤‰øAü«™Ò¡R^ä®»=>\çþw=\nxŒM¹_4|õüNÍ¼R\0&#Ÿ@n}È¬I<a¯\é\Z\ßö¥„\Ï\Zó†R=¬‰Ž|nó\Æy9Ë™?\ÞCÁú‚E]¶6\Ëg[\'Tñõ\âº)a°P\Õ\Þþzþ‡WöµG£Hõ/üf\Ö\áµ\ÃC(3a›Ë—ƒŽ{ÿ\0\\\×SiñƒHû,Q1\0~\æD|ƒž„€9\Î}«\Â\Ú\æc2% ¶1©‰˜>Àv«Z\ÙþÑš\Ò8\Õ x\ÈfwBVC¸\r„Ž9ö\ÇSX\×T£QF‹Ó®º~\'%LÆ¢\Ù\'ýyL[x»ÁúÖžnl\á4ª\É: \Ú€v\äGøW7­xJ½´si£\Ï$‘…ÀŒ¶\äŽ@Pz×ŽX\Å5Á{;¹¡\0ð²¿•t6~+\Ô\ãˆC<Á€\0\ÇS\êqQW‰”T¥ý_\rŒ§dÔ¬\ßs¥¼ðF˜Í¾]<yrH\Ì†=pIüj-\'B\Òÿ\0¶n!‡@’\Ê\ÅdE\'\Ú”8\Æ†2Hç§¯jg‡|h¢p—ªƒ<+\àŒú\×H—V÷efQi<¹ý\Ñ\'s\×Z\àJKF¾G¦±\rõüCLÐ¬\äX\à\Ó ‘.\Ãlm\ã®{ö\â´²4\×Skw¥\Æ\è\Ão\02Ÿz4h¤±¹™ö\Ù\Æü€q\Î:`b®\Û\Þ[A -u¸—\ÎDyã¿¥L\'8?z6ù!Ë•ü/ü\ÈfðÆ“\r»\íb@Ÿ0R˜\ãñªZ|W\ÎÍ§GR•J@†{ƒ\ÔU\ïk¬\Â+[˜<\ï\\\í\ãù\×?.³t%ŒO2¼I»$‚2Çƒ\ß\àSž%F|°Vô\ntÜ£y?¼\Ö\Ò\â¿6\Ï&§|·7rn\"@wŽ\ÄçŠ©o—|³>}½+ÿ\0^·ižp±(!¯¿…X\Ò#\Öõ¤[}M–\á7sq!Ú£ñ®Š*U²•\ÙjB\Z­\rŽXIˆ\ãC\\õª\Z^“«ø÷Ä‹ed²\r*\Ø\æI\0ùYýI\ïŽ\Õ\ÞxC\áS\Î\Â\ç\ÅWŸh$\äZÀJ\Æ=‰\êkÓ´}>\ËK³K]:\Ö+xPaR5Àôx\\,R\Ù&#ví©‘\à\éž±H¡‰K¼\Ý\É÷®lcŒ=©Ë–8©„?\ìšô\Ô\Èóœ\Ûwg».Ö›\"\æ’#\ÛÒŸŸJ\ìÙ˜ž_ûF|ð‡\Å\í./\í7O\Õ\íe¦¯hŠfsŸ-Á\âHó\Î\Ó\Ðò\ç?)x\Ãö0ø“e\âI-´½#W\Ò\Õ\Å}=È´v$rGqŒ\ä\ç­}ö\Ýy¨f\n– \É,prW\Ëðõ\ß4•ŸtD©\ÆZ´|,¿±–¯¥h«øƒÄ¶RP¼–ºz±€2KK eük\ç_Šƒ\Â\ÖZ‘Ñ¼9\n\Ê#|Mx³3†>Šz¯JúKö\äý¡`ñ\×¼|‹…u[ø\ä\ãQu?êùd¤rŒA\Ï\ÊZ…ÕœlþC	gn„•×½|þ!Ð…_gE].§5Gò\Å—1¤F\âˆ\ç¨‡õ«\Ú9U£\06\Ð}Gÿ\0[5¨y¿hgffvl±=ë¦¶Ó¤o‡\ë¸\î\n0=\n“\×ð?Î´©M¸-BTÛŽ†´2[°•R¡‰B[õ\Ïj‘%D‰\Ùˆ\í\n\ä7#¯LqŸZ\æ¬o¤b#CûšÖ´”´j²m79\È\êEy•(8½N^WCšwÈ m9\Íciú\ÄW—w,LÑ¼¿¾Œ±ù½\Ôs\Í_\×o\rXTŒ“œõ¬¯\\[Çª5¼\ä*Ü€M\Ù\è~¹®ú1n›rW;`\ÔÞ¦\ë\\\Ê\ê“\Ú\È\Â	€m¼|¤t\è«X^-Å²J\ê¨J|\Ätf\î*)´ÿ\0+OŽ(¢\n¨\Äc\ÏQ‰®\í’KY#\0,„©ö®)\ÅIß±Ðª:vI“\ß\Ü\ÇYh÷\Ë!\êGµð\ÈdŒ\î‘\áds¹}V·ón.\Ö)œ0‹“\ÇQÚ´%À^1S7Ê¬†\ês;²H´ø®¥\ØT<‡8=ûJöw\ÖL$³(\å~ü\ä3cDò˜\ã9§’:ƒ]F-Ÿˆ4U–A¶\å\×e\ê¯¿Ò¸\êV4¤õ‰\Ë[I]ö³,ðù‰¡n<\È\ä¡þ¢†W2ª\Ë!PÇ‚¿\ÅT5y£\ê¸\éø«/øU«‹}RÐ´,#™Z<ô÷¢µU«SJP—»÷›Â¤š\ì\ËWv‚x\Äq8\0õ-Öµ¼3gcj $fX¹\ëXVw\Í\åJÊ¯Ø“€kR\Å$“LÜƒ‘ŽA®˜æœºVü\ÍaŒiò\ËC½ðú]~Í¨\ÞAƒü¶?o¾Ÿtð²ÿ\0h\È\Â@7n\0“øõ…yþ‘­j\Z| \Él“D;x5\ÖXx\ãF(¢\â9 lrWdqY~\"6vüŽºx©o	’\Å\áJRTjó¸•Ànmx\áð–q.£}<\çý·&¬øo\ÄZ\rüŠ–\×\Ñ\ï<mcƒ]Æ•e\\¡®º4¨oM+y\Z\ËQ\ï\"\rÁ¶\×O‰¤#\ÙHú\×U¤\ÙZ\ØÀ\"¶\"A\ÑUqUm\Ûh\Æj\ÔRž6ó]ÐŠŽ\Æœ¤õf‚°\Ç\Óô©#ËU[ei\ÆNjô’Cc™!±ž{WDcs	2fx¬\á3LÀcÖ²\Ä\ß9Ú®Fx<Vn­¨\Ëw),p€ð¿\Ô\Õ\ÇþEt\Æ)\"ª‰\Ã\ÇQNÝŽýj3Ê‘žGJEl­ka5xOü\á\Õÿ\0Žþ‹½\n\ÓX½\Öôk…kK=1\Îë„‘•eƒï€ 7|c\Ü×º)È¥k:´\ÕH8> \Õ\Ï\Ì?~\Ê|A§½õ·„¯t\á7Eª<vòMÿ\0\\Õ˜~ z\á|Aðÿ\0U\Ð> \ê\Þñ!I\Ôt”’K“r\ÙET\Ìe\ÎKŒ\ÆrX\nývqš\á¾?ø<{ð‹ÄžµKxu\r^À\Å\Ã È¤<a›\ÚYc^U\\­(^2wF¢š\Ñ\ê~NZ\é+¨j0\ÛÆ»ZwX\Ð0\èX€3ù\×Ò¾2øªx{Ã\ácnò\Û\ÇÅ¸Uá›©oûëš±ûþÏž(\Õ~)A\â?\Zxz\çNÐ¼?t]£½C^]Dp±¢žY\ÆY¾\éÛœ\×\Ü\Úe­\Ã9š‘\\ü\Ê\Ãõ–:´œ§§a\ÑM^\ç\ä‹<¯xU\êö\ê«+”G·GòÈ¨b>U®ò›‡\ÝV\Ï~Æ¿H>6ü\Ð<e¡\\\Ã÷£%W†V\ìG¡ðÿ\0Æ¯„\Ú\ï\Ãu\Åð3ZI1H\îW 0\è½qcpõ)=V†\é5ª\Øòj`[`~ˆZ\É\ï\ãÒ­^‡7L\0\Éfýi¶j¦P®B‡\à9þ\ï\í]4Ò„44„Tbužñ\Ä\ÐE§ß¶\æ_–)ˆûø\ìO­n\ê6²O¦¼\Öÿ\01ˆe\ÔHÿ\0\ëW`­c~\Ñ]\Û7˜911\Æ\ïF‘\Ùøú9X\Ä\Ó\É\r\È\Ï#?Ò¸qR–\Ãæ¾Œ\Æ\Ó$Ax%\'\nñ¬x\È\ÆE_Ž2\à\È\Ï\\÷­o\è†.ú\ÞûB9E\0+\ÇÖ±%·“O¹Ê†’)¢8\ÆO·Ò¸j%vº“\ÏmüŒ¸ù[¶jßZ\æN{xËˆ\åŒ\î+\Õ=\r\Z Kh/!a¸MÉ‘\Ó\Z±\á\Û\î<\É “\Ëe\0\\cÒ²”%8ºijËš\çI#¦¾´µ\Ôm\Ø\×\ÌDÀ#¨> ú\Z\ç\àð¼\ê\\Ú¼oµ²\Ê\ÙRW\ê:\×Y éšž¡,pÆ‘?y‹`Îº	j\Ó]5œöRAr±ˆ2\áeÿ\0tô5\æªX\ì>Š\ÏæŒ¹jCN‡›x‹Iò\î	…\\¡\ç\r\ÉO\Äuª\Þ2Y\ëkq#F“”·E?\á^¯¤øp\ê—k¥\\B°\ÝJv©q°\î\íYþ7ð¡,c’\ÅR\êÔ€.#S\ÈôlWN§µ¤\å(\é·üd\ÓWf`Šw“É‰RF½nø+\ÃZ\ì\×ñ\Í6iua¹dnÕ…\á(¯\ì\ï›E½µqueŒoOZ÷ßƒš-\ÅÝª\ÊU¼±\ÎH¯C•aªIN-§M%(–l~\èB¯ý—\n¹\ÇÌ«‚+r\Ë\ÃðiÑ±·B7u\É\ÍvV¶1ELcŽ\Ã9¨d…I*k\ê!‡„>W5\ÎE\í\Ü7Ëœt\äU›y˜ð„û\â·M”nÜŽ:R]4ø’7cZÆ›¸9šD±ƒs\à6?*\çu[\én¦%˜\í\Ï›«\Þ=ä¥· ð=k9\ä›·¨\Ít\Æ)\"mriž½©7û\Ô+.òAŽ\âœcÿ\0­Ut;W#\ä¤<7ùª\Ö2»[üš³ \Ê;WCVd&I*i\Êr>”\Ä\ÈQ\ïKšÍ \åi}i¹\Å;<f€!™I<\ä\â¢d\äüµe©‡4Ó°\Ó,«.\è\Î}:\×!ñ“À\ÚW\Ä/\ê¾»+kqjñEq·„~ª\Ç\Ôn#\Ó5\ÞJ¼\çªDLgj\äú\ÔÔ§\Z‘q’Ñ‡‘ù]ûD|×¾xº\ÛC\Ögµš\æ\â\ÍnÑ­CŠ–`B³¸‚¼ñÞ¼Õ­zUþPN=«õ\â‚´ˆ^¸ðÿ\0Št\è\'ó!x­/ü•k›l|ñ1\ä…$gµò7‡¿d/]ø\Æþ\×V³³þÈ³r‚õ.€ûr\ã\åhe‡l\ç9\×\Ï\×\Â×£R\ÑNI\í\å\êb\à\Ó\Óc\Çþ[\Û\êZ2h\'\Ð\æ‘\à]\ÐN\ès³<mq\È\ë\ë[šGÃˆ,u!weªJa<§ˆ·\Óp\Ç\ç^ß©ü3¿ð~Ÿ˜RgKt­(=N+Ÿ¹±’2C&1\×Ú³t´÷\Í-v\ëA†óI’\Æ|m•6\î•=ˆú\Z¥¨øN\ì\Ö\0»•T*\çªñŒƒÚº¡\Ã\Ç4õ\éQ:•\Û@\á\Ü\å4¯²øq4«Ð¤®\á‘\Î$ƒV|=\áht\ÛDŒ	%\Ï~k¤U\â \çÇ­(Ò„l\íªV\Z¶*hZp·\Ôc‘N>j÷¿\Ã\Új!\Ø3Ú¼V\"¡ƒt \æ½3á†¬»\"\Üýk¶…D†\Ù\ÝI\áý&òò‹‹y\'¶pð\È\È7#†µ\ì´M>$“ý?\Þò\ä¨;¾µZÜ¤€H>÷¯¥_‰\Û9ö®¨¥w¢\ÔN\Ö\Ð\Âñü1©]\Ãsq¦\Â\Ó[c.ü»VŽŸamaj-\íaX£^Š¢®7­5\Çq§¶\Ò\Ü\Ä\×&«J™lŽ•m\Ç\à*)ŠG‘\Îy«N\êDµ„\Ë!\à}\Ñ\ë\\–³s%\ìÄ–;}*î·¨5\Õ\É8>Xû¢³\ßct8ö5Ð \íp(K¦jCŠ\ÑdQ\ÎG\âj­À[ƒ“\è)Ø«Ü¬±±<\n”[\Ü\à|‚¥´†i\ßj)\×ÿ\0¯Z«¥Ï´~ýºzSJÀ\ä{ùù.8\Ý\×Ùªü¹9<Š\Ì\ë9Ï¨­P<\Åã¨­¥±	\èÔ§Ö¤AH\0\ÙÒ²¹|£A\î)\Ë\È\ÆicoAJ@Bw´\Z\Ü\Ò`Óˆ”\å´#\Æ\rE4J\ÊA\éVE&¥4\É0u\0~ej†\Í3´6\èEnÝ°ð+2@<\ÑÀ\ëZ\'tMoL°Õ­M¾¥l®p\àr+\È~$|$’%{­-|Ø -{”ª¾WAùS4€\r\Ó!\0©©\èx®jô!%r¢\ìÏ‹µý\æ\ÂfŽhr+¢+\Û5ô—\Ç;KQ+m8<ùb¼#XŠ!;\â4„W‰R*2hÑ®¦?\ç4¡\È `š³\"&GÈ¿•#¢t~U‹Ð—C“Ž†¶¼~\Ö\×\ë–À&³Qtuô§\éÊ¢\é0\0ù½*Tšz•X÷Ÿ^,öˆsÚ·\á;–¸O‡<ÚŒóÒ»˜\0\ÇJõ)Nñ3jÄ¹9P\Ø±§D˜8¦¸•µÁ\"$œ\×;\â]CÍ“\ìÑœF¿|úŸJè®¸³”Ž\Ú\ã¥\0Û‚@\Écž+ZJò¬UrŒ¼0?J­0$Ž¹}\éó\09\0ÂŸ\0Œýk¯˜,gÊ­œ(\ç8«Vv‰Ï†?N=U~\Ð>Q\×Ò´mU|Ïº:ŽÕœ¥¨5bÎ•d²òTV°Ó¸\ê)4µP8P:v­bz\nW$ÿ\Ù'),(14,'5847399c49feb','ÿ\Øÿ\à\0JFIF\0\0`\0`\0\0ÿ\Û\0C\0		\r\r\r\r\Zÿ\Û\0C\n\nÿÀ\0\0ú\0ú\"\0ÿ\Ä\0\0\0\0\0\0\0\0\0\0\0	\nÿ\Ä\0µ\0\0\0}\0!1AQa\"q2‘¡#B±ÁR\Ñð$3br‚	\n\Z%&\'()*456789:CDEFGHIJSTUVWXYZcdefghijstuvwxyzƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹º\Â\Ã\Ä\Å\Æ\Ç\È\É\Ê\Ò\Ó\Ô\Õ\Ö\×\Ø\Ù\Ú\á\â\ã\ä\å\æ\ç\è\é\êñòóôõö÷øùúÿ\Ä\0\0\0\0\0\0\0\0	\nÿ\Ä\0µ\0\0w\0!1AQaq\"2B‘¡±Á	#3Rðbr\Ñ\n$4\á%ñ\Z&\'()*56789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz‚ƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹º\Â\Ã\Ä\Å\Æ\Ç\È\É\Ê\Ò\Ó\Ô\Õ\Ö\×\Ø\Ù\Ú\â\ã\ä\å\æ\ç\è\é\êòóôõö÷øùúÿ\Ú\0\0\0?\0øE\'¸+´\Î0\ç«8\\Ü•\Ý\ç\ÌOýu?\ãPõ\î:Ð™\Õ’ù÷ÿ\0‰†?\é«*]\\sûù¹ÿ\0¦þ5b+}irF…\0Hg¹^—3g\Ó\Ìoñ \\\\\ãþ>f\äôó[üi™OPÆšGPM	\r\Å\Ï9¹›\Û7øÒ‹‹Œ`\ÜL=?x\ß\ãQq\Ð\æ\Ê\àŽ;P\Í\Å\Èññ?ýýoñ¦y÷Éº›þþ7ø\ÐÞ¦˜¾\ä\Ð†{ƒƒö™ÿ\0\ï\ã#Os\Ð\\\Ì?\í£4“ƒŽ\é£;±\ë@}¢\à\Ë\Ìü\ÓVÿ\0\ZS=Á^.&\ëÿ\0=Oø\Ô]úÑ–\äc¥\08\Ü\Ü\Ï\Ìü\ÓVÿ\0\ZU¹¸?òñ7ýüoñ¦cŒž”\åÁ\ÇJ\0z\Ït\Ä\â\âsúh\ß\ãH..G[‰±ÿ\0][üi¿pœ\ÏZE`ü\í@}¦\ã\0ý¦lújÆœng´\Íÿ\0üi…@@ t¨Õ”œ\Ì\Ð¤ž\àœ›‰¿\ï\áÿ\0\Zd—*ü\\Mú\ê\ß\ãB‘\Å2S“€h\Æ\ê\äÿ\0\Ë\Ì\Ãþ\Ú7øÒ‰\î3Ÿ´Oú\ê\ß\ãP`“‚hrI\ãµ\0L.g›™‡ýµoñ¡®®:™³ÿ\0][üj-À\çŸzPNÞ‚˜ûUÀ\0‰²?\é£i¸ÿ\0žóóÿ\0Müj 22)\Ù\'ŒI \×7\0d\\O\Çý4oñ¥7XÈ¸›þþñ¨\É\Ï9\ëH\Ø\ìhQqr\Ùÿ\0J˜ú\è\ß\ãKö‹ùù›þþ7ø\Ô9$t\ãµ£P\áòƒNALRr1Ÿ­(bƒ“š\0•Y‡\Þ\\\Óz[ô¤BÁ²zc¥8cH$\Ð\ÅpS?JB®=)W ðM(\Ës@Á\Ü~^;S\ã3\Å”pGÿ\0ZŸV€\Z\àb£\Üwcõ©X~u=M\0;O=)½0j@Ú˜¾ý©\ì\0‘Žô\Ôž\Ôò\Ã#© ži\0\åÁ4Àlw©m\ã–i\Ò(bi$…DE,\Ì\Ä\à\0RM2Eh\çdu*\Êp\êF\nž\àŽÆ€\02{š\0ót©|Á\â˜AM\0<±8\Ç‘<ŠU#s`v¦¼ps\ï@¦ð¦L0ribcŠY\08\æ˜ ñIž~U\ëJü\ã4€\ã§R\0`\ÜcÚ•Uº’8£$\äž}(\Ï9\â€\äsž´ƒÉ§u¤%²Ü@\à:Ž¦”·¥4d0þT8\ç­\09[Ž´dzÎš1Ž\äw£)ý\Ê\0>”¹8¤\É\ëŠ^s@8úõ¥]\Ý3Šj’ZQŒPòX…\'\0{S™{8\íM\ã€Žph\Û<N@pz\ÓCƒŽÞ´\äa»ƒ@\n\Ù\ïÒµ|!\ámw\Å3\ÜA\áý6MB\â\Ù’A¯™´œeT[ž¸\Î*o‡É§I\ã½!5T†[\'¼Ež9ÿ\0Õº“Ñ¹+\é#Iðƒõ›xt«!¤jQK››«‹q’<| \ÎG¾k\ÃÎ³Ÿ\ì\ê~\ì¦Öšió8±xµA$•\Ûû˜´ÿ\0jòxº\ÛÃ—–’i—\×\"\Ûmüm\É\ÇÍ‘FO5\ê¾ýµ›SM¼\×u6\çG»–H\çþÌº/,n”\r•ÀŒúqšúS\\ðÎ‘\ãHlu‰V\ÇU—KŒ\Éc0ù´\àƒ»nq\È|ÀŒ…8\ã#\Ïl¯ÿ\0°¼M%­”\ÆKi[|a9\é\ìAñ•x\Ó\Ãÿ\0²%	¤Ô“\Ö\Ï]ž–î®¾óÏ¯šN\ÉCKÿ\0ZûA|ñ\'Â‹\Í:]Q^}3Wˆ½\ÛB\Ñ2°$¤C÷\\m\'‚A#\Ðp\Z,štz\Ä\r«Cq-ˆ“ý\";ir2÷\Ú\Ä\àkô\ãŸwñöb\Ô<9r\ÂOAn/4x§#|\Ò\Â\ç!ó¹Àu\Çrkó\ÊUh\å*\ê\È\è\Û]X`©`ŽÆ¾\Ó#\Ì\Öc„\æo\ÞZ;~~G¯B§´¦Ï¤|\áOÍ­\ézÏ…4\Ù ½XvA™\å1[…f9\0#\ÃWIÿ\0?…u?Zxƒ\Ä\ZMµ\Ü\ÚtR;\Å\"\0—¬~\è—û\äO={\×	û+kZ}¶Ž-4³ws¯\Å>N\ê#±ûµ\î:d“\Ã˜\ëô\ámJ\ãÌ²»m¥Ps\æ8\àœ\Ù\Î÷¯Í³üf+Œœ%ZZiv\Ý\ì÷ó¶»ÿ\0’>o\í\á]®f\Ú\Ó\ä|™ûK\É`|Sd¶\Z}ŽŸ”\ç\ìöv©\nò\ÝHP2N;úW™¹ý\ïCƒ_O|^øh\Þ\Õ|a¨ø\Îñ!®R\0¿¸h\Ô\Ü 9\é‡=Onk\ç\Ý+Q·Ñ­uk‹á±½’H­®0’:AõW\è|9™a1x(ÆNgu·}÷\Òûúùö\ni\ÑQ\æ»[”{gô¤û¤ÒŽ2\äRrX\äWÐƒÕŽaÚ‡lòF+\Öÿ\0f€šÿ\0Å·¼Ôš\ì¿\éÄ¥Î§)L¸Ï–™\ê@9lZ§ñW\á=\æ—\â™-<cª\ê\Ú\\6û\Ý\ÎÀÒ²’\×[U\å±\ë\\r\Ì0±¬\è\ÊiI}\ß~\ÆR­N3\än\Ìò\â?\nn\Õ-\îi\Î$eu`À\à«i3Ž@5\Øj&Àœšw$\0!\ÜNx¤ƒ‚\Ô\0\íÃ¹?…9‰$`ðj<\Ø\r\Å\0…<\ä\Ð\0\Ã\æ#µ*óFFOQ×¥\0&n(Ç¿\éHO½½\0\ã•&\Ð:ŒS@\êGJ\0\0\È\æ€0(Á\ëJ8 \Æ@\Å8.zW¸þ\É^ø!\ã½jx\â/Å¬\ÈQ§NüõP#Ü„19=júÅ¿ðO+\Ç7>øƒyeË¾;McMó=de?š\æ¸þ½KÚºN÷^]ÿ\0B9\×7)ðzŒu^i\ËÁ\é_Eø\ëö&øß \ÜÊšUž\âE„uÓ¯\Õ&P{˜\å\ÚG\ækÅµOø\×Lñ\rÖ‰¨xWVƒQ³p—\Íh\Å\ã\'9Z\Ú\éTW„“)j}û;|\Zøy\â?\0\Úø“N\Ôo¯šñw\â\Í ”\0$„¢±\Ùór¤d• “\Î°k\í—\Ãii£#ý\0†K\Å;¢û¹+÷}y\'\ì¥\â¯|0ð\Ô`\ëxŠ\à4z‹\î\âM\Äyf3\Ï\ËÀýq\Í}®\èþ(ñ––\Ìóÿ\0dÚ¿*ŽHs\Ç~•ð9\Î!Õ¯8\ê\ìô\Ðð««Õ•\Ûn\ç\Î\í}­xXû=ü1\Åt<\Ó\ä|\Ë2\ç{\Ó*q\é\Ívž-ñO‚¼G\áXd–\Ê\×\í‹\"&\Ùa~¤†¤\äûš£­x.x¦;­:OCy•òã‰¾Rx\Þ  óŒŒ\â¼\ë\âw‡¤Ð¼EsQ½²g+\'!{u¯–«\Ã\âk\Âm¸\ÍuZ_\É÷<\É\Þ\î\'µ|¹\Ó59l4K\Ý^#\ì$—+[ó¹\'ŽyÁõ=*ÿ\0Å¯‡?`ø‡«]\Ç\á=:ñ¯\í³s|¥\äó”‰\É\Ú¹e\0’sœ\×\Îz&¤öŽ†H\çsšH[9\ã õ¯A\Ñ|U}©XE¦\Æ\ì\ì¬v\Ë\"\È\çŽõ|&\'ª}Zn<\í^I´\ìº]t¾¬Òž\"t¡È·\ïú{¢ü,¾øy\ãˆ|SgzŸb’úA§\Ç\æ‰ÖŒ0À\åd\ÉJ÷HüMy­<_i‰l‘ ò\äU$»\ãœd÷\Íy¿f¹\ÓukKJK‹+°“Ÿ\0\Æ\èÀGn\Ï|UŸˆZ\Ìúe§—½Vg!\ÞFƒ\è=O­^b«fr£:\íJm4­¢òþµ.¥j•¬\äb\ÙMª\ëú\ç\Úm’d¶’å£‰\î\Ê\áO-‚s´{ú\Ô\ß|G4~›\Ã\Ð\Í\ìö±\Ê\Ål³Fò¶yU*r\Ç=qœó\\ü:\Í\Ý\Í\Å\Ónb	q.öPA;D\'\0d•\Å\Ú|p¾¶\Ô\Ö÷þ«9^\0#·S+*Âªxh\äÿ\0´rk\è0¹^\"µhÔ£Nê®–¾¯\æ*j“Ÿ5$ô·S\ÊÀ\Ãm+ƒœ{W«~ÌŸ/>(øƒíš¶ 4	YK·P\Ö%\ÞÃŸ&ý\éür{oöSøL¿~)\\>§ö‹M\Þc5Ø‰ó$\Î\ÌYmÑ9#9ld\êE}[ñGá¶­¥\ßiº·v:o„--¥–’\Û~\Í>ð\Ã7rrrsšú¼\ï<xXÊ•\ï­\ßH\ßó~G\Ñb+ºq¼U\Ùo\Å:ß€´†zw…´-f\ÏK\Ð-\ä6Öºn—‘rs$\î\Ä$òx‰\äö¯(ø³ñVž6\Ñü\Z<<Œ„þÙ›Oó%\ìÆŒ6®?½†öªPhSXjz•ðÕ´\ËýN•¢¶½(¡¯r~U	žô8\èA5‘ñg\Æ\Ú÷ÃÚˆ&²¶»\Ô\ÃIaü#\Ë³<˜bFG µñ8jU\ëcW+\ç›\ïµû½Ë¾‡	Ô¯Q]k÷ÿ\0Hù\Ï\Æö\ZÖ—\â[«¬\ß\Ú2?4“d´ûùz†\ÎsY»\Õ\ß\êwš\î½w«\ß\í7W³4²\ìP\Ä\ä\àd\à{U\0<\×\ëÔ”6ýl}oep\Ï^84€Œ\ç\ïoÒ‘«¤ñÀ¤##úP­\'µ\0;Þœ6…\â£Ri\Ø\"€{bœq\ÔR)ƒŒô 	6ç¸¤dP½~´Œ[$\0\Ô\ìzúš\0“\ÉO²	 ¹8\ÙÞ¡e \ã½9J\È8÷¥Á#\×ú\Ð[ð[\â_‰þx¯þ?\n›!~j\È<\è\Ðÿ\0x!!K`	8Áæ¾žøgûEüAñ¶‰>­\ãˆ—‹A\æK\áÿ\0\Çýš<¼\à›¥M\ã\'?$l>PN\î\Õñ \\¹\'~•ïŸ²ÿ\0ƒ&O\r\Ý\ë\Úülºu\îÖ±³\'eÿ\0–Ì½\nö_^Mx<AR–:\Î\\²\Ó\Õù/;Ã£»-\Éñ9®%a°\ÚIõì»³\í\rü`øm\à_\èÖ—š<\Ö\Ój±-ó\ÛZ@\Ï\ïošO5Ü´¤x’N:\×w­\ÜxŸ_\Óm¯|+¢hRi\×*&¶ûe»EtRUÀ\Èö\é_$|Vñšï„’)\ÖÍ®tõó!¸{uó6*‘\åo\06\Ó\Øg+­ý›¾?x\ç\Ä~)\Ðüqyfý\ÒÛµ\íâ´’ÆI\ãn8\0÷\Å|^,e¥Ì“\Ò\ê\Ê_o™\\G‘c2<R¡^^\ì•\ã%»\ï?‘\è~#øU\ã]KT’\î_‡^½y>sy$°\Ç1~Í¹b\È#{\nw…~üB\Ónb\ÕZÿ\0\Ãze\Ì,\Æ‚K\É\×¨`òl?]µ\ë.ñ(\Ñle¹’\ç|ÿ\0)202»z\àq^;¯þ\Ð&\äKg gŒ•O\Ý\0:ýN=8¨­K‡NS“]\ä\ß\æô>zt)^ó“oÌ»\â½\Æ^\Ó.¼G«ø§E&\Ö&\Ùp–Ò¼™#\à€>µ\å\ÖZ%—Œ¼,5¿x’\Ùc=®|¸·&y#w$nrOJg‹üI¯üO\Õ\ãðåž¡\ZipF³\ßNXG\å¦y@OWn€sù\n\Èø¥ð\Ç\Âq\èSZÁ¡YA\è\â‹JŽ\á\ß\æ\'sN\Ìdc\ì°¯\"sÀR«98¹l­)?]/o»SÎ¯NŸ2Q\Ù¿ˆô\ß\Ãwºí†¦’\Ø\Û(YUšYXø\é’;ö²þh~\'ñÎµm§\éð\Øé–¡¶µ\Ì6\Ï)OrA,\íù~ï‡–>ð¥øñ>±\æj:l‘ZZoÂõ¤ÁTžw“ž=kgAý <[¢Öš,:&‡jg`¢\Ê\ÅVl9\Æ‡$ñŒµz±¥5	F¾\×Ú’µ¼­\ÝÒ…%\'wsÆ¿	|Ig%\ì·Q\Éaa+\"_\Î>iAH±›§ny\ïU­¾\é~.ðüÁ®\êð\êv‰·\Ì3¦\è\Ó¬¤t÷\ã×½{\'€üF\Ú\îýKL{K\ËqlRWMÁÔ€7\'9c“\ÇÍžµ\ÌZ\ëR\è>2º³[{ˆ\"\é\å3F\é\ÏBQ•Á\È&¼j8\ÜD*6Õ”[¶šzÿ\0Z\Zò¦ù“>`ñ\'Â¿ˆºÌ’xkÄ²_Ge¥­\å\'ý’\Ãc~+Ê¼3\ág\Ä.ƒÃ¶VS­üól‘2<œ™˜vœ\×\é6¼©u\àý@\Ü\ê:Í²\ÄXM` #¡s“Šù—\Ä~0ñ\Ö\î´/†þ¿\Ôu³¶º\Ô\î­X€7\ã\å†!~l\à\ç5öY~}©N\æ\×Å¤R}\äÖ–ü^Ç£„•yI\Â0½ú¥o¼ô¿\r|o\á¿\èñx:\Æ\Åt\ËKwÉ½˜ª\Ë#ºW\Úw3’3À\0\0\0\àV7\í\Ûmñx‹Aƒ\Ä~!¸\Ó4\Ãi$0Kh¨#•\Ãnb\è¬]	\Èc\È\0ú\×-¤j?´\ï…r\Úk\×\ÖZ\Ü\Z¾Öš\ÞFŒÂžY\ÎB\ã\Üpõ«^ð÷‚µ»Cyñ7YÖ¬\ï%;`Ô¡•§iH\êX7Þ¼\ÊQ«C\êb¤¥$Úº÷¯\çm®†Uù\èO–¢wó\Ûñ8½6ûTð^“`\×~7\Óõ!$¥­´Õ‚–Jÿ\0­pW\å\ë\Æ[98«<A\âoø\îy-\î¼Ik§&c¸¼·\\\é\ÊÁCº\"ƒŽ€uÀ\ë]^«ð­t‡þ\Ûøg¨Ã¯ZJËª\éI#>	hlm=w 0k[@ø‡ñ\á\æ»‡\ÄO[\ÞG)VµI­uR½cTPòžü\×o´\äš\ÄÑ‚›N\îÖ‹}ô²üõ0Ô•T´]mþGÊ–>ñMöŸ5ýŸ‡ui¬\í£if¹[)<¨\ÑFK\Æ\0Þ±™;þF¿E¼Kñ‹@ñN…Ž¾¶·´»¡¸»\í\Èa‚ž€ýk\ä_\ÚW@ðv‡¨µ®\á«\í\'P–b\é*]±–,¸‡,O¨\ìe\\Nñ\Ø\ÙaeEÇªk]:\Þöz>Éž,\\gS‘DS9æ§sRù½\Ð# O5õ§Y\ÑÞž i\Å1\Í4‚:RY:`ƒBó\Çzo~)Àžø\ç­\0¤·›\Úu\01Ö˜rŒcñ¨ò7r?\n™He\ç?!…>ð8¡¡3.~\í(a\ÔpSN)µI,+Ù¿d„³ø\ã\Ärø£T„\èR˜È™[¹±‘\ZŽŒ›\Ó\å­sbñ4ð´%Z¦\ÉX<-L]xÐ§»þ®l~\Î?n\ì®\×\Æ7Ñ• Š4—K²¹\Ú\Âfa‘#¦O\0`…n\ç‘Ò»ÿ\0\ë„\Z q…\à\è+£ø“¯\r\îc?»q3\Ðv\Íx¿ŒµfYX³úóšüžXœNu‹öõ¾‹¢GôG”a2<\×\Å\Õõe\Ë\Ù\î5µš\Â¤™¶\ïÂœ`dý½sð]]øoÄ£\Þ\Ïgq©:Kk‘$NT©\ë‘×Š\å\×\Ä\×š\ìwÖ—e~\Î\à”\ê%\ä‘k\'R\×5}[\\’þiEÄ¹%cgû£=\0¯°\ÂdóŒ\Ù?\ÌüŸñx\\\Û\í#ñ\Æ\ÑO£Z¿\ÔúNó\Ç\ÚÖ±§¬2kó^#+#ÍžNzƒ\ïX,\ÔWM\Ñ\àŽ-4\ä E<\äð\0\ãþñ>©i}$6¬#ûLÁ\Ì3.vöÂ“\Ðtü«WUÖµ\äÕ…\ÄðE;¨1\"2Q‘†8\ìqß¨\ìEyò\ÈeN­š\ÜøH\à+It=;C·¿þÁþ \ÓkvýÍ­ˆ=NKn7°\ã\æ\ät\0ð+™ñ‰õ)­Gi\Ì\Ã\Ì\Ë7_Â¯x\ÃZ—ˆ?\âcš\Ú>“ü|]J\å”c\ïl$dûk¥ð¯…\í|_\ã˜\"T•t«gH\ÞVQ¸ ?ÅŽpx\Ç,<i\×u*\Åwµ¶<gAûF\å¿dy±Ô®†‚\És\ç\\\Î$\Â	*ˆ\0søŽÂª\\\ê1EÖ–n¤8dq¸(\Ç\\ÿ\0Jõß‹^²\Ö<U&\á€\Ö\ß÷j\r¢\Õ@‡\\žI=\ÎkŽ\Òþ\\Í«­±Q™	X\É\î\Ø\Î\Ð}p	\Ç|\ZÚ–\"‹‹”•·Ð˜ÒŒ\Ú;Ù\Æ7šj2*3<—±L\Ðo\Èx¼·Rƒ\Ódö\ì^-	}¦[jÖ¶\×Ye¯\Ú2¬OVp ñ\É\È\ê=+À£I>ø²\Ú\ã\\\Ó\'š+ˆdQl’2€W\Ø8cÛ¯¥{—|Ocñ\ÂvöšL^-ÁXÊ¥£@¯€Ç¦\áµy\ã9¯#0\ÃÔ”½ªøekz\íø“U%Y\Ç\Ýv_=¿C‘¾»\Z…¼º•“^i\×\ÈƒFdˆ·R\ZE\Æ\ßmËzô†²G®è‹«xŠ®.¦im^	—“°\0þaû †$0\èqÚ¼³\Ç6ž&\ÐõHõ-\æK;Ûˆ˜³Ë±\'•8aŽ@ÿ\0\nµ\à/jGÃ­a¯y‡QžQ$1-1“\0m+ž‚z\äzV˜J\Ã8\ÎKO=¾\î¿3\ê¸cVqxT´uMuõGu\á¿\nK\â{\ÛMVò\æKx.È¶’Dp\n\0T˜}\ç\ÚT\r£\0’+ñOƒ\ìo!O[\É\"DIH­ld\Äc\Ü\ç>õ\è[«M:Yµ}SÈ´º‰DXüÕˆ\Ü- ©Á\éÓ¾>©¦\Ém{º\Â\åIX\Äcº¶h¤:+Àg#Óž+×­€”a\ZÓ½Ÿ\Ü}4\Õ,Kp­+mu÷›|%‹M\Ò5”¿¼šó\å\Ñ\ÚþFž/N\íB‚Jò8\Îy­kún«K3i·íµ–\ãK`&Ž\Ý\ÉÛ¸/![Œ“œœ\Ýx«\ëk\ÍDa\rµ\ÌReˆ§•:pw@Á\é\ïSiW\ÃNŽ+\Éô› ¹]\ã\ÞA\è72	\Ç÷¦\Ü%G‘>Y>÷þ¯øy\n–7u\ã\Ñ$—ô¿^_\rÀu·\Ó4=M¿\Ñõ‘ù\î«°0\\¾õ.3œI\ÇL\×\Í_¶/Á¹ôV\çÅºK\Í,T\Ü[F˜\0 c ó\Ôö¯¡~#&­i¡Yø‡Á÷\Ñ\ÝK¨\Æbž‘\í\\®A\Ï³\\ˆ|S«N‘\Úø¢ö\rOÌ¬\ã„ÀG_©\Ï\Éü©\àdòú®¢¦\Õý,×—_ò\n¹ns•=®•¥;h|Z\ê\0\Ü2GjŒ‚{\Öö©¡\Þ[ø†ÿ\0I‚\Î\æsgrñnHY²ª\\iwVRl»¶šô\ÆWù\×\ßF¤%k3\â¥J¤ou±“\Êü­Þ–T8\éW¦ET\"\Ü}E2)¡e*\ÉÏ§¥]Œ\ÌõPs\íF1Û­hì›\î\í’[Xc;‰8#Š,3T©\ãjOø©¤·…Ÿ÷RŒ÷©>\Å/b(°\\…[€	ü\éK*¡\ë_M|)ý‹<¯n¼Uym ÚœúÉˆþB¾–ø[û(ü(ðrGqs¦l]\Æ7\ïŽ\á‘\ßoA^ulÎ…5£»ò\Z\Ôøoösøw¬ø›\Ä\ãY}*V\Ò4¥ó\åžd+¾@D¹\Ï<g¥}5¡\Ü\\\èþM\"KÁ%–g ¹v\É\0{Wq\â-gM]:\î\ËK‚{i.\ä1$1„\Â`\ÛB×“ø\ãRû-¹&Aód{\nü»;\Î+fõý”©«i\æ~\å\ÂY,N¤xõ»þº÷õ\0\É$…¸Bs\ì1\Ï5\áž%\Ô\çÖµ‡³†`‘Ž¬\Ün­/Š>2’ò\áô\ëI7)8‘×¹ô¬­*\ß\ì–l\ác‘¥P%BAÀúõö9Rðô•J‹^ˆð¸¯ˆ\ÕZ†–‹\âkò_©V=9!\ÊY˜’9\ëTž\ËÎ»Œ\"˜¦S\çî·¥t6‘,\Î\Ó\ØÃ¶H˜|\Ù_o\ê)u&\Úfócý\Ù`ƒ\'°ô<\î\'\çÒ§\í‘ƒamyq©\Å\Ã:6w¨Á Wu¢Gu\â\r*[³¶¹]ÀðIþ5CB´ž;;«ø£Qpbs—uóüÿ\0JŸÀ—¶\Ñi2À’ºK \É\0õ {W-yóÇ™©r>S¶\Ôü\â{\ßZhN‘iúd	k~Jª E\0± “\Ô\ç©5±ðG\âE—…¯ž\ßY\Òå¼³\Ôñ$w‘ÿ\0¬¶m¸hûÀ8Œ÷®j\Úh.`þ\ÏQ\åGx€H@\0ð8Ï¦O8\ãµOö›–W@/‘…J\ãþð\îø\×ZwM©\Æ\âyE\Z÷´R¹\Ñü-½øyªøŠ\ë\Ã:]½Î£¬[K3Ø°P–1§?h.\Ä\"ðA8$\ÖÍŠøÁ~´\Ô<h\Ñ\ëúÆ«3™¢š}ð½\ì\Ç±\Ïõ\Ä^Ynš\Â8¢\r•#Ä›7 \0\ã\Î9\Ï5\Äø£\Ä\ZŒ›\ï\åyQ\\º¡þ\Û·Z\Îü\ÒQ£>ý~Kü\Î\Ü>Q†\Ã/i$½?\àŸCxŸZøQ\â¿ZjWZO‘ub‚8tô»s•õcq,9%‹n\'=8â¸»\è\Þ7O\áE„·;‰	p\Î\ÄÛ´\Èüzó^,š£\È6—(¤q\Î\à;Æ®\é—ò\Ä\Û\íöŸŸ\Í\Î~ƒ·—Ô±.MÕ©u\Ú\É~Gkys§\É\nWü~ø-«i:n½dº¬Viú”Ê—a”@\åó³•Û’Bƒ–ƒŠö_Ÿƒöz\î£^X-\àsŒ¢/·_^:gs0”Hðo9\è:W\Éz[\êZ¦ˆ.\Ú\Þy--˜o¸T\Â!ð>Ÿ¥v¾øu\á’úŽŽö\Ï}\"\Ò\Úo(„‚\êñcŒöæº•«$”U¯½…O\í¯\È\Ú}“±ô~·\ã\Í\ÏAƒU]rý´«\"m\í,\'†\ÝfI’!„P2@\0\âª\Ãñúi\ì#K™‰€\ÎAÊ¢”M *\í\ä\Î3œú\×\Êú\çÄ›\Íc\Ä\Ð]j\ÒG8ŠI\ÙF\Ý\ã#õÁ§Yøª\Æmop‡\í%\rj7	 m9\ëÁ¬1œCþq¿¯ôŽˆe\Ôc¥MlzwŒ~3\r\Å\\}ž	–ò=\ßh0«\Éßœª°Á\à\Ï\çµg^|Uðüš§\Ú\ì,µ	m¸W¸o0\ã\' \Æwƒ91^%\ãI®Ÿ\ÄW\Ü³ü\Ü(öôúVDs\Ëk\Þc\ædgž¹\æ4£IE»õ\Ø\Ö0\í\ÞÖ·™ôo‡¼s \ÝÁ{u«]\Ïf\"ù\ãTÁÀ<‘Ö²<]«xU5Ø’\Ç]H¡\'‚\âóF ²\Æ\Ò	\ì:Šð\áx\×,\\N-‹\0#<)j³²¬\à\n©ad´¾ž}jU¢\Õõè±~\ê\Zv§i2Giš¾b\Ç\Ý\ÎI®A®›\Æ>ð7Š4¶Ó¼C¤E=»¼ùõƒ^uû2i\ÒXønn¯;L	ds1u1(\Ê\ÃrrkÑ–\×R‘’X¤“d„)u€µù¦2¿²\Ì\'*2\Õ>\×â²¡BU0±Wd\ÖÏ·\ä|‡ûB~\Ï\ZÇ‚#º\×ü5qý« ‡-\å*Ÿ´Z©<n\Ä÷…xÍ¾‘©\ê™m4Û©Bux\àf\ë_¦wºV­axbž\Ú@Ê®cû¤vúT:lZ&™¤J,ô8bDr&1\Ä\0ó1__„\ã,M\nNž.•\äº\ê´ûýO‰\Íøn„…—º÷¶«þ¡ù2\Í˜\æGFø”ŠQ<Œzô\í_f|{øy\áßˆšõ²Á\"iñ#þöh \0©=\È\Çøƒö-ñYh§ðßˆô\íJ\ÒnL²!\Ë_RzW\ÕeüG‚\ÆS\æ\æ³\í¹ò5ðu¨Ë–Hù ,\r¡B¾)žMÀ\ãqü\ë\ìþ\Ãw7–C\íþ.\Ûu³w\î`\Â`O&º¿a8Ä¦O^‡À\Ü>\Âx=\ë¯û_\Õ\Õß¢bXZ½¯dõ4\Ë\Ëc=œ\Ð\Úf‰7¡ Œþµhô\Å7“ÀÉ¯”SV\îagt|k\â9.ô)®4^7I­.\Z4%NHóŸCƒƒ^ñ\ç\â.\Ò\è\Úk±lbIW¢Ÿ@k\èø(_ôInCÐ­Ùµ»fû=õù%Qc>Jvfylq\ÓÖ¾\"\ÕÄ¢\è™NpÙ®<‡\éF»­Q\Ý-¼ü\Ï\Ññ\Ücˆ«—¨R,\å»ì¼½{ôüJQË‚þTRJO.UI#\Ü\×E\á˜\î\å´\È\ßû¬d\àm\Î3\Ï`\Øö8õ«:±\Ót\ß\í¹‘\ça†@\0\rœŒõ«{\ÂZcx“Xþ\Í_²\Ú\Í4$y²N!Rœ3`±¸¤Œ\×\Û9¦ùl|Li5\ï_R¶ˆ9\ÙÉ°\ÅÃ»2ð¨\ïô§\ë³E‰ Œ\ÂûÀH¸\å³×j\î~ ø.\ËÁ£M†\Î\ê;ù/!9D\Ú`sŒ\ç’2\Çd­s¶\Égc\×ú„Bynl\ÆøÀ\îlñúWz‰O’[³®Œy—<^\Æ^¡}\'•*ù\ËžM»8l/ #ÒŸ\ágŠ\ã_±±\Ó8\Ù\ä\Û;l\è3€*®-¤¿l\Ú\â\ÚF\Ù\Ë÷“\ßô¨-m>Ã¯\Ú\êvò°€Ë‰Hû\Êy\0S\ä\å¦\ÔX)~ñ9­:ž\âM?Ã¶1\Éfò\Íö\ì†wP\0p0;tŸ°¯<\Ö\î\ã—Rrn¡VÁ\ä\îÖ³õÿ\0­V{,€3pd\àúf±õnn·G6\î\ä\\T\èU“½C¾¦\"Œ\"£M\êh\Ü\ß]¨h£s\äg\å\ëø\Ó\0\ÉJ\çs}\å\Ç\n+GL¶‰´Ù®e HÍ‡€r8 þu“Ñ\Ù\ÙNø\È!\0\àw\ÅtS‚nñG5J¯K½¤q¤’0\Ï\ÎÀ†\ÏCK*ºIgPµ\'Ö¢[¤™¼øÁ\å	«S˜Ê‰HÛ¸\áNrGÖ®m¦U%M­N\Ë\Â~*–?\nJ³,jLˆ\ËÐƒ\Ôc§<dûW7|\×V\×/1†-\Ó\Ç8\âª\\j°s…T\\.\Õ\Çn¸¬Û‹­Ž\ï$®~@zšä§…|\Í\Ûs¶x\È\Å+\Z\î¡oñ”ùmV\ã…n¹\'Þ¡\Ó5«}=ÀC$Œ0£</°üj´ž#\Ö\ám\í„X\\8–X¶¼ö±œqT>Æ‰j&w ºž•\Õ\ZªzsÅµ.h\ZÉ¬\ÜK²9\\\å‹\ì)#»GÓ¥‹*[ƒ“\ÆNj‹j0\Çl-U 9F\0ö§\èvö·÷{d·—k€Œž\Ô*QŒ[j\É\í\ç9$µl|wn÷¦[É‰s·\æ¬\ÚjÑµù,K¬x\É#©>¢®_x]\ì\âÿ\0\ÎrŠ»‘—•\ç¶\ZÁ\Ë\Ér\ÆfPHö¥?e5\Íš«­YŸ]ü½3ü2\Ò\Â3+t.Xs\ÃŒc\ÜW¿ü&Ö¬%´š‰L¬@ \0±ž\0\äþ¦¾xý—\â–\ßá·•£\ÞÁto’iÃ¤+ÀI\Æ3œ‘ƒÓŽ‡5\ë\Ú>±·‰¤¶†þ5‚\å1³\Ã\Ç÷[h\ÈoB8\çšü¢­«f\Õ*Å«s?\Åùÿ\0Á\ÜýM\Ë\ë™U:rN\ê+ðGSª\ÊW\í&\âDo)\Êye¾bO9 cõ­…±X__]hºŠª¦ \Ã\'p\Ëü#\ê\éT|M¤µž‘k,¦Y$udŒ\0\ÃqLV>‘y>—ªZ\êCþ]d=\0<ñ[Æ¬¨\âµŽ\Úë®¿\Èó*a\ãŠÁN\Þÿ\0š\Ûñ=sHøS\á+Æ»†ÕŒ®Á™Ù¹&º‹mK¶O.4Œ.9^¹ú×Œ~\Ò_|S\á\Ùjž¶Yã»™CÍ‚YTŒ8Ï¯5À|1øý\âCÆš\\W2\Ã›4Š’‰‰o1Xá³ŽwÇŽ†¾º–7.\Ã\éJ•“\ë\Ðø¥•\ã\ë\Óu\\¶\é\Ôú\ÈAÀ‰\n\í;Q}•;,S’õ~\Îñ\ÊYVE\Æô8\àú\Z\Ï[\ëtP‹.F_µzu1T\ãkE~G•\ns}Jû}k˜ø\Ñ\â\Ëo|/\Ö<Qv\Åc±ƒ\å\Ú~r\ÌB¨_ö²xúWU´\\_\í\à\Øüsðw[\ÐØ•˜[5Õ«œK–‡\àY®	¯u\Ø\â¥\Ë\í#Íµ\Ï\Íˆ\Z\æ¡\â\r]nY\åŽÁ\îX¢9,7u,OV8\ë\\ð³y&	*Hm\Ë\Ðn>½«SS¹H£]ÌªÁ@Tw#i\Æ0Xð–© µ½Õ¾§\æ³L\Ã]yô ƒ\Î8ú\×\ÐR\åTâ¢¶=z‘Nv¾\ã|E¤i‹˜\Ó/¥»•m\Ã2ù;\Z$\ß\Ó=\êÏƒšCo%\ãB›asy\0r•dµ\Ù\Ú\×\ÌF…›l¨:ŒôcWuB[-\åÑ´ÁZQ³x\Æ@ÀTUrpiAAIH·y\ã;µ™¼É®\'*J¹l’\Þ\Ýðej:\Üö\Ïy\åa%;p½xõª]\Ù!å”“#H{	¿…Yž\Âfw»U€(A\Ãñ\Ë{s­J¥O™9jÈJ–÷,½\n1Lg&x]’L´œŒdp>œUˆ\r³@§\n\Ê\0\ØÄ¶;ñQ\Ä\çK\ÓXR \åx{\×/w¨\\\Ü^y¡aºÀj¤¥7hh/iEs\ërÖµ$3\ÜH¢-ù\êøûµ’mH‘ž5PˆG\0óZ\ÚBH·Iöˆ\ÕVv%H8ÿ\0\nÔ¹ðð”\â†d=#HÀ>µªœii&sTƒ«\ï$R[—\Zo”Ó°¡Jƒ÷©oî­¬\ì\ÉÜ<Ü²õ\ëTüE–\Ó$LJ\0û\ã\æ\æ±\Ìs«ù«œÖœ(©jž‚•w\r-©}\Ü<€£8vùˆ\Æ>k™\á‰<õI\à—\ÏOÿ\0]g:¸\\— À\è!Y\Õ\Ø\Ü\"ý\Ônükof›2U\ÚZ&Ô¥œ„€a³\Æ\ÑÖ£’)“\æb\Å\Ï8\0\ä\Z\Ñð–™&¯u$~Ê‘\ãq9cÀ]Ý³Úº9´8%\Ý¦\ê.	\ÜÞ€w÷5›p¦ì‹=Mn`ilÀ,~Q–Y9ÿ\0„zšÐ»º4q÷\éÔ“ÖŸq\Z9š\Ýd2H\Ã,ò`cžŸZ§o¬\Ã\â²\Ú,›A Œ¶8=øš\æi\Ê~\ê\Ð\éƒåŽ²3¢\Ó.%¼aY‚¾?rs‘ž O\á]†¡±Š\åœA<ódª\î8\ÛøzûUXn^ò\à\È\ÅUúŒ(R¾ø®\ã\á„u\Ï\Ù	#Y·\Úfa÷Y\ä+g¹8\é\Û5–aW\Ù\á\åQ»$›gfYA\Ï\nkW&’=»\áW\ÃO\Ùx^\Õüg¤¶©©\Ü2\â;‰R%#\"0€\Çrsžk\Ö|/7ti¢þ\ÊðÞ™k!\0Ž+H\Ð6:ò\0#\ëšó9õ-\ÌKI‡Ýž‡\éRCªpœœz\Zü~¶?ZM\Êz7{t_#öZ|7ƒökK;AC\â H“F\ê\Èüº²”\ãÓ½qŸ\îl4Ÿ\r?Œ4¥–7\ÓWu\Ë\"\í&3Á$/g9ô®MÕfP\Ìò>µ\×øgU‚xž\Æä¬¶\×jQ¡|2A0<‚k¡f2©\îUIFý7ùlò?¨\ÍV¤Û·G³]™\ã÷lþÂŸfšòöLmv¯\âkkÀ^9Õ¼Y}\r¢Ù²\\3uÉ®c\Ç-4½¤p”°k‚Ö³`ùK}\Õ\éÁÇµ{\ÂmÁ^\Ò-î¤–\Ê\îòe\Ìv\æ\é·\ßS+Á\Í\'\ìõ¼¤sbsuN›µ5w²Kü\Ïa\×|/¦\ëþ\ZƒF\×\íä¹ŒÆ™Š·a\ï)\ìk\ÈeýžtKE6›§´r¬\ã\Ìlƒ\Ï\Ý\Ü;þ\Úk,ô›(¥±x/ÁrŒŠH\0u\Îpjˆ¾)My¦—\Ó!–\Úv\\nR\Ôÿ\0³^½|F^\é¥)mÛ¯\Ü|NžeJMÁYJ\ç­_y·Z2Y¤6Ìª›K´Ÿp\ë\ë\í\\É±N\Ó\r‰#‚K¾O\é^)q\ã}n\r³^\ê—+»0.J39\ï\ÇZÉ“ÅŽ\Ò36³9$’I™«\n¹\Õ:¶\åƒ\ÓM\Òý\r(\äÕ©^óZúŸciúLqÚ”ºU“Ÿ§\ãV~\Ãl-\ä‰\"Dó¡ v#aª\à±nzšZý6zq’>ö?üm\à{ûO\êözµ•\Ìéš„¶rHü®®T“Ç¶kHð ûV\ç½H„`°.vo²ûâ¾ý»­\å›ö”ñV£A$(³G-Àa„’g…X\ê{w<×‰jZ%\äzÅž•©ùVwQ!Œ\Ï(EPÜ«9\çh\äu®:5_*ƒôýb!8©•¯‘t\èž\ÞI<\ëk\Åp# pGÐŠ\ÜÑ´aul¶±¸hdÁþm¿\Ý\É\è½f\ÞhS$Og{2™b\ÚûWxqÞ®h>-ÿ\0„jK»;	%™\îb0\Ìv;:`g¥aV£Â®wÓ§}\Ø\ê\á“D\Ñ,.¢\Õ4¤•\Ö5±E\ç%ª·A‘\ï\\_ˆ.4ñ¨,p±Ž\Ø>QX³R{ý4]k£RX\á_\Ü\'›ºG•°\ç\×¬iúR\ê\Z\Â\Çw{6×›U¤c¼Å†\nY”vÁ\Ï\áXSuj4¦\\¡J1¼u1/<\Ûû\æò‚\Ëm´HNZ ðƒ_[} ²Æ¨J\0üŒŽO¦k·ºð–¡¯k\â(n¤z\ÒB\ã?|ùpy\Âõõ®GUn\Ö\ã&YXˆÑ\rÛŽŸþªì„•9r\Ü\ä>xÝ­ˆ“OŽ\Þ\Î	&T@ÌŒª\Ã?ðn*\ÊÝ Y!¶\neP23\Ê\ÔZ}œÜ†žI”6V8£P]<ƒÀÀ\ï\ÍUº\Ðü©KCs²D\'!9‘W#”õ÷\ëZJ\nKVdÛ‹÷Q\ÐGký¨MB\Ò)dxn\â¹-\Â÷¶3M}¥¹ž;\ä‹2\\w\Ñ¯¬\åŠ\î|\Èü\Ï6%Ü›B1\ØóM¸\Õ\ÞKc,ÁW\årG\Ðú}\rrÚ­	\Þ&Ž­NA\íÁ’»\\\à\àr¿\áV\ìa\Ó\äš\ïmŸ0(D\Êü§\éQjh\Öòyð\n9\ÏŸˆ\äR$±\ÍsO?\Ý\à2¤Jôe%(\èp\Æ<’:xlSû>h´\Øÿ\0²\Ö6gý\ëœJq rI©4-fm=\Þ9&))ˆ‰!\È*\Ç#’ \çzû\Õ{v\ÛÀI\0by¡¦›ˆ„\ÌX©óÇ¿¥qJ\\¾\ã3¹BòºC/\"\Ó\î\ßGHÁ`\ÛÏ \ÏOÊª\ÞZ\Æöø—I–\Ü\Ç\Ï\Ú!`B~ŠtVööð¼¦\\9\È\Úþº]3\ÄW¶°Koö™<‚NS?tct\æ\ìúŽT\Ó\ßB.¾\Ëo¸\Þ\Ç)ó\0Ç”A\Û\ëŸ\\ö¯^ø\0c}Q\Ô\"¥\æDX\ä€Hü\Îk€\Çb{{[-V\ÊB\ÆÐ»C¢ ]\Än\'jòH\n=±\Åz\ß\Ãö°ÿ\0„6\È\é\Ö\"\Â\Þ\ët\ë9\ØS\ÔñÊ¾w‰«µ‚\äK\âi~¿¡õü†S\ÌÝ­\ß\èl‰\Ù[w=~\éjD”4%ƒ\Ä\ão÷}\ê\Ðc·cù¶\ài¢\\Iý\Þ:\Zø?gm\Õ%[\ÞÑ›6·N&\0¶ÀH\Ë/O­t\ZF p>b\ê\Ù-œ`Wg9/\"ƒœ©\ÇZÓ°¸+rƒpB\ÙÀ=+ž­-cEQKI³ªyZ·\ç6%“fD,Av\Æ	olv¯0Õµ[M±¯œ À\Ý\ru½\Ù2\ål„\Õ\ÍS\á\ÌZö¹6£¤\Ü\ØZ\Ç6\Ö1\\\å|\à…Ú¤SU…”j>I\éo\Äø\Ì\ã\r,$œ\ãª9\Ïx\ß\Â\ÚœÏ«\ÚN\Ê8/ä³Ÿ \Ç\âj?|Z\Òí­¼\ÝFi#),\Ò\rÿ\0\×]¦|1\Öm.‘\ãN–9¼\ÒñVO\í\'ð£Ä²x*4ý>\ÚK›BeCjÁ–\â<|Ê¬?ˆuÁæ½œ&Y½[üŽ\Æc*\Âw\Ú\ç‡üEø³\âX\í’+x\É\å®qøš\â\Û\Ç\Þ\"\Ü\âa\'_j·¢ø_\Äþ$»ž\ÇGðæ©¨\\ZŒ\ÏŽ\ïûÀ(“\áVFVðgˆ‚?³%\ãÿ\0¯ ¡„\ÂS+Š<\Ùcë½¤\Ï\Ö\Øu­2k…‚;\ØG8Uš½‘Šò+\Ù\é·K6«\Ú\"mÙ¾\éú\×c¬ø¢3\Ã\ët‰=\ÈL+\\g×–À¯G,\âZ•£S\ë”ý›Ž»\ßúg‹\Ëa«ÏšþV>/ÿ\0‚‡xJó\Â\ß—\Å	su5¯‰mŒ\é#Œ}žeU£W\î\0T`;Ç½xœ\Þ)xtK\Èu«x. ¸PŒk\æ–\ä©,9\ã’q“_q|aüSð¹Ñ¼Q¥]Km´¶\Ï\Z=»€r\èW?Ãœõu¯Ï¯ˆze¥¦¥s§\éWÿ\0o´v\Ý\Å6¸S\Ð:ÿ\0	\Æ8®l>gmiF•\Ôo½»ž\Í\ZN…«-QNk\ë\ÍU\å©U“\î@\ä¨\èø\Ö|\ÞMœ)º—i	\Ë\îù²?½\ë[Z*úo\Ùb”¼£•98ô¬}eV;÷Û½\Ë08œúW³I¤ôg-Fæ”™j\ßNû@Mòˆ±‡,\Ã%Ï¢¨&¯\é+NöÖŒ6#•\Üëµ²=Â­xoKiíŒ³\é·&\âLE\Èû\ß.2\Ãøõ\é~øG®Nº¤·)¥i\Æ@#vµ\Ý,‡n2S8\n>¹©\Åb¨Ñ\êJÆ´hI¿uoý¨\êZ„1A)bIB³0ôNõžžñ…\ç\Úg\Òô\É- d¾š?*\Ú4\æf•°Š?õõ‡\Ão…\Ú…®¡½ñ\0:„\ï’’M£8ùI\ÛÀ\çp+\Âÿ\0m¿Œ\Ò\ëÚ¬Ÿ<<ñÅ£\ØÈ§ThÕžd\é\ã¢!\Æ}X²+\Í\Âf4ñµ‡\Ã\Â\ïvõ\Ñwù\ßN¯\Ð\Ó	R¢\ç7§\êy6“}m.’E’+\Ä;¢˜9\ç\ÔÒ›ë‹‚°›ˆã·Œ\îwL“÷ˆ n”ŸþüBñ¼\Ï\á?\r\Ý\êv¶j^Y‰X\à@:ü\î@8\ïŒ\×\Ôÿ\0fOjzE¬^2›V¾¿P¦f†ôAm	#\æ¨\\’§û\ÙÏµ{¬vQFrWz%\Ô\ä\Ãak×¦\åìµ¿C\ç]\'Æº¾ƒ¢É£\Ú]mŽv`•Ns†\ÇéŽ•\É\Þ\Ê\Ò^M<3\È\ì\ç$3dœúšû+\â\ìs\á¸%›ÁZÎ­c.\Ðw2‰\×p\ê>l×½|\ïãŸ¾1ðÿ\0\ÄO\Ç¸–ú\Ü\ÍÔŠbjœ6ü\çn=s‘XC6\ÂNN2š¾ú+-õ\Ûñ5y~#•:q\æ¿mþ\íÿ\0\Í\ÖI.¬\n–I‡œž*8.6¢¬L>V“Ž\ä`g\ÜÊ½+\Ä?<u\á\Ý®®4µ\îBdkID¢!ž¸\ÆsŽr;W!q jQØ¯­»nd˜¿Ã°÷\éÇ½v\áñxzð\æ¡5%\ä\îp\â°\Õ\èM*\Ñiù¢M\èM\nÀ¤1\ÉS\Ã{{zÕ‹–’b\\þ\î%\Îñ\ßÚ±´\ë+\ËeMÑ€%\ÉRJµxn$…\íH\Ü;ž•x75sjU}Âµ\íò\ÝF¬ÁTF>Q\ÆG·Ö©¼\Åg\Û$\îÁ3\ÚK\Z(xYØŒ\ïôþ´—È±±±‚ÁoÂº £d\Îi9Iû\Æ|“¼{\ãð#RZúSÁ!ð¶›k‘º;D‰\ã\îñ5óîŸ¨X\Ûº²ž \ÌfHÊ†µô†‰O\Ø\Ç!\Ä	–¶\Ð+\æø¦<Ô©[»>Û§\Ë^µû/Í›÷Q3*\É\Z’7ü\ÞY\Ï8\'§\àj·›š¹Œúÿ\0:\'hòrs»pH©UFmùUc”8\ãü\æ¾;”ýU\Zz—„°\ÈYÊª9hEÚ§ò«V³„{\ÛsEž\Ù\ëYJ’.\Ñ\"»òœ\çvGó«vl\àHÁp±\Ðv\Åe5Õ›Òž›Ns\å\"\0\êr}w\Þ\Õ\ZK5ö\É\r\Ï\å^cn\é¼H09=n\èw\Íñ·°!À\Ç\"¼œL9Z’:kRŽ\"•ž\èõ\Ëk\èŒD\æ`}\ï\áÕ·¢\ë÷\Ö2\Çå²•?ò\Í\ÆC}Ey÷‡5D:°¶•‹‰#;vú\ãŽk¥³t7Ì‘€L\îùú’=k»\r6Ú”]Ÿ‘ñ\Ø\Ü,\áR7G¿ø2ûJÕ´\ß\í+h\"–`¿hV\Üñc¨ô5±\åGÿ\0<\Ç\å_5XøŽ\ê\Êé­ –`Ld²B\Å7r=ªÀñ&¸À0:‰\Ï9.ü\×\ÙÃ‹ðÔ©F5)^K{[¸øŠ\Ü!ˆu„\íµ\Ï`m$¼…I9&°<y\×VQX´Ž‹Ü‘(ùI\Ç\×bp\ÞdŽHn\ëT<C¦Ayj~\Ô;`\ã¼®/%†›\Ý>¨ñh\â¥\Z±u\ì|ÁñÅ—>¸J\ïµ\Ék)\ÙA,\n•ÊG=«\å?höúþ¹=õ™0+0i“=õýs_iüxð†—«\Þ\Úøy?l•L’\ãqˆ\×\ëŽk\Ïu/€~ðþ›q\ç\ß_\Þ\Ã?™•L\ê»@\Æ:\×KNxZSmÛ•÷º=üUz5”®ß–§€ü4\Ñ%Žø\Ãc	d`elc\Óo¯c\Åz7…¾[\êz\Ð\Ô/\"[h¡ 4B–Á\ì:\êq^‡ð\ËÁºV—AajV8˜¸c—b:\ä÷5\Ð\ß\Î%›\ì¶\Ä%¼`lg+ž¿Z\ÏœÖ•ù%dtCMYr«”ôxwN™u)T.$?4®ƒ \î$ût÷/\Ú$¾­”%,\à.F§—šªß‡±‰Ã€¥\ÉÀP:\Ö?‹|B\ÐÛµµ¸\\ùa7&\08\í^>#ª®g\'o\ß\Ìí¡†›’V&»\Ögš\ìYXšR‰`\ÄtÀ¯<øQû0\éÿ\0ð·ˆ~$I£¨\êS›\ÄÓ %l\×s;\ÉùŸ“\Ð\àqÞ½CÁqÅ¢lw8šI¶‚\Ç¿µw\Ö\×0\")\0±XE \äý?ú\Ôòºõ°Ê¤iM§+]õ\ë¢\äwc0¤\á\Ïò\í\ë\Þ\ß\æ7M†=/Jž+K$·†4+0¢¢¢€\ÐN\r\'†fh	\r…F\' \ã‚OZ]HfC,3´lw\îåŒŽ \×ñ©¬ VR¥au<\Çp?§ZëŠŸ2³\Ø9`©»­Í¸õVóv±¤’\Ù\æH¥Pÿ\0µÿ\0\ê®âž¨\êwöš\Ë\\‡–Ì•\ãF;ô\ÈvO$‘¢\ÇJ\Ð\íK¿#¸ô8©NŸ5\äR#\\m‘PðG^s\Û\"»qzN›»ô\îr\á«,-UV^¦#h\Ö\×ZZ¶\ä*a²¸Šù\Ã\â\'\ì\í\ã¿ø\î\ïNðNŸi%Š0œ\Ë5Ð‰-‹vù½y\Æ<{W\Ö)kko’\á÷	:tÒ­x^Xôo\ÚÊ³†ú/²¾s‚\Ù\Êg\èxüj°\åƒ\ÄÂªz=%úi\êrc\ë<F\ZpÝ­cýzø›ö:ø•\á¿F\Ý:ûjy·1It°˜7,v°\Ç·jò¶øU\ã¨\åÚº÷¬{,‘{H¤©ü\ëõ–KDº·h.¡YQ†]r\re\ëþð¶©n\Ë.…`ó¹-\Õw|k\íe\Z®.qü¯f\ß\ÝúŸb‹Q‘ù\Ýðg\á­wz\Þ(×­Ìº6œ|©m,\ç‰\î\æfT\Ã`g©#q\ÍzŽðºkM\â7\Â\×:™¢Z¤‰Â¬“\Ì°\Ä<€Ê¹aÀuš÷ýCöð}\åû]‹Y4ùºµ\Â+B1ƒW-~	x\Z\r§R{«ÓŒ»½m¸‹‘Çµy´±˜™EKØµn¯\Ì\î”ð¶w©{ù?ó>9øÖ–\Þ7ñ\"^h­qs.$4òBwRgToÉ£*F2=\ÍixO\áG\Ä-n2l¼/¨Ëˆ>Ñ½\íüãŽ›°{(ü}=¿\Ã\ß\ÂñZ\évBEU\Ãm\îaœ\Çükªð§ˆl5«!5®\äq\ÃB\Ãkš¤~¿_\Ù\âj¨½ùS»;p¹¥Lº“©†¤\Úz^_ð‚¼+—£\ë\Úo‰t\Ï/P1D—(W\Ép~a´\ã\r\Çz«\â)l\î/e66þZ’(×€ƒ<Zöo\Û\á=\Ô^\'»ñŽŒd¼‡R\Ïw\n©/høq#ø	žÇ­|õ\Ö-oü³‘‚\å¢\È%@þ.:Œw¯œ\Å`+R¯(§t¾Àfx|]\×OVµW\ÙõEÐgGc÷W¦\Þõ=»\Åi&(O(\r“CyngÏ’GC\ïI‹ Y3~•\ç\Îò\ÒÇ±JE¸\Zfc·$gþzÒ´t´òÿ\0\Ö1\ë\É\rT±\í¥Î¾l,p\Êz·\Z¾>\Éþ²\Õ]\Ï*NW\Õ\ÍZ)F\Í­\Zh™\Ñx&YŸÅ°4\rlÄ“\Ðm\Çõ¯F€F²l(dÝ¼¶H\ã=\nñý?SK\rf)™”	d“œ\0\Åz²™	\æ+À|›\nö\ã\0ó\ïùSÃ¥k\Øñ3\Ü\Óï –/5½ý\Ô\ÐNU\Ì8l0]ÉžF;ö¥8\Þ°ÜŽ”\Ë\è\å\âxIû©C·IÁ\É=9Á¬Ëµ¼Ž\îX\Ë\çc‘•`\àö«³\åµÚ·\êy\éBRm\ØúŠ\ÆWš\Ý7*ü¼\àz\×ñŸ\Ç#\Ã\Ð\ÛY\ÛY‹¶ºr“\É\æ\0¶\É\ê{“ž\Õ\Ãø\ß\Ä\Úú\è\ÂCTšg˜ù‚\Ö\Í|q†\ÇÍ‚y\äšóñe¨\êŽ$™(z/$\äö=\ë\Ý\Ìø‚T\èýZŠ¼\ÚWð\Ç\Ãeü<§?m^K•=¿\àMžµ¡©¼\×yŒ[–#<\ãôª~)¼º\×5-ª\\lHó\Ä)\Ç\êq\É\ïVôM\ê\æ#g¥¢<ð€d–i0 ñÔž¿J¯s\Zi³\Ëà²œ;žzÖ¾~XŒD0\Ê\Ò2{ô>¶=EB‡¶n\Zµøf’;xã²³c.Àöýz\É\Õn7í³µ$,Ÿ4¯ŒUý\\”½ò\ãL©µŠöþªÎ¹Å¢;“ó\Æ=ý­s6ù--Ž\ÊT\Õ\ï\Ô\Ï\Ô\äK+!\Zœ6\Þ\Ý\Zù\ç\â\Ï\Æ	¬õ\é4¿Eouöf\"\ê\æ\\²³wDÁ\í\ë\ë^¯ñ+T{\Ü2>Ù¦£<rF3øk\ço4·L¶—YÀb¯{‡0\Ø*Óž#²\Ò+§›¡9›\ÆÑ„i\á¼÷}W¡öŸ\Â\éu/i—–\ï°^Ù£§!²£?ýjôM28V\ÐI1P\Ðþñ\ÝF\ì\àw\Ç5ä¿³˜¹·ð•c;+\Ïe	‰Šðÿ\0LW«Ü½Õ¹WŠxº‰c zÞ¹°¿\í¬b\Ú^—\Ðõ1‰¾^ŽI2mK2¬3\ÂQ i2²F\ÙROC\Ç~Æ©Cyko©=­\ÓK\äÅ»\íD?\Î<\àô\Éµ¥dt\ëÉ­\Ü#B\Ã\n\Æ,\î,GË_^•\ËIa¬[xŠ\ê\Ê÷\ÉEf/<œ09\àž\äœ\n\ê\ÄNt\ÔjF<Í»y”#©S“µ•û=ÿ\0¯À\í<:T\Â\ÖÒ™a‘\ÈeY%ccœ\ß8<úS£¶Vc\å^Ü¨4«!lŽ„sXVúý½´€‰\"y—¹,\ÌÀ¸?—©\ÇJ\ÔÐµ®\å\Ûy\çq±Š\íEÂ &®¦3\ä©\Ç™\Ç*\áz;qº\Ãja½…p²)Ç™\éœô<\Ö&´—–‘\É”\Ç˜ù\Ü\Þ\Ø\íÒºy´h..mŒ‰—\Zf\áI\à°\ç\í\Æ9ô¬}\æ²Ò¾R+ˆ\ã¾søõ\ë\í[\â\éÍ¥NJ\Éè­¿M~G&\Z´U\êGVµŽÇ¢x#Å–Zµ¼—/\äj;´Rq\æ9e=þk¦\ÛÀ=\ë\Æ.,¯­¼Ae©$oö{•yQOðƒ“†ƒŽ\Õì–³\Åql—¸x\åP\èÃ¡k\ìòLu\\L%O½\è[^\ë¹ñù\Æ–q\î\Êúv}‡>\ß,\çÒ¼³Åºc\Ã\ãFÔ®.\Ý\Ò”\n\ÞGl¨`@\Åu¿¼Y¦xWG[½Nc\Z\Ê\â8U»\Êç¢ª¨\É5Àjš\Ãj‹4wù\Ã%f\08ô\È\Ïµó\ÜU™\Â…8|Q\ÕÎœ“UÞ¥½×¡\Åx“K\Õ\åÔ§—L™\îŒl]Ù›\Õy\í\ïõ¯BøA©\ä1*Gõ÷=ÿ\0\ZÁ2Gn†5`\Ï#ò\á²q\Óô­ß„öImw-±\0“z¾y9\í_„\ÄJXš^\Í\ÚJ_-ö>ŸÔ°’RZ$zˆ·Õ¤H\Ô3˜ã¯µxŸÅ¿~º–\ãY\Òô\ãhgm\×1\Ûð#\É\å\ãºò:W·A˜\Ð+õ¦]!\Ú\ØWú¦/KB\ÒV}\×G\Üø|2¶¯4%ÿ\0øO\âWƒ¢ð†¦–6v“¤ñq#\Ç, \àõ\ã\Ô\×*\Í\è]»‹Hlg8\í_K|rð¨÷\Ò\\Z$M	\ÜcÜ¹À=Ex³\á=oM³ûdk„\Ý$«Þ€ó\êYqZü\â´\åR½J|­Itý|\Ï\Ø2\\M*\ØhI\Í6ü\É4Ä–\â8l€‘Ë¾\Ø\Ñy9>•_U­¤1³•’\'*\ê\ÝWÚ¶’S¡1iaI\'–qž#?\ã\\Wˆ/\Ü\Î\î\ï–s¹«Î„\åUrKNñ•úxª\éœ\ì\ì¯¨+\Îk\×~ø´ø§\ÂVW+{\ç^„XœIÂŽŒ{W\Î>>\Õ$m\nP$€=)Ÿ³Š\æ\Òu-#¤¿)¸\è˜¯U\å\ÓúŒ«\Çx½»®¿\æ7ˆ¥W+ø\Úþ¼Ï®oO˜…ea\Îw\Ûÿ\0¯X\Í\ê±X\ïP(Ûœ\Ô\íTƒQµ\Ø&\n\nó¸ô>Ø­4²·(I>q\ÏÝ¯\Z\Þ\Ù)/\Ì\ä7Iò\ËFv¿%X’9n\Ö(œF\"†$\\±Ó¸¤÷®F\Æ)\ZÕ¤Œ\Ï\Î\ÌaA\è	=\ÍhøŽþ\çU\Öd\Ô.\ÑŸõq§E‡½S»\Ö\Zr%{Ž\n\æ«]}bs©&\Ûù3B•HÐ;\r¹€\é:t‹qu²JÀí·`ö\æ±\Ò\ëlfG\Ç\Îø\ï\êjž«¨\É.\çn§¡\ÍU.÷-\Zv`r\éXF·¶«xü(ô)\á\\ay\îÉ¯¤‰¶p\Ø\é\Íbêº‰û<Ž~vE;[mlGoupBZD\î\Ù\çb\ç\ëÒº¯øK›umBÜŒÁ\\}\ã\ïþ2J\Õb›4r£‡‡5F|÷y¢j^)Ô–\Üg$x\ëŸA\Ü\×Kaû=ø¦\Ò\Ô_In–ñ¹w¶\å_Qx3á¦kªÃ©µ¸ó\â\å\ã½\ëH·º¶Mu^\Ì8¯¶À\äø\Ú\Øf\Ó\å\ì»úŸ?\âzpª•(\Ýug\É_´û\ê`ºe/Ž½5 ”,®Už\Þ<8<\äd\Ï?¥g|eÓ¢²ñö\ëd‰\Z†!z·Súb§\Ó&¸}6\Ý\âs ±\å[<|§\×Ú¼œgJ¥JU\äŸN\ç\ÑÕª±8j8ˆ\ét.£òÛ¶¡§\Ä!’Ñ€`Œyö\Çs\Ô\Ó[Fk\Ø\Ìú\å\ã[5\Ã,\í[€[ž}»sW¢·\Ý$2™Z7\nß»l…\É\çúSüO«©\\\ÜchUUøwòsŽ8?\ä\×}\\#¨¹¥¶štë®–g\ÖZ„]¼úô\Òúõ)Ioe¥ †\ÂEHS÷ƒ#¹9\Ïø\Óàºž\Ù\ÄÄŽ¬0e_\á\ÆOò§\\F&v€)~ÙÃƒ÷‡^EEsqk‘\Ñ2B¼O?\n»†‚Œœ¾-3 ÑµVX$Ü¬Œ!*U\×;ò\ëƒVü9k5­±Ô¤;q(ÄŠ2@\Ç•\Ë\Þ\ÏVQµ»$»v·•\íß­oxBòþf@`ŒÁ#ò;\ç>„\ÕÒ±Œ\ÛvÛ®¯üŽ<E\ZRœ4O‘»n\è\Ò=Øº\Ë7˜\ÛsògŽ=s[þÔ¢\Óeo\Þ\\‘I’\ÞB0JûÉ®6Ya³\Ö]®mœD\è_Ž5X\Ô.\Ö\êMv\ÚU\0\n°`0Fs‘ô¯r†6ToV\Z\Ê;«½W]>\æxøœ¶‡$¾³\ÓG\ÓõGOã —L®Pv>\î}+ƒ½‹Ì¹Ø„\ÐJ\ë\ï\ï—WÒ–\ê\Õ÷+\0’§\Ð\×)sivóˆ@-É¯„\â\\G>5\Î[>ß¡®UeO‘\è\Ð^\é\Öö¤M*\É<ƒ2ªŒ˜ý>µÁ÷kmvc*UW=¹=?:¥™t*‡žù­\íC\Äbœ|²ðõÅ†\Å{lLc‡§e\ÑÁ:13‚¢\ÕI\Ü\ïlfómÀ”gŽ\rZQ8ª\Z\\B(„ný¾RÆ­[\î?0$W\ì\Ø\nµ=œ=ª»\Û\ÌøJñ3\åØƒZ°‚ò\Ô\Å*+:^Mñ?ÀQ¯-­¤óNX‡\Ë 0²ü+\Ù]YÀ\í\ß5ð>Sô\ÏcXfy-,t¹\â¹]·H\ìË³J\Ø)\'ò>ø•k¨\Ù\êe%´“¸\n}\ë\Ïu-W¼27“\"¨]\á•þW\èV­\à\Ý/U•¾\ße\Ør\ß:y÷¬\ÝW\Â\ÚdB\é*‚0V1\Å|uƒ†¼š\\««\Ðýýw¥:J\Ï\Þò>\0Ð¾x‡\ÅwðZZY\\O»šO)0W’NGVO\Ä/	\Í\á-a¼”$¸\'Q‘\Ó\0_ šO†\î,·\ÜhN‘ý ²È»@@¯vÎ¼\ï\ã\ï\Â\ãy\á‰\Ò;d”$G\Ë`£tg¯\â3UW‰\Ã\ÒMA¸\ßÞ²\Ò\Ý,úõ¾„\Ð\Îh\×\Å.iYô\×[ùŸ;ü=ñ3µ´SÁ¤÷¯J‡\Äö&-´£?/ÿ\0^¼3D\Óõ\rU–\ÒùXF\ÍÁ=«´D%°G½óØº\n[¥+&~‡M\Ò\ÅSŒ\ên}¡\è-qnždnHQ¿\æÁ¾+ª\Ó>hºh£“Š•.N?1[>\ÓVBŒ\Ê09®±g·²€“„U\î\ì\ä9%,E7W—/w¿\Èüg0\Í\ëF|´[O\È\á¢øO <n÷–+.ATÌŒ1\î\0©tO†\Ú6›s¾\åQ¢LlŒÀÜƒ]eŽ®—Á\ÞTrlzg½c\êò_Í©¤PÛ»»0\Ø;#BS^½|&Q†„\'F—7kuõ}|Ž8có\Z\Æu\Zùš\Ï\á\í&\î5Q;\îˆ\ÑTÊ¤³ðå¹A`y­>\Ý`€\"\ç\0T\Ò)eÀ\ã=\ëè¡–a¤•i\Ò\\\ÞG,Ukò)»\Çk`^*@>Z€ý»kmò†\Ê[\'Ÿz–Ì I´7|t¯BŒ \ì£¾V9\ç\ÍÕžWñ\ÛH3À.\Ò<\á°\î%G­p~y\"VÆŽ‘ÏžA\à_Zö‰Q˜ôi3\Z¼R)$³ð?õ\à\ÖO‹\Éy”´»UOËŸlûq_f°X|\Ù\Ûw­\Ò8r´«\à]\'²\Ø\ë¯dŠ3\'–#\ÞDr\ä‘ ø®rJ}”F\âÕ¡Ž|K*”!>c·‚;qžxªº,=·”×³\Äb+½eP#$\ç\Ãð[A©‡–\â$Ye\0…x\Ïô\ÅuO[M-?®\ÇD \ÒpoUýu*\êv—VŽ\r”@¢™‘×•Á\í\íU#¸\Ï»¶\0B¸$7lŒf·£e¾\Ó|»¥M² /Áù\Üv?ýjÆ¼…`t0YL…X‚	œö\äŽùü+:”\ÒJQzv.•G/vKUÔ•Sº„#HÀÇ¼ckw\Â\ç\é\ÍO§µ­¦£’•K8ÿ\0–‹\ê=GµV\Zc\\\ér\\ #\É.[p\ã¸\ãZš;»\'‰-\âYÁ]\ÞjaT\î\Ö¡%g%eºo¯\Ü]ù“Šw\ïn†ô›\ëotu8\Ë}º\×1ý¥5ªO¥Mj\æÕ§’!“\'§=¸®³Qiš8o¢Ž$epðOlvúW7­\Â\Ò_\\H\"IÀN=rúR‚¼^¿£#/”%¤ÖŸ“L\ê¼}~\"{Y$B·	°¨<#óÖ1˜\å`šòý$\Ü@±\É9””ù\Ó|\Ür7Â½£K‘f\Ó\áF<\Ø\Õñé‘œWVUƒ¥Œ¡Ym¯\Þ|\îyaª\Æp{\é÷!\Ò6•ó6òz\Z\ÑK4ˆU’8\æ¦U\Ý\Çó©À\0=«\è¨døZ)û8üÏœ©‰©-ÙŸw\ämÊŽ‡Ú´\í/<ãš\ãóW\rÀö©\Ða@®¼&Ò­)§£9\ëT\æ‚CÔžô\ì\ÓŽÔ§5\îBm+–°F+;SX¦F‡z\ínõ\'{U\rz\Í\æƒÎ…\Ë\Î\Ï\ïoz\å\Ç^t$\ãù\Z\ÐiM]\Ø4\È8–,‚TgQø–\Ùd°|F\ä#¡öªZ\r\Ê\Éx\Æ\Ý\ÃD>WMÜ£¼VÄ’C6`¡r›¶n±\Ó8\ëŒ×›„©FT\â­\Ðéª¥N²lùƒ\ãWÃ‹;\Ã-Ý¤9 )\ë^4|1®¡\Ø-¤\ÂñÒ¾\Ô\Ö4´\Z„\ÑL¡£•p\é\\Œ\Þ\r„\Ì\ä:`±5ù\ål\rNv–=W\ëó?B\Ë8ŽT)rIß±\è:Aa/ñŽ­O~\ÐÇˆ*\Æ\ã\çô¨´þ&¶QÀò\Ï•E\â ¿n„|¥ùºW\ÖT’£N+k/¿s\á\â¹\ë4ü\Èlt(WXŠ\â\Õ\Þ8\"\Éò\á\É\ï]4\0wm\Å%¢¨N\0zU¨úW­•eô)A¸­\Ýÿ\0\á»Ø¼EIµv\nœsO\n;Ð½)k\è\ã‘À!*3\ÇsR\ÑJt¡=\Ð\Óh\â¾$X\Ì\Ú4\Ïo’2\Ûs’~•ó¥õ\âA©aþP¤aO§|\×Õž&\0\éW\0ü‡µ|§\ãX\ãþØº-w€\Ç#­~Y\Ä\ØHQ\ÆÆ¤^­£ðUW>xH\Ü\Òu¶È¨\å’`F\Ãüg…\Ç\âk¥†W†D‰oy¬U‹ƒ\Üöö®Dùd³e\à‰r\í\ÍwNL\Ú}Ì²þñ\Íö7$ü£½,¤\éJm\êš>ƒ0£ÕŒ\ÏþÔ¾q,Š#\\—å¬¸¨ö¨\\%å€Û©T?,¨\Ü\ÄÞ‡üiÑª¶­ *\î\Ðr>µGE–S©Lå——\ä\ÜvþU\é\Ç\ß~§ƒ(òE[ÈŠ{7\Å} 1€;“\ê}\ê_\Ë$\Új\ÎbH’2²G\Ü\à~DV–Œ‰Á9¼Š£rÌ·\ë±X™~d\ny=Ed\áî´¶k·cH\Ô|\é½mú—\'}\ÚPfÂ˜ðª¬HÇ¢±þF²õ\'\Ú %¹Zžr|¹y<ÇµaÙ³—F[±®l\\¹¬Ÿc³	K•6™£\Í\Í\Ü\Ö\Úe½\ç™5Ó¬@(9PO?¦k\ÜlaŽX\à\"@€{Šñ/„Q\Æ~#®cS¶6+‘\Ðã¨¯r·^‡~ò5j\Ë{¥÷;\Å~\åjt£µ¯ó\åbdP£§4`\Îy=\Í8t¥{ð¯­i[C\ä±\ã \â@P\É÷\é¹r\Æö\"\×d\á†8\ì\Ôi÷<}\ê¨MÐ£ƒN™@\í[©4ˆJ\æv±§¥\Ê?”¢)\"D;½kš\Ôü+ww¬i:ôW\Ík¨\éSd6\Í\ÂX\ÎVHÛžU\Ôþ)\í]±=)Ž•\ÐW“_Nu=ªm?-\êX™\Æ<¥-R\Ñ.T8«ô©7œ\×Òº`–x\íQ3\ÐW\Ë\éV©\Î÷4£^p\\¨ÿ\Ù');
/*!40000 ALTER TABLE `Recipe_Picture` ENABLE KEYS */;
UNLOCK TABLES;

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
  CONSTRAINT `rid_rt_recipe` FOREIGN KEY (`rid`) REFERENCES `Recipe` (`rid`),
  CONSTRAINT `tid_RT_Tag` FOREIGN KEY (`tid`) REFERENCES `Tag` (`tid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Recipe_Tag`
--

LOCK TABLES `Recipe_Tag` WRITE;
/*!40000 ALTER TABLE `Recipe_Tag` DISABLE KEYS */;
INSERT INTO `Recipe_Tag` VALUES ('58472ecb001d5',1),('5847399c49feb',1),('5847302218e09',2),('584732be7985a',2),('5847335393d21',2),('58472dba0bee1',3),('58472ecb001d5',3),('5847399c49feb',3),('584732be7985a',4),('5847335393d21',4),('58472dba0bee1',5);
/*!40000 ALTER TABLE `Recipe_Tag` ENABLE KEYS */;
UNLOCK TABLES;

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
  CONSTRAINT `rid_RV_Recipe` FOREIGN KEY (`rid`) REFERENCES `Recipe` (`rid`),
  CONSTRAINT `uid_RV_User` FOREIGN KEY (`uid`) REFERENCES `User` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Recipe_View`
--

LOCK TABLES `Recipe_View` WRITE;
/*!40000 ALTER TABLE `Recipe_View` DISABLE KEYS */;
/*!40000 ALTER TABLE `Recipe_View` ENABLE KEYS */;
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
  `rid` varchar(13) NOT NULL,
  `uid` int(11) unsigned NOT NULL,
  `rrate` int(1) unsigned DEFAULT NULL,
  `rtext` text NOT NULL,
  `rvtitle` varchar(45) NOT NULL,
  PRIMARY KEY (`r_id`),
  KEY `rid` (`rid`),
  KEY `rrate` (`rrate`),
  KEY `uid` (`uid`),
  CONSTRAINT `rid_reivew_recipe` FOREIGN KEY (`rid`) REFERENCES `Recipe` (`rid`),
  CONSTRAINT `rrate_Review_Rate` FOREIGN KEY (`rrate`) REFERENCES `Rate` (`rank`),
  CONSTRAINT `uid_Review_User` FOREIGN KEY (`uid`) REFERENCES `User` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Review`
--

LOCK TABLES `Review` WRITE;
/*!40000 ALTER TABLE `Review` DISABLE KEYS */;
INSERT INTO `Review` VALUES (2,'8',3,5,'Really, really, tasty!','Yummy!'),(3,'8',3,5,'Really, really, tasty!','Yummy!'),(4,'9',1,4,'good',''),(5,'9',5,3,'not bad',''),(6,'10',1,3,'ok',''),(7,'10',2,1,'awful','');
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
  CONSTRAINT `uid_Search_User` FOREIGN KEY (`uid`) REFERENCES `User` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Search`
--

LOCK TABLES `Search` WRITE;
/*!40000 ALTER TABLE `Search` DISABLE KEYS */;
/*!40000 ALTER TABLE `Search` ENABLE KEYS */;
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
-- Table structure for table `Tag_Click`
--

DROP TABLE IF EXISTS `Tag_Click`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Tag_Click` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `tid` int(11) unsigned NOT NULL,
  `uid` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tid` (`tid`),
  KEY `uid` (`uid`),
  CONSTRAINT `tid_TC_Tag` FOREIGN KEY (`tid`) REFERENCES `Tag` (`tid`),
  CONSTRAINT `uid_TC_User` FOREIGN KEY (`uid`) REFERENCES `User` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Tag_Click`
--

LOCK TABLES `Tag_Click` WRITE;
/*!40000 ALTER TABLE `Tag_Click` DISABLE KEYS */;
/*!40000 ALTER TABLE `Tag_Click` ENABLE KEYS */;
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
INSERT INTO `Unit_Conversion` VALUES ('gram',1),('ounce',28.3),('pinch',0.25),('teaspoon',5);
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User`
--

LOCK TABLES `User` WRITE;
/*!40000 ALTER TABLE `User` DISABLE KEYS */;
INSERT INTO `User` VALUES (1,'lululiu008','123456','Yiwei Liu',NULL),(2,'licheng173','e10adc3949ba59abbe56e057f20f883e','Cheng Li',NULL),(3,'fgl','123456','Gulin Fu',NULL),(4,'cl','asdf','Changyuan Li',NULL),(5,'yds','df34ty','Yandong Sun',NULL),(6,'yiwei','e10adc3949ba59abbe56e057f20f883e','Yiwei Liu',NULL);
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

-- Dump completed on 2016-12-06 22:16:34
