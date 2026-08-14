-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 03, 2026 at 07:20 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hope`
--

-- --------------------------------------------------------

--
-- Table structure for table `actors`
--

CREATE TABLE `actors` (
  `id` int(11) NOT NULL,
  `name` varchar(24) NOT NULL DEFAULT 'Actor',
  `skin` int(11) NOT NULL DEFAULT 0,
  `anim_library` varchar(32) NOT NULL DEFAULT '',
  `anim_name` varchar(32) NOT NULL DEFAULT '',
  `isanimal` int(11) NOT NULL DEFAULT 0,
  `pos_x` float NOT NULL,
  `pos_y` float NOT NULL,
  `pos_z` float NOT NULL,
  `pos_a` float NOT NULL,
  `world` int(11) NOT NULL DEFAULT 0,
  `interior` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `actors`
--

INSERT INTO `actors` (`id`, `name`, `skin`, `anim_library`, `anim_name`, `isanimal`, `pos_x`, `pos_y`, `pos_z`, `pos_a`, `world`, `interior`) VALUES
(1, 'Rusa', 20004, '', '', 1, -2002.01, -1578.29, 133.728, 318.067, 0, 0),
(2, 'Beruang', 20003, '', '', 1, -1999.61, -1575.48, 132.901, 132.936, 0, 0),
(3, 'Ayam', 20002, '', '', 1, -1998.16, -1577.79, 133.339, 96.0855, 0, 0),
(4, 'deer', 20003, '', '', 1, -604.271, -2390.76, 27.5044, 15.8286, 0, 0),
(5, 'bear', 20003, '', '', 1, -648.343, -2394.85, 34.0254, 30.2663, 0, 0),
(6, 'deer', 20004, '', '', 1, -619.197, -2326.1, 31.6672, 337.263, 0, 0),
(7, 'deer', 20004, '', '', 1, -621.591, -2327.43, 32.0357, 338.738, 0, 0),
(8, 'deer', 20004, '', '', 1, -619.292, -2328.78, 31.713, 330.536, 0, 0),
(9, 'deer', 20004, '', '', 1, -615.518, -2231.71, 23.6626, 285.964, 0, 0),
(10, 'deer', 20004, '', '', 1, -609.669, -2215.37, 24.3017, 174.045, 0, 0),
(11, 'deer', 20004, '', '', 1, -581.179, -2213.31, 30.4581, 147.581, 0, 0),
(12, 'bear', 20003, '', '', 1, -767.421, -2268.87, 36.28, 245.018, 0, 0),
(13, 'bear', 20003, '', '', 1, -769.172, -2267.85, 35.764, 277.388, 0, 0),
(14, 'deer', 20004, '', '', 1, -772.021, -2195.88, 18.8879, 42.9384, 0, 0),
(15, 'deer', 20004, '', '', 1, -772.215, -2197.36, 18.7331, 29.7351, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `atms`
--

CREATE TABLE `atms` (
  `id` int(11) NOT NULL,
  `posx` float NOT NULL,
  `posy` float NOT NULL,
  `posz` float NOT NULL,
  `posrx` float NOT NULL,
  `posry` float NOT NULL,
  `posrz` float NOT NULL,
  `interior` int(11) NOT NULL DEFAULT 0,
  `world` int(11) NOT NULL DEFAULT 0,
  `robbery` int(11) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `atms`
--

INSERT INTO `atms` (`id`, `posx`, `posy`, `posz`, `posrx`, `posry`, `posrz`, `interior`, `world`, `robbery`) VALUES
(0, 2248.51, -1759.95, 1014.38, 0, 0, -176.5, 1, 0, 0),
(1, 1491.64, -1011.53, 26.5137, 0, 0, -86.7, 0, 0, 0),
(2, 1432.35, -1012, 26.4837, 0, 0, 88.7, 0, 0, 0),
(3, 1181.14, -1354.75, 13.8547, 0, 0, 0, 0, 0, 0),
(5, 1760.83, -1750.86, 13.235, 0, 0, 0, 0, 0, 0),
(6, 391.069, -1805.93, 7.53812, 0, 0, 180, 0, 0, 0),
(7, -83.2758, -1183.58, 1.42701, 0, 0, -20.3, 0, 0, 0),
(8, 317.072, -158.875, 999.253, 0, 0, 0, 6, 10, 0),
(9, -11.9034, -30.933, 1003.22, 0, 0, 91.1, 10, 11, 0),
(10, 318.953, -164.506, 999.191, 0, 0, -89.4, 6, 20, 0),
(11, 1431.32, -33.0964, 1000.58, -0.999999, 0.500002, 179.8, 1, 0, 0),
(12, 1745.93, -1750.73, 13.1819, 0, 0, 91.4, 0, 0, 0),
(13, -1980.64, 134.372, 27.3275, 0, 0, -90.8, 0, 0, 0),
(14, 1249.43, -1287.17, 1060.79, 0, 0, -91.6001, 1, 0, 0),
(15, -37.8741, -57.3724, 1003.18, 0, 0, 88.2, 6, 2, 0),
(16, 1548.21, -1671.69, 13.1597, 0, 0, -170, 0, 0, 0),
(17, 1734.29, -1866.18, 13.1748, 0, 0, -180, 0, 0, 0),
(18, 1680.25, -2335.53, 13.1469, 0, 0, 180, 0, 0, 0),
(19, 380.084, -72.175, 1001.11, 0, 0, -90, 10, 22, 0),
(20, 1043.27, -1371.38, 13.1872, 0, 0, 90, 0, 0, 0),
(21, 1111.91, -1789.83, 16.1937, 0, 0, -90, 0, 0, 0),
(22, 1121.2, -1246.13, 15.7062, 0, 0, -89.9999, 0, 0, 0),
(23, 987.599, -1341.08, 13.2178, 0, 0, 92.9998, 0, 0, 0),
(24, 987.581, -1342.56, 13.2364, 0, 1.5, 89.9998, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `bisnis`
--

CREATE TABLE `bisnis` (
  `ID` int(11) NOT NULL,
  `owner` varchar(40) NOT NULL DEFAULT '-',
  `name` varchar(40) NOT NULL DEFAULT 'Bisnis',
  `price` int(11) NOT NULL DEFAULT 500000,
  `type` int(11) NOT NULL DEFAULT 1,
  `locked` int(11) NOT NULL DEFAULT 1,
  `money` int(11) NOT NULL DEFAULT 0,
  `prod` int(11) NOT NULL DEFAULT 50,
  `bprice0` int(11) NOT NULL DEFAULT 500,
  `bprice1` int(11) NOT NULL DEFAULT 500,
  `bprice2` int(11) NOT NULL DEFAULT 500,
  `bprice3` int(11) NOT NULL DEFAULT 500,
  `bprice4` int(11) NOT NULL DEFAULT 500,
  `bprice5` int(11) NOT NULL DEFAULT 500,
  `bprice6` int(11) NOT NULL DEFAULT 500,
  `bprice7` int(11) NOT NULL DEFAULT 500,
  `bprice8` int(11) NOT NULL DEFAULT 500,
  `bprice9` int(11) NOT NULL DEFAULT 500,
  `bint` int(11) NOT NULL DEFAULT 0,
  `extposx` float NOT NULL DEFAULT 0,
  `extposy` float NOT NULL DEFAULT 0,
  `extposz` float NOT NULL DEFAULT 0,
  `extposa` float NOT NULL DEFAULT 0,
  `intposx` float NOT NULL DEFAULT 0,
  `intposy` float NOT NULL DEFAULT 0,
  `intposz` float NOT NULL DEFAULT 0,
  `intposa` float NOT NULL DEFAULT 0,
  `pointx` float DEFAULT 0,
  `pointy` float DEFAULT 0,
  `pointz` float DEFAULT 0,
  `visit` bigint(20) NOT NULL DEFAULT 0,
  `restock` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `bisnis`
--

INSERT INTO `bisnis` (`ID`, `owner`, `name`, `price`, `type`, `locked`, `money`, `prod`, `bprice0`, `bprice1`, `bprice2`, `bprice3`, `bprice4`, `bprice5`, `bprice6`, `bprice7`, `bprice8`, `bprice9`, `bint`, `extposx`, `extposy`, `extposz`, `extposa`, `intposx`, `intposy`, `intposz`, `intposa`, `pointx`, `pointy`, `pointz`, `visit`, `restock`) VALUES
(0, '-', 'Flint Intersection', 75000, 2, 0, 944860, 47, 8, 10, 20, 15, 20, 15, 5, 10, 1000, 0, 10, 1833.62, -1842.45, 13.5781, 60.384, 5.73, -31.04, 1003.54, 355.73, 2.46679, -29.0183, 1003.55, 1747472859, 0),
(13, '-', 'Warung Makan Aiden', 300000, 1, 0, 30607, 490, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 10, 1199.28, -918.145, 43.1231, 183.448, 363.22, -74.86, 1001.5, 319.72, 377.44, -67.4358, 1001.51, 1608088885, 0),
(22, 'Leon_Wederrson', 'Sayonara Restaurant', 0, 1, 0, 10025, 483, 4, 2, 3, 1, 0, 0, 0, 0, 0, 0, 10, 1280.61, -1860.95, 13.5391, 182.128, 363.22, -74.86, 1001.5, 319.72, 377.146, -67.4379, 1001.51, 1767075543, 0),
(24, 'Edwin_Kenan', 'EDWIN STORE', 0, 2, 0, 5086, 9910, 50, 50, 50, 100, 100, 1, 1, 1, 1, 200, 10, 1102.42, -1457.95, 15.7969, 74.844, 5.73, -31.04, 1003.54, 355.73, 2.25517, -29.017, 1003.55, 1765955050, 0),
(25, '-', 'TaFood', 75000, 1, 0, 6444, 976, 100, 100, 100, 100, 0, 0, 0, 0, 0, 0, 5, 172.485, 1177.53, 14.7578, 318, 372.34, -133.25, 1001.49, 4.8, 375.697, -118.802, 1001.49, 1742224377, 0),
(7, '-', 'Santa Maria Beach', 0, 4, 0, 163, 915, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 4, 411.923, -1729.33, 9.36531, 162.56, 285.93, -86, 1001.52, 352.95, 291.688, -83.3483, 1001.52, 1742286167, 0),
(9, 'Ken_Clarence', 'TOKO SUKA-SUKA', 75000, 2, 0, 2797, 4979, 8, 8, 10, 15, 50, 150, 50, 50, 65, 120, 6, 1642.54, -2237.66, 13.4999, 355.652, -26.68, -57.92, 1003.54, 357.58, -23.6, -55.6251, 1003.55, 1742436403, 0),
(1, '-', 'Market', 75000, 1, 0, 3721, 9763, 25, 25, 20, 15, 0, 0, 0, 0, 0, 0, 10, 1102.42, -1440.2, 15.7969, 85.438, 363.22, -74.86, 1001.5, 319.72, 376.94, -67.4346, 1001.51, 0, 0),
(2, '-', '???????', 75000, 3, 0, 23987, 974, 450, 70, 35, 20, 0, 0, 0, 0, 0, 0, 15, 1154.72, -1440.18, 15.7969, 277.254, 207.55, -110.67, 1005.13, 0.159997, 207.593, -100.33, 1005.26, 1742743479, 0),
(3, '-', 'BABE CLOTHES', 75000, 3, 0, 3639, 485, 250, 100, 300, 300, 0, 0, 0, 0, 0, 0, 14, 274.123, -1176.33, 80.2309, 127.216, 204.49, -168.26, 1000.52, 358.74, 204.617, -159.351, 1000.52, 0, 0),
(4, '-', 'Market', 300000, 3, 0, 2975, 485, 300, 200, 150, 125, 0, 0, 0, 0, 0, 0, 14, 1074.61, -1298.26, 17.0469, 271.629, 204.49, -168.26, 1000.52, 358.74, 204.302, -159.351, 1000.52, 1742913776, 0),
(5, '-', 'Market', 75000, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 1082.99, -1226.82, 15.8203, 93.9486, -26.68, -57.92, 1003.54, 357.58, 0, 0, 0, 0, 0),
(6, '-', 'Flint County', 50000, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, -78.4011, -1169.96, 2.13093, 250.699, -26.68, -57.92, 1003.54, 357.58, 0, 0, 0, 0, 0),
(8, '-', 'Idlewood', 85000, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 2105.49, -1806.47, 13.5547, 265.248, 363.22, -74.86, 1001.5, 319.72, 0, 0, 0, 0, 0),
(10, '-', 'Commerce', 70000, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 1419.17, -1607.42, 13.5469, 84.8307, 204.49, -168.26, 1000.52, 358.74, 0, 0, 0, 0, 0),
(11, '-', 'Commerce', 70000, 4, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 1419.17, -1623.78, 13.5469, 87.7574, 285.93, -86, 1001.52, 352.95, 0, 0, 0, 0, 0),
(12, 'Nerd_Sammy', 'Market', 75000, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 1038.19, -1340.73, 13.7374, 183.122, 363.22, -74.86, 1001.5, 319.72, 0, 0, 0, 1765163403, 0),
(14, '-', 'Idlewood', 75000, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 1857.76, -1690.07, 13.6094, 79.4077, 372.34, -133.25, 1001.49, 4.8, 0, 0, 0, 0, 0),
(15, '-', 'Idlewood', 75000, 4, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 1858.63, -1724.24, 13.6094, 90.5203, 316.34, -169.6, 999.6, 357.73, 0, 0, 0, 0, 0),
(16, '-', 'Idlewood', 75000, 3, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15, 1858.63, -1735.77, 13.6094, 81.8269, 207.55, -110.67, 1005.13, 0.159999, 0, 0, 0, 0, 0),
(17, '-', 'Idlewood', 75000, 3, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 1869.07, -1688.52, 13.6094, 352.704, 204.49, -168.26, 1000.52, 358.74, 0, 0, 0, 0, 0),
(18, '-', 'Idlewood', 75000, 4, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 1906.98, -1687.48, 13.5234, 247.395, 285.93, -86, 1001.52, 352.95, 0, 0, 0, 0, 0),
(19, '-', 'Idlewood', 75000, 4, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 1908.21, -1706.49, 13.661, 268.219, 316.34, -169.6, 999.6, 357.73, 0, 0, 0, 0, 0),
(20, '-', 'Idlewood', 75000, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 1906.52, -1729.5, 13.5234, 266.971, 5.73, -31.04, 1003.54, 355.73, 0, 0, 0, 0, 0),
(21, '-', 'Idlewood', 75000, 3, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 1906.42, -1720.08, 13.5234, 269.579, 204.49, -168.26, 1000.52, 358.74, 0, 0, 0, 0, 0),
(23, '-', 'Ganton', 30000, 3, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 2244.32, -1665.55, 15.4766, 161.304, 204.49, -168.26, 1000.52, 358.74, 0, 0, 0, 0, 0),
(26, '-', 'Flint County', 20000, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, -223.785, -2263.41, 29.3, 303.796, -26.68, -57.92, 1003.54, 357.58, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `blacklist`
--

CREATE TABLE `blacklist` (
  `username` varchar(24) NOT NULL DEFAULT 'PlayerUCP',
  `player` varchar(24) NOT NULL DEFAULT 'PlayerName',
  `bannedby` varchar(24) NOT NULL DEFAULT 'AdminName',
  `reason` varchar(64) NOT NULL DEFAULT 'None',
  `banned_date` varchar(42) NOT NULL DEFAULT 'FannGanteng',
  `banned_expired` int(11) NOT NULL DEFAULT 0,
  `ip` varchar(16) NOT NULL DEFAULT '127.1.1.1',
  `longip` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `boxes`
--

CREATE TABLE `boxes` (
  `id` int(11) NOT NULL,
  `weight` int(11) NOT NULL DEFAULT 0,
  `type` int(11) NOT NULL DEFAULT 0,
  `in_vehicle` int(11) NOT NULL DEFAULT -1,
  `x` float NOT NULL DEFAULT 0,
  `y` float NOT NULL DEFAULT 0,
  `z` float NOT NULL DEFAULT 0,
  `angle` float NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `boxes`
--

INSERT INTO `boxes` (`id`, `weight`, `type`, `in_vehicle`, `x`, `y`, `z`, `angle`) VALUES
(3, 1, 3, 372, 1153.8, -1238.56, 15.3528, 92.4251),
(4, 1, 2, 372, 1155.68, -1238.6, 15.3476, 177.472),
(5, 1, 1, 372, 1154.63, -1236.6, 15.5579, 195.78),
(6, 1, 1, 372, 844.974, -602.112, 17.7669, 182.845),
(7, 1, 1, 372, 847.492, -595.626, 17.6401, 324.795),
(8, 1, 1, 393, 845.317, -602.029, 17.7669, 169.179),
(9, 1, 1, 393, 845.249, -601.885, 17.7669, 186.423),
(10, 1, 1, 393, 1642.59, -2243.01, 12.8387, 184.615),
(14, 1, 3, 393, 2478.59, -2252.82, 12.9778, 197.848);

-- --------------------------------------------------------

--
-- Table structure for table `claimvoucher`
--

CREATE TABLE `claimvoucher` (
  `playerid` int(11) NOT NULL DEFAULT -1,
  `code` varchar(32) NOT NULL DEFAULT 'None'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `contact`
--

CREATE TABLE `contact` (
  `id` int(11) NOT NULL,
  `ownerid` int(11) NOT NULL DEFAULT -1,
  `name` varchar(32) NOT NULL DEFAULT 'None',
  `number` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `contact`
--

INSERT INTO `contact` (`id`, `ownerid`, `name`, `number`) VALUES
(1, 1, 'Klee Mabar', 4365),
(2, 1, 'Earl Jumpshot', 3469);

-- --------------------------------------------------------

--
-- Table structure for table `dealership`
--

CREATE TABLE `dealership` (
  `id` int(11) NOT NULL,
  `name` varchar(64) NOT NULL DEFAULT 'Dealership',
  `ownerid` int(11) NOT NULL DEFAULT -1,
  `ownername` varchar(32) NOT NULL DEFAULT '-',
  `balance` int(11) NOT NULL DEFAULT 0,
  `type` int(11) NOT NULL DEFAULT 0,
  `price` int(11) NOT NULL DEFAULT 0,
  `status` int(11) NOT NULL DEFAULT 0,
  `stock` int(11) NOT NULL DEFAULT 0,
  `restock` int(11) NOT NULL DEFAULT 0,
  `pos1` float NOT NULL,
  `pos2` float NOT NULL,
  `pos3` float NOT NULL,
  `spawnpos1` float NOT NULL,
  `spawnpos2` float NOT NULL,
  `spawnpos3` float NOT NULL,
  `spawnpos4` float NOT NULL,
  `vehprice1` int(11) NOT NULL DEFAULT 0,
  `vehprice2` int(11) NOT NULL DEFAULT 0,
  `vehprice3` int(11) NOT NULL DEFAULT 0,
  `vehprice4` int(11) NOT NULL DEFAULT 0,
  `vehprice5` int(11) NOT NULL DEFAULT 0,
  `vehprice6` int(11) NOT NULL DEFAULT 0,
  `vehprice7` int(11) NOT NULL DEFAULT 0,
  `vehprice8` int(11) NOT NULL DEFAULT 0,
  `vehprice9` int(11) NOT NULL DEFAULT 0,
  `vehprice10` int(11) NOT NULL DEFAULT 0,
  `vehprice11` int(11) NOT NULL DEFAULT 0,
  `vehprice12` int(11) NOT NULL DEFAULT 0,
  `vehprice13` int(11) NOT NULL DEFAULT 0,
  `vehprice14` int(11) NOT NULL DEFAULT 0,
  `vehprice15` int(11) NOT NULL DEFAULT 0,
  `vehprice16` int(11) NOT NULL DEFAULT 0,
  `vehprice17` int(11) NOT NULL DEFAULT 0,
  `vehprice18` int(11) NOT NULL DEFAULT 0,
  `vehprice19` int(11) NOT NULL DEFAULT 0,
  `vehprice20` int(11) NOT NULL DEFAULT 0,
  `vehprice21` int(11) NOT NULL DEFAULT 0,
  `vehprice22` int(11) NOT NULL DEFAULT 0,
  `vehprice23` int(11) NOT NULL DEFAULT 0,
  `vehprice24` int(11) NOT NULL DEFAULT 0,
  `vehprice25` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dealership`
--

INSERT INTO `dealership` (`id`, `name`, `ownerid`, `ownername`, `balance`, `type`, `price`, `status`, `stock`, `restock`, `pos1`, `pos2`, `pos3`, `spawnpos1`, `spawnpos2`, `spawnpos3`, `spawnpos4`, `vehprice1`, `vehprice2`, `vehprice3`, `vehprice4`, `vehprice5`, `vehprice6`, `vehprice7`, `vehprice8`, `vehprice9`, `vehprice10`, `vehprice11`, `vehprice12`, `vehprice13`, `vehprice14`, `vehprice15`, `vehprice16`, `vehprice17`, `vehprice18`, `vehprice19`, `vehprice20`, `vehprice21`, `vehprice22`, `vehprice23`, `vehprice24`, `vehprice25`) VALUES
(1, 'Government Dealership', 1, 'Ken_Clarence', 17000, 1, 50000, 1, 4999, 0, 1219.4, -1861.53, 13.5469, 1198.74, -1831.83, 13.1717, 269.354, 500, 750, 800, 5000, 7500, 17000, 20000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(2, 'Government Dealership', 1, 'Ken_Clarence', 45000, 2, 100000, 1, 4999, 0, 1248.01, -1559.94, 13.5547, 1272.94, -1553.63, 13.2277, 179.161, 45000, 40000, 52000, 48000, 65000, 47000, 53000, 47000, 45500, 43900, 57400, 80000, 67400, 67600, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `doors`
--

CREATE TABLE `doors` (
  `ID` int(11) NOT NULL,
  `name` varchar(50) DEFAULT 'None',
  `password` varchar(50) DEFAULT '',
  `icon` int(11) DEFAULT 19130,
  `locked` int(11) NOT NULL DEFAULT 0,
  `admin` int(11) NOT NULL DEFAULT 0,
  `vip` int(11) NOT NULL DEFAULT 0,
  `faction` int(11) NOT NULL DEFAULT 0,
  `family` int(11) NOT NULL DEFAULT -1,
  `garage` tinyint(4) NOT NULL DEFAULT 0,
  `custom` int(11) NOT NULL DEFAULT 0,
  `extvw` int(11) DEFAULT 0,
  `extint` int(11) DEFAULT 0,
  `extposx` float DEFAULT 0,
  `extposy` float DEFAULT 0,
  `extposz` float DEFAULT 0,
  `extposa` float DEFAULT 0,
  `intvw` int(11) DEFAULT 0,
  `intint` int(11) NOT NULL DEFAULT 0,
  `intposx` float DEFAULT 0,
  `intposy` float DEFAULT 0,
  `intposz` float DEFAULT 0,
  `intposa` float DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `doors`
--

INSERT INTO `doors` (`ID`, `name`, `password`, `icon`, `locked`, `admin`, `vip`, `faction`, `family`, `garage`, `custom`, `extvw`, `extint`, `extposx`, `extposy`, `extposz`, `extposa`, `intvw`, `intint`, `intposx`, `intposy`, `intposz`, `intposa`) VALUES
(0, 'San Andreas Police Departement', '', 19130, 0, 0, 0, 0, -1, 0, 1, 0, 0, 1555.3, -1675.69, 16.1953, 87.1144, 1, 10, 246.647, 107.377, 1003.22, 6.4186),
(1, 'San Andreas Police Departement', '', 19130, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1565.02, -1666.76, 28.3956, 3.67237, 1, 10, 218.357, 123.536, 1007.21, 268.826),
(2, 'San Andreas Police Departement', '', 19130, 0, 0, 0, 1, -1, 0, 1, 0, 0, 1568.68, -1690.12, 6.21875, 184.131, 1, 10, 227.079, 117.713, 999.033, 85.7161),
(3, 'City Hall', '', 19130, 0, 0, 0, 0, -1, 0, 1, 0, 0, 1481.05, -1772.21, 18.7971, 2.85149, 0, 2, 920.299, -1475.58, 2754.33, 346.653),
(8, 'ASGH Medical Departement', '', 19130, 0, 0, 0, 0, -1, 0, 1, 0, 0, 1172.08, -1323.81, 15.4467, 86.8131, 0, 1, 1429.29, -14.388, 1000.92, 84.0592),
(9, 'ASGH Medical Departement', '', 19130, 0, 0, 0, 0, -1, 0, 1, 0, 0, 1144.88, -1324.18, 13.5853, 78.0049, 0, 1, 1458.09, -32.89, 1000.92, 2.44448),
(10, 'ASGH Medical Departement', '', 19130, 0, 0, 0, 3, -1, 0, 1, 0, 0, 1163.41, -1329.97, 31.4847, 12.2057, 0, 1, 1445.18, 6.96744, 1004.57, 181.023),
(11, 'San Andreas News Agency', '', 19130, 0, 0, 0, 0, -1, 0, 1, 0, 0, 648.742, -1357.6, 13.7623, 267.393, 0, 1, 2451.8, 2282.38, 91.6744, 232.272),
(12, 'San Andreas News Agency Studio', '', 19130, 0, 0, 0, 0, -1, 0, 1, 0, 0, 740.15, -1351.26, 14.7142, 265.1, 0, 1, 248.441, 1783.74, 701.086, 196.479),
(13, 'Bank Central', '', 19130, 0, 0, 0, 0, -1, 0, 1, 0, 0, 1464.89, -1010.09, 26.8438, 182.538, 0, 0, -988.573, 1444.3, 1340.63, 0.340923),
(14, 'Taxi Longue', '', 19130, 0, 0, 0, 0, -1, 0, 1, 0, 0, 1752.63, -1894.08, 13.5574, 276.873, 0, 1, -2158.5, 642.905, 1052.38, 184.752),
(15, 'VIP Longue', '', 19130, 0, 0, 1, 0, -1, 0, 1, 0, 0, 1797.65, -1578.89, 14.0861, 280.855, 0, 1, -4107.23, 906.906, 3.10072, 176.818),
(16, 'SANEWS', '', 19130, 0, 0, 0, 4, -1, 0, 0, 0, 1, 2473.41, 2278.42, 91.6868, 178.715, 0, 0, 737.634, -1353.05, 25.2202, 271.198),
(17, 'SANews Base', '', 19130, 0, 0, 0, 0, -1, 0, 0, 0, 1, 253.447, 1780.27, 701.086, 86.788, 0, 1, 2467.58, 2253.87, 91.6868, 89.1242),
(18, 'Black Market', '', 19130, 0, 0, 0, 0, -1, 0, 1, 0, 0, 1489.25, -1719.42, 8.23919, 344.404, 0, 1, 504.839, -2317.78, 512.791, 175.298),
(20, 'VIP Car Garage', '', 19130, 0, 0, 1, 0, -1, 1, 1, 0, 0, 1827.26, -1538.06, 13.5469, 165.884, 0, 0, 1818.76, -1537.02, 13.3813, 84.7065),
(21, 'VIP Bike Garage', '', 19130, 0, 0, 1, 0, -1, 1, 1, 0, 0, 1754.34, -1594.77, 13.537, 79.0899, 0, 0, 1753.36, -1587.71, 13.3052, 357.622),
(22, 'Pengadilan San Andreas', '', 19130, 0, 0, 0, 0, -1, 0, 1, 0, 0, 1122.71, -2036.99, 69.8958, 91.9046, 0, 1, 1356.01, 717.951, -15.7573, 260.304),
(23, 'Willowfield Gym', '', 19130, 0, 0, 0, 0, -1, 0, 0, 0, 0, 2493.03, -1958.55, 13.5827, 3.07504, 0, 6, 774.372, -50.2732, 1000.59, 2.59314),
(24, 'SAN TOWER', '', 19130, 0, 1, 0, 0, -1, 0, 1, 0, 0, 1415.48, -1300.22, 13.5449, 0.765661, 0, 0, 1548.83, -1363.87, 326.218, 12.036),
(25, 'Newbie School [ OOC ZONE ]', '', 19130, 1, 0, 0, 0, -1, 0, 0, 0, 0, 1286.6, -1329.32, 13.554, 262.649, 0, 1, 2177.65, -1010.05, 1021.69, 178.971),
(26, 'Los Santos Production', '', 19130, 0, 0, 0, 0, -1, 0, 0, 0, 0, 694.907, -500.133, 16.3359, 178.709, 0, 1, 770.935, -1108, -43.26, 179.937),
(35, 'Department of Motor Vehicles', '', 19130, 0, 0, 0, 0, -1, 0, 0, 0, 0, 2062.83, -1897.38, 13.5538, 187.697, 0, 3, 1494.41, 1303.77, 1093.29, 358.274),
(36, 'Las Venturas Schematic Factory', '', 19130, 0, 0, 0, 0, -1, 0, 0, 0, 0, 1590.81, 688.192, 10.8203, 89.1129, 0, 0, 1062.31, 2077.53, 10.8203, 357.764),
(4, 'Insurance Agency', '', 19130, 0, 0, 0, 0, -1, 0, 1, 0, 0, 1111.92, -1795.58, 16.5938, 271.226, 0, 4, 1123.78, -1800.71, 1241.91, 106.076),
(5, 'Kontol', '', 19130, 0, 0, 0, 0, -1, 0, 1, 0, 0, 2561.84, 1561.65, 10.8203, 278.285, 0, 0, 2559.35, 1564.96, 509.07, 179.872),
(6, 'Fire Department Office', '', 19130, 0, 0, 0, 5, -1, 0, 1, 0, 0, 1017.75, -1971.11, 19.1916, 88.1286, 0, 2, 1026.95, -1952.05, 924.577, 265.736),
(7, 'Fish Factory', '', 19130, 0, 0, 0, 0, -1, 0, 1, 0, 0, 2836.74, -1529.09, 11.2087, 0, 0, 6, 1353.23, 1325.98, 10.8862, 0),
(19, 'Floor', '', 19130, 0, 0, 0, 0, -1, 0, 0, 0, 2, 931.355, -1458.35, 2761.02, 14.8416, 0, 2, 931.189, -1458.33, 2754.33, 353.156),
(27, 'Floor', '', 19130, 0, 0, 0, 0, -1, 0, 0, 0, 2, 908.209, -1458.32, 2761.02, 2.57185, 0, 2, 908.291, -1458.37, 2754.32, 350.208),
(28, 'Rooftop', '', 19130, 0, 0, 0, 0, -1, 0, 0, 0, 0, 1437.84, -1796.86, 33.4297, 273.533, 0, 2, 901.527, -1465.88, 2761.02, 75.2238);

-- --------------------------------------------------------

--
-- Table structure for table `dropped_items`
--

CREATE TABLE `dropped_items` (
  `id` int(11) NOT NULL,
  `item` varchar(32) NOT NULL DEFAULT 'None',
  `quantity` int(11) NOT NULL DEFAULT 0,
  `model` int(11) NOT NULL DEFAULT 0,
  `pos_x` float NOT NULL,
  `pos_y` float NOT NULL,
  `pos_z` float NOT NULL,
  `pos_rx` float NOT NULL,
  `pos_ry` float NOT NULL,
  `pos_rz` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dropped_weapons`
--

CREATE TABLE `dropped_weapons` (
  `ID` int(11) NOT NULL,
  `PlayerName` varchar(32) NOT NULL DEFAULT 'None',
  `WeaponModel` int(11) NOT NULL DEFAULT 0,
  `WeaponID` int(11) NOT NULL DEFAULT 0,
  `Ammo` int(11) NOT NULL DEFAULT 0,
  `PosX` float NOT NULL DEFAULT 0,
  `PosY` float NOT NULL DEFAULT 0,
  `PosZ` float NOT NULL DEFAULT 0,
  `Interior` int(11) NOT NULL DEFAULT -1,
  `World` int(11) NOT NULL DEFAULT -1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dropped_weapons`
--

INSERT INTO `dropped_weapons` (`ID`, `PlayerName`, `WeaponModel`, `WeaponID`, `Ammo`, `PosX`, `PosY`, `PosZ`, `Interior`, `World`) VALUES
(1, 'Ken_Clarence', 366, 42, 312, -530.47, -1034.55, 23.72, 0, 0),
(6, 'Ken_Clarence', 348, 24, 19, 1920.72, -1775.34, 16.97, 0, 0),
(7, 'Ken_Clarence', 366, 42, 1128, 1911.59, -1779.8, 21.41, 0, 0),
(8, 'Ken_Clarence', 321, 10, 1, 1909.71, -1779.76, 21.41, 0, 0),
(16, 'Ken_Clarence', 361, 37, 493, 1504.09, 1650.97, 9.82, 0, 0),
(17, 'Ken_Clarence', 360, 36, 499, 1504.11, 1718.21, 9.82, 0, 0),
(20, 'Ken_Clarence', 348, 24, 56, -2197.13, -1767.45, 306.36, 0, 0),
(21, 'Ken_Clarence', 372, 32, 485, -2200.24, -1767.45, 306.36, 0, 0),
(22, 'Ken_Clarence', 366, 42, 838, -2201.01, -1767.45, 306.36, 0, 0),
(24, 'Porkcho_Armagedov', 348, 24, 93, -1965.98, -1488.26, 84.11, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `familys`
--

CREATE TABLE `familys` (
  `ID` int(11) NOT NULL,
  `name` varchar(50) NOT NULL DEFAULT 'None',
  `leader` varchar(50) NOT NULL DEFAULT 'None',
  `motd` varchar(100) NOT NULL DEFAULT 'None',
  `color` int(11) DEFAULT 0,
  `extposx` float DEFAULT 0,
  `extposy` float DEFAULT 0,
  `extposz` float DEFAULT 0,
  `extposa` float DEFAULT 0,
  `intposx` float DEFAULT 0,
  `intposy` float DEFAULT 0,
  `intposz` float DEFAULT 0,
  `intposa` float DEFAULT 0,
  `fint` int(11) NOT NULL DEFAULT 0,
  `Weapon1` int(11) NOT NULL DEFAULT 0,
  `Ammo1` int(11) NOT NULL DEFAULT 0,
  `Weapon2` int(11) NOT NULL DEFAULT 0,
  `Ammo2` int(11) NOT NULL DEFAULT 0,
  `Weapon3` int(11) NOT NULL DEFAULT 0,
  `Ammo3` int(11) NOT NULL DEFAULT 0,
  `Weapon4` int(11) NOT NULL DEFAULT 0,
  `Ammo4` int(11) NOT NULL DEFAULT 0,
  `Weapon5` int(11) NOT NULL DEFAULT 0,
  `Ammo5` int(11) NOT NULL DEFAULT 0,
  `Weapon6` int(11) NOT NULL DEFAULT 0,
  `Ammo6` int(11) NOT NULL DEFAULT 0,
  `Weapon7` int(11) NOT NULL DEFAULT 0,
  `Ammo7` int(11) NOT NULL DEFAULT 0,
  `Weapon8` int(11) NOT NULL DEFAULT 0,
  `Ammo8` int(11) NOT NULL DEFAULT 0,
  `Weapon9` int(11) NOT NULL DEFAULT 0,
  `Ammo9` int(11) NOT NULL DEFAULT 0,
  `Weapon10` int(11) NOT NULL DEFAULT 0,
  `Ammo10` int(11) NOT NULL DEFAULT 0,
  `safex` float DEFAULT 0,
  `safey` float DEFAULT 0,
  `safez` float DEFAULT 0,
  `money` int(11) NOT NULL DEFAULT 0,
  `marijuana` int(11) NOT NULL DEFAULT 0,
  `component` int(11) NOT NULL DEFAULT 0,
  `material` int(11) NOT NULL DEFAULT 0,
  `Weapon11` int(11) NOT NULL DEFAULT 0,
  `Ammo11` int(11) NOT NULL DEFAULT 0,
  `Weapon12` int(11) NOT NULL DEFAULT 0,
  `Ammo12` int(11) NOT NULL DEFAULT 0,
  `Weapon13` int(11) NOT NULL DEFAULT 0,
  `Ammo13` int(11) NOT NULL DEFAULT 0,
  `Weapon14` int(11) NOT NULL DEFAULT 0,
  `Ammo14` int(11) NOT NULL DEFAULT 0,
  `Weapon15` int(11) NOT NULL DEFAULT 0,
  `Ammo15` int(11) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fire`
--

CREATE TABLE `fire` (
  `id` int(11) NOT NULL,
  `model` int(11) NOT NULL DEFAULT 0,
  `interior` int(11) NOT NULL DEFAULT 0,
  `world` int(11) NOT NULL DEFAULT 0,
  `health` float NOT NULL DEFAULT 100,
  `posx` float NOT NULL DEFAULT 0,
  `posy` float NOT NULL DEFAULT 0,
  `posz` float NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `garbage`
--

CREATE TABLE `garbage` (
  `id` int(11) NOT NULL,
  `available` int(11) NOT NULL DEFAULT 1,
  `time` int(11) NOT NULL DEFAULT 0,
  `pos_x` float NOT NULL,
  `pos_y` float NOT NULL,
  `pos_z` float NOT NULL,
  `pos_rx` float NOT NULL,
  `pos_ry` float NOT NULL,
  `pos_rz` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `gates`
--

CREATE TABLE `gates` (
  `ID` int(11) NOT NULL,
  `model` int(11) NOT NULL DEFAULT 0,
  `password` varchar(36) NOT NULL DEFAULT '',
  `admin` tinyint(4) NOT NULL DEFAULT 0,
  `vip` tinyint(4) NOT NULL DEFAULT 0,
  `faction` tinyint(4) NOT NULL DEFAULT 0,
  `family` int(11) NOT NULL DEFAULT -1,
  `speed` float NOT NULL DEFAULT 2,
  `cX` float NOT NULL,
  `cY` float NOT NULL,
  `cZ` float NOT NULL,
  `cRX` float NOT NULL,
  `cRY` float NOT NULL,
  `cRZ` float NOT NULL,
  `oX` float NOT NULL,
  `oY` float NOT NULL,
  `oZ` float NOT NULL,
  `oRX` float NOT NULL,
  `oRY` float NOT NULL,
  `oRZ` float NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `gates`
--

INSERT INTO `gates` (`ID`, `model`, `password`, `admin`, `vip`, `faction`, `family`, `speed`, `cX`, `cY`, `cZ`, `cRX`, `cRY`, `cRZ`, `oX`, `oY`, `oZ`, `oRX`, `oRY`, `oRZ`) VALUES
(0, 980, '', 0, 0, 1, -1, 2, 1539.41, -1627.56, 15.0128, 0, 0, 90.2, 1539.41, -1627.56, 9.51278, 0, 0, 90.2),
(1, 986, '', 0, 0, 4, -1, 2, 777.918, -1385.11, 13.6232, 0, 0, 0, 769.928, -1385.11, 13.6232, 0, 0, 0),
(2, 986, '', 0, 0, 3, -1, 2, 1147.43, -1290.87, 13.6388, 0, 0, 1.1, 1153.97, -1290.74, 13.6388, 0, 0, 1.1),
(4, 968, '', 0, 0, 0, -1, 2, -1701.43, 687.603, 24.7006, -2.4, -90.6, 90, -1701.43, 687.603, 24.7006, 0, 0, 91.6),
(7, 19912, '', 0, 0, 0, -1, 2, 325.315, -1184.65, 77.0866, 0, 0, 40, 325.315, -1184.65, 72.0867, 0, 0, 40),
(8, 1536, '', 0, 0, 3, -1, 2, 1451.61, -18.2838, 999.821, 0, 0, 90, 1451.61, -16.7838, 999.821, 0, 0, 90),
(9, 1536, '', 0, 0, 3, -1, 2, 1436.25, -6.57424, 999.921, 0, 0, 90, 1436.25, -5.07424, 999.921, 0, 0, 90);

-- --------------------------------------------------------

--
-- Table structure for table `graffiti`
--

CREATE TABLE `graffiti` (
  `id` int(11) NOT NULL,
  `owner` int(11) NOT NULL DEFAULT -1,
  `model` int(11) NOT NULL DEFAULT 0,
  `fontsize` int(11) NOT NULL DEFAULT 0,
  `size` int(11) NOT NULL DEFAULT 0,
  `text` varchar(128) NOT NULL DEFAULT 'None',
  `font` varchar(24) NOT NULL DEFAULT 'Arial',
  `x` float NOT NULL DEFAULT 0,
  `y` float NOT NULL DEFAULT 0,
  `z` float NOT NULL DEFAULT 0,
  `rx` float NOT NULL DEFAULT 0,
  `ry` float NOT NULL DEFAULT 0,
  `rz` float NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `graffiti`
--

INSERT INTO `graffiti` (`id`, `owner`, `model`, `fontsize`, `size`, `text`, `font`, `x`, `y`, `z`, `rx`, `ry`, `rz`) VALUES
(1, 1, 19482, 25, 100, 'HopePride', 'Arial', -1321.03, 492.915, 18.2344, 0, 0, 0),
(2, 1, 19482, 25, 40, 'HopePride', 'Arial', -1326.62, 499.479, 18.8494, 0, 0, 90),
(3, 1, 19482, 25, 40, 'HopePride', 'Arial', -1342.26, 499.374, 18.2344, 0, 0, 90),
(4, 1, 19482, 25, 40, 'Fann', 'Arial', -1338.05, 450.106, 7.18751, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `gstations`
--

CREATE TABLE `gstations` (
  `id` int(11) NOT NULL DEFAULT 0,
  `stock` int(11) NOT NULL DEFAULT 10000,
  `posx` float DEFAULT 0,
  `posy` float DEFAULT 0,
  `posz` float DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `gstations`
--

INSERT INTO `gstations` (`id`, `stock`, `posx`, `posy`, `posz`) VALUES
(0, 7895, 1937.56, -1772.77, 13.3828),
(1, 7990, 1944.66, -1772.42, 13.3906),
(2, 7800, -96.0828, -1160.66, 2.18832),
(3, 7600, -93.6488, -1174.95, 2.26908),
(4, 7243, 1004.67, -940.464, 42.1797),
(5, 7263, 1004.12, -933.524, 42.1797),
(6, 10740, 658.764, -565.936, 16.3359),
(7, 7350, -89.2822, -1163.46, 1.82658),
(8, 10000, -2550.52, 2351.71, 4.98438),
(9, 10000, -2550.41, 2356.71, 4.98438),
(10, 7799, -2408.15, 975.992, 45.2969),
(11, 3000, -2413.44, 976.201, 45.2969);

-- --------------------------------------------------------

--
-- Table structure for table `houses`
--

CREATE TABLE `houses` (
  `ID` int(11) NOT NULL,
  `owner` varchar(50) NOT NULL DEFAULT '-',
  `address` varchar(50) DEFAULT 'None',
  `price` int(11) NOT NULL DEFAULT 500000,
  `type` int(11) NOT NULL DEFAULT 1,
  `locked` int(11) NOT NULL DEFAULT 1,
  `money` int(11) NOT NULL DEFAULT 0,
  `houseint` int(11) NOT NULL DEFAULT 0,
  `extposx` float NOT NULL DEFAULT 0,
  `extposy` float NOT NULL DEFAULT 0,
  `extposz` float NOT NULL DEFAULT 0,
  `extposa` float NOT NULL DEFAULT 0,
  `intposx` float NOT NULL DEFAULT 0,
  `intposy` float NOT NULL DEFAULT 0,
  `intposz` float NOT NULL DEFAULT 0,
  `intposa` float NOT NULL DEFAULT 0,
  `kitchenposx` float NOT NULL,
  `kitchenposy` float NOT NULL,
  `kitchenposz` float NOT NULL,
  `visit` bigint(20) DEFAULT 0,
  `houseWeapon1` int(11) DEFAULT 0,
  `houseAmmo1` int(11) DEFAULT 0,
  `houseWeapon2` int(11) DEFAULT 0,
  `houseAmmo2` int(11) DEFAULT 0,
  `houseWeapon3` int(11) DEFAULT 0,
  `houseAmmo3` int(11) DEFAULT 0,
  `houseWeapon4` int(11) DEFAULT 0,
  `houseAmmo4` int(11) DEFAULT 0,
  `houseWeapon5` int(11) DEFAULT 0,
  `houseAmmo5` int(11) DEFAULT 0,
  `houseWeapon6` int(11) DEFAULT 0,
  `houseAmmo6` int(11) DEFAULT 0,
  `houseWeapon7` int(11) DEFAULT 0,
  `houseAmmo7` int(11) DEFAULT 0,
  `houseWeapon8` int(11) DEFAULT 0,
  `houseAmmo8` int(11) DEFAULT 0,
  `houseWeapon9` int(11) DEFAULT 0,
  `houseAmmo9` int(11) DEFAULT 0,
  `houseWeapon10` int(11) DEFAULT 0,
  `houseAmmo10` int(11) DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `houses`
--

INSERT INTO `houses` (`ID`, `owner`, `address`, `price`, `type`, `locked`, `money`, `houseint`, `extposx`, `extposy`, `extposz`, `extposa`, `intposx`, `intposy`, `intposz`, `intposa`, `kitchenposx`, `kitchenposy`, `kitchenposz`, `visit`, `houseWeapon1`, `houseAmmo1`, `houseWeapon2`, `houseAmmo2`, `houseWeapon3`, `houseAmmo3`, `houseWeapon4`, `houseAmmo4`, `houseWeapon5`, `houseAmmo5`, `houseWeapon6`, `houseAmmo6`, `houseWeapon7`, `houseAmmo7`, `houseWeapon8`, `houseAmmo8`, `houseWeapon9`, `houseAmmo9`, `houseWeapon10`, `houseAmmo10`) VALUES
(17, '-', 'Ganton', 20000, 1, 1, 0, 1, 2307.03, -1679.18, 14.3316, 4.14085, 338.29, 1794.87, 1002.17, 269.09, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(18, '-', 'Palomino Creek', 0, 2, 1, 0, 1, 2236.48, 168.302, 28.1535, 358.48, 351.59, 1669.31, 1002.17, 176.03, 0, 0, 0, 1742618902, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(8, '-', 'Idlewood', 10000, 1, 1, 0, 1, 1842.97, -1633.63, 13.5053, 356.269, 337.61, 1854.1, 1002.08, 265.14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(253, '-', 'Marina', 120000, 3, 1, 0, 1, 685.556, -1421.88, 14.7687, 359.284, 1263.68, -605.3, 1001.08, 189.5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(286, '-', 'Temple', 149000, 3, 1, 0, 1, 1242.29, -1099.5, 27.9766, 268.421, 4577.82, -2527.82, 5.28, 262.63, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(7, '-', 'Idlewood', 10000, 1, 1, 0, 1, 1859.27, -1649.02, 13.2553, 166.042, 845.89, -2048, 1476.91, 92.6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(6, '-', 'Idlewood', 10000, 1, 1, 0, 1, 1861.01, -1648.98, 13.2553, 161.673, 845.89, -2048, 1476.91, 92.6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(5, '-', 'Idlewood', 10000, 1, 1, 0, 1, 1859.29, -1636.36, 13.2553, 2.8311, 845.89, -2048, 1476.91, 92.6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(4, '-', 'Idlewood', 10000, 1, 1, 0, 1, 1861.03, -1636.32, 13.2553, 356.543, 338.29, 1794.87, 1002.17, 269.09, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(3, '-', 'Richman', 0, 2, 1, 0, 1, 645.963, -1117.45, 44.207, 217.618, 351.59, 1669.31, 1002.17, 176.03, 0, 0, 0, 1745153667, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(2, '-', 'Idlewood', 10000, 1, 1, 0, 1, 1874.79, -1644.35, 13.2553, 262.466, 338.29, 1794.87, 1002.17, 269.09, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(1, '-', 'Idlewood', 10000, 1, 1, 0, 1, 1874.74, -1642.55, 13.2553, 258.577, 845.89, -2048, 1476.91, 92.6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(300, '-', 'Idlewood', 10000, 1, 1, 0, 0, 1876.74, -1655.93, 13.8885, 261.937, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(288, '-', 'Mulholland Intersection', 0, 2, 1, 0, 0, 1540.47, -851.303, 64.3361, 260.646, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(292, '-', 'Richman', 0, 2, 1, 0, 0, 298.885, -1338.48, 53.4405, 200.803, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(299, '-', 'Marina', 10000, 1, 1, 0, 0, 769.228, -1745.97, 13.0703, 271.522, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(291, '-', 'Mulholland', 0, 3, 1, 0, 0, 1496.95, -687.893, 95.5633, 1.28314, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(293, '-', 'Richman', 0, 1, 1, 0, 0, 298.812, -1338.53, 53.4404, 219.062, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(294, '-', 'Richman', 0, 2, 1, 0, 0, 298.878, -1338.48, 53.4405, 228.133, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(295, '-', 'Richman', 0, 2, 1, 0, 0, 298.8, -1338.21, 53.4405, 195.393, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(296, '-', 'Richman', 0, 2, 1, 0, 0, 298.914, -1338.46, 53.4405, 216.065, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(297, '-', 'Richman', 0, 2, 1, 0, 0, 298.901, -1338.47, 53.4405, 203.937, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(298, '-', 'Richman', 0, 2, 1, 0, 0, 298.99, -1338.6, 53.4405, 235.873, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(9, '-', 'Idlewood', 10000, 1, 1, 0, 1, 1841.19, -1648.78, 13.7866, 177.086, 337.61, 1854.1, 1002.08, 265.14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10, '-', 'Idlewood', 15000, 2, 1, 0, 1, 1885.9, -1643.74, 13.9338, 85.1263, 338.78, 1734.95, 1002.08, 268.46, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11, '-', 'Idlewood', 15000, 2, 1, 0, 1, 1884.92, -1628.94, 13.515, 77.061, 338.78, 1734.95, 1002.08, 268.46, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(12, '-', 'Idlewood', 20000, 2, 1, 0, 1, 1837.98, -1706.73, 14.1566, 173.051, 736.03, 1672.08, 501.08, 356.23, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(301, 'Yuuki_Clawrine', 'Mulholland', 4000, 3, 1, 0, 0, 1298.41, -798.002, 84.1406, 207.634, 0, 0, 0, 0, 0, 0, 0, 1767022625, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(302, '-', 'Ganton', 20000, 2, 1, 0, 0, 2495.31, -1691.13, 14.7656, 184.748, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(13, '-', 'Ganton', 15000, 1, 1, 0, 0, 2514.32, -1691.62, 14.046, 226.709, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(14, '-', 'Ganton', 20000, 2, 1, 0, 0, 2523.27, -1679.38, 15.497, 272.903, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(15, '-', 'Ganton', 15000, 1, 1, 0, 0, 2524.71, -1658.7, 15.824, 268.42, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(16, '-', 'Ganton', 15000, 1, 1, 0, 0, 2513.73, -1650.26, 14.3557, 310.275, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(19, '-', 'Ganton', 15000, 1, 1, 0, 0, 2498.55, -1642.25, 14.1131, 11.1927, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(20, '-', 'Ganton', 20000, 2, 1, 0, 0, 2486.51, -1644.53, 14.0703, 6.55054, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(21, '-', 'Ganton', 15000, 1, 1, 0, 0, 2469.51, -1646.35, 13.7801, 13.7207, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(22, '-', 'Ganton', 18000, 1, 1, 0, 0, 2451.97, -1641.41, 14.0662, 3.70835, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(23, '-', 'Ganton', 22000, 2, 1, 0, 0, 2434.69, -1645.65, 16.3106, 350.808, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(24, '-', 'Ganton', 22000, 2, 1, 0, 0, 2427.21, -1643.93, 16.5277, 11.2039, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(25, '-', 'Ganton', 25000, 2, 1, 0, 0, 2405.09, -1645.12, 16.1867, 357.598, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(26, '-', 'Ganton', 22000, 2, 1, 0, 0, 2392.86, -1648.8, 14.0615, 17.9429, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(27, '-', 'Ganton', 22000, 2, 1, 0, 0, 2378.6, -1649.16, 16.3147, 273.907, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(28, '-', 'Ganton', 22000, 2, 1, 0, 0, 2363.24, -1649.02, 15.8538, 85.374, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(29, '-', 'Ganton', 23000, 2, 1, 0, 0, 2370.41, -1675.31, 16.2413, 88.2144, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(30, '-', 'Ganton', 23000, 2, 1, 0, 0, 2387.2, -1674.71, 17.1756, 270.951, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(31, '-', 'Ganton', 22000, 2, 1, 0, 0, 2404.39, -1673.3, 14.19, 177.501, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(32, '-', 'Ganton', 25000, 2, 1, 0, 0, 2411.01, -1722.42, 15.9208, 92.3835, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(33, '-', 'Ganton', 24500, 2, 1, 0, 0, 2400.39, -1721.97, 16.5899, 266.37, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(34, '-', 'Ganton', 24000, 2, 1, 0, 0, 2387.9, -1718.15, 16.0544, 266.576, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(35, '-', 'Ganton', 20000, 2, 1, 0, 0, 2326.88, -1681.88, 14.9297, 96.1209, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(36, '-', 'Ganton', 15000, 1, 1, 0, 0, 2326.78, -1716.7, 14.2379, 6.50406, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(37, '-', 'Ganton', 15000, 1, 1, 0, 0, 2308.91, -1714.33, 14.9801, 350.1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(38, '-', 'Ganton', 15000, 1, 1, 0, 0, 2282.33, -1641.22, 15.8898, 2.79834, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(39, '-', 'Ganton', 15000, 1, 1, 0, 0, 2257.17, -1643.95, 15.8082, 347.796, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40, '-', 'Ganton', 15000, 1, 1, 0, 0, 2244.58, -1637.66, 16.2379, 339.562, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(41, '-', 'Ganton', 24000, 2, 1, 0, 0, 2228.61, -1793.41, 14.1799, 178.838, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(42, '-', 'Ganton', 24000, 2, 1, 0, 0, 2237.12, -1778.59, 14.1521, 353.273, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(43, '-', 'Ganton', 24000, 2, 1, 0, 0, 2245.34, -1803.59, 14.1415, 166.745, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(44, '-', 'Ganton', 24000, 2, 1, 0, 0, 2257.8, -1788, 14.1415, 350.449, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45, '-', 'Ganton', 24000, 2, 1, 0, 0, 2274.57, -1789.56, 14.5766, 186.016, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(46, '-', 'Ganton', 24000, 2, 1, 0, 0, 2279.52, -1781.56, 14.5779, 350.984, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(47, '-', 'Ganton', 240000, 2, 1, 0, 0, 2274.75, -1805.53, 14.6177, 3.94029, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(48, '-', 'Ganton', 240000, 2, 1, 0, 0, 2281.61, -1818.51, 14.6176, 255.468, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(49, '-', 'Ganton', 240000, 2, 1, 0, 0, 2297.58, -1818.37, 14.5778, 81.5252, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(303, '-', 'Ganton', 24000, 2, 1, 0, 0, 2307.16, -1820.18, 14.1521, 278.024, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(50, '-', 'Ganton', 24000, 2, 1, 0, 0, 2305.27, -1792.87, 14.1521, 180.044, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(51, '-', 'Ganton', 24000, 2, 1, 0, 0, 2312.11, -1778.59, 14.1521, 341.206, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(52, '-', 'Ganton', 24000, 2, 1, 0, 0, 2318.52, -1792.86, 14.1521, 178.796, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(53, '-', 'Ganton', 24000, 2, 1, 0, 0, 2331.71, -1778.59, 14.1521, 342.573, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(54, '-', 'Ganton', 24000, 2, 1, 0, 0, 2329.77, -1806.07, 14.1521, 80.5936, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(55, '-', 'Ganton', 24000, 2, 1, 0, 0, 2353.23, -1791.93, 14.9142, 190.611, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(56, '-', 'Ganton', 24000, 2, 1, 0, 0, 2341.82, -1780.4, 13.9381, 342.245, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(57, '-', 'Ganton', 24000, 2, 1, 0, 0, 2358.09, -1780.4, 13.9378, 331.568, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58, '-', 'Ganton', 24000, 2, 1, 0, 0, 2384.6, -1778.92, 13.8755, 340.695, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(59, '-', 'Ganton', 24000, 2, 1, 0, 0, 2396.73, -1778.92, 13.8755, 334.239, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(60, '-', 'Ganton', 24000, 2, 1, 0, 0, 2382.4, -1800.92, 13.9373, 162.069, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(61, '-', 'Ganton', 24000, 2, 1, 0, 0, 2398.68, -1800.91, 13.9351, 165.489, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `inventory`
--

CREATE TABLE `inventory` (
  `id` int(11) NOT NULL,
  `ownerid` int(11) NOT NULL DEFAULT -1,
  `item` varchar(32) NOT NULL DEFAULT 'None',
  `quantity` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `inventory`
--

INSERT INTO `inventory` (`id`, `ownerid`, `item`, `quantity`) VALUES
(1, 1, 'Handphone', 1),
(22, 1, 'Mineral Water', 2),
(43, 1, 'Component', 570),
(44, 1, 'Walkie Talkie', 1),
(150, 1, 'Seed', 50),
(500, 1, 'Fresh Milk', 7),
(505, 3, 'Snack', 5),
(506, 3, 'Mineral Water', 5),
(507, 4, 'Snack', 2),
(508, 4, 'Mineral Water', 3),
(509, 3, 'Snack', 5),
(510, 3, 'Mineral Water', 5),
(511, 3, 'Handphone', 1),
(512, 3, 'Milk', 1),
(513, 4, 'Snack', 5),
(514, 4, 'Mineral Water', 5),
(515, 4, 'Handphone', 1),
(516, 5, 'Snack', 5),
(517, 5, 'Mineral Water', 5),
(518, 5, 'Handphone', 1),
(520, 6, 'Handphone', 1),
(521, 6, 'Snack', 5),
(522, 6, 'Mineral Water', 5),
(523, 6, 'Fresh Milk', 1),
(524, 7, 'Snack', 5),
(525, 7, 'Mineral Water', 5),
(526, 8, 'Snack', 3),
(527, 8, 'Mineral Water', 4),
(528, 9, 'Snack', 5),
(529, 9, 'Mineral Water', 5),
(530, 10, 'Snack', 5),
(531, 10, 'Mineral Water', 5),
(532, 8, 'Handphone', 1),
(533, 8, 'Boombox', 1),
(534, 11, 'Snack', 5),
(535, 11, 'Mineral Water', 5),
(536, 12, 'Snack', 9),
(537, 12, 'Mineral Water', 9),
(539, 13, 'Snack', 5),
(540, 13, 'Mineral Water', 5),
(541, 13, 'Handphone', 1),
(542, 1, 'Milk', 2),
(543, 14, 'Snack', 5),
(544, 14, 'Mineral Water', 5),
(545, 14, 'Medicine', 2),
(546, 15, 'Snack', 5),
(547, 15, 'Mineral Water', 5),
(548, 14, 'Handphone', 1),
(549, 14, 'Walkie Talkie', 1),
(550, 15, 'Handphone', 1),
(551, 15, 'Walkie Talkie', 1),
(552, 16, 'Snack', 5),
(553, 16, 'Mineral Water', 5),
(554, 18, 'Snack', 5),
(555, 18, 'Mineral Water', 5),
(556, 15, 'Component', 200),
(557, 14, 'First Aid', 1),
(558, 14, 'Medkit', 1),
(559, 19, 'Snack', 5),
(560, 19, 'Mineral Water', 5),
(572, 21, 'Snack', 5),
(573, 21, 'Mineral Water', 5),
(578, 1, 'Worm', 85),
(581, 4, 'Worm', 82),
(582, 22, 'Snack', 5),
(583, 22, 'Mineral Water', 5),
(584, 22, 'Fishing Rod', 1),
(585, 22, 'Worm', 100),
(586, 23, 'Snack', 5),
(587, 23, 'Mineral Water', 5),
(589, 23, 'Handphone', 1),
(591, 9, 'Fresh Milk', 1),
(593, 12, 'Fishing Rod', 1),
(594, 12, 'Worm', 1),
(595, 12, 'Fuel Can', 1),
(597, 12, 'Handphone', 1),
(598, 12, 'Walkie Talkie', 1),
(599, 12, 'Boombox', 1),
(600, 24, 'Snack', 5),
(601, 24, 'Mineral Water', 5),
(602, 8, 'Fishing Rod', 1),
(603, 8, 'Worm', 1),
(604, 1, 'Potato', 86),
(605, 1, 'Roasted Potato', 3),
(606, 1, 'French Fries', 10),
(607, 29, 'Snack', 5),
(608, 29, 'Mineral Water', 5),
(609, 1, 'Material', 1000),
(610, 1, 'Mask', 1),
(611, 34, 'Snack', 5),
(612, 34, 'Mineral Water', 5),
(613, 36, 'Snack', 5),
(614, 36, 'Mineral Water', 5),
(615, 37, 'Snack', 5),
(616, 37, 'Mineral Water', 5),
(617, 1, 'Fuel Can', 3),
(618, 1, 'Fishing Rod', 4),
(619, 1, 'Meat', 18),
(620, 1, 'Boombox', 1),
(621, 1, 'Marijuana', 7);

-- --------------------------------------------------------

--
-- Table structure for table `lockers`
--

CREATE TABLE `lockers` (
  `id` int(11) NOT NULL,
  `type` int(11) NOT NULL DEFAULT 0,
  `posx` float NOT NULL DEFAULT 0,
  `posy` float NOT NULL DEFAULT 0,
  `posz` float NOT NULL DEFAULT 0,
  `interior` int(11) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `lockers`
--

INSERT INTO `lockers` (`id`, `type`, `posx`, `posy`, `posz`, `interior`) VALUES
(0, 1, 261.699, 111.026, 1004.62, 10),
(1, 2, 948.293, -1470.43, 2761.02, 2),
(2, 3, -1992.53, -80.2679, 1060.99, 1),
(3, 4, 2465.24, 2252.1, 91.6868, 1),
(4, 3, 1468.35, -15.5427, 1000.92, 1),
(5, 5, -4120.79, 868.09, 10.0237, 1),
(7, 2, 357.778, 150.822, 1025.79, 3),
(6, 4, 2502.84, 2477.53, -84.9054, 1),
(8, 3, 1269.94, -1308.82, 1061.14, 1),
(9, 2, 1383.21, -25.8476, 1000.92, 1),
(10, 6, 1018.34, -1954.71, 924.577, 2),
(11, 6, 948.098, -1761.44, 19.3478, 0);

-- --------------------------------------------------------

--
-- Table structure for table `loglogin`
--

CREATE TABLE `loglogin` (
  `no` int(11) NOT NULL,
  `username` varchar(40) NOT NULL DEFAULT 'None',
  `reg_id` int(11) NOT NULL DEFAULT 0,
  `password` varchar(40) NOT NULL DEFAULT 'None',
  `time` varchar(40) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `logpay`
--

CREATE TABLE `logpay` (
  `player` varchar(40) NOT NULL DEFAULT 'None',
  `playerid` int(11) NOT NULL DEFAULT 0,
  `toplayer` varchar(40) NOT NULL DEFAULT 'None',
  `toplayerid` int(11) NOT NULL DEFAULT 0,
  `ammount` int(11) NOT NULL DEFAULT 0,
  `time` bigint(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `logstaff`
--

CREATE TABLE `logstaff` (
  `command` varchar(50) NOT NULL,
  `admin` varchar(50) NOT NULL DEFAULT '*',
  `adminid` int(11) NOT NULL DEFAULT -1,
  `player` varchar(50) NOT NULL DEFAULT '*',
  `playerid` int(11) NOT NULL DEFAULT -1,
  `str` varchar(50) NOT NULL DEFAULT '*',
  `time` bigint(20) UNSIGNED NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `logstaff`
--

INSERT INTO `logstaff` (`command`, `admin`, `adminid`, `player`, `playerid`, `str`, `time`) VALUES
('SETLEADER', 'Ken_Clarence(Fann)', 1, 'Ken_Clarence', 1, '1', 1763848023),
('SETLEADER', 'Ken_Clarence(Fann)', 1, 'Ken_Clarence', 1, '0', 1763874428),
('SETFACTION', 'Ken_Clarence(Fann)', 1, 'Ken_Clarence', 1, '3(6 rank)', 1764117390),
('SETADMINLEVEL', 'Ken_Clarence(Fann)', 1, 'Edgar_Rutgle', 4, '6', 1764236585),
('SETMONEY', 'Edgar_Rutgle(Samsudin)', 4, 'Edgar_Rutgle', 4, '5000', 1764238785),
('SETLEADER', 'Ken_Clarence(Fann)', 1, 'Edgar_Rutgle', 4, '5', 1764239774),
('SETFACTION', 'Ken_Clarence(Fann)', 1, 'Ken_Clarence', 1, '5(6 rank)', 1764239892),
('SETVIP', 'Edgar_Rutgle(Samsudin)', 4, 'Edgar_Rutgle', 4, '3(0 days)', 1764241735),
('SETFACTION', 'Edgar_Rutgle(Vall)', 4, 'Edgar_Rutgle', 4, '3(3 rank)', 1764326814),
('SETMONEY', 'Ken_Clarence(Fann)', 1, 'Leonardo_Vanzz', 6, '500000', 1764330887),
('SETFACTION', 'Ken_Clarence(Fann)', 1, 'Ken_Clarence', 1, '1(6 rank)', 1764332919),
('SETFACTION', 'Ken_Clarence(Fann)', 1, 'Ken_Clarence', 1, '4(5 rank)', 1764371965),
('SETFACTION', 'Ken_Clarence(Fann)', 1, 'Ken_Clarence', 1, '4(6 rank)', 1764371974),
('SETHELPERLEVEL', 'Edgar_Rutgle(Vall)', 4, 'Porkcho_Armagedov', 8, '3', 1764576944),
('SETHELPERLEVEL', 'Edgar_Rutgle(Vall)', 4, 'Porkcho_Armagedov', 8, '2', 1764576955),
('SETHELPERLEVEL', 'Ken_Clarence(Fann)', 1, 'Leon_Wederrson', 12, '1', 1765787817),
('SETADMINLEVEL', 'Ken_Clarence(Fann)', 1, 'Leon_Wederrson', 12, '0', 1765787831),
('SETLEADER', 'Ken_Clarence(Fann)', 1, 'Leon_Wederrson', 12, '3', 1765787884),
('GIVEMONEYALL', 'Mark_Oklama(Vall)', 4, '*', -1, '$5,000', 1766991821),
('GIVEMONEYALL', 'Mark_Oklama(Vall)', 4, '*', -1, '$5,000', 1767017501),
('GIVEMONEYALL', 'Mark_Oklama(Vall)', 4, '*', -1, '$5,000', 1767017506),
('GIVEMONEYALL', 'Mark_Oklama(Vall)', 4, '*', -1, '$5,000', 1767018082),
('GIVEMONEYALL', 'Mark_Oklama(Vall)', 4, '*', -1, '$1,000', 1767020382),
('SETGOLD', 'Ken_Clarence(Fann)', 1, 'Ken_Clarence', 1, '10000', 1773497960),
('SETADMINLEVEL', 'Ken_Clarence(Fann)', 1, 'Porkcho_Armagedov', 8, '5', 1773881318);

-- --------------------------------------------------------

--
-- Table structure for table `modshop`
--

CREATE TABLE `modshop` (
  `id` int(11) NOT NULL,
  `pos_x` float NOT NULL DEFAULT 0,
  `pos_y` float NOT NULL DEFAULT 0,
  `pos_z` float NOT NULL DEFAULT 0,
  `virtual` int(11) NOT NULL DEFAULT 0,
  `interior` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `modshop`
--

INSERT INTO `modshop` (`id`, `pos_x`, `pos_y`, `pos_z`, `virtual`, `interior`) VALUES
(1, 1111.23, -1249.38, 15.55, 0, 0),
(2, 1103.75, -1249.51, 15.55, 0, 0),
(3, 350.38, -1809.83, 4.61, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `object`
--

CREATE TABLE `object` (
  `id` int(11) NOT NULL,
  `posx` float NOT NULL,
  `posy` float NOT NULL,
  `posz` float NOT NULL,
  `posrx` float NOT NULL,
  `posry` float NOT NULL,
  `posrz` float NOT NULL,
  `interior` int(11) NOT NULL DEFAULT 0,
  `world` int(11) NOT NULL DEFAULT 0,
  `object` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ores`
--

CREATE TABLE `ores` (
  `id` int(11) NOT NULL,
  `type` int(11) NOT NULL DEFAULT 0,
  `posx` float DEFAULT 0,
  `posy` float DEFAULT 0,
  `posz` float DEFAULT 0,
  `posrx` float DEFAULT 0,
  `posry` float DEFAULT 0,
  `posrz` float DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `ores`
--

INSERT INTO `ores` (`id`, `type`, `posx`, `posy`, `posz`, `posrx`, `posry`, `posrz`) VALUES
(0, 0, 464.381, 866.534, -28.387, 0, 0, 0),
(1, 1, 555.939, 928.367, -43.5709, 0, 0, 0),
(2, 0, 613.141, 865.3, -43.5509, 0, 0, 0),
(3, 1, 637.747, 831.97, -43.6309, 0, 0, 0),
(4, 0, 671.772, 927.05, -41.4543, 0, 0, 0),
(5, 0, 652.36, 738.067, -11.904, 0, 0, 0),
(6, 1, 640.83, 731.161, -2.64683, 0, 0, 0),
(7, 1, 500.121, 781.126, -21.9991, 0, 0, 0),
(8, 0, 488.845, 785.109, -22.3256, 0, 0, 0),
(9, 1, 685.946, 820.716, -28.3049, 0, 0, 0),
(10, 0, 562.108, 982.26, -7.96277, 0, 0, 0),
(11, 0, 535.467, 909.043, -43.4109, 0, 0, 0),
(12, 0, 539.144, 882.115, -36.6565, 0, 0, 0),
(13, 1, 461.884, 884.778, -28.8179, 0, 0, 0),
(14, 1, 698.502, 841.609, -28.2711, 0, 0, 0),
(15, 1, 487.904, 800.007, -22.22, 0, 0, 0),
(16, 0, 546.501, 824.598, -29.9684, 0, 0, 0),
(17, 1, 576.64, 805.685, -29.4404, 0, 0, 0),
(18, 1, 554.326, 786.207, -19.1056, 0, 0, 0),
(19, 1, 709.745, 921.678, -19.4611, 0, 0, 0),
(20, 0, 714.078, 913.618, -19.2864, 0, 0, 0),
(21, 1, 744.818, 776.606, -8.06283, 0, 0, 0),
(22, 0, 600.437, 932.102, -41.5237, 0, 0, 0),
(23, 0, 597.532, 829.781, -43.959, 0, 0, 0),
(24, 1, 540.974, 842.47, -42.1793, 0, 0, 0),
(25, 1, 696.797, 844.561, -28.9438, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `parks`
--

CREATE TABLE `parks` (
  `id` int(11) NOT NULL,
  `posx` float DEFAULT 0,
  `posy` float DEFAULT 0,
  `posz` float DEFAULT 0,
  `interior` int(11) DEFAULT 0,
  `world` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=COMPACT;

--
-- Dumping data for table `parks`
--

INSERT INTO `parks` (`id`, `posx`, `posy`, `posz`, `interior`, `world`) VALUES
(1, 1099.07, -1217.02, 17.8047, 0, 0),
(2, 355.327, 1166.64, 8.16109, 0, 0),
(3, 1179.71, -1361.24, 13.9505, 0, 0),
(4, 1023.74, -1840.72, 13.3499, 0, 0),
(7, 367.571, -2042.84, 7.32892, 0, 0),
(8, 1270.06, -1797.79, 13.3998, 0, 0),
(9, 2109.9, -1779.47, 13.4792, 0, 0),
(10, 1285.4, -1550.91, 13.2209, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `plants`
--

CREATE TABLE `plants` (
  `id` int(11) NOT NULL,
  `type` int(11) NOT NULL DEFAULT 0,
  `time` int(11) NOT NULL DEFAULT 0,
  `posx` float NOT NULL DEFAULT 0,
  `posy` float NOT NULL DEFAULT 0,
  `posz` float NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `players`
--

CREATE TABLE `players` (
  `reg_id` int(10) UNSIGNED NOT NULL,
  `username` varchar(24) NOT NULL DEFAULT '',
  `ucp` varchar(22) NOT NULL DEFAULT '',
  `adminname` varchar(24) NOT NULL DEFAULT 'None',
  `twittername` varchar(64) NOT NULL DEFAULT 'None',
  `ip` varchar(24) NOT NULL DEFAULT '',
  `password` char(64) NOT NULL DEFAULT '',
  `salt` char(16) NOT NULL DEFAULT '',
  `email` varchar(40) NOT NULL DEFAULT 'None',
  `admin` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `helper` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `level` int(10) UNSIGNED NOT NULL DEFAULT 1,
  `levelup` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `vip` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `vip_time` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `gold` int(11) NOT NULL DEFAULT 0,
  `reg_date` varchar(30) NOT NULL DEFAULT '-',
  `last_login` varchar(30) NOT NULL DEFAULT '-',
  `hopecoin` int(11) NOT NULL DEFAULT 0,
  `money` int(11) NOT NULL DEFAULT 0,
  `bmoney` int(11) NOT NULL DEFAULT 0,
  `brek` mediumint(8) UNSIGNED NOT NULL DEFAULT 0,
  `phone` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `phonecredit` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `phonebook` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `wt` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `hours` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `minutes` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `seconds` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `paycheck` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `skin` int(11) NOT NULL DEFAULT 0,
  `facskin` int(11) NOT NULL DEFAULT 0,
  `gender` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `age` varchar(30) NOT NULL DEFAULT '-',
  `origin` varchar(32) NOT NULL DEFAULT 'American',
  `height` int(11) NOT NULL DEFAULT 183,
  `weight` int(11) NOT NULL DEFAULT 73,
  `indoor` mediumint(9) NOT NULL DEFAULT -1,
  `inbiz` mediumint(9) NOT NULL DEFAULT -1,
  `inhouse` mediumint(9) NOT NULL DEFAULT -1,
  `posx` float NOT NULL DEFAULT 0,
  `posy` float NOT NULL DEFAULT 0,
  `posz` float NOT NULL DEFAULT 0,
  `posa` float NOT NULL DEFAULT 0,
  `interior` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `world` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `health` float NOT NULL DEFAULT 100,
  `armour` float NOT NULL DEFAULT 0,
  `hunger` smallint(6) NOT NULL DEFAULT 100,
  `bladder` smallint(6) NOT NULL DEFAULT 100,
  `energy` smallint(6) NOT NULL DEFAULT 100,
  `claimed` int(11) NOT NULL DEFAULT 0,
  `claimedcode` int(11) NOT NULL DEFAULT 0,
  `sick` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `hospital` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `injured` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `duty` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `dutytime` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `faction` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `factionrank` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `factionlead` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `family` tinyint(4) NOT NULL DEFAULT -1,
  `familyrank` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `robtime` int(11) NOT NULL DEFAULT 0,
  `jail` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `jail_time` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `arrest` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `arrest_time` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `warn` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `booster` int(11) NOT NULL DEFAULT 0,
  `boosttime` int(11) NOT NULL DEFAULT 0,
  `job` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `job2` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `jobtime` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `sidejobtime` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `exitjob` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `taxitime` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `medkit` mediumint(9) NOT NULL DEFAULT 0,
  `helmet` int(11) NOT NULL DEFAULT 0,
  `mask` int(11) NOT NULL DEFAULT -1,
  `couple` int(11) NOT NULL DEFAULT -1,
  `charstory` int(11) NOT NULL DEFAULT 0,
  `gps_arrow` int(11) NOT NULL DEFAULT 1318,
  `food` mediumint(9) NOT NULL DEFAULT 0,
  `seed` mediumint(9) NOT NULL DEFAULT 0,
  `potato` mediumint(9) NOT NULL DEFAULT 0,
  `wheat` mediumint(9) NOT NULL DEFAULT 0,
  `orange` mediumint(9) NOT NULL DEFAULT 0,
  `price1` mediumint(8) UNSIGNED NOT NULL DEFAULT 0,
  `price2` mediumint(8) UNSIGNED NOT NULL DEFAULT 0,
  `price3` mediumint(8) UNSIGNED NOT NULL DEFAULT 0,
  `price4` mediumint(8) UNSIGNED NOT NULL DEFAULT 0,
  `marijuana` mediumint(9) NOT NULL DEFAULT 0,
  `plant` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `plant_time` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `fishtool` tinyint(4) NOT NULL DEFAULT 0,
  `fish` mediumint(9) NOT NULL DEFAULT 0,
  `worm` mediumint(9) NOT NULL DEFAULT 0,
  `idcard` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `idcard_time` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `drivelic` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `drivelic_time` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `drivelic_delay` int(11) NOT NULL DEFAULT 0,
  `hbemode` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `invmode` int(11) NOT NULL DEFAULT 1,
  `togpm` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `toglog` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `togads` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `togwt` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `Gun1` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `Gun2` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `Gun3` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `Gun4` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `Gun5` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `Gun6` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `Gun7` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `Gun8` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `Gun9` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `Gun10` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `Gun11` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `Gun12` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `Gun13` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `Ammo1` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `Ammo2` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `Ammo3` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `Ammo4` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `Ammo5` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `Ammo6` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `Ammo7` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `Ammo8` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `Ammo9` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `Ammo10` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `Ammo11` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `Ammo12` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `Ammo13` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `weaponlevel_1` int(11) NOT NULL DEFAULT 1,
  `weaponlevel_2` int(11) NOT NULL DEFAULT 1,
  `weaponlevel_3` int(11) NOT NULL DEFAULT 1,
  `weaponlevel_4` int(11) NOT NULL DEFAULT 1,
  `weaponlevel_5` int(11) NOT NULL DEFAULT 1,
  `weaponlevel_6` int(11) NOT NULL DEFAULT 1,
  `weaponlevel_7` int(11) NOT NULL DEFAULT 1,
  `weaponlevel_8` int(11) NOT NULL DEFAULT 1,
  `weaponlevel_9` int(11) NOT NULL DEFAULT 1,
  `weaponlevel_10` int(11) NOT NULL DEFAULT 1,
  `weaponlevel_11` int(11) NOT NULL DEFAULT 1,
  `weaponexp_1` int(11) NOT NULL DEFAULT 0,
  `weaponexp_2` int(11) NOT NULL DEFAULT 0,
  `weaponexp_3` int(11) NOT NULL DEFAULT 0,
  `weaponexp_4` int(11) NOT NULL DEFAULT 0,
  `weaponexp_5` int(11) NOT NULL DEFAULT 0,
  `weaponexp_6` int(11) NOT NULL DEFAULT 0,
  `weaponexp_7` int(11) NOT NULL DEFAULT 0,
  `weaponexp_8` int(11) NOT NULL DEFAULT 0,
  `weaponexp_9` int(11) NOT NULL DEFAULT 0,
  `weaponexp_10` int(11) NOT NULL DEFAULT 0,
  `weaponexp_11` int(11) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `players`
--

INSERT INTO `players` (`reg_id`, `username`, `ucp`, `adminname`, `twittername`, `ip`, `password`, `salt`, `email`, `admin`, `helper`, `level`, `levelup`, `vip`, `vip_time`, `gold`, `reg_date`, `last_login`, `hopecoin`, `money`, `bmoney`, `brek`, `phone`, `phonecredit`, `phonebook`, `wt`, `hours`, `minutes`, `seconds`, `paycheck`, `skin`, `facskin`, `gender`, `age`, `origin`, `height`, `weight`, `indoor`, `inbiz`, `inhouse`, `posx`, `posy`, `posz`, `posa`, `interior`, `world`, `health`, `armour`, `hunger`, `bladder`, `energy`, `claimed`, `claimedcode`, `sick`, `hospital`, `injured`, `duty`, `dutytime`, `faction`, `factionrank`, `factionlead`, `family`, `familyrank`, `robtime`, `jail`, `jail_time`, `arrest`, `arrest_time`, `warn`, `booster`, `boosttime`, `job`, `job2`, `jobtime`, `sidejobtime`, `exitjob`, `taxitime`, `medkit`, `helmet`, `mask`, `couple`, `charstory`, `gps_arrow`, `food`, `seed`, `potato`, `wheat`, `orange`, `price1`, `price2`, `price3`, `price4`, `marijuana`, `plant`, `plant_time`, `fishtool`, `fish`, `worm`, `idcard`, `idcard_time`, `drivelic`, `drivelic_time`, `drivelic_delay`, `hbemode`, `invmode`, `togpm`, `toglog`, `togads`, `togwt`, `Gun1`, `Gun2`, `Gun3`, `Gun4`, `Gun5`, `Gun6`, `Gun7`, `Gun8`, `Gun9`, `Gun10`, `Gun11`, `Gun12`, `Gun13`, `Ammo1`, `Ammo2`, `Ammo3`, `Ammo4`, `Ammo5`, `Ammo6`, `Ammo7`, `Ammo8`, `Ammo9`, `Ammo10`, `Ammo11`, `Ammo12`, `Ammo13`, `weaponlevel_1`, `weaponlevel_2`, `weaponlevel_3`, `weaponlevel_4`, `weaponlevel_5`, `weaponlevel_6`, `weaponlevel_7`, `weaponlevel_8`, `weaponlevel_9`, `weaponlevel_10`, `weaponlevel_11`, `weaponexp_1`, `weaponexp_2`, `weaponexp_3`, `weaponexp_4`, `weaponexp_5`, `weaponexp_6`, `weaponexp_7`, `weaponexp_8`, `weaponexp_9`, `weaponexp_10`, `weaponexp_11`) VALUES
(1, 'Ken_Clarence', 'Fann', 'Fann', 'Fann', '112.215.225.59', '', '', 'None', 12, 0, 44, 218, 0, 0, 6800, '2025-03-15 05:31:47', '2026-07-02 22:02:32', 0, 6965058, 31506, 195461, 7046, 59, 1, 0, 239, 34, 31, 580726, 208, -1, 1, '18/07/1998', 'American', 183, 73, -1, -1, -1, 1642.86, -2238.08, 13.7989, 279.16, 0, 0, 100, 0, 61, 58, 61, 1, 0, 0, 0, 0, 0, 0, 4, 6, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 4, 0, 0, 0, 0, 0, 0, -1, -1, 1, 19130, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 1784116603, 1, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 24, 0, 32, 0, 34, 0, 0, 42, 0, 0, 0, 0, 0, 21, 0, 953, 0, 8, 0, 0, 816, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(37, 'Panjii_Kurniawan', 'Fann', 'None', '', '140.213.5.59', '', '', 'None', 50, 0, 1, 0, 0, 0, 0, '2026-04-19 20:03:17', '2026-04-19 20:18:14', 0, 250, 5200, 288800, 0, 0, 0, 0, 0, 0, 0, 0, 2, -1, 1, '18/07/1998', 'Indonesia', 183, 73, -1, -1, -1, 1186.27, -1580.07, 15.0163, 88.4891, 0, 0, 100, 0, 100, 100, 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, -1, 0, 1318, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(4, 'Mark_Oklama', 'Vall', 'Vall', '', '103.156.164.83', '', '', 'None', 6, 0, 1, 4, 3, 0, 0, '2025-11-24 05:11:12', '2025-12-30 19:17:17', 0, 21690, 6700, 959710, 3834, 0, 0, 0, 4, 17, 5, 15425, 23, 277, 1, '15/09/2001', 'American', 183, 73, -1, -1, -1, 1047.29, -1713.48, 14.3455, 81.2383, 0, 0, 100, 0, 72, 100, 65, 1, 0, 0, 0, 0, 0, 966, 3, 3, 5, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 0, -1, -1, 1, 1318, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1768252007, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(5, 'Arabella_Leance', 'Rabell', 'None', '', '140.213.4.101', '', '', 'None', 0, 0, 1, 0, 0, 0, 0, '2025-11-24 06:42:23', '2025-11-24 06:46:25', 0, 100, 6700, 239463, 2454, 0, 0, 0, 0, 4, 1, 241, 11, -1, 2, '18/07/1998', 'American', 183, 73, -1, -1, -1, 1642.23, -2335.5, 14.3469, 212.867, 0, 0, 100, 0, 99, 100, 98, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, -1, 0, 1318, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(6, 'Leonardo_Vanzz', 'Kamiell', 'None', '', '114.79.55.248', '', '', 'None', 0, 0, 1, 1, 0, 0, 0, '2025-11-28 11:06:35', '2025-11-28 13:58:50', 0, 499700, 6700, 496030, 7455, 0, 0, 0, 1, 38, 34, 5914, 2, -1, 1, '01/01/2001', 'American', 183, 73, -1, -1, -1, 1463.92, -1732.9, 15.1193, 138.184, 0, 0, 100, 0, 67, 100, 57, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 0, 0, 0, 1764417730, 0, 0, 0, -1, -1, 0, 1318, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1765621766, 0, 0, 1764336266, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(7, 'Venom_Crips', 'Venomm', 'None', '', '180.253.54.220', '', '', 'None', 0, 0, 1, 0, 0, 0, 0, '2025-11-28 21:41:06', '2025-11-28 21:47:21', 0, 250, 6700, 203500, 0, 0, 0, 0, 0, 6, 16, 376, 2, -1, 1, '13/04/2005', 'American', 183, 73, -1, -1, -1, 504.165, -1591.62, 16.258, 92.094, 0, 0, 100, 0, 98, 100, 97, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, -1, 0, 1318, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(8, 'Sam_Wise', 'ciummm', 'Por', 'Porr', '114.10.44.38', '', '', 'None', 5, 0, 2, 7, 0, 0, 0, '2025-11-30 15:20:26', '2026-07-02 17:43:59', 0, 6545, 0, 464913, 8112, 19, 1, 0, 8, 23, 35, 26615, 7, -1, 1, '15/04/1999', 'American', 183, 73, -1, -1, -1, 355.463, -1748.31, 5.63724, 336.389, 0, 0, 100, 0, 80, 100, 90, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 0, -1, -1, 1, 1318, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1784240881, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(9, 'Brad_Reynolds', 'Onlynszee', 'None', '', '140.213.158.164', '', '', 'None', 0, 0, 1, 3, 0, 0, 0, '2025-12-08 03:41:23', '2026-01-08 10:40:36', 0, 5390, 200, 655103, 0, 0, 0, 0, 3, 18, 7, 11887, 14, -1, 1, '8/9/2000', 'American', 183, 73, -1, -1, -1, 1787.04, -2167.64, 14.8163, 90.4891, 0, 0, 125, 98, 54, 100, 50, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 0, -1, -1, 0, 1318, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1768379906, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10, 'Nerd_Sammy', 'Onlynszee', 'None', '', '140.213.230.152', '', '', 'None', 0, 0, 1, 0, 0, 0, 0, '2025-12-08 04:00:28', '2025-12-09 13:04:09', 0, -75050, 5200, 920717, 0, 0, 0, 0, 0, 38, 36, 2316, 2, -1, 1, '8/9/1999', 'American', 183, 73, -1, -1, -1, 1100.67, 1597.53, 36.5097, 163.441, 0, 0, 125, 98, 43, 100, 42, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, -1, 0, 1318, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(13, 'Rizall_Junior', 'Rizall', 'None', '', '103.131.19.37', '', '', 'None', 0, 0, 1, 0, 0, 0, 0, '2025-12-15 09:35:50', '2025-12-19 08:42:13', 0, 170, 5200, 525180, 3172, 20, 1, 0, 0, 36, 37, 2197, 2, -1, 1, '11/06/2000', 'American', 183, 73, -1, -1, -1, 1029.24, -1344.06, 14.6931, 232.284, 0, 0, 96, 0, 93, 100, 93, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, -1, 0, 1318, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1767083905, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(12, 'Leon_Wederrson', 'Leon', 'Leonn', '', '103.166.11.30', '', '', 'None', 0, 2, 1, 3, 0, 0, 0, '2025-12-14 05:03:01', '2026-01-02 07:09:44', 0, 21258, 5200, 785447, 3641, 80, 1, 0, 3, 0, 13, 10813, 2, 70, 1, '27/05/2000', 'American', 183, 73, -1, 9, -1, -45.8101, -90.8641, 3.41719, 90.4335, 0, 0, 220, 0, 69, 100, 64, 1, 0, 0, 0, 0, 0, 602, 3, 6, 3, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, -1, -1, 1, 1318, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(14, 'Edwin_Kenan', 'Rossivip', 'None', '', '36.83.74.123', '', '', 'None', 0, 0, 1, 1, 0, 0, 0, '2025-12-16 11:56:35', '2025-12-18 10:40:33', 0, 392, 5200, 639115, 5347, 100, 1, 1, 1, 9, 54, 4194, 2, 70, 1, '10/10/2000', 'American', 183, 73, -1, -1, -1, 1555.3, -1675.69, 16.9953, 87.1144, 0, 0, 98, 95, 85, 100, 85, 1, 0, 0, 0, 0, 1, 3202, 3, 5, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, -1, 1, 1318, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1767230313, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(15, 'Nathanael_Leandro', 'ravizsulawesi', 'None', '', '140.213.154.189', '', '', 'None', 0, 0, 1, 1, 0, 0, 0, '2025-12-17 07:52:12', '2026-01-02 20:24:30', 0, 4739, 200, 671207, 4235, 20, 1, 1, 1, 27, 50, 5270, 2, -1, 1, '15/04/1998', 'American', 183, 73, -1, -1, -1, 1220.57, -1364.79, 14.5443, 217.035, 0, 0, 90, 0, 85, 100, 84, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, -1, -1, 1, 1318, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(16, 'Finn_Xray', 'ajegile', 'None', '', '160.19.145.201', '', '', 'None', 0, 0, 1, 0, 0, 0, 0, '2025-12-17 09:09:06', '2025-12-18 04:21:05', 0, 250, 5200, 777057, 0, 0, 0, 0, 0, 17, 42, 1062, 2, -1, 1, '8/7/2001', 'American', 183, 73, -1, -1, -1, 1472.55, -1738.53, 13.8469, 8.52809, 0, 0, 100, 0, 100, 100, 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, -1, 0, 1318, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(17, 'Roy_Bustrud', 'ajegile', 'None', '', '160.19.145.201', '', '', 'None', 0, 0, 1, 0, 0, 0, 0, '2025-12-17 09:21:25', '2025-12-17 11:41:41', 0, 250, 200, 376276, 0, 0, 0, 0, 0, 5, 18, 318, 7, -1, 1, '14/7/2000', 'American', 183, 73, -1, -1, -1, 1744.3, -1863.16, 13.8754, 55.907, 0, 0, 100, 0, 100, 100, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, -1, 0, 1318, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(18, 'Kemal_Palevii', 'Kamalgc', 'None', '', '103.159.195.211', '', '', 'None', 0, 0, 1, 0, 0, 0, 0, '2025-12-17 14:48:49', '2025-12-17 14:50:06', 0, 250, 5200, 343042, 0, 0, 0, 0, 0, 1, 18, 78, 2, -1, 1, '25/10/2009', 'American', 183, 73, -1, -1, -1, 1748.87, -1861.38, 14.5615, 197.156, 0, 0, 100, 0, 100, 100, 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, -1, 0, 1318, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(19, 'Jay_Jaeyung', 'JayXyus', 'None', '', '114.10.95.113', '', '', 'None', 0, 0, 1, 0, 0, 0, 0, '2025-12-18 18:18:33', '2025-12-18 18:20:21', 0, 250, 5200, 691515, 0, 0, 0, 0, 0, 1, 48, 108, 1, -1, 1, '23/01/2004', 'American', 183, 73, -1, -1, -1, 1529.97, -2286.79, 13.6828, 300.157, 0, 0, 100, 0, 100, 100, 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, -1, 0, 1318, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(20, 'Marco_Valen', 'Leon', 'None', '', '103.166.11.30', '', '', 'None', 0, 0, 1, 0, 0, 0, 0, '2025-12-18 23:34:23', '2025-12-18 23:34:41', 0, 250, 200, 847582, 0, 0, 0, 0, 0, 0, 18, 18, -1, -1, 0, '', 'American', 183, 73, -1, -1, -1, 808.724, -1389.27, 52.6158, 0, 0, 0, 100, 0, 100, 100, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, -1, 0, 1318, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(21, 'Finn_Roberto', 'yonksrumamen', 'None', '', '160.19.145.201', '', '', 'None', 0, 0, 1, 0, 0, 0, 0, '2025-12-28 21:01:52', '2026-01-02 02:53:15', 0, 200, 5200, 282241, 0, 0, 0, 0, 0, 13, 59, 839, 7, -1, 1, '12/7/2001', 'American', 183, 73, -1, -1, -1, 369.014, -2033.07, 7.97188, 344.324, 0, 0, 125, 0, 99, 100, 99, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, -1, 0, 1318, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1768253481, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(22, 'Nathan_Faurel', 'Dimzz', 'None', '', '103.210.117.83', '', '', 'None', 0, 0, 1, 0, 0, 0, 0, '2025-12-29 13:59:38', '2025-12-29 14:25:12', 0, 5250, 5200, 876647, 0, 0, 0, 0, 0, 25, 34, 1534, 2, -1, 1, '1/9/1999', 'American', 183, 73, -1, -1, -1, 367.602, -2088.79, 8.13594, 154.575, 0, 0, 100, 0, 96, 100, 94, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, -1, 0, 1318, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(23, 'Yuuki_Clawrine', 'Yuuki', 'None', '', '114.10.44.173', '', '', 'None', 0, 0, 1, 2, 0, 0, 0, '2025-12-29 21:19:40', '2025-12-31 16:02:21', 0, 1775, 5200, 717111, 9856, 0, 0, 0, 2, 35, 34, 9334, 18, -1, 1, '05/02/1995', 'American', 183, 73, -1, -1, -1, 392.094, 890.278, 21.2021, 46.3996, 0, 0, 98, 0, 64, 100, 63, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 1767257836, 0, 0, 0, -1, -1, 0, 1318, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1768314588, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(24, 'Bryan_Mike', 'yonksrumamen', 'None', '', '160.19.145.201', '', '', 'None', 0, 0, 1, 0, 0, 0, 0, '2026-01-02 02:54:13', '2026-01-02 02:55:57', 0, 250, 5200, 688330, 0, 0, 0, 0, 0, 1, 44, 104, 2, -1, 1, '12/7/2001', 'American', 183, 73, -1, -1, -1, 1744.38, -1859.18, 14.4375, 0.828743, 0, 0, 125, 0, 100, 100, 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, -1, 0, 1318, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(43, 'Panji_Dewantara', 'Fann', 'None', '', '140.213.4.135', '', '', 'None', 50, 0, 1, 0, 0, 0, 0, '2026-07-01 18:58:11', '2026-07-01 19:01:57', 0, 250, 200, 547016, 0, 0, 0, 0, 0, 3, 42, 222, 2, -1, 1, '18/07/1998', 'Indonesia', 172, 70, -1, -1, -1, 1744.15, -1860.12, 13.878, 1.90998, 0, 0, 100, 0, 100, 100, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, -1, 0, 1318, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `player_fish`
--

CREATE TABLE `player_fish` (
  `id` int(11) NOT NULL,
  `owner` int(11) NOT NULL DEFAULT 0,
  `name` varchar(32) NOT NULL DEFAULT 'None',
  `weight` float NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `player_fish`
--

INSERT INTO `player_fish` (`id`, `owner`, `name`, `weight`) VALUES
(1, 1, 'Megalodon', 90),
(2, 1, 'Megalodon', 90),
(3, 1, 'Turtle', 70),
(4, 1, 'Turtle', 70),
(5, 1, 'Bass', 1.17712),
(6, 1, 'Tuna', 15.8668),
(7, 1, 'Pike', 5.9624),
(8, 1, 'Salmon', 4.56584),
(9, 1, 'Mujair Besar', 8.7521),
(10, 4, 'Bass', 1.36389),
(11, 1, 'Megalodon', 90),
(12, 12, 'Trout', 4.42031);

-- --------------------------------------------------------

--
-- Table structure for table `player_skill`
--

CREATE TABLE `player_skill` (
  `id` int(11) NOT NULL,
  `owner` int(11) NOT NULL DEFAULT 0,
  `name` varchar(32) NOT NULL DEFAULT 'Some Ability',
  `level` int(11) NOT NULL DEFAULT 0,
  `exp` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `player_skill`
--

INSERT INTO `player_skill` (`id`, `owner`, `name`, `level`, `exp`) VALUES
(14, 1, 'Fishing Ability', 10, 277),
(15, 1, 'Cooking Ability', 10, 272),
(16, 1, 'Mechanic Ability', 1, 10),
(17, 1, 'Medical Ability', 1, 0),
(18, 8, 'Fishing Ability', 1, 0),
(19, 8, 'Cooking Ability', 1, 0),
(20, 8, 'Mechanic Ability', 1, 0),
(21, 8, 'Medical Ability', 4, 90),
(22, 12, 'Fishing Ability', 1, 24),
(23, 12, 'Cooking Ability', 1, 0),
(24, 12, 'Mechanic Ability', 1, 0),
(25, 21, 'Fishing Ability', 1, 0),
(26, 21, 'Cooking Ability', 1, 0),
(27, 21, 'Mechanic Ability', 1, 0),
(28, 21, 'Medical Ability', 1, 0),
(29, 4, 'Fishing Ability', 1, 2),
(30, 4, 'Cooking Ability', 1, 0),
(31, 4, 'Mechanic Ability', 1, 0),
(32, 23, 'Fishing Ability', 1, 0),
(33, 23, 'Cooking Ability', 1, 0),
(34, 23, 'Mechanic Ability', 1, 0),
(35, 0, 'Fishing Ability', 1, 0),
(36, 0, 'Cooking Ability', 1, 0),
(37, 0, 'Mechanic Ability', 1, 0),
(38, 0, 'Medical Ability', 4, 90),
(39, 0, 'Fishing Ability', 1, 0),
(40, 0, 'Cooking Ability', 1, 0),
(41, 0, 'Mechanic Ability', 1, 0),
(42, 0, 'Medical Ability', 4, 90),
(43, 0, 'Fishing Ability', 1, 0),
(44, 0, 'Cooking Ability', 1, 0),
(45, 0, 'Mechanic Ability', 1, 0),
(46, 0, 'Medical Ability', 1, 0),
(47, 0, 'Fishing Ability', 1, 0),
(48, 0, 'Cooking Ability', 1, 0),
(49, 0, 'Mechanic Ability', 1, 0),
(50, 0, 'Medical Ability', 1, 0),
(51, 0, 'Fishing Ability', 1, 0),
(52, 0, 'Cooking Ability', 1, 0),
(53, 0, 'Mechanic Ability', 1, 0),
(54, 0, 'Negotiate Ability', 1, 0),
(55, 0, 'Medical Ability', 1, 0),
(56, 25, 'Fishing Ability', 1, 0),
(57, 25, 'Cooking Ability', 1, 0),
(58, 25, 'Mechanic Ability', 1, 0),
(59, 25, 'Medical Ability', 2, 30),
(60, 26, 'Fishing Ability', 1, 0),
(61, 26, 'Cooking Ability', 1, 0),
(62, 26, 'Mechanic Ability', 1, 0),
(63, 26, 'Medical Ability', 1, 0),
(64, 27, 'Fishing Ability', 1, 0),
(65, 27, 'Cooking Ability', 1, 0),
(66, 27, 'Mechanic Ability', 1, 0),
(67, 28, 'Fishing Ability', 1, 0),
(68, 28, 'Cooking Ability', 1, 0),
(69, 28, 'Mechanic Ability', 1, 0),
(70, 30, 'Fishing Ability', 1, 0),
(71, 30, 'Cooking Ability', 1, 0),
(72, 30, 'Mechanic Ability', 1, 0),
(73, 30, 'Medical Ability', 1, 0),
(74, 31, 'Fishing Ability', 1, 0),
(75, 31, 'Cooking Ability', 1, 0),
(76, 31, 'Mechanic Ability', 1, 0),
(77, 31, 'Medical Ability', 1, 0),
(78, 32, 'Fishing Ability', 1, 0),
(79, 32, 'Cooking Ability', 1, 0),
(80, 32, 'Mechanic Ability', 1, 0),
(81, 32, 'Medical Ability', 1, 0),
(82, 35, 'Fishing Ability', 1, 0),
(83, 35, 'Cooking Ability', 1, 0),
(84, 35, 'Mechanic Ability', 1, 0),
(85, 36, 'Fishing Ability', 1, 0),
(86, 36, 'Cooking Ability', 1, 0),
(87, 36, 'Mechanic Ability', 1, 0),
(88, 36, 'Medical Ability', 1, 0),
(89, 37, 'Fishing Ability', 1, 0),
(90, 37, 'Cooking Ability', 1, 0),
(91, 37, 'Mechanic Ability', 1, 0),
(92, 1, 'Fighting Ability', 1, 0),
(93, 8, 'Fighting Ability', 1, 0),
(94, 38, 'Fishing Ability', 1, 0),
(95, 38, 'Cooking Ability', 1, 0),
(96, 38, 'Mechanic Ability', 1, 0),
(97, 38, 'Fighting Ability', 1, 0),
(98, 38, 'Medical Ability', 1, 0),
(99, 39, 'Fishing Ability', 1, 0),
(100, 39, 'Cooking Ability', 1, 0),
(101, 39, 'Mechanic Ability', 1, 0),
(102, 39, 'Fighting Ability', 1, 0),
(103, 39, 'Medical Ability', 1, 0),
(104, 40, 'Fishing Ability', 1, 0),
(105, 40, 'Cooking Ability', 1, 0),
(106, 40, 'Mechanic Ability', 1, 0),
(107, 40, 'Fighting Ability', 1, 0),
(108, 41, 'Fishing Ability', 1, 0),
(109, 41, 'Cooking Ability', 1, 0),
(110, 41, 'Mechanic Ability', 1, 0),
(111, 41, 'Fighting Ability', 1, 0),
(112, 41, 'Medical Ability', 2, 30),
(113, 42, 'Fishing Ability', 1, 0),
(114, 42, 'Cooking Ability', 1, 0),
(115, 42, 'Mechanic Ability', 1, 0),
(116, 42, 'Fighting Ability', 1, 0),
(117, 43, 'Fishing Ability', 1, 0),
(118, 43, 'Cooking Ability', 1, 0),
(119, 43, 'Mechanic Ability', 1, 0),
(120, 43, 'Fighting Ability', 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `playlist`
--

CREATE TABLE `playlist` (
  `id` int(11) NOT NULL,
  `owner` int(11) NOT NULL DEFAULT 0,
  `name` int(11) NOT NULL,
  `link` varchar(64) NOT NULL,
  `duration` varchar(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `requestcs`
--

CREATE TABLE `requestcs` (
  `name` varchar(32) NOT NULL DEFAULT 'Ken_Clarence',
  `user` varchar(32) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `salary`
--

CREATE TABLE `salary` (
  `id` bigint(20) NOT NULL,
  `owner` int(11) DEFAULT 0,
  `info` varchar(46) DEFAULT '',
  `money` int(11) NOT NULL DEFAULT 0,
  `date` varchar(36) DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `salary`
--

INSERT INTO `salary` (`id`, `owner`, `info`, `money`, `date`) VALUES
(11, 13, 'Bus Driver (SideJob)', 446, '2025-12-15 10:07:59'),
(7, 6, 'Bus Driver (SideJob)', 458, '2025-11-28 13:16:39'),
(10, 13, 'Bus Driver (SideJob)', 440, '2025-12-15 09:59:10'),
(12, 1, 'Sweeper (SideJob)', 394, '2026-03-14 15:02:06');

-- --------------------------------------------------------

--
-- Table structure for table `server`
--

CREATE TABLE `server` (
  `id` int(11) NOT NULL DEFAULT 0,
  `servermoney` int(11) NOT NULL DEFAULT 0,
  `material` int(11) NOT NULL DEFAULT 500,
  `materialprice` int(11) NOT NULL DEFAULT 10,
  `lumberprice` int(11) NOT NULL DEFAULT 800,
  `component` int(11) NOT NULL DEFAULT 500,
  `componentprice` int(11) NOT NULL DEFAULT 10,
  `metalprice` int(11) NOT NULL DEFAULT 500,
  `gasoil` int(11) NOT NULL DEFAULT 1000,
  `gasoilprice` int(11) NOT NULL DEFAULT 10,
  `coalprice` int(11) NOT NULL DEFAULT 500,
  `product` int(11) NOT NULL DEFAULT 500,
  `productprice` int(11) NOT NULL DEFAULT 20,
  `apotek` int(11) NOT NULL DEFAULT 500,
  `medicineprice` int(11) NOT NULL DEFAULT 300,
  `medkitprice` int(11) NOT NULL DEFAULT 500,
  `food` int(11) NOT NULL DEFAULT 500,
  `foodprice` int(11) NOT NULL DEFAULT 100,
  `seedprice` int(11) NOT NULL DEFAULT 10,
  `potatoprice` int(11) NOT NULL DEFAULT 10,
  `wheatprice` int(11) NOT NULL DEFAULT 10,
  `orangeprice` int(11) NOT NULL DEFAULT 10,
  `marijuana` int(11) NOT NULL DEFAULT 500,
  `marijuanaprice` int(11) NOT NULL DEFAULT 10,
  `fishprice` int(11) NOT NULL DEFAULT 100,
  `gstationprice` int(11) NOT NULL DEFAULT 100,
  `obatmyr` int(11) NOT NULL DEFAULT 0,
  `obatprice` int(11) NOT NULL DEFAULT 0,
  `crateforklift` int(11) NOT NULL DEFAULT 0,
  `cratekurir` int(11) NOT NULL DEFAULT 0,
  `paper` int(11) NOT NULL DEFAULT 0,
  `paperprice` int(11) NOT NULL DEFAULT 0,
  `hgschema` int(11) NOT NULL DEFAULT 0,
  `arschema` int(11) NOT NULL DEFAULT 0,
  `smgschema` int(11) NOT NULL DEFAULT 0,
  `hgprice` int(11) NOT NULL DEFAULT 70,
  `arprice` int(11) NOT NULL DEFAULT 220,
  `smgprice` int(11) NOT NULL DEFAULT 200,
  `freshmilk` int(11) NOT NULL DEFAULT 0,
  `freshmilkprice` int(11) NOT NULL DEFAULT 0,
  `hopecoin` int(11) NOT NULL DEFAULT 1000,
  `hopecoinprice` int(11) NOT NULL DEFAULT 500,
  `meat` int(11) NOT NULL DEFAULT 5000,
  `meatprice` int(11) NOT NULL DEFAULT 10
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `server`
--

INSERT INTO `server` (`id`, `servermoney`, `material`, `materialprice`, `lumberprice`, `component`, `componentprice`, `metalprice`, `gasoil`, `gasoilprice`, `coalprice`, `product`, `productprice`, `apotek`, `medicineprice`, `medkitprice`, `food`, `foodprice`, `seedprice`, `potatoprice`, `wheatprice`, `orangeprice`, `marijuana`, `marijuanaprice`, `fishprice`, `gstationprice`, `obatmyr`, `obatprice`, `crateforklift`, `cratekurir`, `paper`, `paperprice`, `hgschema`, `arschema`, `smgschema`, `hgprice`, `arprice`, `smgprice`, `freshmilk`, `freshmilkprice`, `hopecoin`, `hopecoinprice`, `meat`, `meatprice`) VALUES
(0, 1453881815, 900, 4, 50, 0, 2, 50, 11350, 3, 45, 399, 8, 5000, 200, 300, 18, 2, 5, 10, 50, 30, 511, 128, 13, 25, 333, 200, 99, 30, 200, 0, 0, 10, 5, 220, 70, 200, 33, 20, 1000, 500, 5000, 10);

-- --------------------------------------------------------

--
-- Table structure for table `toys`
--

CREATE TABLE `toys` (
  `Id` int(11) NOT NULL,
  `Owner` varchar(40) NOT NULL DEFAULT '',
  `Slot0_Model` int(11) NOT NULL DEFAULT 0,
  `Slot0_Bone` int(11) NOT NULL DEFAULT 0,
  `Slot0_XPos` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot0_YPos` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot0_ZPos` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot0_XRot` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot0_YRot` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot0_ZRot` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot0_XScale` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot0_YScale` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot0_ZScale` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot1_Model` int(11) NOT NULL DEFAULT 0,
  `Slot1_Bone` int(11) NOT NULL DEFAULT 0,
  `Slot1_XPos` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot1_YPos` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot1_ZPos` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot1_XRot` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot1_YRot` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot1_ZRot` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot1_XScale` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot1_YScale` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot1_ZScale` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot2_Model` int(11) NOT NULL DEFAULT 0,
  `Slot2_Bone` int(11) NOT NULL DEFAULT 0,
  `Slot2_XPos` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot2_YPos` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot2_ZPos` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot2_XRot` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot2_YRot` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot2_ZRot` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot2_XScale` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot2_YScale` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot2_ZScale` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot3_Model` int(11) NOT NULL DEFAULT 0,
  `Slot3_Bone` int(11) NOT NULL DEFAULT 0,
  `Slot3_XPos` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot3_YPos` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot3_ZPos` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot3_XRot` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot3_YRot` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot3_ZRot` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot3_XScale` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot3_YScale` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot3_ZScale` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot4_Model` int(11) NOT NULL DEFAULT 0,
  `Slot4_Bone` int(11) NOT NULL DEFAULT 0,
  `Slot4_XPos` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot4_YPos` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot4_ZPos` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot4_XRot` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot4_YRot` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot4_ZRot` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot4_XScale` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot4_YScale` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot4_ZScale` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot5_Model` int(11) NOT NULL DEFAULT 0,
  `Slot5_Bone` int(11) NOT NULL DEFAULT 0,
  `Slot5_XPos` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot5_YPos` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot5_ZPos` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot5_XRot` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot5_YRot` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot5_ZRot` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot5_XScale` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot5_YScale` float(20,3) NOT NULL DEFAULT 0.000,
  `Slot5_ZScale` float(20,3) NOT NULL DEFAULT 0.000
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `toys`
--

INSERT INTO `toys` (`Id`, `Owner`, `Slot0_Model`, `Slot0_Bone`, `Slot0_XPos`, `Slot0_YPos`, `Slot0_ZPos`, `Slot0_XRot`, `Slot0_YRot`, `Slot0_ZRot`, `Slot0_XScale`, `Slot0_YScale`, `Slot0_ZScale`, `Slot1_Model`, `Slot1_Bone`, `Slot1_XPos`, `Slot1_YPos`, `Slot1_ZPos`, `Slot1_XRot`, `Slot1_YRot`, `Slot1_ZRot`, `Slot1_XScale`, `Slot1_YScale`, `Slot1_ZScale`, `Slot2_Model`, `Slot2_Bone`, `Slot2_XPos`, `Slot2_YPos`, `Slot2_ZPos`, `Slot2_XRot`, `Slot2_YRot`, `Slot2_ZRot`, `Slot2_XScale`, `Slot2_YScale`, `Slot2_ZScale`, `Slot3_Model`, `Slot3_Bone`, `Slot3_XPos`, `Slot3_YPos`, `Slot3_ZPos`, `Slot3_XRot`, `Slot3_YRot`, `Slot3_ZRot`, `Slot3_XScale`, `Slot3_YScale`, `Slot3_ZScale`, `Slot4_Model`, `Slot4_Bone`, `Slot4_XPos`, `Slot4_YPos`, `Slot4_ZPos`, `Slot4_XRot`, `Slot4_YRot`, `Slot4_ZRot`, `Slot4_XScale`, `Slot4_YScale`, `Slot4_ZScale`, `Slot5_Model`, `Slot5_Bone`, `Slot5_XPos`, `Slot5_YPos`, `Slot5_ZPos`, `Slot5_XRot`, `Slot5_YRot`, `Slot5_ZRot`, `Slot5_XScale`, `Slot5_YScale`, `Slot5_ZScale`) VALUES
(4, 'Ken_Clarence', 19064, 2, 0.165, 0.008, 0.000, -90.000, 90.000, 179.000, 1.000, 1.000, 1.000, 18919, 2, 0.071, 0.020, 0.000, 90.000, 180.000, 90.000, 1.000, 1.000, 1.000, 0, 1, 0.100, -0.250, -0.050, -270.000, 0.000, -60.000, 0.750, 2.000, 1.050, 0, 1, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 1.000, 1.000, 1.000, 0, 0, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0, 0, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000);

-- --------------------------------------------------------

--
-- Table structure for table `trees`
--

CREATE TABLE `trees` (
  `id` int(11) NOT NULL,
  `posx` float DEFAULT NULL,
  `posy` float DEFAULT NULL,
  `posz` float DEFAULT NULL,
  `posrx` float DEFAULT NULL,
  `posry` float DEFAULT NULL,
  `posrz` float DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `trees`
--

INSERT INTO `trees` (`id`, `posx`, `posy`, `posz`, `posrx`, `posry`, `posrz`) VALUES
(0, -523.63, -2247.73, 34.5218, 0, 0, 0),
(1, -623.954, -2261.36, 23.9413, 0, 0, 0),
(2, -628.714, -2394, 29.5843, 0, 0, 0),
(3, -735.625, -2254.4, 27.5423, 0, 0, 0),
(4, -657.756, -2140.98, 24.2563, 0, 0, 0),
(5, -654.44, -2074.7, 25.9842, 0, 0, 0),
(6, -546.637, -1999.71, 48.0892, 0, 0, 0),
(7, -731.541, -2189.38, 34.526, 0, 0, 0),
(8, -732.679, -2200.2, 34.5699, 0, 0, 0),
(9, -739.308, -2193.72, 34.6548, 0, 0, 0),
(10, -865.874, -2199.14, 29.0169, 0, 0, 0),
(11, -814.336, -2247.82, 37.77, 0, 0, 0),
(12, -878.67, -2367.51, 68.2969, 0, 0, 0),
(13, -861.714, -2381.68, 69.0388, 0, 0, 0),
(14, -972.936, -2322.47, 62.7628, 0, 0, 0),
(15, -1043.86, -2303.47, 55.4699, 0, 0, 0),
(16, -979.795, -2391.9, 70.2428, 0, 0, 0),
(17, -928.635, -2531.78, 114.824, 0, 0, 0),
(18, -928.943, -2555.48, 114.897, 0, 0, 0),
(19, -889.914, -2502.48, 110.088, 0, 0, 0),
(20, -874.672, -2612.06, 95.074, 0, 0, 0),
(21, -622.4, -2263.39, 23.9615, 0, 0, 0),
(22, -552.445, -2272.94, 28.3696, 0, 0, 0),
(23, -1065.08, -2548.24, 68.1407, 0, 0, 0),
(24, -744.504, -2441.61, 65.1923, 0, 0, 0),
(25, -818.597, -2657.71, 91.0869, 0, 0, 0),
(26, -734.419, -2690.28, 86.7166, 0, 0, 0),
(27, -686.676, -2630.36, 82.9661, 0, 0, 0),
(28, -707.708, -2695.28, 91.3966, 0, 0, 0),
(29, -757.89, -2538.72, 90.0414, 0, 0, 0),
(30, -748.443, -2509.77, 81.1096, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `ucp`
--

CREATE TABLE `ucp` (
  `id` int(11) NOT NULL,
  `username` varchar(25) NOT NULL DEFAULT '',
  `password` varchar(129) NOT NULL DEFAULT '',
  `ip` varchar(17) NOT NULL DEFAULT '127.0.0.1',
  `admin` int(11) NOT NULL DEFAULT 0,
  `verifystatus` int(11) NOT NULL DEFAULT 0,
  `verifycode` varchar(32) NOT NULL DEFAULT 'RV-000000',
  `discordid` varchar(32) NOT NULL,
  `registerdate` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `ucp`
--

INSERT INTO `ucp` (`id`, `username`, `password`, `ip`, `admin`, `verifystatus`, `verifycode`, `discordid`, `registerdate`) VALUES
(1, 'Fann', '$2b$12$W96CxYPJ8hO2lsiMNggp6e0FFcYjq0ibkWO.plvWbooDuALGj..Ci', '140.213.5.55', 0, 1, 'RV-781622', '1290210051658743833', '2147483647'),
(2, 'Vall', '$2b$12$IURzQMtuwtvNqhHcfeX45.cqNztGsEMqKei4NbDLwKTCA9TUbr8ZW', '103.130.18.49', 0, 1, 'HP-554144', '1439528480692764845', '2025-11-21 14:07:10'),
(3, 'Rabell', '', '140.213.4.101', 0, 1, 'HP-000001', '', 'current_timestamp()'),
(4, 'Onlynszee', '$2b$12$KkTMBUcofPYqD0h.fXOFMet1PT0D4Cq39LUgl3q0TKo6zMFADOgpG', '140.213.70.215', 0, 1, 'HP-749598', '1271079983674298473', '2025-11-26 16:45:40'),
(5, 'Abell', '', '127.0.0.1', 0, 0, 'HP-346500', '1259324008168685700', '2025-11-27 07:20:04'),
(6, 'Kamiell', '$2b$12$1AYjvvmm2hPlNB3XIirp3eI3ZIaq.1FewQh/gbcCeWIoR0F9YpBvu', '114.79.55.124', 0, 1, 'HP-486474', '1190467263598432417', '2025-11-28 10:46:50'),
(7, 'Venomm', '$2b$12$LnRA4Jq9p.bsWJ8Vyl7jUeNYTWtEZzZTnTqCnlhiMyyaPzpCBm4qy', '180.253.54.220', 0, 1, 'HP-163180', '1390525200411525220', '2025-11-28 21:33:50'),
(8, 'ciummm', '$2b$12$GjorcF7/zIPeE8BItbnxieB77u.TabZZE4sN/xghfKL2TjX2aI0dy', '140.213.175.193', 0, 1, 'HP-677604', '1438525032253882388', '2025-11-30 15:11:15'),
(9, 'Mvrick', '', '127.0.0.1', 0, 0, 'HP-428104', '1309472423271202836', '2025-11-30 16:08:09'),
(10, 'Mackenzie', '$2b$12$VdUAQRZaG/w3OxWn9qZ.AODJ0RsazlWCfqgeY8Ox/K9fj8W6xKunG', '110.139.238.40', 0, 1, 'HP-911356', '1401475724178620467', '2025-12-11 12:04:16'),
(11, 'Leon', '$2b$12$/B8QA6c5p7UdQPepM3Q3BewqHNoFu6BT7TwgH0dkdbo67t9KEd8py', '103.166.11.30', 0, 1, 'HP-947645', '1394684950950838313', '2025-12-14 04:45:33'),
(12, 'Hassanudin', '', '127.0.0.1', 0, 0, 'HP-677285', '1448681735087718522', '2025-12-15 06:32:11'),
(13, 'Rizall', '$2b$12$k9oKZLhqPnRYBP2bNrxXV.VsK5OM4rgypPHfjD/Zsf3yOlSZT4QzK', '103.131.19.37', 0, 1, 'HP-335367', '1412263975751647293', '2025-12-15 09:22:37'),
(14, 'Rizal', '', '127.0.0.1', 0, 0, 'HP-311045', '1412263975751647293', '2025-12-15 09:22:55'),
(15, 'Rossivip', '$2b$12$2k7uy32LqQWDHKGE4PPEnOjdzovYXkyqx4LR84LTqUujNL5zYEDqK', '36.83.75.216', 0, 1, 'HP-311918', '1382221780906676414', '2025-12-16 09:35:49'),
(16, 'ravizsulawesi', '$2b$12$L5Q74MPPNCXkb30PEgv4iOLEQ7rFBIPMLZ4QR1xHoC2MJzTxxtPE.', '180.252.200.95', 0, 1, 'HP-334503', '1260201231721435200', '2025-12-17 07:45:18'),
(17, 'ajegile', '$2b$12$PnyOMKxz6Bkcx/yP9gCiq.mqOkhiCxqgRsUFo8fVpkV/OZ2AyyuJS', '160.19.145.201', 0, 1, 'HP-310416', '1447092325670191224', '2025-12-17 09:04:18'),
(18, 'Kamalgc', '$2b$12$hJ5ZKryq9zuUst7jovuKc.9tFaa5p5znl53PboWHxXb..eNLnd7Rm', '103.159.195.211', 0, 1, 'HP-785739', '1312765433245470795', '2025-12-17 14:46:32'),
(19, 'JayXyus', '$2b$12$EQXedED.brUWwQDI2XnS7.LBT5l4gPscgKxJpukfZFVJkc3XLm6Cq', '114.10.95.113', 0, 1, 'HP-412102', '1253591084651647047', '2025-12-18 18:16:45'),
(20, 'yonksrumamen', '$2b$12$5gGqQ.G0f5vjEF01AS7sOebqRUXgl2jHxLzHBK.gVi5/hC2/9YRdm', '160.19.145.201', 0, 1, 'HP-989693', '1451124963351203944', '2025-12-28 20:58:42'),
(21, 'Dimzz', '$2b$12$DbAC0/YzwU5nIsVB8ZUEy.vo69xB943Tsf1XSQdI9MZspn25j9gUe', '103.210.117.83', 0, 1, 'HP-509326', '1272005479958315039', '2025-12-29 13:52:44'),
(22, 'Yuuki', '$2b$12$t8wyMVo98XgZw2ubdXrlqeqUAv3tA8O9mBIZyIpnRHMoj2S1RPoSC', '114.10.44.241', 0, 1, 'HP-210379', '1301817581706940456', '2025-12-29 21:16:21'),
(23, 'Chulopapi', '', '127.0.0.1', 0, 0, 'HP-948469', '1227674814588784660', '2025-12-31 14:14:26');

-- --------------------------------------------------------

--
-- Table structure for table `vehicle`
--

CREATE TABLE `vehicle` (
  `id` int(10) UNSIGNED NOT NULL,
  `owner` int(11) NOT NULL DEFAULT -1,
  `model` int(11) NOT NULL DEFAULT 0,
  `color1` int(11) NOT NULL DEFAULT 0,
  `color2` int(11) NOT NULL DEFAULT 0,
  `paintjob` int(11) NOT NULL DEFAULT -1,
  `neon` int(11) NOT NULL DEFAULT 0,
  `tune_engine` int(11) NOT NULL DEFAULT 0,
  `tune_handbrake` int(11) NOT NULL DEFAULT 0,
  `locked` int(11) NOT NULL DEFAULT 0,
  `insu` int(11) NOT NULL DEFAULT 1,
  `claim` int(11) NOT NULL DEFAULT 0,
  `claim_time` bigint(20) NOT NULL DEFAULT 0,
  `plate` varchar(50) NOT NULL DEFAULT 'None',
  `plate_time` bigint(20) NOT NULL DEFAULT 0,
  `ticket` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `price` int(11) NOT NULL DEFAULT 200000,
  `health` float NOT NULL DEFAULT 1000,
  `fuel` int(11) NOT NULL DEFAULT 1000,
  `x` float NOT NULL DEFAULT 0,
  `y` float NOT NULL DEFAULT 0,
  `z` float NOT NULL DEFAULT 0,
  `a` float NOT NULL DEFAULT 0,
  `int` int(11) NOT NULL DEFAULT 0,
  `vw` int(11) NOT NULL DEFAULT 0,
  `damage0` int(11) NOT NULL DEFAULT 0,
  `damage1` int(11) NOT NULL DEFAULT 0,
  `damage2` int(11) NOT NULL DEFAULT 0,
  `damage3` int(11) NOT NULL DEFAULT 0,
  `mod0` int(11) NOT NULL DEFAULT 0,
  `mod1` int(11) NOT NULL DEFAULT 0,
  `mod2` int(11) NOT NULL DEFAULT 0,
  `mod3` int(11) NOT NULL DEFAULT 0,
  `mod4` int(11) NOT NULL DEFAULT 0,
  `mod5` int(11) NOT NULL DEFAULT 0,
  `mod6` int(11) NOT NULL DEFAULT 0,
  `mod7` int(11) NOT NULL DEFAULT 0,
  `mod8` int(11) NOT NULL DEFAULT 0,
  `mod9` int(11) NOT NULL DEFAULT 0,
  `mod10` int(11) NOT NULL DEFAULT 0,
  `mod11` int(11) NOT NULL DEFAULT 0,
  `mod12` int(11) NOT NULL DEFAULT 0,
  `mod13` int(11) NOT NULL DEFAULT 0,
  `mod14` int(11) NOT NULL DEFAULT 0,
  `mod15` int(11) NOT NULL DEFAULT 0,
  `mod16` int(11) NOT NULL DEFAULT 0,
  `lumber` int(11) NOT NULL DEFAULT -1,
  `metal` int(11) NOT NULL DEFAULT 0,
  `coal` int(11) NOT NULL DEFAULT 0,
  `product` int(11) NOT NULL DEFAULT 0,
  `gasoil` int(11) NOT NULL DEFAULT 0,
  `cargocompo` int(11) NOT NULL DEFAULT 0,
  `cargomat` int(11) NOT NULL DEFAULT 0,
  `cargomilk` int(11) NOT NULL DEFAULT 0,
  `rental` bigint(20) NOT NULL DEFAULT 0,
  `park` int(11) NOT NULL DEFAULT -1,
  `locktyre0` int(11) NOT NULL DEFAULT 0,
  `locktyre1` int(11) NOT NULL DEFAULT 0,
  `locktyre2` int(11) NOT NULL DEFAULT 0,
  `locktyre3` int(11) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `vehicle`
--

INSERT INTO `vehicle` (`id`, `owner`, `model`, `color1`, `color2`, `paintjob`, `neon`, `tune_engine`, `tune_handbrake`, `locked`, `insu`, `claim`, `claim_time`, `plate`, `plate_time`, `ticket`, `price`, `health`, `fuel`, `x`, `y`, `z`, `a`, `int`, `vw`, `damage0`, `damage1`, `damage2`, `damage3`, `mod0`, `mod1`, `mod2`, `mod3`, `mod4`, `mod5`, `mod6`, `mod7`, `mod8`, `mod9`, `mod10`, `mod11`, `mod12`, `mod13`, `mod14`, `mod15`, `mod16`, `lumber`, `metal`, `coal`, `product`, `gasoil`, `cargocompo`, `cargomat`, `cargomilk`, `rental`, `park`, `locktyre0`, `locktyre1`, `locktyre2`, `locktyre3`) VALUES
(196, 22, 468, 144, 49, -1, 0, 0, 0, 0, 3, 0, 0, 'NoHave', 0, 0, 2500, 1000, 100, 1743.87, -1861.82, 13.6758, 345.699, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0),
(94, 7, 468, 47, 139, -1, 0, 0, 0, 0, 3, 0, 0, 'NoHave', 0, 0, 2500, 1000, 100, 1689.07, -2261.57, 13.6077, 32.8845, 0, 0, 2097170, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0),
(64, 18, 468, 90, 102, -1, 0, 0, 0, 0, 3, 0, 0, 'NoHave', 0, 0, 2500, 1000, 100, 1748.87, -1861.38, 13.6764, 197.156, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0),
(368, 13, 468, 148, 161, -1, 0, 0, 0, 0, 3, 0, 0, 'NoHave', 0, 0, 2500, 1000, 100, 1744.04, -1862.75, 13.9746, 331.683, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0),
(369, 10, 468, 170, 214, -1, 0, 0, 0, 0, 3, 0, 0, 'NoHave', 0, 0, 2500, 1000, 100, 1108.57, 1617.22, 12.9469, 306.28, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0),
(370, 10, 468, 170, 214, -1, 0, 0, 0, 1, 3, 0, 0, 'NoHave', 0, 0, 2500, 888.641, 87, 1040.44, -1334.81, 13.6153, 82.2377, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0),
(371, 11, 468, 158, 172, -1, 0, 0, 0, 0, 3, 0, 0, 'NoHave', 0, 0, 2500, 1000, 96, 1535.34, -1667.84, 13.3467, 4.6009, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0),
(373, 15, 468, 124, 163, -1, 0, 0, 0, 0, 3, 0, 0, 'NoHave', 0, 0, 2500, 816.939, 85, 1180.83, -1360.07, 14.1498, 100.091, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0),
(374, 13, 468, 148, 161, -1, 0, 0, 0, 0, 3, 0, 0, 'NoHave', 0, 0, 2500, 999.978, 87, 1029.24, -1344.06, 13.4931, 232.286, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0),
(375, 19, 468, 196, 217, -1, 0, 0, 0, 0, 3, 0, 0, 'NoHave', 0, 0, 2500, 1000, 100, 1677.67, -2257.08, 13.4792, 43.7317, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0),
(376, 15, 468, 124, 163, -1, 0, 0, 0, 1, 3, 0, 0, 'NoHave', 0, 0, 2500, 633.322, 70, 1676.27, -2247.23, 13.4403, 272.407, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0),
(377, 16, 468, 56, 50, -1, 0, 0, 0, 0, 3, 0, 0, 'NoHave', 0, 0, 2500, 1000, 100, 1685.54, -2260.65, 13.753, 7.01826, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0),
(378, 18, 468, 90, 102, -1, 0, 0, 0, 0, 3, 0, 0, 'NoHave', 0, 0, 2500, 1000, 100, 1748.87, -1861.38, 13.3615, 197.157, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0),
(379, 19, 468, 196, 217, -1, 0, 0, 0, 0, 3, 0, 0, 'NoHave', 0, 0, 2500, 1000, 99, 1523.33, -2291.4, 13.151, 295.287, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0),
(388, 1, 463, 46, 54, -1, 0, 0, 0, 0, 3, 0, 0, 'NoHave', 0, 0, 17000, 919.635, 92, 1288.2, -1563.01, 18.788, 246.868, 0, 0, 36700194, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0),
(366, 7, 468, 47, 139, -1, 0, 0, 0, 0, 3, 0, 0, 'NoHave', 0, 0, 2500, 917.6, 93, 500.135, -1591.78, 17.0564, 103.903, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0),
(365, 6, 560, 4, 2, -1, 0, 0, 0, 0, 3, 0, 0, 'NoHave', 0, 0, 70000, 796, 51, 1462.73, -1733.22, 13.0626, 102.112, 0, 0, 1048592, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0),
(364, 6, 468, 172, 146, -1, 0, 0, 0, 0, 3, 0, 0, 'NoHave', 0, 0, 2500, 1000, 100, 1397.64, -3.52486, 1001.54, 213.089, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0),
(363, 4, 499, 4, 9, -1, 0, 0, 0, 0, 3, 0, 0, 'NoHave', 0, 0, 8000, 998.644, 92, 1228.52, -1340.53, 15.3638, 157.512, 0, 0, 2097170, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0),
(393, 1, 499, 6, 2, -1, 0, 0, 0, 0, 3, 0, 0, 'NoHave', 0, 0, 8000, 1000, 85, 2820.85, -1540.61, 11.1149, 110.974, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0),
(360, 5, 468, 54, 80, -1, 0, 0, 0, 0, 3, 0, 0, 'NoHave', 0, 0, 2500, 1000, 95, 1647.01, -2332.26, 13.297, 104.52, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0),
(359, 5, 468, 54, 80, -1, 0, 0, 0, 0, 3, 0, 0, 'NoHave', 0, 0, 2500, 1000, 100, 1688.22, -2260.97, 13.6163, 4.61707, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0),
(358, 3, 468, 94, 49, -1, 0, 0, 0, 0, 3, 0, 0, 'NoHave', 0, 0, 2500, 995.345, 96, 1832.36, -1846.39, 13.3403, 0.511292, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0),
(357, 4, 468, 246, 234, -1, 0, 0, 0, 0, 3, 0, 0, 'NoHave', 0, 0, 2500, 984.395, 99, 1822.8, -1759, 15.2523, 179.944, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0),
(356, 3, 468, 10, 116, -1, 0, 0, 0, 0, 3, 0, 0, 'NoHave', 0, 0, 2500, 1000, 96, 1645.93, -2329.22, 13.2414, 99.7768, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0),
(380, 21, 468, 177, 55, -1, 0, 0, 0, 0, 3, 0, 0, 'NoHave', 0, 0, 2500, 942.374, 96, 1504.87, -1808.08, 13.35, 226.048, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0),
(381, 4, 562, 4, 3, -1, 0, 0, 0, 0, 3, 0, 0, 'NoHave', 0, 0, 67000, 759.858, 48, 1047.29, -1713.48, 13.1412, 81.2383, 0, 0, 2162720, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0),
(382, 1, 415, 6, 3, -1, 0, 0, 0, 0, 2, 0, 0, 'NoHave', 0, 0, 50000, 807.176, 57, -1993.48, -1577.89, 134.329, 150.829, 0, 0, 2162705, 2, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0),
(383, 22, 468, 144, 49, -1, 0, 0, 0, 0, 3, 0, 0, 'NoHave', 0, 0, 2500, 854.548, 91, 385.118, -2087.62, 7.60426, 272.77, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0),
(384, 23, 468, 103, 143, -1, 0, 0, 0, 0, 3, 0, 0, 'NoHave', 0, 0, 2500, 1511.23, 70, 1253.9, -806.634, 83.9059, 355.126, 0, 0, 2162720, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0),
(385, 24, 0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 0, 'None', 0, 0, 200000, 1000, 1000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0),
(387, 29, 468, 169, 217, -1, 0, 0, 0, 0, 3, 0, 0, 'NoHave', 0, 0, 2500, 1000, 100, 1748.66, -1861, 13.6768, 219.279, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0),
(390, 34, 468, 51, 27, -1, 0, 0, 0, 0, 3, 0, 0, 'NoHave', 0, 0, 2500, 1000, 100, 1688.75, -2261.25, 13.2831, 189.342, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0),
(391, 36, 468, 181, 1, -1, 0, 0, 0, 0, 3, 0, 0, 'NoHave', 0, 0, 2500, 1000, 100, 1685.08, -2258.63, 13.4334, 208.461, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0),
(392, 37, 468, 216, 12, -1, 0, 0, 0, 0, 3, 0, 0, 'NoHave', 0, 0, 2500, 888.194, 86, 1186.27, -1580.07, 13.3163, 103.702, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `vehiclestorage`
--

CREATE TABLE `vehiclestorage` (
  `id` int(11) NOT NULL,
  `owner` int(11) NOT NULL DEFAULT 0,
  `item` varchar(32) NOT NULL DEFAULT 'fann_item',
  `quantity` int(11) NOT NULL DEFAULT 0,
  `weapon` int(11) NOT NULL DEFAULT -1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `vehicle_keys`
--

CREATE TABLE `vehicle_keys` (
  `id` int(11) NOT NULL,
  `owner` int(11) NOT NULL DEFAULT -1,
  `vehicle` int(11) NOT NULL DEFAULT -1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `vehicle_object`
--

CREATE TABLE `vehicle_object` (
  `id` int(11) NOT NULL,
  `vehicle` int(11) NOT NULL DEFAULT 0,
  `type` int(11) NOT NULL DEFAULT 0,
  `model` int(11) NOT NULL DEFAULT 0,
  `fontcolor` int(11) NOT NULL DEFAULT 0,
  `fontsize` int(11) NOT NULL DEFAULT 0,
  `toggle` int(11) NOT NULL DEFAULT 0,
  `x` float NOT NULL DEFAULT 0,
  `y` float NOT NULL DEFAULT 0,
  `z` float NOT NULL DEFAULT 0,
  `rx` float NOT NULL DEFAULT 0,
  `ry` float NOT NULL DEFAULT 0,
  `rz` float NOT NULL DEFAULT 0,
  `color` varchar(25) NOT NULL DEFAULT '0|0|0|0|0',
  `text` varchar(128) NOT NULL DEFAULT 'Fann',
  `font` varchar(32) NOT NULL DEFAULT 'gta_fann'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `vehicle_object`
--

INSERT INTO `vehicle_object` (`id`, `vehicle`, `type`, `model`, `fontcolor`, `fontsize`, `toggle`, `x`, `y`, `z`, `rx`, `ry`, `rz`, `color`, `text`, `font`) VALUES
(1, 94, 2, 18659, 0, 45, 0, 1, 0, 0, 0, 0, -358, '1|1|1|1|1', 'Fann', 'Arial'),
(3, 362, 1, 1155, 0, 0, 0, -1.08105, 1.84692, 0.060001, -3, 0, 1.5, '2|2|2|2|2', '', ''),
(5, 363, 1, 1155, 0, 45, 0, -1.03308, 1.83459, -0.382862, 0, 0, 0, '6|1|1|1|1', 'Fann', 'Arial'),
(8, 365, 1, 1003, 0, 0, 0, 0, -2.33008, 0.580007, 0, 0, 0, '4|1|1|1|1', '', ''),
(12, 64, 1, 19620, 0, 0, 0, 0.003622, -0.300271, 0.899963, 0, 0, 0, '1|1|1|1|1', '', ''),
(13, 64, 2, 18659, 1, 40, 0, 0, -1.59155, 1.04996, 0, -89.9998, -0.000029, '1|1|1|1|1', 'Text Here', 'Arial'),
(15, 367, 2, 18659, 1, 60, 0, -0.240207, 0.00347, 0, 0, 0, -359.999, '1|1|1|1|1', 'Fann4K', 'Arial'),
(16, 64, 1, 1003, 0, 0, 0, -0.008252, -3.0483, 0.284987, 0, 0, 0.000257, '1|1|1|1|1', '', ''),
(17, 361, 2, 18659, 1, 40, 0, 0, 0, 0, 0, 0, 0, '1|1|1|1|1', 'Text Here', 'Arial'),
(24, 389, 1, 1001, 0, 0, 0, -0.095187, -1.96467, 0.734992, 0, 0, -360, '1|1|1|1|1', '', ''),
(25, 389, 1, 19620, 0, 0, 0, 0, 0, 0.83999, 0, 0, -360, '1|1|1|1|1', '', ''),
(26, 382, 1, 1000, 0, 0, 0, -0.037011, -2.19183, 0.239996, 0, 0, -360, '6|6|6|6|6', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `vouchers`
--

CREATE TABLE `vouchers` (
  `id` int(11) NOT NULL,
  `code` varchar(32) NOT NULL DEFAULT 'FannCode',
  `vip` int(11) NOT NULL DEFAULT 0,
  `vip_time` int(11) NOT NULL DEFAULT 0,
  `gold` int(11) NOT NULL DEFAULT 0,
  `admin` varchar(16) NOT NULL DEFAULT 'None',
  `expired` int(11) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `weaponsettings`
--

CREATE TABLE `weaponsettings` (
  `Owner` int(11) NOT NULL,
  `WeaponID` tinyint(4) NOT NULL,
  `PosX` float DEFAULT -0.116,
  `PosY` float DEFAULT 0.189,
  `PosZ` float DEFAULT 0.088,
  `RotX` float DEFAULT 0,
  `RotY` float DEFAULT 44.5,
  `RotZ` float DEFAULT 0,
  `Bone` tinyint(4) NOT NULL DEFAULT 1,
  `Hidden` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `weaponsettings`
--

INSERT INTO `weaponsettings` (`Owner`, `WeaponID`, `PosX`, `PosY`, `PosZ`, `RotX`, `RotY`, `RotZ`, `Bone`, `Hidden`) VALUES
(1, 27, -0.236, -0.171, 0.163, -1.5, 52, 4.5, 1, 0),
(1, 30, 0.034, -0.006, 0.043, 13.5, -11, 9, 6, 0),
(1, 23, 0.034, -0.036, 0.103, -88.5, 5.5, -4.5, 8, 0),
(1, 26, -0.146, -0.156, 0.148, 0, 44.5, 0, 1, 0),
(1, 25, -0.176, -0.126, 0.133, 0, 44.5, 0, 1, 0),
(1, 24, -0.101, 0.054, 0.088, -78, 44.5, 0, 8, 0),
(1, 32, -0.116, -0.156, 0.088, 0, 44.5, 0, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `workshop`
--

CREATE TABLE `workshop` (
  `id` int(11) NOT NULL,
  `owner` varchar(25) NOT NULL DEFAULT '-',
  `ownerid` int(11) NOT NULL DEFAULT 0,
  `posx` float NOT NULL DEFAULT 0,
  `posy` float NOT NULL DEFAULT 0,
  `posz` float NOT NULL DEFAULT 0,
  `component` int(11) NOT NULL DEFAULT 0,
  `material` int(11) NOT NULL DEFAULT 0,
  `money` int(11) NOT NULL DEFAULT 0,
  `name` varchar(26) NOT NULL DEFAULT '-',
  `status` int(11) NOT NULL DEFAULT 0,
  `price` int(11) NOT NULL DEFAULT 0,
  `employe0` varchar(25) NOT NULL DEFAULT '-',
  `employe1` varchar(25) NOT NULL DEFAULT '-',
  `employe2` varchar(25) NOT NULL DEFAULT '-'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `workshop`
--

INSERT INTO `workshop` (`id`, `owner`, `ownerid`, `posx`, `posy`, `posz`, `component`, `material`, `money`, `name`, `status`, `price`, `employe0`, `employe1`, `employe2`) VALUES
(0, '', 0, 308.11, -252.908, 1.6035, 4530, 0, 0, '-', 0, 50000, 'Ronald_Charistopher', 'Jethro_Benigno', '-'),
(1, '', 0, -83.7857, -1208.91, 2.74471, 9500, 0, 0, '-', 0, 150000, '-', '-', '-'),
(2, '', 0, 282.343, -1199.92, 80.5324, 6500, 0, 0, '-', 1, 0, '-', '-', '-'),
(3, '', 0, 1015.99, -1859.69, 13.599, 1, 0, 0, '-', 0, 500000, '-', '-', '-');

-- --------------------------------------------------------

--
-- Table structure for table `zone`
--

CREATE TABLE `zone` (
  `id` int(11) NOT NULL,
  `name` varchar(32) NOT NULL DEFAULT '-',
  `type` int(11) NOT NULL DEFAULT 0,
  `min_x` float NOT NULL,
  `min_y` float NOT NULL,
  `max_x` float NOT NULL,
  `max_y` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `zone`
--

INSERT INTO `zone` (`id`, `name`, `type`, `min_x`, `min_y`, `max_x`, `max_y`) VALUES
(1, 'Town Hall', 1, 1376.85, -1879.78, 1646.8, -1584.67),
(2, 'Complex #1', 2, 1954.4, -1799.4, 1813.6, -1601.31),
(3, 'Unity Station', 2, 1829.76, -1825.31, 1687.01, -2005.91);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `actors`
--
ALTER TABLE `actors`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `atms`
--
ALTER TABLE `atms`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bisnis`
--
ALTER TABLE `bisnis`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `blacklist`
--
ALTER TABLE `blacklist`
  ADD PRIMARY KEY (`player`);

--
-- Indexes for table `boxes`
--
ALTER TABLE `boxes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `contact`
--
ALTER TABLE `contact`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `dealership`
--
ALTER TABLE `dealership`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `doors`
--
ALTER TABLE `doors`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `dropped_items`
--
ALTER TABLE `dropped_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `dropped_weapons`
--
ALTER TABLE `dropped_weapons`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `fire`
--
ALTER TABLE `fire`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `garbage`
--
ALTER TABLE `garbage`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `gates`
--
ALTER TABLE `gates`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `graffiti`
--
ALTER TABLE `graffiti`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `gstations`
--
ALTER TABLE `gstations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `houses`
--
ALTER TABLE `houses`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `inventory`
--
ALTER TABLE `inventory`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `lockers`
--
ALTER TABLE `lockers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `loglogin`
--
ALTER TABLE `loglogin`
  ADD PRIMARY KEY (`no`);

--
-- Indexes for table `modshop`
--
ALTER TABLE `modshop`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ores`
--
ALTER TABLE `ores`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `parks`
--
ALTER TABLE `parks`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `plants`
--
ALTER TABLE `plants`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `players`
--
ALTER TABLE `players`
  ADD PRIMARY KEY (`reg_id`);

--
-- Indexes for table `player_fish`
--
ALTER TABLE `player_fish`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `player_skill`
--
ALTER TABLE `player_skill`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `playlist`
--
ALTER TABLE `playlist`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `requestcs`
--
ALTER TABLE `requestcs`
  ADD PRIMARY KEY (`name`);

--
-- Indexes for table `salary`
--
ALTER TABLE `salary`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `server`
--
ALTER TABLE `server`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `toys`
--
ALTER TABLE `toys`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `trees`
--
ALTER TABLE `trees`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ucp`
--
ALTER TABLE `ucp`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Username` (`username`);

--
-- Indexes for table `vehicle`
--
ALTER TABLE `vehicle`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `vehiclestorage`
--
ALTER TABLE `vehiclestorage`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `vehicle_keys`
--
ALTER TABLE `vehicle_keys`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `vehicle_object`
--
ALTER TABLE `vehicle_object`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `vouchers`
--
ALTER TABLE `vouchers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `weaponsettings`
--
ALTER TABLE `weaponsettings`
  ADD PRIMARY KEY (`Owner`,`WeaponID`),
  ADD UNIQUE KEY `Owner` (`Owner`,`WeaponID`);

--
-- Indexes for table `workshop`
--
ALTER TABLE `workshop`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `zone`
--
ALTER TABLE `zone`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `actors`
--
ALTER TABLE `actors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `boxes`
--
ALTER TABLE `boxes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `contact`
--
ALTER TABLE `contact`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `dealership`
--
ALTER TABLE `dealership`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `dropped_items`
--
ALTER TABLE `dropped_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dropped_weapons`
--
ALTER TABLE `dropped_weapons`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `fire`
--
ALTER TABLE `fire`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `garbage`
--
ALTER TABLE `garbage`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `graffiti`
--
ALTER TABLE `graffiti`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `houses`
--
ALTER TABLE `houses`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=304;

--
-- AUTO_INCREMENT for table `inventory`
--
ALTER TABLE `inventory`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=622;

--
-- AUTO_INCREMENT for table `loglogin`
--
ALTER TABLE `loglogin`
  MODIFY `no` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `modshop`
--
ALTER TABLE `modshop`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `parks`
--
ALTER TABLE `parks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `players`
--
ALTER TABLE `players`
  MODIFY `reg_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `player_fish`
--
ALTER TABLE `player_fish`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `player_skill`
--
ALTER TABLE `player_skill`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=121;

--
-- AUTO_INCREMENT for table `playlist`
--
ALTER TABLE `playlist`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `salary`
--
ALTER TABLE `salary`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `toys`
--
ALTER TABLE `toys`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `ucp`
--
ALTER TABLE `ucp`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `vehicle`
--
ALTER TABLE `vehicle`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=394;

--
-- AUTO_INCREMENT for table `vehiclestorage`
--
ALTER TABLE `vehiclestorage`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `vehicle_keys`
--
ALTER TABLE `vehicle_keys`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `vehicle_object`
--
ALTER TABLE `vehicle_object`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `zone`
--
ALTER TABLE `zone`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
