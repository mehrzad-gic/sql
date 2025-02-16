-- Create users table
CREATE TABLE IF NOT EXISTS `users` (
    `id` BIGINT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `name` VARCHAR(255) DEFAULT '',
    `email` VARCHAR(255) UNIQUE,
    `slug` VARCHAR(255) UNIQUE,
    `password` VARCHAR(255),
    `status` TINYINT(1) DEFAULT 1, 
    `followers_count` BIGINT DEFAULT 0,
    `followings_count` BIGINT DEFAULT 0,
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `deleted_at` DATETIME DEFAULT NULL
);


-- Create profiles table
CREATE TABLE IF NOT EXISTS `profiles` (
    `id` BIGINT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `img` TEXT DEFAULT NULL,
    `website` VARCHAR(255) DEFAULT NULL,
    `user_id` BIGINT,
    FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
);


-- Seller Table
CREATE TABLE IF NOT EXISTS `sellers`(
    `name` VARCHAR(255) NOT NULL,
    `des` VARCHAR(255) NOT NULL,
    `img` TEXT NULL,
    `slug` VARCHAR(255) UNIQUE,
    `status` TINYINT(1) DEFAULT 1, 
    `user_id` INT DEFAULT NULL,
    `likes` BIGINT DEFAULT 0,
    `dislikes` BIGINT DEFAULT 0,
    `products_count` BIGINT DEFAULT 0,
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `deleted_at` DATETIME DEFAULT NULL,
    FOREIGN KEY `user_id` REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE
);


-- Create follows table
CREATE TABLE IF NOT EXISTS `follows` (
    `id` BIGINT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `user_id` BIGINT NOT NULL,
    `follower_id` BIGINT NOT NULL,
    FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`follower_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `deleted_at` DATETIME DEFAULT NULL
);


-- Create tags table
CREATE TABLE IF NOT EXISTS `tags` (
    `id` BIGINT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL,
    `slug` VARCHAR(255) UNIQUE,
    `status` TINYINT(1) DEFAULT 1, 
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `deleted_at` DATETIME DEFAULT NULL
);


-- Create posts table
CREATE TABLE IF NOT EXISTS `posts` (
    `id` BIGINT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL,
    `slug` VARCHAR(255) UNIQUE,
    `status` TINYINT(1) DEFAULT 1, 
    `img` TEXT DEFAULT NULL,
    `des` TEXT DEFAULT NULL,
    `likes_count` BIGINT DEFAULT 0,
    `dis_likes_count` BIGINT DEFAULT 0,
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `deleted_at` DATETIME DEFAULT NULL
);


-- Create likes table for storing likes and dislikes across the application
CREATE TABLE IF NOT EXISTS `likes` (
    `id` BIGINT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `value` INT NOT NULL,
    `likeable_type` VARCHAR(255) NOT NULL,
    `likeable_id` BIGINT NOT NULL,
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `deleted_at` DATETIME DEFAULT NULL
);


-- Pivot table for tags and posts (many-to-many relationship)
CREATE TABLE IF NOT EXISTS `tag_posts` (
    `id` BIGINT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `tag_id` BIGINT NOT NULL,
    `post_id` BIGINT NOT NULL,
    FOREIGN KEY (`tag_id`) REFERENCES `tags`(`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`post_id`) REFERENCES `posts`(`id`) ON DELETE CASCADE ON UPDATE CASCADE
);


-- Comment table to store comments on various entities (posts, products, etc.)
CREATE TABLE IF NOT EXISTS `comments` (
    `id` BIGINT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `text` TEXT NOT NULL,
    `status` TINYINT(1) DEFAULT 0, 
    `user_id` BIGINT NOT NULL,
    `parent_id` BIGINT DEFAULT 0,
    `commentable_id` BIGINT NOT NULL,
    `commentable_type` VARCHAR(255) NOT NULL,  -- Changed to VARCHAR
    FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `deleted_at` DATETIME DEFAULT NULL
);


-- Categories Table
CREATE TABLE IF NOT EXISTS `categories`(
    `id` PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `slug` VARCHAR(255) UNIQUE,
    `status` TINYINT(1) DEFAULT 1, 
    `parent_id` INT DEFAULT NULL,
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `deleted_at` DATETIME DEFAULT NULL
);


-- Brands Table
CREATE TABLE IF NOT EXISTS `brands`(
    `id` PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `slug` VARCHAR(255) UNIQUE,
    `status` TINYINT(1) DEFAULT 1, 
    `category_id` INT DEFAULT NULL,
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `deleted_at` DATETIME DEFAULT NULL,
    FOREIGN KEY `category_id` REFERENCES `categories`(`id`) ON DELETE CASCADE ON UPDATE CASCADE
);




-- Alter tables
ALTER TABLE `users`
ADD COLUMN `last_login` DATETIME DEFAULT NULL;

ALTER TABLE `profiles`
ADD COLUMN `bio` TEXT DEFAULT NULL;
