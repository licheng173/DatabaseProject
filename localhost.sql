SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

CREATE DATABASE IF NOT EXISTS `Cookzilla` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `Cookzilla`;

CREATE TABLE `Event` (
  `eid` int(11) NOT NULL,
  `etime` datetime DEFAULT NULL,
  `elocation` varchar(45) DEFAULT NULL,
  `edescription` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `GGroup` (
  `gid` int(11) NOT NULL,
  `gname` varchar(45) DEFAULT NULL,
  `gnumber` int(11) DEFAULT NULL,
  `gdescription` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `Hold_Event` (
  `eid` int(11) NOT NULL,
  `gid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `Ingredient` (
  `rid` int(11) NOT NULL,
  `iname` varchar(45) NOT NULL,
  `iquantity` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `Join_Group` (
  `username` varchar(48) NOT NULL,
  `gid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `Link_Recipe` (
  `rid` int(11) NOT NULL,
  `rid_link` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `Post_Recipe` (
  `rid` int(11) NOT NULL,
  `username` varchar(48) NOT NULL,
  `ptime` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `Recipe` (
  `rid` int(11) NOT NULL,
  `rtitle` varchar(45) DEFAULT NULL,
  `rserving` int(11) DEFAULT NULL,
  `rdescription` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `Recipe_Picture` (
  `rid` int(11) NOT NULL,
  `pid` int(11) NOT NULL,
  `content` blob
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `Recipe_Tag` (
  `rid` int(11) NOT NULL,
  `tag` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `Report` (
  `id` int(11) UNSIGNED NOT NULL,
  `username` varchar(48) DEFAULT NULL,
  `eid` int(11) DEFAULT NULL,
  `content` blob,
  `time` datetime DEFAULT NULL,
  `title` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `Report` VALUES(1, NULL, NULL, NULL, NULL, NULL);

CREATE TABLE `Report_Photo` (
  `id` int(11) NOT NULL,
  `pid` int(11) NOT NULL,
  `photo` blob
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `Reserve` (
  `eid` int(11) NOT NULL,
  `username` varchar(48) NOT NULL,
  `rtime` datetime DEFAULT NULL,
  `rlocation` varchar(48) DEFAULT NULL,
  `rdescription` varchar(80) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `Review` (
  `r_id` int(11) NOT NULL,
  `rid` int(11) DEFAULT NULL,
  `username` varchar(45) DEFAULT NULL,
  `rrate` int(45) DEFAULT NULL,
  `rtext` blob,
  `rtitle` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `Review` VALUES(1, NULL, NULL, 5, 0x5265616c6c792c207265616c6c792c207461737479, 'Yummy!');

CREATE TABLE `Review_Photo` (
  `r_id` int(11) NOT NULL,
  `p_id` int(11) NOT NULL,
  `photo` blob
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `Review_Suggestion` (
  `r_id` int(11) NOT NULL,
  `s_id` int(11) NOT NULL,
  `content` varchar(80) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `User` (
  `username` varchar(45) NOT NULL,
  `upassword` varchar(45) DEFAULT NULL,
  `uname` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


ALTER TABLE `Event`
  ADD PRIMARY KEY (`eid`);

ALTER TABLE `GGroup`
  ADD PRIMARY KEY (`gid`);

ALTER TABLE `Hold_Event`
  ADD PRIMARY KEY (`eid`,`gid`),
  ADD KEY `gid_idx` (`gid`);

ALTER TABLE `Ingredient`
  ADD PRIMARY KEY (`rid`,`iname`);

ALTER TABLE `Join_Group`
  ADD PRIMARY KEY (`username`,`gid`),
  ADD KEY `gid` (`gid`);

ALTER TABLE `Link_Recipe`
  ADD PRIMARY KEY (`rid`,`rid_link`),
  ADD KEY `rid_link` (`rid_link`);

ALTER TABLE `Post_Recipe`
  ADD PRIMARY KEY (`rid`,`username`),
  ADD KEY `username` (`username`);

ALTER TABLE `Recipe`
  ADD PRIMARY KEY (`rid`);

ALTER TABLE `Recipe_Picture`
  ADD PRIMARY KEY (`rid`,`pid`);

ALTER TABLE `Recipe_Tag`
  ADD PRIMARY KEY (`rid`,`tag`);

ALTER TABLE `Report`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`),
  ADD KEY `eid` (`eid`);

ALTER TABLE `Report_Photo`
  ADD PRIMARY KEY (`id`,`pid`);

ALTER TABLE `Reserve`
  ADD PRIMARY KEY (`eid`,`username`),
  ADD KEY `username` (`username`);

ALTER TABLE `Review`
  ADD PRIMARY KEY (`r_id`),
  ADD KEY `username` (`username`),
  ADD KEY `rid` (`rid`);

ALTER TABLE `Review_Photo`
  ADD PRIMARY KEY (`r_id`,`p_id`);

ALTER TABLE `Review_Suggestion`
  ADD PRIMARY KEY (`r_id`,`s_id`);

ALTER TABLE `User`
  ADD PRIMARY KEY (`username`),
  ADD UNIQUE KEY `ulogname_UNIQUE` (`username`);


ALTER TABLE `Report`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

ALTER TABLE `Hold_Event`
  ADD CONSTRAINT `eid` FOREIGN KEY (`eid`) REFERENCES `Event` (`eid`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `gid` FOREIGN KEY (`gid`) REFERENCES `ggroup` (`gid`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `Ingredient`
  ADD CONSTRAINT `ingredient_ibfk_1` FOREIGN KEY (`rid`) REFERENCES `Recipe` (`rid`);

ALTER TABLE `Join_Group`
  ADD CONSTRAINT `join_group_ibfk_1` FOREIGN KEY (`username`) REFERENCES `User` (`username`),
  ADD CONSTRAINT `join_group_ibfk_2` FOREIGN KEY (`gid`) REFERENCES `ggroup` (`gid`);

ALTER TABLE `Link_Recipe`
  ADD CONSTRAINT `link_recipe_ibfk_1` FOREIGN KEY (`rid`) REFERENCES `Recipe` (`rid`),
  ADD CONSTRAINT `link_recipe_ibfk_2` FOREIGN KEY (`rid_link`) REFERENCES `Recipe` (`rid`);

ALTER TABLE `Post_Recipe`
  ADD CONSTRAINT `post_recipe_ibfk_1` FOREIGN KEY (`rid`) REFERENCES `Recipe` (`rid`),
  ADD CONSTRAINT `post_recipe_ibfk_2` FOREIGN KEY (`username`) REFERENCES `User` (`username`);

ALTER TABLE `Recipe_Picture`
  ADD CONSTRAINT `recipe_picture_ibfk_1` FOREIGN KEY (`rid`) REFERENCES `Recipe` (`rid`);

ALTER TABLE `Recipe_Tag`
  ADD CONSTRAINT `recipe_tag_ibfk_1` FOREIGN KEY (`rid`) REFERENCES `Recipe` (`rid`);

ALTER TABLE `Report`
  ADD CONSTRAINT `report_ibfk_1` FOREIGN KEY (`username`) REFERENCES `User` (`username`),
  ADD CONSTRAINT `report_ibfk_2` FOREIGN KEY (`eid`) REFERENCES `Event` (`eid`);

ALTER TABLE `Report_Photo`
  ADD CONSTRAINT `id` FOREIGN KEY (`id`) REFERENCES `Report` (`eid`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `Reserve`
  ADD CONSTRAINT `reserve_ibfk_1` FOREIGN KEY (`eid`) REFERENCES `Event` (`eid`),
  ADD CONSTRAINT `reserve_ibfk_2` FOREIGN KEY (`username`) REFERENCES `User` (`username`);

ALTER TABLE `Review`
  ADD CONSTRAINT `review_ibfk_1` FOREIGN KEY (`username`) REFERENCES `User` (`username`),
  ADD CONSTRAINT `review_ibfk_2` FOREIGN KEY (`rid`) REFERENCES `Recipe` (`rid`);

ALTER TABLE `Review_Photo`
  ADD CONSTRAINT `rid` FOREIGN KEY (`r_id`) REFERENCES `Review` (`r_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `Review_Suggestion`
  ADD CONSTRAINT `review_suggestion_ibfk_1` FOREIGN KEY (`r_id`) REFERENCES `Review` (`r_id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
