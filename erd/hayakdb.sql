-- SQLBook: Code
-- Active: 1731565594709@@127.0.0.1@3306@hayak_db
CREATE TABLE `users` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(100),
  `email` VARCHAR(100) UNIQUE,
  `profile_photo` text,
  `phone_number` VARCHAR(100),
  `password_hash` VARCHAR(100),
  `provider` ENUM('local','google') DEFAULT 'local',
  `created_at` TIMESTAMP,
  `updated_at` TIMESTAMP
);

CREATE TABLE `tokens` (
  `token_id` INT PRIMARY KEY,
  `token` VARCHAR(100),
  `created_at` TIMESTAMP,
  `expires_at` TIMESTAMP
);

CREATE TABLE `preferences` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `user_id` INT,
  `voice_detection` BOOLEAN DEFAULT false,
  `dark_mode` BOOLEAN DEFAULT false,
  `location_tracking` BOOLEAN DEFAULT false,
  `created_at` TIMESTAMP,
  `updated_at` TIMESTAMP
);

CREATE TABLE `maps` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `location_name` varchar(255),
  `latitude` double,
  `longitude` double,
  `created_at` timestamp
);

CREATE TABLE `contacts` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `user_id` int,
  `contact_name` varchar(255),
  `contact_phone` varchar(255),
  `contact_email` varchar(255),
  `message` varchar(100),
  `notify` boolean DEFAULT true,
  `created_at` timestamp
);

CREATE TABLE `reports` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `user_id` int,
  `location_id` int,
  `report_description` text,
  `evidence_url` varchar(255),
  `verified` boolean DEFAULT false,
  `created_at` timestamp
);

CREATE TABLE `notifications` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `user_id` int,
  `contact_id` int,
  `emergency_id` int,
  `sent_at` timestamp,
  `email_status` ENUM('sent','pending','failed') DEFAULT 'pending'
);

CREATE TABLE `emergencies` (
  `emergency_id` INT PRIMARY KEY,
  `user_id` INT,
  `location_id` INT,
  `emergency_status` ENUM('ongoing','resolved') DEFAULT 'ongoing',
  `created_at` TIMESTAMP,
  `updated_at` TIMESTAMP
);

CREATE TABLE `posts` (
  `post_id` INT PRIMARY KEY AUTO_INCREMENT,
  `user_id` INT,
  `title` VARCHAR(100),
  `content` TEXT,
  `category` ENUM('general','alert','information'),
  `created_at` TIMESTAMP,
  `updated_at` timestamp,
  `location_id` INT
);

CREATE TABLE `comments` (
  `comment_id` INT PRIMARY KEY AUTO_INCREMENT,
  `post_id` INT,
  `report_id` INT,
  `user_id` INT,
  `content` TEXT,
  `created_at` TIMESTAMP
);

ALTER TABLE `preferences` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `contacts` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `reports` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `reports` ADD FOREIGN KEY (`location_id`) REFERENCES `maps` (`id`);

ALTER TABLE `notifications` ADD FOREIGN KEY (`emergency_id`) REFERENCES `emergencies` (`emergency_id`);

ALTER TABLE `emergencies` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `emergencies` ADD FOREIGN KEY (`location_id`) REFERENCES `maps` (`id`);

ALTER TABLE `posts` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `posts` ADD FOREIGN KEY (`location_id`) REFERENCES `maps` (`id`);

ALTER TABLE `comments` ADD FOREIGN KEY (`post_id`) REFERENCES `posts` (`post_id`);

ALTER TABLE `comments` ADD FOREIGN KEY (`report_id`) REFERENCES `reports` (`id`);

ALTER TABLE `comments` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `notifications` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `notifications` ADD FOREIGN KEY (`contact_id`) REFERENCES `contacts` (`id`);

ALTER TABLE `posts` ADD FOREIGN KEY (`post_id`) REFERENCES `posts` (`user_id`);
