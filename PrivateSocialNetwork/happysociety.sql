-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 16, 2019 at 12:34 PM
-- Server version: 10.1.28-MariaDB
-- PHP Version: 7.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `happysociety`
--

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `id` int(4) NOT NULL,
  `post_id` varchar(10) NOT NULL,
  `user_id` varchar(10) NOT NULL,
  `comment` varchar(200) NOT NULL,
  `datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`id`, `post_id`, `user_id`, `comment`, `datetime`) VALUES
(2, '11', '6', 'fuck', '2019-03-16 11:05:52'),
(3, '11', '7', 'bad', '2019-03-16 11:06:48'),
(4, '18', '1', 'bad', '2019-03-16 11:32:38'),
(5, '18', '1', 'bad', '2019-03-16 11:32:42');

-- --------------------------------------------------------

--
-- Table structure for table `follows`
--

CREATE TABLE `follows` (
  `id` int(3) NOT NULL,
  `user_id` varchar(11) NOT NULL,
  `follow_id` varchar(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `follows`
--

INSERT INTO `follows` (`id`, `user_id`, `follow_id`) VALUES
(1, '1', '4'),
(2, '4', '1'),
(3, '1', '2'),
(4, '2', '1'),
(5, '2', '4'),
(6, '7', '6'),
(7, '6', '7');

-- --------------------------------------------------------

--
-- Table structure for table `likes`
--

CREATE TABLE `likes` (
  `post_id` varchar(20) NOT NULL,
  `user_id` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `likes`
--

INSERT INTO `likes` (`post_id`, `user_id`) VALUES
('11', '6'),
('11', '7');

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `id` int(11) NOT NULL,
  `user_id` varchar(11) NOT NULL,
  `buddy_id` varchar(11) NOT NULL,
  `datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `content` varchar(111) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `messages`
--

INSERT INTO `messages` (`id`, `user_id`, `buddy_id`, `datetime`, `content`) VALUES
(1, '4', '1', '2019-03-14 18:19:18', 'hey buddy'),
(2, '1', '4', '2019-03-14 18:20:48', 'hello'),
(3, '1', '4', '2019-03-14 18:21:02', 'how ya doing'),
(4, '1', '4', '2019-03-16 09:14:55', 'hello');

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `recipient_id` varchar(11) NOT NULL,
  `sender_id` varchar(11) NOT NULL,
  `type` varchar(11) NOT NULL,
  `datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `recipient_id`, `sender_id`, `type`, `datetime`, `status`) VALUES
(1, '4', '1', 'request', '2019-03-14 20:39:09', 3),
(2, '4', '1', 'request', '2019-03-16 10:24:15', 1),
(3, '4', '1', 'request', '2019-03-16 10:43:44', 1),
(4, '1', '4', 'request', '2019-03-16 10:54:11', 1),
(5, '6', '7', 'request', '2019-03-16 11:03:54', 1);

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `id` int(4) NOT NULL,
  `user_id` varchar(11) NOT NULL,
  `content` varchar(1000) NOT NULL,
  `image` varchar(200) NOT NULL,
  `datetime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `negCount` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`id`, `user_id`, `content`, `image`, `datetime`, `negCount`) VALUES
(2, '4', 'The first rule of Fight Club is: You do not talk about Fight Club.', '', '2019-03-14 23:13:54', 0),
(10, '1', 'Good Morning.All the best', '', '2019-03-16 16:23:48', 0),
(11, '6', 'friendship', '', '2019-03-16 16:30:20', 0),
(18, '1', 'bad', '', '2019-03-16 17:02:32', 0);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(20) NOT NULL,
  `full_name` varchar(22) NOT NULL,
  `gender` varchar(11) NOT NULL,
  `state` varchar(22) NOT NULL,
  `city` varchar(22) NOT NULL,
  `street` varchar(22) NOT NULL,
  `pincode` varchar(11) NOT NULL,
  `birth_year` varchar(11) NOT NULL,
  `profile_pic` varchar(50) NOT NULL DEFAULT 'avatar.png',
  `email` varchar(33) NOT NULL,
  `password` varchar(22) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `full_name`, `gender`, `state`, `city`, `street`, `pincode`, `birth_year`, `profile_pic`, `email`, `password`) VALUES
(1, 'Atchuth Ajaykumar P', 'Male', 'Kerala', 'Thrissur', 'Kodungallur', '680665', '1994', '4.jpg', 'achuthajaykumar@gmail.com', 'imaSSNb0y'),
(2, 'anjana', 'Female', 'IN', 'tri', 'town', '680602', '1997', 'avatar.png	', 'anjanavb4@gmail.com', 'asd1234A'),
(3, 'Jackichand', 'Male', 'Jharkhand', 'Raipur', 'Shepherd', '123456', '1992', 'avatar.png	', 'jackychand@gmail.com', 'jack1Echand'),
(4, 'Tyler Durden', 'Male', 'Kerala', 'Thrissur', 'K-Town', '680664', '1997', '4 (1).jpg', 'fightclub@gmail.com', 'n0FightClub'),
(6, 'rosemol', 'Female', 'Kerala', 'Thrissur', 'Trissur', '680006', '1997', '4 (1).jpg', 'rosemolantony16@gmail.com', 'Rosemol16'),
(7, 'maymol', 'Female', 'Kerala', 'Thrissur', 'Trissur', '680006', '1998', 'avatar.png', 'maymolpaulson@gmail.com', 'Maymol14');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `follows`
--
ALTER TABLE `follows`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `follows`
--
ALTER TABLE `follows`
  MODIFY `id` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `id` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
