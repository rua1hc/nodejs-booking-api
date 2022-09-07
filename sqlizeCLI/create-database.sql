DROP DATABASE IF EXISTS `sql_bookingCare`;
CREATE DATABASE `sql_bookingCare`;
USE `sql_bookingCare`;


CREATE TABLE `all_codes` (
  `code_id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `key` varchar(50) NOT NULL UNIQUE,
  `type` varchar(50) NOT NULL,
  `valueEn` varchar(50) NOT NULL,
  `valueVn` varchar(50) NOT NULL
) ENGINE=InnoDB;
-- INSERT INTO `all_codes` VALUES (1, 'R1', 'ROLE', 'Admin', 'Quản trị viên');
-- INSERT INTO `all_codes` VALUES (2, 'R2', 'ROLE', 'Doctor', 'Bác sĩ');
-- INSERT INTO `all_codes` VALUES (3, 'R3', 'ROLE', 'Patient', 'Bệnh nhân');
-- INSERT INTO `all_codes` VALUES (4, 'S1', 'STATUS', 'New', '');
-- INSERT INTO `all_codes` VALUES (5, 'S2', 'STATUS', 'Confirmed', '');
-- INSERT INTO `all_codes` VALUES (6, 'S3', 'STATUS', 'Done', '');
-- INSERT INTO `all_codes` VALUES (7, 'S4', 'STATUS', 'Cancelled', '');
-- INSERT INTO `all_codes` VALUES (8, 'T1', 'TIME', '8:00 - 9:00', '');


CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `email` varchar(255) NOT NULL UNIQUE,
  `password` varchar(255) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `address` varchar(255),
  `gender` boolean,
  `role_id` int NOT NULL,
   FOREIGN KEY `fk_users_all_codes` (`role_id`) REFERENCES `all_codes` (`code_id`) ON UPDATE CASCADE
) ENGINE=InnoDB;
-- INSERT INTO `users` VALUES (1, 'tatut90@gmail.com', 'Tuấn','Trần', '99 Đài Liệt Sĩ', false, 1);
-- INSERT INTO `users` VALUES (2, 'icyherovt@gmail.com', 'Ly','Huỳnh', '100 Đài Liệt Sĩ', true, 2);
-- INSERT INTO `users` VALUES (3, 'thmngoc2204@gmail.com', 'Ngọc','Trần', '101 Đài Liệt Sĩ', true, 3);


CREATE TABLE `schedules` (
  `schedule_id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `currentNumber` int NOT NULL,
  `maxNumber` int NOT NULL,
  `date` date,
  `timeType` varchar(255),
  `doctor_id` int NOT NULL
) ENGINE=InnoDB;
-- INSERT INTO `schedules` VALUES (1, '', '', '', '');


CREATE TABLE `bookings` (
  `booking_id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `status_id` int NOT NULL,
  `doctor_id` int NOT NULL,
  `patient_id` int NOT NULL,
  `date` date,
  `timeType` varchar(255),
   FOREIGN KEY `fk_bookings_all_codes` (`status_id`) REFERENCES `all_codes` (`code_id`) ON UPDATE CASCADE
) ENGINE=InnoDB;
-- INSERT INTO `bookings` VALUES (1, '', '', '', '');


CREATE TABLE `histories` (
  `history_id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `doctor_id` int NOT NULL,
  `patient_id` int NOT NULL,
  `description` text
) ENGINE=InnoDB;
-- INSERT INTO `histories` VALUES (1, '', '', '', '');


CREATE TABLE `clinics` (
  `clinic_id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `address` varchar(255) NOT NULL,
  `description` text,
  `image` varchar(255)
) ENGINE=InnoDB;
-- INSERT INTO `clinics` VALUES (1, '', '', '', '');


CREATE TABLE `specialties` (
  `specialty_id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `description` text,
  `image` varchar(255)
) ENGINE=InnoDB;
-- INSERT INTO `specialties` VALUES (1, '', '', '', '');


CREATE TABLE `doctor_clinic_specialty` (
  `dcs_id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `doctor_id` int NOT NULL,
  `clinic_id` int NOT NULL,
  `specialty_id` int NOT NULL,
   FOREIGN KEY `fk_dcs_clinics` (`clinic_id`) REFERENCES `clinics` (`clinic_id`) ON UPDATE CASCADE,
   FOREIGN KEY `fk_dcs_specialties` (`specialty_id`) REFERENCES `specialties` (`specialty_id`) ON UPDATE CASCADE
) ENGINE=InnoDB;
-- INSERT INTO `doctor_clinic_specialty` VALUES (1, '', '', '', '');

