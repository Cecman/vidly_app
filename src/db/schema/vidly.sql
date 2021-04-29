-- MySQL Workbench Forward Engineering
SET
  @OLD_UNIQUE_CHECKS = @ @UNIQUE_CHECKS,
  UNIQUE_CHECKS = 0;

SET
  @OLD_FOREIGN_KEY_CHECKS = @ @FOREIGN_KEY_CHECKS,
  FOREIGN_KEY_CHECKS = 0;

SET
  @OLD_SQL_MODE = @ @SQL_MODE,
  SQL_MODE = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema vidly
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema vidly
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `vidly`;

USE `vidly`;

-- -----------------------------------------------------
-- Table `vidly`.`coupons`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vidly`.`coupons` (
  `coupon_id` INT NOT NULL,
  `code` VARCHAR(50) NOT NULL,
  `discount` TINYINT NOT NULL,
  PRIMARY KEY (`coupon_id`)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb3;

-- -----------------------------------------------------
-- Table `vidly`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vidly`.`customers` (
  `customer_id` TINYINT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(50) NOT NULL,
  `last_name` VARCHAR(50) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `phone` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`customer_id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `phone_UNIQUE` (`phone` ASC) VISIBLE
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb3;

-- -----------------------------------------------------
-- Table `vidly`.`roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vidly`.`roles` (
  `role_id` TINYINT NOT NULL AUTO_INCREMENT,
  `role` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`role_id`)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb3;

-- -----------------------------------------------------
-- Table `vidly`.`employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vidly`.`employees` (
  `employee_id` TINYINT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(50) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `roles_role_id` TINYINT NOT NULL,
  PRIMARY KEY (`employee_id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE,
  INDEX `fk_employees_roles_idx` (`roles_role_id` ASC) VISIBLE,
  CONSTRAINT `fk_employees_roles` FOREIGN KEY (`roles_role_id`) REFERENCES `vidly`.`roles` (`role_id`)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb3;

-- -----------------------------------------------------
-- Table `vidly`.`movies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vidly`.`movies` (
  `movie_id` TINYINT NOT NULL AUTO_INCREMENT,
  `bar_code` VARCHAR(10) NOT NULL,
  `daily_rental_rate` DECIMAL(5, 2) NOT NULL,
  `number_in_stock` TINYINT NULL DEFAULT '0',
  PRIMARY KEY (`movie_id`)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb3;

-- -----------------------------------------------------
-- Table `vidly`.`rentals`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vidly`.`rentals` (
  `rental_id` INT NOT NULL AUTO_INCREMENT,
  `day_rented` DATE NOT NULL,
  `day_returned` DATE NOT NULL,
  `customer_id` TINYINT NOT NULL,
  `movie_id` TINYINT NOT NULL,
  `coupon_id` INT NOT NULL,
  PRIMARY KEY (`rental_id`),
  INDEX `fk_rentals_customers1_idx` (`customer_id` ASC) VISIBLE,
  INDEX `fk_rentals_movies1_idx` (`movie_id` ASC) VISIBLE,
  INDEX `fk_rentals_coupons1_idx` (`coupon_id` ASC) VISIBLE,
  CONSTRAINT `fk_rentals_coupons1` FOREIGN KEY (`coupon_id`) REFERENCES `vidly`.`coupons` (`coupon_id`),
  CONSTRAINT `fk_rentals_customers1` FOREIGN KEY (`customer_id`) REFERENCES `vidly`.`customers` (`customer_id`),
  CONSTRAINT `fk_rentals_movies1` FOREIGN KEY (`movie_id`) REFERENCES `vidly`.`movies` (`movie_id`)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb3;

USE `vidly`;

-- -----------------------------------------------------
-- Placeholder table for view `vidly`.`rented_movies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vidly`.`rented_movies` (
  `customer_id` INT,
  `rental_id` INT,
  `movie_id` INT,
  `name` INT,
  `day_rented` INT,
  `daily_rental_rate` INT,
  `days_since_rental` INT,
  `current_rental_price` INT
);

-- -----------------------------------------------------
-- View `vidly`.`rented_movies`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `vidly`.`rented_movies`;

USE `vidly`;

CREATE ALGORITHM = UNDEFINED DEFINER = `root` @`localhost` SQL SECURITY DEFINER VIEW `rented_movies` AS
SELECT
  `c`.`customer_id` AS `customer_id`,
  `r`.`rental_id` AS `rental_id`,
  `m`.`movie_id` AS `movie_id`,
  CONCAT(((`c`.`first_name` + ' ') + `c`.`last_name`)) AS `name`,
  `r`.`day_rented` AS `day_rented`,
  `m`.`daily_rental_rate` AS `daily_rental_rate`,
  (DAYOFMONTH(NOW()) - `r`.`day_rented`) AS `days_since_rental`,
  (
    `m`.`daily_rental_rate` * (DAYOFMONTH(NOW()) - `r`.`day_rented`)
  ) AS `current_rental_price`
FROM
  (
    (
      `customers` `c`
      JOIN `rentals` `r` ON ((`c`.`customer_id` = `r`.`customer_id`))
    )
    JOIN `movies` `m` ON ((`r`.`movie_id` = `m`.`movie_id`))
  )
SET
  SQL_MODE = @OLD_SQL_MODE;

SET
  FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS;

SET
  UNIQUE_CHECKS = @OLD_UNIQUE_CHECKS;