DROP DATABASE IF EXISTS `sql_bookingCare`;
CREATE DATABASE `sql_bookingCare`;
USE `sql_bookingCare`;


CREATE TABLE `code_role` (
  `role_id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `valueEn` varchar(50) NOT NULL,
  `valueVn` varchar(50) NOT NULL
) ENGINE=InnoDB;
INSERT INTO `code_role` VALUES (1, 'Admin', 'Quản trị viên');
INSERT INTO `code_role` VALUES (2, 'Patient', 'Bệnh nhân');
INSERT INTO `code_role` VALUES (3, 'Doctor', 'Bác sĩ');
INSERT INTO `code_role` VALUES (4, 'Master', 'Thạc sĩ');
INSERT INTO `code_role` VALUES (5, 'PhD', 'Tiến sĩ');
INSERT INTO `code_role` VALUES (6, 'Associate Professor', 'Phó Giáo sư');
INSERT INTO `code_role` VALUES (7, 'Professor', 'Giáo sư');


CREATE TABLE `code_status` (
  `status_id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `valueEn` varchar(50) NOT NULL,
  `valueVn` varchar(50) NOT NULL
) ENGINE=InnoDB;
INSERT INTO `code_status` VALUES (1, 'New', 'Lịch hẹn mới');
INSERT INTO `code_status` VALUES (2, 'Confirmed', 'Đã xác nhận');
INSERT INTO `code_status` VALUES (3, 'Done', 'Đã khám xong');
INSERT INTO `code_status` VALUES (4, 'Cancelled', 'Đã hủy');


CREATE TABLE `code_timeslot` (
  `timeslot_id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `valueEn` varchar(50) NOT NULL,
  `valueVn` varchar(50) NOT NULL
) ENGINE=InnoDB;
INSERT INTO `code_timeslot` VALUES (1, '8:00 - 9:00 AM',   '8:00 - 9:00');
INSERT INTO `code_timeslot` VALUES (2, '9:00 - 10:00 AM',  '9:00 - 10:00');
INSERT INTO `code_timeslot` VALUES (3, '10:00 - 11:00 AM', '10:00 - 11:00');
INSERT INTO `code_timeslot` VALUES (4, '11:00 - 12:00 AM', '11:00 - 12:00');
INSERT INTO `code_timeslot` VALUES (5, '13:00 - 14:00 PM', '13:00 - 14:00');
INSERT INTO `code_timeslot` VALUES (6, '14:00 - 15:00 PM', '14:00 - 15:00');
INSERT INTO `code_timeslot` VALUES (7, '15:00 - 16:00 PM', '15:00 - 16:00');
INSERT INTO `code_timeslot` VALUES (8, '16:00 - 17:00 PM', '16:00 - 17:00');


CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `email` varchar(255) NOT NULL UNIQUE,
  `password` varchar(255) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `role_id` int NOT NULL,
  `phone` varchar(50) NOT NULL,
  `address` varchar(255),
  `gender` boolean,
  `image` varchar(255),
   FOREIGN KEY `fk_users_code_role` (`role_id`) REFERENCES `code_role` (`role_id`) ON UPDATE CASCADE
) ENGINE=InnoDB;
INSERT INTO `users` VALUES (1, 'tatut90@gmail.com', '123', 'Tuấn','Trần', 1, '0902878570','9 Đài Liệt Sĩ', false, NULL);
INSERT INTO `users` VALUES (2, 'thmngoc2204@gmail.com', '123', 'Ngọc','Trần', 2, '090','10 Đài Liệt Sĩ', true, NULL);
INSERT INTO `users` VALUES (3, 'icyherovt@gmail.com', '123', 'Ly','Huỳnh', 3, '090545','11 Đài Liệt Sĩ', true, NULL);


CREATE TABLE `schedules` (
  `schedule_id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `currentNumber` int NOT NULL,
  `maxNumber` int NOT NULL,
  `doctor_id` int NOT NULL,
  `date` date,
  `timeType` varchar(255),
   FOREIGN KEY `fk_schedules_users` (`doctor_id`) REFERENCES `users` (`user_id`) ON UPDATE CASCADE
) ENGINE=InnoDB;
-- INSERT INTO `schedules` VALUES (1, '', '', '', '');


CREATE TABLE `bookings` (
  `booking_id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `status_id` int NOT NULL,
  `doctor_id` int NOT NULL,
  `patient_id` int NOT NULL,
  `date` date,
  `timeType` varchar(255),
   FOREIGN KEY `fk_bookings_code_status` (`status_id`) REFERENCES `code_status` (`status_id`) ON UPDATE CASCADE
) ENGINE=InnoDB;
-- INSERT INTO `bookings` VALUES (1, '', '', '', '');


CREATE TABLE `histories` (
  `history_id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `doctor_id` int NOT NULL,
  `patient_id` int NOT NULL,
  `description` text,
  `files` text
) ENGINE=InnoDB;
-- INSERT INTO `histories` VALUES (1, '', '', '', '');


CREATE TABLE `clinics` (
  `clinic_id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `name` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `description` text,
  `image` varchar(255)
) ENGINE=InnoDB;
-- INSERT INTO `clinics` VALUES (1, '', '', '', '');


CREATE TABLE `specialties` (
  `specialty_id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `name` varchar(255) NOT NULL,
  `description` text,
  `image` varchar(255)
) ENGINE=InnoDB;
-- INSERT INTO `specialties` VALUES (1, '', '', '', '');


CREATE TABLE `doctor_clinic_specialty` (
  `dcs_id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `doctor_id` int NOT NULL,
  `clinic_id` int NOT NULL,
  `specialty_id` int NOT NULL,
   FOREIGN KEY `fk_dcs_users` (`doctor_id`) REFERENCES `users` (`user_id`) ON UPDATE CASCADE,
   FOREIGN KEY `fk_dcs_clinics` (`clinic_id`) REFERENCES `clinics` (`clinic_id`) ON UPDATE CASCADE,
   FOREIGN KEY `fk_dcs_specialties` (`specialty_id`) REFERENCES `specialties` (`specialty_id`) ON UPDATE CASCADE
) ENGINE=InnoDB;
-- INSERT INTO `doctor_clinic_specialty` VALUES (1, '', '', '', '');

