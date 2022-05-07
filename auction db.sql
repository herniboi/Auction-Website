CREATE DATABASE IF NOT EXISTS `RUClothing`;
USE `RUClothing`;

--
-- Table structure for table `admin`
--
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `username` varchar(25) NOT NULL DEFAULT '',
  `password` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
--
-- Dumping data for table `admin`
--
LOCK TABLES `admin` WRITE;
INSERT INTO `admin` (username, password) VALUES ('admin1','pass');
UNLOCK TABLES;
--
-- Table structure for table `users`
--
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `userId` integer NOT NULL DEFAULT 0,
  `username` varchar(50) NOT NULL DEFAULT '',
  `password` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `address` varchar(75) DEFAULT NULL,
  `rating` integer DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
--
-- Dumping data for table `users`
--
LOCK TABLES `users` WRITE;
INSERT INTO `users` (username, password, name) VALUES
('user1','pass','Mike Who Cheese Hairy'), ('user2','pass', 'Poopy'),('defaultBid',null,null);
UNLOCK TABLES;
--
-- Table structure for table `customer service rep`
--
DROP TABLE IF EXISTS `CustomerServiceRep`;
CREATE TABLE `CustomerServiceRep` (
  `repId` integer NOT NULL DEFAULT 0,
  `username` varchar(50) NOT NULL DEFAULT '',
  `password` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`repId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
--
-- Dumping data for table `customer service rep`
--
LOCK TABLES `CustomerServiceRep` WRITE;
INSERT INTO `CustomerServiceRep` VALUES (001,'rep1','pass','rep1@gmail.com'), (002,'rep2','pass','rep2@gmail.com');
UNLOCK TABLES;

DROP TABLE IF EXISTS `questions`;
CREATE TABLE `questions` (
  `question` varchar(200) NOT NULL DEFAULT '',
  `questionId` integer NOT NULL DEFAULT 0,
  `username` varchar(50) NOT NULL DEFAULT '',
  `answer` varchar(200) NOT NULL DEFAULT '',
  PRIMARY KEY(`questionId`,`username`),
  FOREIGN KEY (`username`) REFERENCES `users` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `questions` WRITE;
INSERT INTO `questions` (question, questionId, username, answer) values
("How do I create a new account?", 0, "user1", "Go to the home page and click on the register button under the customer header."),
("How do I sell an item?", 1, "user2", "");
UNLOCK TABLES;

--
-- Table structure for table `clothing`
--
DROP TABLE IF EXISTS `clothing`;
CREATE TABLE `clothing` (
  `itemId` integer NOT NULL DEFAULT 0,
  `initialPrice` integer NOT NULL DEFAULT 0,
  `increment` integer NOT NULL DEFAULT 0,
  `startDate` timestamp DEFAULT NULL,
  `endDate` timestamp DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `minWin` integer DEFAULT NULL,
  `clothingType` varchar(50) DEFAULT NULL,
  `rating` integer DEFAULT NULL,
  `username` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`itemId`, `username`),
FOREIGN KEY (`username`) REFERENCES `users` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `clothing`
--
LOCK TABLES `clothing` WRITE;
INSERT INTO `clothing` (itemId, initialPrice, increment, startDate, endDate, name, username, clothingType, minWin) values
(001, 5, 1, '2021-04-012 12:00:00', '2022-05-018 23:59:59', 'shirt with 1 hole', 'user1','tops', 10),
(002, 50, 2, '2021-04-012 12:00:00', '2022-05-018 23:59:59', 'roman civ 5s', 'user1','bottoms',75),
(003, 100, 5, '2021-04-012 12:00:00', '2022-05-018 23:59:59', 'hotdog hat', 'user1', 'onePieces', 125),
(004, 150, 9, '2021-04-012 12:00:00', '2022-05-018 23:59:59', 'something', 'user1', 'socks', 125);
UNLOCK TABLES;
--
-- Table structure for table `tops`
--
DROP TABLE IF EXISTS `tops`;
CREATE TABLE `tops` (
  `itemId` integer NOT NULL DEFAULT 0,
  `size` varchar(10) DEFAULT NULL,
  `color` varchar(40) DEFAULT NULL,
  `gender` char(1) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `clothingType` varchar(50) DEFAULT NULL,
  FOREIGN KEY (`itemId`) REFERENCES `clothing` (`itemId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
--
-- Dumping data for table `tops`
--
LOCK TABLES `tops` WRITE;
INSERT INTO `tops` (itemId, size, color, gender, type, clothingType) values 
(001,'Large', 'white', 'M', 'TShirt', 'tops' );
UNLOCK TABLES;
--
-- Table structure for table `bottoms`
--
DROP TABLE IF EXISTS `bottoms`;
CREATE TABLE `bottoms` (
  `itemId` integer NOT NULL DEFAULT 0,
  `size` varchar(10) DEFAULT NULL,
  `color` varchar(40) DEFAULT NULL,
  `gender` char(1) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `clothingType` varchar(50) DEFAULT NULL,
  FOREIGN KEY (`itemId`) REFERENCES `clothing` (`itemId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
--
-- Dumping data for table `bottoms`
--
LOCK TABLES `bottoms` WRITE;
INSERT INTO `bottoms` (itemId, size, color, gender, type, clothingType) values 
(002,'Large', 'white', 'M', 'Sweatpants', 'bottoms' );
UNLOCK TABLES;
--
-- Table structure for table `socks`
--
DROP TABLE IF EXISTS `socks`;
CREATE TABLE `socks` (
  `itemId` integer NOT NULL DEFAULT 0,
  `size` varchar(10) DEFAULT NULL,
  `color` varchar(40) DEFAULT NULL,
  `gender` char(1) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `clothingType` varchar(50) DEFAULT NULL,
  FOREIGN KEY (`itemId`) REFERENCES `clothing` (`itemId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
--
-- Dumping data for table `socks`
--
LOCK TABLES `socks` WRITE;
INSERT INTO `socks` (itemId, size, color, gender, type, clothingType) values 
(004,'Large', 'white', 'F', 'Ankle Socks', 'socks' );
UNLOCK TABLES;
--
-- Table structure for table `onePieces`
--
DROP TABLE IF EXISTS `onePieces`;
CREATE TABLE `onePieces` (
  `itemId` integer NOT NULL DEFAULT 0,
  `size` varchar(10) DEFAULT NULL,
  `color` varchar(40) DEFAULT NULL,
  `gender` char(1) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `clothingType` varchar(50) DEFAULT NULL,
  FOREIGN KEY (`itemId`) REFERENCES `clothing` (`itemId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
--
-- Dumping data for table `onePieces`
--
LOCK TABLES `onePieces` WRITE;
INSERT INTO `onePieces` (itemId, size, color, gender, type, clothingType) values 
(003,'Large', 'white', 'F', 'Dress', 'onePieces' );
UNLOCK TABLES;


--
-- Table structure for table `generateReports`
--
DROP TABLE IF EXISTS `generateReports`;
CREATE TABLE `generateReports` (
  `itemId` integer NOT NULL DEFAULT 0,
  `username` varchar(50) NOT NULL DEFAULT '',
  `usernameAdmin` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY(`itemId`,`usernameAdmin`,`username`),
  FOREIGN KEY (`itemId`) REFERENCES `clothing` (`itemId`),
  FOREIGN KEY (`usernameAdmin`) REFERENCES `admin` (`username`),
  FOREIGN KEY (`username`) REFERENCES `users` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
--
-- Table structure for table `bids`
--
DROP TABLE IF EXISTS `bids`;
CREATE TABLE `bids` (
  `itemId` integer NOT NULL DEFAULT 0,
  `username` varchar(50) NOT NULL DEFAULT '',
  `bidValue` integer NOT NULL DEFAULT 0,
  `maxBid` integer NOT NULL DEFAULT 0,
  `dateTime` timestamp DEFAULT NULL,
  PRIMARY KEY(`itemId`,`username`,`bidValue`,`maxBid`),
  FOREIGN KEY (`itemId`) REFERENCES `clothing` (`itemId`),
  FOREIGN KEY (`username`) REFERENCES `users` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bids`
--
LOCK TABLES `bids` WRITE;
INSERT INTO `bids` (itemId, username, bidValue, maxBid, dateTime) values
(003,'user2', 105, 105, '2021-04-010 12:00:00'),
(003,'user2', 110, 110, '2021-04-011 12:00:00'),
(003,'user2', 115, 125, '2021-04-012 12:00:00');
UNLOCK TABLES;
--
-- Table structure for table `watchlists`
--
DROP TABLE IF EXISTS `watchlists`;
CREATE TABLE `watchlists` (
  `itemId` integer NOT NULL DEFAULT 0,
  `username` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY(`itemId`,`username`),
   FOREIGN KEY (`itemId`) REFERENCES `clothing` (`itemId`),
   FOREIGN KEY (`username`) REFERENCES `users` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
--
--
--
LOCK TABLES `watchlists` WRITE;
INSERT INTO `watchlists` (itemId, username) values
(001,'user2'),
(003,'user2');
UNLOCK TABLES;
--
--
--
DROP TABLE IF EXISTS `lookingFor`;
CREATE TABLE `lookingFor` (
  `itemName` varchar(50) NOT NULL DEFAULT '',
  `username` varchar(50) NOT NULL DEFAULT '',
  
  PRIMARY KEY(`itemName`,`username`),
  FOREIGN KEY (`username`) REFERENCES `users` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;