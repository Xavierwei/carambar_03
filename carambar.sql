-- phpMyAdmin SQL Dump
-- version 4.0.6
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Mar 21, 2014 at 02:17 AM
-- Server version: 5.5.33
-- PHP Version: 5.5.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `carambar`
--

-- --------------------------------------------------------

--
-- Table structure for table `challenge`
--

CREATE TABLE `challenge` (
  `cid` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'challenge id',
  `title` varchar(128) NOT NULL,
  `image` varchar(256) NOT NULL,
  `datetime` int(11) unsigned zerofill NOT NULL,
  `vote_counts` int(13) unsigned NOT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `challenge`
--

INSERT INTO `challenge` (`cid`, `title`, `image`, `datetime`, `vote_counts`) VALUES
(1, 'Faire Rire\nUne Star D’Hollywood', 'test1.jpg', 01394950749, 4),
(2, 'Faire Rire \nBarack', 'test2.jpg', 01394950760, 17),
(3, 'Faire Rire Un Stade\nAméricain', 'test3.jpg', 01394950847, 3);

-- --------------------------------------------------------

--
-- Table structure for table `comment`
--

CREATE TABLE `comment` (
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `content` text,
  `datetime` int(11) DEFAULT NULL,
  `nid` int(11) DEFAULT '0',
  `status` int(2) NOT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=117 ;

--
-- Dumping data for table `comment`
--

INSERT INTO `comment` (`cid`, `uid`, `name`, `email`, `content`, `datetime`, `nid`, `status`) VALUES
(2, 12, '', '', 'I am at #Starbar and work for #Shanghai Company', NULL, 1, 1),
(3, 12, '', '', 'I am at #Starbar and work for #Shanghai Company', NULL, 1, 1),
(4, 12, '', '', 'I am at #Starbar and work for #Shanghai Company', 1388271018, 1, 1),
(5, 12, '', '', 'I am at #Starbar and work for #Shanghai Company', 1388271027, 1, 1),
(6, 12, '', '', 'test', 1389423952, 21, 1),
(7, 12, '', '', 'fsdf', 1389425642, 21, 1),
(8, 12, '', '', 'fsdf', 1389425696, 21, 1),
(9, 12, '', '', 'OK!', 1389425860, 21, 1),
(10, 12, '', '', 'fds', 1389425941, 21, 1),
(11, 12, '', '', 'fsdf', 1389426073, 21, 1),
(12, 12, '', '', 'fsdf', 1389426074, 21, 1),
(13, 12, '', '', 'fsdf', 1389426108, 21, 1),
(14, 12, '', '', 'fsdf', 1389426108, 21, 1),
(15, 12, '', '', 'fsd', 1389426150, 21, 1),
(16, 12, '', '', 'ccc', 1389450693, 25, 1),
(17, 12, '', '', 'fjkdsjfkd', 1391144305, 193, 1),
(18, 12, '', '', 'fdsfdfdf', 1391144311, 204, 1),
(19, 12, '', '', 'fdeeeff', 1391144319, 204, 1),
(20, 12, '', '', 'fsdfdsf', 1391144656, 204, 1),
(21, 12, '', '', 'fsdfdsf', 1391144662, 204, 1),
(22, 12, '', '', 'ffffff\n', 1391147822, 204, 1),
(23, 12, '', '', '33333', 1391148177, 204, 1),
(24, 12, '', '', '3323', 1391148186, 204, 1),
(25, 12, '', '', 'fdsfdsf', 1391148226, 204, 1),
(26, 12, '', '', 'dsfdfdsf', 1391148239, 204, 1),
(27, 12, '', '', 'fsdfdf', 1391148267, 204, 1),
(28, 37, '', '', 'fsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdf', 1391170897, 204, 1),
(29, 12, '', '', 'fdsf', 1391171028, 203, 1),
(30, 12, '', '', 'sdfdsfdsfd', 1391171035, 203, 1),
(31, 12, '', '', 'sdfdsfdsfdfsd', 1391171039, 203, 1),
(32, 12, '', '', 'sdfdsfdsfdfsd', 1391171043, 203, 1),
(33, 12, '', '', 'ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff', 1391171235, 203, 1),
(34, 12, '', '', 'ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdffafdsfdsf', 1391171243, 203, 1),
(35, 12, '', '', 'fdsf', 1391171611, 201, 1),
(36, 12, '', '', 'fdsf', 1391171615, 201, 1),
(37, 12, '', '', 'fdsf', 1391171618, 201, 1),
(38, 12, '', '', 'fdsf', 1391171621, 201, 1),
(46, 12, '', '', 'ok!', 1391305381, 214, 1),
(49, 12, '', '', 'dsfdsfdsf', 1391305444, 214, 1),
(50, 12, '', '', 'fsdfdsf', 1391357309, 204, 1),
(51, 12, '', '', 'fsdfdsf', 1391357309, 204, 1),
(52, 12, '', '', 'dsfsdfdf', 1391357403, 217, 1),
(53, 3, '', '', 'fsdf', 1391783936, 238, 1),
(75, 4, '', '', 'f323', 1392465667, 444, 1),
(76, 4, '', '', '133332', 1392465671, 444, 1),
(81, 4, '', '', 'fdsfdsf', 1392467259, 443, 1),
(82, 4, '', '', 'hdfdksjkf', 1392470445, 444, 1),
(83, 4, '', '', 'fdsfd', 1392470450, 444, 1),
(84, 4, '', '', 'fdsfdf', 1392470472, 444, 1),
(85, 4, '', '', 'dfsdffdf', 1392470500, 444, 1),
(86, 4, '', '', 'fdsfsf', 1392470504, 444, 1),
(87, 4, '', '', 'fsdfdf', 1392470507, 444, 1),
(88, 4, '', '', 'fdsfdf', 1392470511, 444, 1),
(89, 4, '', '', 'fdsfdf', 1392470538, 444, 1),
(90, 4, '', '', 'fffff', 1392470566, 444, 1),
(91, 4, '', '', '133223', 1392470571, 444, 1),
(92, 4, '', '', 'fffff', 1392470930, 444, 1),
(93, 4, '', '', 'fdfd', 1392473059, 444, 1),
(96, 4, '', '', 'fdsf', 1392478242, 444, 1),
(97, 4, '', '', 'fdsfdf', 1392552730, 450, 1),
(99, 4, '', '', 'fdsfdfdfffdsfdfdfffdsfdfdfffdsfdfdfffdsfdfdff', 1392552740, 450, 1),
(100, 4, '', '', 'fdsfdfdff', 1392552743, 450, 1),
(101, 4, '', '', 'fdsfdfdff', 1392552747, 450, 1),
(102, 4, '', '', 'fdfdsfdsf', 1392814646, 214, 1),
(103, 4, '', '', 'fdfdsf', 1392814650, 214, 1),
(104, 4, '', '', '32332', 1392814654, 214, 1),
(105, 4, '', '', 'fdsfdfdsf', 1392814658, 214, 1),
(106, 4, '', '', '122', 1392814662, 214, 1),
(107, 4, '', '', 'fdsfdsf', 1392814666, 214, 1),
(108, 4, '', '', '323333', 1392814670, 214, 1),
(109, 4, '', '', 'fdsfdf', 1392814674, 214, 1),
(111, 4, '', '', 'fdsf', 1393061431, 322, 1),
(112, NULL, 'fdsjfkj', '', 'fdsfdsf', 1395039713, 99, 1),
(113, NULL, 'jdkjf', 'djfkj@fd.com', 'fkdjkf', 1395039781, 99, 1),
(114, NULL, 'dsjfkjfk', 'dkfjk@fd.com', 'jdkfj@', 1395137667, 99, 1),
(115, NULL, 'ffff', 'dd@fd.d', 'fdsfd', 1395224097, 99, 0),
(116, NULL, 'jdkjf', 'fdkfj@fd.com', 'jfdkjf', 1395224154, 99, 0);

-- --------------------------------------------------------

--
-- Table structure for table `country`
--

CREATE TABLE `country` (
  `country_id` int(11) NOT NULL AUTO_INCREMENT,
  `country_name` varchar(45) DEFAULT NULL,
  `code` varchar(45) DEFAULT NULL,
  `i18n` varchar(45) DEFAULT NULL,
  `flag_icon` varchar(100) NOT NULL,
  PRIMARY KEY (`country_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=78 ;

--
-- Dumping data for table `country`
--

INSERT INTO `country` (`country_id`, `country_name`, `code`, `i18n`, `flag_icon`) VALUES
(1, 'South Africa', 'south africa', 'SOUTH_AFRICA', 'SOUTH_AFRICA'),
(2, 'Albania', 'albania', 'ALBANIA', 'ALBANIA'),
(3, 'Algeria', 'algeria', 'ALGERIA', 'ALGERIA'),
(4, 'Germany', 'germany', 'GERMANY', 'GERMANY'),
(5, 'Saudi', 'saudi', 'SAUDI', 'SAUDI'),
(6, 'Arabia', 'arabia', 'ARABIA', 'ARABIA'),
(7, 'Argentina', 'argentina', 'ARGENTINA', 'ARGENTINA'),
(8, 'Australia', 'australia', 'AUSTRALIA', 'AUSTRALIA'),
(9, 'Austria', 'austria', 'AUSTRIA', 'AUSTRIA'),
(10, 'Bahamas', 'bahamas', 'BAHAMAS', 'BAHAMAS'),
(11, 'Belgium', 'belgium', 'BELGIUM', 'BELGIUM'),
(12, 'Benin', 'benin', 'BENIN', 'BENIN'),
(13, 'Brazil', 'brazil', 'BRAZIL', 'BRAZIL'),
(14, 'Bulgaria', 'bulgaria', 'BULGARIA', 'BULGARIA'),
(15, 'Burkina Faso', 'burkina faso', 'BURKINA_FASO', 'BURKINA_FASO'),
(16, 'Canada', 'canada', 'CANADA', 'CANADA'),
(17, 'Chile', 'chile', 'CHILE', 'CHILE'),
(18, 'China', 'china', 'CHINA', 'CHINA'),
(19, 'Cyprus', 'cyprus', 'CYPRUS', 'CYPRUS'),
(20, 'Korea', 'korea', 'KOREA', 'KOREA'),
(21, 'Republic of Ivory Coast', 'republic of ivory coast', 'REPUBLIC_OF_IVORY_COAST', 'REPUBLIC_OF_IVORY_COAST'),
(22, 'Croatia', 'croatia', 'CROATIA', 'CROATIA'),
(23, 'Denmark', 'denmark', 'DENMARK', 'DENMARK'),
(24, 'Egypt', 'egypt', 'EGYPT', 'EGYPT'),
(25, 'United Arab Emirates', 'united arab emirates', 'UNITED_ARAB_EMIRATES', 'UNITED_ARAB_EMIRATES'),
(26, 'Spain', 'spain', 'SPAIN', 'SPAIN'),
(27, 'Estonia', 'estonia', 'ESTONIA', 'ESTONIA'),
(28, 'USA', 'usa', 'USA', 'USA'),
(29, 'Finland', 'finland', 'FINLAND', 'FINLAND'),
(30, 'France', 'france', 'FRANCE', 'FRANCE'),
(31, 'Georgia', 'georgia', 'GEORGIA', 'GEORGIA'),
(32, 'Ghana', 'ghana', 'GHANA', 'GHANA'),
(33, 'Greece', 'greece', 'GREECE', 'GREECE'),
(34, 'Guinea', 'guinea', 'GUINEA', 'GUINEA'),
(35, 'Equatorial Guinea', 'equatorial guinea', 'EQUATORIAL_GUINEA', 'EQUATORIAL_GUINEA'),
(36, 'Hungary', 'hungary', 'HUNGARY', 'HUNGARY'),
(37, 'India', 'india', 'INDIA', 'INDIA'),
(38, 'Ireland', 'ireland', 'IRELAND', 'IRELAND'),
(39, 'Italy', 'italy', 'ITALY', 'ITALY'),
(40, 'Japan', 'japan', 'JAPAN', 'JAPAN'),
(41, 'Jordan', 'jordan', 'JORDAN', 'JORDAN'),
(42, 'Latvia', 'latvia', 'LATVIA', 'LATVIA'),
(43, 'Lebanon', 'lebanon', 'LEBANON', 'LEBANON'),
(44, 'Lithuania', 'lithuania', 'LITHUANIA', 'LITHUANIA'),
(45, 'Luxembourg', 'luxembourg', 'LUXEMBOURG', 'LUXEMBOURG'),
(46, 'Macedonia', 'macedonia', 'MACEDONIA', 'MACEDONIA'),
(47, 'Madagascar', 'madagascar', 'MADAGASCAR', 'MADAGASCAR'),
(48, 'Morocco', 'morocco', 'MOROCCO', 'MOROCCO'),
(49, 'Mauritania', 'mauritania', 'MAURITANIA', 'MAURITANIA'),
(50, 'Mexico', 'mexico', 'MEXICO', 'MEXICO'),
(51, 'Moldova', 'moldova', 'MOLDOVA', 'MOLDOVA'),
(52, 'Republic of Montenegro', 'republic of montenegro', 'REPUBLIC_OF_MONTENEGRO', 'REPUBLIC_OF_MONTENEGRO'),
(53, 'Norway', 'norway', 'NORWAY', 'NORWAY'),
(54, 'New Caledonia', 'new caledonia', 'NEW_CALEDONIA', 'NEW_CALEDONIA'),
(55, 'Panama', 'panama', 'PANAMA', 'PANAMA'),
(56, 'Netherlands', 'netherlands', 'NETHERLANDS', 'NETHERLANDS'),
(57, 'Peru', 'peru', 'PERU', 'PERU'),
(58, 'Poland', 'poland', 'POLAND', 'POLAND'),
(59, 'Portugal', 'portugal', 'PORTUGAL', 'PORTUGAL'),
(60, 'Reunion', 'reunion', 'REUNION', 'REUNION'),
(61, 'Romania', 'romania', 'ROMANIA', 'ROMANIA'),
(62, 'UK', 'uk', 'UK', 'UK'),
(63, 'Russian Federation', 'russian federation', 'RUSSIAN_FEDERATION', 'RUSSIAN_FEDERATION'),
(64, 'Senegal', 'senegal', 'SENEGAL', 'SENEGAL'),
(65, 'Serbia', 'serbia', 'SERBIA', 'SERBIA'),
(66, 'Singapore', 'singapore', 'SINGAPORE', 'SINGAPORE'),
(67, 'Slovakia', 'slovakia', 'SLOVAKIA', 'SLOVAKIA'),
(68, 'Slovenia', 'slovenia', 'SLOVENIA', 'SLOVENIA'),
(69, 'Sweden', 'sweden', 'SWEDEN', 'SWEDEN'),
(70, 'Switzerland', 'switzerland', 'SWITZERLAND', 'SWITZERLAND'),
(71, 'Chad', 'chad', 'CHAD', 'CHAD'),
(72, 'Czech Republic', 'czech republic', 'CZECH_REPUBLIC', 'CZECH_REPUBLIC'),
(73, 'Tunisia', 'tunisia', 'TUNISIA', 'TUNISIA'),
(74, 'Turkey', 'turkey', 'TURKEY', 'TURKEY'),
(75, 'Ukraine', 'ukraine', 'UKRAINE', 'UKRAINE'),
(76, 'Uruguay', 'uruguay', 'URUGUAY', 'URUGUAY'),
(77, 'Vietnam', 'vietnam', 'VIETNAM', 'VIETNAM');

-- --------------------------------------------------------

--
-- Table structure for table `flag`
--

CREATE TABLE `flag` (
  `flag_id` int(15) NOT NULL AUTO_INCREMENT,
  `nid` int(11) DEFAULT '0',
  `uid` int(15) DEFAULT NULL,
  `datetime` int(11) DEFAULT NULL,
  `cid` int(11) DEFAULT '0',
  `comment_nid` int(11) DEFAULT '0',
  PRIMARY KEY (`flag_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=43 ;

--
-- Dumping data for table `flag`
--

INSERT INTO `flag` (`flag_id`, `nid`, `uid`, `datetime`, `cid`, `comment_nid`) VALUES
(18, 204, 12, 1391165802, 0, NULL),
(19, 214, 12, 1391266459, 0, NULL),
(20, 0, 12, 1391269647, 39, NULL),
(23, 0, 12, 1391270545, 18, 204),
(24, 0, 12, 1391270906, 19, 204),
(25, 0, 12, 1391272003, 21, 204),
(29, 0, 2, 1393079772, 18, 204),
(30, 0, 2, 1393079800, 110, 322),
(31, 0, 2, 1393080202, 114, 322),
(32, 306, 2, 1393080214, 0, 0),
(33, 0, 2, 1393081118, 110, 322),
(34, 306, 2, 1393081176, 0, 0),
(35, 0, 2, 1393081197, 114, 322),
(37, 0, 4, 1393081908, 110, 322),
(38, 0, 4, 1393082225, 111, 322),
(41, 0, 4, 1393082320, 114, 322),
(42, 322, 4, 1393429113, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `like`
--

CREATE TABLE `like` (
  `like_id` int(15) NOT NULL AUTO_INCREMENT,
  `nid` int(15) DEFAULT NULL,
  `uid` int(15) DEFAULT NULL,
  `datetime` int(15) DEFAULT NULL,
  PRIMARY KEY (`like_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=220 ;

--
-- Dumping data for table `like`
--

INSERT INTO `like` (`like_id`, `nid`, `uid`, `datetime`) VALUES
(17, 185, 12, 1389499316),
(18, 122, 12, 1389499469),
(42, 206, 12, 1391303401),
(88, 212, 12, 1391347310),
(89, 203, 12, 1391347392),
(90, 194, 12, 1391347429),
(91, 192, 12, 1391347447),
(94, 191, 12, 1391347579),
(95, 190, 12, 1391347610),
(97, 197, 12, 1391347915),
(98, 189, 12, 1391347935),
(99, 186, 12, 1391347965),
(100, 183, 12, 1391348024),
(101, 184, 12, 1391348120),
(102, 182, 12, 1391348218),
(103, 181, 12, 1391348252),
(104, 177, 12, 1391348337),
(105, 187, 12, 1391348385),
(106, 178, 12, 1391348590),
(107, 176, 12, 1391348621),
(108, 193, 12, 1391348647),
(117, 204, 12, 1391349070),
(118, 170, 12, 1391349246),
(119, 171, 12, 1391349346),
(120, 163, 12, 1391349373),
(123, 211, 12, 1391350129),
(124, 214, 12, 1391350192),
(149, 443, 4, 1392467256),
(154, 442, 4, 1392471562),
(155, 441, 4, 1392471601),
(160, 440, 4, 1392471981),
(162, 438, 4, 1392472053),
(166, 429, 4, 1392472227),
(207, 447, 4, 1392562597),
(208, 321, 4, 1392730838),
(209, 320, 4, 1393160460),
(210, 318, 4, 1393160468),
(211, 308, 4, 1393160572),
(212, 323, 4, 1393160890),
(213, 278, 4, 1393160914),
(214, 277, 4, 1393160933),
(215, 311, 4, 1393166381),
(217, 322, 4, 1393429201),
(218, 99, 1, 1395026365),
(219, 1, 1, 1395028680);

-- --------------------------------------------------------

--
-- Table structure for table `node`
--

CREATE TABLE `node` (
  `nid` int(15) NOT NULL AUTO_INCREMENT,
  `mid` varchar(255) NOT NULL,
  `uid` int(15) DEFAULT NULL,
  `screen_name` varchar(255) NOT NULL,
  `location` varchar(255) NOT NULL,
  `country_id` int(15) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=219 ;

--
-- Dumping data for table `node`
--

INSERT INTO `node` (`nid`, `mid`, `uid`, `screen_name`, `location`, `country_id`, `email`, `type`, `file`, `url`, `media`, `from`, `datetime`, `hashtag`, `description`, `status`, `reward`) VALUES
(1, '671693692806788719_17196948', NULL, 'marinemr', 'Paris, France', NULL, '', 'text', '/uploads/2014/3/8/1.jpg', '', 'instagram', '', 1394292149, NULL, 'Sunny Saturday at the agency #9263', 1, 1),
(2, '671614972297152779_465161729', NULL, 'remygendre', '', NULL, 'tony@fuel-it-up.com', 'video', '/uploads/2014/3/8/2.jpg', 'http://youtu.be/wHfsNXR1uus', 'instagram', 'youtube', 1394282765, NULL, 'Enfin, j''ai trouvé un petit souvenir a ramener de bisca #bisca #9263', 1, 1),
(3, '671556714860556435_149779', NULL, 'jalila', 'Tremblay-en-France, France', NULL, '', 'photo', '/uploads/2014/3/8/3.jpg', '', 'instagram', '', 1394275820, NULL, 'Boarding #9263', 1, 1),
(4, '671143084366191841_8641750', NULL, 'jimtran01', 'Paris, France', NULL, '', 'photo', '/uploads/2014/3/8/4.jpg', '', 'instagram', '', 1394226511, NULL, '#selfie w/ @halary #9263', 1, 1),
(5, '671065779919521486_47150384', NULL, 'lilianer', 'Paris, France', NULL, '', 'photo', '/uploads/2014/3/8/5.jpg', '', 'instagram', '', 1394217296, NULL, '#9263', 1, 0),
(6, '671011207939496592_8350645', NULL, '00liu', 'Shanghai, China', NULL, '', 'photo', '/uploads/2014/3/8/6.jpg', '', 'instagram', '', 1394210791, NULL, '@bautumn1101 24小時on call #9263', 1, 1),
(7, '671001563642124371_331681973', NULL, 'juliadurey', 'Paris, France', NULL, '', 'photo', '/uploads/2014/3/8/7.jpg', '', 'instagram', '', 1394209641, NULL, '❤️ #9263', 1, 0),
(8, '670971881946524475_10283241', NULL, 'alexandrarony', '', NULL, '', 'photo', '/uploads/2014/3/8/8.jpg', '', 'instagram', '', 1394206103, NULL, '#9263', 1, 0),
(9, '670971208861525272_16493368', NULL, 'cold_paradise', '', NULL, '', 'photo', '/uploads/2014/3/8/9.jpg', '', 'instagram', '', 1394206022, NULL, 'Dali nails #9263', 1, 0),
(10, '670969436340799733_813773889', NULL, 'bysardine', 'Paris, France', NULL, '', 'photo', '/uploads/2014/3/8/10.jpg', '', 'instagram', '', 1394205811, NULL, '#9263 #porc #cochon #margaux #love #cute #kawaii', 1, 0),
(11, '670924325297707849_600960629', NULL, 'whynotlinhvu', 'Shanghai, China', NULL, '', 'photo', '/uploads/2014/3/8/11.jpg', '', 'instagram', '', 1394200433, NULL, '#TGIF #dailyshanghai #9263', 1, 0),
(12, '670876732999802761_225395454', NULL, 'uzi_gunpowder18', '', NULL, '', 'photo', '/uploads/2014/3/8/12.jpg', '', 'instagram', '', 1394194760, NULL, '#9263', 1, 0),
(13, '670874183619782663_279712249', NULL, 'xiaotongding', '', NULL, '', 'photo', '/uploads/2014/3/8/13.jpg', '', 'instagram', '', 1394194456, NULL, '#9263# Mr and Mrs Bond', 1, 0),
(14, '670816259462050468_149779', NULL, 'jalila', 'Paris, France', NULL, '', 'photo', '/uploads/2014/3/8/14.jpg', '', 'instagram', '', 1394187551, NULL, 'Screens + @fredfarid #48Provence #9263', 1, 0),
(15, '670809600731781581_8350645', NULL, '00liu', 'Shanghai, China', NULL, '', 'photo', '/uploads/2014/3/8/15.jpg', '', 'instagram', '', 1394186757, NULL, '2 teenagers #9263 #milkana #cheese', 1, 0),
(16, '670808704794715000_32130471', NULL, 'nawal_', 'Paris, France', NULL, '', 'photo', '/uploads/2014/3/8/16.jpg', '', 'instagram', '', 1394186650, NULL, 'En Meeting avec @fredfaridparis et @manuferry chez @FredFaridGroup #FredFaridGroup #9263 #Paris #Shanghai', 1, 0),
(17, '670762978815078572_347189187', NULL, 'thibaudmuratyan', '', NULL, '', 'photo', '/uploads/2014/3/8/17.jpg', '', 'instagram', '', 1394181199, NULL, 'Henri Cartier-Bresson #CentrePompidou #Beaubourg #exhibition #HenriCartierBresson #9263', 1, 0),
(18, '670471951904380322_6187020', NULL, 'lorraine_', 'Paris, France', NULL, '', 'photo', '/uploads/2014/3/8/18.jpg', '', 'instagram', '', 1394146506, NULL, '#9263', 1, 0),
(19, '670466235772671250_6187020', NULL, 'lorraine_', 'Paris, France', NULL, '', 'photo', '/uploads/2014/3/8/19.jpg', '', 'instagram', '', 1394145825, NULL, '#9263', 1, 0),
(20, '670305712140120903_16500443', NULL, 'ray_against_the_machine', 'Paris, France', NULL, '', 'photo', '/uploads/2014/3/8/20.jpg', '', 'instagram', '', 1394126689, NULL, 'Back. #trip #ricoh #airport #9263', 1, 0),
(21, '670305561225113874_149779', NULL, 'jalila', 'Paris, France', NULL, '', 'photo', '/uploads/2014/3/8/21.jpg', '', 'instagram', '', 1394126671, NULL, 'La parisienne #9263', 1, 0),
(22, '670216547859741985_2504398', NULL, 'ladybancale', '', NULL, '', 'photo', '/uploads/2014/3/8/22.jpg', '', 'instagram', '', 1394116060, NULL, 'manque plus qu''Ellen Degeneres / Jared Leto / Brad Pitt / etc #9263 #FF #hellosunshine', 1, 0),
(23, '670151780866338823_336912187', NULL, 'joh_ananas', 'Paris 09, France', NULL, '', 'photo', '/uploads/2014/3/8/23.jpg', '', 'instagram', '', 1394108339, NULL, 'Salut gloglo Robert lunch part 2 #9263', 1, 0),
(24, '670125728483445411_465161729', NULL, 'remygendre', '', NULL, '', 'photo', '/uploads/2014/3/8/24.jpg', '', 'instagram', '', 1394105233, NULL, 'Good morning #9263 #bisca', 1, 0),
(25, '669651107385835315_26847942', NULL, 'monsieur_robs', 'Paris, France', NULL, '', 'photo', '/uploads/2014/3/8/25.jpg', '', 'instagram', '', 1394048654, NULL, NULL, 1, 0),
(26, '669577741259855158_271859948', NULL, 'chacourbon', '', NULL, '', 'photo', '/uploads/2014/3/8/26.jpg', '', 'instagram', '', 1394039908, NULL, 'Welcome @chamontrichard ! #9263', 1, 0),
(27, '669522594412466885_7110867', NULL, 'joiearfi', 'Paris, France', NULL, '', 'photo', '/uploads/2014/3/8/27.jpg', '', 'instagram', '', 1394033334, NULL, 'Le burger, star des projecteurs #shoot #burger #work #ff #9263', 1, 0),
(28, '669456381302157705_336912187', NULL, 'joh_ananas', 'Paris, France', NULL, '', 'photo', '/uploads/2014/3/8/28.jpg', '', 'instagram', '', 1394025441, NULL, 'Salut gloglo Robert lunch part 1 #9263', 1, 0),
(29, '669423687792549743_8641750', NULL, 'jimtran01', 'Paris, France', NULL, '', 'photo', '/uploads/2014/3/8/29.jpg', '', 'instagram', '', 1394021543, NULL, '#FFDIGITAL #lunch #9263 w/@cold_paradise @valentinm @baocontact @duduthenoz @bbzlevy poke @symca', 1, 0),
(30, '669382136543419670_15607662', NULL, 'marcbad', 'Paris, France', NULL, '', 'text', '/uploads/2014/3/8/30.jpg', '', 'instagram', '', 1394016590, NULL, 'ALL WE NEED IS LOVE #9263', 1, 0),
(31, '669380674184740209_17634798', NULL, 'la_bergere', 'Pierrefitte-sur-Seine, France', NULL, '', 'photo', '/uploads/2014/3/8/31.jpg', '', 'instagram', '', 1394016416, NULL, 'Besoin d''une trottinette, d''une gratte? Y''a de tout au métro Commerce #9263', 1, 0),
(32, '669377113656441935_2504398', NULL, 'ladybancale', '', NULL, '', 'photo', '/uploads/2014/3/8/32.jpg', '', 'instagram', '', 1394015991, NULL, 'Les détails font tout. #ff #9263', 1, 0),
(33, '669317544242598744_9260275', NULL, 'marcellaromaniewicz', 'Montévrain, France', NULL, '', 'photo', '/uploads/2014/3/8/33.jpg', '', 'instagram', '', 1394008890, NULL, 'LUZ . CAMERA . AÇÃO #9263 #thosewillbethebestmemories ', 1, 0),
(34, '442330248386863104', NULL, 'grougrou', '', NULL, '', 'photo', '/uploads/2014/3/8/34.jpg', '', 'twitter', '', 1394294723, NULL, 'RT @FredFarid: "On est devenus Chinois dans le business" via @FouziaKML from @CB_News #9263 http://t.co/sz9YYpbIUm', 1, 0),
(35, '442324820936884224', NULL, 'Diamond_9263', '', NULL, '', 'text', NULL, '', 'twitter', '', 1394293429, NULL, '@ArarShahed العمر كلو', 1, 0),
(36, '442320755867779072', NULL, '_hooodrich', 'Standing Alone', NULL, '', 'text', NULL, '', 'twitter', '', 1394292460, NULL, '@qaadie_ 267 970 9263', 1, 0),
(37, '442319452735307776', NULL, 'MarineMR', 'Paris', NULL, '', 'text', NULL, '', 'twitter', '', 1394292150, NULL, 'Sunny Saturday at the agency #9263 http://t.co/7RUGvORX4X', 1, 0),
(38, '442315860351279104', NULL, 'OrdengWarteg', 'Jakarta', NULL, '', 'text', NULL, '', 'twitter', '', 1394291293, NULL, '3 Aly Love Jennifer Natashia L ??? *9263', 1, 0),
(39, '442315563419701248', NULL, 'haine915', '', NULL, '', 'text', NULL, '', 'twitter', '', 1394291222, NULL, '@haine915 03/08-03/09 のふぁぼ数: 105 (9158 → 9263) \nhttp://t.co/KsH2EVJMNi #favcounter', 1, 0),
(40, '442310245201637376', NULL, 'ediponatan', 'Santa Cruz, RN', NULL, '', 'text', NULL, '', 'twitter', '', 1394289954, NULL, 'Garibaldi Filho defende pressa por parte do PMDB: http://t.co/1Z1j5Zdb5a', 1, 0),
(41, '442306258629296128', NULL, 'lebanonsports', '', NULL, '', 'text', NULL, '', 'twitter', '', 1394289004, NULL, 'German Bundesliga Hamburger SV vs Eintracht Frankfurt\nhttp://t.co/BopRika7zr', 1, 0),
(42, '442297409465368576', NULL, 'azizahmaulidyah', 'Smk mahardhika', NULL, '', 'text', NULL, '', 'twitter', '', 1394286894, NULL, 'Aly Love Jennifer Natashia L ??? *9263', 1, 0),
(43, '442276166758846464', NULL, 'cdmasnou', 'El Masnou, Maresme', NULL, '', 'text', NULL, '', 'twitter', '', 1394281829, NULL, 'No baixar el ritme contra el cuer. La prèvia del @cdmasnou-@UDAGramenet de demà (12:00) a http://t.co/kuBF76Acnb #futbolcat #3div5', 1, 0),
(44, '442270356812750848', NULL, 'X_VIDEOS_', '', NULL, '', 'text', NULL, '', 'twitter', '', 1394280444, NULL, '@null 9263', 1, 0),
(45, '442259500666736640', NULL, 'AssetouCouliB', '', NULL, '', 'text', NULL, '', 'twitter', '', 1394277856, NULL, '@karaking6 9263.. ?? a 2H stp', 1, 0),
(46, '442254071232475136', NULL, 'Jalila', 'Paris', NULL, '', 'photo', '/uploads/2014/3/8/46.jpg', '', 'twitter', '', 1394276561, NULL, '✈️ ', 1, 0),
(47, '442251711164338177', NULL, 'FredFarid', 'Paris+Shanghai', NULL, '', 'photo', '/uploads/2014/3/8/47.jpg', '', 'twitter', '', 1394275999, NULL, '#ChinaEastern flight from #Paris to #Shanghai w/ @Jalila #9263 http://t.co/xGv1FJSVz8', 1, 0),
(48, '442246689567809536', NULL, 'nsathostai', 'Волгоград', NULL, '', 'text', NULL, '', 'twitter', '', 1394274802, NULL, 'Понравилась статья, закинул себе в закладки http://t.co/3KnNAVQ648', 1, 0),
(49, '442229959806164992', NULL, 'Nantan_Satria', '28-10-2013 :* :*', NULL, '', 'text', NULL, '', 'twitter', '', 1394270813, NULL, 'Justin Bieber Nangis ? http://t.co/dXrCZbqfhM *9263', 1, 0),
(50, '442224532837789696', NULL, 'TwitLotto69923', '', NULL, '', 'text', NULL, '', 'twitter', '', 1394269519, NULL, '@Sxfwann_ You won an entry in our $10k/week sweeps (dead serious!). Click our shortlink &amp; use pw 9263 to redeem.', 1, 0),
(51, '442217559920631808', NULL, 'latifahltf23', 'Indonesia', NULL, '', 'text', NULL, '', 'twitter', '', 1394267856, NULL, '9263  http://t.co/0Hbh7E4ZK2 #KuzuraNet *594', 1, 0),
(52, '442217359634620416', NULL, 'SadieWarburg', 'Barrie ', NULL, '', 'text', NULL, '', 'twitter', '', 1394267809, NULL, 'DSC_9263_132880_Faye Wightman &amp; Joyce Murray http://t.co/h7C5Mi6bvM #Justin Trudeau #Trudeaumania', 1, 0),
(53, '442209143131488256', NULL, 'demibuxyquxo', '', NULL, '', 'text', NULL, '', 'twitter', '', 1394265850, NULL, 'Пуловер 2014 - 010480 http://t.co/rzW1urQUNh', 1, 0),
(54, '442185772221734912', NULL, 'hina_sibakuro', 'にちö君の後ろ', NULL, '', 'text', NULL, '', 'twitter', '', 1394260278, NULL, '絡んだことある人フレコ交換しませんかー！3969-4376-9263', 1, 0),
(55, '442179520175415297', NULL, 'thomasalix', 'Paris', NULL, '', 'photo', '/uploads/2014/3/8/55.jpg', '', 'twitter', '', 1394258787, NULL, 'RT @FredFarid: "On est devenus Chinois dans le business" via @FouziaKML from @CB_News #9263 http://t.co/sz9YYpbIUm', 1, 0),
(56, '442171539421933568', NULL, 'Mhollstein', 'Oceanside, California', NULL, '', 'text', NULL, '', 'twitter', '', 1394256884, NULL, 'RT @ceebee308: It was the perfect bank heist plan, except... - ''6 Hours 42 Minutes'' - Check it out on #BookBuzzr- http://t.co/0OVk665Xsr', 1, 0),
(57, '442171359222042624', NULL, 'HouseofTaboo', '', NULL, '', 'text', NULL, '', 'twitter', '', 1394256841, NULL, 'RT @ceebee308: It was the perfect bank heist plan, except... - ''6 Hours 42 Minutes'' - Check it out on #BookBuzzr- http://t.co/0OVk665Xsr', 1, 0),
(58, '442170831381483520', NULL, 'AuthorTBrooks', '', NULL, '', 'text', NULL, '', 'twitter', '', 1394256716, NULL, 'RT @ceebee308: It was the perfect bank heist plan, except... - ''6 Hours 42 Minutes'' - Check it out on #BookBuzzr- http://t.co/0OVk665Xsr', 1, 0),
(59, '442170649814261760', NULL, 'AuthorNicMorgan', 'mons circum purpura majestatem', NULL, '', 'text', NULL, '', 'twitter', '', 1394256672, NULL, 'RT @ceebee308: It was the perfect bank heist plan, except... - ''6 Hours 42 Minutes'' - Check it out on #BookBuzzr- http://t.co/0OVk665Xsr', 1, 0),
(60, '442170564552433664', NULL, 'paulregabooks', 'Gulf Coast of Florida ', NULL, '', 'text', NULL, '', 'twitter', '', 1394256652, NULL, 'RT @ceebee308: It was the perfect bank heist plan, except... - ''6 Hours 42 Minutes'' - Check it out on #BookBuzzr- http://t.co/0OVk665Xsr', 1, 0),
(61, '442170354149380098', NULL, 'ceebee308', 'Montreal, Canada', NULL, '', 'text', NULL, '', 'twitter', '', 1394256602, NULL, 'It was the perfect bank heist plan, except... - ''6 Hours 42 Minutes'' - Check it out on #BookBuzzr- http://t.co/0OVk665Xsr', 1, 0),
(62, '442159197711785984', NULL, 'adamgershon', 'The Valley', NULL, '', 'text', NULL, '', 'twitter', '', 1394253942, NULL, 'Helped nearby drivers by reporting a visible police trap on I-5 N, Lebec on @waze - Drive Social. http://t.co/OZFBMeLYcV', 1, 0),
(63, '442148200225312768', NULL, 'FredFarid', 'Paris+Shanghai', NULL, '', 'photo', '/uploads/2014/3/8/63.jpg', '', 'twitter', '', 1394251320, NULL, '"On est devenus Chinois dans le business" via @FouziaKML from @CB_News #9263 http://t.co/sz9YYpbIUm', 1, 0),
(64, '442143356588552192', NULL, 'FredFarid', 'Paris+Shanghai', NULL, '', 'photo', '/uploads/2014/3/8/64.jpg', '', 'twitter', '', 1394250165, NULL, 'Late night w/ my little sister Clemence and Marie @theopaulgab #9263 http://t.co/Ad2RupHMd1', 1, 0),
(65, '442138961004077057', NULL, 'Emilangeles_05', 'яєρυвι¢α ∂σмιηι¢αηα ', NULL, '', 'text', NULL, '', 'twitter', '', 1394249117, NULL, 'Free 1000 followers    http://t.co/8CIbkVwPK3  9263    Justin Bieber Nyengir #ServetİsteyenSiyasetiBıraksın', 1, 0),
(66, '442134464852811776', NULL, 'X_VIDEOS_', '', NULL, '', 'text', NULL, '', 'twitter', '', 1394248045, NULL, '@null 9263', 1, 0),
(67, '445166016675328001', NULL, 'FredFarid', 'Paris+Shanghai', NULL, '', 'photo', '/uploads/2014/3/16/67.jpg', '', 'twitter', '', 1394970823, NULL, 'I''d love to live............. here.... one day.... #Ouessant island #Brittany #France #9263 http://t.co/KxfnTrpVVJ', 0, 0),
(68, '445160091210489856', NULL, 'TwitWin81827', '', NULL, 'tony@fuel-it-up.com', 'text', NULL, '', 'twitter', '', 1394969411, NULL, '@TheRedDevilGuy U landed 1 ticket into our 10 thou/week sweepstakes (I kid u not!). Visit our shortlink &amp; use pass 9263 2 redeem.', 0, 1),
(69, '445159589391368192', NULL, 'McCharmLana', 'france', NULL, '', 'text', NULL, '', 'twitter', '', 1394969291, NULL, '@LanaParrilla @ginnygoodwin I love this pic of Marilyn Monroe, 1953. Photograph by Alfred Eisenstaedt. http://t.co/mSpO4zDWUQ', 0, 1),
(70, '445156282669236224', NULL, 'apocanow_it', 'Italia', NULL, '', 'text', NULL, '', 'twitter', '', 1394968503, NULL, 'Surgeon Simulator Ios Video Recensione : http://t.co/Oq6VxzsDjS', 0, 1),
(71, '445149610643042304', NULL, 'Diamond_9263', '', NULL, '', 'text', NULL, '', 'twitter', '', 1394966912, NULL, '@mirnahisham5 ميرنا صووتك رااائع', 0, 0),
(72, '445148555431653377', NULL, 'Diamond_9263', '', NULL, '', 'text', NULL, '', 'twitter', '', 1394966660, NULL, '@mirnahisham5 اوكي', 0, 0),
(73, '445148390385799168', NULL, 'Diamond_9263', '', NULL, '', 'text', NULL, '', 'twitter', '', 1394966621, NULL, '@ArarShahed احنا تمام وانتي؟؟؟؟ والله اشتقتلك كتيييييييييييير ....', 0, 0),
(74, '445146406538326016', NULL, 'PrizeFun15235', '', NULL, '', 'text', NULL, '', 'twitter', '', 1394966148, NULL, 'Your pass is 9263. @IM_SabakuGaara U won 1 spot in our 10 thou/wk. contest (for real!). Visit our shortlink to claim.', 0, 1),
(75, '445145322239836160', NULL, 'Leota_9263', '', NULL, '', 'video', '/uploads/2014/3/16/75.jpg', 'http://youtu.be/wHfsNXR1uus', 'twitter', 'youtube', 1294965889, NULL, 'RT @iamrawl: Psychic Christopher Golden tells Hilary Duff Enough is Enough:  http://t.co/myfJ9qZ9yy', 1, 0),
(76, '445139251676864512', NULL, 'MarkKrukenberg', '', NULL, '', 'text', NULL, '', 'twitter', '', 1394964442, NULL, 'http://t.co/cXt5xx5iup Игра монстр хай ролер мейс на компьютер', 0, 0),
(77, '445138747425054720', NULL, 'achraf_kimiya', 'MAROC', NULL, '', 'text', NULL, '', 'twitter', '', 1394964322, NULL, 'الااهم لكل I have 7395 the same time as a new one of my favorite is not http://t.co/Du7Ng34qKo\n9263', 0, 0),
(78, '445138470529695744', NULL, 'TweetSweep60310', '', NULL, '', 'text', NULL, '', 'twitter', '', 1394964256, NULL, '@chubbynahnah Your pass: 9263. U earned a ticket in our $10,000/wk. sweeps (not a joke!). Click on our shortlink to redeem.', 0, 0),
(79, '445135407005843456', NULL, 'Laurentius66', 'Amsterdam.', NULL, '', 'text', NULL, '', 'twitter', '', 1394963525, NULL, 'RT @bomengidsnl: zuurbes doet aan abortus http://t.co/6aQ6bNKMzO', 0, 0),
(80, '445133662934556672', NULL, 'bomengidsnl', 'Nijmegen', NULL, '', 'text', NULL, '', 'twitter', '', 1394963110, NULL, 'zuurbes doet aan abortus http://t.co/6aQ6bNKMzO', 0, 0),
(81, '445131883400400896', NULL, 'toriheapes2k1', '', NULL, '', 'text', NULL, '', 'twitter', '', 1394962685, NULL, '@Beyonce I love you so much I know don''t be on this but I love you with all my heart if I see you in person I would be carted of follow 9263', 0, 0),
(82, '445126016017899520', NULL, 'alialajmi2012', '', NULL, '', 'text', NULL, '', 'twitter', '', 1394961286, NULL, 'لعبة ​منوبولي نسخه سعوديه .. عجيبه !! . صوره http://t.co/zI79R6D2Bd', 0, 0),
(83, '445125256551075840', NULL, 'irunka', 'Ukraine, Ternopil', NULL, '', 'text', NULL, '', 'twitter', '', 1394961105, NULL, 'http://t.co/wAhoeK9xwE Скачать недфорспид онлайн андеграунд 2', 0, 0),
(84, '445124170850902016', NULL, 'X_VIDEOS_', '', NULL, '', 'text', NULL, '', 'twitter', '', 1394960847, NULL, '@null 9263', 0, 0),
(85, '445121536882929664', NULL, 'PrizeCrazy73598', '', NULL, '', 'text', NULL, '', 'twitter', '', 1394960219, NULL, '@jackhourigan1 Your pw: 9263. You landed a ticket in our 10 thou/wk. sweeps (for real!). Click on our linky to claim.', 0, 0),
(86, '445117998043791360', NULL, 'gardelemoral29', 'france Quimper', NULL, '', 'photo', '/uploads/2014/3/16/86.jpg', '', 'twitter', '', 1394959375, NULL, 'RT @arielSTRABONI: Sublime ! "@FredFarid: 360° #Ouessant island #Brittany #France #9263 http://t.co/lIk8eOOnP5" via @zoeclips', 0, 0),
(87, '445117394982141952', NULL, 'Prizetopia08750', '', NULL, '', 'text', NULL, '', 'twitter', '', 1394959231, NULL, 'Ur pass: 9263. @_SimplyDae U landed 1 spot in our 10 grand/week sweeps (no joke!). Click our link 2 claim.', 0, 0),
(88, '445115612373991424', NULL, 'arielSTRABONI', '', NULL, '', 'photo', '/uploads/2014/3/16/88.jpg', '', 'twitter', '', 1394958806, NULL, 'Sublime ! "@FredFarid: 360° #Ouessant island #Brittany #France #9263 http://t.co/lIk8eOOnP5" via @zoeclips', 0, 0),
(89, '445115307192221697', NULL, 'zoeclips', '', NULL, '', 'photo', '/uploads/2014/3/16/89.jpg', '', 'twitter', '', 1394958733, NULL, 'RT @FredFarid: 360° #Ouessant island #Brittany #France #9263 http://t.co/zFU8mi9KV2', 0, 0),
(90, '445115221045444608', NULL, 'zoeclips', '', NULL, '', 'photo', '/uploads/2014/3/16/90.jpg', '', 'twitter', '', 1394958713, NULL, 'RT @FredFarid: 360° #Ouessant island #Brittany #France #9263 http://t.co/hUZpn4NDA5', 0, 0),
(91, '445115153764597760', NULL, 'zoeclips', '', NULL, '', 'photo', '/uploads/2014/3/16/91.jpg', '', 'twitter', '', 1394958697, NULL, 'RT @FredFarid: 360° #Ouessant island #Brittany #France #9263 http://t.co/QZdcJAzNyT', 0, 0),
(92, '445106688446570496', NULL, 'TweetSweep16257', '', NULL, '', 'text', NULL, '', 'twitter', '', 1394956678, NULL, 'You landed 1 spot to our 10 grand/week contest @godblessIuke (for real!). Go 2 our shortlink and use pass 9263 to claim.', 0, 0),
(93, '445103668179001344', NULL, 'Shevoness', 'Guarujá,SP', NULL, '', 'text', NULL, '', 'twitter', '', 1394955958, NULL, '@larysck add ai\nja to indo dormir 013 9 9756 9263', 0, 0),
(94, '445100771026419712', NULL, 'Annelfs', 'Paris, France ', NULL, '', 'photo', '/uploads/2014/3/16/94.jpg', '', 'twitter', '', 1394955268, NULL, 'RT @FredFarid: #Ouessant island #Brittany #France #9263 http://t.co/YB9ZFg9kPT', 0, 0),
(95, '445100271463440384', NULL, 'TeenPornVids', '', NULL, '', 'text', NULL, '', 'twitter', '', 1394955148, NULL, '555 http://t.co/To5NEMglmI #teen #porn #video #xxx #pussy #sex #free', 0, 0),
(96, '445092129459535872', NULL, 'SophiaTwatters_', 'TX', NULL, '', 'text', NULL, '', 'twitter', '', 1394953207, NULL, 'https://t.co/Jxju8RRa2u', 0, 0),
(97, '445089620645404672', NULL, 'Funny_Fog', '', NULL, '', 'text', NULL, '', 'twitter', '', 1394952609, NULL, 'Notre coup de coeur de la semaine : "Marry Me" de @ElvisDiFazio ! http://t.co/Yn7QOvy1lQ #Love #SameLove #LGBT #Egalite #Tolerance', 0, 0),
(98, '445080498218364928', NULL, 'tonyguerra2', ' mexico,d.f.', NULL, '', 'text', NULL, '', 'twitter', '', 1394950434, NULL, 'RT @SueltaLaSopaTV: ¿ @thalia podría regresar a la novelas? Entérense de TODOS lo DETALLES aquí --&gt; http://t.co/uSnWL9d4um', 0, 0),
(99, '445079374111727616', NULL, 'doallll', '', NULL, '', 'photo', '/uploads/2014/3/16/99.jpg', '', 'twitter', '', 1394950166, NULL, 'RT @yarinhaber: New York''ta Tayyip için "Wanted" afişleri - http://t.co/mqM9SIQhUv #katiltayyip http://t.co/JzfdzOX0Nb', 1, 0),
(100, '445078075228033024', NULL, 'JasminnePillman', 'Disneylandia ', NULL, '', 'text', NULL, '', 'twitter', '', 1394949856, NULL, 'Voto por #NoSabesNadaDelAmor #NicolePillman @RadioCorazonPe y #TopChartEnEspañol @manuelinares\n#NicolePillmanLOVGenPrimeraFila \n9263', 0, 0),
(101, '445065550058622976', NULL, 'RicKiansCloud', '', NULL, '', 'text', NULL, '', 'twitter', '', 1394946870, NULL, '#trevorsapplejuice OMG PLEASE BE MY 2/6 @TrevorMoran !!! LOVE YOU SO MUCH &lt;3 &lt;3  IT WOULD MEAN THE WORLD!!! &lt;3  9263', 0, 0),
(102, '445061788233924608', NULL, 'BebopArt', 'New Jersey', NULL, '', 'text', NULL, '', 'twitter', '', 1394945973, NULL, '9263:http://t.co/Q3SSOqOTX5 #wisewords The one who would be constant in happiness must frequently change.', 1, 0),
(103, '445059842261409792', NULL, 'MeluSuarez8', 'Corriendo unacarrera sin final', NULL, '', 'text', NULL, '', 'twitter', '', 1394945509, NULL, 'RT @Mar_Amacoria: Jajajajajjaj melina es una testigo que podria haberme visto con 9263 pibes pero solo me vio con patricio', 1, 0),
(104, '780216169_10152289469526170', NULL, 'Tony Zhu', '', NULL, 'tonysh518@gmail.com', 'photo', '/uploads/2014/3/20/104.jpg', '', 'facebook', '', 1395290026, NULL, '#HASHTAGTEST dfdsf', 0, 0),
(105, '780216169_10152289469526170', NULL, 'Tony Zhu', '', NULL, 'tonysh518@gmail.com', 'photo', '/uploads/2014/3/20/105.jpg', '', 'facebook', '', 1395290100, NULL, '#HASHTAGTEST fdsfdsf', 0, 1),
(106, '780216169_10152289469526170', NULL, 'Tony Zhu', '', NULL, 'tonysh518@gmail.com', 'photo', '/uploads/2014/3/20/106.jpg', '', 'facebook', '', 1395290169, NULL, '#HASHTAGTEST go test!', 0, 1),
(107, '780216169_10152289477131170', NULL, 'Tony Zhu', '', NULL, 'tonysh518@gmail.com', 'text', NULL, '', 'facebook', '', 1395290221, NULL, '#HASHTAGTEST fffff', 0, 0),
(108, '780216169_10152289489436170', NULL, 'Tony Zhu', '', NULL, 'tonysh518@gmail.com', 'text', NULL, '', 'facebook', '', 1395291228, NULL, '#HASHTAGTEST fdsfdf', 0, 0),
(109, '780216169_10152289491296170', NULL, 'Tony Zhu', '', NULL, 'tonysh518@gmail.com', 'text', NULL, '', 'facebook', '', 1395291323, NULL, '#HASHTAGTEST fdsf', 0, 0),
(110, '780216169_10152289469526170', NULL, 'Tony Zhu', '', NULL, 'tonysh518@gmail.com', 'photo', '/uploads/2014/3/20/110.jpg', '', 'facebook', '', 1395291352, NULL, '#HASHTAGTEST fdsf', 0, 0),
(111, '446585222226669568', NULL, 'likewanjeon', '', NULL, '', 'video', '/uploads/2014/3/20/111.jpg', 'http://youtu.be/xDMLANstgGI', 'twitter', 'youtube', 1395309188, NULL, 'RT @SMTOWNGLOBAL: Check out the new video of @smrookies WENDY.\nhttp://t.co/W0q1viOQzw', 1, 0),
(112, '446585222218260480', NULL, 'analxxxfans', '', NULL, '', 'text', NULL, '', 'twitter', '', 1395309188, NULL, 'hot Teen whore Takes It In The Ass http://t.co/hf7eYfiQ5u #free #tube #sex #porn #video #lol', 0, 0),
(113, '446585221966598144', NULL, 'EelcoDeBoer', 'Amsterdam, Holland', NULL, '', 'video', '/uploads/2014/3/20/113.jpg', 'http://youtu.be/DDm-ftThobM', 'twitter', 'youtube', 1395309188, NULL, 'Nieuwe video: "Hoe Word Ik Meer Gevraagd als Artiest" http://t.co/FtNmOZdZJw', 1, 0),
(114, '446585221870125056', NULL, 'mrseltrk', 'Ankara', NULL, '', 'text', NULL, '', 'twitter', '', 1395309188, NULL, 'RT @n_ygt: İbretlik!!! Latif Erdoğan''ı öz ağabeyi yalanladı! http://t.co/tY7suZPuhX', 0, 0),
(115, '446585221589512192', NULL, 'AlcidesR10', 'Panama', NULL, '', 'text', NULL, '', 'twitter', '', 1395309188, NULL, 'RT @DannyVHH: New Video: 50 Cent - Hold On | http://t.co/ao8zI066SG', 0, 0),
(116, '446585221514002433', NULL, 'chedadsp', '', NULL, '', 'text', NULL, '', 'twitter', '', 1395309188, NULL, 'RT @xmos: Video: Getting Started with XMOS startKIT, in Webinars, Training and Events Videos http://t.co/bix3xv8LWT Via @element14', 0, 0),
(117, '446585221425930240', NULL, 'VICOTVS', 'Nigeria / Italy ', NULL, '', 'video', '/uploads/2014/3/20/117.jpg', 'http://youtu.be/yfEJC4wo8Bw?a', 'twitter', 'youtube', 1395309188, NULL, 'RT @PCBEAgyeman: I liked a @YouTube video from @vicotvs http://t.co/droORs3v1E VIC.O - I wanna love you (video)', 1, 0),
(118, '446585221014487040', NULL, 'Biancuuuuuuuh', 'Sfoa kiddo ✌', NULL, '', 'text', NULL, '', 'twitter', '', 1395309188, NULL, '@Aaaaaps i dont like to play video games e sorry haha', 0, 0),
(119, '446585220964564992', NULL, 'BreannefvPicker', '', NULL, '', 'text', NULL, '', 'twitter', '', 1395309188, NULL, 'is an upcoming firstperson shooter video game developed bySplash Damage set to release in Fall 201', 0, 0),
(120, '446585220796387328', NULL, 'sara6ixy', 'New york', NULL, '', 'text', NULL, '', 'twitter', '', 1395309188, NULL, 'OFFICE STUD FUCKS CURVY MILF BOSS LEXXXI LOCKHART http://t.co/LsPd3B1kZF #movie #music #ass #lol #video', 0, 0),
(121, '446585220569890816', NULL, 'EghaCellz', 'Cilegon - Banten', NULL, '', 'text', NULL, '', 'twitter', '', 1395309188, NULL, 'Kylie Minogue Pamer Lekuk Tubuh Indah di Video Klip Baru: Kylie Minogue selalu konsisten untuk tampil sensual ... http://t.co/SrgXHT1DoS', 0, 0),
(122, '446585220397944832', NULL, 'CoKetah_', '', NULL, '', 'text', NULL, '', 'twitter', '', 1395309188, NULL, '#Coketah_ F1 Engine Noise Debate: Viral Video Shows Difference Between 2013 and 2014 Cars: F1 supremo Bernie E... http://t.co/bN1d66OHLP', 0, 0),
(123, '446585220301484032', NULL, 'hotchoco0404', '', NULL, '', 'video', '/uploads/2014/3/20/123.jpg', 'http://www.youtube.com/watch?v=st9zZ9X6sZo&feature=youtu.be', 'twitter', 'youtube', 1395309188, NULL, 'Super Junior-M_SWING_Music Video Teaser 2 http://t.co/oGBaToVbhC', 1, 0),
(124, '446585219689086976', NULL, 'johnhatejohn', '209', NULL, '', 'video', '/uploads/2014/3/20/124.jpg', 'http://youtu.be/hsxyHVUd1zA', 'twitter', 'youtube', 1395309188, NULL, 'RT @xPerionx1911: NASTY - SLAVES TO THE RICH (Official Music Video): http://t.co/KvTZY46cUh', 1, 0),
(125, '446585219240689664', NULL, 'WeAreIndiePromo', 'Nashville, TN', NULL, '', 'text', NULL, '', 'twitter', '', 1395309188, NULL, 'Indie Promo Tip #46 from @clgmusicmedia: Ask fans to create their own YouTube video using one of your songs. Award prize for "Best Video"', 0, 0),
(126, '446585218565410816', NULL, 'fnorie01', 'DMV,WV,Bmore,El Paso,Juarez', NULL, '', 'photo', '/uploads/2014/3/20/126.jpg', '', 'twitter', '', 1395309187, NULL, 'RT @espnmx: Todos muy amigables antes del clásico tapatío. http://t.co/mxgVizx6ff http://t.co/9OPvzdwhs6', 1, 0),
(127, '446585218502508544', NULL, 'Rodrigo_Himitsu', 'Maricá', NULL, '', 'video', '/uploads/2014/3/20/127.jpg', 'http://youtu.be/2XkV6IpV2Y0?aThe', 'twitter', 'youtube', 1395309187, NULL, 'Gostei de um vídeo @YouTube http://t.co/hubCCdjVCk History and Future of Everything -- Time', 1, 0),
(128, '446585218049118208', NULL, 'msebastianco', 'Tampa', NULL, '', 'text', NULL, '', 'twitter', '', 1395309187, NULL, 'RT @TARGIT: Missed #Microsoft #CONV14 a few weeks ago? You can still get in on the excitement:  http://t.co/IAODFtrdQs //@MSFTDynamics', 0, 0),
(129, '446585217089019904', NULL, '69sexpostion', 'New york', NULL, '', 'text', NULL, '', 'twitter', '', 1395309187, NULL, 'xxx film : whore babes playing with dudes in dorm room &amp; getting naked http://t.co/TRHX1j2Rqh #free #tits #sexy #boobs #android', 0, 0),
(130, '446585216992153600', NULL, 'yureomo', '', NULL, '', 'text', NULL, '', 'twitter', '', 1395309187, NULL, 'FC2動画:眠れない夜を抱いて　1992 http://t.co/MVGhEDznMH #sougofollow #ZARD #相互フォロー #sougofollow', 0, 0),
(131, '446585216987975680', NULL, 'alia101tricia', '', NULL, '', 'text', NULL, '', 'twitter', '', 1395309187, NULL, 'RT @Thegooglefactz: If you want to download a Youtube video, simply add "ss" to the URL between www. and Youtube!', 0, 0),
(132, '446585216904478720', NULL, 'IrishGirlGuides', 'Ireland', NULL, '', 'video', '/uploads/2014/3/20/132.jpg', 'http://www.youtube.com/watch?v=wxcDxgu8k9k', 'twitter', 'youtube', 1395309187, NULL, 'Brownies'' #happyday video to celebrate International Happiness Day with @UN and @Pharrell \nhttp://t.co/KOL3b11Nwv', 1, 0),
(133, '446585216652820480', NULL, 'sthayfan', '', NULL, '', 'video', '/uploads/2014/3/20/133.jpg', 'http://youtu.be/d3fuD8Sg1nE?a', 'twitter', 'youtube', 1395309187, NULL, 'I liked a @YouTube video http://t.co/ESvDfXH5do อื้อ อ๊ะ [ชานแบค]', 1, 0),
(134, '446585216598278145', NULL, 'mercesas', '', NULL, '', 'text', NULL, '', 'twitter', '', 1395309187, NULL, 'RT Ens el mirarem @AjSantBoi: El vídeo de la Jornada #mediaciosalutmental d''avui, pròximament al Canal Ajuntament http://t.co/nKTj51b81n', 0, 0),
(135, '446585216510218240', NULL, 'marmenoller', '', NULL, '', 'text', NULL, '', 'twitter', '', 1395309187, NULL, 'RT @mcolmenerro: No te pierdas este video  \n\nhttp://t.co/MNWMtlTWDM', 0, 0),
(136, '446585215826141184', NULL, 'DeDae', 'เป็นหน้าผากของยุนอา', NULL, '', 'video', '/uploads/2014/3/20/136.jpg', 'http://www.youtube.com/watch?v=w-_rU7HBwp0&sns=tw', 'twitter', 'youtube', 1395309187, NULL, 'RT @YoonTaeNy1: [VIDEO] 140320 SNSD - Wide Entertainment News 2 http://t.co/W7U9rujtdy', 0, 0),
(137, '446585215503572992', NULL, 'Itzmolly22', 'Warsop', NULL, '', 'photo', '/uploads/2014/3/20/137.jpg', '', 'twitter', '', 1395309187, NULL, 'RT @TheVampsCon: Fin doing his famous moves in his music video ''The Finbine Harvester'' @findonttweet http://t.co/TANhnuxlJo', 0, 0),
(138, '446585215297679360', NULL, 'xxshakhairxx', 'lion city', NULL, '', 'photo', '/uploads/2014/3/20/138.jpg', '', 'twitter', '', 1395309187, NULL, 'RT @FCBarcelona: VIDEO - Goals scored at the Bernabéu: Piqué''s 2-6 in 2009 http://t.co/R5fROkb0YP http://t.co/nytNUr3lbL', 0, 0),
(139, '446585214845067264', NULL, 'Nelly_Nel400', 'Baltimore,Maryland', NULL, '', 'text', NULL, '', 'twitter', '', 1395309187, NULL, '**New Exclusive Video @DboiDaDome ft KG West East Party view here Now http://t.co/NbcwjjfQSt 4$ure4life', 0, 0),
(140, '446585214509543424', NULL, 'MinxMinx20', 'Bristol', NULL, '', 'text', NULL, '', 'twitter', '', 1395309186, NULL, '@CORTEZ_HSP luv the murda ave release party video :) xx luv ya', 0, 0),
(141, '446585213787721728', NULL, 'rafiqirfs', 'Bekasi', NULL, '', 'photo', '/uploads/2014/3/20/141.jpg', '', 'twitter', '', 1395309186, NULL, 'RT @FCBarcelona: VIDEO - Goals scored at the Bernabéu: Piqué''s 2-6 in 2009 http://t.co/R5fROkb0YP http://t.co/nytNUr3lbL', 0, 0),
(142, '446585213783515136', NULL, 'QuecFormazione', 'Lucca', NULL, '', 'text', NULL, '', 'twitter', '', 1395309186, NULL, 'VIVIANI: Il cellulare fa male? - Video Mediaset http://t.co/9YMDKZZIsO #videomediaset', 0, 0),
(143, '446585213531873280', NULL, '_jennQuen', 'Iloilo City, Philippines', NULL, '', 'text', NULL, '', 'twitter', '', 1395309186, NULL, '#myxmusicawards Favorite Guest Appearance In A Music Video Enrique', 0, 0),
(144, '446585213460967426', NULL, 'AYullianty', 'SMK Negeri 27 Jakarta Pusat ', NULL, '', 'video', '/uploads/2014/3/20/144.jpg', 'http://youtu.be/xDMLANstgGI?a', 'twitter', 'youtube', 1395309186, NULL, 'I liked a @YouTube video http://t.co/U4YicOdD3U Wendy 웬디 of SMROOKIES_슬픔 속에 그댈 지워야만 해 (From Mnet Drama', 0, 0),
(145, '446585213444186113', NULL, 'G4sure', '', NULL, '', 'text', NULL, '', 'twitter', '', 1395309186, NULL, '**New Exclusive Video @DboiDaDome ft KG West East Party view here Now http://t.co/8zLhOnyvbo 4$ure4life', 0, 0),
(146, '446585213187928065', NULL, 'VenuSpeak', 'Ballygunge , Kolkata', NULL, '', 'video', '/uploads/2014/3/20/146.jpg', 'http://youtu.be/G7xiTWyjGEI?a', 'twitter', 'youtube', 1395309186, NULL, 'I liked a @YouTube video http://t.co/TPDNzLVbh0 TERI KHAATIR HAI SAARI ZINDAGI by Poonam Damani', 1, 0),
(147, '446585213087662080', NULL, 'adrianaxxxsage', '', NULL, '', 'text', NULL, '', 'twitter', '', 1395309186, NULL, 'sex video : Hot Bonde Kali has her First Squirting Orgasm #free #tits #sexy #boobs #android http://t.co/Vq36lerkVF', 0, 0),
(148, '446585213078880258', NULL, 'tahryin', 'RGN', NULL, '', 'video', '/uploads/2014/3/20/148.jpg', 'http://youtu.be/CplDcFmUqJY', 'twitter', 'youtube', 1395309186, NULL, 'RT @StayfanyTH: Girls'' Generation - Behind The Scenes of Mr. Mr. Music Video: http://t.co/nlX4MdoKgr via @YouTube', 1, 0),
(149, '446585212592328704', NULL, 'taraswelevingne', 'sumwer duwn da rud', NULL, '', 'photo', '/uploads/2014/3/20/149.jpg', '', 'twitter', '', 1395309186, NULL, 'BUT THE FACT THAT THIS GIVES ME SPEAK NOW ERA FEELS...\n\nthe story of us music video ASDFGHKL http://t.co/l9bQGBqlui', 1, 0),
(150, '446585212416172032', NULL, 'Jerrodjvq44546', 'Indonesia', NULL, '', 'video', '/uploads/2014/3/20/150.jpg', 'https://www.youtube.com/watch?v=AwJPGi7rKPM', 'twitter', 'youtube', 1395309186, NULL, 'Yuk @aisyahhajsak lihat VIDEO #RabuPagiBagasDifa Uang Ajaib #3\nhttps://t.co/7C0LtfTiNe *91\n\n&gt; @bagasdifareal', 1, 0),
(151, '678825246761234894_43874427', NULL, '_soloma_', 'Ryazan, Russia', NULL, '', 'photo', '/uploads/2014/3/20/151.jpg', '', 'instagram', '', 1395142297, NULL, '', 0, 0),
(152, '677289502779453445_43874427', NULL, '_soloma_', ', Russia', NULL, '', 'photo', '/uploads/2014/3/20/152.jpg', '', 'instagram', '', 1394959222, NULL, 'ребята', 0, 0),
(153, '639678464349440203_286370257', NULL, 'jme_cook', '', NULL, '', 'photo', '/uploads/2014/3/20/153.jpg', '', 'instagram', '', 1390475636, NULL, 'White bits!!! ', 0, 0),
(154, '675027224386417413_43874427', NULL, '_soloma_', 'Ryazan, Russia', NULL, '', 'photo', '/uploads/2014/3/20/154.jpg', '', 'instagram', '', 1394689537, NULL, 'Nigga we made it #napoher #party #russia', 0, 0),
(155, '680226307787076899_381225396', NULL, 'bader_alalwi', '', NULL, '', 'video', '/uploads/2014/3/20/155.jpg', 'http://distilleryimage9.s3.amazonaws.com/0872751ab01511e39d620e434dd2f639_101.mp4', 'instagram', 'instagram', 1395309316, NULL, '#وضعنا #حاليا بال#دوام\n\n#رقصة #الخميس', 1, 0),
(156, '675321353175681548_327039465', NULL, 'bernakya', '', NULL, '', 'photo', '/uploads/2014/3/20/156.jpg', '', 'instagram', '', 1394724600, NULL, 'gülümse toplantı var ', 0, 0),
(157, '680166691342259649_254550132', NULL, 'hazarcobanoglu', 'Istanbul, Turkey', NULL, '', 'video', '/uploads/2014/3/20/157.jpg', 'http://distilleryimage6.s3.amazonaws.com/574427c6b00411e3ad25129af71cb2b6_101.mp4', 'instagram', 'instagram', 1395302209, NULL, 'Hello spring #doodle #march', 0, 0),
(158, '680228081754680833_639958818', NULL, 'hekuuuz', ', Finland', NULL, '', 'video', '/uploads/2014/3/20/158.jpg', 'http://distilleryimage5.s3.amazonaws.com/0b167036b01611e3a99d12d9e97ebfa1_101.mp4', 'instagram', 'instagram', 1395309528, NULL, 'Last day of my vacation ! ', 1, 0),
(159, '679553570269638718_43874427', NULL, '_soloma_', 'Zeleninskiye Dvoriki, Russia', NULL, '', 'photo', '/uploads/2014/3/20/159.jpg', '', 'instagram', '', 1395229120, NULL, '#Zaraisk #winter #russia #nature', 0, 0),
(160, '680227099950738423_467062585', NULL, 'edinek123', 'Ruzomberok, Slovakia', NULL, '', 'photo', '/uploads/2014/3/20/160.jpg', '', 'instagram', '', 1395309411, NULL, '#school #patamat #video #instapic #yeah #english #jou #thursday', 1, 0),
(161, '680226638947762132_653328918', NULL, 'irene_rumondang', '', NULL, '', 'video', '/uploads/2014/3/20/161.jpg', 'http://distilleryimage0.s3.amazonaws.com/d4b64afcb01511e3af4d1209b7aeead8_101.mp4', 'instagram', 'instagram', 1395309356, NULL, '#IrenEliTanpi#video#sweet#moments#amuba#bff#forever#together♥', 1, 0),
(162, '680226820205781423_342765967', NULL, 'stanislav_krimov', '', NULL, '', 'photo', '/uploads/2014/3/20/162.jpg', '', 'instagram', '', 1395309377, NULL, '#krimov #crimea #steampunk #asia #film #backstage #video #nice', 0, 0),
(163, '680226588746840336_1029370509', NULL, 'maissonsofficial', '', NULL, '', 'video', '/uploads/2014/3/20/163.jpg', 'http://distilleryimage10.s3.amazonaws.com/afd0ac00b01511e3a2251217fce1d74a_101.mp4', 'instagram', 'instagram', 1395309350, NULL, 'Macaroni spaghetti meatball ', 1, 0),
(164, '680203847894290996_295681523', NULL, 'g_khv', 'Almaty, Kazakhstan', NULL, '', 'video', '/uploads/2014/3/20/164.jpg', 'http://distilleryimage2.s3.amazonaws.com/6579c188b00f11e3b1521292f891e046_101.mp4', 'instagram', 'instagram', 1395306639, NULL, '#lol #cat #wahahah #video ', 0, 0),
(165, '680225337839782315_402117625', NULL, 'aileen006', '', NULL, '', 'video', '/uploads/2014/3/20/165.jpg', 'http://distilleryimage5.s3.amazonaws.com/1436dc92b01511e38b3d0e1d7b20dd35_101.mp4', 'instagram', 'instagram', 1395309200, NULL, '#old #video #Peace @omaymasaidi :33', 1, 0),
(166, '680226213877048066_272970823', NULL, 'yoanaencheva', '', NULL, '', 'video', '/uploads/2014/3/20/166.jpg', 'http://distilleryimage9.s3.amazonaws.com/becf8876b01411e3aba80edc38dbd115_101.mp4', 'instagram', 'instagram', 1395309305, NULL, '#love #best #friends #forever #Flipagram #video :D ❤️', 1, 0),
(167, '680225920820779073_1192805581', NULL, 'cutenessgames', '', NULL, '', 'video', '/uploads/2014/3/20/167.jpg', 'http://distilleryimage11.s3.amazonaws.com/738749d4b01511e3b3f5128350632cb7_101.mp4', 'instagram', 'instagram', 1395309270, NULL, 'Ham is just sitting here purring really loudly. Can you hear him? #kittens #cute #hamandtrinket #video', 1, 0),
(168, '680225761438550916_475371873', NULL, 'numderome', '', NULL, '', 'video', '/uploads/2014/3/20/168.jpg', 'http://distilleryimage4.s3.amazonaws.com/2eaeaba4b01511e38c580e7be18a9944_101.mp4', 'instagram', 'instagram', 1395309251, NULL, 'Всем котиков :3 #видео #кот  #черный_кот  #cat  #video  #black_cat', 1, 0),
(169, '680225586368124959_271146701', NULL, 'highmynameisdingus', '', NULL, '', 'video', '/uploads/2014/3/20/169.jpg', 'http://distilleryimage11.s3.amazonaws.com/4b7d6586b01511e38c000e4efbc22637_101.mp4', 'instagram', 'instagram', 1395309230, NULL, '#new#creeps#design#coming#soon#graphic#art#video#beach#waves#yeah#hightimes#original#splash', 1, 0),
(170, '677339999805597497_250931240', NULL, 'julezzyyy', '', NULL, '', 'photo', '/uploads/2014/3/20/170.jpg', '', 'instagram', '', 1394965241, NULL, '•To die would be an awfully big adventure• ~He was my first love ', 0, 0),
(171, '680225280643698067_1181495130', NULL, 'luamazzu', '', NULL, '', 'video', '/uploads/2014/3/20/171.jpg', 'http://distilleryimage6.s3.amazonaws.com/7a5871b8afbe11e385d90e105e102132_101.mp4', 'instagram', 'instagram', 1395309194, NULL, '#luana #es #un #video #deci #hola #holaaaa', 1, 0),
(172, '446634103639916544', NULL, '1bouldervidaday', 'World', NULL, '', 'text', NULL, '', 'twitter', '', 1395320843, NULL, 'daily #bouldering video: sweet Macedonian boulders, from the steep and powerful to the crimpy and intricate http://t.co/NX0o5AqjUH', 0, 0),
(173, '446634102930669569', NULL, 'madam_mahy', '', NULL, '', 'text', NULL, '', 'twitter', '', 1395320842, NULL, 'Brazzers � Lonely MILF gets the best massage she�s ever had http://t.co/mu7sQ2I4lr #porn #video #teen #pussy #ass', 0, 0),
(174, '446634102737760257', NULL, 'booby_women', '', NULL, '', 'text', NULL, '', 'twitter', '', 1395320842, NULL, 'xxx clip : homemade sex tape for Huge butt mom wife on top of the dick #free #xxx #sex #porn #video #teen http://t.co/LOxxVNRuZZ', 0, 0),
(175, '446634102322896896', NULL, 'AbelardAurick', 'Berlin', NULL, '', 'text', NULL, '', 'twitter', '', 1395320842, NULL, 'Intern- PhD Research Video/Video over Wireless at InterDigital (San Diego, CA) http://t.co/C3OthgIg8k #cajobs', 0, 0),
(176, '446634102310313984', NULL, 'Fuhito_31', '神奈川の田舎', NULL, '', 'video', '/uploads/2014/3/20/176.jpg', 'http://youtu.be/H0Ib9SwC7EI?a', 'twitter', 'youtube', 1395320842, NULL, 'I liked a @YouTube video http://t.co/Wl7M7MtZc0 Superman With a GoPro', 0, 0),
(177, '446634102259982336', NULL, 'aaliyahxxxjolie', '', NULL, '', 'text', NULL, '', 'twitter', '', 1395320842, NULL, 'sex video: Homeless Teen Squirts For Money #free #tits #sexy #boobs #android http://t.co/oJ4qNPbclw', 0, 0),
(178, '446634102188675072', NULL, 'Ruronin_Kenshin', 'Brasil', NULL, '', 'video', '/uploads/2014/3/20/178.jpg', 'http://youtu.be/iuOD0E4JTqw?aFrases', 'twitter', 'youtube', 1395320842, NULL, 'Gostei de um vídeo @YouTube http://t.co/eQ9h5PrgoQ que gostaríamos de falar: PRAS GAROTAS', 0, 0),
(179, '446634102071246848', NULL, 'nana_niall', 'Germany', NULL, '', 'text', NULL, '', 'twitter', '', 1395320842, NULL, 'RT @BibisBeauty: AAAAAAH ! \nIn 10 Minuten kommt mein neues Video onlineee !\n"7 BEAUTY MYTHEN - Aufgeklärt"❤️', 0, 0),
(180, '446634101815390208', NULL, 'nth0o', 'Earth / World (?)', NULL, '', 'video', '/uploads/2014/3/20/180.jpg', 'http://youtu.be/Ov-R1Lbshhw?a', 'twitter', 'youtube', 1395320842, NULL, 'I liked a @YouTube video http://t.co/YvjPgjZGwK Full Performance of "Happy" from "100" | GLEE', 0, 0),
(181, '446634101466865664', NULL, 'CordierSteeve', 'Anglet', NULL, '', 'text', NULL, '', 'twitter', '', 1395320842, NULL, 'Un bébé se réveille en dansant http://t.co/ymH9zV7giO via @koreus', 0, 0),
(182, '446634101404356608', NULL, 'Tyokoyama1122', '', NULL, '', 'video', '/uploads/2014/3/20/182.jpg', 'http://youtu.be/Iujf45icinA?a', 'twitter', 'youtube', 1395320842, NULL, 'I liked a @YouTube video from @kosukepad1 http://t.co/fgAMKOcZfg', 0, 0),
(183, '446634101307502593', NULL, 'backpaker69', '', NULL, '', 'photo', '/uploads/2014/3/20/183.jpg', '', 'twitter', '', 1395320842, NULL, 'RT @arenanarsis: 1. jablay kita semua http://t.co/xKgcFqrHjZ | http://t.co/ogoIiDoGqr', 0, 0),
(184, '446634101119139840', NULL, 'PazaruHD', '', NULL, '', 'video', '/uploads/2014/3/20/184.jpg', 'http://youtu.be/8hNzULIodb0?a', 'twitter', 'youtube', 1395320842, NULL, 'Ich habe ein @YouTube-Video von @earliboy positiv bewertet: http://t.co/Hlywmb8rdF CraftAttack Failstream - MEGA AUSRASTER! Mit', 0, 0),
(185, '446634100896444416', NULL, 'Priii_Carp', 'Burzaco', NULL, '', 'text', NULL, '', 'twitter', '', 1395320842, NULL, 'Vi un video de Dlc en pasion en el qe maso menos me escrachan Y me acorde de mi mamá re emocion porque me habia visto jajajaj', 0, 0),
(186, '446634100615819264', NULL, 'dramaticxbiebur', 'My World Tour 290311', NULL, '', 'text', NULL, '', 'twitter', '', 1395320842, NULL, '@avonskiidraxhl hey sunshine ! could you please watch my video ? would mean alot :) ily xoxo have a nice day :) https://t.co/J5q3lhLJS4 …', 0, 0),
(187, '446634100431265792', NULL, 'CeliaaLuque', 'CÓRDOBA', NULL, '', 'video', '/uploads/2014/3/20/187.jpg', 'http://youtu.be/W8r-eIhp4j0', 'twitter', 'youtube', 1395320842, NULL, 'Romeo Santos - Odio Feat. Drake (Lyric Video) ', 0, 0),
(188, '446634100372557824', NULL, 'bilinmeyenibil', '', NULL, '', 'text', NULL, '', 'twitter', '', 1395320842, NULL, 'RT @61_atila: AKPARTİMİZİN BU GURUR VERICI SEÇIM REKLAMINI YSK KURULU YASAKLAMIŞ BU NEDENLE RT YAPIP YAYALIM http://t.co/DB0bPwpARv', 0, 0),
(189, '446634100301234176', NULL, 'Ruronin_Kenshin', 'Brasil', NULL, '', 'video', '/uploads/2014/3/20/189.jpg', 'http://youtu.be/em3chhGvlFk?aImprov', 'twitter', 'youtube', 1395320842, NULL, 'Gostei de um vídeo @YouTube http://t.co/nPuydBWTPhável - Frente e Trás #5', 0, 0),
(190, '446634100284481536', NULL, 'PoZe_aV', 'Portugal  ', NULL, '', 'video', '/uploads/2014/3/20/190.jpg', 'http://youtu.be/eW4KI6Bf3Ek?a', 'twitter', 'youtube', 1395320842, NULL, 'I liked a @YouTube video from @bananafone34 http://t.co/cpmHow4KpM LUCKY GREEN CAMO WITH GREENDAY!!', 0, 0),
(191, '446634100267687936', NULL, 'junebuggin', 'Lumberton, NC, USA', NULL, '', 'text', NULL, '', 'twitter', '', 1395320842, NULL, 'RT @AJEnglish: By 2020, the world will have accumulated 3.3 trillion video hours of surveillance footage http://t.co/Uyr5yNQmJG', 0, 0),
(192, '446634100108324864', NULL, 'asenante', 'Madrid', NULL, '', 'video', '/uploads/2014/3/20/192.jpg', 'http://youtu.be/H_wQhrhkrek', 'twitter', 'youtube', 1395320842, NULL, 'Escenas curiosas: la nueva valla de #Melilla defiende un campo de golf. VIDEO en @phumano http://t.co/rLxDdFIHnq por @javierbauluz', 0, 0),
(193, '446634100078563328', NULL, 'roygultom65', '', NULL, '', 'text', NULL, '', 'twitter', '', 1395320842, NULL, '[VIDEO] Rel Jet Coaster Patah di Magelang, 7 Anak Terluka http://t.co/jSrEE0rtyf', 0, 0),
(194, '446634099944345600', NULL, 'mmkkhhrrkk', '', NULL, '', 'video', '/uploads/2014/3/20/194.jpg', 'http://youtu.be/WchwFBwQKOs?a', 'twitter', 'youtube', 1395320842, NULL, 'I liked a @YouTube video from @youtube_miyau http://t.co/RarOHYigjt 【GTA5】スタンガンで市民をいじめる', 0, 0),
(195, '446634099768561664', NULL, 'nth0o', 'Earth / World (?)', NULL, '', 'video', '/uploads/2014/3/20/195.jpg', 'http://youtu.be/WVAvIcMaRK8?a', 'twitter', 'youtube', 1395320842, NULL, 'I liked a @YouTube video http://t.co/lS2tpLiOGF Full Performance of "Toxic" from "100" | GLEE', 0, 0),
(196, '446634099630157825', NULL, 'Invencibl333', '', NULL, '', 'video', '/uploads/2014/3/20/196.jpg', 'http://youtu.be/LTpvpz-PWG0?a', 'twitter', 'youtube', 1395320842, NULL, 'Gostei de um vídeo @YouTube de @ndjogos http://t.co/TafpFT6uKe NEED FOR SPEED The Movie | DESAFIO UMA POR DIA', 0, 0),
(197, '446634099520708609', NULL, 'TheRealNonick', 'cloud 11', NULL, '', 'text', NULL, '', 'twitter', '', 1395320842, NULL, 'Video: Jesse Jagz Presents The Royal Niger Company: Jesse Jagz discusses the making of The Royal Niger Company.   http://t.co/aN4WLz4ffU', 0, 0),
(198, '446634099432632320', NULL, 'lifesexybutt', 'New york', NULL, '', 'text', NULL, '', 'twitter', '', 1395320842, NULL, 'Sarah jay hottie huge butt milfe famous porn star get nailed on huge black cock http://t.co/3Y9AmMHrK6 #pics #news #pussy #youtube', 0, 0),
(199, '446634099420446720', NULL, 'arsenalite82', 'London, UK', NULL, '', 'video', '/uploads/2014/3/20/199.jpg', 'http://www.youtube.com/watch?v=iU83R7rpXQY', 'twitter', 'youtube', 1395320842, NULL, '@alexthenac http://t.co/xROi3oPKZP Watch that. When yer read about the events, and view the video, you can see he got shot from behind 1st..', 0, 0),
(200, '446634099240095744', NULL, 'kheswalisarkar', '', NULL, '', 'video', '/uploads/2014/3/20/200.jpg', 'http://youtu.be/O0gaSW9zf-M?a', 'twitter', 'youtube', 1395320841, NULL, 'I added a video to a @YouTube playlist http://t.co/xtEAhgyWou kardo Ik Nazr Se Khasta Halea-Raiz Ali+Ijaz Ali Per Mahal Wale-1993', 0, 0),
(201, '446634098971656192', NULL, 'Siobhan_Adams1', '', NULL, '', 'video', '/uploads/2014/3/20/201.jpg', 'http://www.youtube.com/watch?v=gFLcOs8cj8U&sns=em', 'twitter', 'youtube', 1395320841, NULL, 'RT @KarlHughesUK: Watch my new youtube video here --&gt; http://t.co/K87j5XlxET', 0, 0),
(202, '446634098912952321', NULL, 'SkellyAdam', 'morecambe', NULL, '', 'text', NULL, '', 'twitter', '', 1395320841, NULL, '@Maddog_Angus that video is mad do u think it''s real ? Iv read about it and experts don''t think it''s fake but it looks Naff as hell', 0, 0),
(203, '446634098896146432', NULL, 'kheswalisarkar', '', NULL, '', 'video', '/uploads/2014/3/20/203.jpg', 'http://youtu.be/84g9wB7zloA?a', 'twitter', 'youtube', 1395320841, NULL, 'I added a video to a @YouTube playlist http://t.co/uk6M64yq6M Alam Me Koe Or Na Asa Nazar Aya-Rizwan Mozam+Mujhahid-1994', 0, 0),
(204, '446634098870992897', NULL, 'kheswalisarkar', '', NULL, '', 'video', '/uploads/2014/3/20/204.jpg', 'http://youtu.be/cON1Hz815Go?a', 'twitter', 'youtube', 1395320841, NULL, 'I added a video to a @YouTube playlist http://t.co/6H6rMGxYqs Anha Ute Saya Mera Ghos Dastgher-fAkhter Sharef Arop Wale-1990', 0, 0),
(205, '446634098862604288', NULL, 'kheswalisarkar', '', NULL, '', 'video', '/uploads/2014/3/20/205.jpg', 'http://youtu.be/eABr5lgU1lE?a', 'twitter', 'youtube', 1395320841, NULL, 'I added a video to a @YouTube playlist http://t.co/gWWByXZpGV Kafir Bane Ge Ishq Ke Azmat Bharae Ge-Akhter Sharef Arop Wale ( Nagre', 0, 0),
(206, '446634098862587904', NULL, 'kheswalisarkar', '', NULL, '', 'video', '/uploads/2014/3/20/206.jpg', 'http://youtu.be/p0x0V9AalTQ?a', 'twitter', 'youtube', 1395320841, NULL, 'I added a video to a @YouTube playlist http://t.co/TsK7Y3oXuj Jab Andhre Cha Ge-Rizwan Mozam+Mujhahid-1997', 0, 0),
(207, '446634098837422080', NULL, 'kheswalisarkar', '', NULL, '', 'video', '/uploads/2014/3/20/207.jpg', 'http://youtu.be/rs-KNSf-ppE?a', 'twitter', 'youtube', 1395320841, NULL, 'I added a video to a @YouTube playlist http://t.co/yNXIGcUmVy Main Goli Nori Bori Wali De-Rizwan Mozam+Mujhahid Mu -1996', 0, 0),
(208, '446634098745159680', NULL, 'iHeartJessicaJ', 'BELIEVETour', NULL, '', 'text', NULL, '', 'twitter', '', 1395320841, NULL, 'RT @justinbieber: Make me a remix video. http://t.co/7Dz3YYGxd2 #NEObiebermix @adidasNEOLabel', 0, 0);
INSERT INTO `node` (`nid`, `mid`, `uid`, `screen_name`, `location`, `country_id`, `email`, `type`, `file`, `url`, `media`, `from`, `datetime`, `hashtag`, `description`, `status`, `reward`) VALUES
(209, '446634098703216640', NULL, 'kheswalisarkar', '', NULL, '', 'video', '/uploads/2014/3/20/209.jpg', 'http://youtu.be/mGk1-RJ9wsU?a', 'twitter', 'youtube', 1395320841, NULL, 'I added a video to a @YouTube playlist http://t.co/PH6kvAejS1 Jitna Dya Sarkar Ne Mujh Ko - Mian Dad Khan', 0, 0),
(210, '446634098619342848', NULL, 'Sarahtanner579', '', NULL, '', 'text', NULL, '', 'twitter', '', 1395320841, NULL, '@justinbieber @CrazyKhalil VIDEO?!??', 0, 0),
(211, '446634098510295041', NULL, 'kheswalisarkar', '', NULL, '', 'video', '/uploads/2014/3/20/211.jpg', 'http://youtu.be/1fEEgluYmjg?a', 'twitter', 'youtube', 1395320841, NULL, 'I added a video to a @YouTube playlist http://t.co/rDuunHqQSq Allah Allah Mere Nabi De Kamli Kali Ae-Badar Meya Dad-1987', 0, 0),
(212, '446634098447364097', NULL, 'Yoye_Firfonst', 'Bangkok', NULL, '', 'video', '/uploads/2014/3/20/212.jpg', 'http://youtu.be/7hrV2xhBV9A?a', 'twitter', 'youtube', 1395320841, NULL, 'I liked a @YouTube video http://t.co/MEDzozI6jl [Real GOT7] episode 9. Teamwork Game', 0, 0),
(213, '446634098438987776', NULL, 'meliicampoya', '', NULL, '', 'text', NULL, '', 'twitter', '', 1395320841, NULL, 'Muy bueno el video de los de la Dorotea', 0, 0),
(214, '446634098325745664', NULL, 'kheswalisarkar', '', NULL, '', 'video', '/uploads/2014/3/20/214.jpg', 'http://youtu.be/1QIMBZq8Wm4?a', 'twitter', 'youtube', 1395320841, NULL, 'I added a video to a @YouTube playlist http://t.co/uUKFt28Df1 Athe Othe Tereya Dhuma-Bakhshi Salamat-1987', 0, 0),
(215, '100007933597655_1392834627657644', NULL, 'Fuelitup Fuel', '', NULL, 'dev@fuel-it-up.com', 'photo', '/uploads/2014/3/20/215.jpg', '', 'facebook', '', 1395321114, NULL, '#HASHTAGTEST fds', 0, 0),
(216, '100007933597655_1392834714324302', NULL, 'Fuelitup Fuel', '', NULL, 'dev@fuel-it-up.com', 'text', NULL, '', 'facebook', '', 1395321125, NULL, '#HASHTAGTEST ffff', 0, 0),
(217, '100007933597655_1392834627657644', NULL, 'Fuelitup Fuel', '', NULL, 'dev@fuel-it-up.com', 'photo', '/uploads/2014/3/20/217.jpg', '', 'facebook', '', 1395321154, NULL, '#HASHTAGTEST ffff', 0, 0),
(218, '100007933597655_1392838750990565', NULL, 'Fuelitup Fuel', '', NULL, 'dev@fuel-it-up.com', 'text', NULL, '', 'facebook', '', 1395321644, NULL, '#HASHTAGTEST ffdsfd', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `oauth`
--

CREATE TABLE `oauth` (
  `oid` int(10) NOT NULL AUTO_INCREMENT,
  `media` varchar(100) NOT NULL,
  `username` varchar(100) NOT NULL,
  `token` varchar(255) NOT NULL,
  `token_secret` varchar(255) NOT NULL,
  PRIMARY KEY (`oid`),
  UNIQUE KEY `media` (`media`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `oauth`
--

INSERT INTO `oauth` (`oid`, `media`, `username`, `token`, `token_secret`) VALUES
(1, 'instagram', 'fuelitup', '1133838733.28fb0c1.18d82e8ec3454d49988ab2ee083be6fa', ''),
(2, 'twitter', 'fuelitup2', '2365810087-IatJREE8Px4XhiINuvhFZ4kf7G4Tk9IMiERo0JQ', 'GdBSh2a7JCDT3Na0EDlU6OQQeZJsHZ72M4fBsIehFBfSk'),
(4, 'facebook', 'fuelitup.fuel ', 'CAADhritmk0ABABxa1pDVNXZCtewEcucftJMvfjQTRLjmz5K6syvgnNVQsR5P2AudwmRVwQZBO7ZCUJz6XzisA9Cwo6hUCXD2ncr7jRrz3LNoyZBtI1CB4ldI3RWG0414k1TjHP7CJ43at8bXK9aA4e1DW2FI8jLE2wRFkghyBzgpGvCf3gnqoIea3ZB2oaXcZD', '');

-- --------------------------------------------------------

--
-- Table structure for table `session`
--

CREATE TABLE `session` (
  `id` char(32) NOT NULL,
  `expire` int(11) DEFAULT NULL,
  `data` longblob,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `session`
--

INSERT INTO `session` (`id`, `expire`, `data`) VALUES
('000d17d7efd6aa967726cbdda928c87a', 1394366182, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223663343563363431383934333535366235393330326166653130613937316235223b),
('03b897dd91ad73897def104d8a212e8c', 1394365841, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223334363135393938653136663062333066396335653037643763663137616634223b),
('05346bd730b01c5c9e832eb0f6e84503', 1394366702, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223330363163393131366662336638663161333864636339313234353764323430223b),
('0697a6d2fea3699d8612dc096810db95', 1394365778, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223335663032363233353964376436386462386233623131626664626135353963223b),
('06dc2464456a6227fc94fab3cf1eee07', 1394366175, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223864656536623865363539636335653230396164323131393630646637363066223b),
('08a96f9eb9b660ccf40f70329de0e834', 1394365849, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223535323965613962663533393338376565353363613338623366303263343136223b),
('0b3cdc0259a24a671afc880810529c45', 1394365774, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223164333531306165366661336637386330373263656134653538323135363332223b),
('0bb159bec1ee00b14ba98887d344adb9', 1394365778, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223263313536303937336338343834313534386434383337623739353330303832223b),
('109b1d34990ba40552ee4b03ab0e6b83', 1394366151, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223365373139343865356330343935613032656231326532303133653534383233223b),
('1863d357ed8b1f57519350bd560ac182', 1394365782, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223134353037613335616535386439333330613637616135303935653165316162223b),
('18e9149a1ef153b665e26397da62c2b5', 1394366419, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223638613538336665396664333836373632383433613335316230336430643834223b),
('19d243d3d62018f0f327371d1bbb0b3e', 1394366700, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a226438303037306261626261383163636536316634323165313435636430633939223b),
('1f4689e03b9a2d232e50aa9a17f00603', 1394365845, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223762393033633239633831663631643731343265383839666566386566316532223b),
('21628454bfecaa6b511cee7a6a8ddd33', 1394366149, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a226539303163663134376537383631323131353165653234646361663333653335223b),
('22d54e671fff04c4f36a2e7a98419405', 1394366408, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223763343838376131636231323563336432643837636334616566353239663830223b),
('22d8b2f5533439cc596306a9517da495', 1394365848, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a226466393131326534396235653732323431396366373830643937633761386464223b),
('30517518fcc80496563be13d3157d075', 1394366408, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223038376432336235633164303063396637613334616235666633623835643039223b),
('325a3ede21a096eec06fc32978c7f0ce', 1394365784, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a226564353633623964303835393364303930386138633034653163333362353866223b),
('32d06c11842678b52e1b966218cf5176', 1394366417, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a226434396631313539653337623534396631386230306436313338303138386434223b),
('333bbf0215cc665ab54682c0ea4ba08d', 1394365845, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223863356362613065623435373034663263656466653736376331656532323763223b),
('334c6bcd738e027525a11fb013470d6d', 1394366701, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223835633632376139353764366164616637336132306166353438333564393333223b),
('36fb763858be934708bfca0871e39b4f', 1394365848, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223164353038656639313431396339323765313630346638393038363861353234223b),
('372197862dbee71f4619b96228809696', 1394366419, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223535623662653639376130616562616138343630376462653832343538613766223b),
('3746975fa36d04af2f57ee0ae277ee6b', 1394366707, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a226632306563643961666536326162666231646137396338653034363537633465223b),
('3e37058014a3ae3bd60cdf20b157cdf0', 1394366702, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223230383937303436333365666234626230666336313538333330663961383031223b),
('3f3f1a249c90c8b284532099ea3d6ff5', 1394365848, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223932643762393262346538313339363738366330326333663335376534343936223b),
('4193679a800dd3a4543f3608309924f2', 1394366148, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223334643464646530616666396565356362303435366139616365396435373735223b),
('4409570c0f5b1cf00c51be9d19a02059', 1394365843, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a226533326462613866386461376439363232363437336435343665653461616530223b),
('457c8913cb7869eba125d4d8e6501976', 1394365842, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223532383339656362633861626364666535346466386334323136626266363933223b),
('4779bc31030f8b6b6f2b947f86ccd086', 1394366408, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a226663613434643830653762376664343830316265333937623264306336373831223b),
('47b323a22f146f29f780f0124659a2b2', 1394365782, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a226130333066633237646131616438326137336664393565326434346366343930223b),
('4994a22c8f82ad5473d5451bcbbde3b4', 1394366702, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223538613634386237633436313930653566313331316137363530303833376235223b),
('4998ddef4aa21caeccf2c37f4ea60322', 1394365778, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a226664613239313532623737383535643263376138353565376166643663343665223b),
('4e550efdee81268ae88380a262089fa8', 1394366701, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223330393866663266313038326563336164356166303532313631656262343134223b),
('4ebf24a7382c5a13536774adcb72e0f1', 1394366701, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223537633763366435306238343366383862306635323566373737333866613537223b),
('504107c8238b3901911d9acb4fb0057d', 1394365876, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223536303536303832386166303633373934363938613431393133326639636361223b),
('52f56290854f98331f0ef34da4f801bc', 1394365875, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a226530663839653432623134616531353138666530366133663261363566653365223b),
('54a7b1ad69d5e65830fa28d7013efa4f', 1394366422, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223132306162313436343166306233393130356162313563313234393431306239223b),
('5682068101a3d7ec1efa047bf10820ec', 1394366418, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223739363934366530393861346663303262636535656331616430346637643265223b),
('56e3c3098877bab865ad229b610ff763', 1394365781, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223230376363376164616233313338666665616261386433396265353061393133223b),
('587a812ad0bc8f339cc6d7c74f8ba41b', 1394366140, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a226635646438336262373032613639646162613930636231613335303636646362223b),
('5a10f5dd44bb12bf59c72533def28c67', 1394366146, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223437323632653735303139633862316135346634303166393333336661663235223b),
('5dca8efd309006acc80c6b104ec3b8c7', 1394366701, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a226630623265366335393437336234633430373832343361303539316331383932223b),
('5f964e18ae6fce9b18b10f46dbc8849d', 1394365782, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223631376338663563323662663061343435363035313432336130376135353230223b),
('61d50e925a115d401fad0769941121ea', 1394366183, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223830363961336231653863393739666165636330363565356437363339623332223b),
('623c519994bb8f5d42b019b080d1cf20', 1394365875, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223239646332646165306338373731356435636530626235366633373566343437223b),
('6431fbeab05f51bbdcf10c1f43d2c3d2', 1394365777, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a226661653337656335636262613139303161303238336666393766643766363332223b),
('64a1106ea12e9efdda0a318a5af5c92e', 1394365843, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223334383466613936363963613230623635656564643635353236366666646630223b),
('661aa6fe2856b59c9e6fc297408760a5', 1394366143, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223465303266353237303631643232633237396532633731323664333938386463223b),
('66fb6b391a600b421889f9729d97ea6d', 1394366150, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223232633538633938376334303137616463376333343533343539396136363437223b),
('67883a3b94726480e46b216a13d4212c', 1394365782, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223639666661663663383937313837616336396663633264323166626666643034223b),
('69beb5145b47be4bc3d69bb47e718221', 1394365781, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223861643639643531323666663763363833636365333632616633376666323132223b),
('6a7518eb25398088e10d4076e71c6216', 1394365777, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223830616339653161643137633533373434623137336565373031386364316662223b),
('6bd8326b98a2b888199e1cf1ad8e6f0e', 1394366418, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223065343763356264343534613762626366646534393165633732356562636436223b),
('6d91b10d2e0d08b36d54415a51aa6757', 1394366138, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223737363232373533363435323332323161313438666537306133383632333961223b),
('6db192daa8967a09abe9a1479a23588e', 1394365875, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223664303432613636393639343639356163373036366163613764386463383334223b),
('6f0f2ff4d0cf57eb8a403ad907fdadec', 1394365844, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223738626665323934623230353235306664366236343530373265663464633739223b),
('711c4df4e6370c487f8d99fcaeec6061', 1394365844, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223336306339636338376431316437363530393066313066313564653536396238223b),
('7294c46b42d29f70859f877843287679', 1394366169, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223530633239366234363739343431313531363036363839323430396165643465223b),
('750d051c5d8b6bc18fa5400e0abcda13', 1394365848, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223130656165623966313831316563306166633132316437333639373535643861223b),
('762c3aa01ab4bfdcf5314967ab057fe8', 1394366145, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223034306434316465623266643435343064663036313935653330643334383361223b),
('7654477313375ce678a8eaa85dd7e646', 1394366149, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223664353932636266656231666439653938323131626564326336313862373161223b),
('7756ecc921a3c03ae25dbee79a884a6c', 1394365842, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223762663037376166613236326364663330643436346139313365393564363330223b),
('7b72ebb0728de881af816066fcc00f30', 1394365848, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a226135643234643334336665383962393935613438663561363437373165386263223b),
('7b765e21ded83984ebef048b9a7512b4', 1394365777, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223861383162656531633966643435663637353037353765636363373331346563223b),
('7ba2a5d6a9b60d14c3a7f720795186ab', 1394366143, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223334353938353530653338393833386465653835613031383461343964643733223b),
('7c6a7cf373dbb2441be56b1a7a51d1fc', 1394366139, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223434663132383863363462623937666231303938333365393435663436636430223b),
('7fa384bc5925e06841cbb29f1446f1b4', 1394366702, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a226136393564626366623365613039613539646565363264323336636637306132223b),
('804e82ed088b300542715ca0bc5f061d', 1394366168, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223064353233396536303066336462636335303065613636663233336634613833223b),
('80633a0e2c4580f8779c7d57f7dfda19', 1394365780, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a226637363234643632643232323936356166366661623132346637666634316161223b),
('80a8aa4d92557b41fcf2e79b12ee4b99', 1394365779, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223731643231333238646635303637646162373337643630626636306432326464223b),
('8923e51e9ecb35edf7460b650703e0c6', 1394366148, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223630663538323430656361303936373537333039306539646132323535383430223b),
('8c6d9f693c9822dcb6cce18fc3e8e988', 1394366701, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223530363637326364336564643131333236623161636138346632666636653732223b),
('8cf794b8d003a73c9a43249e9f75afe1', 1394365875, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a226665393563316162656635313264306230383030373839663131326262373466223b),
('8e04cf18f0290b903f8443aa778b6a74', 1394365845, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223434383636386431323931353530613163363265323131646665363437346230223b),
('8e1a8e7ce56c9cc6498da494b1d9a90c', 1394366151, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223431633231383038336133313031353531313939613135656463396537346564223b),
('8e80508d2dd4f8ce68784ecced1e669d', 1394365847, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a226231626366333938386235653133313462323735316437326437396639333330223b),
('9341843a20adfb46735476719297ff4a', 1394366408, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223936323232613835643062623531356436316564633531393238663234353134223b),
('9423ada677cb7a4a4eda96e26684ba64', 1394366147, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223336303539613665653530646338353764333135623039626639313064346665223b),
('996f5a814f72f110e56496e42771a350', 1394366409, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223137636635636364313139653136333237336235333732386266353766313562223b),
('99d39f4652ec71316c652e0396047aa7', 1394366701, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a226537386263663830343336633031653130393463633731353839336263613738223b),
('9d8d5e5e9cb9076b43e049af8d04f85f', 1394365781, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a226463646438653137636561363762623835316662363236353331323533393730223b),
('9da38468f9f31986c321d82e161f4d44', 1394366142, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a226266303132643439366531656634326563613936336665343231613261386364223b),
('9dafe5f43deb3439b2d5344babc1f58e', 1394366703, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a226531663231646138346163656133306431303337646531333263316530646163223b),
('9e89243f268222561612af5557d1111d', 1394365779, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a226134333538633834633764636232653262616233316139363731336362613639223b),
('9ec467d7e12c1485d6216d0199953a1a', 1394365843, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223638366334326564323635366463653531313830393339666634663138383530223b),
('a03edd7abc8b35ea3cf87691186c4715', 1394366422, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a226263306563383764363736336537376634633133613963663733336133666333223b),
('a19b5425601545fee152e855341f4710', 1394365847, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223564633262396264323033323138366335333230336535356634323461366432223b),
('a4890a96d559bde584358cd304ea58cb', 1394366409, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223264363537616436616339363933313731303734633963366339303466623532223b),
('a576e16d0876bf2e3dc0124fc074d8af', 1394365847, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a226536373939303435626362323037376631396533663634373333353439623438223b),
('a5d78b1818cc9f459386517d261e6b2f', 1394366150, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223938383030363335616136393932346331646232306630663061333933396164223b),
('a711087eb07cc37461c81cc8faa53b96', 1394365843, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223538316561663465653035313665626333313435623664386465353165623161223b),
('a8fc52492250e1f1fd2134e0025c36b1', 1394366141, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a226363613033356537303766396364333665633233656263363563356337613864223b),
('ac6c3ca986173ca3e4fb2f9fac568766', 1394365776, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223836646365343362333766323464333438373134306464366139383231353261223b),
('ad951ffc95bbb0b8bf18aa56da2c524e', 1394365846, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a226432303133663635396465323364613131303937663033323737363436663139223b),
('ae21b4743123807be046c95e370e2bdb', 1394366181, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223361626237363361646332636162613632616239303063613234346663323739223b);
INSERT INTO `session` (`id`, `expire`, `data`) VALUES
('aea067ac58618ad7d1fd4ee81252e261', 1394366416, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223431373666343737393638393730653536313066656137323136326265613865223b),
('af1fc63fe51f2956ab30848d757423da', 1394366146, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223137366234663438663735383835633836666233396432616237343166373165223b),
('afc5fa63422cb373f8dd8190cfb48abd', 1394366419, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223934383939616363333930343336303862316439336236376235306339313265223b),
('b13f7dfe82bda704f985bd2b2e389a65', 1394366417, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223034323237356466373830663237613530306637333836316234353833383236223b),
('b32b868e060259bb7fb29330b8f20930', 1394366167, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223863646632313636656465666239666332663163616133633262633739636231223b),
('b5ad14c30012bd0f654efad9761bed56', 1394365774, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223237366361623562643532363036306431666133313861626664643962646635223b),
('bcc47019d82a5148b6bddd50778da155', 1394365844, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a226238623733323430373534353066333031643339613938396439663334636337223b),
('be5dbed0b0a26d8d7ad341c85f8d3d7e', 1394365842, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223931383637653665636361633763353264323034373564323032363463346533223b),
('bfd1bda817b6acfa2bbafc6c027755b3', 1394366144, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a226239396434373039613464353230653265633535653865376466343864333763223b),
('bff82d21ce14f5540df98999a3fd9907', 1394365780, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a226265343161326130623735323835666364353931646535343232653763336332223b),
('c022b53446626057edbd3f424a9c120a', 1394366418, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223039303432326665656539376534393231326563613065653563633735366235223b),
('c9e17744eed0a28f3bf4a964baf05c76', 1394366147, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a226666653539396363363263636363333665383963303162313537323563396139223b),
('caa8c77c6abe4fe1d6b9232b12722a0d', 1394366417, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223435396438353739376666383161333535393638613162323538343962346464223b),
('cf441e265fe9d8c2cadedaa48075601a', 1394366702, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a226166623639396261336135373664323935303539633536373439613839363831223b),
('d48be236a2dd4c5d47a6e6c4785ac4b9', 1394366416, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223839343864383034323734643630656431366230663666303266323266633765223b),
('d5708802420bf3ecfac33f404dcdfd09', 1394365783, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223238633361333063666539333438383738333764663239626638383634633332223b),
('d84588c5619b67fa271dfa1ccfd3c947', 1394366416, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223634663337616439343331303563333135353334396630356534376665376332223b),
('d9afa21ccb6c94d81c50730a037c2721', 1394365779, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223435343861376637366163376164333266653632346534666263613831306361223b),
('da156ef51ac0ee0881ac70f8f7c8463e', 1394365846, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223530353366376362636264393166383863313038336666333463313332373332223b),
('db055e9843211ec7c84190304ff48266', 1394366137, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223030626366333738643034353639383335363233313834643134343165396433223b),
('dd24a2bc7b2b65410bf244dad05e0ef8', 1394365783, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a226564343237623437316362313461643633643332393531633931613666333736223b),
('ddfef78e9c17c9747e8aa22a1253e946', 1394365845, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223539353231393663663633656234326232323731393637326139373061353766223b),
('e05d131bf020ba9aef1e91a42ba29be7', 1394365779, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a226139343833303135393031383537663438386238383765613139396261386236223b),
('e2e94457bb5d16e9a5dd873eb16b8c4e', 1394365845, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223666373863623761353364636239373563613862643362336639633033663264223b),
('e5d7122d14294c9ad4b9298468f39244', 1394366417, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223534323230323531636465666634303063326130653065303038303935666366223b),
('e884554b544171c2bdca2a7baea08b26', 1394365776, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a226334373739643833373764333064363634383636313834316630363435373738223b),
('e8d62ed79bc06146a68a066ee355cfbd', 1394365780, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223431383963396531326163656630666162326166346537306334653633373932223b),
('e97b32ae8ff8f23ff7d7f70688407aed', 1394365779, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223832623236386634663139626134646331353162646531613962663535353437223b),
('ea4bf35146630d2bf4a19d4c3e504c7b', 1394366419, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223063616562643032616538333964363766333735383763663763663737356439223b),
('ede2efe13884687efe561dde86366b0c', 1394366174, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a226461303736633862313231376130623463643835376436636538383231623036223b),
('f4556285da60ce2a3e9815276658b890', 1394365778, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a226139656535396366333138373038356437643766353833633632336236373935223b),
('f78b43bf130947c63de77b4e8d42ef0f', 1394365849, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a226463386362353932633561376664363135633462633066356331343764363837223b),
('f7f1dbeb3402e010ffff4630f1fa53fc', 1394365846, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a223561626632353635366432316433373535653733343432383134623832343739223b),
('fe3f39e1e92b48fc63b3430893f673a6', 1394366416, 0x30383562363932333965653237313936303039613432643835323736386164385f5f6e616d657c733a303a22223b30383562363932333965653237313936303039613432643835323736386164385f5f7374617465737c613a303a7b7d3038356236393233396565323731393630303961343264383532373638616438726f6c657c693a303b3038356236393233396565323731393630303961343264383532373638616438636f756e7472795f69647c693a303b766f74655f73657373696f6e7c733a33323a226366313939636465346236343664313465363239333039643735366263393865223b);

-- --------------------------------------------------------

--
-- Table structure for table `setting`
--

CREATE TABLE `setting` (
  `sid` int(10) NOT NULL AUTO_INCREMENT,
  `setting_key` varchar(255) CHARACTER SET utf8 NOT NULL,
  `setting_value` varchar(255) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`sid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `setting`
--

INSERT INTO `setting` (`sid`, `setting_key`, `setting_value`) VALUES
(1, 'phase', '3'),
(2, 'praise', '27'),
(3, 'answer', '3'),
(4, 'countdown', '1395446400');

-- --------------------------------------------------------

--
-- Table structure for table `tag`
--

CREATE TABLE `tag` (
  `tag_id` int(128) NOT NULL AUTO_INCREMENT,
  `tag` varchar(255) NOT NULL,
  `count` int(255) NOT NULL DEFAULT '0',
  `date` varchar(16) NOT NULL,
  PRIMARY KEY (`tag_id`),
  UNIQUE KEY `tag` (`tag`),
  UNIQUE KEY `tag_id` (`tag_id`),
  KEY `tag_id_2` (`tag_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=28 ;

--
-- Dumping data for table `tag`
--

INSERT INTO `tag` (`tag_id`, `tag`, `count`, `date`) VALUES
(1, 'test', 2, ''),
(2, 'teak', 2, ''),
(3, 'test2', 0, ''),
(5, 'test3', 0, ''),
(8, 'test5', 2, ''),
(9, 'bird', 1, ''),
(10, 'lovely', 1, ''),
(11, 'red', 1, ''),
(12, 'cute', 1, ''),
(13, 'animal', 1, ''),
(14, 'china', 2, ''),
(15, 'green', 3, '1391351051'),
(17, 'natural', 0, ''),
(18, 'fdf', 0, ''),
(19, 'dffd', 0, ''),
(20, 'kkk', 0, ''),
(21, 'fff', 1, '1391422741'),
(22, 'winter', 1, ''),
(23, 'ff', 0, ''),
(24, 'abcd', 0, ''),
(25, '223', 0, ''),
(26, 'djd''fifif', 0, ''),
(27, 'dkdd', 0, '');

-- --------------------------------------------------------

--
-- Table structure for table `topday`
--

CREATE TABLE `topday` (
  `topday_id` int(15) NOT NULL AUTO_INCREMENT,
  `nid` int(15) NOT NULL,
  `date` int(11) NOT NULL,
  PRIMARY KEY (`topday_id`),
  UNIQUE KEY `nid` (`nid`,`date`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=32 ;

--
-- Dumping data for table `topday`
--

INSERT INTO `topday` (`topday_id`, `nid`, `date`) VALUES
(31, 1, 1394208000),
(30, 99, 1394899200),
(6, 122, 1389481200),
(14, 163, 1389740400),
(13, 170, 1389913200),
(5, 197, 1390258800),
(3, 206, 1391122800),
(2, 214, 1391209200),
(1, 214, 1391219200),
(29, 277, 1391900400),
(27, 308, 1392678000),
(28, 323, 1393110000),
(26, 429, 1392418800);

-- --------------------------------------------------------

--
-- Table structure for table `topmonth`
--

CREATE TABLE `topmonth` (
  `topmonth_id` int(15) NOT NULL AUTO_INCREMENT,
  `nid` int(15) NOT NULL,
  `date` int(11) NOT NULL,
  PRIMARY KEY (`topmonth_id`),
  UNIQUE KEY `nid` (`nid`,`date`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `topmonth`
--

INSERT INTO `topmonth` (`topmonth_id`, `nid`, `date`) VALUES
(4, 1, 1393603200),
(2, 122, 1388530800),
(3, 214, 1391209200);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `uid` int(15) NOT NULL AUTO_INCREMENT,
  `sso_id` varchar(100) NOT NULL,
  `name` varchar(200) DEFAULT NULL,
  `screen_name` varchar(255) NOT NULL,
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=16 ;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`uid`, `sso_id`, `name`, `screen_name`, `personal_email`, `company_email`, `country_id`, `avatar`, `role`, `datetime`, `firstname`, `lastname`, `password`, `status`) VALUES
(1, '', 'guest', '', NULL, NULL, NULL, '', 1, NULL, NULL, NULL, NULL, 1),
(3, '2ff43693fbce1d16e38e833b33a069f9', 'tonysh518', '', 'tony@fuel-it-up.com', 'tonysh518@rnd.feide.no', 30, '', 1, 1391654204, 'tony', 'zhu', NULL, 1),
(4, '4f5761b67a2a11b8d37d1112820d253c', 'sgtest', '', 'tofnfff33333f33ffdf23@fuel-it-up.com', 'sgtest@rnd.feide.no', 35, '/uploads/avatar/4.jpg', 2, 1391912982, 'sg', 'test', NULL, 1),
(5, 'ac0f49b7b582db2a194f42ccf15a6247', 'sgtest2', '', NULL, 'sgtest2@rnd.feide.no', 30, '', 1, 1392725672, 'sgtest2', 'sg', NULL, 1),
(6, '9a229522a6d2a17e314a0109fcd21a3d', 't_tonysh518', '', NULL, NULL, 0, '', 1, 1394292727, NULL, NULL, NULL, 1),
(7, '601fb00a92bf6b88cca3d3a6c2eb945d', 't_fuelitup2', '', NULL, NULL, 0, '', 1, 1394292784, NULL, NULL, NULL, 1),
(8, '938a0d0e86d72a29454145db7dc6e844', 't_tropicalfishx', '', NULL, NULL, 0, '', 1, 1394356975, NULL, NULL, NULL, 1),
(13, '21232f297a57a5a743894a0e4a801fc3', 'admin', '', NULL, NULL, NULL, '', 2, NULL, NULL, NULL, NULL, 1),
(14, '7ff6e29783d30f6b09bfd54138a9222a', 'f_fuelitup.fuel', 'Fuelitup Fuel', 'dev@fuel-it-up.com', NULL, 0, '', 1, 1395202616, NULL, NULL, NULL, 1),
(15, '3446d1587bf4b029704f80e32a5bc03d', 'f_tony.zhu.10004', 'Tony Zhu', 'tonysh518@gmail.com', NULL, 0, '', 1, 1395289632, NULL, NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `video`
--

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=16 ;

--
-- Dumping data for table `video`
--

INSERT INTO `video` (`vid`, `url`, `title`, `thumbnail`, `datetime`, `status`, `position`, `mid`, `rank`, `phase`, `ribbon`) VALUES
(13, 'https://www.youtube.com/watch?v=RaNfoclPlRo', 'CARAMBAR THE COUNTRYWIDE JOKE', '/uploads/2014/3/20/video13.jpg', 1395332486, 1, 2, 'RaNfoclPlRo', 0, '1', 2),
(14, 'https://www.youtube.com/watch?v=A9OuCxM56bk', 'Pourquoi je n''aime pas YVES ROCHER?', '/uploads/2014/3/20/video14.jpg', 1395332368, 1, 1, 'A9OuCxM56bk', 0, '1', 1),
(15, 'https://www.youtube.com/watch?v=m4ASUibmfos', 'Tuto Fimo : Carambar', '/uploads/2014/3/20/video15.jpg', 1395332276, 1, 1, 'm4ASUibmfos', 0, '', 1);

-- --------------------------------------------------------

--
-- Table structure for table `vote`
--

CREATE TABLE `vote` (
  `vote_id` int(100) NOT NULL AUTO_INCREMENT,
  `vid` int(100) NOT NULL,
  `datetime` varchar(16) NOT NULL,
  PRIMARY KEY (`vote_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=14 ;

--
-- Dumping data for table `vote`
--

INSERT INTO `vote` (`vote_id`, `vid`, `datetime`) VALUES
(1, 1, '1394283385'),
(2, 1, '1394284096'),
(3, 3, '1394284158'),
(4, 3, '1394284409'),
(5, 2, '1394284414'),
(6, 3, '1394285687'),
(7, 3, '1394285716'),
(8, 3, '1394285816'),
(9, 2, '1394285845'),
(10, 3, '1394294287'),
(11, 2, '1394296214'),
(12, 1, '1394345888'),
(13, 1, '1394356955');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
