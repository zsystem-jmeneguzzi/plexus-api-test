-- MySQL dump 10.19  Distrib 10.3.39-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: citas_medicas
-- ------------------------------------------------------
-- Server version	10.3.39-MariaDB-0ubuntu0.20.04.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `appointment_attentions`
--

DROP TABLE IF EXISTS `appointment_attentions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `appointment_attentions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `appointment_id` bigint(20) unsigned NOT NULL,
  `patient_id` bigint(20) unsigned NOT NULL,
  `description` longtext NOT NULL,
  `receta_medica` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointment_attentions`
--

LOCK TABLES `appointment_attentions` WRITE;
/*!40000 ALTER TABLE `appointment_attentions` DISABLE KEYS */;
/*!40000 ALTER TABLE `appointment_attentions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `appointment_pays`
--

DROP TABLE IF EXISTS `appointment_pays`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `appointment_pays` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `appointment_id` bigint(20) unsigned NOT NULL,
  `amount` double NOT NULL,
  `method_payment` varchar(150) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointment_pays`
--

LOCK TABLES `appointment_pays` WRITE;
/*!40000 ALTER TABLE `appointment_pays` DISABLE KEYS */;
INSERT INTO `appointment_pays` VALUES (11,9,150,'MERCADOPAGO','2024-06-25 15:10:36','2024-06-25 15:10:36',NULL),(12,9,10,'EFECTIVO','2024-07-07 21:07:05','2024-07-07 21:07:05',NULL);
/*!40000 ALTER TABLE `appointment_pays` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `appointments`
--

DROP TABLE IF EXISTS `appointments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `appointments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `doctor_id` bigint(20) unsigned NOT NULL,
  `patient_id` bigint(20) unsigned NOT NULL,
  `date_appointment` timestamp NULL DEFAULT NULL,
  `cron_state` tinyint(1) unsigned DEFAULT 1,
  `specialitie_id` bigint(20) unsigned NOT NULL,
  `doctor_schedule_join_hour_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `amount` double NOT NULL COMMENT 'costo total de la cita',
  `status_pay` tinyint(1) unsigned NOT NULL DEFAULT 1 COMMENT '1 pagado, 2 deuda',
  `status` tinyint(1) unsigned NOT NULL DEFAULT 1 COMMENT '1 pendiente, 2 atendido',
  `date_attention` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointments`
--

LOCK TABLES `appointments` WRITE;
/*!40000 ALTER TABLE `appointments` DISABLE KEYS */;
INSERT INTO `appointments` VALUES (9,54,104,'2024-06-24 06:00:00',1,1,54,1,200,2,1,NULL,'2024-06-25 15:10:36','2024-06-25 15:10:36',NULL);
/*!40000 ALTER TABLE `appointments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `carpetas`
--

DROP TABLE IF EXISTS `carpetas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `carpetas` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `autos` varchar(250) NOT NULL,
  `nro_carpeta` varchar(25) DEFAULT NULL,
  `fecha_inicio` date DEFAULT NULL,
  `ultimo_movimiento` date DEFAULT NULL,
  `tipo_proceso_id` bigint(20) unsigned DEFAULT NULL,
  `estado` bigint(20) unsigned DEFAULT NULL COMMENT '1) En tramite, 2) Finalizado',
  `descripcion` longtext NOT NULL,
  `abogado_id` bigint(20) unsigned DEFAULT NULL,
  `contrarios_id` bigint(20) unsigned DEFAULT NULL,
  `tercero_id` bigint(20) unsigned DEFAULT NULL,
  `cliente_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carpetas`
--

LOCK TABLES `carpetas` WRITE;
/*!40000 ALTER TABLE `carpetas` DISABLE KEYS */;
INSERT INTO `carpetas` VALUES (1,'prueba','1','2024-07-01','2024-07-17',1,1,'1asdas',57,1,1,NULL,'2024-07-15 23:57:29','2024-07-17 12:38:01',NULL),(2,'prueba 2','2','2024-07-02','2024-07-22',1,1,'1',55,2,2,NULL,'2024-07-15 23:58:12','2024-07-22 13:47:46',NULL);
/*!40000 ALTER TABLE `carpetas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor_schedule_days`
--

DROP TABLE IF EXISTS `doctor_schedule_days`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `doctor_schedule_days` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `day` varchar(50) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=225 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor_schedule_days`
--

LOCK TABLES `doctor_schedule_days` WRITE;
/*!40000 ALTER TABLE `doctor_schedule_days` DISABLE KEYS */;
INSERT INTO `doctor_schedule_days` VALUES (218,51,'Miercoles','2024-06-24 17:55:20','2024-06-24 17:55:20',NULL),(219,51,'Jueves','2024-06-24 17:55:20','2024-06-24 17:55:20',NULL),(220,51,'Viernes','2024-06-24 17:55:20','2024-06-24 17:55:20',NULL),(221,54,'Lunes','2024-06-25 15:07:35','2024-06-25 15:07:35',NULL),(223,55,'Miercoles','2024-07-05 20:45:56','2024-07-05 20:45:56',NULL),(224,57,'Martes','2024-07-12 17:38:39','2024-07-12 17:38:39',NULL);
/*!40000 ALTER TABLE `doctor_schedule_days` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor_schedule_hours`
--

DROP TABLE IF EXISTS `doctor_schedule_hours`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `doctor_schedule_hours` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `hour_start` varchar(50) NOT NULL,
  `hour_end` varchar(50) NOT NULL,
  `hour` varchar(20) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor_schedule_hours`
--

LOCK TABLES `doctor_schedule_hours` WRITE;
/*!40000 ALTER TABLE `doctor_schedule_hours` DISABLE KEYS */;
INSERT INTO `doctor_schedule_hours` VALUES (1,'08:00:00','08:15:00','08',NULL,NULL),(2,'08:15:00','08:30:00','08',NULL,NULL),(3,'08:30:00','08:45:00','08',NULL,NULL),(4,'08:45:00','09:00:00','08',NULL,NULL),(5,'09:00:00','09:15:00','09',NULL,NULL),(6,'09:15:00','09:30:00','09',NULL,NULL),(7,'09:30:00','09:45:00','09',NULL,NULL),(8,'09:45:00','10:00:00','09',NULL,NULL),(9,'10:00:00','10:15:00','10',NULL,NULL),(10,'10:15:00','10:30:00','10',NULL,NULL),(11,'10:30:00','10:45:00','10',NULL,NULL),(12,'10:45:00','11:00:00','10',NULL,NULL),(13,'11:00:00','11:15:00','11',NULL,NULL),(14,'11:15:00','11:30:00','11',NULL,NULL),(15,'11:30:00','11:45:00','11',NULL,NULL),(16,'11:45:00','12:00:00','11',NULL,NULL),(17,'12:00:00','12:15:00','12',NULL,NULL),(18,'12:15:00','12:30:00','12',NULL,NULL),(19,'12:30:00','12:45:00','12',NULL,NULL),(20,'12:45:00','13:00:00','12',NULL,NULL),(21,'13:00:00','13:15:00','13',NULL,NULL),(22,'13:15:00','13:30:00','13',NULL,NULL),(23,'13:30:00','13:45:00','13',NULL,NULL),(24,'13:45:00','14:00:00','13',NULL,NULL),(25,'14:00:00','14:15:00','14',NULL,NULL),(26,'14:15:00','14:30:00','14',NULL,NULL),(27,'14:30:00','14:45:00','14',NULL,NULL),(28,'14:45:00','15:00:00','14',NULL,NULL),(29,'15:00:00','15:15:00','15',NULL,NULL),(30,'15:15:00','15:30:00','15',NULL,NULL),(31,'15:30:00','15:45:00','15',NULL,NULL),(32,'15:45:00','16:00:00','15',NULL,NULL),(33,'16:00:00','16:15:00','16',NULL,NULL),(34,'16:15:00','16:30:00','16',NULL,NULL),(35,'16:30:00','16:45:00','16',NULL,NULL),(36,'16:45:00','17:00:00','16',NULL,NULL),(37,'17:00:00','17:15:00','17',NULL,NULL),(38,'17:15:00','17:30:00','17',NULL,NULL),(39,'17:30:00','17:45:00','17',NULL,NULL),(40,'17:45:00','18:00:00','17',NULL,NULL);
/*!40000 ALTER TABLE `doctor_schedule_hours` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor_schedule_join_hours`
--

DROP TABLE IF EXISTS `doctor_schedule_join_hours`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `doctor_schedule_join_hours` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `doctor_schedule_day_id` bigint(20) unsigned NOT NULL,
  `doctor_schedule_hour_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `doctor_schedule_day_join` (`doctor_schedule_day_id`),
  CONSTRAINT `doctor_schedule_day_join` FOREIGN KEY (`doctor_schedule_day_id`) REFERENCES `doctor_schedule_days` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor_schedule_join_hours`
--

LOCK TABLES `doctor_schedule_join_hours` WRITE;
/*!40000 ALTER TABLE `doctor_schedule_join_hours` DISABLE KEYS */;
INSERT INTO `doctor_schedule_join_hours` VALUES (41,218,1,'2024-06-24 17:55:20','2024-06-24 17:55:20',NULL),(42,218,2,'2024-06-24 17:55:20','2024-06-24 17:55:20',NULL),(43,218,3,'2024-06-24 17:55:20','2024-06-24 17:55:20',NULL),(44,218,4,'2024-06-24 17:55:20','2024-06-24 17:55:20',NULL),(45,219,1,'2024-06-24 17:55:20','2024-06-24 17:55:20',NULL),(46,219,2,'2024-06-24 17:55:20','2024-06-24 17:55:20',NULL),(47,219,3,'2024-06-24 17:55:20','2024-06-24 17:55:20',NULL),(48,219,4,'2024-06-24 17:55:20','2024-06-24 17:55:20',NULL),(49,220,1,'2024-06-24 17:55:20','2024-06-24 17:55:20',NULL),(50,220,2,'2024-06-24 17:55:20','2024-06-24 17:55:20',NULL),(51,220,3,'2024-06-24 17:55:20','2024-06-24 17:55:20',NULL),(52,220,4,'2024-06-24 17:55:20','2024-06-24 17:55:20',NULL),(53,221,1,'2024-06-25 15:07:35','2024-06-25 15:07:35',NULL),(54,221,2,'2024-06-25 15:07:35','2024-06-25 15:07:35',NULL),(55,221,3,'2024-06-25 15:07:35','2024-06-25 15:07:35',NULL),(56,221,4,'2024-06-25 15:07:35','2024-06-25 15:07:35',NULL),(57,221,5,'2024-06-25 15:07:35','2024-06-25 15:07:35',NULL),(58,221,6,'2024-06-25 15:07:35','2024-06-25 15:07:35',NULL),(59,221,7,'2024-06-25 15:07:35','2024-06-25 15:07:35',NULL),(60,221,8,'2024-06-25 15:07:35','2024-06-25 15:07:35',NULL),(69,223,1,'2024-07-05 20:45:56','2024-07-05 20:45:56',NULL),(70,223,2,'2024-07-05 20:45:56','2024-07-05 20:45:56',NULL),(71,223,3,'2024-07-05 20:45:56','2024-07-05 20:45:56',NULL),(72,223,4,'2024-07-05 20:45:56','2024-07-05 20:45:56',NULL),(73,223,5,'2024-07-05 20:45:56','2024-07-05 20:45:56',NULL),(74,223,6,'2024-07-05 20:45:56','2024-07-05 20:45:56',NULL),(75,223,7,'2024-07-05 20:45:56','2024-07-05 20:45:56',NULL),(76,223,8,'2024-07-05 20:45:56','2024-07-05 20:45:56',NULL),(77,224,1,'2024-07-12 17:38:39','2024-07-12 17:38:39',NULL),(78,224,2,'2024-07-12 17:38:39','2024-07-12 17:38:39',NULL),(79,224,3,'2024-07-12 17:38:39','2024-07-12 17:38:39',NULL),(80,224,4,'2024-07-12 17:38:39','2024-07-12 17:38:39',NULL);
/*!40000 ALTER TABLE `doctor_schedule_join_hours` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'2014_10_12_000000_create_users_table',1),(2,'2014_10_12_100000_create_password_reset_tokens_table',1),(3,'2019_08_19_000000_create_failed_jobs_table',1),(4,'2019_12_14_000001_create_personal_access_tokens_table',1),(5,'2024_03_07_173021_create_permission_tables',1),(6,'2024_07_12_221002_add_archivo_to_movimiento_carpetas_table',2),(7,'2024_07_15_202837_add_archivo_nombre_to_movimiento_carpetas_table',3),(8,'2024_07_15_203648_add_archivo_nombre_to_movimiento_carpetas_table',4),(9,'2024_07_17_020314_add_fecha_vencimiento_to_movimiento_carpetas_table',5),(10,'2024_07_17_165836_add_tipo_evento_to_movimiento_carpetas_table',6),(11,'2024_07_17_184413_add_hour_to_movimiento_carpetas_table',7);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `model_has_permissions`
--

DROP TABLE IF EXISTS `model_has_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `model_has_permissions` (
  `permission_id` bigint(20) unsigned NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `model_has_permissions`
--

LOCK TABLES `model_has_permissions` WRITE;
/*!40000 ALTER TABLE `model_has_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `model_has_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `model_has_roles`
--

DROP TABLE IF EXISTS `model_has_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `model_has_roles` (
  `role_id` bigint(20) unsigned NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `model_has_roles`
--

LOCK TABLES `model_has_roles` WRITE;
/*!40000 ALTER TABLE `model_has_roles` DISABLE KEYS */;
INSERT INTO `model_has_roles` VALUES (1,'App\\Models\\User',1),(2,'App\\Models\\User',5),(2,'App\\Models\\User',6),(2,'App\\Models\\User',8),(2,'App\\Models\\User',9),(2,'App\\Models\\User',16),(2,'App\\Models\\User',17),(2,'App\\Models\\User',18),(2,'App\\Models\\User',21),(2,'App\\Models\\User',22),(2,'App\\Models\\User',23),(2,'App\\Models\\User',24),(2,'App\\Models\\User',25),(2,'App\\Models\\User',26),(2,'App\\Models\\User',27),(2,'App\\Models\\User',28),(2,'App\\Models\\User',29),(2,'App\\Models\\User',30),(2,'App\\Models\\User',31),(2,'App\\Models\\User',32),(2,'App\\Models\\User',33),(2,'App\\Models\\User',34),(2,'App\\Models\\User',35),(2,'App\\Models\\User',36),(2,'App\\Models\\User',37),(2,'App\\Models\\User',38),(2,'App\\Models\\User',39),(2,'App\\Models\\User',40),(2,'App\\Models\\User',41),(2,'App\\Models\\User',42),(2,'App\\Models\\User',43),(2,'App\\Models\\User',44),(2,'App\\Models\\User',45),(2,'App\\Models\\User',46),(2,'App\\Models\\User',47),(2,'App\\Models\\User',48),(2,'App\\Models\\User',51),(2,'App\\Models\\User',54),(2,'App\\Models\\User',55),(2,'App\\Models\\User',57),(13,'App\\Models\\User',52),(14,'App\\Models\\User',53);
/*!40000 ALTER TABLE `model_has_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movimiento_carpetas`
--

DROP TABLE IF EXISTS `movimiento_carpetas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `movimiento_carpetas` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `carpeta_id` bigint(20) unsigned NOT NULL,
  `abogado_id` bigint(20) unsigned NOT NULL,
  `comentario` longtext NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `archivo` varchar(255) DEFAULT NULL,
  `archivo_nombre` varchar(255) DEFAULT NULL,
  `fecha_vencimiento` date DEFAULT NULL,
  `tipo_evento` varchar(255) DEFAULT NULL,
  `hora_vencimiento` time DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movimiento_carpetas`
--

LOCK TABLES `movimiento_carpetas` WRITE;
/*!40000 ALTER TABLE `movimiento_carpetas` DISABLE KEYS */;
INSERT INTO `movimiento_carpetas` VALUES (6,2,55,'asd','2024-07-16 00:00:55','2024-07-17 20:56:03','2024-07-17 20:56:03',NULL,NULL,NULL,NULL,NULL),(7,2,55,'asd','2024-07-16 00:01:04','2024-07-17 20:56:03','2024-07-17 20:56:03','http://192.168.1.101:8000/storage/archivos/1721088064_prueba2.pdf','prueba2.pdf',NULL,NULL,NULL),(8,1,57,'sdf','2024-07-16 00:01:34','2024-07-16 00:01:34',NULL,NULL,NULL,NULL,NULL,NULL),(9,2,55,'movimiento numero 2','2024-07-17 01:58:16','2024-07-17 20:56:04','2024-07-17 20:56:04',NULL,NULL,NULL,NULL,NULL),(10,1,57,'movimiento numero 2 de prueba','2024-07-17 01:58:59','2024-07-17 01:58:59',NULL,NULL,NULL,NULL,NULL,NULL),(11,1,57,'jjjj','2024-07-17 02:22:51','2024-07-17 02:22:51',NULL,NULL,NULL,NULL,NULL,NULL),(12,1,57,',mn','2024-07-17 12:38:01','2024-07-17 12:38:01',NULL,NULL,NULL,NULL,NULL,NULL),(13,2,55,'eeee','2024-07-17 14:25:46','2024-07-17 20:56:04','2024-07-17 20:56:04',NULL,NULL,NULL,NULL,NULL),(14,2,55,'lll','2024-07-17 14:37:59','2024-07-17 20:56:04','2024-07-17 20:56:04',NULL,NULL,NULL,NULL,NULL),(15,2,55,'kll','2024-07-17 14:42:27','2024-07-17 20:56:05','2024-07-17 20:56:05',NULL,NULL,NULL,NULL,NULL),(16,2,55,'ss','2024-07-17 14:45:54','2024-07-17 20:56:05','2024-07-17 20:56:05',NULL,NULL,'2024-07-11',NULL,NULL),(17,2,55,'nuevo comentario','2024-07-17 15:09:48','2024-07-17 20:56:06','2024-07-17 20:56:06',NULL,NULL,'2024-07-27',NULL,NULL),(18,2,55,'nuevo comentario','2024-07-17 15:10:03','2024-07-17 20:56:06','2024-07-17 20:56:06','http://192.168.1.101:8000//storage/archivos/1721229003_prueba.docx','prueba.docx','2024-07-27',NULL,NULL),(19,2,55,'hhh','2024-07-17 15:28:56','2024-07-17 20:56:06','2024-07-17 20:56:06',NULL,NULL,'2024-07-19',NULL,NULL),(20,2,55,'kkk','2024-07-17 15:33:17','2024-07-17 20:56:07','2024-07-17 20:56:07',NULL,NULL,'2024-07-26',NULL,NULL),(21,2,55,'mmm','2024-07-17 15:48:46','2024-07-17 20:56:07','2024-07-17 20:56:07',NULL,NULL,'2024-07-19',NULL,NULL),(22,2,55,'mmm','2024-07-17 15:49:06','2024-07-17 20:56:07','2024-07-17 20:56:07','http://192.168.1.101:8000//storage/archivos/1721231346_prueba2.pdf','prueba2.pdf','2024-07-19',NULL,NULL),(23,2,55,'prueba de tarea','2024-07-17 17:07:42','2024-07-17 20:56:08','2024-07-17 20:56:08',NULL,NULL,'2024-07-18','Tareas',NULL),(24,2,55,'esto es una prueba de compromiso','2024-07-17 17:15:49','2024-07-17 20:56:08','2024-07-17 20:56:08',NULL,NULL,'2024-07-19','Compromisos',NULL),(25,2,55,'asdasd','2024-07-17 17:20:47','2024-07-17 20:56:09','2024-07-17 20:56:09',NULL,NULL,'2024-07-27','Vencimientos',NULL),(26,2,55,'bbbbb','2024-07-17 17:20:56','2024-07-17 20:56:10','2024-07-17 20:56:10',NULL,NULL,'2024-07-27','Audiencias',NULL),(27,2,55,'asdas','2024-07-17 17:21:16','2024-07-17 20:56:10','2024-07-17 20:56:10',NULL,NULL,'2024-07-27','Audiencias',NULL),(28,2,55,'Esto es una prueba de TAREA','2024-07-17 17:56:56','2024-07-17 17:56:56',NULL,NULL,NULL,'2024-07-17','Tareas',NULL),(29,2,55,'Esto es una prueba de VENCIMIENTO','2024-07-17 17:57:16','2024-07-17 17:57:16',NULL,NULL,NULL,'2024-07-18','Vencimientos',NULL),(30,2,55,'Esto es una prueba de COMPROMISO','2024-07-17 17:57:30','2024-07-17 17:57:30',NULL,NULL,NULL,'2024-07-18','Compromisos',NULL),(31,2,55,'Esto es una prueba de AUDIENCIA','2024-07-17 17:57:40','2024-07-17 17:57:40',NULL,NULL,NULL,'2024-07-18','Audiencias',NULL),(32,2,55,'Esto es una prueba de adjunto','2024-07-17 17:58:16','2024-07-17 17:58:16',NULL,'http://192.168.1.101:8000/storage/archivos/1721239096_prueba2.pdf','prueba2.pdf',NULL,NULL,NULL),(33,2,55,'Esto es una prueba de adjunto con vencimiento','2024-07-17 17:58:32','2024-07-17 17:58:32',NULL,'http://192.168.1.101:8000/storage/archivos/1721239112_prueba2.pdf','prueba2.pdf','2024-07-18','Compromisos',NULL),(34,2,55,'prueba de movimiento comun','2024-07-17 17:59:00','2024-07-17 17:59:00',NULL,NULL,NULL,NULL,NULL,NULL),(35,2,55,'prueba de hora','2024-07-17 18:52:44','2024-07-17 18:52:44',NULL,NULL,NULL,'2024-07-19','Tareas',NULL),(36,2,55,'prueba de horaaaaa','2024-07-17 18:54:31','2024-07-17 22:07:59','2024-07-17 22:07:59',NULL,NULL,'2024-07-19','Tareas','17:00:00'),(37,2,55,'zxczxczx','2024-07-17 19:08:16','2024-07-17 22:09:11','2024-07-17 22:09:11',NULL,NULL,'2024-07-19',NULL,'16:00:00'),(38,2,55,'zxcxzczxc','2024-07-17 19:09:20','2024-07-17 19:09:20',NULL,NULL,NULL,'2024-08-11',NULL,'16:09:00'),(39,2,55,'iiiii','2024-07-17 19:23:31','2024-07-17 19:23:31',NULL,NULL,NULL,'2024-07-24','Audiencias','04:23:00'),(40,2,55,'revisar el 150','2024-07-17 20:00:07','2024-07-17 20:00:07',NULL,'http://192.168.1.101:8000/storage/archivos/1721246407_prueba2.pdf','prueba2.pdf','2024-08-15','Vencimientos','08:00:00'),(41,2,55,'lkjflkdsajklfslkfgj','2024-07-17 20:00:36','2024-07-17 20:00:36',NULL,NULL,NULL,NULL,NULL,NULL),(42,2,55,'hable con elc iente y nada','2024-07-17 20:00:44','2024-07-17 20:00:44',NULL,NULL,NULL,NULL,NULL,NULL),(43,2,55,'prueba de calendario','2024-07-21 03:33:14','2024-07-21 03:33:14',NULL,NULL,NULL,'2024-07-22','Vencimientos','08:00:00'),(44,2,55,'prueba','2024-07-22 13:47:46','2024-07-22 13:47:46',NULL,NULL,NULL,'2024-07-23','Vencimientos','08:00:00');
/*!40000 ALTER TABLE `movimiento_carpetas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_tokens`
--

LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient_persons`
--

DROP TABLE IF EXISTS `patient_persons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patient_persons` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `patient_id` bigint(20) unsigned NOT NULL,
  `name_companion` varchar(250) NOT NULL,
  `surname_companion` varchar(250) NOT NULL,
  `mobile_companion` varchar(250) DEFAULT NULL,
  `relationship_companion` varchar(250) DEFAULT NULL,
  `name_responsible` varchar(250) DEFAULT NULL,
  `surname_responsible` varchar(250) DEFAULT NULL,
  `mobile_responsible` varchar(250) DEFAULT NULL,
  `relationship_responsible` varchar(250) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_persons`
--

LOCK TABLES `patient_persons` WRITE;
/*!40000 ALTER TABLE `patient_persons` DISABLE KEYS */;
INSERT INTO `patient_persons` VALUES (1,104,'sdf','sdf','234',NULL,NULL,NULL,NULL,NULL,'2024-05-23 16:16:36','2024-06-25 15:10:36',NULL);
/*!40000 ALTER TABLE `patient_persons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patients`
--

DROP TABLE IF EXISTS `patients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patients` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(250) NOT NULL,
  `surname` varchar(250) NOT NULL,
  `email` varchar(250) DEFAULT NULL,
  `mobile` varchar(25) DEFAULT NULL,
  `gender` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `avatar` varchar(250) DEFAULT NULL,
  `n_document` varchar(50) DEFAULT NULL,
  `birth_date` timestamp NULL DEFAULT NULL,
  `address` varchar(250) DEFAULT NULL,
  `education` varchar(250) DEFAULT NULL,
  `antecedent_family` text DEFAULT NULL,
  `antecedent_personal` text DEFAULT NULL,
  `antecedent_allergic` text DEFAULT NULL,
  `ta` varchar(250) DEFAULT NULL COMMENT 'presión arterial',
  `temperatura` varchar(20) DEFAULT NULL,
  `fc` varchar(50) DEFAULT NULL COMMENT 'frecuencia cardiaca',
  `fr` varchar(50) DEFAULT NULL COMMENT 'frecuencia respiratoria',
  `peso` varchar(25) DEFAULT NULL,
  `current_disease` text DEFAULT NULL COMMENT 'Enfermedad actual',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patients`
--

LOCK TABLES `patients` WRITE;
/*!40000 ALTER TABLE `patients` DISABLE KEYS */;
INSERT INTO `patients` VALUES (104,'paciente','demo','qq@qw.com','324324',2,NULL,'111','2024-05-15 06:00:00','sdf','wer','dsf','sdf','sdf','22','33','33','33','33','sdf','2024-05-23 16:16:35','2024-05-23 16:17:11',NULL);
/*!40000 ALTER TABLE `patients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permissions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` VALUES (1,'register_rol','api','2024-03-09 03:48:53','2024-03-09 03:48:53'),(2,'list_rol','api','2024-03-09 03:48:53','2024-03-09 03:48:53'),(3,'edit_rol','api','2024-03-09 03:48:53','2024-03-09 03:48:53'),(4,'delete_rol','api','2024-03-09 03:48:53','2024-03-09 03:48:53'),(5,'register_doctor','api','2024-03-09 03:48:53','2024-03-09 03:48:53'),(6,'list_doctor','api','2024-03-09 03:48:53','2024-03-09 03:48:53'),(7,'edit_doctor','api','2024-03-09 03:48:53','2024-03-09 03:48:53'),(8,'delete_doctor','api','2024-03-09 03:48:54','2024-03-09 03:48:54'),(9,'profile_doctor','api','2024-03-09 03:48:54','2024-03-09 03:48:54'),(10,'register_patient','api','2024-03-09 03:48:54','2024-03-09 03:48:54'),(11,'list_patient','api','2024-03-09 03:48:54','2024-03-09 03:48:54'),(12,'edit_patient','api','2024-03-09 03:48:54','2024-03-09 03:48:54'),(13,'delete_patient','api','2024-03-09 03:48:54','2024-03-09 03:48:54'),(14,'profile_patient','api','2024-03-09 03:48:54','2024-03-09 03:48:54'),(15,'register_staff','api','2024-03-09 03:48:54','2024-03-09 03:48:54'),(16,'list_staff','api','2024-03-09 03:48:54','2024-03-09 03:48:54'),(17,'edit_staff','api','2024-03-09 03:48:54','2024-03-09 03:48:54'),(18,'delete_staff','api','2024-03-09 03:48:54','2024-03-09 03:48:54'),(19,'register_appointment','api','2024-03-09 03:48:54','2024-03-09 03:48:54'),(20,'list_appointment','api','2024-03-09 03:48:54','2024-03-09 03:48:54'),(21,'edit_appointment','api','2024-03-09 03:48:54','2024-03-09 03:48:54'),(22,'delete_appointment','api','2024-03-09 03:48:54','2024-03-09 03:48:54'),(23,'register_specialty','api','2024-03-09 03:48:54','2024-03-09 03:48:54'),(24,'list_specialty','api','2024-03-09 03:48:54','2024-03-09 03:48:54'),(25,'edit_specialty','api','2024-03-09 03:48:54','2024-03-09 03:48:54'),(26,'delete_specialty','api','2024-03-09 03:48:55','2024-03-09 03:48:55'),(27,'show_payment','api','2024-03-09 03:48:55','2024-03-09 03:48:55'),(28,'edit_payment','api','2024-03-09 03:48:55','2024-03-09 03:48:55'),(29,'activitie','api','2024-03-09 03:48:55','2024-03-09 03:48:55'),(30,'calendar','api','2024-03-09 03:48:55','2024-03-09 03:48:55'),(31,'expense_report','api','2024-03-09 03:48:55','2024-03-09 03:48:55'),(32,'invoice_report','api','2024-03-09 03:48:55','2024-03-09 03:48:55'),(33,'settings','api','2024-03-09 03:48:55','2024-03-09 03:48:55'),(34,'admin_dashboard','api','2024-05-06 19:03:37','2024-05-06 19:03:41'),(35,'doctor_dashboard','api','2024-05-06 19:03:37','2024-05-06 19:03:41'),(36,'delete_payment','api','2024-05-06 19:03:37','2024-05-06 19:03:41'),(37,'add_payment','api','2024-05-06 19:03:37','2024-05-06 19:03:41'),(38,'attention_appointment','api','2024-05-06 19:03:37','2024-05-06 19:03:41');
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_has_permissions`
--

DROP TABLE IF EXISTS `role_has_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_has_permissions` (
  `permission_id` bigint(20) unsigned NOT NULL,
  `role_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `role_has_permissions_role_id_foreign` (`role_id`),
  CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_has_permissions`
--

LOCK TABLES `role_has_permissions` WRITE;
/*!40000 ALTER TABLE `role_has_permissions` DISABLE KEYS */;
INSERT INTO `role_has_permissions` VALUES (2,13),(6,2),(6,14),(7,2),(8,14),(9,2),(9,13),(10,2),(11,2),(12,2),(13,2),(14,2),(14,15),(16,2),(16,13),(20,2),(21,14),(24,2),(27,2),(28,2),(28,14),(30,2),(35,2),(35,13),(37,2),(38,15);
/*!40000 ALTER TABLE `role_has_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Super-Admin','api','2024-03-09 03:48:55','2024-03-09 03:48:55'),(2,'Abogado','api','2024-03-11 12:33:16','2024-05-20 16:26:07'),(13,'Cliente','api','2024-05-20 16:27:03','2024-05-20 16:27:03'),(14,'Contrarios','api','2024-05-20 16:27:25','2024-05-20 16:27:25'),(15,'Terceros','api','2024-05-20 16:27:33','2024-05-20 16:27:33');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `specialities`
--

DROP TABLE IF EXISTS `specialities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `specialities` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(250) NOT NULL,
  `state` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `specialities`
--

LOCK TABLES `specialities` WRITE;
/*!40000 ALTER TABLE `specialities` DISABLE KEYS */;
INSERT INTO `specialities` VALUES (1,'Previsional',1,'2023-10-04 07:18:43','2024-05-20 13:28:43',NULL),(13,'segunda especialidad demo',1,'2024-05-23 16:26:53','2024-06-24 17:56:06',NULL);
/*!40000 ALTER TABLE `specialities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_proceso`
--

DROP TABLE IF EXISTS `tipo_proceso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipo_proceso` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(250) NOT NULL,
  `state` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_proceso`
--

LOCK TABLES `tipo_proceso` WRITE;
/*!40000 ALTER TABLE `tipo_proceso` DISABLE KEYS */;
INSERT INTO `tipo_proceso` VALUES (1,'Previsional',1,'2023-10-04 07:18:43','2024-05-20 13:28:43',NULL),(13,'segudna especialidad demo',1,'2024-05-23 16:26:53','2024-05-23 16:26:53',NULL);
/*!40000 ALTER TABLE `tipo_proceso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `surname` varchar(250) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `specialitie_id` bigint(20) unsigned DEFAULT NULL,
  `mobile` varchar(50) DEFAULT NULL,
  `birth_date` timestamp NULL DEFAULT NULL,
  `gender` tinyint(1) unsigned NOT NULL DEFAULT 1 COMMENT '1 es masculino, 2 es femenino',
  `education` longtext DEFAULT NULL,
  `designation` longtext DEFAULT NULL,
  `address` varchar(250) DEFAULT NULL,
  `avatar` varchar(250) DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Super-Admin User','admin','juan@juan.com',NULL,'11','1970-01-01 12:00:00',1,'sx','sx','sx',NULL,'2024-03-09 03:48:55','$2y$12$gfkLvwB.3k2tYw3ViCe/fO05r6NdH3XItqdIO9/XXOBF6nXDZuYSG','i5epJHW6pV','2024-03-09 03:48:56','2024-04-12 00:42:45',NULL),(51,'abogado2','Perez','es@ewa.com',1,'123123','2024-05-15 06:00:00',1,'es','se','asd','staffs/3RnDnki5KJ3mgo2mYlKaeRJ9oKOOFBgF9HE93W2m.png',NULL,'$2y$12$5gtypD2R/yzA9U6uARCos.lcy65tCgjkqFVr3xX30Sbh1.o4jg2pu',NULL,'2024-05-23 18:55:54','2024-06-24 20:55:20',NULL),(52,'cliente1','zxc','asd@asd.com',NULL,'234324','2024-05-29 06:00:00',2,NULL,'asd','asd',NULL,NULL,'$2y$12$7K0OOP6GQeBu.v5PCoL90.JTO6wum6ooMGM9MzdrOyAwu3De8IZ.S',NULL,'2024-05-23 19:00:05','2024-06-24 20:54:37',NULL),(53,'Contrario1','vcvc','ws@gfh.com',NULL,'123','2024-05-08 06:00:00',1,'sd','xc','sd',NULL,NULL,'$2y$12$yFUrBnHuVLr8jMGvbvQKC.z5ptUS1uLtTFGBuviLSsqW5ObQMmDIm',NULL,'2024-05-23 19:13:11','2024-06-24 20:54:21',NULL),(54,'Abogado1','demo','pepe@pepe.com',1,'123123123','2024-06-13 06:00:00',1,'asd','asd','asd','staffs/axwMRJrTv05O9YbJbiBa0BuGgxVbbjumYpbbYFsa.jpg',NULL,'$2y$12$H4GhgT9e6Gh.KV8N54a25uJtzT9zgzhBacvOtOjZlUBRQ4ZPneFIe',NULL,'2024-06-14 19:20:02','2024-06-24 20:55:04',NULL),(55,'Guadalupe','Amendolara','estudiojuridico@amendolara.com.ar',13,'1152590727','1976-07-23 06:00:00',2,'Abogada','asda','asdsad','staffs/xmtkwNqgKcY6aIq8TAPwjWlZrtsT2KOcBOAqIJ7d.jpg',NULL,'$2y$12$USlViasl2U/XxUhxPP40auYoBAGkdNdZkJwy9b34ak2icVg/RWtzi',NULL,'2024-07-05 19:08:52','2024-07-05 23:45:56',NULL),(57,'Juan','Meneguzzi','jmeneguzzi@gmail.com',13,'1168341879','1976-12-29 15:00:00',1,'Administrador','Ad','asd','staffs/rvVX3Ddlk6oAmh0gGqDRFueSEXzRRW1vTtSguJPF.png',NULL,'$2y$12$.JZ14gGQb4tAhOpcmkTjVOfYt/0wyY5ER4550M66t.0etQsSdRTZ2',NULL,'2024-07-12 20:38:39','2024-07-12 20:38:39',NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-07-22 19:29:54
