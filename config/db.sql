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

drop database if exists EducationSystem;
create database EducationSystem;

use EducationSystem;

--
-- Table structure for table `ES_student`
--

DROP TABLE IF EXISTS `ES_student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ES_student` (
  `sno` varchar(20) NOT NULL COMMENT '学号',
  `sname` varchar(64) NOT NULL COMMENT '学生姓名',
  `spasswd` varchar(64) DEFAULT NULL COMMENT '学生密码',
  `sbirth` date DEFAULT NULL COMMENT '出生年月',
  `sage`  INT DEFAULT NULL COMMENT '年龄',
  `ssex`  varchar(2) DEFAULT NULL COMMENT '性别',
  `spolitc` varchar(12) DEFAULT NULL COMMENT '政治面貌',
  `sadmission` date DEFAULT NULL COMMENT '入学时间',
  `sprofile` varchar(200) DEFAULT NULL COMMENT '个人简介',
  `sfamilyaddr` varchar(100) DEFAULT NULL COMMENT '家庭住址',
  `spostcode` varchar(8) DEFAULT NULL COMMENT '邮政编码',
  `grade` INT DEFAULT NULL COMMENT '年级',
  `major` varchar(128) DEFAULT NULL COMMENT '专业',
  PRIMARY KEY (`sno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ES_student`
--

LOCK TABLES `ES_student` WRITE;
/*!40000 ALTER TABLE `ES_student` DISABLE KEYS */;
INSERT INTO `ES_student` values ('201608010301', '张三', '666666', '1996-03-16', 19, '男', '共青团员', '2015-09-01',NULL,NULL,'1101234', 2015, '计算机科学与技术');
INSERT INTO `ES_student` values ('201508010301', '李四', '666666', '1997-01-23', 18, '男', '群众',  '2015-09-01', NULL,NULL,NULL, 2015, '计算机科学与技术');
/*!40000 ALTER TABLE `ES_student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ES_teacher`
--

DROP TABLE IF EXISTS `ES_teacher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ES_teacher` (
  `tno` varchar(20) NOT NULL COMMENT '教师职工号',
  `tname` varchar(64) DEFAULT NULL COMMENT '教师姓名',
  `tpasswd` varchar(64) DEFAULT NULL COMMENT '教师密码',
  PRIMARY KEY (`tno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ES_teacher`
--

LOCK TABLES `ES_teacher` WRITE;
/*!40000 ALTER TABLE `ES_teacher` DISABLE KEYS */;
INSERT INTO `ES_teacher` values ('200003', '杨圣洪', '123456'),('200004', '王永恒', '123456');
/*!40000 ALTER TABLE `ES_teacher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ES_administrator`
--

DROP TABLE IF EXISTS `ES_administrator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ES_administrator` (
  `ano` varchar(20) NOT NULL COMMENT '管理员职工号',
  `aname` varchar(64) DEFAULT NULL COMMENT '管理员姓名',
  `apasswd` varchar(64) DEFAULT NULL COMMENT '管理员密码',
  PRIMARY KEY (`ano`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ES_administrator`
--

LOCK TABLES `ES_administrator` WRITE;
/*!40000 ALTER TABLE `ES_administrator` DISABLE KEYS */;
INSERT INTO `ES_administrator` values ('100000', 'root', 'password'),('100001', 'admin', 'adminpass'),('100002', 'administrator', 'passpass');
/*!40000 ALTER TABLE `ES_administrator` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ES_course`
--

DROP TABLE IF EXISTS `ES_course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ES_course` (
  `cno` varchar(20) NOT NULL COMMENT '课程号',
  `cname` varchar(64) NOT NULL COMMENT '课程名',
  `teacher_tno` varchar(20) NOT NULL COMMENT '授课教师职工号',
  `limit_num` INT DEFAULT NULL COMMENT '限选人数',
  `selected_num` INT DEFAULT NULL COMMENT '已选人数',
  `semester` INT DEFAULT NULL COMMENT '学期',
  PRIMARY KEY (`cno`),
  KEY `fk_teacher_tno`(`teacher_tno`),
  CONSTRAINT `FK_teacher` FOREIGN KEY (`teacher_tno`) REFERENCES `ES_teacher` (`tno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ES_course`
--

LOCK TABLES `ES_course` WRITE;
/*!40000 ALTER TABLE `ES_course` DISABLE KEYS */;
INSERT INTO `ES_course` values ('1', '数据库原理', '200004', 100, 0, 2015);
/*!40000 ALTER TABLE `ES_course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ES_selected`
--

DROP TABLE IF EXISTS `ES_selected`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ES_selected` (
  `student_sno` varchar(20) NOT NULL COMMENT '学号',
  `course_cno` varchar(20) NOT NULL COMMENT '课程号',
  `score` INT DEFAULT NULL COMMENT '成绩',
  PRIMARY KEY (`student_sno`, `course_cno`),
  KEY `fk_student_sno`(student_sno),
  KEY `fk_course_cno`(course_cno),
  CONSTRAINT `FK_student` FOREIGN KEY (`student_sno`) REFERENCES `ES_student` (`sno`),
  CONSTRAINT `FK_course` FOREIGN KEY (`course_cno`) REFERENCES `ES_course` (`cno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ES_selected`
--

LOCK TABLES `ES_selected` WRITE;
/*!40000 ALTER TABLE `ES_selected` DISABLE KEYS */;
INSERT INTO `ES_selected` values ('201508010301', '1', 88);
/*!40000 ALTER TABLE `ES_selected` ENABLE KEYS */;
UNLOCK TABLES;

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-03-06 17:24:36
