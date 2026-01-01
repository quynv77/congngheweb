
DROP TABLE IF EXISTS `admin`;

CREATE TABLE `admin` (
  `maadmin` varchar(127) NOT NULL,
  `ho_tenlot` varchar(255) NOT NULL,
  `ten` varchar(255) NOT NULL,
  `tendangnhap` varchar(127) NOT NULL,
  `matkhau` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `sdt` varchar(10) NOT NULL,
  `namsinh` int NOT NULL,
  `gioitinh` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


  LOCK TABLES `admin` WRITE;

INSERT INTO `admin` VALUES ('admin123','admin','admin','admin1234','12345678','admin1234@gmail.com','0982146088',2003,1);

UNLOCK TABLES;

DROP TABLE IF EXISTS `all_lophoc`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
SET character_set_client = @saved_cs_client;

DROP TABLE IF EXISTS `baigiang`;

CREATE TABLE `baigiang` (
  `id_l` int(11) NOT NULL AUTO_INCREMENT,
  `id_lophoc` int(11) NOT NULL,
  `tieude` text NOT NULL,
  `noidung` mediumtext NOT NULL,
  PRIMARY KEY (`id_l`),
  KEY `baigiang_ibfk_1` (`id_lophoc`),
  CONSTRAINT `baigiang_ibfk_1` FOREIGN KEY (`id_lophoc`) REFERENCES `lophoc` (`id_c`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4;

LOCK TABLES `baigiang` WRITE;

INSERT INTO `baigiang` VALUES (1,1,'Bài 1','Giới thiệu môn học');

UNLOCK TABLES;

DROP TABLE IF EXISTS `baitap`;

CREATE TABLE `baitap` (
  `id_e` int(11) NOT NULL AUTO_INCREMENT,
  `id_lophoc` int(11) NOT NULL,
  `tieude` text NOT NULL,
  `noidung` mediumtext NOT NULL,
  PRIMARY KEY (`id_e`),
  KEY `baitap_ibfk_1` (`id_lophoc`),
  CONSTRAINT `baitap_ibfk_1` FOREIGN KEY (`id_lophoc`) REFERENCES `lophoc` (`id_c`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

LOCK TABLES `baitap` WRITE;

INSERT INTO `baitap` VALUES (1,1,'Bài tập 1','Làm bài tập 1');

UNLOCK TABLES;

DROP TABLE IF EXISTS `diemso`;

CREATE TABLE `diemso` (
  `id_lophoc` int(11) NOT NULL,
  `masinhvien` varchar(127) NOT NULL,
  `sodiem` int NOT NULL,
  KEY `id_lophoc` (`id_lophoc`),
  KEY `masinhvien` (`masinhvien`),
  CONSTRAINT `diemso_ibfk_1` FOREIGN KEY (`id_lophoc`) REFERENCES `lophoc` (`id_c`),
  CONSTRAINT `diemso_ibfk_2` FOREIGN KEY (`masinhvien`) REFERENCES `sinhvien` (`masinhvien`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


LOCK TABLES `diemso` WRITE;

INSERT INTO `diemso` VALUES (1,'SV-1',8);

UNLOCK TABLES;

DROP TABLE IF EXISTS `giangvien`;

CREATE TABLE `giangvien` (
  `magiangvien` varchar(127) NOT NULL,
  `ho_tenlot` varchar(255) NOT NULL,
  `ten` varchar(255) NOT NULL,
  `tendangnhap` varchar(127) NOT NULL,
  `matkhau` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `sdt` varchar(10) NOT NULL,
  `namsinh` int NOT NULL,
  `gioitinh` tinyint(1) NOT NULL,
  PRIMARY KEY (`magiangvien`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `giangvien` WRITE;

INSERT INTO `giangvien` VALUES ('GV-06','Qúy','Văn','giangvien06','12345678','giangvien06@hust.edu.vn','0982146088',2001,1);

UNLOCK TABLES;

DROP TABLE IF EXISTS `in4admin`;

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;

SET character_set_client = @saved_cs_client;

DROP TABLE IF EXISTS `in4giangvien`;

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
SET character_set_client = @saved_cs_client;

DROP TABLE IF EXISTS `in4sinhvien`;

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;

SET character_set_client = @saved_cs_client;

DROP TABLE IF EXISTS `khoahoc`;

CREATE TABLE `khoahoc` (
  `makhoahoc` varchar(127) NOT NULL,
  `tenkhoahoc` varchar(255) NOT NULL,
  PRIMARY KEY (`makhoahoc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `khoahoc` WRITE;

INSERT INTO `khoahoc` VALUES ('IT1234','Kỹ thuật phần mềm');

UNLOCK TABLES;

DROP TABLE IF EXISTS `kiemtra`;

CREATE TABLE `kiemtra` (
  `id_t` int(11) NOT NULL AUTO_INCREMENT,
  `id_lophoc` int(11) NOT NULL,
  `tieude` text NOT NULL,
  `noidung` mediumtext NOT NULL,
  `thoigian` int NOT NULL,
  PRIMARY KEY (`id_t`),
  KEY `kiemtra_ibfk_1` (`id_lophoc`),
  CONSTRAINT `kiemtra_ibfk_1` FOREIGN KEY (`id_lophoc`) REFERENCES `lophoc` (`id_c`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

LOCK TABLES `kiemtra` WRITE;

INSERT INTO `kiemtra` VALUES (1,1,'Bài kiểm tra Hệ CSDL','Làm bài kiểm tra',60);

UNLOCK TABLES;

DROP TABLE IF EXISTS `login_ad`;

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;

SET character_set_client = @saved_cs_client;

DROP TABLE IF EXISTS `login_gv`;

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;

SET character_set_client = @saved_cs_client;

DROP TABLE IF EXISTS `login_sv`;

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;

SET character_set_client = @saved_cs_client;

DROP TABLE IF EXISTS `lop_rec`;

CREATE TABLE `lop_rec` (
  `id_lophoc` int(11) NOT NULL,
  `masinhvien` varchar(127) NOT NULL,
  PRIMARY KEY (`id_lophoc`,`masinhvien`),
  UNIQUE KEY `id_lophoc` (`id_lophoc`,`masinhvien`),
  KEY `lop_rec_ibfk_2` (`masinhvien`),
  CONSTRAINT `lop_rec_ibfk_1` FOREIGN KEY (`id_lophoc`) REFERENCES `lophoc` (`id_c`),
  CONSTRAINT `lop_rec_ibfk_2` FOREIGN KEY (`masinhvien`) REFERENCES `sinhvien` (`masinhvien`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `lop_rec` WRITE;

INSERT INTO `lop_rec` VALUES (1,'SV-3');

UNLOCK TABLES;

DROP TABLE IF EXISTS `lophoc`;

CREATE TABLE `lophoc` (
  `id_c` int(11) NOT NULL AUTO_INCREMENT,
  `malophoc` varchar(127) NOT NULL,
  `makhoahoc` varchar(127) NOT NULL,
  `magiangvien` varchar(127) NOT NULL,
  PRIMARY KEY (`id_c`),
  UNIQUE KEY `malophoc_1` (`malophoc`,`makhoahoc`,`magiangvien`),
  KEY `lophoc_ibfk_1` (`makhoahoc`),
  KEY `lophoc_ibfk_2` (`magiangvien`),
  CONSTRAINT `lophoc_ibfk_1` FOREIGN KEY (`makhoahoc`) REFERENCES `khoahoc` (`makhoahoc`),
  CONSTRAINT `lophoc_ibfk_2` FOREIGN KEY (`magiangvien`) REFERENCES `giangvien` (`magiangvien`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4;

LOCK TABLES `lophoc` WRITE;

INSERT INTO `lophoc` VALUES (1,'KTPM01','IT1234','GV-06');

UNLOCK TABLES;

DROP TABLE IF EXISTS `sinhvien`;

CREATE TABLE `sinhvien` (
  `masinhvien` varchar(127) NOT NULL,
  `ho_tenlot` varchar(255) NOT NULL,
  `ten` varchar(255) NOT NULL,
  `tendangnhap` varchar(127) NOT NULL,
  `matkhau` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `sdt` varchar(10) NOT NULL,
  `namsinh` int NOT NULL,
  `gioitinh` tinyint(1) NOT NULL,
  PRIMARY KEY (`masinhvien`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `sinhvien` WRITE;

INSERT INTO `sinhvien` VALUES ('SV-1','Sinh ','Viên 5','phuc.le1103','12345678','phuc.le1103@hust.edu.vn','0123456789',2003,1);

UNLOCK TABLES;

DROP TABLE IF EXISTS `xemdiem`;

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;

SET character_set_client = @saved_cs_client;
