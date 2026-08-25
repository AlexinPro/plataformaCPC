-- MySQL dump 10.13  Distrib 8.0.30, for Win64 (x86_64)
--
-- Host: localhost    Database: planeacion
-- ------------------------------------------------------
-- Server version	8.0.30

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
-- Table structure for table `asistencias`
--

DROP TABLE IF EXISTS `asistencias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `asistencias` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `integrante_id` bigint unsigned NOT NULL,
  `tipo_sesion` enum('ordinaria','solemne','extraordinaria') COLLATE utf8mb4_unicode_ci NOT NULL,
  `evidencia` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha` date NOT NULL,
  `estado` enum('asistio','falto','justificada') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'asistio',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `asistencias_integrante_id_foreign` (`integrante_id`),
  CONSTRAINT `asistencias_integrante_id_foreign` FOREIGN KEY (`integrante_id`) REFERENCES `integrantes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=237 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asistencias`
--

LOCK TABLES `asistencias` WRITE;
/*!40000 ALTER TABLE `asistencias` DISABLE KEYS */;
INSERT INTO `asistencias` VALUES (107,46,'ordinaria','evidencias/WxUM32pYp2OYIJQzYmzh72NlEEg0Hauj9H1k49Rd.pdf','2025-12-04','asistio','2025-12-24 01:39:30','2025-12-24 01:39:30'),(108,47,'ordinaria','evidencias/WxUM32pYp2OYIJQzYmzh72NlEEg0Hauj9H1k49Rd.pdf','2025-12-04','asistio','2025-12-24 01:39:31','2025-12-24 01:39:31'),(110,49,'ordinaria','evidencias/WxUM32pYp2OYIJQzYmzh72NlEEg0Hauj9H1k49Rd.pdf','2025-12-04','asistio','2025-12-24 01:39:31','2025-12-24 01:39:31'),(111,46,'extraordinaria','evidencias/jkIu6ChPrY7U4yiVfWNOFa851qbWPYryyfzcau0p.pdf','2025-12-05','asistio','2025-12-24 01:39:46','2025-12-24 01:39:46'),(112,47,'extraordinaria','evidencias/jkIu6ChPrY7U4yiVfWNOFa851qbWPYryyfzcau0p.pdf','2025-12-05','asistio','2025-12-24 01:39:46','2025-12-24 01:39:46'),(114,49,'extraordinaria','evidencias/jkIu6ChPrY7U4yiVfWNOFa851qbWPYryyfzcau0p.pdf','2025-12-05','asistio','2025-12-24 01:39:46','2025-12-24 01:39:46'),(115,46,'solemne',NULL,'2025-12-09','asistio','2025-12-24 04:34:19','2025-12-24 04:34:19'),(116,47,'solemne',NULL,'2025-12-09','asistio','2025-12-24 04:34:19','2025-12-24 04:34:19'),(118,49,'solemne',NULL,'2025-12-09','asistio','2025-12-24 04:34:19','2025-12-24 04:34:19'),(119,46,'ordinaria','evidencias/KeHAbi597iR8sHCe1xmL7pZ0mP5oBkcIyYqTNTQ5.pdf','2025-12-10','asistio','2025-12-24 04:35:32','2025-12-24 04:35:32'),(120,47,'ordinaria','evidencias/KeHAbi597iR8sHCe1xmL7pZ0mP5oBkcIyYqTNTQ5.pdf','2025-12-10','asistio','2025-12-24 04:35:32','2025-12-24 04:35:32'),(122,49,'ordinaria','evidencias/KeHAbi597iR8sHCe1xmL7pZ0mP5oBkcIyYqTNTQ5.pdf','2025-12-10','asistio','2025-12-24 04:35:32','2025-12-24 04:35:32'),(123,46,'extraordinaria',NULL,'2026-01-09','asistio','2026-01-08 06:27:56','2026-01-08 06:27:56'),(124,47,'extraordinaria',NULL,'2026-01-09','asistio','2026-01-08 06:27:56','2026-01-08 06:27:56'),(125,49,'extraordinaria',NULL,'2026-01-09','asistio','2026-01-08 06:27:56','2026-01-08 06:27:56'),(126,70,'extraordinaria',NULL,'2026-01-09','asistio','2026-01-08 06:27:56','2026-01-08 06:27:56'),(127,50,'solemne',NULL,'2026-01-02','asistio','2026-01-09 11:22:17','2026-01-09 11:22:17'),(128,51,'solemne',NULL,'2026-01-02','asistio','2026-01-09 11:22:17','2026-01-09 11:22:17'),(129,52,'solemne',NULL,'2026-01-02','asistio','2026-01-09 11:22:17','2026-01-09 11:22:17'),(130,53,'solemne',NULL,'2026-01-02','asistio','2026-01-09 11:22:17','2026-01-09 11:22:17'),(132,50,'solemne',NULL,'2026-01-03','asistio','2026-01-09 11:22:28','2026-01-09 11:22:28'),(133,51,'solemne',NULL,'2026-01-03','asistio','2026-01-09 11:22:28','2026-01-09 11:22:28'),(134,52,'solemne',NULL,'2026-01-03','asistio','2026-01-09 11:22:28','2026-01-09 11:22:28'),(135,53,'solemne',NULL,'2026-01-03','asistio','2026-01-09 11:22:28','2026-01-09 11:22:28'),(137,50,'ordinaria',NULL,'2026-01-04','asistio','2026-01-09 11:22:37','2026-01-09 11:22:37'),(138,51,'ordinaria',NULL,'2026-01-04','asistio','2026-01-09 11:22:37','2026-01-09 11:22:37'),(139,52,'ordinaria',NULL,'2026-01-04','asistio','2026-01-09 11:22:37','2026-01-09 11:22:37'),(140,53,'ordinaria',NULL,'2026-01-04','asistio','2026-01-09 11:22:37','2026-01-09 11:22:37'),(142,46,'ordinaria','evidencias/j2x989qhUfZOXDxGwXiZgMT2O4CsZnMM4PycQwii.pdf','2026-01-26','asistio','2026-01-23 23:30:10','2026-01-23 23:30:10'),(143,47,'ordinaria','evidencias/j2x989qhUfZOXDxGwXiZgMT2O4CsZnMM4PycQwii.pdf','2026-01-26','asistio','2026-01-23 23:30:10','2026-01-23 23:30:10'),(144,49,'ordinaria','evidencias/j2x989qhUfZOXDxGwXiZgMT2O4CsZnMM4PycQwii.pdf','2026-01-26','asistio','2026-01-23 23:30:10','2026-01-23 23:30:10'),(145,70,'ordinaria','evidencias/j2x989qhUfZOXDxGwXiZgMT2O4CsZnMM4PycQwii.pdf','2026-01-26','asistio','2026-01-23 23:30:10','2026-01-23 23:30:10'),(147,46,'solemne',NULL,'2026-01-27','asistio','2026-01-23 23:30:31','2026-01-23 23:30:31'),(148,47,'solemne',NULL,'2026-01-27','asistio','2026-01-23 23:30:31','2026-01-23 23:30:31'),(149,49,'solemne',NULL,'2026-01-27','asistio','2026-01-23 23:30:31','2026-01-23 23:30:31'),(150,70,'solemne',NULL,'2026-01-27','asistio','2026-01-23 23:30:31','2026-01-23 23:30:31'),(152,46,'extraordinaria','evidencias/6X9TzaY9Q0WN9qAAE3wszz9Mif8fKVJIc4IbeUeG.pdf','2026-01-28','asistio','2026-01-23 23:30:57','2026-01-23 23:30:57'),(153,47,'extraordinaria','evidencias/6X9TzaY9Q0WN9qAAE3wszz9Mif8fKVJIc4IbeUeG.pdf','2026-01-28','asistio','2026-01-23 23:30:57','2026-01-23 23:30:57'),(154,49,'extraordinaria','evidencias/6X9TzaY9Q0WN9qAAE3wszz9Mif8fKVJIc4IbeUeG.pdf','2026-01-28','asistio','2026-01-23 23:30:57','2026-01-23 23:30:57'),(155,70,'extraordinaria','evidencias/6X9TzaY9Q0WN9qAAE3wszz9Mif8fKVJIc4IbeUeG.pdf','2026-01-28','asistio','2026-01-23 23:30:57','2026-01-23 23:30:57'),(157,46,'solemne',NULL,'2026-01-29','asistio','2026-01-23 23:32:29','2026-01-23 23:32:29'),(158,47,'solemne',NULL,'2026-01-29','asistio','2026-01-23 23:32:29','2026-01-23 23:32:29'),(159,49,'solemne',NULL,'2026-01-29','asistio','2026-01-23 23:32:29','2026-01-23 23:32:29'),(160,70,'solemne',NULL,'2026-01-29','asistio','2026-01-23 23:32:29','2026-01-23 23:32:29'),(162,54,'solemne',NULL,'2026-01-10','asistio','2026-01-31 15:05:09','2026-01-31 15:05:09'),(163,55,'solemne',NULL,'2026-01-10','asistio','2026-01-31 15:05:09','2026-01-31 15:05:09'),(164,56,'solemne',NULL,'2026-01-10','asistio','2026-01-31 15:05:09','2026-01-31 15:05:09'),(165,57,'solemne',NULL,'2026-01-10','asistio','2026-01-31 15:05:09','2026-01-31 15:05:09'),(166,58,'solemne',NULL,'2026-01-10','asistio','2026-01-31 15:05:09','2026-01-31 15:05:09'),(167,54,'ordinaria',NULL,'2026-01-11','asistio','2026-01-31 15:05:17','2026-01-31 15:05:17'),(168,55,'ordinaria',NULL,'2026-01-11','asistio','2026-01-31 15:05:17','2026-01-31 15:05:17'),(169,56,'ordinaria',NULL,'2026-01-11','asistio','2026-01-31 15:05:17','2026-01-31 15:05:17'),(170,57,'ordinaria',NULL,'2026-01-11','asistio','2026-01-31 15:05:17','2026-01-31 15:05:17'),(171,58,'ordinaria',NULL,'2026-01-11','asistio','2026-01-31 15:05:17','2026-01-31 15:05:17'),(172,54,'extraordinaria',NULL,'2026-01-09','asistio','2026-01-31 15:05:24','2026-01-31 15:05:24'),(173,55,'extraordinaria',NULL,'2026-01-09','asistio','2026-01-31 15:05:24','2026-01-31 15:05:24'),(174,56,'extraordinaria',NULL,'2026-01-09','asistio','2026-01-31 15:05:24','2026-01-31 15:05:24'),(175,57,'extraordinaria',NULL,'2026-01-09','asistio','2026-01-31 15:05:24','2026-01-31 15:05:24'),(176,58,'extraordinaria',NULL,'2026-01-09','asistio','2026-01-31 15:05:24','2026-01-31 15:05:24'),(177,46,'extraordinaria','evidencias/UpxVyXWjxdPc6bxQiSYNDaEmR5F55ZYXICPXBBR9.pdf','2025-12-12','justificada','2026-02-01 15:42:31','2026-02-01 15:42:31'),(178,47,'extraordinaria','evidencias/UpxVyXWjxdPc6bxQiSYNDaEmR5F55ZYXICPXBBR9.pdf','2025-12-12','falto','2026-02-01 15:42:31','2026-02-01 15:42:31'),(179,49,'extraordinaria','evidencias/UpxVyXWjxdPc6bxQiSYNDaEmR5F55ZYXICPXBBR9.pdf','2025-12-12','falto','2026-02-01 15:42:31','2026-02-01 15:42:31'),(180,70,'extraordinaria','evidencias/UpxVyXWjxdPc6bxQiSYNDaEmR5F55ZYXICPXBBR9.pdf','2025-12-12','falto','2026-02-01 15:42:31','2026-02-01 15:42:31'),(181,46,'ordinaria',NULL,'2025-12-13','asistio','2026-02-01 15:42:52','2026-02-01 15:42:52'),(182,47,'ordinaria',NULL,'2025-12-13','falto','2026-02-01 15:42:52','2026-02-01 15:42:52'),(183,49,'ordinaria',NULL,'2025-12-13','falto','2026-02-01 15:42:52','2026-02-01 15:42:52'),(184,70,'ordinaria',NULL,'2025-12-13','justificada','2026-02-01 15:42:52','2026-02-01 15:42:52'),(185,50,'solemne',NULL,'2026-01-06','justificada','2026-02-01 15:46:09','2026-02-01 15:46:09'),(186,51,'solemne',NULL,'2026-01-06','justificada','2026-02-01 15:46:09','2026-02-01 15:46:09'),(187,52,'solemne',NULL,'2026-01-06','asistio','2026-02-01 15:46:09','2026-02-01 15:46:09'),(188,53,'solemne',NULL,'2026-01-06','falto','2026-02-01 15:46:09','2026-02-01 15:46:09'),(189,50,'extraordinaria',NULL,'2026-01-15','falto','2026-02-01 15:46:29','2026-02-01 15:46:29'),(190,51,'extraordinaria',NULL,'2026-01-15','falto','2026-02-01 15:46:29','2026-02-01 15:46:29'),(191,52,'extraordinaria',NULL,'2026-01-15','asistio','2026-02-01 15:46:29','2026-02-01 15:46:29'),(192,53,'extraordinaria',NULL,'2026-01-15','justificada','2026-02-01 15:46:29','2026-02-01 15:46:29'),(193,50,'ordinaria',NULL,'2026-01-17','justificada','2026-02-01 15:46:42','2026-02-01 15:46:42'),(194,51,'ordinaria',NULL,'2026-01-17','justificada','2026-02-01 15:46:42','2026-02-01 15:46:42'),(195,52,'ordinaria',NULL,'2026-01-17','falto','2026-02-01 15:46:42','2026-02-01 15:46:42'),(196,53,'ordinaria',NULL,'2026-01-17','asistio','2026-02-01 15:46:42','2026-02-01 15:46:42'),(197,50,'extraordinaria',NULL,'2026-01-18','falto','2026-02-01 15:47:07','2026-02-01 15:47:07'),(198,51,'extraordinaria',NULL,'2026-01-18','falto','2026-02-01 15:47:07','2026-02-01 15:47:07'),(199,52,'extraordinaria',NULL,'2026-01-18','falto','2026-02-01 15:47:07','2026-02-01 15:47:07'),(200,53,'extraordinaria',NULL,'2026-01-18','falto','2026-02-01 15:47:07','2026-02-01 15:47:07'),(201,50,'solemne',NULL,'2026-01-19','falto','2026-02-01 15:47:23','2026-02-01 15:47:23'),(202,51,'solemne',NULL,'2026-01-19','falto','2026-02-01 15:47:23','2026-02-01 15:47:23'),(203,52,'solemne',NULL,'2026-01-19','falto','2026-02-01 15:47:23','2026-02-01 15:47:23'),(204,53,'solemne',NULL,'2026-01-19','falto','2026-02-01 15:47:23','2026-02-01 15:47:23'),(205,54,'extraordinaria',NULL,'2026-01-12','falto','2026-02-01 15:49:59','2026-02-01 15:49:59'),(206,55,'extraordinaria',NULL,'2026-01-12','falto','2026-02-01 15:49:59','2026-02-01 15:49:59'),(207,56,'extraordinaria',NULL,'2026-01-12','asistio','2026-02-01 15:49:59','2026-02-01 15:49:59'),(208,57,'extraordinaria',NULL,'2026-01-12','asistio','2026-02-01 15:49:59','2026-02-01 15:49:59'),(209,58,'extraordinaria',NULL,'2026-01-12','justificada','2026-02-01 15:49:59','2026-02-01 15:49:59'),(210,54,'extraordinaria',NULL,'2026-01-14','asistio','2026-02-01 15:50:20','2026-02-01 15:50:20'),(211,55,'extraordinaria',NULL,'2026-01-14','falto','2026-02-01 15:50:20','2026-02-01 15:50:20'),(212,56,'extraordinaria',NULL,'2026-01-14','falto','2026-02-01 15:50:20','2026-02-01 15:50:20'),(213,57,'extraordinaria',NULL,'2026-01-14','justificada','2026-02-01 15:50:20','2026-02-01 15:50:20'),(214,58,'extraordinaria',NULL,'2026-01-14','falto','2026-02-01 15:50:20','2026-02-01 15:50:20'),(215,54,'solemne',NULL,'2026-01-15','falto','2026-02-01 15:51:05','2026-02-01 15:51:05'),(216,55,'solemne',NULL,'2026-01-15','asistio','2026-02-01 15:51:05','2026-02-01 15:51:05'),(217,56,'solemne',NULL,'2026-01-15','asistio','2026-02-01 15:51:05','2026-02-01 15:51:05'),(218,57,'solemne',NULL,'2026-01-15','falto','2026-02-01 15:51:05','2026-02-01 15:51:05'),(219,58,'solemne',NULL,'2026-01-15','falto','2026-02-01 15:51:05','2026-02-01 15:51:05'),(220,75,'extraordinaria','evidencias/BhVA4oppC9iJs38gGrEOXkIhOspyp4w2YJyCQqg0.pdf','2026-02-01','justificada','2026-02-01 15:55:19','2026-02-01 15:55:19'),(222,77,'extraordinaria','evidencias/BhVA4oppC9iJs38gGrEOXkIhOspyp4w2YJyCQqg0.pdf','2026-02-01','justificada','2026-02-01 15:55:19','2026-02-01 15:55:19'),(223,75,'solemne','evidencias/vsVoFBvrJG6PwbynqQtDTFRZzh2ZdO3jdiNdVfTt.pdf','2026-02-02','falto','2026-02-01 15:55:32','2026-02-01 15:55:32'),(225,77,'solemne','evidencias/vsVoFBvrJG6PwbynqQtDTFRZzh2ZdO3jdiNdVfTt.pdf','2026-02-02','falto','2026-02-01 15:55:32','2026-02-01 15:55:32'),(226,75,'ordinaria','evidencias/523rW75Qcf0O1oAI2g5TCGBqS84ICetmQt9PcIVN.pdf','2026-02-03','asistio','2026-02-01 15:55:41','2026-02-01 15:55:41'),(228,77,'ordinaria','evidencias/523rW75Qcf0O1oAI2g5TCGBqS84ICetmQt9PcIVN.pdf','2026-02-03','asistio','2026-02-01 15:55:41','2026-02-01 15:55:41'),(229,75,'extraordinaria',NULL,'2026-02-19','justificada','2026-02-01 15:56:11','2026-02-01 15:56:11'),(231,77,'extraordinaria',NULL,'2026-02-19','asistio','2026-02-01 15:56:11','2026-02-01 15:56:11'),(232,75,'extraordinaria','evidencias/bWufr3mJkyadl8h37qD3mUdoBOH0P7kpMMdHkJV0.pdf','2026-02-28','asistio','2026-02-01 15:56:27','2026-02-01 15:56:27'),(234,77,'extraordinaria','evidencias/bWufr3mJkyadl8h37qD3mUdoBOH0P7kpMMdHkJV0.pdf','2026-02-28','asistio','2026-02-01 15:56:27','2026-02-01 15:56:27'),(235,75,'extraordinaria',NULL,'2026-03-07','justificada','2026-02-02 03:42:04','2026-02-02 03:42:04'),(236,77,'extraordinaria',NULL,'2026-03-07','justificada','2026-02-02 03:42:04','2026-02-02 03:42:04');
/*!40000 ALTER TABLE `asistencias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache`
--

LOCK TABLES `cache` WRITE;
/*!40000 ALTER TABLE `cache` DISABLE KEYS */;
INSERT INTO `cache` VALUES ('implan@test.com|127.0.0.1','i:1;',1769699498),('implan@test.com|127.0.0.1:timer','i:1769699498;',1769699498),('spatie.permission.cache','a:3:{s:5:\"alias\";a:4:{s:1:\"a\";s:2:\"id\";s:1:\"b\";s:4:\"name\";s:1:\"c\";s:10:\"guard_name\";s:1:\"r\";s:5:\"roles\";}s:11:\"permissions\";a:12:{i:0;a:4:{s:1:\"a\";i:1;s:1:\"b\";s:14:\"usuarios.crear\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:2;}}i:1;a:4:{s:1:\"a\";i:2;s:1:\"b\";s:15:\"usuarios.editar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:2;}}i:2;a:4:{s:1:\"a\";i:3;s:1:\"b\";s:19:\"convocatorias.crear\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:2;}}i:3;a:4:{s:1:\"a\";i:4;s:1:\"b\";s:16:\"documentos.subir\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:2;i:1;i:3;}}i:4;a:4:{s:1:\"a\";i:5;s:1:\"b\";s:15:\"asistencias.ver\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:2;i:1;i:3;}}i:5;a:4:{s:1:\"a\";i:6;s:1:\"b\";s:17:\"asistencias.crear\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:2;}}i:6;a:4:{s:1:\"a\";i:7;s:1:\"b\";s:12:\"consejos.ver\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:2;i:1;i:3;}}i:7;a:4:{s:1:\"a\";i:8;s:1:\"b\";s:13:\"legalidad.ver\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:3:{i:0;i:2;i:1;i:3;i:2;i:4;}}i:8;a:4:{s:1:\"a\";i:9;s:1:\"b\";s:12:\"reportes.ver\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:2;i:1;i:3;}}i:9;a:3:{s:1:\"a\";i:10;s:1:\"b\";s:30:\"legalidad.solicitar_reeleccion\";s:1:\"c\";s:3:\"web\";}i:10;a:4:{s:1:\"a\";i:11;s:1:\"b\";s:28:\"legalidad.validar_reeleccion\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:4;}}i:11;a:4:{s:1:\"a\";i:12;s:1:\"b\";s:29:\"legalidad.rechazar_reeleccion\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:4;}}}s:5:\"roles\";a:3:{i:0;a:3:{s:1:\"a\";i:2;s:1:\"b\";s:5:\"admin\";s:1:\"c\";s:3:\"web\";}i:1;a:3:{s:1:\"a\";i:3;s:1:\"b\";s:10:\"integrante\";s:1:\"c\";s:3:\"web\";}i:2;a:3:{s:1:\"a\";i:4;s:1:\"b\";s:11:\"super-admin\";s:1:\"c\";s:3:\"web\";}}}',1770270491),('xddd@test.com|127.0.0.1','i:1;',1770192686),('xddd@test.com|127.0.0.1:timer','i:1770192686;',1770192686);
/*!40000 ALTER TABLE `cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_locks`
--

LOCK TABLES `cache_locks` WRITE;
/*!40000 ALTER TABLE `cache_locks` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_locks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consejos`
--

DROP TABLE IF EXISTS `consejos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `consejos` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consejos`
--

LOCK TABLES `consejos` WRITE;
/*!40000 ALTER TABLE `consejos` DISABLE KEYS */;
INSERT INTO `consejos` VALUES (1,'Asuntos Indígenas','Fomentar la participación, reconocimiento y preservación de los derechos, culturas y lenguas de los pueblos indígenas que habitan en el municipio. ',NULL,NULL),(2,'Bienestar','Proponer acciones para mejorar las condiciones de vida de la población mediante el acceso a servicios básicos, programas sociales y desarrollo comunitario.',NULL,NULL),(3,'Bienestar Animal','Impulsar políticas de protección, cuidado y trato digno hacia los animales, promoviendo la tenencia responsable y la conciencia ciudadana.',NULL,NULL),(4,'Centro Histórico y Patrimonio Edificado','Coadyuvar en la conservación, rehabilitación y aprovechamiento del patrimonio arquitectónico y cultural del centro histórico.',NULL,NULL),(5,'Cultura\r\n','Fomentar el acceso a la vida cultural del municipio, el fortalecimiento de las expresiones artísticas y el patrimonio cultural.\r\n',NULL,NULL),(6,'Deporte','Promover el deporte y la actividad física como medios para mejorar la salud, la convivencia y el desarrollo comunitario.\r\n',NULL,NULL),(7,'Derechos Humanos e Igualdad entre Géneros','Fortalecer la cultura de derechos humanos, la no discriminación y la igualdad sustantiva.',NULL,NULL),(8,'Desarrollo Urbano','Participar en la planeación del crecimiento ordenado del municipio, proponiendo estrategias para un desarrollo urbano sostenible e incluyente.',NULL,NULL),(9,'Desempeño Gubernamental','Proponer mejoras en la eficiencia, transparencia y rendición de cuentas del gobierno municipal.',NULL,NULL),(10,'Discapacidad','Promover la inclusión plena de personas con discapacidad, eliminando barreras físicas, sociales y culturales en la vida municipal.',NULL,NULL),(11,'Ecología y Medio Ambiente','Promover políticas y acciones de educación ecológica y desarrollo sustentable.',NULL,NULL),(12,'Educación','Contribuir a la mejora del sistema educativo municipal, el acceso equitativo a la educación y la permanencia escolar.',NULL,NULL),(13,'Juventud','Fomentar el acceso a la vida cultural del municipio, el fortalecimiento de las expresiones artísticas y el patrimonio cultural.',NULL,NULL),(14,'Niñez y la Adolescencia','Promover acciones y políticas que garanticen los derechos, bienestar y desarrollo integral de las infancias y adolescencias en el municipio.',NULL,NULL),(15,'Obras y Servicios Públicos','Proponer mejoras en la infraestructura, mantenimiento y calidad de los servicios públicos municipales.',NULL,NULL),(16,'Movilidad','Proponer soluciones integrales para una movilidad segura, eficiente, equitativa y sustentable en la ciudad.',NULL,NULL),(17,'Personas en Situación de Vulnerabilidad','Impulsar propuestas para mejorar las condiciones de vida y promover la inclusión de personas en condiciones de vulnerabilidad.',NULL,NULL),(18,'Protección Civil','Impulsar acciones de prevención y respuesta ante riesgos, desastres naturales y emergencias, fortaleciendo la cultura de la protección civil.',NULL,NULL),(19,'Salud','Fomentar acciones para la promoción de la salud, la prevención de enfermedades y la mejora de los servicios municipales en la materia.',NULL,NULL),(20,'Seguridad Pública','Coadyuvar en el fortalecimiento de la prevención del delito y la construcción de entornos seguros.',NULL,NULL),(21,'Turismo','Impulsar estrategias para el fomento del turismo cultural, ecológico y socialmente responsable en el municipio.',NULL,NULL),(22,'Vialidad y Transporte','Realizar propuestas enfocadas a la mejora del sistema de transporte y la seguridad vial.',NULL,NULL);
/*!40000 ALTER TABLE `consejos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `convocatorias`
--

DROP TABLE IF EXISTS `convocatorias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `convocatorias` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `consejo_id` bigint unsigned NOT NULL,
  `tipo_sesion` enum('ordinaria','solemne','extraordinaria') COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha` date DEFAULT NULL,
  `documento` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estado_convocatoria` tinyint(1) NOT NULL DEFAULT '0',
  `estado_sesion` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `convocatorias_consejo_id_foreign` (`consejo_id`),
  CONSTRAINT `convocatorias_consejo_id_foreign` FOREIGN KEY (`consejo_id`) REFERENCES `consejos` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `convocatorias`
--

LOCK TABLES `convocatorias` WRITE;
/*!40000 ALTER TABLE `convocatorias` DISABLE KEYS */;
INSERT INTO `convocatorias` VALUES (1,1,'ordinaria','2025-10-26','convocatorias/uKRWX76r9tVrdueBInR9rfPhCNEtzYiaPkvbSk55.pdf',1,1,'2025-10-27 09:54:25','2025-10-27 09:54:25'),(2,1,'extraordinaria','2025-10-24','convocatorias/qyfnLIscoxQY6NoCp4yRP7rcvn41d2AGNSeGAo1s.pdf',1,0,'2025-10-27 21:00:10','2025-10-27 21:00:10'),(3,1,'solemne','2025-09-01','convocatorias/ZFQOQknrRmjNH3TZa6nSIs0urzcKmmZQAUMvB2pc.pdf',0,1,'2025-10-27 21:01:51','2025-10-27 21:01:51'),(4,1,'ordinaria','2025-10-27','convocatorias/tigUpnY6t1lwj0mvtCbIfRPMy5yTo9DBf6FzQSiJ.pdf',1,0,'2025-10-27 21:04:19','2025-10-27 21:04:19'),(5,2,'ordinaria','2025-08-30','convocatorias/jrnBNYrMXgv4e2kqEwlyKf69DZOcuT54IF3H9O2Z.pdf',1,0,'2025-10-27 21:45:59','2025-10-27 21:45:59'),(6,2,'extraordinaria','2025-05-17','convocatorias/cPXTHX62Hb5t3X9iQE6454dlaZYBZpteTqeeMviu.pdf',0,1,'2025-10-27 21:46:27','2025-10-27 21:46:27'),(7,2,'solemne','2025-09-10','convocatorias/Q7o0zzhTKGPjFpoZt3FZNskr66fIR8EnYBGNZWZ6.pdf',1,0,'2025-10-27 21:50:42','2025-10-27 21:50:42'),(8,5,'ordinaria','2025-10-27','convocatorias/36LoZFYK4k8HrowlIdRLFo9ysfzHt7vC2mT5c02W.pdf',1,1,'2025-10-27 21:57:49','2025-10-27 21:57:49'),(9,5,'ordinaria','2025-07-02','convocatorias/DYW9Cg8UCpf5SvWxf1NC838cjXTHags6RPd4SMuV.pdf',0,1,'2025-10-27 21:58:25','2025-10-27 21:58:25'),(10,5,'ordinaria','2025-09-10','convocatorias/L2ZT4aWd3qib4syEjMxUSIo8sRiO4Uc5Z5dvVcOI.pdf',0,1,'2025-10-27 22:17:08','2025-10-27 22:17:08'),(11,5,'ordinaria','2025-06-20','convocatorias/KYhIx84TGXyQHza6FjJPaaAVkfrQxGeyxD6djSSj.pdf',1,1,'2025-10-27 22:18:27','2025-10-27 22:18:27'),(12,5,'extraordinaria','2025-08-02','convocatorias/a5dDm57CgLJ6XBD5HZAivgHMq4iB6BqNXhY6PWFO.pdf',1,0,'2025-10-27 22:18:54','2025-10-27 22:18:54'),(13,1,'ordinaria','2025-10-13','convocatorias/Bt5x25C2HzjP0ZViG27raUVaHlQ6uUVHkePM8Ku3.pdf',0,0,'2025-10-28 00:36:04','2025-10-28 00:36:04'),(14,3,'ordinaria','2025-02-03','convocatorias/YdVAhGyKA0FMvR4flneGyxc7vjNlXOGWWomIrbKB.pdf',1,1,'2025-11-04 03:42:58','2025-11-04 03:42:58'),(15,3,'extraordinaria','2025-01-25',NULL,1,0,'2025-11-04 03:43:34','2025-11-04 03:43:34'),(16,1,'ordinaria','2025-01-12','convocatorias/uB48b8AOrUoovKNOH3OMSuGZc66M3qZWiDP29Auy.pdf',1,1,'2025-11-10 12:58:30','2025-11-10 12:58:30'),(17,3,'ordinaria','2025-10-10','convocatorias/WpJLUyKkDk5HybYxrG82CAPMpxsy4gapNQgYFkbc.pdf',1,1,'2025-11-13 10:54:48','2025-11-13 10:54:48'),(18,3,'solemne','2025-11-12','convocatorias/r2ICZSZaxI5wp2gsEKlbqnBjsoqYIF84brCmgemg.pdf',0,0,'2025-11-18 13:36:05','2025-11-18 13:36:05'),(19,1,'ordinaria','2025-11-18','convocatorias/QA4W9lOgtTFzQ9vqXLmpMQwmPwtBvdI9eU6AZ2hx.pdf',1,0,'2025-11-19 00:37:18','2025-11-19 00:37:18'),(20,1,'ordinaria','2025-12-10',NULL,0,0,'2025-12-09 01:40:14','2025-12-09 01:40:14'),(21,1,'ordinaria','2025-12-10','convocatorias/ZbDlbdvkqb4onz6XUCEkDN5Vp67LX7zILNOev6zR.pdf',1,1,'2025-12-09 01:41:00','2025-12-09 01:41:00'),(22,1,'solemne','2026-01-27','convocatorias/e89Oc51XZyW0Kr2eoB5lDYwim6BDDSqdfdHyM74L.pdf',1,1,'2026-01-23 23:40:23','2026-01-23 23:40:23'),(23,2,'solemne','2026-01-26','convocatorias/iPZBtUNEgUncljOGYhTYija59ShcWY6RQFerjP47.pdf',1,1,'2026-01-26 11:54:58','2026-01-26 11:54:58'),(24,3,'ordinaria','2026-01-25','convocatorias/KmZ3ayqaj3VALddWbXrqyKfcvh3pjjUgB2tImr4O.pdf',1,0,'2026-01-26 12:00:44','2026-01-26 12:00:44'),(25,3,'solemne','2026-01-27',NULL,1,0,'2026-01-26 12:01:26','2026-01-26 12:01:26'),(26,4,'solemne','2026-01-27','convocatorias/jKDE8JCg3O5d7rUX3yOMVA7dkCGVlXaiys8Urt2q.pdf',1,1,'2026-01-29 14:40:38','2026-01-29 14:40:38');
/*!40000 ALTER TABLE `convocatorias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `docus`
--

DROP TABLE IF EXISTS `docus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `docus` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `integrante_id` bigint unsigned NOT NULL,
  `tipo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `archivo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `docus_integrante_id_tipo_unique` (`integrante_id`,`tipo`),
  CONSTRAINT `docus_integrante_id_foreign` FOREIGN KEY (`integrante_id`) REFERENCES `integrantes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `docus`
--

LOCK TABLES `docus` WRITE;
/*!40000 ALTER TABLE `docus` DISABLE KEYS */;
INSERT INTO `docus` VALUES (86,49,'ine','documentos/49/YuMJ47qLB0L9nFVn4tcnehf09poFX20U0nftN3iZ.pdf','2025-11-21 12:17:00','2025-11-21 12:17:00'),(87,49,'comprobante_domiciliario','documentos/49/3ufHGJX3MUKTEyFOxDaohAgH4kN8MgcvsjUfWCo9.pdf','2025-11-21 12:17:00','2025-11-21 12:17:00'),(88,49,'bajo_protesta_art_170','documentos/49/uM7eIITK91wYyykuSgcREp90lSkJAN4QAsDaDrkk.pdf','2025-11-21 12:17:00','2025-11-21 12:17:00'),(89,49,'integracion_formula','documentos/49/6QhzvJd0LhRrvd7c7B3HUtPV3QHjFWgDYSBwp1XM.pdf','2025-11-21 12:17:00','2025-11-21 12:17:00');
/*!40000 ALTER TABLE `docus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
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
-- Table structure for table `integrante_bajas`
--

DROP TABLE IF EXISTS `integrante_bajas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `integrante_bajas` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `integrante_id` bigint unsigned DEFAULT NULL,
  `consejo_id` bigint unsigned NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `apellido` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `motivo` enum('inasistencia','sancion','fin_periodo','renuncia') COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_baja` date NOT NULL,
  `evidencia_pdf` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `integrante_bajas_consejo_id_foreign` (`consejo_id`),
  CONSTRAINT `integrante_bajas_consejo_id_foreign` FOREIGN KEY (`consejo_id`) REFERENCES `consejos` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `integrante_bajas`
--

LOCK TABLES `integrante_bajas` WRITE;
/*!40000 ALTER TABLE `integrante_bajas` DISABLE KEYS */;
INSERT INTO `integrante_bajas` VALUES (1,69,1,'Anette','Correa','renuncia','2025-10-26','bajas/h9EsQyR2cNOo2iavdtMzbcPQF1ubVpzZrnffnxi4.pdf','2025-12-25 04:37:06','2025-12-25 04:37:06'),(2,59,2,'Yovani','Gonzalez Flores','fin_periodo','2025-12-26','bajas/rgKr9i8HT0QHo3wRn2BcMf9eZ56RP2koGlANHrl6.pdf','2025-12-26 02:13:19','2025-12-26 02:13:19'),(3,71,4,'Guillermo Solis','Cruz','renuncia','2025-12-31','bajas/b3xDENngc9OwT5WZp2H0ZjDI7Esy6G21FqbQcJoL.pdf','2025-12-31 12:06:58','2025-12-31 12:06:58'),(4,72,2,'p','sjunjds','inasistencia','2025-01-08','bajas/xYMrCYTF9fTI2NXKKT7VpI5HIx8hWk4Uslq90bJP.pdf','2026-01-09 11:23:21','2026-01-09 11:23:21'),(5,74,1,'Nadia','Hernándes','renuncia','2026-01-23','bajas/ha9EsR8wVREgVNEZil3LOhN6HinDWYn70xStGDFX.pdf','2026-01-23 23:28:06','2026-01-23 23:28:06'),(6,73,1,'Maura','Solis Rivera','renuncia','2025-12-12','bajas/uLcHzCF89ilHMWKD9ddznf45u13BBGrhb6R9318f.pdf','2026-01-27 03:15:19','2026-01-27 03:15:19'),(7,76,4,'Jose Miguel','Ku','inasistencia','2026-03-02','bajas/D3LNotTbLZFGAHcT5eVa4hJBayoWv8XSkK4GcLso.pdf','2026-02-01 15:57:04','2026-02-01 15:57:04');
/*!40000 ALTER TABLE `integrante_bajas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `integrante_consejo`
--

DROP TABLE IF EXISTS `integrante_consejo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `integrante_consejo` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `integrante_id` bigint unsigned NOT NULL,
  `consejo_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `integrante_consejo_consejo_id_foreign` (`consejo_id`),
  KEY `integrante_consejo_integrante_id_foreign` (`integrante_id`),
  CONSTRAINT `integrante_consejo_consejo_id_foreign` FOREIGN KEY (`consejo_id`) REFERENCES `consejos` (`id`) ON DELETE CASCADE,
  CONSTRAINT `integrante_consejo_integrante_id_foreign` FOREIGN KEY (`integrante_id`) REFERENCES `integrantes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `integrante_consejo`
--

LOCK TABLES `integrante_consejo` WRITE;
/*!40000 ALTER TABLE `integrante_consejo` DISABLE KEYS */;
/*!40000 ALTER TABLE `integrante_consejo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `integrantes`
--

DROP TABLE IF EXISTS `integrantes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `integrantes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `apellido` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `genero` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `colonia` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `discapacidad` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `discapacidad_tipo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `puesto` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `correo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `consejo_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `integrantes_correo_unique` (`correo`),
  KEY `integrantes_consejo_id_foreign` (`consejo_id`),
  CONSTRAINT `integrantes_consejo_id_foreign` FOREIGN KEY (`consejo_id`) REFERENCES `consejos` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `integrantes`
--

LOCK TABLES `integrantes` WRITE;
/*!40000 ALTER TABLE `integrantes` DISABLE KEYS */;
INSERT INTO `integrantes` VALUES (46,'Roberto Alan','Gomez Bolaños','Masculino','zocaloooo','no',NULL,'Persona consejera','robert@ttes.com',1,'2025-11-21 12:02:54','2025-12-23 09:41:49'),(47,'Olivia','Benson','Femenino','san fco. totitemhuacan','si','auditiva','Persona auxiliar','olivia@test.com',1,'2025-11-21 12:09:39','2025-11-21 12:09:39'),(49,'Maria de los Angeles','Castro','Otro','Centro','si','Facultades mentales','Persona consjera de tesoreria','mari@test.com',1,'2025-11-21 12:16:00','2025-11-21 12:16:13'),(50,'John Arthur','McAllister','Hombre','san pablo del monte','no',NULL,'Persona consjera propietaria','johnnn@test.com',2,'2025-11-30 10:13:01','2025-11-30 10:13:01'),(51,'Karen','Paige','Mujer','san amnuel','si','auditiva','Persona abogada','karen@test.com',2,'2025-11-30 10:13:41','2025-11-30 10:13:41'),(52,'Alina','Cruz','Prefiero no responder','juan iglesias','no',NULL,'Persona consjera de tesoreria','alina@test.com',2,'2025-11-30 10:14:28','2025-11-30 10:14:28'),(53,'Selene','Ramos','Fluido','la paz','no',NULL,'Persona auxiliar','selene@test.com',2,'2025-11-30 11:33:26','2025-11-30 11:33:26'),(54,'Sebastian','Cisneros Parra','Prefiero no responder','atlixco','no',NULL,'Persona consejera','sebas@test.com',3,'2025-12-07 12:27:22','2025-12-07 12:29:22'),(55,'Catalina','Muñoz Perez','Mujer','zocalo','no',NULL,'Persona consjera de tesoreria','catalina@test.com',3,'2025-12-07 12:29:16','2025-12-07 12:29:16'),(56,'Yoselin','Varela Silva','Prefiero no responder','cholula','si','Facultades mentales','Persona abogada','yos@test.com',3,'2025-12-07 12:30:16','2025-12-07 12:30:16'),(57,'Austin','Cazales Barrera','Homosexual','chiautla','no',NULL,'Persona consjera propietaria','austilin@test.com',3,'2025-12-07 12:31:05','2025-12-07 12:31:05'),(58,'Miguel Angel','Palacios Parra','Prefiero no responder','azcapizalco','no',NULL,'Persona auxiliar','mic@test.com',3,'2025-12-07 13:01:41','2025-12-07 13:01:41'),(70,'Cornelio','Rivas','Prefiero no responder','el cerrito','no',NULL,'Persona auxiliar','cornellio@test.com',1,'2025-12-31 12:05:23','2025-12-31 12:05:23'),(75,'Damian','Caceres','Hombre','san ignacio allende','si','visual','Persona consjera de tesoreria','ddamiann@test.com',4,'2026-02-01 15:53:24','2026-02-01 15:53:24'),(77,'Ximena','Serdan','Mujer','juan c bonilla','no',NULL,'Persona auxiliar','xime@test.com',4,'2026-02-01 15:54:55','2026-02-01 15:54:55');
/*!40000 ALTER TABLE `integrantes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_batches`
--

LOCK TABLES `job_batches` WRITE;
/*!40000 ALTER TABLE `job_batches` DISABLE KEYS */;
/*!40000 ALTER TABLE `job_batches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint unsigned NOT NULL,
  `reserved_at` int unsigned DEFAULT NULL,
  `available_at` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `legalidad`
--

DROP TABLE IF EXISTS `legalidad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `legalidad` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `consejo_id` bigint unsigned NOT NULL,
  `integrante_id` bigint unsigned NOT NULL,
  `inicio_cargo` date NOT NULL,
  `fin_cargo` date NOT NULL,
  `periodo_habil` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `doc_nombramiento` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `doc_carta_reeleccion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `doc_otros` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_inicio_reeleccion` date DEFAULT NULL,
  `estatus_reeleccion` enum('pendiente','aprobado','rechazado') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pendiente',
  `ya_reelegido` tinyint(1) NOT NULL DEFAULT '0',
  `fecha_validacion` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `validado_por` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `legalidad_consejo_id_foreign` (`consejo_id`),
  KEY `legalidad_integrante_id_foreign` (`integrante_id`),
  KEY `legalidad_validado_por_foreign` (`validado_por`),
  CONSTRAINT `legalidad_consejo_id_foreign` FOREIGN KEY (`consejo_id`) REFERENCES `consejos` (`id`) ON DELETE CASCADE,
  CONSTRAINT `legalidad_integrante_id_foreign` FOREIGN KEY (`integrante_id`) REFERENCES `integrantes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `legalidad_validado_por_foreign` FOREIGN KEY (`validado_por`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `legalidad`
--

LOCK TABLES `legalidad` WRITE;
/*!40000 ALTER TABLE `legalidad` DISABLE KEYS */;
INSERT INTO `legalidad` VALUES (1,1,46,'2025-12-12','2028-12-12','1096 días',NULL,NULL,NULL,NULL,'pendiente',0,NULL,'2025-12-13 02:59:37','2025-12-13 02:59:37',NULL),(2,1,47,'2024-07-15','2028-07-15','1461 días',NULL,NULL,NULL,NULL,'pendiente',0,NULL,'2025-12-13 03:06:01','2025-12-13 03:08:17',NULL),(4,2,51,'2025-12-15','2025-12-20','5 días',NULL,NULL,NULL,NULL,'pendiente',0,NULL,'2025-12-15 12:14:06','2025-12-15 12:15:57',NULL),(5,2,52,'2025-12-18','2026-01-19','00:01:01',NULL,NULL,NULL,NULL,'pendiente',0,NULL,'2025-12-23 03:09:49','2025-12-23 03:09:49',NULL),(6,2,50,'2025-12-22','2026-02-14','00:01:23',NULL,NULL,NULL,NULL,'pendiente',0,NULL,'2025-12-23 03:47:17','2025-12-23 03:47:17',NULL),(7,1,49,'2025-07-15','2025-07-16','00:00:01',NULL,NULL,NULL,NULL,'pendiente',0,NULL,'2025-12-24 00:39:19','2025-12-24 00:39:19',NULL),(9,1,46,'2025-12-23','2028-12-23','03:00:00',NULL,NULL,NULL,NULL,'pendiente',0,NULL,'2025-12-24 04:47:01','2025-12-24 04:47:01',NULL),(10,1,49,'2025-12-23','2026-01-23','00:01:00',NULL,NULL,NULL,NULL,'pendiente',0,NULL,'2025-12-24 04:48:38','2025-12-24 04:48:38',NULL),(11,2,53,'2026-01-29','2027-01-29','01:00:00',NULL,NULL,NULL,NULL,'pendiente',0,NULL,'2026-01-29 22:34:36','2026-01-29 22:34:36',NULL);
/*!40000 ALTER TABLE `legalidad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (19,'0001_01_01_000000_create_users_table',1),(20,'0001_01_01_000001_create_cache_table',1),(21,'0001_01_01_000002_create_jobs_table',1),(22,'2025_09_16_193202_create_consejos_table',1),(23,'2025_09_16_193206_create_integrantes_table',1),(24,'2025_09_16_195043_create_integrante_consejo_table',1),(25,'2025_10_03_163028_create_convs_table',2),(28,'2025_10_03_163107_create_docus_table',3),(40,'2025_10_20_175547_add_consejo_id_to_asistencias_table',4),(44,'2025_10_08_051907_create_convocatorias_table',5),(45,'2025_10_19_033429_create_asistencias_table',5),(47,'2025_11_20_215314_campos_extra_integrantes_table',6),(49,'2025_11_21_064551_add_evidencia_to_asistencias_table',7),(50,'2025_11_23_073022_remove_mes_from_asistencias_table',7),(51,'2025_12_12_155743_create_legalidads_table',8),(52,'2025_12_16_055154_add_archivo_reeleccion_to_legalidad_table',9),(56,'2025_12_23_031601_create_integrante_bajas_table',10),(57,'2026_01_20_082403_create_permission_tables',11),(58,'2026_01_29_160252_add_validacion_fields_to_legalidad_table',12),(59,'2026_02_01_075446_add_estado_to_asistencias_table',13),(60,'2026_02_04_064452_actualizar_tabla_legalidad_para_reeleccion',14);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `model_has_permissions`
--

DROP TABLE IF EXISTS `model_has_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `model_has_permissions` (
  `permission_id` bigint unsigned NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint unsigned NOT NULL,
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `model_has_roles` (
  `role_id` bigint unsigned NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint unsigned NOT NULL,
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
INSERT INTO `model_has_roles` VALUES (1,'App\\Models\\User',1);
/*!40000 ALTER TABLE `model_has_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_tokens`
--

LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
INSERT INTO `password_reset_tokens` VALUES ('jesusaldominguezr06@gmail.com','$2y$12$QP9QQvNFog2PxxDP.qOmZ.TLMYJAd9Avay/smZ2cL4omyLsSq7UvW','2025-10-03 13:07:19');
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permissions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` VALUES (1,'usuarios.crear','web','2026-01-20 14:44:35','2026-01-20 14:44:35'),(2,'usuarios.editar','web','2026-01-20 14:44:35','2026-01-20 14:44:35'),(3,'convocatorias.crear','web','2026-01-20 14:44:35','2026-01-20 14:44:35'),(4,'documentos.subir','web','2026-01-20 14:44:35','2026-01-20 14:44:35'),(5,'asistencias.ver','web','2026-01-23 22:01:34','2026-01-23 22:01:34'),(6,'asistencias.crear','web','2026-01-23 22:01:34','2026-01-23 22:01:34'),(7,'consejos.ver','web','2026-01-23 22:01:34','2026-01-23 22:01:34'),(8,'legalidad.ver','web','2026-01-23 22:01:34','2026-01-23 22:01:34'),(9,'reportes.ver','web','2026-01-23 22:01:34','2026-01-23 22:01:34'),(10,'legalidad.solicitar_reeleccion','web','2026-01-29 22:12:11','2026-01-29 22:12:11'),(11,'legalidad.validar_reeleccion','web','2026-01-29 22:12:11','2026-01-29 22:12:11'),(12,'legalidad.rechazar_reeleccion','web','2026-01-29 22:12:11','2026-01-29 22:12:11');
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_has_permissions`
--

DROP TABLE IF EXISTS `role_has_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_has_permissions` (
  `permission_id` bigint unsigned NOT NULL,
  `role_id` bigint unsigned NOT NULL,
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
INSERT INTO `role_has_permissions` VALUES (1,2),(2,2),(3,2),(4,2),(5,2),(6,2),(7,2),(8,2),(9,2),(4,3),(5,3),(7,3),(8,3),(9,3),(8,4),(11,4),(12,4);
/*!40000 ALTER TABLE `role_has_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'super_admin','web','2026-01-20 14:44:59','2026-01-20 14:44:59'),(2,'admin','web','2026-01-20 14:44:59','2026-01-20 14:44:59'),(3,'integrante','web','2026-01-20 14:44:59','2026-01-20 14:44:59'),(4,'super-admin','web','2026-01-29 22:11:59','2026-01-29 22:11:59');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES ('KHu9UGPp9qcsvohim8ORtTJ2TukpNwbtRRmyXosr',1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 OPR/126.0.0.0 (Edition std-1)','YTo1OntzOjY6Il90b2tlbiI7czo0MDoiaHFkd2JYWWNTU1N6SnJPeThGcG5DdFllclV4N3lhWTlFN2ZuSXBneCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHA6Ly9wbGFuZWFjaW9uLnRlc3QvZGFzaGJvYXJkIjt9czozOiJ1cmwiO2E6MDp7fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjE7fQ==',1770193686),('XuopnDcXADn1NTRm8OfxE5VPilphiwElB9ZQm4XZ',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoienVBaEpCTkNreTg3d0FudERBd2pPWFhlREh0bzAzdFVWUll2Q1VxayI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHA6Ly9wbGFuZWFjaW9uLnRlc3QiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19',1770193384);
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Juan Perez','admin@test.com',NULL,'$2y$12$cdNBn/f0nJUClGVgqJ.cHeD8BAkrHeR0x2qOIlY8Ue7ob2tI6fNTe','UeP0IuPCBvVyo4XJpY47GqF6ojIRUwXjAl9BfwzA1088xmybT0QPsRaVWsCS','2025-09-23 04:36:13','2025-09-23 04:36:13'),(2,'Jesus Alejandro','jesusaldominguezr06@gmail.com',NULL,'$2y$12$28SXiIxQm45WtbOA19KeXOwtelrBAtWQXgoim1N/wEqa9XGtjdRLq',NULL,'2025-10-03 13:04:08','2025-10-03 13:04:08'),(3,'Integrantes','integrante@gmail.com',NULL,'$2y$12$ZuAgGkRq5WYBGaK40d9uruq1Y9WPL6AX/PoeZmGCn5Gm4oZKGytrO',NULL,'2026-01-23 01:30:00','2026-01-23 01:30:00');
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

-- Dump completed on 2026-02-04 13:30:09
