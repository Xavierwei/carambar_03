/*
Navicat MySQL Data Transfer

Source Server         : 172.16.111.87
Source Server Version : 50535
Source Host           : localhost:3306
Source Database       : carambar

Target Server Type    : MYSQL
Target Server Version : 50535
File Encoding         : 65001

Date: 2014-03-20 00:43:10
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for video
-- ----------------------------
DROP TABLE IF EXISTS `video`;
CREATE TABLE `video` (
  `vid` int(100) NOT NULL AUTO_INCREMENT,
  `url` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `thumbnail` varchar(255) NOT NULL,
  `datetime` int(11) unsigned NOT NULL COMMENT '创建时间',
  `status` tinyint(1) unsigned NOT NULL,
  `position` tinyint(2) unsigned NOT NULL,
  `mid` varchar(50) NOT NULL COMMENT 'youtube id',
  `rank` int(6) unsigned NOT NULL COMMENT '排名',
  `phase` varchar(30) NOT NULL COMMENT '阶段',
  `ribbon` tinyint(1) unsigned NOT NULL COMMENT 'icon',
  PRIMARY KEY (`vid`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of video
-- ----------------------------
INSERT INTO `video` VALUES ('1', '11', '', '11', '1111111111', '1', '1', '', '1', '1,2,3', '1');
INSERT INTO `video` VALUES ('2', '22', '', '22', '1395246811', '1', '2', '', '3', '2,3,4,5', '2');
INSERT INTO `video` VALUES ('3', '33', '', '33', '3333333333', '1', '3', '', '19', '1,3,4', '3');
INSERT INTO `video` VALUES ('4', '11', '', '11', '1111111111', '1', '1', '', '2', '1,2,3', '4');
INSERT INTO `video` VALUES ('5', '22', '', '22', '2222222222', '1', '2', '', '3', '2,3', '5');
INSERT INTO `video` VALUES ('6', '33', '', '33', '3333333333', '1', '3', '', '6', '1,3', '4');
INSERT INTO `video` VALUES ('7', '11', '', '11', '1111111111', '1', '1', '', '5', '1,2,3', '3');
INSERT INTO `video` VALUES ('8', '22', '', '22', '2222222222', '1', '2', '', '8', '2,3', '2');
INSERT INTO `video` VALUES ('9', '33', '', '33', '3333333333', '1', '3', '', '40', '1,3,4', '4');
INSERT INTO `video` VALUES ('10', '11', '', '11', '1111111111', '1', '1', '', '9', '1,2,3', '1');
INSERT INTO `video` VALUES ('11', '22', '', '22', '2222222222', '1', '2', '', '41', '2,3,4', '2');
INSERT INTO `video` VALUES ('12', '33', '', '33', '3333333333', '1', '3', '', '458', '1,3,4', '2');
