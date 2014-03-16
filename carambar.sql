/*
Navicat MySQL Data Transfer

Source Server         : 172.16.111.87
Source Server Version : 50535
Source Host           : localhost:3306
Source Database       : carambar

Target Server Type    : MYSQL
Target Server Version : 50535
File Encoding         : 65001

Date: 2014-03-16 15:58:55
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
INSERT INTO `challenge` VALUES ('2', 'test2', 'test2.jpg', '01394950760', '16');
INSERT INTO `challenge` VALUES ('3', 'test3', 'test3.jpg', '01394950847', '3');

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL,
  `content` text,
  `datetime` int(11) DEFAULT NULL,
  `nid` int(11) DEFAULT '0',
  `status` int(2) NOT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=112 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES ('2', '12', 'I am at #Starbar and work for #Shanghai Company', null, '1', '1');
INSERT INTO `comment` VALUES ('3', '12', 'I am at #Starbar and work for #Shanghai Company', null, '1', '1');
INSERT INTO `comment` VALUES ('4', '12', 'I am at #Starbar and work for #Shanghai Company', '1388271018', '1', '1');
INSERT INTO `comment` VALUES ('5', '12', 'I am at #Starbar and work for #Shanghai Company', '1388271027', '1', '1');
INSERT INTO `comment` VALUES ('6', '12', 'test', '1389423952', '21', '1');
INSERT INTO `comment` VALUES ('7', '12', 'fsdf', '1389425642', '21', '1');
INSERT INTO `comment` VALUES ('8', '12', 'fsdf', '1389425696', '21', '1');
INSERT INTO `comment` VALUES ('9', '12', 'OK!', '1389425860', '21', '1');
INSERT INTO `comment` VALUES ('10', '12', 'fds', '1389425941', '21', '1');
INSERT INTO `comment` VALUES ('11', '12', 'fsdf', '1389426073', '21', '1');
INSERT INTO `comment` VALUES ('12', '12', 'fsdf', '1389426074', '21', '1');
INSERT INTO `comment` VALUES ('13', '12', 'fsdf', '1389426108', '21', '1');
INSERT INTO `comment` VALUES ('14', '12', 'fsdf', '1389426108', '21', '1');
INSERT INTO `comment` VALUES ('15', '12', 'fsd', '1389426150', '21', '1');
INSERT INTO `comment` VALUES ('16', '12', 'ccc', '1389450693', '25', '1');
INSERT INTO `comment` VALUES ('17', '12', 'fjkdsjfkd', '1391144305', '193', '1');
INSERT INTO `comment` VALUES ('18', '12', 'fdsfdfdf', '1391144311', '204', '1');
INSERT INTO `comment` VALUES ('19', '12', 'fdeeeff', '1391144319', '204', '1');
INSERT INTO `comment` VALUES ('20', '12', 'fsdfdsf', '1391144656', '204', '1');
INSERT INTO `comment` VALUES ('21', '12', 'fsdfdsf', '1391144662', '204', '1');
INSERT INTO `comment` VALUES ('22', '12', 'ffffff\n', '1391147822', '204', '1');
INSERT INTO `comment` VALUES ('23', '12', '33333', '1391148177', '204', '1');
INSERT INTO `comment` VALUES ('24', '12', '3323', '1391148186', '204', '1');
INSERT INTO `comment` VALUES ('25', '12', 'fdsfdsf', '1391148226', '204', '1');
INSERT INTO `comment` VALUES ('26', '12', 'dsfdfdsf', '1391148239', '204', '1');
INSERT INTO `comment` VALUES ('27', '12', 'fsdfdf', '1391148267', '204', '1');
INSERT INTO `comment` VALUES ('28', '37', 'fsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdf', '1391170897', '204', '1');
INSERT INTO `comment` VALUES ('29', '12', 'fdsf', '1391171028', '203', '1');
INSERT INTO `comment` VALUES ('30', '12', 'sdfdsfdsfd', '1391171035', '203', '1');
INSERT INTO `comment` VALUES ('31', '12', 'sdfdsfdsfdfsd', '1391171039', '203', '1');
INSERT INTO `comment` VALUES ('32', '12', 'sdfdsfdsfdfsd', '1391171043', '203', '1');
INSERT INTO `comment` VALUES ('33', '12', 'ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff', '1391171235', '203', '1');
INSERT INTO `comment` VALUES ('34', '12', 'ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdffafdsfdsf', '1391171243', '203', '1');
INSERT INTO `comment` VALUES ('35', '12', 'fdsf', '1391171611', '201', '1');
INSERT INTO `comment` VALUES ('36', '12', 'fdsf', '1391171615', '201', '1');
INSERT INTO `comment` VALUES ('37', '12', 'fdsf', '1391171618', '201', '1');
INSERT INTO `comment` VALUES ('38', '12', 'fdsf', '1391171621', '201', '1');
INSERT INTO `comment` VALUES ('46', '12', 'ok!', '1391305381', '214', '1');
INSERT INTO `comment` VALUES ('49', '12', 'dsfdsfdsf', '1391305444', '214', '1');
INSERT INTO `comment` VALUES ('50', '12', 'fsdfdsf', '1391357309', '204', '1');
INSERT INTO `comment` VALUES ('51', '12', 'fsdfdsf', '1391357309', '204', '1');
INSERT INTO `comment` VALUES ('52', '12', 'dsfsdfdf', '1391357403', '217', '1');
INSERT INTO `comment` VALUES ('53', '3', 'fsdf', '1391783936', '238', '1');
INSERT INTO `comment` VALUES ('75', '4', 'f323', '1392465667', '444', '1');
INSERT INTO `comment` VALUES ('76', '4', '133332', '1392465671', '444', '1');
INSERT INTO `comment` VALUES ('81', '4', 'fdsfdsf', '1392467259', '443', '1');
INSERT INTO `comment` VALUES ('82', '4', 'hdfdksjkf', '1392470445', '444', '1');
INSERT INTO `comment` VALUES ('83', '4', 'fdsfd', '1392470450', '444', '1');
INSERT INTO `comment` VALUES ('84', '4', 'fdsfdf', '1392470472', '444', '1');
INSERT INTO `comment` VALUES ('85', '4', 'dfsdffdf', '1392470500', '444', '1');
INSERT INTO `comment` VALUES ('86', '4', 'fdsfsf', '1392470504', '444', '1');
INSERT INTO `comment` VALUES ('87', '4', 'fsdfdf', '1392470507', '444', '1');
INSERT INTO `comment` VALUES ('88', '4', 'fdsfdf', '1392470511', '444', '1');
INSERT INTO `comment` VALUES ('89', '4', 'fdsfdf', '1392470538', '444', '1');
INSERT INTO `comment` VALUES ('90', '4', 'fffff', '1392470566', '444', '1');
INSERT INTO `comment` VALUES ('91', '4', '133223', '1392470571', '444', '1');
INSERT INTO `comment` VALUES ('92', '4', 'fffff', '1392470930', '444', '1');
INSERT INTO `comment` VALUES ('93', '4', 'fdfd', '1392473059', '444', '1');
INSERT INTO `comment` VALUES ('96', '4', 'fdsf', '1392478242', '444', '1');
INSERT INTO `comment` VALUES ('97', '4', 'fdsfdf', '1392552730', '450', '1');
INSERT INTO `comment` VALUES ('99', '4', 'fdsfdfdfffdsfdfdfffdsfdfdfffdsfdfdfffdsfdfdff', '1392552740', '450', '1');
INSERT INTO `comment` VALUES ('100', '4', 'fdsfdfdff', '1392552743', '450', '1');
INSERT INTO `comment` VALUES ('101', '4', 'fdsfdfdff', '1392552747', '450', '1');
INSERT INTO `comment` VALUES ('102', '4', 'fdfdsfdsf', '1392814646', '214', '1');
INSERT INTO `comment` VALUES ('103', '4', 'fdfdsf', '1392814650', '214', '1');
INSERT INTO `comment` VALUES ('104', '4', '32332', '1392814654', '214', '1');
INSERT INTO `comment` VALUES ('105', '4', 'fdsfdfdsf', '1392814658', '214', '1');
INSERT INTO `comment` VALUES ('106', '4', '122', '1392814662', '214', '1');
INSERT INTO `comment` VALUES ('107', '4', 'fdsfdsf', '1392814666', '214', '1');
INSERT INTO `comment` VALUES ('108', '4', '323333', '1392814670', '214', '1');
INSERT INTO `comment` VALUES ('109', '4', 'fdsfdf', '1392814674', '214', '1');
INSERT INTO `comment` VALUES ('111', '4', 'fdsf', '1393061431', '322', '1');

-- ----------------------------
-- Table structure for country
-- ----------------------------
DROP TABLE IF EXISTS `country`;
CREATE TABLE `country` (
  `country_id` int(11) NOT NULL AUTO_INCREMENT,
  `country_name` varchar(45) DEFAULT NULL,
  `code` varchar(45) DEFAULT NULL,
  `i18n` varchar(45) DEFAULT NULL,
  `flag_icon` varchar(100) NOT NULL,
  PRIMARY KEY (`country_id`)
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of country
-- ----------------------------
INSERT INTO `country` VALUES ('1', 'South Africa', 'south africa', 'SOUTH_AFRICA', 'SOUTH_AFRICA');
INSERT INTO `country` VALUES ('2', 'Albania', 'albania', 'ALBANIA', 'ALBANIA');
INSERT INTO `country` VALUES ('3', 'Algeria', 'algeria', 'ALGERIA', 'ALGERIA');
INSERT INTO `country` VALUES ('4', 'Germany', 'germany', 'GERMANY', 'GERMANY');
INSERT INTO `country` VALUES ('5', 'Saudi', 'saudi', 'SAUDI', 'SAUDI');
INSERT INTO `country` VALUES ('6', 'Arabia', 'arabia', 'ARABIA', 'ARABIA');
INSERT INTO `country` VALUES ('7', 'Argentina', 'argentina', 'ARGENTINA', 'ARGENTINA');
INSERT INTO `country` VALUES ('8', 'Australia', 'australia', 'AUSTRALIA', 'AUSTRALIA');
INSERT INTO `country` VALUES ('9', 'Austria', 'austria', 'AUSTRIA', 'AUSTRIA');
INSERT INTO `country` VALUES ('10', 'Bahamas', 'bahamas', 'BAHAMAS', 'BAHAMAS');
INSERT INTO `country` VALUES ('11', 'Belgium', 'belgium', 'BELGIUM', 'BELGIUM');
INSERT INTO `country` VALUES ('12', 'Benin', 'benin', 'BENIN', 'BENIN');
INSERT INTO `country` VALUES ('13', 'Brazil', 'brazil', 'BRAZIL', 'BRAZIL');
INSERT INTO `country` VALUES ('14', 'Bulgaria', 'bulgaria', 'BULGARIA', 'BULGARIA');
INSERT INTO `country` VALUES ('15', 'Burkina Faso', 'burkina faso', 'BURKINA_FASO', 'BURKINA_FASO');
INSERT INTO `country` VALUES ('16', 'Canada', 'canada', 'CANADA', 'CANADA');
INSERT INTO `country` VALUES ('17', 'Chile', 'chile', 'CHILE', 'CHILE');
INSERT INTO `country` VALUES ('18', 'China', 'china', 'CHINA', 'CHINA');
INSERT INTO `country` VALUES ('19', 'Cyprus', 'cyprus', 'CYPRUS', 'CYPRUS');
INSERT INTO `country` VALUES ('20', 'Korea', 'korea', 'KOREA', 'KOREA');
INSERT INTO `country` VALUES ('21', 'Republic of Ivory Coast', 'republic of ivory coast', 'REPUBLIC_OF_IVORY_COAST', 'REPUBLIC_OF_IVORY_COAST');
INSERT INTO `country` VALUES ('22', 'Croatia', 'croatia', 'CROATIA', 'CROATIA');
INSERT INTO `country` VALUES ('23', 'Denmark', 'denmark', 'DENMARK', 'DENMARK');
INSERT INTO `country` VALUES ('24', 'Egypt', 'egypt', 'EGYPT', 'EGYPT');
INSERT INTO `country` VALUES ('25', 'United Arab Emirates', 'united arab emirates', 'UNITED_ARAB_EMIRATES', 'UNITED_ARAB_EMIRATES');
INSERT INTO `country` VALUES ('26', 'Spain', 'spain', 'SPAIN', 'SPAIN');
INSERT INTO `country` VALUES ('27', 'Estonia', 'estonia', 'ESTONIA', 'ESTONIA');
INSERT INTO `country` VALUES ('28', 'USA', 'usa', 'USA', 'USA');
INSERT INTO `country` VALUES ('29', 'Finland', 'finland', 'FINLAND', 'FINLAND');
INSERT INTO `country` VALUES ('30', 'France', 'france', 'FRANCE', 'FRANCE');
INSERT INTO `country` VALUES ('31', 'Georgia', 'georgia', 'GEORGIA', 'GEORGIA');
INSERT INTO `country` VALUES ('32', 'Ghana', 'ghana', 'GHANA', 'GHANA');
INSERT INTO `country` VALUES ('33', 'Greece', 'greece', 'GREECE', 'GREECE');
INSERT INTO `country` VALUES ('34', 'Guinea', 'guinea', 'GUINEA', 'GUINEA');
INSERT INTO `country` VALUES ('35', 'Equatorial Guinea', 'equatorial guinea', 'EQUATORIAL_GUINEA', 'EQUATORIAL_GUINEA');
INSERT INTO `country` VALUES ('36', 'Hungary', 'hungary', 'HUNGARY', 'HUNGARY');
INSERT INTO `country` VALUES ('37', 'India', 'india', 'INDIA', 'INDIA');
INSERT INTO `country` VALUES ('38', 'Ireland', 'ireland', 'IRELAND', 'IRELAND');
INSERT INTO `country` VALUES ('39', 'Italy', 'italy', 'ITALY', 'ITALY');
INSERT INTO `country` VALUES ('40', 'Japan', 'japan', 'JAPAN', 'JAPAN');
INSERT INTO `country` VALUES ('41', 'Jordan', 'jordan', 'JORDAN', 'JORDAN');
INSERT INTO `country` VALUES ('42', 'Latvia', 'latvia', 'LATVIA', 'LATVIA');
INSERT INTO `country` VALUES ('43', 'Lebanon', 'lebanon', 'LEBANON', 'LEBANON');
INSERT INTO `country` VALUES ('44', 'Lithuania', 'lithuania', 'LITHUANIA', 'LITHUANIA');
INSERT INTO `country` VALUES ('45', 'Luxembourg', 'luxembourg', 'LUXEMBOURG', 'LUXEMBOURG');
INSERT INTO `country` VALUES ('46', 'Macedonia', 'macedonia', 'MACEDONIA', 'MACEDONIA');
INSERT INTO `country` VALUES ('47', 'Madagascar', 'madagascar', 'MADAGASCAR', 'MADAGASCAR');
INSERT INTO `country` VALUES ('48', 'Morocco', 'morocco', 'MOROCCO', 'MOROCCO');
INSERT INTO `country` VALUES ('49', 'Mauritania', 'mauritania', 'MAURITANIA', 'MAURITANIA');
INSERT INTO `country` VALUES ('50', 'Mexico', 'mexico', 'MEXICO', 'MEXICO');
INSERT INTO `country` VALUES ('51', 'Moldova', 'moldova', 'MOLDOVA', 'MOLDOVA');
INSERT INTO `country` VALUES ('52', 'Republic of Montenegro', 'republic of montenegro', 'REPUBLIC_OF_MONTENEGRO', 'REPUBLIC_OF_MONTENEGRO');
INSERT INTO `country` VALUES ('53', 'Norway', 'norway', 'NORWAY', 'NORWAY');
INSERT INTO `country` VALUES ('54', 'New Caledonia', 'new caledonia', 'NEW_CALEDONIA', 'NEW_CALEDONIA');
INSERT INTO `country` VALUES ('55', 'Panama', 'panama', 'PANAMA', 'PANAMA');
INSERT INTO `country` VALUES ('56', 'Netherlands', 'netherlands', 'NETHERLANDS', 'NETHERLANDS');
INSERT INTO `country` VALUES ('57', 'Peru', 'peru', 'PERU', 'PERU');
INSERT INTO `country` VALUES ('58', 'Poland', 'poland', 'POLAND', 'POLAND');
INSERT INTO `country` VALUES ('59', 'Portugal', 'portugal', 'PORTUGAL', 'PORTUGAL');
INSERT INTO `country` VALUES ('60', 'Reunion', 'reunion', 'REUNION', 'REUNION');
INSERT INTO `country` VALUES ('61', 'Romania', 'romania', 'ROMANIA', 'ROMANIA');
INSERT INTO `country` VALUES ('62', 'UK', 'uk', 'UK', 'UK');
INSERT INTO `country` VALUES ('63', 'Russian Federation', 'russian federation', 'RUSSIAN_FEDERATION', 'RUSSIAN_FEDERATION');
INSERT INTO `country` VALUES ('64', 'Senegal', 'senegal', 'SENEGAL', 'SENEGAL');
INSERT INTO `country` VALUES ('65', 'Serbia', 'serbia', 'SERBIA', 'SERBIA');
INSERT INTO `country` VALUES ('66', 'Singapore', 'singapore', 'SINGAPORE', 'SINGAPORE');
INSERT INTO `country` VALUES ('67', 'Slovakia', 'slovakia', 'SLOVAKIA', 'SLOVAKIA');
INSERT INTO `country` VALUES ('68', 'Slovenia', 'slovenia', 'SLOVENIA', 'SLOVENIA');
INSERT INTO `country` VALUES ('69', 'Sweden', 'sweden', 'SWEDEN', 'SWEDEN');
INSERT INTO `country` VALUES ('70', 'Switzerland', 'switzerland', 'SWITZERLAND', 'SWITZERLAND');
INSERT INTO `country` VALUES ('71', 'Chad', 'chad', 'CHAD', 'CHAD');
INSERT INTO `country` VALUES ('72', 'Czech Republic', 'czech republic', 'CZECH_REPUBLIC', 'CZECH_REPUBLIC');
INSERT INTO `country` VALUES ('73', 'Tunisia', 'tunisia', 'TUNISIA', 'TUNISIA');
INSERT INTO `country` VALUES ('74', 'Turkey', 'turkey', 'TURKEY', 'TURKEY');
INSERT INTO `country` VALUES ('75', 'Ukraine', 'ukraine', 'UKRAINE', 'UKRAINE');
INSERT INTO `country` VALUES ('76', 'Uruguay', 'uruguay', 'URUGUAY', 'URUGUAY');
INSERT INTO `country` VALUES ('77', 'Vietnam', 'vietnam', 'VIETNAM', 'VIETNAM');

-- ----------------------------
-- Table structure for flag
-- ----------------------------
DROP TABLE IF EXISTS `flag`;
CREATE TABLE `flag` (
  `flag_id` int(15) NOT NULL AUTO_INCREMENT,
  `nid` int(11) DEFAULT '0',
  `uid` int(15) DEFAULT NULL,
  `datetime` int(11) DEFAULT NULL,
  `cid` int(11) DEFAULT '0',
  `comment_nid` int(11) DEFAULT '0',
  PRIMARY KEY (`flag_id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of flag
-- ----------------------------
INSERT INTO `flag` VALUES ('18', '204', '12', '1391165802', '0', null);
INSERT INTO `flag` VALUES ('19', '214', '12', '1391266459', '0', null);
INSERT INTO `flag` VALUES ('20', '0', '12', '1391269647', '39', null);
INSERT INTO `flag` VALUES ('23', '0', '12', '1391270545', '18', '204');
INSERT INTO `flag` VALUES ('24', '0', '12', '1391270906', '19', '204');
INSERT INTO `flag` VALUES ('25', '0', '12', '1391272003', '21', '204');
INSERT INTO `flag` VALUES ('29', '0', '2', '1393079772', '18', '204');
INSERT INTO `flag` VALUES ('30', '0', '2', '1393079800', '110', '322');
INSERT INTO `flag` VALUES ('31', '0', '2', '1393080202', '114', '322');
INSERT INTO `flag` VALUES ('32', '306', '2', '1393080214', '0', '0');
INSERT INTO `flag` VALUES ('33', '0', '2', '1393081118', '110', '322');
INSERT INTO `flag` VALUES ('34', '306', '2', '1393081176', '0', '0');
INSERT INTO `flag` VALUES ('35', '0', '2', '1393081197', '114', '322');
INSERT INTO `flag` VALUES ('37', '0', '4', '1393081908', '110', '322');
INSERT INTO `flag` VALUES ('38', '0', '4', '1393082225', '111', '322');
INSERT INTO `flag` VALUES ('41', '0', '4', '1393082320', '114', '322');
INSERT INTO `flag` VALUES ('42', '322', '4', '1393429113', '0', '0');

-- ----------------------------
-- Table structure for like
-- ----------------------------
DROP TABLE IF EXISTS `like`;
CREATE TABLE `like` (
  `like_id` int(15) NOT NULL AUTO_INCREMENT,
  `nid` int(15) DEFAULT NULL,
  `uid` int(15) DEFAULT NULL,
  `datetime` int(15) DEFAULT NULL,
  PRIMARY KEY (`like_id`)
) ENGINE=InnoDB AUTO_INCREMENT=218 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of like
-- ----------------------------
INSERT INTO `like` VALUES ('17', '185', '12', '1389499316');
INSERT INTO `like` VALUES ('18', '122', '12', '1389499469');
INSERT INTO `like` VALUES ('42', '206', '12', '1391303401');
INSERT INTO `like` VALUES ('88', '212', '12', '1391347310');
INSERT INTO `like` VALUES ('89', '203', '12', '1391347392');
INSERT INTO `like` VALUES ('90', '194', '12', '1391347429');
INSERT INTO `like` VALUES ('91', '192', '12', '1391347447');
INSERT INTO `like` VALUES ('94', '191', '12', '1391347579');
INSERT INTO `like` VALUES ('95', '190', '12', '1391347610');
INSERT INTO `like` VALUES ('97', '197', '12', '1391347915');
INSERT INTO `like` VALUES ('98', '189', '12', '1391347935');
INSERT INTO `like` VALUES ('99', '186', '12', '1391347965');
INSERT INTO `like` VALUES ('100', '183', '12', '1391348024');
INSERT INTO `like` VALUES ('101', '184', '12', '1391348120');
INSERT INTO `like` VALUES ('102', '182', '12', '1391348218');
INSERT INTO `like` VALUES ('103', '181', '12', '1391348252');
INSERT INTO `like` VALUES ('104', '177', '12', '1391348337');
INSERT INTO `like` VALUES ('105', '187', '12', '1391348385');
INSERT INTO `like` VALUES ('106', '178', '12', '1391348590');
INSERT INTO `like` VALUES ('107', '176', '12', '1391348621');
INSERT INTO `like` VALUES ('108', '193', '12', '1391348647');
INSERT INTO `like` VALUES ('117', '204', '12', '1391349070');
INSERT INTO `like` VALUES ('118', '170', '12', '1391349246');
INSERT INTO `like` VALUES ('119', '171', '12', '1391349346');
INSERT INTO `like` VALUES ('120', '163', '12', '1391349373');
INSERT INTO `like` VALUES ('123', '211', '12', '1391350129');
INSERT INTO `like` VALUES ('124', '214', '12', '1391350192');
INSERT INTO `like` VALUES ('149', '443', '4', '1392467256');
INSERT INTO `like` VALUES ('154', '442', '4', '1392471562');
INSERT INTO `like` VALUES ('155', '441', '4', '1392471601');
INSERT INTO `like` VALUES ('160', '440', '4', '1392471981');
INSERT INTO `like` VALUES ('162', '438', '4', '1392472053');
INSERT INTO `like` VALUES ('166', '429', '4', '1392472227');
INSERT INTO `like` VALUES ('207', '447', '4', '1392562597');
INSERT INTO `like` VALUES ('208', '321', '4', '1392730838');
INSERT INTO `like` VALUES ('209', '320', '4', '1393160460');
INSERT INTO `like` VALUES ('210', '318', '4', '1393160468');
INSERT INTO `like` VALUES ('211', '308', '4', '1393160572');
INSERT INTO `like` VALUES ('212', '323', '4', '1393160890');
INSERT INTO `like` VALUES ('213', '278', '4', '1393160914');
INSERT INTO `like` VALUES ('214', '277', '4', '1393160933');
INSERT INTO `like` VALUES ('215', '311', '4', '1393166381');
INSERT INTO `like` VALUES ('217', '322', '4', '1393429201');

-- ----------------------------
-- Table structure for node
-- ----------------------------
DROP TABLE IF EXISTS `node`;
CREATE TABLE `node` (
  `nid` int(15) NOT NULL AUTO_INCREMENT,
  `mid` varchar(255) NOT NULL,
  `uid` int(15) DEFAULT NULL,
  `screen_name` varchar(255) NOT NULL,
  `location` varchar(255) NOT NULL,
  `country_id` int(15) DEFAULT NULL,
  `type` varchar(45) DEFAULT NULL,
  `file` varchar(255) DEFAULT NULL,
  `url` varchar(255) NOT NULL,
  `media` varchar(100) NOT NULL,
  `from` varchar(100) NOT NULL,
  `datetime` int(11) DEFAULT NULL,
  `hashtag` varchar(200) DEFAULT NULL,
  `description` text,
  `status` int(11) DEFAULT '0',
  `reward` int(2) NOT NULL,
  PRIMARY KEY (`nid`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of node
-- ----------------------------
INSERT INTO `node` VALUES ('1', '671693692806788719_17196948', null, 'marinemr', 'Paris, France', null, 'photo', '/uploads/2014/3/8/1.jpg', '', 'instagram', '', '1394292149', null, 'Sunny Saturday at the agency #9263', '1', '0');
INSERT INTO `node` VALUES ('2', '671614972297152779_465161729', null, 'remygendre', '', null, 'photo', '/uploads/2014/3/8/2.jpg', '', 'instagram', '', '1394282765', null, 'Enfin, j\'ai trouvé un petit souvenir a ramener de bisca #bisca #9263', '1', '0');
INSERT INTO `node` VALUES ('3', '671556714860556435_149779', null, 'jalila', 'Tremblay-en-France, France', null, 'photo', '/uploads/2014/3/8/3.jpg', '', 'instagram', '', '1394275820', null, 'Boarding #9263', '1', '0');
INSERT INTO `node` VALUES ('4', '671143084366191841_8641750', null, 'jimtran01', 'Paris, France', null, 'photo', '/uploads/2014/3/8/4.jpg', '', 'instagram', '', '1394226511', null, '#selfie w/ @halary #9263', '1', '0');
INSERT INTO `node` VALUES ('5', '671065779919521486_47150384', null, 'lilianer', 'Paris, France', null, 'photo', '/uploads/2014/3/8/5.jpg', '', 'instagram', '', '1394217296', null, '#9263', '1', '0');
INSERT INTO `node` VALUES ('6', '671011207939496592_8350645', null, '00liu', 'Shanghai, China', null, 'photo', '/uploads/2014/3/8/6.jpg', '', 'instagram', '', '1394210791', null, '@bautumn1101 24小時on call #9263', '1', '0');
INSERT INTO `node` VALUES ('7', '671001563642124371_331681973', null, 'juliadurey', 'Paris, France', null, 'photo', '/uploads/2014/3/8/7.jpg', '', 'instagram', '', '1394209641', null, '❤️ #9263', '1', '0');
INSERT INTO `node` VALUES ('8', '670971881946524475_10283241', null, 'alexandrarony', '', null, 'photo', '/uploads/2014/3/8/8.jpg', '', 'instagram', '', '1394206103', null, '#9263', '1', '0');
INSERT INTO `node` VALUES ('9', '670971208861525272_16493368', null, 'cold_paradise', '', null, 'photo', '/uploads/2014/3/8/9.jpg', '', 'instagram', '', '1394206022', null, 'Dali nails #9263', '1', '0');
INSERT INTO `node` VALUES ('10', '670969436340799733_813773889', null, 'bysardine', 'Paris, France', null, 'photo', '/uploads/2014/3/8/10.jpg', '', 'instagram', '', '1394205811', null, '#9263 #porc #cochon #margaux #love #cute #kawaii', '1', '0');
INSERT INTO `node` VALUES ('11', '670924325297707849_600960629', null, 'whynotlinhvu', 'Shanghai, China', null, 'photo', '/uploads/2014/3/8/11.jpg', '', 'instagram', '', '1394200433', null, '#TGIF #dailyshanghai #9263', '1', '0');
INSERT INTO `node` VALUES ('12', '670876732999802761_225395454', null, 'uzi_gunpowder18', '', null, 'photo', '/uploads/2014/3/8/12.jpg', '', 'instagram', '', '1394194760', null, '#9263', '1', '0');
INSERT INTO `node` VALUES ('13', '670874183619782663_279712249', null, 'xiaotongding', '', null, 'photo', '/uploads/2014/3/8/13.jpg', '', 'instagram', '', '1394194456', null, '#9263# Mr and Mrs Bond', '1', '0');
INSERT INTO `node` VALUES ('14', '670816259462050468_149779', null, 'jalila', 'Paris, France', null, 'photo', '/uploads/2014/3/8/14.jpg', '', 'instagram', '', '1394187551', null, 'Screens + @fredfarid #48Provence #9263', '1', '0');
INSERT INTO `node` VALUES ('15', '670809600731781581_8350645', null, '00liu', 'Shanghai, China', null, 'photo', '/uploads/2014/3/8/15.jpg', '', 'instagram', '', '1394186757', null, '2 teenagers #9263 #milkana #cheese', '1', '0');
INSERT INTO `node` VALUES ('16', '670808704794715000_32130471', null, 'nawal_', 'Paris, France', null, 'photo', '/uploads/2014/3/8/16.jpg', '', 'instagram', '', '1394186650', null, 'En Meeting avec @fredfaridparis et @manuferry chez @FredFaridGroup #FredFaridGroup #9263 #Paris #Shanghai', '1', '0');
INSERT INTO `node` VALUES ('17', '670762978815078572_347189187', null, 'thibaudmuratyan', '', null, 'photo', '/uploads/2014/3/8/17.jpg', '', 'instagram', '', '1394181199', null, 'Henri Cartier-Bresson #CentrePompidou #Beaubourg #exhibition #HenriCartierBresson #9263', '1', '0');
INSERT INTO `node` VALUES ('18', '670471951904380322_6187020', null, 'lorraine_', 'Paris, France', null, 'photo', '/uploads/2014/3/8/18.jpg', '', 'instagram', '', '1394146506', null, '#9263', '1', '0');
INSERT INTO `node` VALUES ('19', '670466235772671250_6187020', null, 'lorraine_', 'Paris, France', null, 'photo', '/uploads/2014/3/8/19.jpg', '', 'instagram', '', '1394145825', null, '#9263', '1', '0');
INSERT INTO `node` VALUES ('20', '670305712140120903_16500443', null, 'ray_against_the_machine', 'Paris, France', null, 'photo', '/uploads/2014/3/8/20.jpg', '', 'instagram', '', '1394126689', null, 'Back. #trip #ricoh #airport #9263', '1', '0');
INSERT INTO `node` VALUES ('21', '670305561225113874_149779', null, 'jalila', 'Paris, France', null, 'photo', '/uploads/2014/3/8/21.jpg', '', 'instagram', '', '1394126671', null, 'La parisienne #9263', '1', '0');
INSERT INTO `node` VALUES ('22', '670216547859741985_2504398', null, 'ladybancale', '', null, 'photo', '/uploads/2014/3/8/22.jpg', '', 'instagram', '', '1394116060', null, 'manque plus qu\'Ellen Degeneres / Jared Leto / Brad Pitt / etc #9263 #FF #hellosunshine', '1', '0');
INSERT INTO `node` VALUES ('23', '670151780866338823_336912187', null, 'joh_ananas', 'Paris 09, France', null, 'photo', '/uploads/2014/3/8/23.jpg', '', 'instagram', '', '1394108339', null, 'Salut gloglo Robert lunch part 2 #9263', '1', '0');
INSERT INTO `node` VALUES ('24', '670125728483445411_465161729', null, 'remygendre', '', null, 'photo', '/uploads/2014/3/8/24.jpg', '', 'instagram', '', '1394105233', null, 'Good morning #9263 #bisca', '1', '0');
INSERT INTO `node` VALUES ('25', '669651107385835315_26847942', null, 'monsieur_robs', 'Paris, France', null, 'photo', '/uploads/2014/3/8/25.jpg', '', 'instagram', '', '1394048654', null, null, '1', '0');
INSERT INTO `node` VALUES ('26', '669577741259855158_271859948', null, 'chacourbon', '', null, 'photo', '/uploads/2014/3/8/26.jpg', '', 'instagram', '', '1394039908', null, 'Welcome @chamontrichard ! #9263', '1', '0');
INSERT INTO `node` VALUES ('27', '669522594412466885_7110867', null, 'joiearfi', 'Paris, France', null, 'photo', '/uploads/2014/3/8/27.jpg', '', 'instagram', '', '1394033334', null, 'Le burger, star des projecteurs #shoot #burger #work #ff #9263', '1', '0');
INSERT INTO `node` VALUES ('28', '669456381302157705_336912187', null, 'joh_ananas', 'Paris, France', null, 'photo', '/uploads/2014/3/8/28.jpg', '', 'instagram', '', '1394025441', null, 'Salut gloglo Robert lunch part 1 #9263', '1', '0');
INSERT INTO `node` VALUES ('29', '669423687792549743_8641750', null, 'jimtran01', 'Paris, France', null, 'photo', '/uploads/2014/3/8/29.jpg', '', 'instagram', '', '1394021543', null, '#FFDIGITAL #lunch #9263 w/@cold_paradise @valentinm @baocontact @duduthenoz @bbzlevy poke @symca', '1', '0');
INSERT INTO `node` VALUES ('30', '669382136543419670_15607662', null, 'marcbad', 'Paris, France', null, 'photo', '/uploads/2014/3/8/30.jpg', '', 'instagram', '', '1394016590', null, 'ALL WE NEED IS LOVE #9263', '1', '0');
INSERT INTO `node` VALUES ('31', '669380674184740209_17634798', null, 'la_bergere', 'Pierrefitte-sur-Seine, France', null, 'photo', '/uploads/2014/3/8/31.jpg', '', 'instagram', '', '1394016416', null, 'Besoin d\'une trottinette, d\'une gratte? Y\'a de tout au métro Commerce #9263', '1', '0');
INSERT INTO `node` VALUES ('32', '669377113656441935_2504398', null, 'ladybancale', '', null, 'photo', '/uploads/2014/3/8/32.jpg', '', 'instagram', '', '1394015991', null, 'Les détails font tout. #ff #9263', '1', '0');
INSERT INTO `node` VALUES ('33', '669317544242598744_9260275', null, 'marcellaromaniewicz', 'Montévrain, France', null, 'photo', '/uploads/2014/3/8/33.jpg', '', 'instagram', '', '1394008890', null, 'LUZ . CAMERA . AÇÃO #9263 #thosewillbethebestmemories ', '1', '0');
INSERT INTO `node` VALUES ('34', '442330248386863104', null, 'grougrou', '', null, 'photo', '/uploads/2014/3/8/34.jpg', '', 'twitter', '', '1394294723', null, 'RT @FredFarid: \"On est devenus Chinois dans le business\" via @FouziaKML from @CB_News #9263 http://t.co/sz9YYpbIUm', '1', '0');
INSERT INTO `node` VALUES ('35', '442324820936884224', null, 'Diamond_9263', '', null, 'text', null, '', 'twitter', '', '1394293429', null, '@ArarShahed العمر كلو', '1', '0');
INSERT INTO `node` VALUES ('36', '442320755867779072', null, '_hooodrich', 'Standing Alone', null, 'text', null, '', 'twitter', '', '1394292460', null, '@qaadie_ 267 970 9263', '1', '0');
INSERT INTO `node` VALUES ('37', '442319452735307776', null, 'MarineMR', 'Paris', null, 'text', null, '', 'twitter', '', '1394292150', null, 'Sunny Saturday at the agency #9263 http://t.co/7RUGvORX4X', '1', '0');
INSERT INTO `node` VALUES ('38', '442315860351279104', null, 'OrdengWarteg', 'Jakarta', null, 'text', null, '', 'twitter', '', '1394291293', null, '3 Aly Love Jennifer Natashia L ??? *9263', '1', '0');
INSERT INTO `node` VALUES ('39', '442315563419701248', null, 'haine915', '', null, 'text', null, '', 'twitter', '', '1394291222', null, '@haine915 03/08-03/09 のふぁぼ数: 105 (9158 → 9263) \nhttp://t.co/KsH2EVJMNi #favcounter', '1', '0');
INSERT INTO `node` VALUES ('40', '442310245201637376', null, 'ediponatan', 'Santa Cruz, RN', null, 'text', null, '', 'twitter', '', '1394289954', null, 'Garibaldi Filho defende pressa por parte do PMDB: http://t.co/1Z1j5Zdb5a', '1', '0');
INSERT INTO `node` VALUES ('41', '442306258629296128', null, 'lebanonsports', '', null, 'text', null, '', 'twitter', '', '1394289004', null, 'German Bundesliga Hamburger SV vs Eintracht Frankfurt\nhttp://t.co/BopRika7zr', '1', '0');
INSERT INTO `node` VALUES ('42', '442297409465368576', null, 'azizahmaulidyah', 'Smk mahardhika', null, 'text', null, '', 'twitter', '', '1394286894', null, 'Aly Love Jennifer Natashia L ??? *9263', '1', '0');
INSERT INTO `node` VALUES ('43', '442276166758846464', null, 'cdmasnou', 'El Masnou, Maresme', null, 'text', null, '', 'twitter', '', '1394281829', null, 'No baixar el ritme contra el cuer. La prèvia del @cdmasnou-@UDAGramenet de demà (12:00) a http://t.co/kuBF76Acnb #futbolcat #3div5', '1', '0');
INSERT INTO `node` VALUES ('44', '442270356812750848', null, 'X_VIDEOS_', '', null, 'text', null, '', 'twitter', '', '1394280444', null, '@null 9263', '1', '0');
INSERT INTO `node` VALUES ('45', '442259500666736640', null, 'AssetouCouliB', '', null, 'text', null, '', 'twitter', '', '1394277856', null, '@karaking6 9263.. ?? a 2H stp', '1', '0');
INSERT INTO `node` VALUES ('46', '442254071232475136', null, 'Jalila', 'Paris', null, 'photo', '/uploads/2014/3/8/46.jpg', '', 'twitter', '', '1394276561', null, '✈️ ', '1', '0');
INSERT INTO `node` VALUES ('47', '442251711164338177', null, 'FredFarid', 'Paris+Shanghai', null, 'photo', '/uploads/2014/3/8/47.jpg', '', 'twitter', '', '1394275999', null, '#ChinaEastern flight from #Paris to #Shanghai w/ @Jalila #9263 http://t.co/xGv1FJSVz8', '1', '0');
INSERT INTO `node` VALUES ('48', '442246689567809536', null, 'nsathostai', 'Волгоград', null, 'text', null, '', 'twitter', '', '1394274802', null, 'Понравилась статья, закинул себе в закладки http://t.co/3KnNAVQ648', '1', '0');
INSERT INTO `node` VALUES ('49', '442229959806164992', null, 'Nantan_Satria', '28-10-2013 :* :*', null, 'text', null, '', 'twitter', '', '1394270813', null, 'Justin Bieber Nangis ? http://t.co/dXrCZbqfhM *9263', '1', '0');
INSERT INTO `node` VALUES ('50', '442224532837789696', null, 'TwitLotto69923', '', null, 'text', null, '', 'twitter', '', '1394269519', null, '@Sxfwann_ You won an entry in our $10k/week sweeps (dead serious!). Click our shortlink &amp; use pw 9263 to redeem.', '1', '0');
INSERT INTO `node` VALUES ('51', '442217559920631808', null, 'latifahltf23', 'Indonesia', null, 'text', null, '', 'twitter', '', '1394267856', null, '9263  http://t.co/0Hbh7E4ZK2 #KuzuraNet *594', '1', '0');
INSERT INTO `node` VALUES ('52', '442217359634620416', null, 'SadieWarburg', 'Barrie ', null, 'text', null, '', 'twitter', '', '1394267809', null, 'DSC_9263_132880_Faye Wightman &amp; Joyce Murray http://t.co/h7C5Mi6bvM #Justin Trudeau #Trudeaumania', '1', '0');
INSERT INTO `node` VALUES ('53', '442209143131488256', null, 'demibuxyquxo', '', null, 'text', null, '', 'twitter', '', '1394265850', null, 'Пуловер 2014 - 010480 http://t.co/rzW1urQUNh', '1', '0');
INSERT INTO `node` VALUES ('54', '442185772221734912', null, 'hina_sibakuro', 'にちö君の後ろ', null, 'text', null, '', 'twitter', '', '1394260278', null, '絡んだことある人フレコ交換しませんかー！3969-4376-9263', '1', '0');
INSERT INTO `node` VALUES ('55', '442179520175415297', null, 'thomasalix', 'Paris', null, 'photo', '/uploads/2014/3/8/55.jpg', '', 'twitter', '', '1394258787', null, 'RT @FredFarid: \"On est devenus Chinois dans le business\" via @FouziaKML from @CB_News #9263 http://t.co/sz9YYpbIUm', '1', '0');
INSERT INTO `node` VALUES ('56', '442171539421933568', null, 'Mhollstein', 'Oceanside, California', null, 'text', null, '', 'twitter', '', '1394256884', null, 'RT @ceebee308: It was the perfect bank heist plan, except... - \'6 Hours 42 Minutes\' - Check it out on #BookBuzzr- http://t.co/0OVk665Xsr', '1', '0');
INSERT INTO `node` VALUES ('57', '442171359222042624', null, 'HouseofTaboo', '', null, 'text', null, '', 'twitter', '', '1394256841', null, 'RT @ceebee308: It was the perfect bank heist plan, except... - \'6 Hours 42 Minutes\' - Check it out on #BookBuzzr- http://t.co/0OVk665Xsr', '1', '0');
INSERT INTO `node` VALUES ('58', '442170831381483520', null, 'AuthorTBrooks', '', null, 'text', null, '', 'twitter', '', '1394256716', null, 'RT @ceebee308: It was the perfect bank heist plan, except... - \'6 Hours 42 Minutes\' - Check it out on #BookBuzzr- http://t.co/0OVk665Xsr', '1', '0');
INSERT INTO `node` VALUES ('59', '442170649814261760', null, 'AuthorNicMorgan', 'mons circum purpura majestatem', null, 'text', null, '', 'twitter', '', '1394256672', null, 'RT @ceebee308: It was the perfect bank heist plan, except... - \'6 Hours 42 Minutes\' - Check it out on #BookBuzzr- http://t.co/0OVk665Xsr', '1', '0');
INSERT INTO `node` VALUES ('60', '442170564552433664', null, 'paulregabooks', 'Gulf Coast of Florida ', null, 'text', null, '', 'twitter', '', '1394256652', null, 'RT @ceebee308: It was the perfect bank heist plan, except... - \'6 Hours 42 Minutes\' - Check it out on #BookBuzzr- http://t.co/0OVk665Xsr', '1', '0');
INSERT INTO `node` VALUES ('61', '442170354149380098', null, 'ceebee308', 'Montreal, Canada', null, 'text', null, '', 'twitter', '', '1394256602', null, 'It was the perfect bank heist plan, except... - \'6 Hours 42 Minutes\' - Check it out on #BookBuzzr- http://t.co/0OVk665Xsr', '1', '0');
INSERT INTO `node` VALUES ('62', '442159197711785984', null, 'adamgershon', 'The Valley', null, 'text', null, '', 'twitter', '', '1394253942', null, 'Helped nearby drivers by reporting a visible police trap on I-5 N, Lebec on @waze - Drive Social. http://t.co/OZFBMeLYcV', '1', '0');
INSERT INTO `node` VALUES ('63', '442148200225312768', null, 'FredFarid', 'Paris+Shanghai', null, 'photo', '/uploads/2014/3/8/63.jpg', '', 'twitter', '', '1394251320', null, '\"On est devenus Chinois dans le business\" via @FouziaKML from @CB_News #9263 http://t.co/sz9YYpbIUm', '1', '0');
INSERT INTO `node` VALUES ('64', '442143356588552192', null, 'FredFarid', 'Paris+Shanghai', null, 'photo', '/uploads/2014/3/8/64.jpg', '', 'twitter', '', '1394250165', null, 'Late night w/ my little sister Clemence and Marie @theopaulgab #9263 http://t.co/Ad2RupHMd1', '1', '0');
INSERT INTO `node` VALUES ('65', '442138961004077057', null, 'Emilangeles_05', 'яєρυвι¢α ∂σмιηι¢αηα ', null, 'text', null, '', 'twitter', '', '1394249117', null, 'Free 1000 followers    http://t.co/8CIbkVwPK3  9263    Justin Bieber Nyengir #ServetİsteyenSiyasetiBıraksın', '1', '0');
INSERT INTO `node` VALUES ('66', '442134464852811776', null, 'X_VIDEOS_', '', null, 'text', null, '', 'twitter', '', '1394248045', null, '@null 9263', '1', '0');

-- ----------------------------
-- Table structure for oauth
-- ----------------------------
DROP TABLE IF EXISTS `oauth`;
CREATE TABLE `oauth` (
  `oid` int(10) NOT NULL AUTO_INCREMENT,
  `media` varchar(100) NOT NULL,
  `username` varchar(100) NOT NULL,
  `token` varchar(255) NOT NULL,
  `token_secret` varchar(255) NOT NULL,
  PRIMARY KEY (`oid`),
  UNIQUE KEY `media` (`media`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of oauth
-- ----------------------------
INSERT INTO `oauth` VALUES ('1', 'instagram', 'fuelitup', '1133838733.28fb0c1.18d82e8ec3454d49988ab2ee083be6fa', '');
INSERT INTO `oauth` VALUES ('2', 'twitter', 'fuelitup2', '2365810087-IatJREE8Px4XhiINuvhFZ4kf7G4Tk9IMiERo0JQ', 'GdBSh2a7JCDT3Na0EDlU6OQQeZJsHZ72M4fBsIehFBfSk');
INSERT INTO `oauth` VALUES ('4', 'facebook', 'fuelitup.fuel ', 'CAADhritmk0ABABxa1pDVNXZCtewEcucftJMvfjQTRLjmz5K6syvgnNVQsR5P2AudwmRVwQZBO7ZCUJz6XzisA9Cwo6hUCXD2ncr7jRrz3LNoyZBtI1CB4ldI3RWG0414k1TjHP7CJ43at8bXK9aA4e1DW2FI8jLE2wRFkghyBzgpGvCf3gnqoIea3ZB2oaXcZD', '');

-- ----------------------------
-- Table structure for session
-- ----------------------------
DROP TABLE IF EXISTS `session`;
CREATE TABLE `session` (
  `id` char(32) NOT NULL,
  `expire` int(11) DEFAULT NULL,
  `data` longblob,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of session
-- ----------------------------
INSERT INTO `session` VALUES ('000d17d7efd6aa967726cbdda928c87a', '1394366182', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223663343563363431383934333535366235393330326166653130613937316235223B);
INSERT INTO `session` VALUES ('03b897dd91ad73897def104d8a212e8c', '1394365841', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223334363135393938653136663062333066396335653037643763663137616634223B);
INSERT INTO `session` VALUES ('05346bd730b01c5c9e832eb0f6e84503', '1394366702', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223330363163393131366662336638663161333864636339313234353764323430223B);
INSERT INTO `session` VALUES ('0697a6d2fea3699d8612dc096810db95', '1394365778', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223335663032363233353964376436386462386233623131626664626135353963223B);
INSERT INTO `session` VALUES ('06dc2464456a6227fc94fab3cf1eee07', '1394366175', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223864656536623865363539636335653230396164323131393630646637363066223B);
INSERT INTO `session` VALUES ('08a96f9eb9b660ccf40f70329de0e834', '1394365849', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223535323965613962663533393338376565353363613338623366303263343136223B);
INSERT INTO `session` VALUES ('0b3cdc0259a24a671afc880810529c45', '1394365774', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223164333531306165366661336637386330373263656134653538323135363332223B);
INSERT INTO `session` VALUES ('0bb159bec1ee00b14ba98887d344adb9', '1394365778', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223263313536303937336338343834313534386434383337623739353330303832223B);
INSERT INTO `session` VALUES ('109b1d34990ba40552ee4b03ab0e6b83', '1394366151', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223365373139343865356330343935613032656231326532303133653534383233223B);
INSERT INTO `session` VALUES ('1863d357ed8b1f57519350bd560ac182', '1394365782', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223134353037613335616535386439333330613637616135303935653165316162223B);
INSERT INTO `session` VALUES ('18e9149a1ef153b665e26397da62c2b5', '1394366419', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223638613538336665396664333836373632383433613335316230336430643834223B);
INSERT INTO `session` VALUES ('19d243d3d62018f0f327371d1bbb0b3e', '1394366700', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A226438303037306261626261383163636536316634323165313435636430633939223B);
INSERT INTO `session` VALUES ('1f4689e03b9a2d232e50aa9a17f00603', '1394365845', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223762393033633239633831663631643731343265383839666566386566316532223B);
INSERT INTO `session` VALUES ('21628454bfecaa6b511cee7a6a8ddd33', '1394366149', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A226539303163663134376537383631323131353165653234646361663333653335223B);
INSERT INTO `session` VALUES ('22d54e671fff04c4f36a2e7a98419405', '1394366408', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223763343838376131636231323563336432643837636334616566353239663830223B);
INSERT INTO `session` VALUES ('22d8b2f5533439cc596306a9517da495', '1394365848', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A226466393131326534396235653732323431396366373830643937633761386464223B);
INSERT INTO `session` VALUES ('30517518fcc80496563be13d3157d075', '1394366408', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223038376432336235633164303063396637613334616235666633623835643039223B);
INSERT INTO `session` VALUES ('325a3ede21a096eec06fc32978c7f0ce', '1394365784', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A226564353633623964303835393364303930386138633034653163333362353866223B);
INSERT INTO `session` VALUES ('32d06c11842678b52e1b966218cf5176', '1394366417', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A226434396631313539653337623534396631386230306436313338303138386434223B);
INSERT INTO `session` VALUES ('333bbf0215cc665ab54682c0ea4ba08d', '1394365845', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223863356362613065623435373034663263656466653736376331656532323763223B);
INSERT INTO `session` VALUES ('334c6bcd738e027525a11fb013470d6d', '1394366701', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223835633632376139353764366164616637336132306166353438333564393333223B);
INSERT INTO `session` VALUES ('36fb763858be934708bfca0871e39b4f', '1394365848', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223164353038656639313431396339323765313630346638393038363861353234223B);
INSERT INTO `session` VALUES ('372197862dbee71f4619b96228809696', '1394366419', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223535623662653639376130616562616138343630376462653832343538613766223B);
INSERT INTO `session` VALUES ('3746975fa36d04af2f57ee0ae277ee6b', '1394366707', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A226632306563643961666536326162666231646137396338653034363537633465223B);
INSERT INTO `session` VALUES ('3e37058014a3ae3bd60cdf20b157cdf0', '1394366702', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223230383937303436333365666234626230666336313538333330663961383031223B);
INSERT INTO `session` VALUES ('3f3f1a249c90c8b284532099ea3d6ff5', '1394365848', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223932643762393262346538313339363738366330326333663335376534343936223B);
INSERT INTO `session` VALUES ('4193679a800dd3a4543f3608309924f2', '1394366148', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223334643464646530616666396565356362303435366139616365396435373735223B);
INSERT INTO `session` VALUES ('4409570c0f5b1cf00c51be9d19a02059', '1394365843', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A226533326462613866386461376439363232363437336435343665653461616530223B);
INSERT INTO `session` VALUES ('457c8913cb7869eba125d4d8e6501976', '1394365842', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223532383339656362633861626364666535346466386334323136626266363933223B);
INSERT INTO `session` VALUES ('4779bc31030f8b6b6f2b947f86ccd086', '1394366408', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A226663613434643830653762376664343830316265333937623264306336373831223B);
INSERT INTO `session` VALUES ('47b323a22f146f29f780f0124659a2b2', '1394365782', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A226130333066633237646131616438326137336664393565326434346366343930223B);
INSERT INTO `session` VALUES ('4994a22c8f82ad5473d5451bcbbde3b4', '1394366702', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223538613634386237633436313930653566313331316137363530303833376235223B);
INSERT INTO `session` VALUES ('4998ddef4aa21caeccf2c37f4ea60322', '1394365778', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A226664613239313532623737383535643263376138353565376166643663343665223B);
INSERT INTO `session` VALUES ('4e550efdee81268ae88380a262089fa8', '1394366701', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223330393866663266313038326563336164356166303532313631656262343134223B);
INSERT INTO `session` VALUES ('4ebf24a7382c5a13536774adcb72e0f1', '1394366701', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223537633763366435306238343366383862306635323566373737333866613537223B);
INSERT INTO `session` VALUES ('504107c8238b3901911d9acb4fb0057d', '1394365876', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223536303536303832386166303633373934363938613431393133326639636361223B);
INSERT INTO `session` VALUES ('52f56290854f98331f0ef34da4f801bc', '1394365875', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A226530663839653432623134616531353138666530366133663261363566653365223B);
INSERT INTO `session` VALUES ('54a7b1ad69d5e65830fa28d7013efa4f', '1394366422', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223132306162313436343166306233393130356162313563313234393431306239223B);
INSERT INTO `session` VALUES ('5682068101a3d7ec1efa047bf10820ec', '1394366418', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223739363934366530393861346663303262636535656331616430346637643265223B);
INSERT INTO `session` VALUES ('56e3c3098877bab865ad229b610ff763', '1394365781', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223230376363376164616233313338666665616261386433396265353061393133223B);
INSERT INTO `session` VALUES ('587a812ad0bc8f339cc6d7c74f8ba41b', '1394366140', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A226635646438336262373032613639646162613930636231613335303636646362223B);
INSERT INTO `session` VALUES ('5a10f5dd44bb12bf59c72533def28c67', '1394366146', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223437323632653735303139633862316135346634303166393333336661663235223B);
INSERT INTO `session` VALUES ('5dca8efd309006acc80c6b104ec3b8c7', '1394366701', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A226630623265366335393437336234633430373832343361303539316331383932223B);
INSERT INTO `session` VALUES ('5f964e18ae6fce9b18b10f46dbc8849d', '1394365782', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223631376338663563323662663061343435363035313432336130376135353230223B);
INSERT INTO `session` VALUES ('61d50e925a115d401fad0769941121ea', '1394366183', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223830363961336231653863393739666165636330363565356437363339623332223B);
INSERT INTO `session` VALUES ('623c519994bb8f5d42b019b080d1cf20', '1394365875', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223239646332646165306338373731356435636530626235366633373566343437223B);
INSERT INTO `session` VALUES ('6431fbeab05f51bbdcf10c1f43d2c3d2', '1394365777', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A226661653337656335636262613139303161303238336666393766643766363332223B);
INSERT INTO `session` VALUES ('64a1106ea12e9efdda0a318a5af5c92e', '1394365843', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223334383466613936363963613230623635656564643635353236366666646630223B);
INSERT INTO `session` VALUES ('661aa6fe2856b59c9e6fc297408760a5', '1394366143', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223465303266353237303631643232633237396532633731323664333938386463223B);
INSERT INTO `session` VALUES ('66fb6b391a600b421889f9729d97ea6d', '1394366150', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223232633538633938376334303137616463376333343533343539396136363437223B);
INSERT INTO `session` VALUES ('67883a3b94726480e46b216a13d4212c', '1394365782', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223639666661663663383937313837616336396663633264323166626666643034223B);
INSERT INTO `session` VALUES ('69beb5145b47be4bc3d69bb47e718221', '1394365781', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223861643639643531323666663763363833636365333632616633376666323132223B);
INSERT INTO `session` VALUES ('6a7518eb25398088e10d4076e71c6216', '1394365777', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223830616339653161643137633533373434623137336565373031386364316662223B);
INSERT INTO `session` VALUES ('6bd8326b98a2b888199e1cf1ad8e6f0e', '1394366418', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223065343763356264343534613762626366646534393165633732356562636436223B);
INSERT INTO `session` VALUES ('6d91b10d2e0d08b36d54415a51aa6757', '1394366138', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223737363232373533363435323332323161313438666537306133383632333961223B);
INSERT INTO `session` VALUES ('6db192daa8967a09abe9a1479a23588e', '1394365875', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223664303432613636393639343639356163373036366163613764386463383334223B);
INSERT INTO `session` VALUES ('6f0f2ff4d0cf57eb8a403ad907fdadec', '1394365844', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223738626665323934623230353235306664366236343530373265663464633739223B);
INSERT INTO `session` VALUES ('711c4df4e6370c487f8d99fcaeec6061', '1394365844', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223336306339636338376431316437363530393066313066313564653536396238223B);
INSERT INTO `session` VALUES ('7294c46b42d29f70859f877843287679', '1394366169', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223530633239366234363739343431313531363036363839323430396165643465223B);
INSERT INTO `session` VALUES ('750d051c5d8b6bc18fa5400e0abcda13', '1394365848', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223130656165623966313831316563306166633132316437333639373535643861223B);
INSERT INTO `session` VALUES ('762c3aa01ab4bfdcf5314967ab057fe8', '1394366145', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223034306434316465623266643435343064663036313935653330643334383361223B);
INSERT INTO `session` VALUES ('7654477313375ce678a8eaa85dd7e646', '1394366149', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223664353932636266656231666439653938323131626564326336313862373161223B);
INSERT INTO `session` VALUES ('7756ecc921a3c03ae25dbee79a884a6c', '1394365842', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223762663037376166613236326364663330643436346139313365393564363330223B);
INSERT INTO `session` VALUES ('7b72ebb0728de881af816066fcc00f30', '1394365848', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A226135643234643334336665383962393935613438663561363437373165386263223B);
INSERT INTO `session` VALUES ('7b765e21ded83984ebef048b9a7512b4', '1394365777', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223861383162656531633966643435663637353037353765636363373331346563223B);
INSERT INTO `session` VALUES ('7ba2a5d6a9b60d14c3a7f720795186ab', '1394366143', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223334353938353530653338393833386465653835613031383461343964643733223B);
INSERT INTO `session` VALUES ('7c6a7cf373dbb2441be56b1a7a51d1fc', '1394366139', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223434663132383863363462623937666231303938333365393435663436636430223B);
INSERT INTO `session` VALUES ('7fa384bc5925e06841cbb29f1446f1b4', '1394366702', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A226136393564626366623365613039613539646565363264323336636637306132223B);
INSERT INTO `session` VALUES ('804e82ed088b300542715ca0bc5f061d', '1394366168', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223064353233396536303066336462636335303065613636663233336634613833223B);
INSERT INTO `session` VALUES ('80633a0e2c4580f8779c7d57f7dfda19', '1394365780', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A226637363234643632643232323936356166366661623132346637666634316161223B);
INSERT INTO `session` VALUES ('80a8aa4d92557b41fcf2e79b12ee4b99', '1394365779', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223731643231333238646635303637646162373337643630626636306432326464223B);
INSERT INTO `session` VALUES ('8923e51e9ecb35edf7460b650703e0c6', '1394366148', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223630663538323430656361303936373537333039306539646132323535383430223B);
INSERT INTO `session` VALUES ('8c6d9f693c9822dcb6cce18fc3e8e988', '1394366701', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223530363637326364336564643131333236623161636138346632666636653732223B);
INSERT INTO `session` VALUES ('8cf794b8d003a73c9a43249e9f75afe1', '1394365875', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A226665393563316162656635313264306230383030373839663131326262373466223B);
INSERT INTO `session` VALUES ('8e04cf18f0290b903f8443aa778b6a74', '1394365845', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223434383636386431323931353530613163363265323131646665363437346230223B);
INSERT INTO `session` VALUES ('8e1a8e7ce56c9cc6498da494b1d9a90c', '1394366151', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223431633231383038336133313031353531313939613135656463396537346564223B);
INSERT INTO `session` VALUES ('8e80508d2dd4f8ce68784ecced1e669d', '1394365847', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A226231626366333938386235653133313462323735316437326437396639333330223B);
INSERT INTO `session` VALUES ('9341843a20adfb46735476719297ff4a', '1394366408', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223936323232613835643062623531356436316564633531393238663234353134223B);
INSERT INTO `session` VALUES ('9423ada677cb7a4a4eda96e26684ba64', '1394366147', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223336303539613665653530646338353764333135623039626639313064346665223B);
INSERT INTO `session` VALUES ('996f5a814f72f110e56496e42771a350', '1394366409', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223137636635636364313139653136333237336235333732386266353766313562223B);
INSERT INTO `session` VALUES ('99d39f4652ec71316c652e0396047aa7', '1394366701', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A226537386263663830343336633031653130393463633731353839336263613738223B);
INSERT INTO `session` VALUES ('9d8d5e5e9cb9076b43e049af8d04f85f', '1394365781', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A226463646438653137636561363762623835316662363236353331323533393730223B);
INSERT INTO `session` VALUES ('9da38468f9f31986c321d82e161f4d44', '1394366142', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A226266303132643439366531656634326563613936336665343231613261386364223B);
INSERT INTO `session` VALUES ('9dafe5f43deb3439b2d5344babc1f58e', '1394366703', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A226531663231646138346163656133306431303337646531333263316530646163223B);
INSERT INTO `session` VALUES ('9e89243f268222561612af5557d1111d', '1394365779', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A226134333538633834633764636232653262616233316139363731336362613639223B);
INSERT INTO `session` VALUES ('9ec467d7e12c1485d6216d0199953a1a', '1394365843', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223638366334326564323635366463653531313830393339666634663138383530223B);
INSERT INTO `session` VALUES ('a03edd7abc8b35ea3cf87691186c4715', '1394366422', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A226263306563383764363736336537376634633133613963663733336133666333223B);
INSERT INTO `session` VALUES ('a19b5425601545fee152e855341f4710', '1394365847', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223564633262396264323033323138366335333230336535356634323461366432223B);
INSERT INTO `session` VALUES ('a4890a96d559bde584358cd304ea58cb', '1394366409', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223264363537616436616339363933313731303734633963366339303466623532223B);
INSERT INTO `session` VALUES ('a576e16d0876bf2e3dc0124fc074d8af', '1394365847', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A226536373939303435626362323037376631396533663634373333353439623438223B);
INSERT INTO `session` VALUES ('a5d78b1818cc9f459386517d261e6b2f', '1394366150', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223938383030363335616136393932346331646232306630663061333933396164223B);
INSERT INTO `session` VALUES ('a711087eb07cc37461c81cc8faa53b96', '1394365843', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223538316561663465653035313665626333313435623664386465353165623161223B);
INSERT INTO `session` VALUES ('a8fc52492250e1f1fd2134e0025c36b1', '1394366141', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A226363613033356537303766396364333665633233656263363563356337613864223B);
INSERT INTO `session` VALUES ('ac6c3ca986173ca3e4fb2f9fac568766', '1394365776', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223836646365343362333766323464333438373134306464366139383231353261223B);
INSERT INTO `session` VALUES ('ad951ffc95bbb0b8bf18aa56da2c524e', '1394365846', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A226432303133663635396465323364613131303937663033323737363436663139223B);
INSERT INTO `session` VALUES ('ae21b4743123807be046c95e370e2bdb', '1394366181', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223361626237363361646332636162613632616239303063613234346663323739223B);
INSERT INTO `session` VALUES ('aea067ac58618ad7d1fd4ee81252e261', '1394366416', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223431373666343737393638393730653536313066656137323136326265613865223B);
INSERT INTO `session` VALUES ('af1fc63fe51f2956ab30848d757423da', '1394366146', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223137366234663438663735383835633836666233396432616237343166373165223B);
INSERT INTO `session` VALUES ('afc5fa63422cb373f8dd8190cfb48abd', '1394366419', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223934383939616363333930343336303862316439336236376235306339313265223B);
INSERT INTO `session` VALUES ('b13f7dfe82bda704f985bd2b2e389a65', '1394366417', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223034323237356466373830663237613530306637333836316234353833383236223B);
INSERT INTO `session` VALUES ('b32b868e060259bb7fb29330b8f20930', '1394366167', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223863646632313636656465666239666332663163616133633262633739636231223B);
INSERT INTO `session` VALUES ('b5ad14c30012bd0f654efad9761bed56', '1394365774', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223237366361623562643532363036306431666133313861626664643962646635223B);
INSERT INTO `session` VALUES ('bcc47019d82a5148b6bddd50778da155', '1394365844', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A226238623733323430373534353066333031643339613938396439663334636337223B);
INSERT INTO `session` VALUES ('be5dbed0b0a26d8d7ad341c85f8d3d7e', '1394365842', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223931383637653665636361633763353264323034373564323032363463346533223B);
INSERT INTO `session` VALUES ('bfd1bda817b6acfa2bbafc6c027755b3', '1394366144', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A226239396434373039613464353230653265633535653865376466343864333763223B);
INSERT INTO `session` VALUES ('bff82d21ce14f5540df98999a3fd9907', '1394365780', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A226265343161326130623735323835666364353931646535343232653763336332223B);
INSERT INTO `session` VALUES ('c022b53446626057edbd3f424a9c120a', '1394366418', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223039303432326665656539376534393231326563613065653563633735366235223B);
INSERT INTO `session` VALUES ('c9e17744eed0a28f3bf4a964baf05c76', '1394366147', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A226666653539396363363263636363333665383963303162313537323563396139223B);
INSERT INTO `session` VALUES ('caa8c77c6abe4fe1d6b9232b12722a0d', '1394366417', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223435396438353739376666383161333535393638613162323538343962346464223B);
INSERT INTO `session` VALUES ('cf441e265fe9d8c2cadedaa48075601a', '1394366702', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A226166623639396261336135373664323935303539633536373439613839363831223B);
INSERT INTO `session` VALUES ('d48be236a2dd4c5d47a6e6c4785ac4b9', '1394366416', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223839343864383034323734643630656431366230663666303266323266633765223B);
INSERT INTO `session` VALUES ('d5708802420bf3ecfac33f404dcdfd09', '1394365783', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223238633361333063666539333438383738333764663239626638383634633332223B);
INSERT INTO `session` VALUES ('d84588c5619b67fa271dfa1ccfd3c947', '1394366416', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223634663337616439343331303563333135353334396630356534376665376332223B);
INSERT INTO `session` VALUES ('d9afa21ccb6c94d81c50730a037c2721', '1394365779', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223435343861376637366163376164333266653632346534666263613831306361223B);
INSERT INTO `session` VALUES ('da156ef51ac0ee0881ac70f8f7c8463e', '1394365846', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223530353366376362636264393166383863313038336666333463313332373332223B);
INSERT INTO `session` VALUES ('db055e9843211ec7c84190304ff48266', '1394366137', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223030626366333738643034353639383335363233313834643134343165396433223B);
INSERT INTO `session` VALUES ('dd24a2bc7b2b65410bf244dad05e0ef8', '1394365783', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A226564343237623437316362313461643633643332393531633931613666333736223B);
INSERT INTO `session` VALUES ('ddfef78e9c17c9747e8aa22a1253e946', '1394365845', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223539353231393663663633656234326232323731393637326139373061353766223B);
INSERT INTO `session` VALUES ('e05d131bf020ba9aef1e91a42ba29be7', '1394365779', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A226139343833303135393031383537663438386238383765613139396261386236223B);
INSERT INTO `session` VALUES ('e2e94457bb5d16e9a5dd873eb16b8c4e', '1394365845', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223666373863623761353364636239373563613862643362336639633033663264223B);
INSERT INTO `session` VALUES ('e5d7122d14294c9ad4b9298468f39244', '1394366417', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223534323230323531636465666634303063326130653065303038303935666366223B);
INSERT INTO `session` VALUES ('e884554b544171c2bdca2a7baea08b26', '1394365776', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A226334373739643833373764333064363634383636313834316630363435373738223B);
INSERT INTO `session` VALUES ('e8d62ed79bc06146a68a066ee355cfbd', '1394365780', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223431383963396531326163656630666162326166346537306334653633373932223B);
INSERT INTO `session` VALUES ('e97b32ae8ff8f23ff7d7f70688407aed', '1394365779', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223832623236386634663139626134646331353162646531613962663535353437223B);
INSERT INTO `session` VALUES ('ea4bf35146630d2bf4a19d4c3e504c7b', '1394366419', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223063616562643032616538333964363766333735383763663763663737356439223B);
INSERT INTO `session` VALUES ('ede2efe13884687efe561dde86366b0c', '1394366174', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A226461303736633862313231376130623463643835376436636538383231623036223B);
INSERT INTO `session` VALUES ('f4556285da60ce2a3e9815276658b890', '1394365778', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A226139656535396366333138373038356437643766353833633632336236373935223B);
INSERT INTO `session` VALUES ('f78b43bf130947c63de77b4e8d42ef0f', '1394365849', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A226463386362353932633561376664363135633462633066356331343764363837223B);
INSERT INTO `session` VALUES ('f7f1dbeb3402e010ffff4630f1fa53fc', '1394365846', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A223561626632353635366432316433373535653733343432383134623832343739223B);
INSERT INTO `session` VALUES ('fe3f39e1e92b48fc63b3430893f673a6', '1394366416', 0x30383562363932333965653237313936303039613432643835323736386164385F5F6E616D657C733A303A22223B30383562363932333965653237313936303039613432643835323736386164385F5F7374617465737C613A303A7B7D3038356236393233396565323731393630303961343264383532373638616438726F6C657C693A303B3038356236393233396565323731393630303961343264383532373638616438636F756E7472795F69647C693A303B766F74655F73657373696F6E7C733A33323A226366313939636465346236343664313465363239333039643735366263393865223B);

-- ----------------------------
-- Table structure for setting
-- ----------------------------
DROP TABLE IF EXISTS `setting`;
CREATE TABLE `setting` (
  `sid` int(10) NOT NULL AUTO_INCREMENT,
  `setting_key` varchar(255) CHARACTER SET utf8 NOT NULL,
  `setting_value` varchar(255) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`sid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of setting
-- ----------------------------
INSERT INTO `setting` VALUES ('1', 'phase', '1');
INSERT INTO `setting` VALUES ('2', 'praise', '2');
INSERT INTO `setting` VALUES ('3', 'answer', '地方dfreterc');

-- ----------------------------
-- Table structure for tag
-- ----------------------------
DROP TABLE IF EXISTS `tag`;
CREATE TABLE `tag` (
  `tag_id` int(128) NOT NULL AUTO_INCREMENT,
  `tag` varchar(255) NOT NULL,
  `count` int(255) NOT NULL DEFAULT '0',
  `date` varchar(16) NOT NULL,
  PRIMARY KEY (`tag_id`),
  UNIQUE KEY `tag` (`tag`),
  UNIQUE KEY `tag_id` (`tag_id`),
  KEY `tag_id_2` (`tag_id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tag
-- ----------------------------
INSERT INTO `tag` VALUES ('1', 'test', '2', '');
INSERT INTO `tag` VALUES ('2', 'teak', '2', '');
INSERT INTO `tag` VALUES ('3', 'test2', '0', '');
INSERT INTO `tag` VALUES ('5', 'test3', '0', '');
INSERT INTO `tag` VALUES ('8', 'test5', '2', '');
INSERT INTO `tag` VALUES ('9', 'bird', '1', '');
INSERT INTO `tag` VALUES ('10', 'lovely', '1', '');
INSERT INTO `tag` VALUES ('11', 'red', '1', '');
INSERT INTO `tag` VALUES ('12', 'cute', '1', '');
INSERT INTO `tag` VALUES ('13', 'animal', '1', '');
INSERT INTO `tag` VALUES ('14', 'china', '2', '');
INSERT INTO `tag` VALUES ('15', 'green', '3', '1391351051');
INSERT INTO `tag` VALUES ('17', 'natural', '0', '');
INSERT INTO `tag` VALUES ('18', 'fdf', '0', '');
INSERT INTO `tag` VALUES ('19', 'dffd', '0', '');
INSERT INTO `tag` VALUES ('20', 'kkk', '0', '');
INSERT INTO `tag` VALUES ('21', 'fff', '1', '1391422741');
INSERT INTO `tag` VALUES ('22', 'winter', '1', '');
INSERT INTO `tag` VALUES ('23', 'ff', '0', '');
INSERT INTO `tag` VALUES ('24', 'abcd', '0', '');
INSERT INTO `tag` VALUES ('25', '223', '0', '');
INSERT INTO `tag` VALUES ('26', 'djd\'fifif', '0', '');
INSERT INTO `tag` VALUES ('27', 'dkdd', '0', '');

-- ----------------------------
-- Table structure for topday
-- ----------------------------
DROP TABLE IF EXISTS `topday`;
CREATE TABLE `topday` (
  `topday_id` int(15) NOT NULL AUTO_INCREMENT,
  `nid` int(15) NOT NULL,
  `date` int(11) NOT NULL,
  PRIMARY KEY (`topday_id`),
  UNIQUE KEY `nid` (`nid`,`date`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of topday
-- ----------------------------
INSERT INTO `topday` VALUES ('6', '122', '1389481200');
INSERT INTO `topday` VALUES ('14', '163', '1389740400');
INSERT INTO `topday` VALUES ('13', '170', '1389913200');
INSERT INTO `topday` VALUES ('5', '197', '1390258800');
INSERT INTO `topday` VALUES ('3', '206', '1391122800');
INSERT INTO `topday` VALUES ('2', '214', '1391209200');
INSERT INTO `topday` VALUES ('1', '214', '1391219200');
INSERT INTO `topday` VALUES ('29', '277', '1391900400');
INSERT INTO `topday` VALUES ('27', '308', '1392678000');
INSERT INTO `topday` VALUES ('28', '323', '1393110000');
INSERT INTO `topday` VALUES ('26', '429', '1392418800');

-- ----------------------------
-- Table structure for topmonth
-- ----------------------------
DROP TABLE IF EXISTS `topmonth`;
CREATE TABLE `topmonth` (
  `topmonth_id` int(15) NOT NULL AUTO_INCREMENT,
  `nid` int(15) NOT NULL,
  `date` int(11) NOT NULL,
  PRIMARY KEY (`topmonth_id`),
  UNIQUE KEY `nid` (`nid`,`date`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of topmonth
-- ----------------------------
INSERT INTO `topmonth` VALUES ('2', '122', '1388530800');
INSERT INTO `topmonth` VALUES ('3', '214', '1391209200');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `uid` int(15) NOT NULL AUTO_INCREMENT,
  `sso_id` varchar(100) NOT NULL,
  `name` varchar(200) DEFAULT NULL,
  `personal_email` varchar(200) DEFAULT NULL,
  `company_email` varchar(200) DEFAULT NULL,
  `country_id` int(15) DEFAULT NULL,
  `avatar` varchar(200) DEFAULT '',
  `role` int(11) DEFAULT '1',
  `datetime` int(11) DEFAULT NULL,
  `firstname` varchar(45) DEFAULT NULL,
  `lastname` varchar(45) DEFAULT NULL,
  `password` varchar(45) DEFAULT NULL,
  `status` int(11) DEFAULT '1',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `sso_id` (`sso_id`),
  UNIQUE KEY `personal_email_UNIQUE` (`personal_email`),
  UNIQUE KEY `company_email_UNIQUE` (`company_email`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('3', '2ff43693fbce1d16e38e833b33a069f9', 'tonysh518', 'tony2@fuel-it-up.com', 'tonysh518@rnd.feide.no', '30', '', '1', '1391654204', 'tony', 'zhu', null, '1');
INSERT INTO `user` VALUES ('4', '4f5761b67a2a11b8d37d1112820d253c', 'sgtest', 'tofnfff33333f33ffdf23@fuel-it-up.com', 'sgtest@rnd.feide.no', '35', '/uploads/avatar/4.jpg', '2', '1391912982', 'sg', 'test', null, '1');
INSERT INTO `user` VALUES ('5', 'ac0f49b7b582db2a194f42ccf15a6247', 'sgtest2', null, 'sgtest2@rnd.feide.no', '30', '', '1', '1392725672', 'sgtest2', 'sg', null, '1');
INSERT INTO `user` VALUES ('6', '9a229522a6d2a17e314a0109fcd21a3d', 't_tonysh518', null, null, '0', '', '1', '1394292727', null, null, null, '1');
INSERT INTO `user` VALUES ('7', '601fb00a92bf6b88cca3d3a6c2eb945d', 't_fuelitup2', null, null, '0', '', '1', '1394292784', null, null, null, '1');
INSERT INTO `user` VALUES ('8', '938a0d0e86d72a29454145db7dc6e844', 't_tropicalfishx', null, null, '0', '', '1', '1394356975', null, null, null, '1');

-- ----------------------------
-- Table structure for video
-- ----------------------------
DROP TABLE IF EXISTS `video`;
CREATE TABLE `video` (
  `vid` int(100) NOT NULL AUTO_INCREMENT,
  `url` varchar(255) NOT NULL,
  `thumbnail` varchar(255) NOT NULL,
  `datetime` varchar(16) NOT NULL,
  `status` int(1) NOT NULL,
  `position` int(2) NOT NULL,
  PRIMARY KEY (`vid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of video
-- ----------------------------

-- ----------------------------
-- Table structure for vote
-- ----------------------------
DROP TABLE IF EXISTS `vote`;
CREATE TABLE `vote` (
  `vote_id` int(100) NOT NULL AUTO_INCREMENT,
  `vid` int(100) NOT NULL,
  `datetime` varchar(16) NOT NULL,
  PRIMARY KEY (`vote_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of vote
-- ----------------------------
INSERT INTO `vote` VALUES ('1', '1', '1394283385');
INSERT INTO `vote` VALUES ('2', '1', '1394284096');
INSERT INTO `vote` VALUES ('3', '3', '1394284158');
INSERT INTO `vote` VALUES ('4', '3', '1394284409');
INSERT INTO `vote` VALUES ('5', '2', '1394284414');
INSERT INTO `vote` VALUES ('6', '3', '1394285687');
INSERT INTO `vote` VALUES ('7', '3', '1394285716');
INSERT INTO `vote` VALUES ('8', '3', '1394285816');
INSERT INTO `vote` VALUES ('9', '2', '1394285845');
INSERT INTO `vote` VALUES ('10', '3', '1394294287');
INSERT INTO `vote` VALUES ('11', '2', '1394296214');
INSERT INTO `vote` VALUES ('12', '1', '1394345888');
INSERT INTO `vote` VALUES ('13', '1', '1394356955');
