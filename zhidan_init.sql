-- MySQL Script generated by MySQL Workbench
-- Tue Jun 26 23:06:31 2018
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema zhidan
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema zhidan
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `zhidan` DEFAULT CHARACTER SET utf8 ;
USE `zhidan` ;

-- -----------------------------------------------------
-- Table `zhidan`.`restaurant`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zhidan`.`restaurant` (
  `restaurant_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `manager_number` VARCHAR(16) NOT NULL,
  `manager_password` CHAR(32) NOT NULL,
  `restaurant_name` VARCHAR(64) NULL,
  `image_url` VARCHAR(256) NULL,
  `restaurant_number` VARCHAR(16) NULL,
  `description` VARCHAR(512) NULL,
  `desk_number` INT UNSIGNED NULL DEFAULT 0,
  `order_counter` INT NULL DEFAULT 0,
  `order_timestamp` TIMESTAMP NULL DEFAULT NOW(),
  `date` TIMESTAMP NOT NULL DEFAULT NOW(),
  PRIMARY KEY (`restaurant_id`),
  UNIQUE INDEX `manager_number_UNIQUE` (`manager_number` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zhidan`.`desk`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zhidan`.`desk` (
  `desk_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `desk_link` VARCHAR(256) NULL,
  `restaurant_id` INT UNSIGNED NOT NULL,
  `desk_number` INT UNSIGNED NULL,
  PRIMARY KEY (`desk_id`),
  INDEX `restaurant_id_idx` (`restaurant_id` ASC),
  CONSTRAINT `desk_fk1`
    FOREIGN KEY (`restaurant_id`)
    REFERENCES `zhidan`.`restaurant` (`restaurant_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zhidan`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zhidan`.`category` (
  `category_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `category_name` VARCHAR(64) NOT NULL,
  `restaurant_id` INT UNSIGNED NOT NULL,
  `date` TIMESTAMP NOT NULL DEFAULT NOW(),
  PRIMARY KEY (`category_id`),
  INDEX `category_fk1_idx` (`restaurant_id` ASC),
  CONSTRAINT `category_fk1`
    FOREIGN KEY (`restaurant_id`)
    REFERENCES `zhidan`.`restaurant` (`restaurant_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zhidan`.`dish`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zhidan`.`dish` (
  `dish_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `date` TIMESTAMP NOT NULL DEFAULT NOW(),
  `dish_name` VARCHAR(64) NOT NULL,
  `price` FLOAT NOT NULL,
  `image_url` VARCHAR(256) NULL,
  `flavor` VARCHAR(32) NOT NULL,
  `category_id` INT UNSIGNED NOT NULL,
  `favorable_rate` FLOAT NULL DEFAULT 0.0,
  `description` VARCHAR(256) NULL,
  `restaurant_id` INT UNSIGNED NOT NULL,
  `sale_out` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`dish_id`),
  INDEX `dish_fk2_idx` (`category_id` ASC),
  INDEX `dish_fk1_idx` (`restaurant_id` ASC),
  CONSTRAINT `dish_fk2`
    FOREIGN KEY (`category_id`)
    REFERENCES `zhidan`.`category` (`category_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `dish_fk1`
    FOREIGN KEY (`restaurant_id`)
    REFERENCES `zhidan`.`restaurant` (`restaurant_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zhidan`.`meal_order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zhidan`.`meal_order` (
  `order_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `restaurant_id` INT UNSIGNED NOT NULL,
  `date` TIMESTAMP NOT NULL DEFAULT NOW(),
  `total_price` FLOAT NULL,
  `dish_number` INT NULL,
  `tableware` VARCHAR(4) NULL,
  `state` VARCHAR(12) NULL,
  `desk_id` INT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `restaurant_id_idx` (`restaurant_id` ASC),
  CONSTRAINT `order_fk2`
    FOREIGN KEY (`restaurant_id`)
    REFERENCES `zhidan`.`restaurant` (`restaurant_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zhidan`.`sale`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zhidan`.`sale` (
  `sale_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `restaurant_id` INT UNSIGNED NOT NULL,
  `dish_id` INT UNSIGNED NOT NULL,
  `order_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`sale_id`),
  INDEX `restaurant_id_idx` (`restaurant_id` ASC),
  INDEX `order_id_idx` (`order_id` ASC),
  INDEX `sale_fk2_idx` (`dish_id` ASC),
  CONSTRAINT `sale_fk1`
    FOREIGN KEY (`restaurant_id`)
    REFERENCES `zhidan`.`restaurant` (`restaurant_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `sale_fk2`
    FOREIGN KEY (`dish_id`)
    REFERENCES `zhidan`.`dish` (`dish_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `sale_fk3`
    FOREIGN KEY (`order_id`)
    REFERENCES `zhidan`.`meal_order` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zhidan`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zhidan`.`customer` (
  `customer_id` VARCHAR(64) NOT NULL,
  `nickname` VARCHAR(64) NOT NULL,
  PRIMARY KEY (`customer_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `zhidan`.`comment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `zhidan`.`comment` (
  `comment_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `dish_id` INT UNSIGNED NOT NULL,
  `customer_id` VARCHAR(64) NOT NULL,
  `description` VARCHAR(256) NULL,
  `level` VARCHAR(8) NULL,
  PRIMARY KEY (`comment_id`),
  INDEX `dish_id_idx` (`dish_id` ASC),
  INDEX `customer_id_idx` (`customer_id` ASC),
  CONSTRAINT `comment_fk1`
    FOREIGN KEY (`dish_id`)
    REFERENCES `zhidan`.`dish` (`dish_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `comment_fk2`
    FOREIGN KEY (`customer_id`)
    REFERENCES `zhidan`.`customer` (`customer_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
