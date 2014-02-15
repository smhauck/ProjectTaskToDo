-- MySQL dump 10.13  Distrib 5.1.46, for slackware-linux-gnu (i486)
--
-- Host: localhost    Database: projecttasktodo
-- ------------------------------------------------------
-- Server version	5.1.46-log

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
-- Table structure for table `activity_type`
--

DROP TABLE IF EXISTS `activity_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `activity_type` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT 'NO_NAME_ASSIGNED',
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activity_type`
--

LOCK TABLES `activity_type` WRITE;
/*!40000 ALTER TABLE `activity_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `activity_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `allocation`
--

DROP TABLE IF EXISTS `allocation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `allocation` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `person_id` bigint(20) unsigned NOT NULL,
  `task_id` bigint(20) unsigned DEFAULT NULL,
  `project_id` bigint(20) unsigned DEFAULT NULL,
  `date_of_work` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `allocation`
--

LOCK TABLES `allocation` WRITE;
/*!40000 ALTER TABLE `allocation` DISABLE KEYS */;
/*!40000 ALTER TABLE `allocation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `allocation_certainty_type`
--

DROP TABLE IF EXISTS `allocation_certainty_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `allocation_certainty_type` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `allocation_certainty_type`
--

LOCK TABLES `allocation_certainty_type` WRITE;
/*!40000 ALTER TABLE `allocation_certainty_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `allocation_certainty_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `capability`
--

DROP TABLE IF EXISTS `capability`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `capability` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT 'NO_NAME_ASSIGNED',
  `display_name` varchar(255) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `capability`
--

LOCK TABLES `capability` WRITE;
/*!40000 ALTER TABLE `capability` DISABLE KEYS */;
/*!40000 ALTER TABLE `capability` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `country`
--

DROP TABLE IF EXISTS `country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `country` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `alpha2` char(2) DEFAULT NULL,
  `alpha3` char(3) DEFAULT NULL,
  `numeric_id` int(11) DEFAULT NULL,
  `iso3166_2` varchar(255) DEFAULT NULL,
  `continent_id` int(1) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `country`
--

LOCK TABLES `country` WRITE;
/*!40000 ALTER TABLE `country` DISABLE KEYS */;
/*!40000 ALTER TABLE `country` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_title`
--

DROP TABLE IF EXISTS `job_title`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `job_title` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT 'NO_NAME_ASSIGNED',
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_title`
--

LOCK TABLES `job_title` WRITE;
/*!40000 ALTER TABLE `job_title` DISABLE KEYS */;
/*!40000 ALTER TABLE `job_title` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `list_type`
--

DROP TABLE IF EXISTS `list_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `list_type` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `list_type`
--

LOCK TABLES `list_type` WRITE;
/*!40000 ALTER TABLE `list_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `list_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `note`
--

DROP TABLE IF EXISTS `note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `note` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `active` char(1) DEFAULT NULL,
  `creator_id` bigint(20) unsigned NOT NULL,
  `created` datetime NOT NULL,
  `last_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `project_id` bigint(20) unsigned DEFAULT NULL,
  `client_contact_person_id` bigint(20) unsigned DEFAULT NULL,
  `client_organization_id` bigint(20) unsigned DEFAULT NULL,
  `client_person_id` bigint(20) unsigned DEFAULT NULL,
  `task_id` bigint(20) unsigned DEFAULT NULL,
  `public` char(1) NOT NULL DEFAULT '0',
  `date_selected` date DEFAULT NULL,
  `title` tinyblob,
  `body` longblob,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `note`
--

LOCK TABLES `note` WRITE;
/*!40000 ALTER TABLE `note` DISABLE KEYS */;
/*!40000 ALTER TABLE `note` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification`
--

DROP TABLE IF EXISTS `notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notification` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `recorded` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_to_notify` bigint(20) unsigned NOT NULL,
  `user_making_modification` bigint(20) unsigned NOT NULL,
  `notification_type` smallint(5) unsigned NOT NULL,
  `project_id` bigint(20) unsigned DEFAULT NULL,
  `task_id` bigint(20) unsigned DEFAULT NULL,
  `body` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification`
--

LOCK TABLES `notification` WRITE;
/*!40000 ALTER TABLE `notification` DISABLE KEYS */;
/*!40000 ALTER TABLE `notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organization`
--

DROP TABLE IF EXISTS `organization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `organization` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `recorded` datetime DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  `notes` text,
  `hq_address_id` bigint(20) unsigned DEFAULT NULL,
  `address_1` varchar(255) DEFAULT NULL,
  `address_2` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `zip` varchar(25) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organization`
--

LOCK TABLES `organization` WRITE;
/*!40000 ALTER TABLE `organization` DISABLE KEYS */;
/*!40000 ALTER TABLE `organization` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person`
--

DROP TABLE IF EXISTS `person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(32) NOT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `office_phone` varchar(25) DEFAULT NULL,
  `office_floor` varchar(25) DEFAULT NULL,
  `office_address1` varchar(255) DEFAULT NULL,
  `office_address2` varchar(255) DEFAULT NULL,
  `office_address3` varchar(255) DEFAULT NULL,
  `office_city` varchar(255) DEFAULT NULL,
  `office_state` varchar(255) DEFAULT NULL,
  `office_postal_code` varchar(255) DEFAULT NULL,
  `offie_country` varchar(255) DEFAULT NULL,
  `mobile_phone` varchar(25) DEFAULT NULL,
  `skype_name` varchar(255) DEFAULT NULL,
  `aim_name` varchar(255) DEFAULT NULL,
  `nnit_initials` varchar(10) DEFAULT NULL,
  `timezone` varchar(255) DEFAULT NULL,
  `created_on` datetime NOT NULL,
  `last_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `active` char(1) NOT NULL DEFAULT '1',
  `office_email` varchar(255) DEFAULT NULL,
  `office_department` varchar(255) DEFAULT NULL,
  `headshot` mediumblob,
  `office_country` varchar(255) DEFAULT NULL,
  `job_title_id` int(10) unsigned DEFAULT NULL,
  `job_title` varchar(255) DEFAULT NULL,
  `hire_date_text` varchar(15) DEFAULT NULL,
  `admin_notes` longtext,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username_unique` (`username`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person`
--

LOCK TABLES `person` WRITE;
/*!40000 ALTER TABLE `person` DISABLE KEYS */;
INSERT INTO `person` (`id`, `username`, `full_name`, `first_name`, `last_name`, `office_phone`, `office_floor`, `office_address1`, `office_address2`, `office_address3`, `office_city`, `office_state`, `office_postal_code`, `offie_country`, `mobile_phone`, `skype_name`, `aim_name`, `nnit_initials`, `timezone`, `created_on`, `last_modified`, `active`, `office_email`, `office_department`, `headshot`, `office_country`, `job_title_id`, `job_title`, `hire_date_text`, `admin_notes`) VALUES (1,'admin','Administrator','Administrator','Administrator','','','','','','','','',NULL,'','','','',NULL,'0000-00-00 00:00:00','2013-11-19 01:01:40','1','admin@localhost.localdomain','',NULL,'',NULL,'','','');
/*!40000 ALTER TABLE `person` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`projecttasktodo`@`localhost`*/ /*!50003 trigger person_ai
after insert
on person
for each row
begin
insert into user (id, active, username, full_name, contact_email, phone, department, registered)
values
(new.id, 1, new.username, new.full_name, new.office_email, new.mobile_phone, new.office_department, now());
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`projecttasktodo`@`localhost`*/ /*!50003 trigger person_au
after update
on person
for each row
begin
update user set active=new.active, username=new.username, full_name=new.full_name, contact_email=new.office_email,
phone=new.mobile_phone, department=new.office_department where user.id=new.id;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `project`
--

DROP TABLE IF EXISTS `project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project` (
  `project_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` bigint(20) unsigned NOT NULL DEFAULT '1',
  `billable` int(1) unsigned NOT NULL DEFAULT '1',
  `project_short_name` char(16) DEFAULT NULL,
  `project_name` varchar(255) NOT NULL,
  `project_creator_id` bigint(20) unsigned NOT NULL,
  `project_owner_id` bigint(20) unsigned NOT NULL,
  `project_description` text,
  `project_requirements_text` longtext,
  `project_requirements_document` longblob,
  `project_sched_start_date` date DEFAULT NULL,
  `project_actual_start_date` date DEFAULT NULL,
  `project_start_date_diff` int(11) DEFAULT NULL,
  `project_sched_compl_date` date DEFAULT NULL,
  `project_actual_compl_date` date DEFAULT NULL,
  `project_compl_date_diff` int(11) DEFAULT NULL,
  `sched_go_live_date` date DEFAULT NULL,
  `actual_go_live_date` date DEFAULT NULL,
  `project_complete` char(1) NOT NULL DEFAULT 'n',
  `project_completion_notes` text,
  `deleted` char(1) NOT NULL DEFAULT 'n',
  `project_deletion_date` date DEFAULT NULL,
  `project_last_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `project_modified_by_user_id` bigint(20) unsigned DEFAULT NULL,
  `project_deletion_notes` text,
  `project_recorded` datetime DEFAULT NULL,
  `project_alive` char(1) NOT NULL DEFAULT '1',
  `project_alive_modified` datetime DEFAULT NULL,
  `list_type` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `client_person_id` bigint(20) unsigned DEFAULT NULL,
  `client_person_name` varchar(255) DEFAULT NULL,
  `client_person_department` varchar(255) DEFAULT NULL,
  `client_person_office_phone` varchar(255) DEFAULT NULL,
  `client_person_email` varchar(255) DEFAULT NULL,
  `client_organization_email` varchar(255) DEFAULT NULL,
  `client_organization_office_phone` varchar(255) DEFAULT NULL,
  `client_organization_name` varchar(255) DEFAULT NULL,
  `client_organization_id` bigint(20) unsigned DEFAULT NULL,
  `status_id` smallint(5) unsigned NOT NULL DEFAULT '1',
  `allocated_hours` float unsigned DEFAULT NULL,
  `client_contact_person_id` bigint(20) unsigned DEFAULT NULL,
  `client_contact_person_name` varchar(255) DEFAULT NULL,
  `client_contact_person_department` varchar(255) DEFAULT NULL,
  `client_contact_person_office_phone` varchar(255) DEFAULT NULL,
  `client_contact_person_email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`project_id`),
  UNIQUE KEY `project_short_name_unique` (`project_short_name`),
  FULLTEXT KEY `name_ftindex` (`project_name`),
  FULLTEXT KEY `description_ftindex` (`project_description`),
  FULLTEXT KEY `short_name_name_description_ftindex` (`project_short_name`,`project_name`,`project_description`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project`
--

LOCK TABLES `project` WRITE;
/*!40000 ALTER TABLE `project` DISABLE KEYS */;
/*!40000 ALTER TABLE `project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_category`
--

DROP TABLE IF EXISTS `project_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_category` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_category`
--

LOCK TABLES `project_category` WRITE;
/*!40000 ALTER TABLE `project_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_comment`
--

DROP TABLE IF EXISTS `project_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_comment` (
  `comment_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` mediumint(9) NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `comment` text NOT NULL,
  `recorded` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`comment_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_comment`
--

LOCK TABLES `project_comment` WRITE;
/*!40000 ALTER TABLE `project_comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_comment_type`
--

DROP TABLE IF EXISTS `project_comment_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_comment_type` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `name` char(50) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_comment_type`
--

LOCK TABLES `project_comment_type` WRITE;
/*!40000 ALTER TABLE `project_comment_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_comment_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_file`
--

DROP TABLE IF EXISTS `project_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_file` (
  `project_id` bigint(20) unsigned NOT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `uploaded_by_user` bigint(20) unsigned NOT NULL,
  `recorded` datetime DEFAULT NULL,
  `id` varchar(255) NOT NULL,
  `last_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_file`
--

LOCK TABLES `project_file` WRITE;
/*!40000 ALTER TABLE `project_file` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_has_tag`
--

DROP TABLE IF EXISTS `project_has_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_has_tag` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tag_id` bigint(20) unsigned NOT NULL,
  `project_id` bigint(20) unsigned NOT NULL,
  `creator_id` bigint(20) unsigned NOT NULL,
  `created_on` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_has_tag`
--

LOCK TABLES `project_has_tag` WRITE;
/*!40000 ALTER TABLE `project_has_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_has_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_link`
--

DROP TABLE IF EXISTS `project_link`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_link` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `link_type_id` smallint(5) unsigned DEFAULT NULL,
  `project_id` bigint(20) unsigned NOT NULL,
  `link_url` varchar(1024) DEFAULT NULL,
  `link_text` varchar(255) DEFAULT NULL,
  `creator_id` bigint(20) unsigned NOT NULL,
  `last_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_link`
--

LOCK TABLES `project_link` WRITE;
/*!40000 ALTER TABLE `project_link` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_link` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_link_type`
--

DROP TABLE IF EXISTS `project_link_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_link_type` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `abbreviation` char(4) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_link_type`
--

LOCK TABLES `project_link_type` WRITE;
/*!40000 ALTER TABLE `project_link_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_link_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_status_type`
--

DROP TABLE IF EXISTS `project_status_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_status_type` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `living` char(1) NOT NULL,
  `description` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_status_type`
--

LOCK TABLES `project_status_type` WRITE;
/*!40000 ALTER TABLE `project_status_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_status_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_tag`
--

DROP TABLE IF EXISTS `project_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_tag` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `creator_id` bigint(20) unsigned DEFAULT NULL,
  `created_on` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_tag`
--

LOCK TABLES `project_tag` WRITE;
/*!40000 ALTER TABLE `project_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_user`
--

DROP TABLE IF EXISTS `project_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_user` (
  `project_user_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `project_user_project_id` mediumint(9) NOT NULL,
  `project_user_user_id` bigint(20) unsigned NOT NULL,
  `project_user_role_id` mediumint(9) NOT NULL,
  `project_user_last_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`project_user_id`),
  UNIQUE KEY `project_user_role` (`project_user_project_id`,`project_user_user_id`,`project_user_role_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_user`
--

LOCK TABLES `project_user` WRITE;
/*!40000 ALTER TABLE `project_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `requirement`
--

DROP TABLE IF EXISTS `requirement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `requirement` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` bigint(20) unsigned NOT NULL,
  `name` text,
  `description` text,
  `capability_id` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `requirement`
--

LOCK TABLES `requirement` WRITE;
/*!40000 ALTER TABLE `requirement` DISABLE KEYS */;
/*!40000 ALTER TABLE `requirement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `custom_role` int(1) NOT NULL DEFAULT '1',
  `role` varchar(255) DEFAULT NULL,
  `capability` bigint(20) unsigned DEFAULT NULL,
  `project_related` tinyint(1) NOT NULL DEFAULT '0',
  `display_name` varchar(255) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` (`id`, `custom_role`, `role`, `capability`, `project_related`, `display_name`, `description`) VALUES (1,0,'admin',NULL,0,'Administrator','Runs the whole system'),(2,1,'member',NULL,0,'Team Member','A Person who works on Projects'),(3,1,'user_maintainer',NULL,0,'User Maintainer',NULL),(4,1,'client',NULL,0,'Client',NULL);
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `session`
--

DROP TABLE IF EXISTS `session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `session` (
  `id` char(72) NOT NULL,
  `session_data` text,
  `expires` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `session`
--

LOCK TABLES `session` WRITE;
/*!40000 ALTER TABLE `session` DISABLE KEYS */;
/*!40000 ALTER TABLE `session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task`
--

DROP TABLE IF EXISTS `task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task` (
  `task_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `task_project_id` int(11) DEFAULT NULL,
  `task_status_id` smallint(5) unsigned NOT NULL DEFAULT '1',
  `on_project_plan` char(1) NOT NULL,
  `task_order` int(10) unsigned DEFAULT NULL,
  `task_name` varchar(255) NOT NULL,
  `task_creator_id` bigint(20) unsigned NOT NULL,
  `task_owner_id` bigint(20) unsigned NOT NULL,
  `task_project` char(1) NOT NULL DEFAULT '0',
  `task_priority` smallint(5) unsigned NOT NULL DEFAULT '10',
  `task_description` text,
  `task_sched_start_date` date DEFAULT NULL,
  `task_actual_start_date` date DEFAULT NULL,
  `task_start_date_diff` int(11) DEFAULT NULL,
  `task_sched_compl_date` date DEFAULT NULL,
  `task_actual_compl_date` date DEFAULT NULL,
  `task_compl_date_diff` int(11) DEFAULT NULL,
  `task_deletion_date` date DEFAULT NULL,
  `difficulty` tinyint(3) unsigned DEFAULT NULL,
  `task_complete` char(1) NOT NULL DEFAULT 'n',
  `task_deleted` char(1) NOT NULL DEFAULT 'n',
  `task_recorded` datetime DEFAULT NULL,
  `task_last_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `task_modified_by_user_id` bigint(20) unsigned DEFAULT NULL,
  `task_completion_notes` text,
  `task_deletion_notes` text,
  `task_alive` char(1) NOT NULL DEFAULT '1',
  `task_alive_modified` datetime DEFAULT NULL,
  `task_last_activity` datetime DEFAULT NULL,
  `task_duration` int(11) DEFAULT NULL,
  `time_estimate` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`task_id`),
  FULLTEXT KEY `name_ftindex` (`task_name`),
  FULLTEXT KEY `description_ftindex` (`task_description`),
  FULLTEXT KEY `name_description_ftindex` (`task_name`,`task_description`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task`
--

LOCK TABLES `task` WRITE;
/*!40000 ALTER TABLE `task` DISABLE KEYS */;
/*!40000 ALTER TABLE `task` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`projecttasktodo`@`localhost`*/ /*!50003 TRIGGER `task_bi` BEFORE INSERT ON `task` FOR EACH ROW begin
set new.task_start_date_diff = datediff(new.task_actual_start_date, new.task_sched_start_date);
set new.task_compl_date_diff = datediff(new.task_actual_compl_date, new.task_sched_compl_date);
set new.task_last_activity = now();
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`projecttasktodo`@`localhost`*/ /*!50003 TRIGGER `task_bu` BEFORE UPDATE ON `task` FOR EACH ROW begin
set new.task_start_date_diff= datediff(new.task_actual_start_date, new.task_sched_start_date);
set new.task_compl_date_diff= datediff(new.task_actual_compl_date, new.task_sched_compl_date);
set new.task_last_activity = now();
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `task_comment`
--

DROP TABLE IF EXISTS `task_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task_comment` (
  `task_comment_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `task_comment_task_id` bigint(20) unsigned NOT NULL,
  `task_comment_user_id` bigint(20) unsigned NOT NULL,
  `task_comment_type_id` smallint(5) unsigned DEFAULT NULL,
  `task_comment_date_of_work` date DEFAULT NULL,
  `task_comment_time_worked` float unsigned DEFAULT NULL,
  `task_comment_body` longtext,
  `task_comment_recorded` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `billable` char(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`task_comment_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_comment`
--

LOCK TABLES `task_comment` WRITE;
/*!40000 ALTER TABLE `task_comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_comment` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`projecttasktodo`@`localhost`*/ /*!50003 TRIGGER `task_comment_bi` BEFORE INSERT ON `task_comment` FOR EACH ROW begin
update task set task.task_last_modified = now(), task_modified_by_user_id=new.task_comment_user_id where task.task_id = new.task_comment_task_id;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `task_comment_type`
--

DROP TABLE IF EXISTS `task_comment_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task_comment_type` (
  `task_comment_type_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `task_comment_type_name` char(50) DEFAULT NULL,
  `task_comment_type_description` text,
  PRIMARY KEY (`task_comment_type_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_comment_type`
--

LOCK TABLES `task_comment_type` WRITE;
/*!40000 ALTER TABLE `task_comment_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_comment_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_status_type`
--

DROP TABLE IF EXISTS `task_status_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task_status_type` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `name` char(50) NOT NULL,
  `living` char(1) NOT NULL DEFAULT '1',
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_status_type`
--

LOCK TABLES `task_status_type` WRITE;
/*!40000 ALTER TABLE `task_status_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_status_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_time`
--

DROP TABLE IF EXISTS `task_time`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task_time` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `comment_id` bigint(20) unsigned NOT NULL,
  `task_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `recorded_at` datetime DEFAULT NULL,
  `recorded_by` bigint(20) unsigned DEFAULT NULL,
  `modified_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `modified_by` bigint(20) unsigned DEFAULT NULL,
  `date_of_work` date NOT NULL,
  `time_worked` float unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_time`
--

LOCK TABLES `task_time` WRITE;
/*!40000 ALTER TABLE `task_time` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_time` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`projecttasktodo`@`localhost`*/ /*!50003 TRIGGER `task_time_bi` BEFORE INSERT ON `task_time` FOR EACH ROW begin
set new.recorded_at = now();
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `task_user`
--

DROP TABLE IF EXISTS `task_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task_user` (
  `task_user_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `task_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `role_id` mediumint(9) NOT NULL,
  `recorded` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`task_user_id`),
  UNIQUE KEY `task_user_role` (`task_id`,`user_id`,`role_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_user`
--

LOCK TABLES `task_user` WRITE;
/*!40000 ALTER TABLE `task_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tech_allocation`
--

DROP TABLE IF EXISTS `tech_allocation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tech_allocation` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `resource_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `lead_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `project_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `task_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `week_ending` date NOT NULL,
  `time_reserved` int(11) NOT NULL DEFAULT '0',
  `certainty_id` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `sched_start_date` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tech_allocation`
--

LOCK TABLES `tech_allocation` WRITE;
/*!40000 ALTER TABLE `tech_allocation` DISABLE KEYS */;
/*!40000 ALTER TABLE `tech_allocation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tech_allocation_certainty_type`
--

DROP TABLE IF EXISTS `tech_allocation_certainty_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tech_allocation_certainty_type` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT 'NO_NAME_ASSIGNED',
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tech_allocation_certainty_type`
--

LOCK TABLES `tech_allocation_certainty_type` WRITE;
/*!40000 ALTER TABLE `tech_allocation_certainty_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `tech_allocation_certainty_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `time_palette_project`
--

DROP TABLE IF EXISTS `time_palette_project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `time_palette_project` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `project_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `time_palette_project`
--

LOCK TABLES `time_palette_project` WRITE;
/*!40000 ALTER TABLE `time_palette_project` DISABLE KEYS */;
/*!40000 ALTER TABLE `time_palette_project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `todolist`
--

DROP TABLE IF EXISTS `todolist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `todolist` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `short_name` char(16) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `creator_id` bigint(20) unsigned NOT NULL,
  `owner_id` bigint(20) unsigned NOT NULL,
  `description` text,
  `requirements_text` longtext,
  `requirements_document` longblob,
  `sched_start_date` date DEFAULT NULL,
  `actual_start_date` date DEFAULT NULL,
  `start_date_diff` int(11) DEFAULT NULL,
  `sched_compl_date` date DEFAULT NULL,
  `actual_compl_date` date DEFAULT NULL,
  `compl_date_diff` int(11) DEFAULT NULL,
  `complete` char(1) NOT NULL DEFAULT 'n',
  `completion_notes` text,
  `deleted` char(1) NOT NULL DEFAULT 'n',
  `deletion_date` date DEFAULT NULL,
  `last_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `modified_by_user_id` bigint(20) unsigned DEFAULT NULL,
  `deletion_notes` text,
  `recorded` datetime DEFAULT NULL,
  `alive` char(1) NOT NULL DEFAULT '1',
  `alive_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  FULLTEXT KEY `name_ftindex` (`name`),
  FULLTEXT KEY `description_ftindex` (`description`),
  FULLTEXT KEY `short_name_name_description_ftindex` (`short_name`,`name`,`description`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `todolist`
--

LOCK TABLES `todolist` WRITE;
/*!40000 ALTER TABLE `todolist` DISABLE KEYS */;
/*!40000 ALTER TABLE `todolist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `todolist_comment`
--

DROP TABLE IF EXISTS `todolist_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `todolist_comment` (
  `comment_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `todo_id` mediumint(9) NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `comment` text NOT NULL,
  `recorded` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`comment_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `todolist_comment`
--

LOCK TABLES `todolist_comment` WRITE;
/*!40000 ALTER TABLE `todolist_comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `todolist_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `todolist_comment_type`
--

DROP TABLE IF EXISTS `todolist_comment_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `todolist_comment_type` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `name` char(50) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `todolist_comment_type`
--

LOCK TABLES `todolist_comment_type` WRITE;
/*!40000 ALTER TABLE `todolist_comment_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `todolist_comment_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `todolist_status_type`
--

DROP TABLE IF EXISTS `todolist_status_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `todolist_status_type` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `living` char(1) NOT NULL,
  `description` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `todolist_status_type`
--

LOCK TABLES `todolist_status_type` WRITE;
/*!40000 ALTER TABLE `todolist_status_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `todolist_status_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `todolist_user`
--

DROP TABLE IF EXISTS `todolist_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `todolist_user` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `todolist_id` mediumint(9) NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `role_id` mediumint(9) NOT NULL,
  `last_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `todolist_user_role` (`todolist_id`,`user_id`,`role_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `todolist_user`
--

LOCK TABLES `todolist_user` WRITE;
/*!40000 ALTER TABLE `todolist_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `todolist_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `active` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `username` varchar(32) NOT NULL,
  `password` varchar(32) NOT NULL DEFAULT '',
  `full_name` varchar(255) DEFAULT NULL,
  `contact_email` varchar(255) DEFAULT NULL,
  `phone` varchar(25) DEFAULT NULL,
  `department` varchar(255) DEFAULT NULL,
  `registered` datetime DEFAULT NULL,
  `last_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username_unique` (`username`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`id`, `active`, `username`, `password`, `full_name`, `contact_email`, `phone`, `department`, `registered`, `last_modified`) VALUES (1,1,'admin','PBsFAH7mDBc5I','Administrator','admin@localhost.localdomain','','',NULL,'2013-11-19 01:01:40');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_role`
--

DROP TABLE IF EXISTS `user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_role` (
  `user` bigint(20) unsigned NOT NULL,
  `role` int(10) unsigned NOT NULL,
  PRIMARY KEY (`user`,`role`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_role`
--

LOCK TABLES `user_role` WRITE;
/*!40000 ALTER TABLE `user_role` DISABLE KEYS */;
INSERT INTO `user_role` (`user`, `role`) VALUES (1,1),(1,2),(1,3);
/*!40000 ALTER TABLE `user_role` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-02-11  9:04:25
