-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: salessoft
-- ------------------------------------------------------
-- Server version	8.0.41

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
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `CODIGO` int NOT NULL AUTO_INCREMENT,
  `NOME` varchar(200) NOT NULL,
  `CIDADE` varchar(40) NOT NULL,
  `UF` char(2) NOT NULL,
  PRIMARY KEY (`CODIGO`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES (1,'Guilherme Briggs','Teresópolis','RJ'),(2,'Alexandre Moreno','Rio de Janeiro','RJ'),(3,'Wendel Bezerra','São Paulo','SP'),(4,'Mauro Ramos','São Paulo','SP'),(5,'Ricardo Juarez','Rio de Janeiro','RJ'),(6,'Marco Ribeiro','Rio de Janeiro','RJ'),(7,'Manolo Rey','Rio de Janeiro','RJ'),(8,'Miriam Ficher','Rio de Janeiro','RJ'),(9,'Andréa Murucci','Rio de Janeiro','RJ'),(10,'Fernanda Baronne','São Paulo','SP'),(11,'Luiz Carlos Persy','Rio de Janeiro','RJ'),(12,'Duda Ribeiro','Rio de Janeiro','RJ'),(13,'Tatá Guarnieri','São Paulo','SP'),(14,'Adriana Torres','Rio de Janeiro','RJ'),(15,'Márcio Simões','Rio de Janeiro','RJ'),(16,'Cecília Lemes','São Paulo','SP'),(17,'Orlando Drummond','Rio de Janeiro','RJ'),(18,'Isaac Bardavid','Niteói','RJ'),(19,'Júlio Chaves','Rio de Janeiro','RJ'),(20,'Selma Lopes','Rio de Janeiro','RJ');
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidoitens`
--

DROP TABLE IF EXISTS `pedidoitens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidoitens` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `NUMERO_PEDIDO` int NOT NULL,
  `CODIGO_PRODUTO` int NOT NULL,
  `QUANTIDADE` int NOT NULL,
  `VALOR_UNITARIO` decimal(13,2) NOT NULL,
  `VALOR_TOTAL` decimal(13,2) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_NUMERO_PEDIDO` (`NUMERO_PEDIDO`),
  KEY `IDX_CODIGO_PRODUTO` (`CODIGO_PRODUTO`),
  CONSTRAINT `pedidoitens_ibfk_1` FOREIGN KEY (`NUMERO_PEDIDO`) REFERENCES `pedidos` (`NUMERO_PEDIDO`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `pedidoitens_ibfk_2` FOREIGN KEY (`CODIGO_PRODUTO`) REFERENCES `produtos` (`CODIGO`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidoitens`
--

LOCK TABLES `pedidoitens` WRITE;
/*!40000 ALTER TABLE `pedidoitens` DISABLE KEYS */;
INSERT INTO `pedidoitens` VALUES (2,2,1,2,10.20,20.40),(3,2,11,1,16.50,16.50),(4,2,10,1,5.40,5.40),(5,2,17,10,0.80,8.00),(6,3,14,1,2.80,2.80),(7,3,15,1,18.90,18.90),(8,3,6,2,9.20,18.40),(9,4,4,1,2.50,2.50);
/*!40000 ALTER TABLE `pedidoitens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidos`
--

DROP TABLE IF EXISTS `pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidos` (
  `NUMERO_PEDIDO` int NOT NULL AUTO_INCREMENT,
  `DATA_EMISSAO` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `CODIGO_CLIENTE` int NOT NULL,
  `VALOR_TOTAL` decimal(13,2) NOT NULL,
  PRIMARY KEY (`NUMERO_PEDIDO`),
  KEY `IDX_CODIGO_CLIENTE` (`CODIGO_CLIENTE`),
  KEY `IDX_DATA_EMISSAO` (`DATA_EMISSAO`),
  CONSTRAINT `pedidos_ibfk_1` FOREIGN KEY (`CODIGO_CLIENTE`) REFERENCES `clientes` (`CODIGO`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos`
--

LOCK TABLES `pedidos` WRITE;
/*!40000 ALTER TABLE `pedidos` DISABLE KEYS */;
INSERT INTO `pedidos` VALUES (2,'2025-02-04 13:46:21',1,50.30),(3,'2025-02-04 13:47:14',20,40.10),(4,'2025-02-04 13:48:04',12,2.50);
/*!40000 ALTER TABLE `pedidos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produtos`
--

DROP TABLE IF EXISTS `produtos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produtos` (
  `CODIGO` int NOT NULL AUTO_INCREMENT,
  `DESCRICAO` varchar(300) NOT NULL,
  `PRECO_VENDA` decimal(13,2) NOT NULL,
  PRIMARY KEY (`CODIGO`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produtos`
--

LOCK TABLES `produtos` WRITE;
/*!40000 ALTER TABLE `produtos` DISABLE KEYS */;
INSERT INTO `produtos` VALUES (1,'Coca-Cola',10.20),(2,'Pepsi',9.80),(3,'Guaraná Antarctica',9.50),(4,'Água Mineral',2.50),(5,'Leite',6.80),(6,'Manteiga',9.20),(7,'Arroz Branco',26.90),(8,'Feijão',7.50),(9,'Óleo de Soja',8.90),(10,'Açúcar',5.40),(11,'Café',16.50),(12,'Biscoito Recheado',3.80),(13,'Barra de Chocolate',6.50),(14,'Sabonete',2.80),(15,'Shampoo',18.90),(16,'Creme dental',8.40),(17,'Paçoca',0.80),(18,'Jujuba',1.50),(19,'Doce de Leite',8.00),(20,'Chiclete',0.20);
/*!40000 ALTER TABLE `produtos` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-02-04 13:50:11
