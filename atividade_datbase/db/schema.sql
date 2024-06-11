CREATE DATABASE `db_restaurante` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

CREATE TABLE `tb_cliente` (
  `id_cliente` int NOT NULL AUTO_INCREMENT,
  `cpf_cliente` varchar(14) NOT NULL,
  `nome_cliente` varchar(150) NOT NULL,
  `email_cliente` varchar(45) DEFAULT NULL,
  `telefone_cliente` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_cliente`)
) ENGINE=InnoDB AUTO_INCREMENT=128 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tb_mesa` (
  `codigo_mesa` int NOT NULL AUTO_INCREMENT,
  `id_cliente` int NOT NULL,
  `num_pessoa_mesa` int NOT NULL DEFAULT '1',
  `data_hora_entrada` datetime DEFAULT NULL,
  `data_hora_saida` datetime DEFAULT NULL,
  PRIMARY KEY (`codigo_mesa`),
  KEY `fk_cliente_idx` (`id_cliente`),
  CONSTRAINT `fk_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `tb_cliente` (`id_cliente`)
) ENGINE=InnoDB AUTO_INCREMENT=16384 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tb_tipo_prato` (
  `codigo_tipo_prato` int NOT NULL AUTO_INCREMENT,
  `nome_tipo_prato` varchar(45) NOT NULL,
  PRIMARY KEY (`codigo_tipo_prato`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `tb_situacao_pedido` (
  `codigo_situacao_pedido` int NOT NULL AUTO_INCREMENT,
  `nome_situacao_pedido` varchar(45) NOT NULL,
  PRIMARY KEY (`codigo_situacao_pedido`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `tb_prato` (
  `codigo_prato` int NOT NULL AUTO_INCREMENT,
  `codigo_tipo_prato` int NOT NULL,
  `nome_prato` varchar(45) NOT NULL,
  `preco_unitario_prato` double NOT NULL,
  PRIMARY KEY (`codigo_prato`),
  KEY `fk_tipo_prato_idx` (`codigo_tipo_prato`),
  CONSTRAINT `fk_tipo_prato` FOREIGN KEY (`codigo_tipo_prato`) REFERENCES `tb_tipo_prato` (`codigo_tipo_prato`)
) ENGINE=InnoDB AUTO_INCREMENT=1024 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tb_pedido` (
  `codigo_mesa` int NOT NULL,
  `codigo_prato` int NOT NULL,
  `quantidade_pedido` varchar(45) NOT NULL,
  `codigo_situacao_pedido` int NOT NULL,
  KEY `fk_situacao_pedido_idx` (`codigo_situacao_pedido`),
  KEY `fk_mesa_idx` (`codigo_mesa`),
  KEY `fk_prato_idx` (`codigo_prato`),
  CONSTRAINT `fk_mesa` FOREIGN KEY (`codigo_mesa`) REFERENCES `tb_mesa` (`codigo_mesa`),
  CONSTRAINT `fk_prato` FOREIGN KEY (`codigo_prato`) REFERENCES `tb_prato` (`codigo_prato`),
  CONSTRAINT `fk_situacao_pedido` FOREIGN KEY (`codigo_situacao_pedido`) REFERENCES `tb_situacao_pedido` (`codigo_situacao_pedido`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;