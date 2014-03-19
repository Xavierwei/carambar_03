/*
Navicat MySQL Data Transfer

Source Server         : 172.16.111.87
Source Server Version : 50535
Source Host           : localhost:3306
Source Database       : carambar

Target Server Type    : MYSQL
Target Server Version : 50535
File Encoding         : 65001

Date: 2014-03-19 18:19:49
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for answer
-- ----------------------------
DROP TABLE IF EXISTS `answer`;
CREATE TABLE `answer` (
  `aid` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '问答题aid',
  `answer` varchar(255) NOT NULL COMMENT '问题',
  `answer_value` varchar(255) DEFAULT NULL COMMENT '问题答案',
  `answer_count` int(10) unsigned NOT NULL COMMENT '问题答对数',
  PRIMARY KEY (`aid`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of answer
-- ----------------------------
INSERT INTO `answer` VALUES ('1', '11', '11', '11');
INSERT INTO `answer` VALUES ('2', '2', '2', '2');
INSERT INTO `answer` VALUES ('3', '3', '33', '3');
