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

alter table payment
add totalAmount decimal(4,2);
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


----Items Table-----
INSERT INTO `coffeeshop`.`items` (`itemID`, `name`, `description`, `price`, `Category_catergoryID`) VALUES ('I001', 'Cold Brew French Style', 'french style coffee cold brew in 1 hour', '5.00', 'CG1001');
INSERT INTO `coffeeshop`.`items` (`itemID`, `name`, `description`, `price`, `Category_catergoryID`) VALUES ('I002', 'Cold Espresso', 'pressure steam black coffee', '4.50', 'CG1001');
INSERT INTO `coffeeshop`.`items` (`itemID`, `name`, `description`, `price`, `Category_catergoryID`) VALUES ('I003', 'Iced Americano', 'espresso shots topped with cold water ', '5.00', 'CG1001');
INSERT INTO `coffeeshop`.`items` (`itemID`, `name`, `description`, `price`, `Category_catergoryID`) VALUES ('I004', 'Hot Espresso', 'espresso shot in small cup', '4.00', 'CG1002');
INSERT INTO `coffeeshop`.`items` (`itemID`, `name`, `description`, `price`, `Category_catergoryID`) VALUES ('I005', 'Hot Chocolate', '1 shot of coffee with milk and  chocolate-flavored syrups', '5.00', 'CG1002');
INSERT INTO `coffeeshop`.`items` (`itemID`, `name`, `description`, `price`, `Category_catergoryID`) VALUES ('I006', 'Ice Mocha Latte', 'espresso with milk and mocha flavor', '5.00', 'CG2001');
INSERT INTO `coffeeshop`.`items` (`itemID`, `name`, `description`, `price`, `Category_catergoryID`) VALUES ('I007', 'Hot Latte', 'espresso, steamed milk and a layer of foam', '5.00', 'CG2002');
INSERT INTO `coffeeshop`.`items` (`itemID`, `name`, `description`, `price`, `Category_catergoryID`) VALUES ('I008', 'Hot Cappuccino', 'dark, rich espresso lies in wait under a smoothed and stretched layer of thick milk foam', '5.0', 'CG3001');
INSERT INTO `coffeeshop`.`items` (`itemID`, `name`, `description`, `price`, `Category_catergoryID`) VALUES ('I009', 'Chocolate Chip Frappuccino', 'chocolate chip with coffee milk, ice, whipped cream and mocha drizzle', '5.50', 'CG3002');
INSERT INTO `coffeeshop`.`items` (`itemID`, `name`, `description`, `price`, `Category_catergoryID`) VALUES ('I010', 'Caramel Frappuccino', 'caramel syrup meets coffee, milk and ice topped with whipped cream and caramel sauce', '5.50', 'CG3002');
INSERT INTO `coffeeshop`.`items` (`itemID`, `name`, `description`, `price`, `Category_catergoryID`) VALUES ('I011', 'Strawberry Crème Frappuccino', 'non-caffeine strawberry puree, whipped cream and ice', '5.00', 'CG3002');
INSERT INTO `coffeeshop`.`items` (`itemID`, `name`, `description`, `price`, `Category_catergoryID`) VALUES ('I012', 'Royal English Breakfast Tea', 'english style black tea', '4.00', 'CG4001');
INSERT INTO `coffeeshop`.`items` (`itemID`, `name`, `description`, `price`, `Category_catergoryID`) VALUES ('I013', 'Iced Matcha Tea Latte', 'matcha with milk over ice', '5.00', 'CG4002');
INSERT INTO `coffeeshop`.`items` (`itemID`, `name`, `description`, `price`, `Category_catergoryID`) VALUES ('I014', 'Iced Green Tea', 'green tea blended with mint, lemongrass and lemon verbena, and given a good shake with ice', '5.50', 'CG4002');


----Customer Table-----
INSERT INTO `coffeeshop`.`customer` (`customerID`, `firstName`, `lastName`, `phone`, `email`, `city`, `zipcode`) VALUES ('C001', 'Linh', 'Nguyen', '8322310312', 'linhxuanthinguyen@gmail.com', 'Houston', '77070');
INSERT INTO `coffeeshop`.`customer` (`customerID`, `firstName`, `lastName`, `phone`, `email`, `city`, `zipcode`) VALUES ('C002', 'Michael', 'Jackson', '8324789874', 'mj2016@gmail.com', 'Houston', '77001');
INSERT INTO `coffeeshop`.`customer` (`customerID`, `firstName`, `lastName`, `phone`, `email`, `city`, `zipcode`) VALUES ('C003', 'Sang ', 'Lee', '3137894575', 'leesang.45@gmail.com', 'Houston', '77001');
INSERT INTO `coffeeshop`.`customer` (`customerID`, `firstName`, `lastName`, `phone`, `email`, `city`, `zipcode`) VALUES ('C004', 'Stevie', 'Wonder', '7135641578', 'stWonder@gmail.com', 'Houston', '77070');
INSERT INTO `coffeeshop`.`customer` (`customerID`, `firstName`, `lastName`, `phone`, `email`, `city`, `zipcode`) VALUES ('C005', 'Celine', 'Dion', '5124574515', 'CelineDion123@gmail.com', 'Houston', '77043');
INSERT INTO `coffeeshop`.`customer` (`customerID`, `firstName`, `lastName`, `phone`, `email`, `city`, `zipcode`) VALUES ('C006', 'Frank', 'Sinatra', '8647549746', 'Frankclassy@gmail.com', 'Houston', '77041');
INSERT INTO `coffeeshop`.`customer` (`customerID`, `firstName`, `lastName`, `phone`, `email`, `city`, `zipcode`) VALUES ('C007', 'Lana', 'Rey', '7134216513', 'lanadelrey30@gmail.com', 'Austin', '78723');
INSERT INTO `coffeeshop`.`customer` (`customerID`, `firstName`, `lastName`, `phone`, `email`, `city`, `zipcode`) VALUES ('C008', 'Kendrick', 'Lamar', '8322314514', 'Klamar8745@gmail.com', 'Austin', '78761');
INSERT INTO `coffeeshop`.`customer` (`customerID`, `firstName`, `lastName`, `phone`, `email`, `city`, `zipcode`) VALUES ('C009', 'Bruce', 'Spring', '9451254784', 'brucelovespring@gmail.com', 'Austin', '78761');
INSERT INTO `coffeeshop`.`customer` (`customerID`, `firstName`, `lastName`, `phone`, `email`, `city`, `zipcode`) VALUES ('C010', 'Alex', 'Warren', '8457245613', 'chasingShadows@gmail.com', 'Austin', '78723');


---Order Table------
INSERT INTO `coffeeshop`.`customer` (`customerID`, `firstName`, `lastName`, `phone`, `email`, `city`, `zipcode`) VALUES ('C001', 'Linh', 'Nguyen', '8322310312', 'linhxuanthinguyen@gmail.com', 'Houston', '77070');
INSERT INTO `coffeeshop`.`customer` (`customerID`, `firstName`, `lastName`, `phone`, `email`, `city`, `zipcode`) VALUES ('C002', 'Michael', 'Jackson', '8324789874', 'mj2016@gmail.com', 'Houston', '77001');
INSERT INTO `coffeeshop`.`customer` (`customerID`, `firstName`, `lastName`, `phone`, `email`, `city`, `zipcode`) VALUES ('C003', 'Sang ', 'Lee', '3137894575', 'leesang.45@gmail.com', 'Houston', '77001');
INSERT INTO `coffeeshop`.`customer` (`customerID`, `firstName`, `lastName`, `phone`, `email`, `city`, `zipcode`) VALUES ('C004', 'Stevie', 'Wonder', '7135641578', 'stWonder@gmail.com', 'Houston', '77070');
INSERT INTO `coffeeshop`.`customer` (`customerID`, `firstName`, `lastName`, `phone`, `email`, `city`, `zipcode`) VALUES ('C005', 'Celine', 'Dion', '5124574515', 'CelineDion123@gmail.com', 'Houston', '77043');
INSERT INTO `coffeeshop`.`customer` (`customerID`, `firstName`, `lastName`, `phone`, `email`, `city`, `zipcode`) VALUES ('C006', 'Frank', 'Sinatra', '8647549746', 'Frankclassy@gmail.com', 'Houston', '77041');
INSERT INTO `coffeeshop`.`customer` (`customerID`, `firstName`, `lastName`, `phone`, `email`, `city`, `zipcode`) VALUES ('C007', 'Lana', 'Rey', '7134216513', 'lanadelrey30@gmail.com', 'Austin', '78723');
INSERT INTO `coffeeshop`.`customer` (`customerID`, `firstName`, `lastName`, `phone`, `email`, `city`, `zipcode`) VALUES ('C008', 'Kendrick', 'Lamar', '8322314514', 'Klamar8745@gmail.com', 'Austin', '78761');
INSERT INTO `coffeeshop`.`customer` (`customerID`, `firstName`, `lastName`, `phone`, `email`, `city`, `zipcode`) VALUES ('C009', 'Bruce', 'Spring', '9451254784', 'brucelovespring@gmail.com', 'Austin', '78761');
INSERT INTO `coffeeshop`.`customer` (`customerID`, `firstName`, `lastName`, `phone`, `email`, `city`, `zipcode`) VALUES ('C010', 'Alex', 'Warren', '8457245613', 'chasingShadows@gmail.com', 'Austin', '78723');


---Order has Items Table----
INSERT INTO `coffeeshop`.`order_has_items` (`Order_orderID`, `Items_itemID`, `itemQuantity`) VALUES ('O1001', 'I001', '1');
INSERT INTO `coffeeshop`.`order_has_items` (`Order_orderID`, `Items_itemID`, `itemQuantity`) VALUES ('O1001', 'I002', '1');
INSERT INTO `coffeeshop`.`order_has_items` (`Order_orderID`, `Items_itemID`, `itemQuantity`) VALUES ('O1001', 'I003', '1');
INSERT INTO `coffeeshop`.`order_has_items` (`Order_orderID`, `Items_itemID`, `itemQuantity`) VALUES ('O1002', 'I009', '1');
INSERT INTO `coffeeshop`.`order_has_items` (`Order_orderID`, `Items_itemID`, `itemQuantity`) VALUES ('O1003', 'I009', '1');
INSERT INTO `coffeeshop`.`order_has_items` (`Order_orderID`, `Items_itemID`, `itemQuantity`) VALUES ('O1003', 'I010', '1');
INSERT INTO `coffeeshop`.`order_has_items` (`Order_orderID`, `Items_itemID`, `itemQuantity`) VALUES ('O1003', 'I012', '4');
INSERT INTO `coffeeshop`.`order_has_items` (`Order_orderID`, `Items_itemID`, `itemQuantity`) VALUES ('O1004', 'I001', '1');
INSERT INTO `coffeeshop`.`order_has_items` (`Order_orderID`, `Items_itemID`, `itemQuantity`) VALUES ('O1004', 'I014', '1');
INSERT INTO `coffeeshop`.`order_has_items` (`Order_orderID`, `Items_itemID`, `itemQuantity`) VALUES ('O1004', 'I011', '1');
INSERT INTO `coffeeshop`.`order_has_items` (`Order_orderID`, `Items_itemID`, `itemQuantity`) VALUES ('O1005', 'I010', '1');
INSERT INTO `coffeeshop`.`order_has_items` (`Order_orderID`, `Items_itemID`, `itemQuantity`) VALUES ('O1005', 'I012', '1');
INSERT INTO `coffeeshop`.`order_has_items` (`Order_orderID`, `Items_itemID`, `itemQuantity`) VALUES ('O1006', 'I002', '1');
INSERT INTO `coffeeshop`.`order_has_items` (`Order_orderID`, `Items_itemID`, `itemQuantity`) VALUES ('O1007', 'I005', '2');
INSERT INTO `coffeeshop`.`order_has_items` (`Order_orderID`, `Items_itemID`, `itemQuantity`) VALUES ('O1007', 'I007', '2');
INSERT INTO `coffeeshop`.`order_has_items` (`Order_orderID`, `Items_itemID`, `itemQuantity`) VALUES ('O1007', 'I004', '1');
INSERT INTO `coffeeshop`.`order_has_items` (`Order_orderID`, `Items_itemID`, `itemQuantity`) VALUES ('O1008', 'I009', '1');
INSERT INTO `coffeeshop`.`order_has_items` (`Order_orderID`, `Items_itemID`, `itemQuantity`) VALUES ('O1008', 'I010', '1');
INSERT INTO `coffeeshop`.`order_has_items` (`Order_orderID`, `Items_itemID`, `itemQuantity`) VALUES ('O1009', 'I003', '2');
INSERT INTO `coffeeshop`.`order_has_items` (`Order_orderID`, `Items_itemID`, `itemQuantity`) VALUES ('O1010', 'I001', '2');
INSERT INTO `coffeeshop`.`order_has_items` (`Order_orderID`, `Items_itemID`, `itemQuantity`) VALUES ('O1010', 'I006', '1');
INSERT INTO `coffeeshop`.`order_has_items` (`Order_orderID`, `Items_itemID`, `itemQuantity`) VALUES ('O1010', 'I002', '1');

----Staff Table----

--there are some changes. Please delete the staff table which was created before
--and add the this new one so the code can be united
---- Table `coffeeShop`.`Staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `coffeeShop`.`Staff` (
  `staffID` VARCHAR(10) NOT NULL,
  `firstName` VARCHAR(40) NOT NULL,
  `lastName` VARCHAR(40) NOT NULL,
  `phone` VARCHAR(10) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `DOB` DATE NOT NULL,
  `positionTitle` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`staffID`),
  UNIQUE INDEX `DOB_UNIQUE` (`DOB` ASC) VISIBLE,
  UNIQUE INDEX `phone_UNIQUE` (`phone` ASC) VISIBLE)
ENGINE = InnoDB;

--then do this--

INSERT INTO `coffeeshop`.`staff` (`staffID`, `firstName`, `lastName`, `phone`, `email`, `DOB`, `positionTitle`) VALUES ('S001', 'Linh', 'Nguyen', '8322310315', 'nguyenl190@gator.uhd.edu', '1998-07-23', 'Manager');
INSERT INTO `coffeeshop`.`staff` (`staffID`, `firstName`, `lastName`, `phone`, `email`, `DOB`, `positionTitle`) VALUES ('S002', 'Young', 'Bryce', '7131234567', 'bryce.young@gmail.com', '2000-05-01', 'Barista');
INSERT INTO `coffeeshop`.`staff` (`staffID`, `firstName`, `lastName`, `phone`, `email`, `DOB`, `positionTitle`) VALUES ('S003', 'CJ', 'Stroud', '2811234567', 'cj.stroud@gmail.com', '2000-04-27', 'Barista');
INSERT INTO `coffeeshop`.`staff` (`staffID`, `firstName`, `lastName`, `phone`, `email`, `DOB`, `positionTitle`) VALUES ('S004', 'Emperor', 'Palpatine', '8321234567', 'emperorpalpatine@gmail.com', '1950-01-01', 'Manager');
INSERT INTO `coffeeshop`.`staff` (`staffID`, `firstName`, `lastName`, `phone`, `email`, `DOB`, `positionTitle`) VALUES ('S005', 'Darth', 'Vader', '3461234567', 'darth.vader@gmail.com', '1975-01-01', 'Barista');
INSERT INTO `coffeeshop`.`staff` (`staffID`, `firstName`, `lastName`, `phone`, `email`, `DOB`, `positionTitle`) VALUES ('S006', 'Darth', 'Maul', '5121234567', 'darth.maul@gmail.com', '1950-01-08', 'Barista');
INSERT INTO `coffeeshop`.`staff` (`staffID`, `firstName`, `lastName`, `phone`, `email`, `DOB`, `positionTitle`) VALUES ('S007', 'Ime', 'Udoka', '7132345678', 'ime.udoka@gmail.com', '1980-05-07', 'Manager');
INSERT INTO `coffeeshop`.`staff` (`staffID`, `firstName`, `lastName`, `phone`, `email`, `DOB`, `positionTitle`) VALUES ('S008', 'Jalen', 'Green', '2812345678', 'jalen.green@gmail.com', '2002-07-04', 'Barista');
INSERT INTO `coffeeshop`.`staff` (`staffID`, `firstName`, `lastName`, `phone`, `email`, `DOB`, `positionTitle`) VALUES ('S009', 'Jabari', 'Smith', '8322345678', 'jabari.smith@gmail.com', '2003-06-08', 'Barista');
INSERT INTO `coffeeshop`.`staff` (`staffID`, `firstName`, `lastName`, `phone`, `email`, `DOB`, `positionTitle`) VALUES ('S010', 'Lebron', 'James', '3462345678', 'lebron.james@gmail.com', '1980-06-30', 'Manager');
INSERT INTO `coffeeshop`.`staff` (`staffID`, `firstName`, `lastName`, `phone`, `email`, `DOB`, `positionTitle`) VALUES ('S011', 'Anthony', 'Davis', '5122345678', 'anthony.davis@gmail.com', '1988-08-16', 'Barista');
INSERT INTO `coffeeshop`.`staff` (`staffID`, `firstName`, `lastName`, `phone`, `email`, `DOB`, `positionTitle`) VALUES ('S012', 'Russell', 'Westbrook', '7133456789', 'russell.westbrook@gmail.com', '1985-07-24', 'Barista');
INSERT INTO `coffeeshop`.`staff` (`staffID`, `firstName`, `lastName`, `phone`, `email`, `DOB`, `positionTitle`) VALUES ('S013', 'Michael', 'Scott', '2813456789', 'michael.scott@gmail.com', '1970-08-17', 'Manager');
INSERT INTO `coffeeshop`.`staff` (`staffID`, `firstName`, `lastName`, `phone`, `email`, `DOB`, `positionTitle`) VALUES ('S014', 'Jim', 'Halpert', '8323456789', 'jim.halpert@gmail.com', '1986-04-05', 'Barista');
INSERT INTO `coffeeshop`.`staff` (`staffID`, `firstName`, `lastName`, `phone`, `email`, `DOB`, `positionTitle`) VALUES ('S015', 'Dwight', 'Schrute', '3463456789', 'dwight.schrute@gmail.com', '1986-12-05', 'Barista');
INSERT INTO `coffeeshop`.`staff` (`staffID`, `firstName`, `lastName`, `phone`, `email`, `DOB`, `positionTitle`) VALUES ('S016', 'Lupita', 'Thornton', '8323930001', 'lupita.thornton@gmail.com', '1969-03-12', 'Manager');
INSERT INTO `coffeeshop`.`staff` (`staffID`, `firstName`, `lastName`, `phone`, `email`, `DOB`, `positionTitle`) VALUES ('S017', 'Maria', 'Hernandez', '8323930002', 'maria.hernandez@gmail.com', '1985-05-30', 'Barista');
INSERT INTO `coffeeshop`.`staff` (`staffID`, `firstName`, `lastName`, `phone`, `email`, `DOB`, `positionTitle`) VALUES ('S018', 'Michael', 'Do', '8323930003', 'michael.do@gmail.com', '1992-01-12', 'Barista');

---then add this code---
alter table staff
add branchID varchar(10);

alter table staff
add foreign key (branchID) references branch(branchID);

---then do this last part for staff table---
UPDATE `coffeeshop`.`staff` SET `branchID` = 'B001' WHERE (`staffID` = 'S001');
UPDATE `coffeeshop`.`staff` SET `branchID` = 'B001' WHERE (`staffID` = 'S002');
UPDATE `coffeeshop`.`staff` SET `branchID` = 'B001' WHERE (`staffID` = 'S003');
UPDATE `coffeeshop`.`staff` SET `branchID` = 'B002' WHERE (`staffID` = 'S004');
UPDATE `coffeeshop`.`staff` SET `branchID` = 'B002' WHERE (`staffID` = 'S005');
UPDATE `coffeeshop`.`staff` SET `branchID` = 'B002' WHERE (`staffID` = 'S006');
UPDATE `coffeeshop`.`staff` SET `branchID` = 'B003' WHERE (`staffID` = 'S007');
UPDATE `coffeeshop`.`staff` SET `branchID` = 'B003' WHERE (`staffID` = 'S008');
UPDATE `coffeeshop`.`staff` SET `branchID` = 'B003' WHERE (`staffID` = 'S009');
UPDATE `coffeeshop`.`staff` SET `branchID` = 'B004' WHERE (`staffID` = 'S010');
UPDATE `coffeeshop`.`staff` SET `branchID` = 'B004' WHERE (`staffID` = 'S011');
UPDATE `coffeeshop`.`staff` SET `branchID` = 'B004' WHERE (`staffID` = 'S012');
UPDATE `coffeeshop`.`staff` SET `branchID` = 'B005' WHERE (`staffID` = 'S013');
UPDATE `coffeeshop`.`staff` SET `branchID` = 'B005' WHERE (`staffID` = 'S014');
UPDATE `coffeeshop`.`staff` SET `branchID` = 'B005' WHERE (`staffID` = 'S015');
DELETE FROM `coffeeshop`.`staff` WHERE (`staffID` = 'S016');
DELETE FROM `coffeeshop`.`staff` WHERE (`staffID` = 'S017');
DELETE FROM `coffeeshop`.`staff` WHERE (`staffID` = 'S018');
