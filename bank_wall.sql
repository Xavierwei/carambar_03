-- phpMyAdmin SQL Dump
-- version 4.0.6
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Feb 20, 2014 at 05:09 PM
-- Server version: 5.5.33
-- PHP Version: 5.5.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `bank_wall`
--

-- --------------------------------------------------------

--
-- Table structure for table `comment`
--

CREATE TABLE `comment` (
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL,
  `content` text,
  `datetime` int(11) DEFAULT NULL,
  `nid` int(11) DEFAULT '0',
  `status` int(2) NOT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=112 ;

--
-- Dumping data for table `comment`
--

INSERT INTO `comment` (`cid`, `uid`, `content`, `datetime`, `nid`, `status`) VALUES
(2, 12, 'I am at #Starbar and work for #Shanghai Company', NULL, 1, 0),
(3, 12, 'I am at #Starbar and work for #Shanghai Company', NULL, 1, 0),
(4, 12, 'I am at #Starbar and work for #Shanghai Company', 1388271018, 1, 0),
(5, 12, 'I am at #Starbar and work for #Shanghai Company', 1388271027, 1, 0),
(6, 12, 'test', 1389423952, 21, 0),
(7, 12, 'fsdf', 1389425642, 21, 0),
(8, 12, 'fsdf', 1389425696, 21, 0),
(9, 12, 'OK!', 1389425860, 21, 0),
(10, 12, 'fds', 1389425941, 21, 0),
(11, 12, 'fsdf', 1389426073, 21, 0),
(12, 12, 'fsdf', 1389426074, 21, 0),
(13, 12, 'fsdf', 1389426108, 21, 0),
(14, 12, 'fsdf', 1389426108, 21, 0),
(15, 12, 'fsd', 1389426150, 21, 0),
(16, 12, 'ccc', 1389450693, 25, 0),
(17, 12, 'fjkdsjfkd', 1391144305, 193, 0),
(18, 12, 'fdsfdfdf', 1391144311, 204, 0),
(19, 12, 'fdeeeff', 1391144319, 204, 0),
(20, 12, 'fsdfdsf', 1391144656, 204, 0),
(21, 12, 'fsdfdsf', 1391144662, 204, 0),
(22, 12, 'ffffff\n', 1391147822, 204, 0),
(23, 12, '33333', 1391148177, 204, 0),
(24, 12, '3323', 1391148186, 204, 0),
(25, 12, 'fdsfdsf', 1391148226, 204, 0),
(26, 12, 'dsfdfdsf', 1391148239, 204, 0),
(27, 12, 'fsdfdf', 1391148267, 204, 0),
(28, 37, 'fsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdffsdf', 1391170897, 204, 0),
(29, 12, 'fdsf', 1391171028, 203, 0),
(30, 12, 'sdfdsfdsfd', 1391171035, 203, 0),
(31, 12, 'sdfdsfdsfdfsd', 1391171039, 203, 0),
(32, 12, 'sdfdsfdsfdfsd', 1391171043, 203, 0),
(33, 12, 'ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff', 1391171235, 203, 0),
(34, 12, 'ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdffafdsfdsf', 1391171243, 203, 0),
(35, 12, 'fdsf', 1391171611, 201, 0),
(36, 12, 'fdsf', 1391171615, 201, 0),
(37, 12, 'fdsf', 1391171618, 201, 0),
(38, 12, 'fdsf', 1391171621, 201, 0),
(46, 12, 'ok!', 1391305381, 214, 0),
(49, 12, 'dsfdsfdsf', 1391305444, 214, 0),
(50, 12, 'fsdfdsf', 1391357309, 204, 0),
(51, 12, 'fsdfdsf', 1391357309, 204, 0),
(52, 12, 'dsfsdfdf', 1391357403, 217, 0),
(53, 4, 'dfsfs', 1392105894, 261, 0),
(54, 4, 'dsfds', 1392105899, 261, 0),
(55, 4, 'fdsfdsfdf', 1392105923, 265, 0),
(56, 4, 'dsdsf', 1392105992, 265, 0),
(57, 4, 'jfkdf\n', 1392177301, 254, 0),
(58, 4, 'fsfdsf', 1392177305, 254, 0),
(59, 4, 'fdsfdsf', 1392177308, 254, 0),
(60, 4, 'dfsfdsffd', 1392177312, 254, 0),
(61, 4, 'fdsfdsf', 1392177317, 254, 0),
(62, 4, 'fdsfdsaf', 1392177320, 254, 0),
(74, 4, 'fdsfdf', 1392603138, 170, 0),
(75, 4, 'fdsfdsf', 1392603145, 170, 0),
(76, 4, 'fdsfdsf', 1392603208, 197, 0),
(77, 4, 'fdsfdf', 1392603212, 197, 0),
(78, 4, 'fdfdsfdf', 1392603453, 197, 0),
(79, 4, 'fdsfdsfdsf', 1392603670, 197, 0),
(80, 4, 'fdsfdsf\ndff\nd\nf\ndsf\ndsfdsf', 1392603676, 197, 0),
(81, 4, 'fdfdfdsfdf', 1392603680, 197, 0),
(82, 4, '<script>alert(1);</script>', 1392603695, 197, 0),
(83, 4, '&lt;script&gt;alert(1);&lt;/script&gt;', 1392604204, 197, 0),
(84, 4, '&lt;&lt;&lt;^@#&amp;&amp;#$&amp;*#*(@', 1392604243, 163, 0),
(85, 4, '@', 1392604249, 163, 0),
(86, 4, '#$%^&amp;*()_', 1392604258, 163, 0),
(87, 4, '&lt;&gt;', 1392604264, 163, 0),
(88, 4, '&lt;&gt;', 1392604373, 170, 0),
(89, 4, '&lt;span&gt;&lt;/span&gt;', 1392604448, 170, 0),
(90, 4, '<script>alert(1);</script>', 1392604522, 170, 0),
(91, 4, 'good !!@#$%^&amp;*()=-', 1392604965, 170, 0),
(100, 4, '333', 1392696544, 199, 0),
(101, 4, 'fdsfdf', 1392696548, 199, 0),
(102, 4, 'fsdfdf', 1392696577, 171, 0),
(103, 4, 'fdsf', 1392696657, 171, 1),
(104, 4, 'haha', 1392697854, 171, 0),
(105, 4, 'Ok!', 1392778829, 282, 1),
(106, 4, 'fdfdf\n', 1392779022, 170, 1),
(107, 4, 'dddddd', 1392779052, 170, 1),
(108, 4, 'fdsf332', 1392779058, 170, 0),
(109, 4, 'vdfdfd', 1392779063, 170, 0),
(110, 4, 'd1233', 1392779068, 170, 1),
(111, 4, '111111', 1392779073, 170, 0);

-- --------------------------------------------------------

--
-- Table structure for table `country`
--

CREATE TABLE `country` (
  `country_id` int(11) NOT NULL AUTO_INCREMENT,
  `country_name` varchar(45) DEFAULT NULL,
  `code` varchar(45) DEFAULT NULL,
  `flag_icon` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`country_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=78 ;

--
-- Dumping data for table `country`
--

INSERT INTO `country` (`country_id`, `country_name`, `code`, `flag_icon`) VALUES
(1, 'South Africa', 'south africa', 'south africa'),
(2, 'Albania', 'albania', 'albania'),
(3, 'Algeria', 'algeria', 'algeria'),
(4, 'Germany', 'germany', 'germany'),
(5, 'Saudi', 'saudi', 'saudi'),
(6, 'Arabia', 'arabia', 'arabia'),
(7, 'Argentina', 'argentina', 'argentina'),
(8, 'Australia', 'australia', 'australia'),
(9, 'Austria', 'austria', 'austria'),
(10, 'Bahamas', 'bahamas', 'bahamas'),
(11, 'Belgium', 'belgium', 'belgium'),
(12, 'Benin', 'benin', 'benin'),
(13, 'Brazil', 'brazil', 'brazil'),
(14, 'Bulgaria', 'bulgaria', 'bulgaria'),
(15, 'Burkina Faso', 'burkina faso', 'burkina faso'),
(16, 'Canada', 'canada', 'canada'),
(17, 'Chile', 'chile', 'chile'),
(18, 'China', 'china', 'china'),
(19, 'Cyprus', 'cyprus', 'cyprus'),
(20, 'Korea', 'korea', 'korea'),
(21, 'Republic of Ivory Coast', 'republic of ivory coast', 'republic of ivory coast'),
(22, 'Croatia', 'croatia', 'croatia'),
(23, 'Denmark', 'denmark', 'denmark'),
(24, 'Egypt', 'egypt', 'egypt'),
(25, 'United Arab Emirates', 'united arab emirates', 'united arab emirates'),
(26, 'Spain', 'spain', 'spain'),
(27, 'Estonia', 'estonia', 'estonia'),
(28, 'USA', 'usa', 'usa'),
(29, 'Finland', 'finland', 'finland'),
(30, 'France', 'france', 'france'),
(31, 'Georgia', 'georgia', 'georgia'),
(32, 'Ghana', 'ghana', 'ghana'),
(33, 'Greece', 'greece', 'greece'),
(34, 'Guinea', 'guinea', 'guinea'),
(35, 'Equatorial Guinea', 'equatorial guinea', 'equatorial guinea'),
(36, 'Hungary', 'hungary', 'hungary'),
(37, 'India', 'india', 'india'),
(38, 'Ireland', 'ireland', 'ireland'),
(39, 'Italy', 'italy', 'italy'),
(40, 'Japan', 'japan', 'japan'),
(41, 'Jordan', 'jordan', 'jordan'),
(42, 'Latvia', 'latvia', 'latvia'),
(43, 'Lebanon', 'lebanon', 'lebanon'),
(44, 'Lithuania', 'lithuania', 'lithuania'),
(45, 'Luxembourg', 'luxembourg', 'luxembourg'),
(46, 'Macedonia', 'macedonia', 'macedonia'),
(47, 'Madagascar', 'madagascar', 'madagascar'),
(48, 'Morocco', 'morocco', 'morocco'),
(49, 'Mauritania', 'mauritania', 'mauritania'),
(50, 'Mexico', 'mexico', 'mexico'),
(51, 'Moldova', 'moldova', 'moldova'),
(52, 'Republic of Montenegro', 'republic of montenegro', 'republic of montenegro'),
(53, 'Norway', 'norway', 'norway'),
(54, 'New Caledonia', 'new caledonia', 'new caledonia'),
(55, 'Panama', 'panama', 'panama'),
(56, 'Netherlands', 'netherlands', 'netherlands'),
(57, 'Peru', 'peru', 'peru'),
(58, 'Poland', 'poland', 'poland'),
(59, 'Portugal', 'portugal', 'portugal'),
(60, 'Reunion', 'reunion', 'reunion'),
(61, 'Romania', 'romania', 'romania'),
(62, 'UK', 'uk', 'uk'),
(63, 'Russian Federation', 'russian federation', 'russian federation'),
(64, 'Senegal', 'senegal', 'senegal'),
(65, 'Serbia', 'serbia', 'serbia'),
(66, 'Singapore', 'singapore', 'singapore'),
(67, 'Slovakia', 'slovakia', 'slovakia'),
(68, 'Slovenia', 'slovenia', 'slovenia'),
(69, 'Sweden', 'sweden', 'sweden'),
(70, 'Switzerland', 'switzerland', 'switzerland'),
(71, 'Chad', 'chad', 'chad'),
(72, 'Czech Republic', 'czech republic', 'czech republic'),
(73, 'Tunisia', 'tunisia', 'tunisia'),
(74, 'Turkey', 'turkey', 'turkey'),
(75, 'Ukraine', 'ukraine', 'ukraine'),
(76, 'Uruguay', 'uruguay', 'uruguay'),
(77, 'Vietnam', 'vietnam', 'vietnam');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=26 ;

--
-- Dumping data for table `flag`
--

INSERT INTO `flag` (`flag_id`, `nid`, `uid`, `datetime`, `cid`, `comment_nid`) VALUES
(18, 204, 12, 1391165802, 0, NULL),
(19, 214, 12, 1391266459, 0, NULL),
(20, 0, 12, 1391269647, 39, NULL),
(21, 212, 12, 1391270483, 0, NULL),
(22, 211, 12, 1391270509, 0, NULL),
(23, 0, 12, 1391270545, 18, 204),
(24, 0, 12, 1391270906, 19, 204),
(25, 0, 12, 1391272003, 21, 204);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=148 ;

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
(126, 268, 4, 1392288938),
(127, 267, 4, 1392288941),
(128, 270, 4, 1392351452),
(129, 269, 4, 1392351591),
(130, 256, 4, 1392351687),
(131, 265, 4, 1392351696),
(135, 170, 4, 1392602256),
(142, 71, 4, 1392608129),
(146, 282, 4, 1392776490);

-- --------------------------------------------------------

--
-- Table structure for table `node`
--

CREATE TABLE `node` (
  `nid` int(15) NOT NULL AUTO_INCREMENT,
  `uid` int(15) DEFAULT NULL,
  `country_id` int(15) DEFAULT NULL,
  `type` varchar(45) DEFAULT NULL,
  `file` varchar(255) DEFAULT NULL,
  `datetime` int(11) DEFAULT NULL,
  `hashtag` varchar(200) DEFAULT NULL,
  `description` text,
  `status` int(11) DEFAULT '0',
  PRIMARY KEY (`nid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=289 ;

--
-- Dumping data for table `node`
--

INSERT INTO `node` (`nid`, `uid`, `country_id`, `type`, `file`, `datetime`, `hashtag`, `description`, `status`) VALUES
(62, 4, 1, 'photo', '/uploads/p62.jpg', 1389489709, 'a:0:{}', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', 1),
(63, 4, 1, 'photo', '/uploads/p63.jpg', 1389489716, 'a:0:{}', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', 1),
(64, 4, 1, 'photo', '/uploads/p64.jpg', 1389489721, 'a:0:{}', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', 1),
(65, 4, 1, 'photo', '/uploads/p65.jpg', 1389489727, 'a:0:{}', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', 1),
(66, 4, 1, 'photo', '/uploads/p66.jpg', 1389489731, 'a:0:{}', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', 1),
(67, 4, 1, 'photo', '/uploads/p67.jpg', 1389489736, 'a:0:{}', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', 1),
(68, 4, 1, 'photo', '/uploads/p68.jpg', 1389489742, 'a:0:{}', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', 1),
(69, 4, 1, 'photo', '/uploads/p69.jpg', 1389489747, 'a:0:{}', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', 1),
(70, 4, 1, 'photo', '/uploads/p70.jpg', 1389489751, 'a:0:{}', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', 1),
(71, 4, 1, 'photo', '/uploads/p71.jpg', 1389489755, 'a:0:{}', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', 1),
(72, 4, 1, 'photo', '/uploads/p72.jpg', 1389489760, 'a:0:{}', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', 1),
(73, 4, 1, 'photo', '/uploads/p73.jpg', 1389489765, 'a:0:{}', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', 1),
(74, 4, 1, 'photo', '/uploads/p74.jpg', 1389489770, 'a:0:{}', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', 1),
(75, 4, 1, 'photo', '/uploads/p75.jpg', 1389489775, 'a:0:{}', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', 1),
(76, 4, 1, 'photo', '/uploads/p76.jpg', 1389489779, 'a:0:{}', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', 1),
(77, 4, 1, 'photo', '/uploads/p77.jpg', 1389489784, 'a:0:{}', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', 1),
(78, 4, 1, 'photo', '/uploads/p78.jpg', 1389489789, 'a:0:{}', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', 1),
(79, 4, 1, 'photo', '/uploads/p79.jpg', 1389489796, 'a:0:{}', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', 1),
(80, 4, 1, 'photo', '/uploads/p80.jpg', 1389489799, 'a:0:{}', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', 1),
(81, 4, 1, 'photo', '/uploads/p81.jpg', 1389489803, 'a:0:{}', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', 1),
(82, 4, 1, 'photo', '/uploads/p82.jpg', 1389489806, 'a:0:{}', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', 1),
(83, 4, 1, 'photo', '/uploads/p83.jpg', 1389489809, 'a:0:{}', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', 1),
(84, 4, 1, 'photo', '/uploads/p84.jpg', 1389489813, 'a:0:{}', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', 1),
(85, 4, 1, 'photo', '/uploads/p85.jpg', 1389489817, 'a:0:{}', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', 1),
(86, 4, 1, 'photo', '/uploads/p86.jpg', 1389489821, 'a:0:{}', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', 1),
(87, 4, 1, 'photo', '/uploads/p87.jpg', 1389489824, 'a:0:{}', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', 1),
(88, 4, 1, 'photo', '/uploads/p88.jpg', 1389489831, 'a:0:{}', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', 1),
(89, 4, 1, 'photo', '/uploads/p89.jpg', 1389489835, 'a:0:{}', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', 1),
(90, 4, 1, 'photo', '/uploads/p90.jpg', 1389489838, 'a:0:{}', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', 1),
(91, 4, 1, 'photo', '/uploads/p91.jpg', 1389489843, 'a:0:{}', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', 1),
(92, 4, 1, 'photo', '/uploads/p92.jpg', 1389489846, 'a:0:{}', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', 1),
(93, 4, 1, 'photo', '/uploads/p93.jpg', 1389489849, 'a:0:{}', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', 1),
(94, 4, 1, 'photo', '/uploads/p94.jpg', 1389489854, 'a:0:{}', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', 1),
(95, 4, 1, 'photo', '/uploads/p95.jpg', 1389489857, 'a:0:{}', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', 1),
(96, 4, 1, 'photo', '/uploads/p96.jpg', 1389489862, 'a:0:{}', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', 1),
(97, 4, 1, 'photo', '/uploads/p97.jpg', 1389489865, 'a:0:{}', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', 1),
(98, 4, 1, 'photo', '/uploads/p98.jpg', 1389489869, 'a:0:{}', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', 1),
(99, 4, 1, 'photo', '/uploads/p99.jpg', 1389489876, 'a:0:{}', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', 1),
(100, 4, 1, 'photo', '/uploads/p100.jpg', 1389489880, 'a:0:{}', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', 1),
(101, 4, 1, 'photo', '/uploads/p101.jpg', 1389489883, 'a:0:{}', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', 1),
(102, 4, 1, 'photo', '/uploads/p102.jpg', 1389489887, 'a:0:{}', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', 1),
(103, 4, 1, 'photo', '/uploads/p103.jpg', 1389489890, 'a:0:{}', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', 1),
(104, 4, 1, 'photo', '/uploads/p104.jpg', 1389489894, 'a:0:{}', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', 1),
(105, 4, 1, 'photo', '/uploads/p105.jpg', 1389489897, 'a:0:{}', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', 1),
(106, 4, 1, 'photo', '/uploads/p106.jpg', 1389489900, 'a:0:{}', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', 1),
(107, 4, 1, 'photo', '/uploads/p107.jpg', 1389489904, 'a:0:{}', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', 1),
(108, 4, 1, 'photo', '/uploads/p108.jpg', 1389489908, 'a:0:{}', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', 1),
(109, 4, 1, 'photo', '/uploads/p109.jpg', 1389489912, 'a:0:{}', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', 1),
(110, 4, 1, 'photo', '/uploads/p110.jpg', 1389490088, 'a:0:{}', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', 1),
(111, 4, 1, 'photo', '/uploads/p111.jpg', 1389490093, 'a:0:{}', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', 1),
(112, 4, 1, 'photo', '/uploads/p112.jpg', 1389490096, 'a:0:{}', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', 1),
(113, 4, 1, 'photo', '/uploads/p113.jpg', 1389490099, 'a:0:{}', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', 1),
(114, 4, 1, 'photo', '/uploads/p114.jpg', 1389490103, 'a:0:{}', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', 1),
(115, 4, 1, 'photo', '/uploads/p115.jpg', 1389490106, 'a:0:{}', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', 1),
(116, 4, 1, 'photo', '/uploads/p116.jpg', 1389490109, 'a:0:{}', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', 1),
(117, 4, 1, 'photo', '/uploads/p117.jpg', 1389490113, 'a:0:{}', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', 1),
(118, 4, 1, 'photo', '/uploads/p118.jpg', 1389490116, 'a:0:{}', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', 1),
(119, 4, 1, 'photo', '/uploads/p119.jpg', 1389490120, 'a:0:{}', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', 1),
(120, 4, 1, 'photo', '/uploads/p120.jpg', 1389490124, 'a:0:{}', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', 1),
(121, 4, 1, 'video', '/uploads/v121.mp4', 1389490986, 'a:0:{}', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', 1),
(122, 4, 1, 'video', '/uploads/v122.mp4', 1389491072, 'a:0:{}', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', 1),
(123, 4, 1, 'video', '/uploads/v123.mp4', 1389491201, 'a:0:{}', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', 1),
(124, 4, 1, 'video', '/uploads/v124.mp4', 1389491249, 'a:0:{}', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', 1),
(125, 4, 1, 'video', '/uploads/v125.mp4', 1389493079, 'a:0:{}', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.', 1),
(155, 4, 1, 'photo', '/uploads/p155.jpg', 1389496804, 'a:0:{}', NULL, 1),
(156, 4, 1, 'photo', '/uploads/p156.jpg', 1389496808, 'a:0:{}', NULL, 1),
(157, 4, 1, 'photo', '/uploads/p157.jpg', 1389496811, 'a:0:{}', NULL, 1),
(158, 4, 1, 'photo', '/uploads/p158.jpg', 1389496816, 'a:0:{}', NULL, 1),
(159, 4, 1, 'photo', '/uploads/p159.jpg', 1389496820, 'a:0:{}', NULL, 1),
(160, 4, 1, 'photo', '/uploads/p160.jpg', 1389715200, 'a:0:{}', NULL, 1),
(161, 4, 1, 'photo', '/uploads/p161.jpg', 1389496829, 'a:0:{}', NULL, 1),
(162, 4, 1, 'photo', '/uploads/p162.jpg', 1389496835, 'a:0:{}', NULL, 1),
(163, 4, 1, 'photo', '/uploads/p163.jpg', 1389801600, 'a:0:{}', NULL, 1),
(164, 4, 1, 'photo', '/uploads/p164.jpg', 1389801600, 'a:0:{}', NULL, 1),
(165, 4, 1, 'photo', '/uploads/p165.jpg', 1389801600, 'a:0:{}', NULL, 1),
(166, 4, 1, 'photo', '/uploads/p166.jpg', 1389496851, 'a:0:{}', NULL, 1),
(167, 4, 1, 'photo', '/uploads/p167.jpg', 1389496855, 'a:0:{}', NULL, 1),
(168, 4, 1, 'video', '/uploads/v168.mp4', 1389496865, 'a:0:{}', NULL, 1),
(169, 4, 1, 'photo', '/uploads/p169.jpg', 1389496892, 'a:0:{}', NULL, 1),
(170, 4, 1, 'photo', '/uploads/p170.jpg', 1389974400, 'a:0:{}', NULL, 1),
(171, 4, 1, 'photo', '/uploads/p171.jpg', 1389974400, 'a:0:{}', NULL, 1),
(172, 4, 1, 'photo', '/uploads/p172.jpg', 1389496904, 'a:0:{}', NULL, 1),
(173, 4, 1, 'photo', '/uploads/p173.jpg', 1389496907, 'a:0:{}', NULL, 1),
(174, 4, 1, 'photo', '/uploads/p174.jpg', 1389496916, 'a:0:{}', NULL, 1),
(175, 4, 1, 'photo', '/uploads/p175.jpg', 1389496920, 'a:0:{}', NULL, 1),
(176, 4, 1, 'photo', '/uploads/p176.jpg', 1389496931, 'a:0:{}', NULL, 1),
(177, 4, 1, 'photo', '/uploads/p177.jpg', 1389496934, 'a:0:{}', NULL, 1),
(178, 4, 1, 'photo', '/uploads/p178.jpg', 1389496943, 'a:0:{}', NULL, 1),
(179, 4, 1, 'photo', '/uploads/p179.jpg', 1389496948, 'a:0:{}', NULL, 1),
(180, 4, 1, 'photo', '/uploads/p180.jpg', 1389496953, 'a:0:{}', NULL, 1),
(181, 4, 1, 'photo', '/uploads/p181.jpg', 1389496998, 'a:0:{}', NULL, 1),
(182, 4, 1, 'photo', '/uploads/p182.jpg', 1389497012, 'a:0:{}', NULL, 1),
(183, 4, 1, 'photo', '/uploads/p183.jpg', 1389497061, 'a:0:{}', NULL, 1),
(184, 4, 1, 'photo', '/uploads/p184.jpg', 1389497080, 'a:0:{}', NULL, 1),
(185, 4, 1, 'photo', '/uploads/p185.jpg', 1389497114, 'a:0:{}', NULL, 1),
(186, 4, 1, 'photo', '/uploads/p186.jpg', 1389497134, 'a:0:{}', NULL, 1),
(187, 4, 1, 'photo', '/uploads/p187.jpg', 1389497166, 'a:0:{}', NULL, 1),
(188, 4, 1, 'photo', '/uploads/p188.jpg', 1389497240, 'a:0:{}', NULL, 1),
(189, 4, 1, 'photo', '/uploads/p189.jpg', 1389497333, 'a:0:{}', NULL, 1),
(190, 4, 1, 'photo', '/uploads/p190.jpg', 1389497404, 'a:0:{}', NULL, 1),
(191, 4, 1, 'photo', '/uploads/p191.jpg', 1389497413, 'a:0:{}', NULL, 1),
(192, 4, 1, 'photo', '/uploads/p192.jpg', 1389497464, 'a:0:{}', NULL, 1),
(193, 4, 1, 'photo', '/uploads/p193.jpg', 1389497478, 'a:0:{}', NULL, 1),
(194, 4, 1, 'photo', '/uploads/p194.jpg', 1389497500, 'a:0:{}', NULL, 1),
(197, 4, 1, 'photo', '/uploads/p197.jpg', 1390277398, 'a:0:{}', NULL, 1),
(199, 4, 1, 'video', '/uploads/v199.mp4', 1390280795, 'a:0:{}', NULL, 0),
(201, 4, 1, 'photo', '/uploads/p201.jpg', 1390281204, 'a:0:{}', NULL, 0),
(273, 4, 30, 'photo', '/uploads/2014/2/17/p273.jpg', 1392607344, 'a:0:{}', 'dsfds', 1),
(282, 4, 30, 'photo', '/uploads/2014/2/18/p282.jpg', 1392713160, 'a:1:{i:0;s:4:"snow";}', '#snow', 1),
(283, 4, 30, 'photo', '/uploads/2014/2/19/p283.jpg', 1392778746, 'a:0:{}', 'fsdf', 1),
(284, 4, 30, 'photo', '/uploads/2014/2/19/p284.jpg', 1392779791, 'a:0:{}', 'dsdf', 1),
(285, 4, 30, 'photo', '/uploads/2014/2/19/p285.jpg', 1392779827, 'a:0:{}', 'fdsfdf', 0),
(286, 4, 30, 'photo', '/uploads/2014/2/19/p286.jpg', 1392779892, 'a:0:{}', 'dfdf', 0),
(287, 4, 30, 'photo', '/uploads/2014/2/19/p287.jpg', 1392780926, 'a:0:{}', 'fdf', 0),
(288, 4, 30, 'photo', '/uploads/2014/2/19/p288.jpg', 1392780943, 'a:0:{}', '中文！', 1);

-- --------------------------------------------------------

--
-- Table structure for table `saml_kvstore`
--

CREATE TABLE `saml_kvstore` (
  `_type` varchar(30) NOT NULL,
  `_key` varchar(50) NOT NULL,
  `_value` text NOT NULL,
  `_expire` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`_key`,`_type`),
  KEY `saml_kvstore_expire` (`_expire`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `saml_kvstore`
--

INSERT INTO `saml_kvstore` (`_type`, `_key`, `_value`, `_expire`) VALUES
('session', 'b83ceaedbe785aa4cefd2def889bb96c', 'O%3A18%3A%22SimpleSAML_Session%22%3A20%3A%7Bs%3A29%3A%22%00SimpleSAML_Session%00sessionId%22%3Bs%3A32%3A%22b83ceaedbe785aa4cefd2def889bb96c%22%3Bs%3A29%3A%22%00SimpleSAML_Session%00transient%22%3Bb%3A0%3Bs%3A27%3A%22%00SimpleSAML_Session%00trackid%22%3Bs%3A10%3A%22d2e1851509%22%3Bs%3A23%3A%22%00SimpleSAML_Session%00idp%22%3BN%3Bs%3A33%3A%22%00SimpleSAML_Session%00authenticated%22%3BN%3Bs%3A30%3A%22%00SimpleSAML_Session%00attributes%22%3BN%3Bs%3A32%3A%22%00SimpleSAML_Session%00sessionindex%22%3BN%3Bs%3A26%3A%22%00SimpleSAML_Session%00nameid%22%3BN%3Bs%3A29%3A%22%00SimpleSAML_Session%00authority%22%3Bs%3A10%3A%22default-sp%22%3Bs%3A34%3A%22%00SimpleSAML_Session%00sessionstarted%22%3BN%3Bs%3A35%3A%22%00SimpleSAML_Session%00sessionduration%22%3BN%3Bs%3A25%3A%22%00SimpleSAML_Session%00dirty%22%3Bb%3A0%3Bs%3A35%3A%22%00SimpleSAML_Session%00logout_handlers%22%3Ba%3A0%3A%7B%7Ds%3A29%3A%22%00SimpleSAML_Session%00dataStore%22%3Ba%3A2%3A%7Bs%3A21%3A%22SimpleSAML_Auth_State%22%3Ba%3A0%3A%7B%7Ds%3A38%3A%22SimpleSAML_Auth_Source.LogoutCallbacks%22%3Ba%3A1%3A%7Bs%3A37%3A%2210%3Adefault-sphttps%3A%2F%2Fopenidp.feide.no%22%3Ba%3A3%3A%7Bs%3A7%3A%22expires%22%3Bs%3A13%3A%22logoutTimeout%22%3Bs%3A7%3A%22timeout%22%3Bs%3A13%3A%22logoutTimeout%22%3Bs%3A4%3A%22data%22%3Ba%3A2%3A%7Bs%3A8%3A%22callback%22%3Ba%3A2%3A%7Bi%3A0%3Bs%3A23%3A%22SimpleSAML_Auth_Default%22%3Bi%3A1%3Bs%3A14%3A%22logoutCallback%22%3B%7Ds%3A5%3A%22state%22%3Ba%3A1%3A%7Bs%3A36%3A%22SimpleSAML_Auth_Default.logoutSource%22%3Bs%3A10%3A%22default-sp%22%3B%7D%7D%7D%7D%7Ds%3A33%3A%22%00SimpleSAML_Session%00sessionNameId%22%3BN%3Bs%3A31%3A%22%00SimpleSAML_Session%00logoutState%22%3BN%3Bs%3A29%3A%22%00SimpleSAML_Session%00authState%22%3BN%3Bs%3A32%3A%22%00SimpleSAML_Session%00associations%22%3Ba%3A0%3A%7B%7Ds%3A29%3A%22%00SimpleSAML_Session%00authToken%22%3Bs%3A43%3A%22_959e8e5b567ea3695001f1a91e11a3da9157ed6170%22%3Bs%3A28%3A%22%00SimpleSAML_Session%00authData%22%3Ba%3A1%3A%7Bs%3A10%3A%22default-sp%22%3Ba%3A10%3A%7Bs%3A28%3A%22saml%3AAuthenticatingAuthority%22%3Ba%3A1%3A%7Bi%3A0%3Bs%3A24%3A%22https%3A%2F%2Fopenidp.feide.no%22%3B%7Ds%3A14%3A%22saml%3Asp%3ANameID%22%3Ba%3A3%3A%7Bs%3A5%3A%22Value%22%3Bs%3A43%3A%22_cb6d6c4cff27a235b4a540104a82c1e13989c6fe4c%22%3Bs%3A15%3A%22SPNameQualifier%22%3Bs%3A96%3A%22http%3A%2F%2Flocalhost%3A8888%2Fbank_wall%2Fapi%2Fsimplesamlphp%2Fwww%2Fmodule.php%2Fsaml%2Fsp%2Fmetadata.php%2Fdefault-sp%22%3Bs%3A6%3A%22Format%22%3Bs%3A51%3A%22urn%3Aoasis%3Anames%3Atc%3ASAML%3A2.0%3Anameid-format%3Atransient%22%3B%7Ds%3A20%3A%22saml%3Asp%3ASessionIndex%22%3Bs%3A43%3A%22_6a643f0c9e7ba7de3e6a8941f4493273a535c15c66%22%3Bs%3A20%3A%22saml%3Asp%3AAuthnContext%22%3Bs%3A47%3A%22urn%3Aoasis%3Anames%3Atc%3ASAML%3A2.0%3Aac%3Aclasses%3APassword%22%3Bs%3A16%3A%22saml%3Asp%3AprevAuth%22%3Ba%3A3%3A%7Bs%3A2%3A%22id%22%3Bs%3A43%3A%22_311b1947822d00f0b8876bc4acecb88e8143e84640%22%3Bs%3A6%3A%22issuer%22%3Bs%3A24%3A%22https%3A%2F%2Fopenidp.feide.no%22%3Bs%3A8%3A%22redirect%22%3Bs%3A50%3A%22http%3A%2F%2Flocalhost%3A8888%2Fbank_wall%2Fapi%2Fuser%2Fsamllogin%22%3B%7Ds%3A11%3A%22saml%3Asp%3AIdP%22%3Bs%3A24%3A%22https%3A%2F%2Fopenidp.feide.no%22%3Bs%3A10%3A%22Attributes%22%3Ba%3A15%3A%7Bs%3A3%3A%22uid%22%3Ba%3A1%3A%7Bi%3A0%3Bs%3A6%3A%22sgtest%22%3B%7Ds%3A9%3A%22givenName%22%3Ba%3A1%3A%7Bi%3A0%3Bs%3A2%3A%22sg%22%3B%7Ds%3A2%3A%22sn%22%3Ba%3A1%3A%7Bi%3A0%3Bs%3A4%3A%22test%22%3B%7Ds%3A2%3A%22cn%22%3Ba%3A1%3A%7Bi%3A0%3Bs%3A7%3A%22sg%20test%22%3B%7Ds%3A4%3A%22mail%22%3Ba%3A1%3A%7Bi%3A0%3Bs%3A22%3A%22devtest%40fuel-it-up.com%22%3B%7Ds%3A22%3A%22eduPersonPrincipalName%22%3Ba%3A1%3A%7Bi%3A0%3Bs%3A19%3A%22sgtest%40rnd.feide.no%22%3B%7Ds%3A19%3A%22eduPersonTargetedID%22%3Ba%3A1%3A%7Bi%3A0%3Bs%3A40%3A%220bdefd5881486cb00eb46fe97c1288da4227b3af%22%3B%7Ds%3A33%3A%22urn%3Aoid%3A0.9.2342.19200300.100.1.1%22%3Ba%3A1%3A%7Bi%3A0%3Bs%3A6%3A%22sgtest%22%3B%7Ds%3A16%3A%22urn%3Aoid%3A2.5.4.42%22%3Ba%3A1%3A%7Bi%3A0%3Bs%3A2%3A%22sg%22%3B%7Ds%3A15%3A%22urn%3Aoid%3A2.5.4.4%22%3Ba%3A1%3A%7Bi%3A0%3Bs%3A4%3A%22test%22%3B%7Ds%3A15%3A%22urn%3Aoid%3A2.5.4.3%22%3Ba%3A1%3A%7Bi%3A0%3Bs%3A7%3A%22sg%20test%22%3B%7Ds%3A33%3A%22urn%3Aoid%3A0.9.2342.19200300.100.1.3%22%3Ba%3A1%3A%7Bi%3A0%3Bs%3A22%3A%22devtest%40fuel-it-up.com%22%3B%7Ds%3A32%3A%22urn%3Aoid%3A1.3.6.1.4.1.5923.1.1.1.6%22%3Ba%3A1%3A%7Bi%3A0%3Bs%3A19%3A%22sgtest%40rnd.feide.no%22%3B%7Ds%3A33%3A%22urn%3Aoid%3A1.3.6.1.4.1.5923.1.1.1.10%22%3Ba%3A1%3A%7Bi%3A0%3Bs%3A40%3A%220bdefd5881486cb00eb46fe97c1288da4227b3af%22%3B%7Ds%3A6%3A%22groups%22%3Ba%3A3%3A%7Bi%3A0%3Bs%3A18%3A%22realm-rnd.feide.no%22%3Bi%3A1%3Bs%3A5%3A%22users%22%3Bi%3A2%3Bs%3A7%3A%22members%22%3B%7D%7Ds%3A6%3A%22Expire%22%3Bi%3A1392896293%3Bs%3A11%3A%22LogoutState%22%3Ba%3A4%3A%7Bs%3A16%3A%22saml%3Alogout%3AType%22%3Bs%3A5%3A%22saml2%22%3Bs%3A15%3A%22saml%3Alogout%3AIdP%22%3Bs%3A24%3A%22https%3A%2F%2Fopenidp.feide.no%22%3Bs%3A18%3A%22saml%3Alogout%3ANameID%22%3Ba%3A3%3A%7Bs%3A5%3A%22Value%22%3Bs%3A43%3A%22_cb6d6c4cff27a235b4a540104a82c1e13989c6fe4c%22%3Bs%3A15%3A%22SPNameQualifier%22%3Bs%3A96%3A%22http%3A%2F%2Flocalhost%3A8888%2Fbank_wall%2Fapi%2Fsimplesamlphp%2Fwww%2Fmodule.php%2Fsaml%2Fsp%2Fmetadata.php%2Fdefault-sp%22%3Bs%3A6%3A%22Format%22%3Bs%3A51%3A%22urn%3Aoasis%3Anames%3Atc%3ASAML%3A2.0%3Anameid-format%3Atransient%22%3B%7Ds%3A24%3A%22saml%3Alogout%3ASessionIndex%22%3Bs%3A43%3A%22_6a643f0c9e7ba7de3e6a8941f4493273a535c15c66%22%3B%7Ds%3A12%3A%22AuthnInstant%22%3Bi%3A1392867495%3B%7D%7D%7D', '2014-02-20 11:38:15'),
('session', 'e14fccb8112b73c125ee95071242e02a', 'O%3A18%3A%22SimpleSAML_Session%22%3A20%3A%7Bs%3A29%3A%22%00SimpleSAML_Session%00sessionId%22%3Bs%3A32%3A%22e14fccb8112b73c125ee95071242e02a%22%3Bs%3A29%3A%22%00SimpleSAML_Session%00transient%22%3Bb%3A0%3Bs%3A27%3A%22%00SimpleSAML_Session%00trackid%22%3Bs%3A10%3A%22d9075909ea%22%3Bs%3A23%3A%22%00SimpleSAML_Session%00idp%22%3BN%3Bs%3A33%3A%22%00SimpleSAML_Session%00authenticated%22%3BN%3Bs%3A30%3A%22%00SimpleSAML_Session%00attributes%22%3BN%3Bs%3A32%3A%22%00SimpleSAML_Session%00sessionindex%22%3BN%3Bs%3A26%3A%22%00SimpleSAML_Session%00nameid%22%3BN%3Bs%3A29%3A%22%00SimpleSAML_Session%00authority%22%3Bs%3A10%3A%22default-sp%22%3Bs%3A34%3A%22%00SimpleSAML_Session%00sessionstarted%22%3BN%3Bs%3A35%3A%22%00SimpleSAML_Session%00sessionduration%22%3BN%3Bs%3A25%3A%22%00SimpleSAML_Session%00dirty%22%3Bb%3A0%3Bs%3A35%3A%22%00SimpleSAML_Session%00logout_handlers%22%3Ba%3A0%3A%7B%7Ds%3A29%3A%22%00SimpleSAML_Session%00dataStore%22%3Ba%3A2%3A%7Bs%3A21%3A%22SimpleSAML_Auth_State%22%3Ba%3A0%3A%7B%7Ds%3A38%3A%22SimpleSAML_Auth_Source.LogoutCallbacks%22%3Ba%3A1%3A%7Bs%3A37%3A%2210%3Adefault-sphttps%3A%2F%2Fopenidp.feide.no%22%3Ba%3A3%3A%7Bs%3A7%3A%22expires%22%3Bs%3A13%3A%22logoutTimeout%22%3Bs%3A7%3A%22timeout%22%3Bs%3A13%3A%22logoutTimeout%22%3Bs%3A4%3A%22data%22%3Ba%3A2%3A%7Bs%3A8%3A%22callback%22%3Ba%3A2%3A%7Bi%3A0%3Bs%3A23%3A%22SimpleSAML_Auth_Default%22%3Bi%3A1%3Bs%3A14%3A%22logoutCallback%22%3B%7Ds%3A5%3A%22state%22%3Ba%3A1%3A%7Bs%3A36%3A%22SimpleSAML_Auth_Default.logoutSource%22%3Bs%3A10%3A%22default-sp%22%3B%7D%7D%7D%7D%7Ds%3A33%3A%22%00SimpleSAML_Session%00sessionNameId%22%3BN%3Bs%3A31%3A%22%00SimpleSAML_Session%00logoutState%22%3BN%3Bs%3A29%3A%22%00SimpleSAML_Session%00authState%22%3BN%3Bs%3A32%3A%22%00SimpleSAML_Session%00associations%22%3Ba%3A0%3A%7B%7Ds%3A29%3A%22%00SimpleSAML_Session%00authToken%22%3Bs%3A43%3A%22_6a18df3a37e840cc08018105e403f613ead64d47aa%22%3Bs%3A28%3A%22%00SimpleSAML_Session%00authData%22%3Ba%3A1%3A%7Bs%3A10%3A%22default-sp%22%3Ba%3A10%3A%7Bs%3A28%3A%22saml%3AAuthenticatingAuthority%22%3Ba%3A1%3A%7Bi%3A0%3Bs%3A24%3A%22https%3A%2F%2Fopenidp.feide.no%22%3B%7Ds%3A14%3A%22saml%3Asp%3ANameID%22%3Ba%3A3%3A%7Bs%3A5%3A%22Value%22%3Bs%3A43%3A%22_c6c895a064641dccb7707e59fb0ce069ba0859f027%22%3Bs%3A15%3A%22SPNameQualifier%22%3Bs%3A96%3A%22http%3A%2F%2Flocalhost%3A8888%2Fbank_wall%2Fapi%2Fsimplesamlphp%2Fwww%2Fmodule.php%2Fsaml%2Fsp%2Fmetadata.php%2Fdefault-sp%22%3Bs%3A6%3A%22Format%22%3Bs%3A51%3A%22urn%3Aoasis%3Anames%3Atc%3ASAML%3A2.0%3Anameid-format%3Atransient%22%3B%7Ds%3A20%3A%22saml%3Asp%3ASessionIndex%22%3Bs%3A43%3A%22_9f8fd53d71b0eda4e1728e1d7d3d39d7fe5f123f59%22%3Bs%3A20%3A%22saml%3Asp%3AAuthnContext%22%3Bs%3A47%3A%22urn%3Aoasis%3Anames%3Atc%3ASAML%3A2.0%3Aac%3Aclasses%3APassword%22%3Bs%3A16%3A%22saml%3Asp%3AprevAuth%22%3Ba%3A3%3A%7Bs%3A2%3A%22id%22%3Bs%3A43%3A%22_7f942c657a89ad3bf3ba376dbcd767c769767cba1a%22%3Bs%3A6%3A%22issuer%22%3Bs%3A24%3A%22https%3A%2F%2Fopenidp.feide.no%22%3Bs%3A8%3A%22redirect%22%3Bs%3A50%3A%22http%3A%2F%2Flocalhost%3A8888%2Fbank_wall%2Fapi%2Fuser%2Fsamllogin%22%3B%7Ds%3A11%3A%22saml%3Asp%3AIdP%22%3Bs%3A24%3A%22https%3A%2F%2Fopenidp.feide.no%22%3Bs%3A10%3A%22Attributes%22%3Ba%3A15%3A%7Bs%3A3%3A%22uid%22%3Ba%3A1%3A%7Bi%3A0%3Bs%3A6%3A%22sgtest%22%3B%7Ds%3A9%3A%22givenName%22%3Ba%3A1%3A%7Bi%3A0%3Bs%3A2%3A%22sg%22%3B%7Ds%3A2%3A%22sn%22%3Ba%3A1%3A%7Bi%3A0%3Bs%3A4%3A%22test%22%3B%7Ds%3A2%3A%22cn%22%3Ba%3A1%3A%7Bi%3A0%3Bs%3A7%3A%22sg%20test%22%3B%7Ds%3A4%3A%22mail%22%3Ba%3A1%3A%7Bi%3A0%3Bs%3A22%3A%22devtest%40fuel-it-up.com%22%3B%7Ds%3A22%3A%22eduPersonPrincipalName%22%3Ba%3A1%3A%7Bi%3A0%3Bs%3A19%3A%22sgtest%40rnd.feide.no%22%3B%7Ds%3A19%3A%22eduPersonTargetedID%22%3Ba%3A1%3A%7Bi%3A0%3Bs%3A40%3A%220bdefd5881486cb00eb46fe97c1288da4227b3af%22%3B%7Ds%3A33%3A%22urn%3Aoid%3A0.9.2342.19200300.100.1.1%22%3Ba%3A1%3A%7Bi%3A0%3Bs%3A6%3A%22sgtest%22%3B%7Ds%3A16%3A%22urn%3Aoid%3A2.5.4.42%22%3Ba%3A1%3A%7Bi%3A0%3Bs%3A2%3A%22sg%22%3B%7Ds%3A15%3A%22urn%3Aoid%3A2.5.4.4%22%3Ba%3A1%3A%7Bi%3A0%3Bs%3A4%3A%22test%22%3B%7Ds%3A15%3A%22urn%3Aoid%3A2.5.4.3%22%3Ba%3A1%3A%7Bi%3A0%3Bs%3A7%3A%22sg%20test%22%3B%7Ds%3A33%3A%22urn%3Aoid%3A0.9.2342.19200300.100.1.3%22%3Ba%3A1%3A%7Bi%3A0%3Bs%3A22%3A%22devtest%40fuel-it-up.com%22%3B%7Ds%3A32%3A%22urn%3Aoid%3A1.3.6.1.4.1.5923.1.1.1.6%22%3Ba%3A1%3A%7Bi%3A0%3Bs%3A19%3A%22sgtest%40rnd.feide.no%22%3B%7Ds%3A33%3A%22urn%3Aoid%3A1.3.6.1.4.1.5923.1.1.1.10%22%3Ba%3A1%3A%7Bi%3A0%3Bs%3A40%3A%220bdefd5881486cb00eb46fe97c1288da4227b3af%22%3B%7Ds%3A6%3A%22groups%22%3Ba%3A3%3A%7Bi%3A0%3Bs%3A18%3A%22realm-rnd.feide.no%22%3Bi%3A1%3Bs%3A5%3A%22users%22%3Bi%3A2%3Bs%3A7%3A%22members%22%3B%7D%7Ds%3A6%3A%22Expire%22%3Bi%3A1392909079%3Bs%3A11%3A%22LogoutState%22%3Ba%3A4%3A%7Bs%3A16%3A%22saml%3Alogout%3AType%22%3Bs%3A5%3A%22saml2%22%3Bs%3A15%3A%22saml%3Alogout%3AIdP%22%3Bs%3A24%3A%22https%3A%2F%2Fopenidp.feide.no%22%3Bs%3A18%3A%22saml%3Alogout%3ANameID%22%3Ba%3A3%3A%7Bs%3A5%3A%22Value%22%3Bs%3A43%3A%22_c6c895a064641dccb7707e59fb0ce069ba0859f027%22%3Bs%3A15%3A%22SPNameQualifier%22%3Bs%3A96%3A%22http%3A%2F%2Flocalhost%3A8888%2Fbank_wall%2Fapi%2Fsimplesamlphp%2Fwww%2Fmodule.php%2Fsaml%2Fsp%2Fmetadata.php%2Fdefault-sp%22%3Bs%3A6%3A%22Format%22%3Bs%3A51%3A%22urn%3Aoasis%3Anames%3Atc%3ASAML%3A2.0%3Anameid-format%3Atransient%22%3B%7Ds%3A24%3A%22saml%3Alogout%3ASessionIndex%22%3Bs%3A43%3A%22_9f8fd53d71b0eda4e1728e1d7d3d39d7fe5f123f59%22%3B%7Ds%3A12%3A%22AuthnInstant%22%3Bi%3A1392880281%3B%7D%7D%7D', '2014-02-20 15:11:21'),
('saml.AssertionReceived', '_001c543cdac600ffb0f499710bee9d304ca3faf594', 'b%3A1%3B', '2014-02-20 03:44:13'),
('saml.AssertionReceived', '_459b3d165d290c6abc92b4b90988d483918892dbfe', 'b%3A1%3B', '2014-02-20 07:17:19');

-- --------------------------------------------------------

--
-- Table structure for table `saml_saml_logoutstore`
--

CREATE TABLE `saml_saml_logoutstore` (
  `_authSource` varchar(30) NOT NULL,
  `_nameId` varchar(40) NOT NULL,
  `_sessionIndex` varchar(50) NOT NULL,
  `_expire` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `_sessionId` varchar(50) NOT NULL,
  UNIQUE KEY `_authSource` (`_authSource`,`_nameId`,`_sessionIndex`),
  KEY `saml_saml_LogoutStore_expire` (`_expire`),
  KEY `saml_saml_LogoutStore_nameId` (`_authSource`,`_nameId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `saml_saml_logoutstore`
--

INSERT INTO `saml_saml_logoutstore` (`_authSource`, `_nameId`, `_sessionIndex`, `_expire`, `_sessionId`) VALUES
('default-sp', '0dec05a61a0557f78e7da828ebbdd1e43ed6d48d', '_0ac81d3ff3b63a3e488c1b1776a8fa0b2f4f9675dd', '2014-02-19 10:53:59', '2bed457342159b7c078ff266b199c9fc'),
('default-sp', '13034fc97241e75a2e05bf28303b889177ba3c49', '_4eb610d69af6b954511d574b927652767d33d0fb8a', '2014-02-14 16:26:29', '625c44895bc95c37cd66c4a9e8744b22'),
('default-sp', '3d4defc339c1f6c962ea38ba1d3d0ec46b0cdaf9', '_9f8fd53d71b0eda4e1728e1d7d3d39d7fe5f123f59', '2014-02-20 15:11:19', 'e14fccb8112b73c125ee95071242e02a'),
('default-sp', '3ec46c5b3bfcd75874ac9f5dc009a8f98cbd6620', '_e297585535e60bac675e79f4504ea2b6c86be87a5d', '2014-02-13 17:22:09', 'ded83b36374250cbac2e485cb68f0223'),
('default-sp', '65ef5709b33aae197dbab7aeb8e49850d958ec8c', '_e4fc190b9b72b29c9c7f1bc7acc391b9a79a1967d4', '2014-02-14 12:01:53', 'ded83b36374250cbac2e485cb68f0223'),
('default-sp', '7699eb0d7d4357e8d9f3cb45eddb7107734a258d', '_a20512b156a690ad680bc0f6370c2ddc0c7c1250d5', '2014-02-20 11:26:49', 'b83ceaedbe785aa4cefd2def889bb96c'),
('default-sp', '7c8cc6e7943d3a6744f8c035bc3b2fbf56cb295a', '_539ef71cd2ba5effc1e25b508505245504784b2e3a', '2014-02-14 11:42:05', 'eaded903523b0e9722989b055f0497dd'),
('default-sp', '88a8b444f1516f11fe11d7309693a7bc3ea6006e', '_3abe9dc225d447c65b79a0d042596c1b851ecf5d5b', '2014-02-17 11:31:24', '9a562516f368873a27cc593d3f1ed7ca'),
('default-sp', '8d1325ca3994a5802f63e0adaa613af8dfe8aad2', '_e7035768e03fdbef20717960f444c3abc03b303f91', '2014-02-12 11:19:36', 'd98e00fdfdc30001fc3cbb667d6f0ed4'),
('default-sp', '99d1e81be8b8e12bafdf5a543af1d2aca265d34f', '_5ce2fad6743bb8e9f609c296da8fce908bb72c30ce', '2014-02-18 14:38:20', 'b83ceaedbe785aa4cefd2def889bb96c'),
('default-sp', '9e315e28aad6cd997251857558f9165c9e92e484', '_d46cb324d092a0821613203c7ae6a90b48810cfcfa', '2014-02-17 09:47:47', 'b83ceaedbe785aa4cefd2def889bb96c'),
('default-sp', 'af0c78286fba72db3c70ee628864a538e2424ff9', '_def17a6d21069ec1b7bb4c0c9cd07f343a14e3dd6b', '2014-02-18 14:36:03', '3daec119ad868444b264bd059501ce86'),
('default-sp', 'cd6d5ac9af03e197a24af9d13573ff5f1f665051', '_6a643f0c9e7ba7de3e6a8941f4493273a535c15c66', '2014-02-20 11:38:13', 'b83ceaedbe785aa4cefd2def889bb96c'),
('default-sp', 'f31456a3bb62068a0790a413212d6c69d7a85a2c', '_def81334ce7432962e2407a74d020d0e43398f149d', '2014-02-13 09:51:24', 'bf7539cc3bc3ad3d93bd1c6e288013b3'),
('default-sp', 'f66180e01a8b3fca08bf16cdbd3954c3c482855a', '_5f3b26d3d9ced7f4be603fe57321d1b0ae936108e7', '2014-02-18 11:34:35', '3daec119ad868444b264bd059501ce86');

-- --------------------------------------------------------

--
-- Table structure for table `saml_tableVersion`
--

CREATE TABLE `saml_tableVersion` (
  `_name` varchar(30) NOT NULL,
  `_version` int(11) NOT NULL,
  UNIQUE KEY `_name` (`_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `saml_tableVersion`
--

INSERT INTO `saml_tableVersion` (`_name`, `_version`) VALUES
('kvstore', 1),
('saml_LogoutStore', 1);

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=29 ;

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
(27, 'dkdd', 0, ''),
(28, 'snow', 6, '1392713160');

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=23 ;

--
-- Dumping data for table `topday`
--

INSERT INTO `topday` (`topday_id`, `nid`, `date`) VALUES
(19, 71, 1389456000),
(6, 122, 1389481200),
(14, 163, 1389740400),
(13, 170, 1389913200),
(18, 197, 1390233600),
(5, 197, 1390258800),
(3, 206, 1391122800),
(2, 214, 1391209200),
(1, 214, 1391219200),
(17, 256, 1391961600),
(16, 265, 1392048000),
(22, 282, 1392652800);

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `topmonth`
--

INSERT INTO `topmonth` (`topmonth_id`, `nid`, `date`) VALUES
(5, 71, 1388505600),
(2, 122, 1388530800),
(3, 214, 1391209200),
(7, 282, 1391184000);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`uid`, `sso_id`, `name`, `personal_email`, `company_email`, `country_id`, `avatar`, `role`, `datetime`, `firstname`, `lastname`, `password`, `status`) VALUES
(3, '2ff43693fbce1d16e38e833b33a069f9', 'tonysh518', 'tony@fuel-it-up.com', 'tonysh518@rnd.feide.no', 1, '', 1, 1391654204, 'tony', 'zhu', NULL, 1),
(4, '4565b512743a119b19291a3307cc2950', 'sgtest', 'fdsf@fd.com', 'sgtest@rnd.feide.no', 30, '/uploads/avatar/4.jpg', 2, 1392088817, 'sg', 'test', NULL, 1);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
