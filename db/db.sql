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
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`parts543`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`parts543` (
    `partNo543` VARCHAR(5) NOT NULL,
    `partName543` VARCHAR(20) NOT NULL,
    `partDescription543` VARCHAR(45) NULL,
    `currentPrice543` DOUBLE NOT NULL,
    `QoH543` INT NOT NULL,
    PRIMARY KEY (`partNo543`),
    UNIQUE INDEX `partNo_UNIQUE` (`partNo543` ASC) )
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`clients543`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`clients543` (
    `clientId543` VARCHAR(5) NOT NULL,
    `clientName543` VARCHAR(45) NOT NULL,
    `clientCity543` VARCHAR(45) NOT NULL,
    `clientCompPassword543` VARCHAR(45) NOT NULL,
    `moneyOwed543` DOUBLE NULL,
    `clientStatus543` VARCHAR(45) NULL,
    PRIMARY KEY (`clientId543`))
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`pos543`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`pos543` (
    `poNo543` VARCHAR(5) NOT NULL,
    `dataPO543` DATETIME NOT NULL,
    `status543` VARCHAR(45) NOT NULL,
    `clientId543` VARCHAR(5) NOT NULL,
    PRIMARY KEY (`poNo543`),
    INDEX `fk_pos543_clients5431_idx` (`clientId543` ASC) ,
    CONSTRAINT `fk_pos543_clients5431`
    FOREIGN KEY (`clientId543`)
    REFERENCES `mydb`.`clients543` (`clientId543`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`lines543`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`lines543` (
    `partNo543` VARCHAR(5) NOT NULL,
    `lineNum543` VARCHAR(5) NOT NULL,
    `poNo543` VARCHAR(5) NOT NULL,
    `price543` DOUBLE NULL,
    `quantity543` INT NULL,
    INDEX `fk_lines_parts5431_idx` (`partNo543` ASC) ,
    PRIMARY KEY (`lineNum543`, `poNo543`),
    INDEX `fk_lines_pos5431_idx` (`poNo543` ASC) ,
    CONSTRAINT `fk_lines_parts5431`
    FOREIGN KEY (`partNo543`)
    REFERENCES `mydb`.`parts543` (`partNo543`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CONSTRAINT `fk_lines_pos5431`
    FOREIGN KEY (`poNo543`)
    REFERENCES `mydb`.`pos543` (`poNo543`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
    ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

USE mydb;
-- procedure
DELIMITER $$
CREATE PROCEDURE GetPrice( IN PartNo  varchar(30), INOUT Price double )
BEGIN

    set Price = (SELECT currentPrice543 FROM parts543 WHERE partNo543 = PartNo);

END;
$$


-- trigger

delimiter $$
CREATE TRIGGER MoneyOwed
    BEFORE INSERT ON  lines543
    FOR EACH ROW
BEGIN
    CALL GetPrice( NEW.partNo543, NEW.price543);


    UPDATE clients543
    SET moneyOwed543 = moneyOwed543 + ( NEW.price543 * NEW.quantity543)
    WHERE clientId543 = (SELECT clientId543 FROM pos543 WHERE poNo543 = NEW.poNo543);
END;
    $$


