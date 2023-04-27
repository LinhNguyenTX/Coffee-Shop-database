-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema coffeeShop
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema coffeeShop
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `coffeeShop` DEFAULT CHARACTER SET utf8 ;
USE `coffeeShop` ;

-- -----------------------------------------------------
-- Table `coffeeShop`.`Branch`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `coffeeShop`.`Branch` (
  `branchID` VARCHAR(10) NOT NULL,
  `street` VARCHAR(70) NULL,
  `city` VARCHAR(30) NOT NULL,
  `zipcode` VARCHAR(15) NOT NULL,
  `phone` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`branchID`),
  UNIQUE INDEX `phone_UNIQUE` (`phone` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `coffeeShop`.`Staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `coffeeShop`.`Staff` (
  `staffID` VARCHAR(10) NOT NULL,
  `firstName` VARCHAR(40) NOT NULL,
  `lastName` VARCHAR(40) NOT NULL,
  `phone` VARCHAR(10) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `DOB` DATE NOT NULL,
  `positionTitle` VARCHAR(45) NOT NULL,
  `Branch_branchID` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`staffID`),
  UNIQUE INDEX `DOB_UNIQUE` (`DOB` ASC) VISIBLE,
  UNIQUE INDEX `phone_UNIQUE` (`phone` ASC) VISIBLE,
  INDEX `fk_Staff_Branch1_idx` (`Branch_branchID` ASC) VISIBLE,
  CONSTRAINT `fk_Staff_Branch1`
    FOREIGN KEY (`Branch_branchID`)
    REFERENCES `coffeeShop`.`Branch` (`branchID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `coffeeShop`.`Category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `coffeeShop`.`Category` (
  `catergoryID` VARCHAR(10) NOT NULL,
  `categoryName` VARCHAR(45) NOT NULL,
  `description` VARCHAR(150) NULL,
  PRIMARY KEY (`catergoryID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `coffeeShop`.`Items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `coffeeShop`.`Items` (
  `itemID` VARCHAR(10) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(150) NULL,
  `price` DECIMAL(3,2) NULL,
  `Category_catergoryID` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`itemID`),
  INDEX `fk_Items_Category1_idx` (`Category_catergoryID` ASC) VISIBLE,
  CONSTRAINT `fk_Items_Category1`
    FOREIGN KEY (`Category_catergoryID`)
    REFERENCES `coffeeShop`.`Category` (`catergoryID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `coffeeShop`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `coffeeShop`.`Customer` (
  `customerID` VARCHAR(10) NOT NULL,
  `firstName` VARCHAR(40) NOT NULL,
  `lastName` VARCHAR(40) NOT NULL,
  `phone` VARCHAR(10) NOT NULL,
  `email` VARCHAR(100) NULL,
  `city` VARCHAR(30) NULL,
  `zipcode` VARCHAR(15) NULL,
  PRIMARY KEY (`customerID`),
  UNIQUE INDEX `phone_UNIQUE` (`phone` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `coffeeShop`.`Order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `coffeeShop`.`Order` (
  `orderID` VARCHAR(10) NOT NULL,
  `orderTime` TIME NOT NULL,
  `orderDate` DATE NOT NULL,
  `Customer_customerID` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`orderID`),
  INDEX `fk_Order_Customer1_idx` (`Customer_customerID` ASC) VISIBLE,
  CONSTRAINT `fk_Order_Customer1`
    FOREIGN KEY (`Customer_customerID`)
    REFERENCES `coffeeShop`.`Customer` (`customerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `coffeeShop`.`Payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `coffeeShop`.`Payment` (
  `paymentID` VARCHAR(10) NOT NULL,
  `paymentDate` DATE NOT NULL,
  `totalPrice` DECIMAL(4,2) NOT NULL,
  `tax` DECIMAL(4,2) NOT NULL,
  `Customer_customerID` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`paymentID`),
  INDEX `fk_Payment_Customer1_idx` (`Customer_customerID` ASC) VISIBLE,
  CONSTRAINT `fk_Payment_Customer1`
    FOREIGN KEY (`Customer_customerID`)
    REFERENCES `coffeeShop`.`Customer` (`customerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `coffeeShop`.`Order_has_Items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `coffeeShop`.`Order_has_Items` (
  `Order_orderID` VARCHAR(10) NOT NULL,
  `Items_itemID` VARCHAR(10) NOT NULL,
  `itemQuantity` INT NULL,
  PRIMARY KEY (`Order_orderID`, `Items_itemID`),
  INDEX `fk_Order_has_Items_Items1_idx` (`Items_itemID` ASC) VISIBLE,
  INDEX `fk_Order_has_Items_Order1_idx` (`Order_orderID` ASC) VISIBLE,
  CONSTRAINT `fk_Order_has_Items_Order1`
    FOREIGN KEY (`Order_orderID`)
    REFERENCES `coffeeShop`.`Order` (`orderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Order_has_Items_Items1`
    FOREIGN KEY (`Items_itemID`)
    REFERENCES `coffeeShop`.`Items` (`itemID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
