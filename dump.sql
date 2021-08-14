-- Progettazione Web 
DROP DATABASE if exists trading; 
CREATE DATABASE trading; 
USE trading; 
-- MySQL dump 10.13  Distrib 5.6.20, for Win32 (x86)
--
-- Host: localhost    Database: trading
-- ------------------------------------------------------
-- Server version	5.6.20

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
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '',
  `code` varchar(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Cryptocurrencies','CRYP'),(2,'Currencies','CURR'),(3,'Commodities','COMM'),(4,'Indices','INDI'),(5,'Stocks','STOC');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category_rank`
--

DROP TABLE IF EXISTS `category_rank`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category_rank` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `_idcategory` int(11) NOT NULL,
  `_idrank` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `_idcategoryRel` (`_idcategory`),
  KEY `_idrankRel` (`_idrank`),
  CONSTRAINT `_idcategoryRel` FOREIGN KEY (`_idcategory`) REFERENCES `category` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `_idrankRel` FOREIGN KEY (`_idrank`) REFERENCES `rank` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category_rank`
--

LOCK TABLES `category_rank` WRITE;
/*!40000 ALTER TABLE `category_rank` DISABLE KEYS */;
INSERT INTO `category_rank` VALUES (1,1,1),(2,1,2),(3,2,2),(4,1,3),(5,2,3),(6,3,3),(7,1,4),(8,2,4),(9,3,4),(10,4,4),(11,5,4);
/*!40000 ALTER TABLE `category_rank` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deposit`
--

DROP TABLE IF EXISTS `deposit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deposit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `_iduser` int(11) NOT NULL,
  `type` varchar(2) NOT NULL DEFAULT '' COMMENT 'BF, CC, PP',
  `description` text NOT NULL COMMENT 'bank transfer, credit card, paypal',
  `amount` decimal(6,2) NOT NULL COMMENT 'max amount < 10.000',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `_iduser` (`_iduser`),
  CONSTRAINT `_iduser` FOREIGN KEY (`_iduser`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deposit`
--

LOCK TABLES `deposit` WRITE;
/*!40000 ALTER TABLE `deposit` DISABLE KEYS */;
INSERT INTO `deposit` VALUES (1,1,'PP','PayPal',1.00,'2020-06-22 08:07:41'),(2,1,'PP','PayPal',10.50,'2020-06-22 08:08:50'),(3,1,'PP','PayPal',1.00,'2020-06-22 08:28:19'),(4,1,'PP','PayPal',1.00,'2020-06-22 08:30:12'),(5,1,'PP','PayPal',1.00,'2020-06-22 08:34:28'),(6,1,'CC','Credit Card, Card Number: 5555 4444 8888, ValidThru: 12/24, Secret Code:222',1.00,'2020-06-22 08:38:23'),(7,1,'PP','PayPal, Email: ciao@tiscali.it',20.00,'2020-06-22 08:38:49'),(8,1,'BT','Bank Transfer, Fullname: Ciao Mondo, IBAN: ITXX4445556999',100.00,'2020-06-22 08:39:10'),(9,1,'PP','PayPal, Email: leonardo@gmail.com',1.13,'2020-06-22 16:36:56'),(10,19,'CC','Credit Card, Card Number: 4444, ValidThru: 45/45, Secret Code:242',1.00,'2020-06-30 20:23:25'),(11,20,'CC','Credit Card, Card Number: 2222555588889999, ValidThru: 55/66, Secret Code:123',10.00,'2020-07-05 13:59:00'),(12,20,'PP','PayPal, Email: totano@gmail.com',15.00,'2020-07-05 13:59:11'),(13,20,'BT','Bank Transfer, Fullname: Totano Pesci, IBAN: ITX888888888888888888888888',15.00,'2020-07-05 14:01:37'),(14,20,'PP','PayPal, Email: ciao@mondo.it',100.00,'2020-07-05 14:05:00'),(15,20,'CC','Credit Card, Card Number: 1234567891011121, ValidThru: 12/22, Secret Code:111',10.00,'2020-07-05 14:05:26'),(16,20,'BT','Bank Transfer, Fullname: Totano Pesci, IBAN: ITX999444555777777777PPPPPP',13.00,'2020-07-05 14:05:58'),(17,21,'CC','Credit Card, Card Number: 4445556669999999, ValidThru: 88/88, Secret Code:888',10.00,'2020-07-05 15:18:45'),(18,21,'BT','Bank Transfer, Fullname: Aldo Mori, IBAN: ITX777777777777777777777777',10.00,'2020-07-05 15:18:59'),(19,22,'CC','Credit Card, Card Number: 8888555522224444, ValidThru: 12/12, Secret Code:222',100.00,'2020-07-05 15:45:13'),(20,22,'PP','PayPal, Email: giovanni@verdi.it',10.00,'2020-07-05 15:45:24'),(21,20,'CC','Credit Card, Card Number: 4444555588889999, ValidThru: 12/12, Secret Code:222',10.00,'2020-07-06 11:53:15'),(22,20,'PP','PayPal, Email: totano@gmail.com',10.00,'2020-07-06 11:53:24'),(23,20,'BT','Bank Transfer, Fullname: Totano Rossi, IBAN: ITX888888888888888888888888',1.00,'2020-07-06 11:53:36');
/*!40000 ALTER TABLE `deposit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `goal`
--

DROP TABLE IF EXISTS `goal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `goal` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL DEFAULT '',
  `description` varchar(100) NOT NULL DEFAULT '',
  `experience` int(11) NOT NULL DEFAULT '0',
  `code` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `goal`
--

LOCK TABLES `goal` WRITE;
/*!40000 ALTER TABLE `goal` DISABLE KEYS */;
INSERT INTO `goal` VALUES (1,'First Purchase','Make the first purchase',30,'FIPU'),(2,'First Sale','Make the first sale',30,'FISA'),(3,'All Cryptocurrencies','Purchase all the cryptocurrencies',40,'ALCR'),(4,'British Lover','Purchase the Euro-Pound currency',50,'BRLO'),(5,'American Seller','Sell the Euro-American Dollar currency',50,'AMSE'),(6,'All Currencies','Purchase all the currencies',100,'ALCU'),(7,'Gold Lover','Purchase the Gold commodity',50,'GOLO'),(8,'Copper Seller','Sell the Copper commodity',50,'BRSE'),(9,'All Commodities','Purchase all the commodities',100,'ALCO');
/*!40000 ALTER TABLE `goal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `market`
--

DROP TABLE IF EXISTS `market`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `market` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `_idcategory` int(11) NOT NULL,
  `icon` varchar(100) NOT NULL DEFAULT '',
  `name` varchar(100) NOT NULL DEFAULT '',
  `code` varchar(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `_idcategory` (`_idcategory`),
  CONSTRAINT `_idcategory` FOREIGN KEY (`_idcategory`) REFERENCES `category` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `market`
--

LOCK TABLES `market` WRITE;
/*!40000 ALTER TABLE `market` DISABLE KEYS */;
INSERT INTO `market` VALUES (1,1,'BTC.png','Bitcoin','BTC'),(2,1,'BCH.png','Bitcoin Cash','BCH'),(3,1,'DASH.png','Dash','DASH'),(4,1,'LTC.png','Litecoin','LTC'),(5,2,'EUR-GBP.png','Euro-Pound','EUR-GBP'),(6,2,'EUR-AUD.png','Euro-Australian Dollar','EUR-AUD'),(7,2,'EUR-CAD.png','Euro-Canadian Dollar','EUR-CAD'),(8,2,'EUR-USD.png','Euro-American Dollar','EUR-USD'),(9,3,'COPPER.png','Copper','COPPER'),(10,3,'GOLD.png','Gold','GOLD'),(11,3,'SILVER.png','Silver','SILVER'),(12,3,'PLATINUM.png','Platinum','PLATINUM'),(13,4,'ESP35.png','Spain','ESP35'),(14,4,'FRA40.png','France','FRA40'),(15,4,'GER30.png','Germany','GER30'),(16,4,'UK100.png','United Kingdom','UK100'),(17,5,'ORCL.png','Oracle','ORCL'),(18,5,'MSFT.png','Microsoft','MSFT'),(19,5,'INTC.png','Intel','INTC'),(20,5,'AMD.png','Advanced Micro Devices','AMD'),(21,5,'NVDA.png','Nvidia','NVDA'),(22,5,'IBM.png','IBM','IBM'),(23,5,'GOOG.png','Google','GOOG');
/*!40000 ALTER TABLE `market` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `packet`
--

DROP TABLE IF EXISTS `packet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `packet` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` tinyint(4) NOT NULL,
  `credits` decimal(6,2) NOT NULL,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `packet`
--

LOCK TABLES `packet` WRITE;
/*!40000 ALTER TABLE `packet` DISABLE KEYS */;
INSERT INTO `packet` VALUES (1,1,200.00,'ultra rare'),(2,2,100.00,'rare'),(3,3,50.00,'common');
/*!40000 ALTER TABLE `packet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rank`
--

DROP TABLE IF EXISTS `rank`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rank` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `icon` varchar(100) NOT NULL DEFAULT '',
  `name` varchar(20) NOT NULL DEFAULT 'wood',
  `code` varchar(2) NOT NULL DEFAULT 'W',
  `condition` int(11) NOT NULL DEFAULT '100',
  `bonus` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rank`
--

LOCK TABLES `rank` WRITE;
/*!40000 ALTER TABLE `rank` DISABLE KEYS */;
INSERT INTO `rank` VALUES (1,'wood.png','Wood','W',0,1000),(2,'bronze.png','Bronze','B',100,500),(3,'silver.png','Silver','S',300,1000),(4,'gold.png','Gold','G',500,2000);
/*!40000 ALTER TABLE `rank` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction`
--

DROP TABLE IF EXISTS `transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transaction` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `_iduser` int(11) NOT NULL,
  `type` varchar(5) NOT NULL DEFAULT '' COMMENT 'buy, sell',
  `state` varchar(45) NOT NULL DEFAULT 'open',
  `price_buy` decimal(6,2) NOT NULL DEFAULT '0.00' COMMENT '100 < x < 999, x = price',
  `price_sell` decimal(6,2) NOT NULL DEFAULT '0.00',
  `timestamp_buy` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `timestamp_sell` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `_iduserTransaction` (`_iduser`),
  CONSTRAINT `_iduserTransaction` FOREIGN KEY (`_iduser`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=213 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction`
--

LOCK TABLES `transaction` WRITE;
/*!40000 ALTER TABLE `transaction` DISABLE KEYS */;
INSERT INTO `transaction` VALUES (1,1,'buy','open',95.00,0.00,'2020-06-04 15:20:08','2020-06-22 13:40:36'),(2,1,'buy','open',95.00,0.00,'2020-06-04 15:23:16','2020-06-22 13:40:36'),(3,1,'buy','open',95.00,0.00,'2020-06-04 15:34:13','2020-06-22 13:40:36'),(4,1,'buy','open',95.00,0.00,'2020-06-04 15:40:09','2020-06-22 13:40:36'),(5,1,'buy','open',95.00,0.00,'2020-06-04 15:40:28','2020-06-22 13:40:36'),(6,1,'buy','open',95.00,0.00,'2020-06-04 15:41:47','2020-06-22 13:40:36'),(7,1,'buy','open',95.00,0.00,'2020-06-04 15:44:49','2020-06-22 13:40:36'),(8,1,'buy','open',95.00,0.00,'2020-06-04 15:46:32','2020-06-22 13:40:36'),(9,1,'buy','open',95.00,0.00,'2020-06-04 15:50:21','2020-06-22 13:40:36'),(10,1,'buy','open',95.00,0.00,'2020-06-04 15:54:14','2020-06-22 13:40:36'),(11,1,'buy','open',95.00,0.00,'2020-06-04 15:54:18','2020-06-22 13:40:36'),(12,1,'buy','open',95.00,0.00,'2020-06-04 15:56:44','2020-06-22 13:40:36'),(13,1,'buy','open',95.00,0.00,'2020-06-04 15:58:41','2020-06-22 13:40:36'),(14,1,'buy','open',95.00,0.00,'2020-06-04 16:04:24','2020-06-22 13:40:36'),(15,1,'buy','open',95.00,0.00,'2020-06-04 16:12:03','2020-06-22 13:40:36'),(16,1,'buy','open',95.00,0.00,'2020-06-04 16:18:01','2020-06-22 13:40:36'),(17,1,'buy','open',95.00,0.00,'2020-06-04 16:18:25','2020-06-22 13:40:36'),(18,1,'buy','open',95.00,0.00,'2020-06-04 16:20:50','2020-06-22 13:40:36'),(19,1,'buy','open',95.00,0.00,'2020-06-04 16:21:33','2020-06-22 13:40:36'),(20,1,'buy','open',95.00,0.00,'2020-06-04 16:22:08','2020-06-22 13:40:36'),(21,1,'buy','open',95.00,0.00,'2020-06-04 16:22:56','2020-06-22 13:40:36'),(22,1,'buy','open',95.00,0.00,'2020-06-04 16:24:42','2020-06-22 13:40:36'),(23,1,'buy','open',95.00,0.00,'2020-06-04 16:25:53','2020-06-22 13:40:36'),(24,1,'buy','open',80.50,0.00,'2020-06-04 16:25:56','2020-06-22 13:40:36'),(25,1,'buy','open',95.00,0.00,'2020-06-04 16:27:41','2020-06-22 13:40:36'),(26,1,'buy','open',85.00,0.00,'2020-06-04 16:27:45','2020-06-22 13:40:36'),(27,1,'buy','close',60.90,0.00,'2020-06-04 16:27:48','2020-06-22 13:40:36'),(28,1,'buy','close',95.00,0.00,'2020-06-04 16:27:51','2020-06-22 13:40:36'),(29,1,'buy','close',80.50,0.00,'2020-06-04 16:27:53','2020-06-22 13:40:36'),(30,1,'buy','open',95.00,0.00,'2020-06-04 16:28:11','2020-06-22 13:40:36'),(31,1,'buy','close',95.00,0.00,'2020-06-04 16:54:22','2020-06-22 13:40:36'),(32,1,'buy','close',85.00,0.00,'2020-06-04 16:54:37','2020-06-22 13:40:36'),(33,1,'buy','close',95.00,0.00,'2020-06-05 06:29:22','2020-06-22 13:40:36'),(34,1,'buy','close',76.00,0.00,'2020-06-11 16:08:19','2020-06-22 13:40:36'),(35,1,'buy','close',1.00,0.00,'2020-06-11 16:12:43','2020-06-22 13:40:36'),(36,1,'buy','close',9.00,0.00,'2020-06-11 16:24:00','2020-06-22 13:40:36'),(37,1,'sell','open',3.00,0.00,'2020-06-11 16:47:36','2020-06-22 13:40:36'),(38,1,'sell','open',21.00,0.00,'2020-06-11 16:50:25','2020-06-22 13:40:36'),(39,1,'buy','close',68.00,0.00,'2020-06-11 16:51:22','2020-06-22 13:40:36'),(40,1,'sell','open',68.00,0.00,'2020-06-11 16:51:39','2020-06-22 13:40:36'),(41,1,'sell','open',68.00,0.00,'2020-06-11 16:52:58','2020-06-22 13:40:36'),(42,1,'sell','open',4.00,0.00,'2020-06-11 16:53:27','2020-06-22 13:40:36'),(43,1,'sell','open',14.00,0.00,'2020-06-11 16:53:55','2020-06-22 13:40:36'),(44,1,'buy','close',4.00,0.00,'2020-06-11 16:54:12','2020-06-22 13:40:36'),(45,1,'sell','open',4.00,0.00,'2020-06-11 16:54:20','2020-06-22 13:40:36'),(46,1,'sell','open',34.00,0.00,'2020-06-11 16:55:05','2020-06-22 13:40:36'),(47,1,'buy','close',70.00,0.00,'2020-06-11 16:55:24','2020-06-22 13:40:36'),(48,1,'sell','open',51.00,0.00,'2020-06-11 16:55:36','2020-06-22 13:40:36'),(49,1,'buy','close',98.00,0.00,'2020-06-11 16:55:49','2020-06-22 13:40:36'),(50,1,'sell','open',54.00,0.00,'2020-06-11 16:56:04','2020-06-22 13:40:36'),(51,1,'sell','open',10.00,0.00,'2020-06-11 17:01:07','2020-06-22 13:40:36'),(52,1,'sell','open',5.00,0.00,'2020-06-11 17:01:13','2020-06-22 13:40:36'),(53,1,'buy','close',67.00,0.00,'2020-06-22 08:22:26','2020-06-22 13:40:36'),(54,1,'sell','open',90.00,0.00,'2020-06-22 08:43:05','2020-06-22 13:40:36'),(55,1,'sell','open',95.00,0.00,'2020-06-22 08:44:00','2020-06-22 13:40:36'),(56,1,'buy','closed',6.00,0.00,'2020-06-22 08:55:51','2020-06-22 13:40:36'),(57,1,'sell','closed',75.00,0.00,'2020-06-22 08:56:12','2020-06-22 13:40:36'),(58,1,'buy','open',13.00,0.00,'2020-06-22 12:36:10','2020-06-22 13:40:36'),(59,1,'buy','open',10.00,0.00,'2020-06-22 12:36:29','2020-06-22 13:40:36'),(60,1,'buy','open',15.00,0.00,'2020-06-22 12:38:36','2020-06-22 13:40:36'),(61,1,'buy','open',15.00,0.00,'2020-06-22 12:38:53','2020-06-22 13:40:36'),(62,1,'sell','closed',1.08,1.09,'2020-06-22 13:23:41','2020-06-22 16:14:24'),(63,1,'sell','closed',1.00,0.00,'2020-06-22 13:35:57','2020-06-22 13:40:36'),(64,1,'buy','open',1.00,0.00,'2020-06-22 13:37:44','2020-06-22 13:40:36'),(65,1,'sell','closed',1.01,0.00,'2020-06-22 13:38:24','2020-06-22 13:40:36'),(66,1,'sell','closed',1.02,1.05,'2020-06-22 13:47:28','2020-06-22 14:27:46'),(67,1,'sell','closed',1.05,0.00,'2020-06-22 14:10:45','2020-06-22 14:12:47'),(68,1,'sell','closed',1.06,1.08,'2020-06-22 14:25:10','2020-06-22 14:26:17'),(69,1,'sell','closed',1.04,1.09,'2020-06-22 16:13:16','2020-06-22 16:13:46'),(70,2,'sell','closed',1.09,1.01,'2020-06-22 16:37:41','2020-06-22 16:37:50'),(71,2,'sell','closed',1.00,1.09,'2020-06-22 16:38:46','2020-06-22 16:39:02'),(72,2,'sell','closed',1.01,1.07,'2020-06-22 16:45:46','2020-06-22 16:45:55'),(73,2,'sell','closed',1.01,1.07,'2020-06-22 16:47:58','2020-06-22 16:48:05'),(74,2,'sell','closed',1.01,1.05,'2020-06-22 16:48:12','2020-06-22 16:48:20'),(75,2,'sell','closed',9.90,9.72,'2020-06-22 20:24:16','2020-06-22 20:24:43'),(76,2,'sell','closed',1.36,5.35,'2020-06-22 20:24:58','2020-06-22 20:25:05'),(77,2,'sell','closed',1.34,9.96,'2020-06-22 20:25:16','2020-06-23 10:15:23'),(78,2,'sell','closed',9.51,2.76,'2020-06-23 15:45:12','2020-06-23 15:47:33'),(79,7,'sell','closed',1.30,9.05,'2020-06-26 19:39:33','2020-06-26 19:40:30'),(80,7,'sell','closed',1.07,7.99,'2020-06-26 19:40:58','2020-06-26 19:41:11'),(81,7,'sell','closed',1.05,6.00,'2020-06-26 19:41:41','2020-06-26 19:42:00'),(82,8,'sell','closed',1.51,6.55,'2020-06-26 19:57:56','2020-06-26 20:44:46'),(83,9,'buy','open',2.20,0.00,'2020-06-26 20:02:53','2020-06-26 20:02:53'),(84,10,'buy','open',1.46,0.00,'2020-06-26 20:06:22','2020-06-26 20:06:22'),(85,10,'buy','open',1.29,0.00,'2020-06-26 20:08:31','2020-06-26 20:08:31'),(86,10,'buy','open',5.11,0.00,'2020-06-26 20:11:04','2020-06-26 20:11:04'),(87,10,'buy','open',3.06,0.00,'2020-06-26 20:11:36','2020-06-26 20:11:36'),(88,10,'sell','closed',1.87,9.96,'2020-06-26 20:12:05','2020-06-26 20:18:30'),(89,10,'buy','open',2.51,0.00,'2020-06-26 20:12:32','2020-06-26 20:12:32'),(90,8,'buy','open',7.20,0.00,'2020-06-26 20:46:06','2020-06-26 20:46:06'),(91,8,'buy','open',8.39,0.00,'2020-06-26 20:46:08','2020-06-26 20:46:08'),(92,8,'buy','open',8.37,0.00,'2020-06-26 20:46:11','2020-06-26 20:46:11'),(93,8,'buy','open',5.48,0.00,'2020-06-26 20:48:03','2020-06-26 20:48:03'),(94,11,'buy','open',1.10,0.00,'2020-06-26 20:50:18','2020-06-26 20:50:18'),(95,11,'buy','open',8.69,0.00,'2020-06-26 20:51:34','2020-06-26 20:51:34'),(96,11,'buy','open',8.13,0.00,'2020-06-26 20:51:37','2020-06-26 20:51:37'),(97,11,'buy','open',6.74,0.00,'2020-06-26 20:51:40','2020-06-26 20:51:40'),(98,12,'sell','closed',1.45,7.76,'2020-06-26 20:56:42','2020-06-26 20:57:32'),(99,12,'buy','open',5.59,0.00,'2020-06-26 20:57:11','2020-06-26 20:57:11'),(100,12,'sell','closed',2.05,6.19,'2020-06-26 20:57:14','2020-06-26 21:08:10'),(101,12,'buy','open',6.77,0.00,'2020-06-26 20:57:17','2020-06-26 20:57:17'),(102,12,'buy','open',4.63,0.00,'2020-06-26 21:13:01','2020-06-26 21:13:01'),(103,12,'buy','open',7.53,0.00,'2020-06-26 21:14:42','2020-06-26 21:14:42'),(104,12,'buy','open',5.14,0.00,'2020-06-26 21:20:46','2020-06-26 21:20:46'),(105,12,'buy','open',4.81,0.00,'2020-06-26 21:20:56','2020-06-26 21:20:56'),(106,12,'buy','open',1.42,0.00,'2020-06-26 21:23:05','2020-06-26 21:23:05'),(107,13,'sell','closed',1.39,7.80,'2020-06-26 21:28:34','2020-06-26 21:29:18'),(108,13,'buy','open',2.35,0.00,'2020-06-26 21:28:48','2020-06-26 21:28:48'),(109,13,'buy','open',2.31,0.00,'2020-06-26 21:28:50','2020-06-26 21:28:50'),(110,13,'buy','open',5.93,0.00,'2020-06-26 21:28:51','2020-06-26 21:28:51'),(111,13,'buy','open',5.54,0.00,'2020-06-26 21:28:56','2020-06-26 21:28:56'),(112,13,'buy','open',9.88,0.00,'2020-06-26 21:36:01','2020-06-26 21:36:01'),(113,13,'buy','open',7.32,0.00,'2020-06-26 21:36:03','2020-06-26 21:36:03'),(114,13,'buy','open',1.83,0.00,'2020-06-26 21:36:05','2020-06-26 21:36:05'),(115,13,'buy','open',8.52,0.00,'2020-06-26 21:36:07','2020-06-26 21:36:07'),(116,14,'sell','closed',1.68,2.21,'2020-06-26 21:38:34','2020-06-26 21:38:45'),(117,14,'buy','open',6.56,0.00,'2020-06-26 21:38:36','2020-06-26 21:38:36'),(118,14,'buy','open',2.96,0.00,'2020-06-26 21:38:37','2020-06-26 21:38:37'),(119,14,'buy','open',5.58,0.00,'2020-06-26 21:38:38','2020-06-26 21:38:38'),(120,15,'buy','open',2.88,0.00,'2020-06-26 21:40:37','2020-06-26 21:40:37'),(121,15,'sell','closed',4.16,8.13,'2020-06-26 21:40:38','2020-06-26 21:40:43'),(122,15,'buy','open',4.29,0.00,'2020-06-26 21:40:39','2020-06-26 21:40:39'),(123,15,'buy','open',9.81,0.00,'2020-06-26 21:40:40','2020-06-26 21:40:40'),(124,16,'sell','closed',1.65,7.33,'2020-06-28 14:55:26','2020-06-28 14:58:28'),(125,16,'buy','open',2.35,0.00,'2020-06-28 14:59:37','2020-06-28 14:59:37'),(126,16,'buy','open',1.62,0.00,'2020-06-28 14:59:50','2020-06-28 14:59:50'),(127,16,'buy','open',1.36,0.00,'2020-06-28 14:59:51','2020-06-28 14:59:51'),(128,17,'sell','closed',1.64,6.48,'2020-06-28 15:12:51','2020-06-28 15:13:08'),(129,17,'buy','open',8.35,0.00,'2020-06-28 15:12:58','2020-06-28 15:12:58'),(130,17,'buy','open',4.43,0.00,'2020-06-28 15:13:00','2020-06-28 15:13:00'),(131,17,'buy','open',7.08,0.00,'2020-06-28 15:13:01','2020-06-28 15:13:01'),(132,18,'sell','closed',2.73,9.73,'2020-06-28 16:14:51','2020-06-28 16:18:46'),(133,18,'buy','open',3.47,0.00,'2020-06-28 16:19:04','2020-06-28 16:19:04'),(134,18,'buy','open',9.15,0.00,'2020-06-28 16:19:06','2020-06-28 16:19:06'),(135,18,'buy','open',8.68,0.00,'2020-06-28 16:19:07','2020-06-28 16:19:07'),(136,18,'sell','closed',4.82,2.81,'2020-06-28 16:35:51','2020-06-28 16:40:51'),(137,18,'sell','closed',4.75,1.14,'2020-06-28 16:39:04','2020-06-28 16:40:51'),(138,18,'sell','closed',4.42,3.56,'2020-06-28 16:40:48','2020-06-28 16:40:52'),(139,18,'buy','open',6.01,0.00,'2020-06-28 16:40:57','2020-06-28 16:40:57'),(140,19,'sell','closed',3.92,5.36,'2020-06-28 16:43:23','2020-07-01 10:12:37'),(141,19,'buy','open',9.37,0.00,'2020-06-28 16:43:26','2020-06-28 16:43:26'),(142,19,'sell','closed',3.76,9.81,'2020-06-28 16:43:27','2020-07-01 10:13:18'),(143,19,'sell','closed',5.98,8.09,'2020-06-28 16:43:28','2020-06-28 16:43:37'),(144,19,'buy','open',7.50,0.00,'2020-06-28 16:44:08','2020-06-28 16:44:08'),(145,19,'buy','open',7.00,0.00,'2020-06-28 16:44:18','2020-06-28 16:44:18'),(146,19,'buy','open',9.07,0.00,'2020-06-28 16:44:21','2020-06-28 16:44:21'),(147,19,'sell','closed',4.82,5.12,'2020-06-28 16:44:23','2020-06-28 16:53:50'),(148,19,'buy','open',4.96,0.00,'2020-06-28 16:54:19','2020-06-28 16:54:19'),(149,19,'sell','closed',9.06,3.22,'2020-06-28 16:54:52','2020-06-28 16:55:34'),(150,19,'sell','closed',1.77,6.41,'2020-06-28 16:55:43','2020-06-28 16:57:11'),(151,19,'buy','open',4.39,0.00,'2020-06-28 16:55:45','2020-06-28 16:55:45'),(152,19,'buy','open',9.59,0.00,'2020-06-28 16:57:00','2020-06-28 16:57:00'),(153,19,'sell','closed',1.86,8.16,'2020-06-28 16:57:05','2020-07-01 10:12:40'),(154,19,'sell','closed',1.85,5.91,'2020-06-30 20:02:19','2020-07-01 10:12:49'),(155,20,'sell','closed',2.83,9.79,'2020-07-02 06:27:14','2020-07-02 06:27:39'),(156,20,'buy','open',7.60,0.00,'2020-07-02 06:27:50','2020-07-02 06:27:50'),(157,20,'buy','open',1.66,0.00,'2020-07-02 06:27:51','2020-07-02 06:27:51'),(158,20,'sell','closed',5.63,1.62,'2020-07-02 06:27:53','2020-07-06 10:16:07'),(159,20,'sell','closed',2.96,6.11,'2020-07-02 06:30:44','2020-07-02 06:30:54'),(160,20,'sell','closed',2.38,9.65,'2020-07-02 06:30:47','2020-07-05 14:47:17'),(161,20,'sell','closed',6.90,3.82,'2020-07-02 06:30:59','2020-07-05 14:47:22'),(162,20,'sell','closed',8.19,6.95,'2020-07-02 06:31:00','2020-07-06 10:16:25'),(163,20,'buy','open',9.34,0.00,'2020-07-05 14:52:30','2020-07-05 14:52:30'),(164,20,'sell','closed',4.98,6.47,'2020-07-05 14:53:31','2020-07-05 14:53:36'),(165,20,'sell','closed',8.91,7.41,'2020-07-05 14:53:42','2020-07-06 11:52:30'),(166,20,'sell','closed',9.06,4.26,'2020-07-05 14:53:45','2020-07-06 11:52:33'),(167,21,'sell','closed',3.06,6.29,'2020-07-05 15:14:31','2020-07-05 15:14:52'),(168,21,'buy','open',5.49,0.00,'2020-07-05 15:14:42','2020-07-05 15:14:42'),(169,21,'sell','closed',2.55,7.41,'2020-07-05 15:15:02','2020-07-05 15:15:30'),(170,21,'buy','open',7.88,0.00,'2020-07-05 15:15:04','2020-07-05 15:15:04'),(171,21,'sell','closed',1.70,4.85,'2020-07-05 15:15:25','2020-07-05 15:19:16'),(172,21,'sell','closed',3.68,4.35,'2020-07-05 15:16:09','2020-07-05 15:16:34'),(173,21,'sell','closed',5.46,6.42,'2020-07-05 15:16:17','2020-07-05 15:16:37'),(174,21,'buy','open',3.25,0.00,'2020-07-05 15:16:24','2020-07-05 15:16:24'),(175,21,'buy','open',2.82,0.00,'2020-07-05 15:17:02','2020-07-05 15:17:02'),(176,21,'buy','open',1.73,0.00,'2020-07-05 15:17:07','2020-07-05 15:17:07'),(177,21,'sell','closed',2.43,9.88,'2020-07-05 15:17:14','2020-07-05 15:18:19'),(178,21,'buy','open',2.23,0.00,'2020-07-05 15:17:17','2020-07-05 15:17:17'),(179,21,'sell','closed',4.78,8.91,'2020-07-05 15:19:07','2020-07-05 15:19:32'),(180,22,'sell','closed',3.11,3.21,'2020-07-05 15:43:32','2020-07-05 16:09:37'),(181,22,'sell','closed',2.26,5.94,'2020-07-05 15:43:35','2020-07-05 16:09:36'),(182,22,'sell','closed',1.61,8.64,'2020-07-05 15:43:36','2020-07-05 15:43:45'),(183,22,'sell','closed',4.06,8.85,'2020-07-05 15:43:38','2020-07-05 16:09:35'),(184,22,'buy','open',2.24,0.00,'2020-07-05 15:43:58','2020-07-05 15:43:58'),(185,22,'buy','open',7.96,0.00,'2020-07-05 15:44:00','2020-07-05 15:44:00'),(186,22,'sell','closed',3.75,9.68,'2020-07-05 15:44:02','2020-07-05 15:44:13'),(187,22,'sell','closed',3.01,6.71,'2020-07-05 15:44:05','2020-07-05 16:09:44'),(188,22,'sell','closed',1.60,7.12,'2020-07-05 15:44:24','2020-07-05 15:46:30'),(189,22,'sell','closed',1.41,5.30,'2020-07-05 15:44:27','2020-07-05 15:46:24'),(190,22,'sell','closed',1.21,6.70,'2020-07-05 15:44:34','2020-07-05 15:44:48'),(191,22,'buy','open',3.80,0.00,'2020-07-05 15:44:38','2020-07-05 15:44:38'),(192,22,'buy','open',5.80,0.00,'2020-07-05 15:46:20','2020-07-05 15:46:20'),(193,22,'sell','closed',4.33,6.06,'2020-07-05 15:46:45','2020-07-05 15:46:56'),(194,20,'buy','open',1.17,0.00,'2020-07-06 10:16:02','2020-07-06 10:16:02'),(195,20,'sell','closed',7.57,4.87,'2020-07-06 11:52:40','2020-07-06 11:52:45'),(196,23,'sell','closed',3.29,7.62,'2020-07-06 12:01:26','2020-07-06 12:01:48'),(197,23,'buy','open',9.41,0.00,'2020-07-06 12:01:36','2020-07-06 12:01:36'),(198,23,'buy','open',7.18,0.00,'2020-07-06 12:01:39','2020-07-06 12:01:39'),(199,23,'buy','open',9.83,0.00,'2020-07-06 12:01:42','2020-07-06 12:01:42'),(200,23,'sell','closed',6.59,9.10,'2020-07-06 12:01:59','2020-07-06 12:02:25'),(201,23,'buy','open',9.23,0.00,'2020-07-06 12:02:02','2020-07-06 12:02:02'),(202,23,'buy','open',1.69,0.00,'2020-07-06 12:02:05','2020-07-06 12:02:05'),(203,23,'buy','open',1.64,0.00,'2020-07-06 12:02:10','2020-07-06 12:02:10'),(204,23,'buy','open',6.15,0.00,'2020-07-06 12:02:42','2020-07-06 12:02:42'),(205,23,'sell','closed',2.41,9.13,'2020-07-06 12:02:45','2020-07-06 12:02:57'),(206,23,'buy','open',2.00,0.00,'2020-07-06 12:02:48','2020-07-06 12:02:48'),(207,23,'buy','open',7.27,0.00,'2020-07-06 12:02:52','2020-07-06 12:02:52'),(208,23,'buy','open',6.94,0.00,'2020-07-06 12:03:19','2020-07-06 12:03:19'),(209,23,'buy','open',1.53,0.00,'2020-07-06 12:03:23','2020-07-06 12:03:23'),(210,23,'buy','open',8.26,0.00,'2020-07-06 12:03:26','2020-07-06 12:03:26'),(211,23,'sell','closed',5.44,6.46,'2020-07-06 12:03:33','2020-07-06 12:03:48'),(212,23,'sell','closed',8.07,2.36,'2020-07-06 12:03:35','2020-07-06 12:03:51');
/*!40000 ALTER TABLE `transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction_market`
--

DROP TABLE IF EXISTS `transaction_market`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transaction_market` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `_idtransaction` int(11) NOT NULL,
  `_idmarket` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `_idmarketRel` (`_idmarket`),
  KEY `_idtransactionRel` (`_idtransaction`),
  CONSTRAINT `_idmarketRel` FOREIGN KEY (`_idmarket`) REFERENCES `market` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `_idtransactionRel` FOREIGN KEY (`_idtransaction`) REFERENCES `transaction` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=212 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction_market`
--

LOCK TABLES `transaction_market` WRITE;
/*!40000 ALTER TABLE `transaction_market` DISABLE KEYS */;
INSERT INTO `transaction_market` VALUES (1,2,1),(2,3,1),(3,4,1),(4,5,1),(5,6,1),(6,7,1),(7,8,1),(8,9,1),(9,10,1),(10,11,1),(11,12,1),(12,13,1),(13,14,1),(14,15,1),(15,16,1),(16,17,1),(17,18,1),(18,19,1),(19,20,1),(20,21,1),(21,22,1),(22,23,1),(23,24,2),(24,25,1),(25,26,3),(26,27,4),(27,28,1),(28,29,2),(29,30,1),(30,31,1),(31,32,3),(32,33,1),(33,34,1),(34,35,2),(35,36,3),(36,37,3),(37,38,2),(38,39,1),(39,40,1),(40,41,1),(41,42,2),(42,43,3),(43,44,2),(44,45,2),(45,46,1),(46,47,4),(47,48,4),(48,49,1),(49,50,1),(50,51,1),(51,52,4),(52,53,1),(53,54,1),(54,55,1),(55,56,4),(56,57,4),(57,58,1),(58,59,2),(59,60,4),(60,61,2),(61,62,2),(62,63,2),(63,64,3),(64,65,3),(65,66,2),(66,67,4),(67,68,3),(68,69,4),(69,70,1),(70,71,3),(71,72,2),(72,73,2),(73,74,4),(74,75,2),(75,76,3),(76,77,1),(77,78,1),(78,79,4),(79,80,4),(80,81,4),(81,82,3),(82,83,4),(83,84,2),(84,85,3),(85,86,4),(86,87,4),(87,88,1),(88,89,1),(89,90,4),(90,91,2),(91,92,1),(92,93,3),(93,94,4),(94,95,3),(95,96,2),(96,97,1),(97,98,1),(98,99,2),(99,100,3),(100,101,4),(101,102,8),(102,103,6),(103,104,5),(104,105,7),(105,106,6),(106,107,2),(107,108,4),(108,109,3),(109,110,2),(110,111,1),(111,112,8),(112,113,6),(113,114,7),(114,115,5),(115,116,1),(116,117,2),(117,118,3),(118,119,4),(119,120,2),(120,121,3),(121,122,4),(122,123,1),(123,124,3),(124,125,1),(125,126,2),(126,127,4),(127,128,1),(128,129,2),(129,130,3),(130,131,4),(131,132,3),(132,133,4),(133,134,2),(134,135,1),(135,136,5),(136,137,5),(137,138,5),(138,139,5),(139,140,1),(140,141,2),(141,142,3),(142,143,4),(143,144,5),(144,145,7),(145,146,6),(146,147,8),(147,148,10),(148,149,9),(149,150,12),(150,151,11),(151,152,20),(152,153,18),(153,154,2),(154,155,3),(155,156,4),(156,157,2),(157,158,1),(158,159,8),(159,160,5),(160,161,6),(161,162,7),(162,163,10),(163,164,9),(164,165,12),(165,166,11),(166,167,2),(167,168,1),(168,169,3),(169,170,4),(170,171,7),(171,172,5),(172,173,8),(173,174,6),(174,175,11),(175,176,12),(176,177,9),(177,178,10),(178,179,20),(179,180,1),(180,181,3),(181,182,2),(182,183,4),(183,184,7),(184,185,6),(185,186,8),(186,187,5),(187,188,12),(188,189,11),(189,190,9),(190,191,10),(191,192,1),(192,193,20),(193,194,1),(194,195,18),(195,196,4),(196,197,3),(197,198,2),(198,199,1),(199,200,8),(200,201,6),(201,202,7),(202,203,5),(203,204,12),(204,205,9),(205,206,10),(206,207,11),(207,208,20),(208,209,17),(209,210,21),(210,211,1),(211,212,1);
/*!40000 ALTER TABLE `transaction_market` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `_idrank` int(11) NOT NULL DEFAULT '1',
  `username` varchar(100) NOT NULL DEFAULT '',
  `password` varchar(255) NOT NULL DEFAULT '',
  `email` varchar(100) NOT NULL DEFAULT '',
  `name` varchar(100) NOT NULL DEFAULT '',
  `surname` varchar(100) NOT NULL DEFAULT '',
  `wallet` decimal(11,2) NOT NULL DEFAULT '1000.00',
  `experience` int(11) NOT NULL DEFAULT '0',
  `role` varchar(50) NOT NULL DEFAULT 'user',
  `banned` tinyint(4) NOT NULL DEFAULT '0',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  UNIQUE KEY `username_UNIQUE` (`username`),
  KEY `_idrank` (`_idrank`),
  CONSTRAINT `_idrank` FOREIGN KEY (`_idrank`) REFERENCES `rank` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,1,'ciao','mondo','ciao@mondo.it','ciao','mondo',361.30,0,'user',0,'2020-07-01 07:49:33'),(2,2,'leonardo','dalleluche','leonardo@luche.it','leonardo','dalleluche',1005.85,0,'user',0,'2020-07-01 07:49:33'),(4,1,'admin','admin','admin@gmail.com','admin','admin',0.00,0,'admin',0,'2020-07-01 07:49:33'),(5,1,'leonardo1','ciaomondo','leonardo@outlook.it','leonardo','dalleluche',1000.00,0,'user',1,'2020-07-01 07:49:33'),(6,1,'lorenzo','ciaomondo','lorenzo@gmail.com','lorenzo','dalleluche',1000.00,0,'user',0,'2020-07-01 07:49:33'),(7,1,'alessandro','ciaomondo','ale@outlook.it','test','test',1019.62,0,'user',1,'2020-07-01 07:49:33'),(8,1,'mario','rossi12','mario@rossi.it','mario','rossi',975.60,100,'user',0,'2020-07-01 07:49:33'),(9,1,'marco','verdi1','marco@verdi.it','marco','verdi',997.80,30,'user',0,'2020-07-01 07:49:33'),(10,1,'tiziano','gialli1','tiziano@gialli.com','tiziano','gialli',994.66,60,'user',0,'2020-07-01 07:49:33'),(11,1,'piero','blu123','pero@blu.it','piero','blu',975.34,30,'user',1,'2020-07-01 07:49:33'),(12,1,'riccardo','ferri1','riccardo@gmail.com','riccardo','ferri',974.56,280,'user',0,'2020-07-01 07:49:33'),(13,1,'angelo','angeli1','angelo@gmail.com','angelo','angeli',962.73,200,'user',1,'2020-07-01 07:49:33'),(14,1,'luca','rossi1','luca@rossi.it','luca','rossi',985.43,100,'user',0,'2020-07-01 07:49:33'),(15,1,'pierino','pierino1','pierino@gmail.com','pierino','rossi',986.99,100,'user',0,'2020-07-01 07:49:33'),(16,1,'marco12','marco1','marco@rossi.it','marco','rossi',1000.35,100,'user',0,'2020-07-01 07:49:33'),(17,1,'leonardo12','leonardo1','leonardo@hotmail.it','leonardo','dalle',1184.98,100,'user',0,'2020-07-01 07:49:33'),(18,1,'pierino1','ciaomondo','pierino@hotmail.it','pierino','tona',1023.21,100,'user',1,'2020-07-01 07:49:33'),(19,1,'loreno','ciaomondo','loreno@verdi.it','loreno','verdi',1668.18,500,'user',0,'2020-07-01 07:49:33'),(20,4,'totano','ciaomondo','totano@hotmail.it','totano','ciao',1765.77,500,'user',0,'2020-07-02 06:26:23'),(21,4,'aldo','aldomori1','aldo@mori.it','Aldo','Mori',1771.05,500,'user',0,'2020-07-05 15:14:12'),(22,4,'giovanni','giovanni42','giovanni@verdi.it','Giovanni','Verdi',1832.06,500,'user',0,'2020-07-05 15:43:21'),(23,4,'marco33','marco33','marco@gialli.com','Marco','Gialli',1087.74,500,'user',0,'2020-07-06 11:55:50');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_goal`
--

DROP TABLE IF EXISTS `user_goal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_goal` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `_iduser` int(11) NOT NULL,
  `_idgoal` int(11) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `unlocked` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `_idgoalRel` (`_idgoal`),
  KEY `_iduserRel` (`_iduser`),
  CONSTRAINT `_idgoalRel` FOREIGN KEY (`_idgoal`) REFERENCES `goal` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `_iduserRel` FOREIGN KEY (`_iduser`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=154 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_goal`
--

LOCK TABLES `user_goal` WRITE;
/*!40000 ALTER TABLE `user_goal` DISABLE KEYS */;
INSERT INTO `user_goal` VALUES (1,7,1,'2020-06-24 08:49:20',0),(2,7,2,'2020-06-24 08:49:20',0),(3,7,3,'2020-06-24 08:49:20',0),(4,7,4,'2020-06-24 08:49:20',0),(5,7,5,'2020-06-24 08:49:20',0),(6,7,6,'2020-06-24 08:49:20',0),(7,7,7,'2020-06-24 08:49:20',0),(8,7,8,'2020-06-24 08:49:20',0),(9,7,9,'2020-06-24 08:49:20',0),(10,8,1,'2020-06-26 19:57:42',1),(11,8,2,'2020-06-26 19:57:42',1),(12,8,3,'2020-06-26 19:57:42',1),(13,8,4,'2020-06-26 19:57:42',0),(14,8,5,'2020-06-26 19:57:42',0),(15,8,6,'2020-06-26 19:57:42',0),(16,8,7,'2020-06-26 19:57:42',0),(17,8,8,'2020-06-26 19:57:42',0),(18,8,9,'2020-06-26 19:57:42',0),(19,9,1,'2020-06-26 20:01:49',0),(20,9,2,'2020-06-26 20:01:49',0),(21,9,3,'2020-06-26 20:01:49',0),(22,9,4,'2020-06-26 20:01:49',0),(23,9,5,'2020-06-26 20:01:49',0),(24,9,6,'2020-06-26 20:01:49',0),(25,9,7,'2020-06-26 20:01:49',0),(26,9,8,'2020-06-26 20:01:49',0),(27,9,9,'2020-06-26 20:01:49',0),(28,10,1,'2020-06-26 20:06:13',1),(29,10,2,'2020-06-26 20:06:13',1),(30,10,3,'2020-06-26 20:06:13',0),(31,10,4,'2020-06-26 20:06:13',0),(32,10,5,'2020-06-26 20:06:13',0),(33,10,6,'2020-06-26 20:06:13',0),(34,10,7,'2020-06-26 20:06:13',0),(35,10,8,'2020-06-26 20:06:13',0),(36,10,9,'2020-06-26 20:06:13',0),(37,11,1,'2020-06-26 20:50:08',1),(38,11,2,'2020-06-26 20:50:08',0),(39,11,3,'2020-06-26 20:50:08',0),(40,11,4,'2020-06-26 20:50:08',0),(41,11,5,'2020-06-26 20:50:08',0),(42,11,6,'2020-06-26 20:50:08',0),(43,11,7,'2020-06-26 20:50:08',0),(44,11,8,'2020-06-26 20:50:08',0),(45,11,9,'2020-06-26 20:50:08',0),(46,12,1,'2020-06-26 20:56:34',1),(47,12,2,'2020-06-26 20:56:34',1),(48,12,3,'2020-06-26 20:56:34',1),(49,12,4,'2020-06-26 20:56:34',0),(50,12,5,'2020-06-26 20:56:34',0),(51,12,6,'2020-06-26 20:56:34',1),(52,12,7,'2020-06-26 20:56:34',0),(53,12,8,'2020-06-26 20:56:34',0),(54,12,9,'2020-06-26 20:56:34',0),(55,13,1,'2020-06-26 21:28:11',1),(56,13,2,'2020-06-26 21:28:11',1),(57,13,3,'2020-06-26 21:28:11',1),(58,13,4,'2020-06-26 21:28:11',0),(59,13,5,'2020-06-26 21:28:11',0),(60,13,6,'2020-06-26 21:28:11',1),(61,13,7,'2020-06-26 21:28:11',0),(62,13,8,'2020-06-26 21:28:11',0),(63,13,9,'2020-06-26 21:28:11',0),(64,14,1,'2020-06-26 21:38:25',1),(65,14,2,'2020-06-26 21:38:25',1),(66,14,3,'2020-06-26 21:38:25',1),(67,14,4,'2020-06-26 21:38:25',0),(68,14,5,'2020-06-26 21:38:25',0),(69,14,6,'2020-06-26 21:38:25',0),(70,14,7,'2020-06-26 21:38:25',0),(71,14,8,'2020-06-26 21:38:25',0),(72,14,9,'2020-06-26 21:38:25',0),(73,15,1,'2020-06-26 21:40:29',1),(74,15,2,'2020-06-26 21:40:29',1),(75,15,3,'2020-06-26 21:40:29',1),(76,15,4,'2020-06-26 21:40:29',0),(77,15,5,'2020-06-26 21:40:29',0),(78,15,6,'2020-06-26 21:40:29',0),(79,15,7,'2020-06-26 21:40:29',0),(80,15,8,'2020-06-26 21:40:29',0),(81,15,9,'2020-06-26 21:40:29',0),(82,16,1,'2020-06-28 14:55:13',1),(83,16,2,'2020-06-28 14:55:13',1),(84,16,3,'2020-06-28 14:55:13',1),(85,16,4,'2020-06-28 14:55:13',0),(86,16,5,'2020-06-28 14:55:13',0),(87,16,6,'2020-06-28 14:55:13',0),(88,16,7,'2020-06-28 14:55:13',0),(89,16,8,'2020-06-28 14:55:13',0),(90,16,9,'2020-06-28 14:55:13',0),(91,17,1,'2020-06-28 15:12:40',1),(92,17,2,'2020-06-28 15:12:40',1),(93,17,3,'2020-06-28 15:12:40',1),(94,17,4,'2020-06-28 15:12:40',0),(95,17,5,'2020-06-28 15:12:40',0),(96,17,6,'2020-06-28 15:12:40',0),(97,17,7,'2020-06-28 15:12:40',0),(98,17,8,'2020-06-28 15:12:40',0),(99,17,9,'2020-06-28 15:12:40',0),(100,18,1,'2020-06-28 16:13:35',1),(101,18,2,'2020-06-28 16:13:35',1),(102,18,3,'2020-06-28 16:13:35',1),(103,18,4,'2020-06-28 16:13:35',0),(104,18,5,'2020-06-28 16:13:35',0),(105,18,6,'2020-06-28 16:13:35',0),(106,18,7,'2020-06-28 16:13:35',0),(107,18,8,'2020-06-28 16:13:35',0),(108,18,9,'2020-06-28 16:13:35',0),(109,19,1,'2020-06-28 16:41:39',1),(110,19,2,'2020-06-28 16:41:39',1),(111,19,3,'2020-06-28 16:41:39',1),(112,19,4,'2020-06-28 16:41:39',1),(113,19,5,'2020-06-28 16:41:39',1),(114,19,6,'2020-06-28 16:41:39',1),(115,19,7,'2020-06-28 16:41:39',1),(116,19,8,'2020-06-28 16:41:39',1),(117,19,9,'2020-06-28 16:41:39',1),(118,20,1,'2020-07-02 06:26:23',1),(119,20,2,'2020-07-02 06:26:23',1),(120,20,3,'2020-07-02 06:26:23',1),(121,20,4,'2020-07-02 06:26:23',1),(122,20,5,'2020-07-02 06:26:23',1),(123,20,6,'2020-07-02 06:26:23',1),(124,20,7,'2020-07-02 06:26:23',1),(125,20,8,'2020-07-02 06:26:23',1),(126,20,9,'2020-07-02 06:26:23',1),(127,21,1,'2020-07-05 15:14:12',1),(128,21,2,'2020-07-05 15:14:12',1),(129,21,3,'2020-07-05 15:14:12',1),(130,21,4,'2020-07-05 15:14:12',1),(131,21,5,'2020-07-05 15:14:12',1),(132,21,6,'2020-07-05 15:14:12',1),(133,21,7,'2020-07-05 15:14:12',1),(134,21,8,'2020-07-05 15:14:12',1),(135,21,9,'2020-07-05 15:14:12',1),(136,22,1,'2020-07-05 15:43:21',1),(137,22,2,'2020-07-05 15:43:21',1),(138,22,3,'2020-07-05 15:43:21',1),(139,22,4,'2020-07-05 15:43:21',1),(140,22,5,'2020-07-05 15:43:21',1),(141,22,6,'2020-07-05 15:43:21',1),(142,22,7,'2020-07-05 15:43:21',1),(143,22,8,'2020-07-05 15:43:21',1),(144,22,9,'2020-07-05 15:43:21',1),(145,23,1,'2020-07-06 11:55:50',1),(146,23,2,'2020-07-06 11:55:50',1),(147,23,3,'2020-07-06 11:55:50',1),(148,23,4,'2020-07-06 11:55:50',1),(149,23,5,'2020-07-06 11:55:50',1),(150,23,6,'2020-07-06 11:55:50',1),(151,23,7,'2020-07-06 11:55:50',1),(152,23,8,'2020-07-06 11:55:50',1),(153,23,9,'2020-07-06 11:55:50',1);
/*!40000 ALTER TABLE `user_goal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_packet`
--

DROP TABLE IF EXISTS `user_packet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_packet` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `_iduser` int(11) NOT NULL,
  `_idpacket` int(11) NOT NULL,
  `closed` tinyint(4) NOT NULL DEFAULT '1',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `_idpacket` (`_idpacket`),
  KEY `_iduserPacket` (`_iduser`),
  CONSTRAINT `_idpacket` FOREIGN KEY (`_idpacket`) REFERENCES `packet` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `_iduserPacket` FOREIGN KEY (`_iduser`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_packet`
--

LOCK TABLES `user_packet` WRITE;
/*!40000 ALTER TABLE `user_packet` DISABLE KEYS */;
INSERT INTO `user_packet` VALUES (1,1,2,1,'2020-06-26 21:33:46'),(2,17,2,0,'2020-06-28 15:13:08'),(3,18,3,0,'2020-06-28 16:19:07'),(4,19,2,0,'2020-06-28 16:43:37'),(5,19,1,0,'2020-06-28 16:53:50'),(6,19,3,0,'2020-06-28 16:55:45'),(7,19,3,0,'2020-06-30 20:02:19'),(8,19,2,0,'2020-06-30 20:02:19'),(9,19,1,0,'2020-06-30 20:02:19'),(10,19,3,0,'2020-07-01 07:42:04'),(12,19,3,0,'2020-07-01 10:12:37'),(13,19,3,0,'2020-07-01 10:12:37'),(14,19,3,0,'2020-07-01 10:12:37'),(15,20,3,0,'2020-07-02 06:27:53'),(16,20,3,0,'2020-07-02 06:31:00'),(17,20,2,0,'2020-07-02 06:35:45'),(18,20,1,0,'2020-07-02 06:55:16'),(19,20,2,0,'2020-07-03 09:16:31'),(20,20,3,0,'2020-07-05 14:53:45'),(21,21,3,0,'2020-07-05 15:15:04'),(22,21,1,0,'2020-07-05 15:16:37'),(23,21,3,0,'2020-07-05 15:18:19'),(24,21,2,0,'2020-07-05 15:21:18'),(25,21,3,0,'2020-07-05 15:26:08'),(26,21,3,0,'2020-07-05 15:34:14'),(27,21,1,0,'2020-07-05 15:35:50'),(28,21,2,0,'2020-07-05 15:35:51'),(29,21,1,0,'2020-07-05 15:36:02'),(30,21,1,0,'2020-07-05 15:36:03'),(31,21,2,0,'2020-07-05 15:40:17'),(32,21,1,1,'2020-07-05 15:40:18'),(33,21,2,1,'2020-07-05 15:40:22'),(34,17,2,1,'2020-07-05 15:41:08'),(35,13,1,1,'2020-07-05 15:41:14'),(36,22,3,0,'2020-07-05 15:43:45'),(37,22,1,0,'2020-07-05 15:44:13'),(38,22,1,0,'2020-07-05 15:44:48'),(39,22,1,0,'2020-07-05 15:46:06'),(40,22,3,0,'2020-07-05 16:09:23'),(41,20,1,1,'2020-07-06 10:16:59'),(42,20,3,0,'2020-07-06 10:17:05'),(43,11,3,1,'2020-07-06 11:52:01'),(44,23,3,0,'2020-07-06 12:01:48'),(45,23,3,0,'2020-07-06 12:02:25'),(46,23,3,0,'2020-07-06 12:02:57');
/*!40000 ALTER TABLE `user_packet` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-07-06 14:12:32
