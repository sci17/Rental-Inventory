-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: finalldrill
-- ------------------------------------------------------
-- Server version	8.0.36

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts` (
  `account_id` int NOT NULL AUTO_INCREMENT,
  `account_name` varchar(45) NOT NULL,
  `payment_method_code` int NOT NULL,
  `customer_id` int NOT NULL,
  `account_details` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`account_id`),
  KEY `fk_ACCOUNTS_PAYMENT_METHODS1_idx` (`payment_method_code`),
  KEY `fk_ACCOUNTS_CUSTOMERS1_idx` (`customer_id`),
  CONSTRAINT `fk_ACCOUNTS_CUSTOMERS1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  CONSTRAINT `fk_ACCOUNTS_PAYMENT_METHODS1` FOREIGN KEY (`payment_method_code`) REFERENCES `payment_methods` (`payment_method_code`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT INTO `accounts` VALUES (1,'Josh Santos',1,1,'Savings'),(2,'Jasper White MD',2,2,'Quo ut nobis voluptates suscipit dignissimos '),(3,'Vinnie Mayert',3,3,'Libero vel sequi recusandae vel nam.'),(4,'Gregory Schiller',4,4,'Repellendus illo officiis autem et enim delec'),(5,'Florence Harris',5,5,'Consectetur ut optio quae nemo praesentium su'),(6,'Winston Swift',6,6,'Molestiae asperiores quos eos ipsam corporis '),(7,'Prof. Paris Hintz Sr.',7,7,'Nostrum totam voluptates qui qui molestiae au'),(8,'Cecile Goldner DVM',8,8,'Ut qui minima aperiam et.'),(9,'Prof. Nikko Blick',9,9,'Sit magnam ut deserunt eaque ut est nobis max'),(10,'Enoch Hessel',10,10,'Perferendis deserunt ea adipisci eos quia.'),(11,'Dr. Jason Lakin IV',11,11,'Eos neque sit autem fugit labore.'),(12,'Damian Abernathy',12,12,'Animi animi aspernatur rerum et velit necessi'),(13,'Francisco Labadie',13,13,'Iusto autem mollitia distinctio repudiandae d'),(14,'Rogelio Farrell',14,14,'Assumenda nihil iusto totam ipsum.'),(15,'Marshall Schneider',15,15,'Et corporis optio omnis.'),(16,'Briana Streich',16,16,'Voluptatem commodi deserunt perferendis possi'),(17,'Jace White',17,17,'Iusto quos autem quaerat id id cumque deserun'),(18,'Casandra Swaniawski',18,18,'Illum pariatur ipsam incidunt expedita sit de'),(19,'Fermin Graham',19,19,'Rerum quia natus consectetur.'),(20,'Prof. Durward O\'Conner',20,20,'Unde autem dolor eligendi aspernatur velit id'),(21,'Mr. Ephraim Runolfsdottir DDS',21,21,'Natus veniam suscipit eos illum magnam.'),(22,'Ervin Pfeffer',22,22,'Ex aperiam dolor eum eos.'),(23,'Rickie Weissnat',23,23,'Minima sit aut est.'),(24,'Nathanael Kessler',24,24,'Molestiae natus placeat quasi quae deleniti h'),(25,'Lexie West',25,25,'Facilis minima deleniti iste.'),(28,'Lexie Lore',12,26,'Facilis minima deleniti iste.');
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_item_purchases`
--

DROP TABLE IF EXISTS `customer_item_purchases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_item_purchases` (
  `purchase_id` int NOT NULL AUTO_INCREMENT,
  `purchase_status_code` int NOT NULL,
  `customer_id` int NOT NULL,
  `item_id` int NOT NULL,
  `purchase_date` date NOT NULL,
  `purchase_quantity` int DEFAULT NULL,
  `amount_due` double NOT NULL,
  PRIMARY KEY (`purchase_id`),
  KEY `fk_PURCHASE_STATUS_CODES_has_CUSTOMERS_CUSTOMERS1_idx` (`customer_id`),
  KEY `fk_PURCHASE_STATUS_CODES_has_CUSTOMERS_PURCHASE_STATUS_CODE_idx` (`purchase_status_code`),
  KEY `fk_CUSTOMER_ITEM_PURCHASES_INVENTORY_ITEMS1_idx` (`item_id`),
  CONSTRAINT `fk_CUSTOMER_ITEM_PURCHASES_INVENTORY_ITEMS1` FOREIGN KEY (`item_id`) REFERENCES `inventory_items` (`item_id`),
  CONSTRAINT `fk_PURCHASE_STATUS_CODES_has_CUSTOMERS_CUSTOMERS1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  CONSTRAINT `fk_PURCHASE_STATUS_CODES_has_CUSTOMERS_PURCHASE_STATUS_CODES` FOREIGN KEY (`purchase_status_code`) REFERENCES `purchase_status_codes` (`purchase_status_code`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_item_purchases`
--

LOCK TABLES `customer_item_purchases` WRITE;
/*!40000 ALTER TABLE `customer_item_purchases` DISABLE KEYS */;
INSERT INTO `customer_item_purchases` VALUES (1,1,1,1,'1975-04-01',519126,0),(2,2,2,2,'2012-12-21',499916548,229.4702672),(3,3,3,3,'2009-11-08',570985317,17883883.520651),(4,4,4,4,'2015-08-03',0,4.14348),(5,5,5,5,'2015-02-16',0,238.9088),(6,6,6,6,'1987-08-03',4567,73943.52),(7,7,7,7,'1978-06-22',85,4102620.012189),(8,8,8,8,'1975-03-21',0,46216.0236303),(9,9,9,9,'2014-12-22',8,1174),(10,10,10,10,'2013-12-07',874,42),(11,11,11,11,'2005-09-06',58203365,49398424.443574),(12,12,12,12,'1975-11-04',1,45),(13,13,13,13,'1981-11-09',55,170.97250963),(14,14,14,14,'1985-09-28',9,144),(15,15,15,15,'1977-11-27',97585,684.473140937),(16,6,6,6,'2024-12-13',4567,73943.52),(17,17,17,17,'2014-03-12',49,0),(18,18,18,18,'1999-02-14',5497,6),(19,19,19,19,'1988-10-11',993,1716.079154821),(20,20,20,20,'2013-03-23',102,505.343541751),(21,21,21,21,'2014-10-26',0,15.9774689),(22,22,22,22,'2013-01-13',4,49),(23,23,23,23,'1991-01-10',347528361,75602.651453),(24,24,24,24,'2015-10-31',57519,842.4837516),(25,25,25,25,'2014-11-07',49066444,10961.164876039);
/*!40000 ALTER TABLE `customer_item_purchases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_item_rentals`
--

DROP TABLE IF EXISTS `customer_item_rentals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_item_rentals` (
  `item_rental_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `item_id` int NOT NULL,
  `rental_date_out` date NOT NULL,
  `rental_date_returned` date NOT NULL,
  `amount_due` float NOT NULL,
  `other_details` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`item_rental_id`),
  KEY `fk_CUSTOMER_ITEM_RENTALS_INVENTORY_ITEMS1_idx` (`item_id`),
  KEY `fk_CUSTOMER_ITEM_RENTALS_CUSTOMERS1_idx` (`customer_id`),
  CONSTRAINT `fk_CUSTOMER_ITEM_RENTALS_CUSTOMERS1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  CONSTRAINT `fk_CUSTOMER_ITEM_RENTALS_INVENTORY_ITEMS1` FOREIGN KEY (`item_id`) REFERENCES `inventory_items` (`item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_item_rentals`
--

LOCK TABLES `customer_item_rentals` WRITE;
/*!40000 ALTER TABLE `customer_item_rentals` DISABLE KEYS */;
INSERT INTO `customer_item_rentals` VALUES (1,1,1,'1984-12-31','2023-08-09',4.48166,NULL),(2,2,2,'2018-11-03','1983-04-02',288.81,NULL),(3,3,3,'1997-07-24','1995-10-22',45226300,NULL),(4,4,4,'1981-08-08','1999-07-12',916635,NULL),(5,5,5,'1994-08-15','1986-08-17',296627000,NULL),(6,6,6,'1986-05-27','1997-01-13',7.1011,NULL),(7,7,7,'2023-05-18','1987-10-21',95678,NULL),(8,8,8,'2013-02-18','2020-02-04',19110400,NULL),(9,9,9,'2018-03-14','1988-12-30',14558800,NULL),(10,10,10,'1991-10-15','1983-12-21',63.8848,NULL),(11,11,11,'2007-03-20','2004-12-21',379221,NULL),(12,12,12,'1986-01-08','1972-12-18',33133.1,NULL),(13,13,13,'1986-06-30','2016-01-17',15.2,NULL),(14,14,14,'1974-07-05','1986-01-03',305.95,NULL),(15,15,15,'2017-08-29','2024-04-03',55.2728,NULL),(16,16,16,'1983-07-21','2002-05-08',376.649,NULL),(17,17,17,'2023-07-04','1986-01-21',17206.8,NULL),(18,18,18,'1970-07-16','2015-03-17',5.0506,NULL),(19,19,19,'1999-08-20','1973-10-10',23137,'damaged'),(20,20,20,'2006-12-20','1998-04-21',77074.7,NULL),(21,21,21,'2007-07-04','2021-04-19',38131.8,NULL),(22,22,22,'2024-06-08','1996-10-08',2.326,NULL),(23,23,23,'2004-05-31','1984-03-05',448.27,NULL),(24,24,24,'2004-09-29','1980-03-30',191752,NULL),(25,25,25,'2011-11-29','1985-08-27',14863700,NULL);
/*!40000 ALTER TABLE `customer_item_rentals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `customer_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `address` varchar(500) DEFAULT NULL,
  `phone_number` varchar(45) NOT NULL,
  `cell_mobile` varchar(45) DEFAULT NULL,
  `email_address` varchar(45) NOT NULL,
  `other_details` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,'Sarai','Greenfelder','004 Durgan Crossroad\nPierreshire, ND 83576','474.949.6646',NULL,'rowan66@example.com',NULL),(2,'Golden','Jacobi','1548 Kuhlman Route\nAmiyaside, AZ 74261-3342','1-029-109-0771',NULL,'tiffany.rogahn@example.net',NULL),(3,'Dashawn','Weissnat','888 White Crossing Apt. 083\nEast Carmellaville, WI 15749','(470)498-2810x01235',NULL,'kaci82@example.net',NULL),(4,'Zackary','Konopelski','4458 Wintheiser Pass Apt. 311\nWest Wendellview, WV 56237','(034)370-2861',NULL,'florine27@example.com',NULL),(5,'Okey','Heaney','770 Karelle Well Apt. 139\nHavenborough, WY 00668-5984','222.286.7472x26643',NULL,'abby65@example.org',NULL),(6,'Soledad','Bartoletti','137 Denesik Station Suite 211\nMervinstad, VT 62371','706.556.7230',NULL,'carli73@example.org',NULL),(7,'Adam','Little','2607 Walker Fork Suite 006\nSouth Joannefort, AZ 37530-6694','(965)405-2793x686',NULL,'lyric02@example.com',NULL),(8,'Lewis','Runolfsson','7670 Beahan Run\nWest Dameon, KS 84334-5972','1-832-824-2655x22010',NULL,'buddy92@example.com',NULL),(9,'Mariane','Witting','893 Little Rapids Apt. 221\nKreigerberg, OH 56467','1-369-130-4279x9679',NULL,'ariel92@example.org',NULL),(10,'Aileen','Schamberger','296 Allison Loop\nRusselborough, ND 55295','402-703-9278',NULL,'narmstrong@example.net',NULL),(11,'Donny','Strosin','79570 Bailey Prairie\nWilliamsonmouth, FL 01813','+13(2)3146925747',NULL,'matteo29@example.net',NULL),(12,'Austyn','Mann','865 Hoeger Garden Suite 892\nWalshhaven, NH 09522','292.200.6751',NULL,'zfunk@example.org',NULL),(13,'Libby','Sanford','908 DuBuque Drive\nPort Baylee, MS 81813','(109)881-6674x7832',NULL,'lydia.hammes@example.net',NULL),(14,'Samantha','Gutmann','787 Auer Ridge Suite 386\nElsatown, AK 75494','(752)984-0698',NULL,'bruen.ransom@example.org',NULL),(15,'Giovanni','Welch','9608 Feeney Groves Apt. 530\nProhaskaborough, MS 89871-4413','(880)648-6825',NULL,'marietta.walsh@example.net',NULL),(16,'Malvina','Lesch','78498 Jerrell Pike\nCamilaland, NH 32854-3215','(696)375-0331',NULL,'qcormier@example.com',NULL),(17,'Jules','Kris','396 Hayden Run\nPadbergberg, KY 38092-1562','1-627-475-2204',NULL,'turcotte.ramiro@example.com',NULL),(18,'Guadalupe','Kerluke','3905 Rogahn Square\nMadgemouth, MS 62636','09055381477',NULL,'william.gleason@example.com',NULL),(19,'Kyra','Lubowitz','23063 Astrid Via\nSouth Julian, NV 66781','1-263-525-1956',NULL,'felipa09@example.net',NULL),(20,'Tod','Roob','5107 Brant Tunnel Apt. 031\nEast Garfieldton, NH 20445','638.434.2227',NULL,'hmueller@example.com',NULL),(21,'John Paulo','Nase','Malabon City','92928321002','','jah@gmail.com',''),(22,'Fatima','Schumm','721 Amir Pike Apt. 386\nD\'Amoreport, PA 77251','950-082-8112x653',NULL,'gerald05@example.org',NULL),(23,'Lonny','Dicki','4179 Conroy Shoals\nJamiemouth, LA 17119','1-879-020-9819',NULL,'pamela94@example.net',NULL),(24,'Wilhelm','Altenwerth','645 Lindsay Shore\nNew Earnestfort, SC 49231','+56(9)1455755875',NULL,'solon.gaylord@example.org',NULL),(25,'Brianne','Leffler','02911 Vernice Spur\nNew Addiechester, DE 17979-6515','+75(7)0929419244',NULL,'lbeatty@example.org',NULL),(26,'Ken','Suson','Manila, Philippines','37299203283','','ken@gmail.com','');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `financial_transactions`
--

DROP TABLE IF EXISTS `financial_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `financial_transactions` (
  `transaction_id` int NOT NULL AUTO_INCREMENT,
  `account_id` int NOT NULL,
  `item_rental_id` int NOT NULL,
  `purchase_id` int NOT NULL,
  `previous_transaction_id` int NOT NULL,
  `transaction_date` date NOT NULL,
  `transaction_type_code` int DEFAULT NULL,
  `transaction_amount` double NOT NULL,
  `comment` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`transaction_id`),
  KEY `fk_FINANCIAL_TRANSACTIONS_CUSTOMER_ITEM_PURCHASES1_idx` (`purchase_id`),
  KEY `fk_FINANCIAL_TRANSACTIONS_FINANCIAL_TRANSACTIONS1_idx` (`previous_transaction_id`),
  KEY `fk_FINANCIAL_TRANSACTIONS_TRANSACTION_TYPES1_idx` (`transaction_type_code`),
  KEY `fk_FINANCIAL_TRANSACTIONS_ACCOUNTS1_idx` (`account_id`),
  KEY `fk_FINANCIAL_TRANSACTIONS_CUSTOMER_ITEM_RENTALS1_idx` (`item_rental_id`),
  CONSTRAINT `fk_FINANCIAL_TRANSACTIONS_ACCOUNTS1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`account_id`),
  CONSTRAINT `fk_FINANCIAL_TRANSACTIONS_CUSTOMER_ITEM_PURCHASES1` FOREIGN KEY (`purchase_id`) REFERENCES `customer_item_purchases` (`purchase_id`),
  CONSTRAINT `fk_FINANCIAL_TRANSACTIONS_CUSTOMER_ITEM_RENTALS1` FOREIGN KEY (`item_rental_id`) REFERENCES `customer_item_rentals` (`item_rental_id`),
  CONSTRAINT `fk_FINANCIAL_TRANSACTIONS_FINANCIAL_TRANSACTIONS1` FOREIGN KEY (`previous_transaction_id`) REFERENCES `financial_transactions` (`transaction_id`),
  CONSTRAINT `fk_FINANCIAL_TRANSACTIONS_TRANSACTION_TYPES1` FOREIGN KEY (`transaction_type_code`) REFERENCES `transaction_types` (`transaction_type_code`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `financial_transactions`
--

LOCK TABLES `financial_transactions` WRITE;
/*!40000 ALTER TABLE `financial_transactions` DISABLE KEYS */;
INSERT INTO `financial_transactions` VALUES (1,1,1,1,1,'2019-11-18',1,2910,NULL),(2,2,2,2,2,'2011-07-19',2,1387,NULL),(3,3,3,3,3,'2009-03-23',3,2831,NULL),(4,4,4,4,4,'2021-03-16',4,20232,NULL),(5,5,5,5,5,'2019-07-29',5,2083,NULL),(6,6,6,6,6,'2002-10-17',6,29372,NULL),(7,7,7,7,7,'2013-02-21',7,10002,NULL),(8,8,8,8,8,'2021-06-17',8,2300,NULL),(9,9,9,9,9,'2023-09-20',9,29321,NULL),(10,10,10,10,10,'0207-09-19',10,5002,NULL),(11,11,11,11,11,'2023-05-21',11,21777,NULL),(12,12,12,12,12,'2028-12-12',12,29102,NULL),(13,13,13,13,13,'2019-10-17',13,9372,NULL),(14,14,14,14,14,'2000-04-16',14,20821,NULL),(15,15,15,15,15,'2010-06-10',15,38392,NULL),(16,16,16,16,16,'2004-09-29',16,3029272,'pagod na sa buhay'),(17,17,17,17,17,'2000-08-23',17,12791,NULL),(18,18,18,18,18,'2003-03-17',18,298231,NULL),(19,19,19,19,19,'2001-01-15',19,829272,NULL),(20,20,20,20,20,'2016-01-17',20,836292,NULL),(21,21,21,21,21,'2009-06-27',21,937292,NULL),(22,22,22,22,22,'2006-05-10',22,293972,NULL),(23,23,23,23,23,'2020-08-28',23,39374,NULL),(24,24,24,24,24,'2022-11-30',24,218731,NULL),(25,25,25,25,25,'2023-02-14',25,972927,NULL);
/*!40000 ALTER TABLE `financial_transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory_item_types`
--

DROP TABLE IF EXISTS `inventory_item_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory_item_types` (
  `item_type_code` int NOT NULL AUTO_INCREMENT,
  `description` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`item_type_code`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory_item_types`
--

LOCK TABLES `inventory_item_types` WRITE;
/*!40000 ALTER TABLE `inventory_item_types` DISABLE KEYS */;
INSERT INTO `inventory_item_types` VALUES (1,'Electronics'),(2,'Clothing'),(3,'Furniture'),(4,'Groceries'),(5,'Stationery'),(6,'E-Books'),(7,'Software License'),(8,'Streaming Subscriptions'),(9,'Digital Art'),(10,'Consulting Services'),(11,'Maintenance Services'),(12,'Delivery Services'),(13,'Event Ticket'),(14,'Gym Memberships'),(15,'Gift Cards'),(16,'Coupons'),(17,'Stocks'),(18,'Bonds'),(19,'Cryptocurrencies'),(20,'Steel'),(21,'Plastic Resin'),(22,'Lumber'),(23,'Oil and Gas'),(24,'Chemicals'),(25,'School Supplies'),(26,'Appliances');
/*!40000 ALTER TABLE `inventory_item_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory_items`
--

DROP TABLE IF EXISTS `inventory_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory_items` (
  `item_id` int NOT NULL AUTO_INCREMENT,
  `item_type_code` int NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `number_in_stocks` int NOT NULL,
  `rental_sale_both` enum('rental','sale','both') NOT NULL,
  `rental_daily_rate` int DEFAULT NULL,
  `sale_price` int NOT NULL,
  PRIMARY KEY (`item_id`),
  KEY `fk_INVENTORY_ITEMS_INVENTORY_ITEM_TYPES1_idx` (`item_type_code`),
  CONSTRAINT `fk_INVENTORY_ITEMS_INVENTORY_ITEM_TYPES1` FOREIGN KEY (`item_type_code`) REFERENCES `inventory_item_types` (`item_type_code`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory_items`
--

LOCK TABLES `inventory_items` WRITE;
/*!40000 ALTER TABLE `inventory_items` DISABLE KEYS */;
INSERT INTO `inventory_items` VALUES (1,1,'Smartphone',452071611,'both',NULL,2),(2,2,'Laptop',545465,'sale',NULL,6),(3,3,'Headphones',89014,'sale',NULL,23),(4,4,'Smartwatch',1,'both',NULL,11996475),(5,5,'Tablet',9298,'rental',NULL,149655),(6,6,'T-Shirt',4,'both',NULL,354),(7,7,'Jeans',672454417,'sale',NULL,9),(8,8,'Jacket',18524285,'sale',NULL,45918805),(9,9,'Sneakers',4408078,'both',NULL,622),(10,10,'Hat',53,'rental',NULL,4908),(11,11,'Bread',2,'rental',NULL,3747924),(12,12,'Milk',313206428,'both',NULL,1),(13,13,'Eggs',3854,'both',NULL,2759),(14,14,'Apples',25691,'sale',NULL,57),(15,15,'Rice',4,'both',NULL,43714592),(16,16,'Dining Table',487287,'sale',NULL,7),(17,17,'Sofa',0,'sale',NULL,2099),(18,18,'Bed frame',812580,'both',NULL,5),(19,19,'Office chair',81608,'sale',NULL,3784),(20,20,'Bookshelf',70,'sale',NULL,58),(21,21,'Notebook',76572777,'rental',NULL,17916886),(22,22,'Backpack',843310,'sale',NULL,2935),(23,23,'Wristwatch',914203,'sale',NULL,1),(24,24,'Sunglasses',81661,'both',NULL,16367047),(25,25,'Bicycle',606,'sale',NULL,6219);
/*!40000 ALTER TABLE `inventory_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_methods`
--

DROP TABLE IF EXISTS `payment_methods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment_methods` (
  `payment_method_code` int NOT NULL AUTO_INCREMENT,
  `description` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`payment_method_code`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_methods`
--

LOCK TABLES `payment_methods` WRITE;
/*!40000 ALTER TABLE `payment_methods` DISABLE KEYS */;
INSERT INTO `payment_methods` VALUES (1,'Cash'),(2,'Check'),(3,'Debit Card'),(4,'Credit Card'),(5,'Bank Transfer'),(6,'Paypal'),(7,'Apple Pay'),(8,'Google Pay'),(9,'Samsung Pay'),(10,'Venmo'),(11,'Zelle'),(12,'Cash App'),(13,'Gcash Payment'),(14,'AliPay'),(15,'M-Pesa'),(16,'Bitcoin'),(17,'Ethereum'),(18,'Litecoin'),(19,'Tether'),(20,'Ripple'),(21,'Gift cards'),(22,'Store credit'),(23,'Afterpay'),(24,'Direct Debit'),(25,'Prepaid Cards');
/*!40000 ALTER TABLE `payment_methods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_status_codes`
--

DROP TABLE IF EXISTS `purchase_status_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchase_status_codes` (
  `purchase_status_code` int NOT NULL AUTO_INCREMENT,
  `description` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`purchase_status_code`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_status_codes`
--

LOCK TABLES `purchase_status_codes` WRITE;
/*!40000 ALTER TABLE `purchase_status_codes` DISABLE KEYS */;
INSERT INTO `purchase_status_codes` VALUES (1,'Pending'),(2,'Confirmed'),(3,'Processing'),(4,'Payment Successful'),(5,'Delivered'),(6,'Payment Pending'),(7,'Payment Failed'),(8,'Refunded'),(9,'Cancelled'),(10,'Returned'),(11,'On Hold'),(12,'Backordered'),(13,'Prepared for Shipment'),(14,'Picking in Warehouse'),(15,'Packed for shipping'),(16,'Out of Transit'),(17,'Received by Customer'),(18,'Closed'),(19,'Out of Stock'),(20,'Delayed'),(21,'Partial Payment Made'),(22,'Partially Delivered'),(23,'Replacement Issued'),(24,'Under Review'),(25,'Voluptatum adipisci recusandae reprehenderit provident sint illum accusantium cum.'),(26,'Shipped');
/*!40000 ALTER TABLE `purchase_status_codes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction_types`
--

DROP TABLE IF EXISTS `transaction_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaction_types` (
  `transaction_type_code` int NOT NULL AUTO_INCREMENT,
  `description` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`transaction_type_code`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction_types`
--

LOCK TABLES `transaction_types` WRITE;
/*!40000 ALTER TABLE `transaction_types` DISABLE KEYS */;
INSERT INTO `transaction_types` VALUES (1,'Cash Deposit'),(2,'Cash Withdrawal'),(3,'Online Payment'),(4,'Credit Card Purchase'),(5,'Debit Card Purchase'),(6,'Bank Transfer'),(7,'Mobile Wallet Payment'),(8,'Loan Disbursement'),(9,'Check Issuance'),(10,'Clearing Check'),(11,'Wire Transfer'),(12,'Recurring Payment'),(13,'Refund'),(14,'Overdraft'),(15,'Investment Purchase'),(16,'Dividend Payment'),(17,'Foreign Exchange '),(18,'Tax Payment'),(19,'Salary Payment'),(20,'Account Opening'),(21,'Password Reset'),(22,'Account Update'),(23,'Balance Inquiry'),(24,'Statement Request'),(25,'Bill Payment'),(26,'Financial');
/*!40000 ALTER TABLE `transaction_types` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-13 19:05:49
