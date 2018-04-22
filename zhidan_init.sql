# create database zhidan
CREATE DATABASE IF NOT EXISTS `zhidan`;
use zhidan;

# create table restaurant
CREATE TABLE IF NOT EXISTS `restaurant` (
    `restaurant_id` INT UNSIGNED AUTO_INCREMENT,
    `manager_number` VARCHAR(16) NOT NULL,
    `manager_password` CHAR(32) NOT NULL,
    `restaurant_name` VARCHAR(64) NOT NULL,
    `description` VARCHAR(256) DEFAULT '',
    `image_id` VARCHAR(256) DEFAULT '',
    `restaurant_number` VARCHAR(16) DEFAULT '',
    PRIMARY KEY(`restaurant_id`),
    UNIQUE KEY(`manager_number`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
DESC `restaurant`;

# create table disk
CREATE TABLE IF NOT EXISTS `disk` (
    `disk_id` INT UNSIGNED AUTO_INCREMENT,
    `restaurant_id` INT UNSIGNED,
    `creation_date` TIMESTAMP NOT NULL DEFAULT NOW(),
    `disk_name` VARCHAR(64) NOT NULL,
    `price` FLOAT NOT NULL,
    `image_id` VARCHAR(256) DEFAULT '',
    `flavor` VARCHAR(32) NOT NULL,
    `category` VARCHAR(32) NOT NULL,
    `favorable_rate` FLOAT,
    `comment_number` INT UNSIGNED,
    `description` VARCHAR(256),
    PRIMARY KEY(`disk_id`),
    CONSTRAINT `disk_fk1` FOREIGN KEY(`restaurant_id`) REFERENCES `restaurant` (`restaurant_id`) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8; 
DESC `disk`;

# create table desk
CREATE TABLE IF NOT EXISTS `desk` (
    `desk_id` INT UNSIGNED AUTO_INCREMENT,
    `desk_number` INT UNSIGNED,
    `restaurant_id` INT UNSIGNED,
    `desk_link` VARCHAR(256),
    PRIMARY KEY(`desk_id`),
    CONSTRAINT `desk_fk1` FOREIGN KEY(`restaurant_id`) REFERENCES `restaurant` (`restaurant_id`) ON UPDATE CASCADE ON DELETE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
DESC `desk`;

# create table customer
CREATE TABLE IF NOT EXISTS `customer` (
    `customer_id` VARCHAR(64),
    `nickname` VARCHAR(64) NOT NULL,
    PRIMARY KEY(`customer_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
DESC `customer`;

# create table customer_comment
CREATE TABLE IF NOT EXISTS `customer_comment` (
    `comment_id` INT UNSIGNED AUTO_INCREMENT,
    `disk_id` INT UNSIGNED,
    `customer_id` VARCHAR(64),
    `description` VARCHAR(256) DEFAULT '',
    PRIMARY KEY(`comment_id`),
    CONSTRAINT `customer_comment_fk1` FOREIGN KEY(`disk_id`) REFERENCES `disk` (`disk_id`) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT `customer_comment_fk2` FOREIGN KEY(`customer_id`) REFERENCES `customer` (`customer_id`) ON UPDATE CASCADE ON DELETE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
DESC `customer_comment`;

# create table order
CREATE TABLE IF NOT EXISTS `customer_order` (
    `order_id` INT UNSIGNED AUTO_INCREMENT,
    `restaurant_id` INT UNSIGNED,
    `customer_id` VARCHAR(64),
    `desk_id` INT UNSIGNED,
    `order_date` TIMESTAMP NOT NULL DEFAULT NOW(),
    `total_price` FLOAT,
    `disk_num` INT,
    `tableware` VARCHAR(4),
    `state` VARCHAR(12),
    PRIMARY KEY(`order_id`),
    CONSTRAINT `customer_order_fk1` FOREIGN KEY(`restaurant_id`) REFERENCES `restaurant` (`restaurant_id`) ON UPDATE CASCADE,
    CONSTRAINT `customer_order_fk2` FOREIGN KEY(`customer_id`) REFERENCES `customer` (`customer_id`) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT `customer_order_fk3` FOREIGN KEY(`desk_id`) REFERENCES `desk` (`desk_id`) ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
DESC `customer_order`;

# ceate table sale
CREATE TABLE IF NOT EXISTS `sale` (
    `sale_id` INT UNSIGNED AUTO_INCREMENT,
    `restaurant_id` INT UNSIGNED,
    `desk_id` INT UNSIGNED,
    `order_id` INT UNSIGNED,
    PRIMARY KEY(`sale_id`),
    CONSTRAINT `sale_fk1` FOREIGN KEY(`restaurant_id`) REFERENCES `restaurant` (`restaurant_id`) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT `sale_fk2` FOREIGN KEY(`desk_id`) REFERENCES `desk` (`desk_id`) ON UPDATE CASCADE,
    CONSTRAINT `sale_fk3` FOREIGN KEY(`order_id`) REFERENCES `customer_order` (`order_id`) ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
DESC `sale`;

SHOW TABLES;
