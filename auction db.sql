CREATE DATABASE  IF NOT EXISTS `RUClothing`;
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
`user_id` integer NOT NULL DEFAULT 0,
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
INSERT INTO `users` (username, password, name) VALUES ('user1','pass','Mike Who Cheese Hairy'), ('user2','pass', 'Poopy'),('default_bid',null,null);
UNLOCK TABLES;
--
-- Table structure for table `customer service rep`
--
DROP TABLE IF EXISTS `CustomerServiceRep`;
CREATE TABLE `CustomerServiceRep` (
  `rep_id` integer NOT NULL DEFAULT 0,
  `username` varchar(50) NOT NULL DEFAULT '',
  `password` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`rep_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
--
-- Dumping data for table `customer service rep`
--
LOCK TABLES `CustomerServiceRep` WRITE;
INSERT INTO `CustomerServiceRep` VALUES (001,'rep1','pass','rep1@gmail.com'), (002,'rep2','pass','rep2@gmail.com');
UNLOCK TABLES;