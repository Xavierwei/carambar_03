/*
Navicat MySQL Data Transfer

Source Server         : 172.16.111.87
Source Server Version : 50535
Source Host           : localhost:3306
Source Database       : carambar

Target Server Type    : MYSQL
Target Server Version : 50535
File Encoding         : 65001

Date: 2014-03-16 14:21:04
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for challenge
-- ----------------------------
DROP TABLE IF EXISTS `challenge`;
CREATE TABLE `challenge` (
  `cid` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'challenge id',
  `title` varchar(128) NOT NULL,
  `image` varchar(256) NOT NULL,
  `datetime` int(11) unsigned zerofill NOT NULL,
  `vote_counts` int(13) unsigned NOT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of challenge
-- ----------------------------
INSERT INTO `challenge` VALUES ('1', 'test1', 'test1.jpg', '01394950749', '1');
INSERT INTO `challenge` VALUES ('2', 'test2', 'test2.jpg', '01394950760', '15');
INSERT INTO `challenge` VALUES ('3', 'test3', 'test3.jpg', '01394950847', '3');
