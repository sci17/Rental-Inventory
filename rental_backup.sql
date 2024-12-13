-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema finalldrill
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema finalldrill
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `finalldrill` DEFAULT CHARACTER SET utf8mb3 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`PURCHASE_STATUS_CODES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PURCHASE_STATUS_CODES` (
  `purchase_status_code` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`purchase_status_code`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`INVENTORY_ITEM_TYPES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`INVENTORY_ITEM_TYPES` (
  `item_type_code` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`item_type_code`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`INVENTORY_ITEMS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`INVENTORY_ITEMS` (
  `item_id` INT NOT NULL AUTO_INCREMENT,
  `item_type_code` INT NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  `number_in_stocks` INT NOT NULL,
  `rental_sale_both` ENUM('rental', 'sale', 'both') NOT NULL,
  `rental_daily_rate` INT NULL,
  `sale_price` INT NOT NULL,
  PRIMARY KEY (`item_id`),
  INDEX `fk_INVENTORY_ITEMS_INVENTORY_ITEM_TYPES1_idx` (`item_type_code` ASC) VISIBLE,
  CONSTRAINT `fk_INVENTORY_ITEMS_INVENTORY_ITEM_TYPES1`
    FOREIGN KEY (`item_type_code`)
    REFERENCES `mydb`.`INVENTORY_ITEM_TYPES` (`item_type_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`TRANSACTION_TYPES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`TRANSACTION_TYPES` (
  `transaction_type_code` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`transaction_type_code`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`CUSTOMERS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`CUSTOMERS` (
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  `phone_number` VARCHAR(45) NOT NULL,
  `cell_mobile` VARCHAR(45) NULL,
  `email_address` VARCHAR(45) NOT NULL,
  `other_details` VARCHAR(45) NULL,
  PRIMARY KEY (`customer_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`CUSTOMER_ITEM_PURCHASES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`CUSTOMER_ITEM_PURCHASES` (
  `purchase_id` INT NOT NULL AUTO_INCREMENT,
  `purchase_status_code` INT NOT NULL,
  `customer_id` INT NOT NULL,
  `item_id` INT NOT NULL,
  `purchase_date` DATE NOT NULL,
  `purchase_quanity` INT NOT NULL,
  `amount_due` DOUBLE NOT NULL,
  INDEX `fk_PURCHASE_STATUS_CODES_has_CUSTOMERS_CUSTOMERS1_idx` (`customer_id` ASC) VISIBLE,
  INDEX `fk_PURCHASE_STATUS_CODES_has_CUSTOMERS_PURCHASE_STATUS_CODE_idx` (`purchase_status_code` ASC) VISIBLE,
  PRIMARY KEY (`purchase_id`),
  INDEX `fk_CUSTOMER_ITEM_PURCHASES_INVENTORY_ITEMS1_idx` (`item_id` ASC) VISIBLE,
  CONSTRAINT `fk_PURCHASE_STATUS_CODES_has_CUSTOMERS_PURCHASE_STATUS_CODES`
    FOREIGN KEY (`purchase_status_code`)
    REFERENCES `mydb`.`PURCHASE_STATUS_CODES` (`purchase_status_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PURCHASE_STATUS_CODES_has_CUSTOMERS_CUSTOMERS1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `mydb`.`CUSTOMERS` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CUSTOMER_ITEM_PURCHASES_INVENTORY_ITEMS1`
    FOREIGN KEY (`item_id`)
    REFERENCES `mydb`.`INVENTORY_ITEMS` (`item_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PAYMENT_METHODS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PAYMENT_METHODS` (
  `payment_method_code` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`payment_method_code`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ACCOUNTS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ACCOUNTS` (
  `account_id` INT NOT NULL AUTO_INCREMENT,
  `account_name` VARCHAR(45) NOT NULL,
  `payment_method_code` INT NOT NULL,
  `customer_id` INT NOT NULL,
  `account_details` VARCHAR(45) NULL,
  PRIMARY KEY (`account_id`),
  INDEX `fk_ACCOUNTS_PAYMENT_METHODS1_idx` (`payment_method_code` ASC) VISIBLE,
  INDEX `fk_ACCOUNTS_CUSTOMERS1_idx` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_ACCOUNTS_PAYMENT_METHODS1`
    FOREIGN KEY (`payment_method_code`)
    REFERENCES `mydb`.`PAYMENT_METHODS` (`payment_method_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ACCOUNTS_CUSTOMERS1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `mydb`.`CUSTOMERS` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`CUSTOMER_ITEM_RENTALS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`CUSTOMER_ITEM_RENTALS` (
  `item_rental_id` INT NOT NULL AUTO_INCREMENT,
  `customer_id` INT NOT NULL,
  `item_id` INT NOT NULL,
  `rental_date_out` DATE NOT NULL,
  `rental_date_returned` DATE NOT NULL,
  `amount_due` FLOAT NOT NULL,
  `other_details` VARCHAR(45) NULL,
  PRIMARY KEY (`item_rental_id`),
  INDEX `fk_CUSTOMER_ITEM_RENTALS_INVENTORY_ITEMS1_idx` (`item_id` ASC) VISIBLE,
  INDEX `fk_CUSTOMER_ITEM_RENTALS_CUSTOMERS1_idx` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_CUSTOMER_ITEM_RENTALS_INVENTORY_ITEMS1`
    FOREIGN KEY (`item_id`)
    REFERENCES `mydb`.`INVENTORY_ITEMS` (`item_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CUSTOMER_ITEM_RENTALS_CUSTOMERS1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `mydb`.`CUSTOMERS` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`FINANCIAL_TRANSACTIONS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`FINANCIAL_TRANSACTIONS` (
  `transaction_id` INT NOT NULL AUTO_INCREMENT,
  `account_id` INT NOT NULL,
  `item_rental_id` INT NOT NULL,
  `purchase_id` INT NOT NULL,
  `previous_transaction_id` INT NOT NULL,
  `transaction_date` DATE NOT NULL,
  `transaction_type_code` INT NULL,
  `transaction_amount` DOUBLE NOT NULL,
  `comment` VARCHAR(150) NULL,
  PRIMARY KEY (`transaction_id`),
  INDEX `fk_FINANCIAL_TRANSACTIONS_CUSTOMER_ITEM_PURCHASES1_idx` (`purchase_id` ASC) VISIBLE,
  INDEX `fk_FINANCIAL_TRANSACTIONS_FINANCIAL_TRANSACTIONS1_idx` (`previous_transaction_id` ASC) VISIBLE,
  INDEX `fk_FINANCIAL_TRANSACTIONS_TRANSACTION_TYPES1_idx` (`transaction_type_code` ASC) VISIBLE,
  INDEX `fk_FINANCIAL_TRANSACTIONS_ACCOUNTS1_idx` (`account_id` ASC) VISIBLE,
  INDEX `fk_FINANCIAL_TRANSACTIONS_CUSTOMER_ITEM_RENTALS1_idx` (`item_rental_id` ASC) VISIBLE,
  CONSTRAINT `fk_FINANCIAL_TRANSACTIONS_CUSTOMER_ITEM_PURCHASES1`
    FOREIGN KEY (`purchase_id`)
    REFERENCES `mydb`.`CUSTOMER_ITEM_PURCHASES` (`purchase_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_FINANCIAL_TRANSACTIONS_FINANCIAL_TRANSACTIONS1`
    FOREIGN KEY (`previous_transaction_id`)
    REFERENCES `mydb`.`FINANCIAL_TRANSACTIONS` (`transaction_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_FINANCIAL_TRANSACTIONS_TRANSACTION_TYPES1`
    FOREIGN KEY (`transaction_type_code`)
    REFERENCES `mydb`.`TRANSACTION_TYPES` (`transaction_type_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_FINANCIAL_TRANSACTIONS_ACCOUNTS1`
    FOREIGN KEY (`account_id`)
    REFERENCES `mydb`.`ACCOUNTS` (`account_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_FINANCIAL_TRANSACTIONS_CUSTOMER_ITEM_RENTALS1`
    FOREIGN KEY (`item_rental_id`)
    REFERENCES `mydb`.`CUSTOMER_ITEM_RENTALS` (`item_rental_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `finalldrill` ;

-- -----------------------------------------------------
-- Table `finalldrill`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finalldrill`.`customers` (
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `address` VARCHAR(500) NULL DEFAULT NULL,
  `phone_number` VARCHAR(45) NOT NULL,
  `cell_mobile` VARCHAR(45) NULL DEFAULT NULL,
  `email_address` VARCHAR(45) NOT NULL,
  `other_details` VARCHAR(500) NULL DEFAULT NULL,
  PRIMARY KEY (`customer_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 28
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `finalldrill`.`payment_methods`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finalldrill`.`payment_methods` (
  `payment_method_code` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(500) NULL DEFAULT NULL,
  PRIMARY KEY (`payment_method_code`))
ENGINE = InnoDB
AUTO_INCREMENT = 26
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `finalldrill`.`accounts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finalldrill`.`accounts` (
  `account_id` INT NOT NULL AUTO_INCREMENT,
  `account_name` VARCHAR(45) NOT NULL,
  `payment_method_code` INT NOT NULL,
  `customer_id` INT NOT NULL,
  `account_details` VARCHAR(500) NULL DEFAULT NULL,
  PRIMARY KEY (`account_id`),
  INDEX `fk_ACCOUNTS_PAYMENT_METHODS1_idx` (`payment_method_code` ASC) VISIBLE,
  INDEX `fk_ACCOUNTS_CUSTOMERS1_idx` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_ACCOUNTS_CUSTOMERS1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `finalldrill`.`customers` (`customer_id`),
  CONSTRAINT `fk_ACCOUNTS_PAYMENT_METHODS1`
    FOREIGN KEY (`payment_method_code`)
    REFERENCES `finalldrill`.`payment_methods` (`payment_method_code`))
ENGINE = InnoDB
AUTO_INCREMENT = 27
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `finalldrill`.`inventory_item_types`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finalldrill`.`inventory_item_types` (
  `item_type_code` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(500) NULL DEFAULT NULL,
  PRIMARY KEY (`item_type_code`))
ENGINE = InnoDB
AUTO_INCREMENT = 27
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `finalldrill`.`inventory_items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finalldrill`.`inventory_items` (
  `item_id` INT NOT NULL AUTO_INCREMENT,
  `item_type_code` INT NOT NULL,
  `description` VARCHAR(500) NULL DEFAULT NULL,
  `number_in_stocks` INT NOT NULL,
  `rental_sale_both` ENUM('rental', 'sale', 'both') NOT NULL,
  `rental_daily_rate` INT NULL DEFAULT NULL,
  `sale_price` INT NOT NULL,
  PRIMARY KEY (`item_id`),
  INDEX `fk_INVENTORY_ITEMS_INVENTORY_ITEM_TYPES1_idx` (`item_type_code` ASC) VISIBLE,
  CONSTRAINT `fk_INVENTORY_ITEMS_INVENTORY_ITEM_TYPES1`
    FOREIGN KEY (`item_type_code`)
    REFERENCES `finalldrill`.`inventory_item_types` (`item_type_code`))
ENGINE = InnoDB
AUTO_INCREMENT = 26
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `finalldrill`.`purchase_status_codes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finalldrill`.`purchase_status_codes` (
  `purchase_status_code` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(500) NULL DEFAULT NULL,
  PRIMARY KEY (`purchase_status_code`))
ENGINE = InnoDB
AUTO_INCREMENT = 27
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `finalldrill`.`customer_item_purchases`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finalldrill`.`customer_item_purchases` (
  `purchase_id` INT NOT NULL AUTO_INCREMENT,
  `purchase_status_code` INT NOT NULL,
  `customer_id` INT NOT NULL,
  `item_id` INT NOT NULL,
  `purchase_date` DATE NOT NULL,
  `purchase_quantity` INT NULL DEFAULT NULL,
  `amount_due` DOUBLE NOT NULL,
  PRIMARY KEY (`purchase_id`),
  INDEX `fk_PURCHASE_STATUS_CODES_has_CUSTOMERS_CUSTOMERS1_idx` (`customer_id` ASC) VISIBLE,
  INDEX `fk_PURCHASE_STATUS_CODES_has_CUSTOMERS_PURCHASE_STATUS_CODE_idx` (`purchase_status_code` ASC) VISIBLE,
  INDEX `fk_CUSTOMER_ITEM_PURCHASES_INVENTORY_ITEMS1_idx` (`item_id` ASC) VISIBLE,
  CONSTRAINT `fk_CUSTOMER_ITEM_PURCHASES_INVENTORY_ITEMS1`
    FOREIGN KEY (`item_id`)
    REFERENCES `finalldrill`.`inventory_items` (`item_id`),
  CONSTRAINT `fk_PURCHASE_STATUS_CODES_has_CUSTOMERS_CUSTOMERS1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `finalldrill`.`customers` (`customer_id`),
  CONSTRAINT `fk_PURCHASE_STATUS_CODES_has_CUSTOMERS_PURCHASE_STATUS_CODES`
    FOREIGN KEY (`purchase_status_code`)
    REFERENCES `finalldrill`.`purchase_status_codes` (`purchase_status_code`))
ENGINE = InnoDB
AUTO_INCREMENT = 26
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `finalldrill`.`customer_item_rentals`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finalldrill`.`customer_item_rentals` (
  `item_rental_id` INT NOT NULL AUTO_INCREMENT,
  `customer_id` INT NOT NULL,
  `item_id` INT NOT NULL,
  `rental_date_out` DATE NOT NULL,
  `rental_date_returned` DATE NOT NULL,
  `amount_due` FLOAT NOT NULL,
  `other_details` VARCHAR(500) NULL DEFAULT NULL,
  PRIMARY KEY (`item_rental_id`),
  INDEX `fk_CUSTOMER_ITEM_RENTALS_INVENTORY_ITEMS1_idx` (`item_id` ASC) VISIBLE,
  INDEX `fk_CUSTOMER_ITEM_RENTALS_CUSTOMERS1_idx` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_CUSTOMER_ITEM_RENTALS_CUSTOMERS1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `finalldrill`.`customers` (`customer_id`),
  CONSTRAINT `fk_CUSTOMER_ITEM_RENTALS_INVENTORY_ITEMS1`
    FOREIGN KEY (`item_id`)
    REFERENCES `finalldrill`.`inventory_items` (`item_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 26
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `finalldrill`.`transaction_types`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finalldrill`.`transaction_types` (
  `transaction_type_code` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(500) NULL DEFAULT NULL,
  PRIMARY KEY (`transaction_type_code`))
ENGINE = InnoDB
AUTO_INCREMENT = 27
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `finalldrill`.`financial_transactions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finalldrill`.`financial_transactions` (
  `transaction_id` INT NOT NULL AUTO_INCREMENT,
  `account_id` INT NOT NULL,
  `item_rental_id` INT NOT NULL,
  `purchase_id` INT NOT NULL,
  `previous_transaction_id` INT NOT NULL,
  `transaction_date` DATE NOT NULL,
  `transaction_type_code` INT NULL DEFAULT NULL,
  `transaction_amount` DOUBLE NOT NULL,
  `comment` VARCHAR(150) NULL DEFAULT NULL,
  PRIMARY KEY (`transaction_id`),
  INDEX `fk_FINANCIAL_TRANSACTIONS_CUSTOMER_ITEM_PURCHASES1_idx` (`purchase_id` ASC) VISIBLE,
  INDEX `fk_FINANCIAL_TRANSACTIONS_FINANCIAL_TRANSACTIONS1_idx` (`previous_transaction_id` ASC) VISIBLE,
  INDEX `fk_FINANCIAL_TRANSACTIONS_TRANSACTION_TYPES1_idx` (`transaction_type_code` ASC) VISIBLE,
  INDEX `fk_FINANCIAL_TRANSACTIONS_ACCOUNTS1_idx` (`account_id` ASC) VISIBLE,
  INDEX `fk_FINANCIAL_TRANSACTIONS_CUSTOMER_ITEM_RENTALS1_idx` (`item_rental_id` ASC) VISIBLE,
  CONSTRAINT `fk_FINANCIAL_TRANSACTIONS_ACCOUNTS1`
    FOREIGN KEY (`account_id`)
    REFERENCES `finalldrill`.`accounts` (`account_id`),
  CONSTRAINT `fk_FINANCIAL_TRANSACTIONS_CUSTOMER_ITEM_PURCHASES1`
    FOREIGN KEY (`purchase_id`)
    REFERENCES `finalldrill`.`customer_item_purchases` (`purchase_id`),
  CONSTRAINT `fk_FINANCIAL_TRANSACTIONS_CUSTOMER_ITEM_RENTALS1`
    FOREIGN KEY (`item_rental_id`)
    REFERENCES `finalldrill`.`customer_item_rentals` (`item_rental_id`),
  CONSTRAINT `fk_FINANCIAL_TRANSACTIONS_FINANCIAL_TRANSACTIONS1`
    FOREIGN KEY (`previous_transaction_id`)
    REFERENCES `finalldrill`.`financial_transactions` (`transaction_id`),
  CONSTRAINT `fk_FINANCIAL_TRANSACTIONS_TRANSACTION_TYPES1`
    FOREIGN KEY (`transaction_type_code`)
    REFERENCES `finalldrill`.`transaction_types` (`transaction_type_code`))
ENGINE = InnoDB
AUTO_INCREMENT = 26
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
