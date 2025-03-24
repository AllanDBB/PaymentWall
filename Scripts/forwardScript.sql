-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema PaymentWallDB
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `PaymentWallDB` ;

-- -----------------------------------------------------
-- Schema PaymentWallDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `PaymentWallDB` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `PaymentWallDB` ;

-- -----------------------------------------------------
-- Table `PaymentWallDB`.`PW_company`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PaymentWallDB`.`PW_company` ;

CREATE TABLE IF NOT EXISTS `PaymentWallDB`.`PW_company` (
  `companyId` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `type` VARCHAR(45) NULL,
  PRIMARY KEY (`companyId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentWallDB`.`PW_users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PaymentWallDB`.`PW_users` ;

CREATE TABLE IF NOT EXISTS `PaymentWallDB`.`PW_users` (
  `userId` INT NOT NULL AUTO_INCREMENT,
  `firstName` VARCHAR(100) NOT NULL,
  `lastName` VARCHAR(100) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `createdAt` TIMESTAMP NOT NULL,
  `updatedAt` TIMESTAMP NOT NULL,
  `PW_company_companyId` INT NULL,
  PRIMARY KEY (`userId`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  INDEX `fk_PW_users_PW_company1_idx` (`PW_company_companyId` ASC) VISIBLE,
  CONSTRAINT `fk_PW_users_PW_company1`
    FOREIGN KEY (`PW_company_companyId`)
    REFERENCES `PaymentWallDB`.`PW_company` (`companyId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `PaymentWallDB`.`PW_roles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PaymentWallDB`.`PW_roles` ;

CREATE TABLE IF NOT EXISTS `PaymentWallDB`.`PW_roles` (
  `roleId` INT NOT NULL AUTO_INCREMENT,
  `roleName` VARCHAR(50) NOT NULL,
  `roleDescription` TEXT NULL,
  PRIMARY KEY (`roleId`),
  UNIQUE INDEX `roleName_UNIQUE` (`roleName` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentWallDB`.`PW_modules`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PaymentWallDB`.`PW_modules` ;

CREATE TABLE IF NOT EXISTS `PaymentWallDB`.`PW_modules` (
  `moduleId` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  UNIQUE INDEX `idPW_modules_UNIQUE` (`moduleId` ASC) VISIBLE,
  PRIMARY KEY (`moduleId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentWallDB`.`PW_permissions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PaymentWallDB`.`PW_permissions` ;

CREATE TABLE IF NOT EXISTS `PaymentWallDB`.`PW_permissions` (
  `permissionId` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NULL,
  `description` VARCHAR(60) NOT NULL,
  `code` VARCHAR(10) NOT NULL,
  `createdAt` TIMESTAMP NULL,
  `updatedAt` TIMESTAMP NULL,
  `moduleId` INT NOT NULL,
  `htmlObject` VARCHAR(600) NULL,
  PRIMARY KEY (`permissionId`),
  UNIQUE INDEX `code_UNIQUE` (`code` ASC) VISIBLE,
  INDEX `fk_PW_permissions_PW_modules_idx` (`moduleId` ASC) VISIBLE,
  CONSTRAINT `fk_PW_permissions_PW_modules`
    FOREIGN KEY (`moduleId`)
    REFERENCES `PaymentWallDB`.`PW_modules` (`moduleId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentWallDB`.`PW_rolePermissions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PaymentWallDB`.`PW_rolePermissions` ;

CREATE TABLE IF NOT EXISTS `PaymentWallDB`.`PW_rolePermissions` (
  `rolePermissionId` INT NOT NULL,
  `enabled` TINYINT NOT NULL,
  `deleted` TINYINT NOT NULL,
  `lastUpdate` DATETIME NULL,
  `userName` VARCHAR(50) NOT NULL,
  `checksum` VARBINARY(250) NOT NULL,
  `permissionId` INT NOT NULL,
  `roleId` INT NOT NULL,
  PRIMARY KEY (`rolePermissionId`),
  UNIQUE INDEX `idPW_rolePermissions_UNIQUE` (`rolePermissionId` ASC) VISIBLE,
  INDEX `fk_PW_rolePermissions_PW_permissions1_idx` (`permissionId` ASC) VISIBLE,
  INDEX `fk_PW_rolePermissions_PW_roles1_idx` (`roleId` ASC) VISIBLE,
  CONSTRAINT `fk_PW_rolePermissions_PW_permissions1`
    FOREIGN KEY (`permissionId`)
    REFERENCES `PaymentWallDB`.`PW_permissions` (`permissionId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PW_rolePermissions_PW_roles1`
    FOREIGN KEY (`roleId`)
    REFERENCES `PaymentWallDB`.`PW_roles` (`roleId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentWallDB`.`PW_userPermissions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PaymentWallDB`.`PW_userPermissions` ;

CREATE TABLE IF NOT EXISTS `PaymentWallDB`.`PW_userPermissions` (
  `userPermissionsId` INT NOT NULL,
  `enabled` TINYINT NOT NULL,
  `deleted` TINYINT NOT NULL,
  `lastUpdate` DATETIME NOT NULL,
  `userName` VARCHAR(50) NOT NULL,
  `checksum` VARBINARY(250) NOT NULL,
  `permissionId` INT NOT NULL,
  `userId` INT NOT NULL,
  PRIMARY KEY (`userPermissionsId`),
  UNIQUE INDEX `userPermissionsId_UNIQUE` (`userPermissionsId` ASC) VISIBLE,
  INDEX `fk_PW_userPermissions_PW_permissions1_idx` (`permissionId` ASC) VISIBLE,
  INDEX `fk_PW_userPermissions_PW_users1_idx` (`userId` ASC) VISIBLE,
  CONSTRAINT `fk_PW_userPermissions_PW_permissions1`
    FOREIGN KEY (`permissionId`)
    REFERENCES `PaymentWallDB`.`PW_permissions` (`permissionId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PW_userPermissions_PW_users1`
    FOREIGN KEY (`userId`)
    REFERENCES `PaymentWallDB`.`PW_users` (`userId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentWallDB`.`PW_userRoles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PaymentWallDB`.`PW_userRoles` ;

CREATE TABLE IF NOT EXISTS `PaymentWallDB`.`PW_userRoles` (
  `roleId` INT NOT NULL,
  `userId` INT NOT NULL,
  `lastUpdated` DATETIME NOT NULL,
  `userName` VARCHAR(50) NOT NULL,
  `checksum` VARBINARY(250) NOT NULL,
  `enabled` TINYINT NOT NULL,
  `deleted` TINYINT NOT NULL,
  INDEX `fk_PW_userRoles_PW_roles1_idx` (`roleId` ASC) VISIBLE,
  INDEX `fk_PW_userRoles_PW_users1_idx` (`userId` ASC) VISIBLE,
  CONSTRAINT `fk_PW_userRoles_PW_roles1`
    FOREIGN KEY (`roleId`)
    REFERENCES `PaymentWallDB`.`PW_roles` (`roleId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PW_userRoles_PW_users1`
    FOREIGN KEY (`userId`)
    REFERENCES `PaymentWallDB`.`PW_users` (`userId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentWallDB`.`PW_countries`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PaymentWallDB`.`PW_countries` ;

CREATE TABLE IF NOT EXISTS `PaymentWallDB`.`PW_countries` (
  `countryId` INT NOT NULL,
  `name` VARCHAR(75) NOT NULL,
  `isoCode` CHAR(10) NOT NULL,
  `phoneCode` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`countryId`),
  UNIQUE INDEX `countryId_UNIQUE` (`countryId` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentWallDB`.`PW_states`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PaymentWallDB`.`PW_states` ;

CREATE TABLE IF NOT EXISTS `PaymentWallDB`.`PW_states` (
  `stateId` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `countryId` INT NOT NULL,
  PRIMARY KEY (`stateId`),
  INDEX `fk_PW_states_PW_countries1_idx` (`countryId` ASC) VISIBLE,
  CONSTRAINT `fk_PW_states_PW_countries1`
    FOREIGN KEY (`countryId`)
    REFERENCES `PaymentWallDB`.`PW_countries` (`countryId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentWallDB`.`PW_cities`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PaymentWallDB`.`PW_cities` ;

CREATE TABLE IF NOT EXISTS `PaymentWallDB`.`PW_cities` (
  `cityId` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `stateId` INT NOT NULL,
  PRIMARY KEY (`cityId`),
  INDEX `fk_PW_cities_PW_states1_idx` (`stateId` ASC) VISIBLE,
  CONSTRAINT `fk_PW_cities_PW_states1`
    FOREIGN KEY (`stateId`)
    REFERENCES `PaymentWallDB`.`PW_states` (`stateId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentWallDB`.`PW_address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PaymentWallDB`.`PW_address` ;

CREATE TABLE IF NOT EXISTS `PaymentWallDB`.`PW_address` (
  `addressId` INT NOT NULL AUTO_INCREMENT,
  `street` VARCHAR(255) NOT NULL,
  `number` VARCHAR(10) NULL,
  `zipcode` VARCHAR(20) NOT NULL,
  `line1` VARCHAR(200) NULL,
  `line2` VARCHAR(200) NULL,
  `cityId` INT NOT NULL,
  `geoSpatial` POINT NULL,
  PRIMARY KEY (`addressId`),
  INDEX `fk_PW_address_PW_cities1_idx` (`cityId` ASC) VISIBLE,
  CONSTRAINT `fk_PW_address_PW_cities1`
    FOREIGN KEY (`cityId`)
    REFERENCES `PaymentWallDB`.`PW_cities` (`cityId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentWallDB`.`PW_userAddress`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PaymentWallDB`.`PW_userAddress` ;

CREATE TABLE IF NOT EXISTS `PaymentWallDB`.`PW_userAddress` (
  `userAddressId` INT NOT NULL AUTO_INCREMENT,
  `addressId` INT NOT NULL,
  `userId` INT NOT NULL,
  PRIMARY KEY (`userAddressId`),
  INDEX `fk_PW_userAddress_PW_address1_idx` (`addressId` ASC) VISIBLE,
  INDEX `fk_PW_userAddress_PW_users1_idx` (`userId` ASC) VISIBLE,
  CONSTRAINT `fk_PW_userAddress_PW_address1`
    FOREIGN KEY (`addressId`)
    REFERENCES `PaymentWallDB`.`PW_address` (`addressId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PW_userAddress_PW_users1`
    FOREIGN KEY (`userId`)
    REFERENCES `PaymentWallDB`.`PW_users` (`userId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentWallDB`.`PW_contactType`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PaymentWallDB`.`PW_contactType` ;

CREATE TABLE IF NOT EXISTS `PaymentWallDB`.`PW_contactType` (
  `contactTypeId` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `format` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`contactTypeId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentWallDB`.`PW_contactInfo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PaymentWallDB`.`PW_contactInfo` ;

CREATE TABLE IF NOT EXISTS `PaymentWallDB`.`PW_contactInfo` (
  `contactInfoId` INT NOT NULL,
  `contactTypeId` INT NOT NULL,
  `value` VARCHAR(255) NULL,
  `isPrimary` TINYINT NULL,
  `verifiedAt` TIMESTAMP NULL,
  `updatedAt` TIMESTAMP NULL,
  PRIMARY KEY (`contactInfoId`),
  INDEX `fk_PW_contactInfo_PW_contactType1_idx` (`contactTypeId` ASC) VISIBLE,
  CONSTRAINT `fk_PW_contactInfo_PW_contactType1`
    FOREIGN KEY (`contactTypeId`)
    REFERENCES `PaymentWallDB`.`PW_contactType` (`contactTypeId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentWallDB`.`PW_userContact`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PaymentWallDB`.`PW_userContact` ;

CREATE TABLE IF NOT EXISTS `PaymentWallDB`.`PW_userContact` (
  `userContactId` INT NOT NULL,
  `contactInfoId` INT NOT NULL,
  `userId` INT NOT NULL,
  PRIMARY KEY (`userContactId`),
  INDEX `fk_PW_userContact_PW_contactInfo1_idx` (`contactInfoId` ASC) VISIBLE,
  INDEX `fk_PW_userContact_PW_users1_idx` (`userId` ASC) VISIBLE,
  CONSTRAINT `fk_PW_userContact_PW_contactInfo1`
    FOREIGN KEY (`contactInfoId`)
    REFERENCES `PaymentWallDB`.`PW_contactInfo` (`contactInfoId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PW_userContact_PW_users1`
    FOREIGN KEY (`userId`)
    REFERENCES `PaymentWallDB`.`PW_users` (`userId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentWallDB`.`PW_companyAddress`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PaymentWallDB`.`PW_companyAddress` ;

CREATE TABLE IF NOT EXISTS `PaymentWallDB`.`PW_companyAddress` (
  `companyAddressId` INT NOT NULL,
  `companyId` INT NOT NULL,
  `addressId` INT NOT NULL,
  PRIMARY KEY (`companyAddressId`),
  INDEX `fk_PW_companyAddress_PW_company1_idx` (`companyId` ASC) VISIBLE,
  INDEX `fk_PW_companyAddress_PW_address1_idx` (`addressId` ASC) VISIBLE,
  CONSTRAINT `fk_PW_companyAddress_PW_company1`
    FOREIGN KEY (`companyId`)
    REFERENCES `PaymentWallDB`.`PW_company` (`companyId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PW_companyAddress_PW_address1`
    FOREIGN KEY (`addressId`)
    REFERENCES `PaymentWallDB`.`PW_address` (`addressId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentWallDB`.`PW_companyContact`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PaymentWallDB`.`PW_companyContact` ;

CREATE TABLE IF NOT EXISTS `PaymentWallDB`.`PW_companyContact` (
  `companyContactId` INT NOT NULL,
  `contactInfoId` INT NOT NULL,
  `companyId` INT NOT NULL,
  PRIMARY KEY (`companyContactId`),
  INDEX `fk_PW_companyContact_PW_contactInfo1_idx` (`contactInfoId` ASC) VISIBLE,
  INDEX `fk_PW_companyContact_PW_company1_idx` (`companyId` ASC) VISIBLE,
  CONSTRAINT `fk_PW_companyContact_PW_contactInfo1`
    FOREIGN KEY (`contactInfoId`)
    REFERENCES `PaymentWallDB`.`PW_contactInfo` (`contactInfoId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PW_companyContact_PW_company1`
    FOREIGN KEY (`companyId`)
    REFERENCES `PaymentWallDB`.`PW_company` (`companyId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentWallDB`.`PW_mediaTypes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PaymentWallDB`.`PW_mediaTypes` ;

CREATE TABLE IF NOT EXISTS `PaymentWallDB`.`PW_mediaTypes` (
  `mediaTypeId` INT NOT NULL,
  `name` VARCHAR(30) NULL,
  `playerimpl` VARCHAR(100) NULL,
  PRIMARY KEY (`mediaTypeId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentWallDB`.`PW_mediafiles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PaymentWallDB`.`PW_mediafiles` ;

CREATE TABLE IF NOT EXISTS `PaymentWallDB`.`PW_mediafiles` (
  `mediafileId` INT NOT NULL AUTO_INCREMENT,
  `filename` VARCHAR(255) NULL,
  `fileUrl` VARCHAR(500) NOT NULL,
  `fileSizeMB` INT NOT NULL,
  `deleted` TINYINT NOT NULL,
  `createdAt` TIMESTAMP NULL,
  `updatedAt` DATETIME NULL,
  `mediaTypeId` INT NOT NULL,
  PRIMARY KEY (`mediafileId`),
  INDEX `fk_PW_mediafiles_PW_mediaTypes1_idx` (`mediaTypeId` ASC) VISIBLE,
  CONSTRAINT `fk_PW_mediafiles_PW_mediaTypes1`
    FOREIGN KEY (`mediaTypeId`)
    REFERENCES `PaymentWallDB`.`PW_mediaTypes` (`mediaTypeId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentWallDB`.`PW_thirdPartyAuth`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PaymentWallDB`.`PW_thirdPartyAuth` ;

CREATE TABLE IF NOT EXISTS `PaymentWallDB`.`PW_thirdPartyAuth` (
  `idPW_thirdPartyAuth` INT NOT NULL,
  `name` VARCHAR(25) NOT NULL,
  `secretKey` VARBINARY(255) NOT NULL,
  `publicKey` VARBINARY(255) NOT NULL,
  `iconURL` VARCHAR(200) NULL,
  PRIMARY KEY (`idPW_thirdPartyAuth`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentWallDB`.`PW_authSession`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PaymentWallDB`.`PW_authSession` ;

CREATE TABLE IF NOT EXISTS `PaymentWallDB`.`PW_authSession` (
  `authSessionId` INT NOT NULL,
  `sessionId` VARBINARY(16) NOT NULL,
  `externalUser` VARBINARY(16) NOT NULL,
  `token` VARBINARY(128) NOT NULL,
  `refreshToken` VARBINARY(128) NOT NULL,
  `thirdPartyAuth` INT NOT NULL,
  `userId` INT NOT NULL,
  PRIMARY KEY (`authSessionId`),
  INDEX `fk_PW_authSession_PW_thirdPartyAuth1_idx` (`thirdPartyAuth` ASC) VISIBLE,
  INDEX `fk_PW_authSession_PW_users1_idx` (`userId` ASC) VISIBLE,
  CONSTRAINT `fk_PW_authSession_PW_thirdPartyAuth1`
    FOREIGN KEY (`thirdPartyAuth`)
    REFERENCES `PaymentWallDB`.`PW_thirdPartyAuth` (`idPW_thirdPartyAuth`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PW_authSession_PW_users1`
    FOREIGN KEY (`userId`)
    REFERENCES `PaymentWallDB`.`PW_users` (`userId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentWallDB`.`PW_userMedia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PaymentWallDB`.`PW_userMedia` ;

CREATE TABLE IF NOT EXISTS `PaymentWallDB`.`PW_userMedia` (
  `userMediaId` INT NOT NULL,
  `mediafileId` INT NOT NULL,
  `userId` INT NOT NULL,
  PRIMARY KEY (`userMediaId`),
  INDEX `fk_PW_userMedia_PW_mediafiles1_idx` (`mediafileId` ASC) VISIBLE,
  INDEX `fk_PW_userMedia_PW_users1_idx` (`userId` ASC) VISIBLE,
  CONSTRAINT `fk_PW_userMedia_PW_mediafiles1`
    FOREIGN KEY (`mediafileId`)
    REFERENCES `PaymentWallDB`.`PW_mediafiles` (`mediafileId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PW_userMedia_PW_users1`
    FOREIGN KEY (`userId`)
    REFERENCES `PaymentWallDB`.`PW_users` (`userId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentWallDB`.`PW_transTypes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PaymentWallDB`.`PW_transTypes` ;

CREATE TABLE IF NOT EXISTS `PaymentWallDB`.`PW_transTypes` (
  `transTypesId` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`transTypesId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentWallDB`.`PW_transSubTypes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PaymentWallDB`.`PW_transSubTypes` ;

CREATE TABLE IF NOT EXISTS `PaymentWallDB`.`PW_transSubTypes` (
  `subTypeId` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`subTypeId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentWallDB`.`PW_paymentMethods`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PaymentWallDB`.`PW_paymentMethods` ;

CREATE TABLE IF NOT EXISTS `PaymentWallDB`.`PW_paymentMethods` (
  `paymentMethodId` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `apiURL` VARCHAR(300) NOT NULL,
  `secretkey` VARBINARY(128) NOT NULL,
  `key` VARBINARY(128) NOT NULL,
  `logoIconUrl` VARCHAR(300) NULL,
  `enabled` BIT NOT NULL,
  PRIMARY KEY (`paymentMethodId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentWallDB`.`PW_availableMethods`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PaymentWallDB`.`PW_availableMethods` ;

CREATE TABLE IF NOT EXISTS `PaymentWallDB`.`PW_availableMethods` (
  `availableMethodsId` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `token` VARBINARY(128) NOT NULL,
  `expirationTokenDate` DATETIME NOT NULL,
  `maskaccount` VARCHAR(20) NOT NULL,
  `paymentMethodId` INT NOT NULL,
  `userId` INT NOT NULL,
  PRIMARY KEY (`availableMethodsId`),
  INDEX `fk_PW_availableMethods_PW_paymentMethods1_idx` (`paymentMethodId` ASC) VISIBLE,
  INDEX `fk_PW_availableMethods_PW_users1_idx` (`userId` ASC) VISIBLE,
  CONSTRAINT `fk_PW_availableMethods_PW_paymentMethods1`
    FOREIGN KEY (`paymentMethodId`)
    REFERENCES `PaymentWallDB`.`PW_paymentMethods` (`paymentMethodId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PW_availableMethods_PW_users1`
    FOREIGN KEY (`userId`)
    REFERENCES `PaymentWallDB`.`PW_users` (`userId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentWallDB`.`PW_Payments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PaymentWallDB`.`PW_Payments` ;

CREATE TABLE IF NOT EXISTS `PaymentWallDB`.`PW_Payments` (
  `paymentId` INT NOT NULL AUTO_INCREMENT,
  `amount` BIGINT NOT NULL,
  `actualAmount` BIGINT NOT NULL,
  `result` TINYINT NOT NULL,
  `reference` VARCHAR(100) NOT NULL,
  `auth` VARCHAR(60) NOT NULL,
  `chargetoken` VARBINARY(128) NOT NULL,
  `description` VARCHAR(120) NULL,
  `error` VARCHAR(120) NULL,
  `date` DATETIME NOT NULL,
  `checksum` VARBINARY(250) NOT NULL,
  `userId` INT NOT NULL,
  `paymentMethodId` INT NOT NULL,
  `availableMethodsId` INT NOT NULL,
  `moduleId` INT NOT NULL,
  PRIMARY KEY (`paymentId`),
  INDEX `fk_PW_Payments_PW_users1_idx` (`userId` ASC) VISIBLE,
  INDEX `fk_PW_Payments_PW_paymentMethods1_idx` (`paymentMethodId` ASC) VISIBLE,
  INDEX `fk_PW_Payments_PW_availableMethods1_idx` (`availableMethodsId` ASC) VISIBLE,
  INDEX `fk_PW_Payments_PW_modules1_idx` (`moduleId` ASC) VISIBLE,
  CONSTRAINT `fk_PW_Payments_PW_users1`
    FOREIGN KEY (`userId`)
    REFERENCES `PaymentWallDB`.`PW_users` (`userId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PW_Payments_PW_paymentMethods1`
    FOREIGN KEY (`paymentMethodId`)
    REFERENCES `PaymentWallDB`.`PW_paymentMethods` (`paymentMethodId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PW_Payments_PW_availableMethods1`
    FOREIGN KEY (`availableMethodsId`)
    REFERENCES `PaymentWallDB`.`PW_availableMethods` (`availableMethodsId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PW_Payments_PW_modules1`
    FOREIGN KEY (`moduleId`)
    REFERENCES `PaymentWallDB`.`PW_modules` (`moduleId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentWallDB`.`PW_currency`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PaymentWallDB`.`PW_currency` ;

CREATE TABLE IF NOT EXISTS `PaymentWallDB`.`PW_currency` (
  `currencyId` INT NOT NULL AUTO_INCREMENT,
  `name` INT NOT NULL,
  `acronym` VARCHAR(5) NOT NULL,
  `symbol` VARCHAR(2) NOT NULL,
  `countryId` INT NOT NULL,
  PRIMARY KEY (`currencyId`),
  INDEX `fk_PW_currency_PW_countries1_idx` (`countryId` ASC) VISIBLE,
  CONSTRAINT `fk_PW_currency_PW_countries1`
    FOREIGN KEY (`countryId`)
    REFERENCES `PaymentWallDB`.`PW_countries` (`countryId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentWallDB`.`PW_exchangeRate`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PaymentWallDB`.`PW_exchangeRate` ;

CREATE TABLE IF NOT EXISTS `PaymentWallDB`.`PW_exchangeRate` (
  `exchangeRateId` INT NOT NULL AUTO_INCREMENT,
  `startDate` DATETIME NULL,
  `changeDate` DATETIME NOT NULL,
  `PW_exchangeRatecol` VARCHAR(45) NOT NULL,
  `enabled` TINYINT NULL,
  `currentChange` TINYINT NULL,
  `baseCurrencyId` INT NOT NULL,
  `conversionCurrencyId` INT NOT NULL,
  PRIMARY KEY (`exchangeRateId`),
  INDEX `fk_PW_exchangeRate_PW_currency1_idx` (`baseCurrencyId` ASC) VISIBLE,
  INDEX `fk_PW_exchangeRate_PW_currency2_idx` (`conversionCurrencyId` ASC) VISIBLE,
  CONSTRAINT `fk_PW_exchangeRate_PW_currency1`
    FOREIGN KEY (`baseCurrencyId`)
    REFERENCES `PaymentWallDB`.`PW_currency` (`currencyId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PW_exchangeRate_PW_currency2`
    FOREIGN KEY (`conversionCurrencyId`)
    REFERENCES `PaymentWallDB`.`PW_currency` (`currencyId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentWallDB`.`PW_transactions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PaymentWallDB`.`PW_transactions` ;

CREATE TABLE IF NOT EXISTS `PaymentWallDB`.`PW_transactions` (
  `transactionId` INT NOT NULL AUTO_INCREMENT,
  `amount` BIGINT NOT NULL,
  `description` TEXT NOT NULL,
  `date` DATETIME NOT NULL,
  `postTime` DATETIME NOT NULL,
  `reference1` BIGINT NULL,
  `reference2` BIGINT NULL,
  `value1` VARCHAR(100) NULL,
  `value2` VARCHAR(100) NULL,
  `processManagerId` INT NOT NULL,
  `convertedAmount` BIGINT NOT NULL,
  `checksum` VARBINARY(250) NOT NULL,
  `transTypesId` INT NOT NULL,
  `transSubTypeId` INT NOT NULL,
  `paymentId` INT NOT NULL,
  `currencyId` INT NOT NULL,
  `exchangeRateId` INT NOT NULL,
  `BankID` INT NOT NULL,
  PRIMARY KEY (`transactionId`),
  INDEX `fk_PW_transactions_PW_transTypes1_idx` (`transTypesId` ASC) VISIBLE,
  INDEX `fk_PW_transactions_PW_subTypes1_idx` (`transSubTypeId` ASC) VISIBLE,
  INDEX `fk_PW_transactions_PW_Payments1_idx` (`paymentId` ASC) VISIBLE,
  INDEX `fk_PW_transactions_PW_currency1_idx` (`currencyId` ASC) VISIBLE,
  INDEX `fk_PW_transactions_PW_exchangeRate1_idx` (`exchangeRateId` ASC) VISIBLE,
  CONSTRAINT `fk_PW_transactions_PW_transTypes1`
    FOREIGN KEY (`transTypesId`)
    REFERENCES `PaymentWallDB`.`PW_transTypes` (`transTypesId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PW_transactions_PW_subTypes1`
    FOREIGN KEY (`transSubTypeId`)
    REFERENCES `PaymentWallDB`.`PW_transSubTypes` (`subTypeId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PW_transactions_PW_Payments1`
    FOREIGN KEY (`paymentId`)
    REFERENCES `PaymentWallDB`.`PW_Payments` (`paymentId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PW_transactions_PW_currency1`
    FOREIGN KEY (`currencyId`)
    REFERENCES `PaymentWallDB`.`PW_currency` (`currencyId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PW_transactions_PW_exchangeRate1`
    FOREIGN KEY (`exchangeRateId`)
    REFERENCES `PaymentWallDB`.`PW_exchangeRate` (`exchangeRateId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentWallDB`.`PW_suscriptions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PaymentWallDB`.`PW_suscriptions` ;

CREATE TABLE IF NOT EXISTS `PaymentWallDB`.`PW_suscriptions` (
  `suscriptionId` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(100) NOT NULL,
  `logoURL` VARCHAR(300) NOT NULL,
  PRIMARY KEY (`suscriptionId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentWallDB`.`PW_planPrice`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PaymentWallDB`.`PW_planPrice` ;

CREATE TABLE IF NOT EXISTS `PaymentWallDB`.`PW_planPrice` (
  `planPriceId` INT NOT NULL AUTO_INCREMENT,
  `amount` BIGINT NULL,
  `recurrencyType` INT NULL,
  `postTime` DATETIME NULL,
  `endDate` DATETIME NULL,
  `currencyId` INT NOT NULL,
  `suscriptionId` INT NOT NULL,
  PRIMARY KEY (`planPriceId`),
  INDEX `fk_PW_planPrice_PW_currency1_idx` (`currencyId` ASC) VISIBLE,
  INDEX `fk_PW_planPrice_PW_suscriptions1_idx` (`suscriptionId` ASC) VISIBLE,
  CONSTRAINT `fk_PW_planPrice_PW_currency1`
    FOREIGN KEY (`currencyId`)
    REFERENCES `PaymentWallDB`.`PW_currency` (`currencyId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PW_planPrice_PW_suscriptions1`
    FOREIGN KEY (`suscriptionId`)
    REFERENCES `PaymentWallDB`.`PW_suscriptions` (`suscriptionId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentWallDB`.`PW_schedules`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PaymentWallDB`.`PW_schedules` ;

CREATE TABLE IF NOT EXISTS `PaymentWallDB`.`PW_schedules` (
  `scheduleId` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `recurrencyType` INT NOT NULL,
  `repetions` INT NULL,
  `endtype` INT NOT NULL,
  `repit` TINYINT NOT NULL,
  `endDate` DATETIME NOT NULL,
  PRIMARY KEY (`scheduleId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentWallDB`.`PW_userPlan`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PaymentWallDB`.`PW_userPlan` ;

CREATE TABLE IF NOT EXISTS `PaymentWallDB`.`PW_userPlan` (
  `userPlanId` INT NOT NULL,
  `acquisition` DATETIME NULL,
  `enabled` TINYINT NULL,
  `planPriceId` INT NOT NULL,
  `userId` INT NOT NULL,
  `scheduleId` INT NOT NULL,
  PRIMARY KEY (`userPlanId`),
  INDEX `fk_PW_userPlan_PW_planPrice1_idx` (`planPriceId` ASC) VISIBLE,
  INDEX `fk_PW_userPlan_PW_users1_idx` (`userId` ASC) VISIBLE,
  INDEX `fk_PW_userPlan_PW_schedules1_idx` (`scheduleId` ASC) VISIBLE,
  CONSTRAINT `fk_PW_userPlan_PW_planPrice1`
    FOREIGN KEY (`planPriceId`)
    REFERENCES `PaymentWallDB`.`PW_planPrice` (`planPriceId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PW_userPlan_PW_users1`
    FOREIGN KEY (`userId`)
    REFERENCES `PaymentWallDB`.`PW_users` (`userId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PW_userPlan_PW_schedules1`
    FOREIGN KEY (`scheduleId`)
    REFERENCES `PaymentWallDB`.`PW_schedules` (`scheduleId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentWallDB`.`PW_scheduleDetails`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PaymentWallDB`.`PW_scheduleDetails` ;

CREATE TABLE IF NOT EXISTS `PaymentWallDB`.`PW_scheduleDetails` (
  `scheduleDetailsId` INT NOT NULL,
  `deleted` TINYINT NOT NULL,
  `baseDate` DATETIME NOT NULL,
  `datepart` VARCHAR(45) NOT NULL,
  `lastExecute` DATETIME NOT NULL,
  `nextExecute` DATETIME NOT NULL,
  `scheduleId` INT NOT NULL,
  PRIMARY KEY (`scheduleDetailsId`),
  INDEX `fk_PW_scheduleDetails_PW_schedules1_idx` (`scheduleId` ASC) VISIBLE,
  CONSTRAINT `fk_PW_scheduleDetails_PW_schedules1`
    FOREIGN KEY (`scheduleId`)
    REFERENCES `PaymentWallDB`.`PW_schedules` (`scheduleId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentWallDB`.`PW_planFeatures`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PaymentWallDB`.`PW_planFeatures` ;

CREATE TABLE IF NOT EXISTS `PaymentWallDB`.`PW_planFeatures` (
  `planFeatureId` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(150) NOT NULL,
  `enabled` TINYINT NOT NULL,
  `dateType` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`planFeatureId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentWallDB`.`PW_featuresPerPlan`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PaymentWallDB`.`PW_featuresPerPlan` ;

CREATE TABLE IF NOT EXISTS `PaymentWallDB`.`PW_featuresPerPlan` (
  `featurePerPlanId` INT NOT NULL,
  `value` VARCHAR(45) NOT NULL,
  `enabled` TINYINT NOT NULL,
  `planFeatureId` INT NOT NULL,
  `suscriptionId` INT NOT NULL,
  PRIMARY KEY (`featurePerPlanId`),
  INDEX `fk_PW_featuresPerPlan_PW_planFeatures1_idx` (`planFeatureId` ASC) VISIBLE,
  INDEX `fk_PW_featuresPerPlan_PW_suscriptions1_idx` (`suscriptionId` ASC) VISIBLE,
  CONSTRAINT `fk_PW_featuresPerPlan_PW_planFeatures1`
    FOREIGN KEY (`planFeatureId`)
    REFERENCES `PaymentWallDB`.`PW_planFeatures` (`planFeatureId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PW_featuresPerPlan_PW_suscriptions1`
    FOREIGN KEY (`suscriptionId`)
    REFERENCES `PaymentWallDB`.`PW_suscriptions` (`suscriptionId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentWallDB`.`PW_userPlanLimit`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PaymentWallDB`.`PW_userPlanLimit` ;

CREATE TABLE IF NOT EXISTS `PaymentWallDB`.`PW_userPlanLimit` (
  `personPlanLimit` INT NOT NULL AUTO_INCREMENT,
  `limit` TINYINT NOT NULL,
  `userPlanId` INT NOT NULL,
  `planFeatureId` INT NOT NULL,
  PRIMARY KEY (`personPlanLimit`),
  INDEX `fk_PW_userPlanLimit_PW_userPlan1_idx` (`userPlanId` ASC) VISIBLE,
  INDEX `fk_PW_userPlanLimit_PW_planFeatures1_idx` (`planFeatureId` ASC) VISIBLE,
  CONSTRAINT `fk_PW_userPlanLimit_PW_userPlan1`
    FOREIGN KEY (`userPlanId`)
    REFERENCES `PaymentWallDB`.`PW_userPlan` (`userPlanId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PW_userPlanLimit_PW_planFeatures1`
    FOREIGN KEY (`planFeatureId`)
    REFERENCES `PaymentWallDB`.`PW_planFeatures` (`planFeatureId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentWallDB`.`PW_languages`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PaymentWallDB`.`PW_languages` ;

CREATE TABLE IF NOT EXISTS `PaymentWallDB`.`PW_languages` (
  `languageId` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `culture` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`languageId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentWallDB`.`PW_translation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PaymentWallDB`.`PW_translation` ;

CREATE TABLE IF NOT EXISTS `PaymentWallDB`.`PW_translation` (
  `translationId` INT NOT NULL,
  `code` VARCHAR(15) NOT NULL,
  `caption` TEXT NULL,
  `enabled` TINYINT NOT NULL,
  `languageId` INT NOT NULL,
  `moduleId` INT NOT NULL,
  PRIMARY KEY (`translationId`),
  INDEX `fk_PW_translation_PW_languages1_idx` (`languageId` ASC) VISIBLE,
  INDEX `fk_PW_translation_PW_modules1_idx` (`moduleId` ASC) VISIBLE,
  CONSTRAINT `fk_PW_translation_PW_languages1`
    FOREIGN KEY (`languageId`)
    REFERENCES `PaymentWallDB`.`PW_languages` (`languageId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PW_translation_PW_modules1`
    FOREIGN KEY (`moduleId`)
    REFERENCES `PaymentWallDB`.`PW_modules` (`moduleId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentWallDB`.`PW_infoTypes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PaymentWallDB`.`PW_infoTypes` ;

CREATE TABLE IF NOT EXISTS `PaymentWallDB`.`PW_infoTypes` (
  `infoTypeId` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`infoTypeId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentWallDB`.`PW_info`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PaymentWallDB`.`PW_info` ;

CREATE TABLE IF NOT EXISTS `PaymentWallDB`.`PW_info` (
  `infoId` INT NOT NULL AUTO_INCREMENT,
  `value` VARCHAR(100) NOT NULL,
  `enabled` TINYINT NOT NULL,
  `lastUpdate` DATETIME NOT NULL,
  `paymentMethodId` INT NOT NULL,
  `infoTypeId` INT NOT NULL,
  PRIMARY KEY (`infoId`),
  INDEX `fk_PW_userInfo_PW_paymentMethods1_idx` (`paymentMethodId` ASC) VISIBLE,
  INDEX `fk_PW_info_PW_infoTypes1_idx` (`infoTypeId` ASC) VISIBLE,
  CONSTRAINT `fk_PW_userInfo_PW_paymentMethods1`
    FOREIGN KEY (`paymentMethodId`)
    REFERENCES `PaymentWallDB`.`PW_paymentMethods` (`paymentMethodId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PW_info_PW_infoTypes1`
    FOREIGN KEY (`infoTypeId`)
    REFERENCES `PaymentWallDB`.`PW_infoTypes` (`infoTypeId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentWallDB`.`PW_infoCompany`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PaymentWallDB`.`PW_infoCompany` ;

CREATE TABLE IF NOT EXISTS `PaymentWallDB`.`PW_infoCompany` (
  `companyInfoTypeId` INT NOT NULL AUTO_INCREMENT,
  `companyAddressId` INT NOT NULL,
  `infoId` INT NOT NULL,
  PRIMARY KEY (`companyInfoTypeId`),
  INDEX `fk_PW_infoCompany_PW_companyAddress1_idx` (`companyAddressId` ASC) VISIBLE,
  INDEX `fk_PW_infoCompany_PW_info1_idx` (`infoId` ASC) VISIBLE,
  CONSTRAINT `fk_PW_infoCompany_PW_companyAddress1`
    FOREIGN KEY (`companyAddressId`)
    REFERENCES `PaymentWallDB`.`PW_companyAddress` (`companyAddressId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PW_infoCompany_PW_info1`
    FOREIGN KEY (`infoId`)
    REFERENCES `PaymentWallDB`.`PW_info` (`infoId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentWallDB`.`PW_services`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PaymentWallDB`.`PW_services` ;

CREATE TABLE IF NOT EXISTS `PaymentWallDB`.`PW_services` (
  `serviceId` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `keywords` TEXT NOT NULL,
  `category` VARCHAR(45) NOT NULL,
  `description` TEXT NULL,
  `Cuenta_Iban` INT NULL,
  PRIMARY KEY (`serviceId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentWallDB`.`PW_userServices`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PaymentWallDB`.`PW_userServices` ;

CREATE TABLE IF NOT EXISTS `PaymentWallDB`.`PW_userServices` (
  `userServiceId` INT NOT NULL AUTO_INCREMENT,
  `serviceId` INT NOT NULL,
  `userId` INT NOT NULL,
  PRIMARY KEY (`userServiceId`),
  INDEX `fk_PW_userServices_PW_services1_idx` (`serviceId` ASC) VISIBLE,
  INDEX `fk_PW_userServices_PW_users1_idx` (`userId` ASC) VISIBLE,
  CONSTRAINT `fk_PW_userServices_PW_services1`
    FOREIGN KEY (`serviceId`)
    REFERENCES `PaymentWallDB`.`PW_services` (`serviceId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PW_userServices_PW_users1`
    FOREIGN KEY (`userId`)
    REFERENCES `PaymentWallDB`.`PW_users` (`userId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentWallDB`.`PW_companyServices`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PaymentWallDB`.`PW_companyServices` ;

CREATE TABLE IF NOT EXISTS `PaymentWallDB`.`PW_companyServices` (
  `companyServiceId` INT NOT NULL AUTO_INCREMENT,
  `serviceId` INT NOT NULL,
  `companyAddressId` INT NOT NULL,
  PRIMARY KEY (`companyServiceId`),
  INDEX `fk_PW_companyServices_PW_services1_idx` (`serviceId` ASC) VISIBLE,
  INDEX `fk_PW_companyServices_PW_companyAddress1_idx` (`companyAddressId` ASC) VISIBLE,
  CONSTRAINT `fk_PW_companyServices_PW_services1`
    FOREIGN KEY (`serviceId`)
    REFERENCES `PaymentWallDB`.`PW_services` (`serviceId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PW_companyServices_PW_companyAddress1`
    FOREIGN KEY (`companyAddressId`)
    REFERENCES `PaymentWallDB`.`PW_companyAddress` (`companyAddressId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentWallDB`.`PW_userInfo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PaymentWallDB`.`PW_userInfo` ;

CREATE TABLE IF NOT EXISTS `PaymentWallDB`.`PW_userInfo` (
  `userInfoId` VARCHAR(45) NOT NULL,
  `userId` INT NOT NULL,
  `infoId` INT NOT NULL,
  INDEX `fk_PW_userInfo_PW_users2_idx` (`userId` ASC) VISIBLE,
  INDEX `fk_PW_userInfo_PW_info1_idx` (`infoId` ASC) VISIBLE,
  PRIMARY KEY (`userInfoId`),
  CONSTRAINT `fk_PW_userInfo_PW_users2`
    FOREIGN KEY (`userId`)
    REFERENCES `PaymentWallDB`.`PW_users` (`userId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PW_userInfo_PW_info1`
    FOREIGN KEY (`infoId`)
    REFERENCES `PaymentWallDB`.`PW_info` (`infoId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentWallDB`.`PW_logSeverity`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PaymentWallDB`.`PW_logSeverity` ;

CREATE TABLE IF NOT EXISTS `PaymentWallDB`.`PW_logSeverity` (
  `logSeverityId` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`logSeverityId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentWallDB`.`PW_sources`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PaymentWallDB`.`PW_sources` ;

CREATE TABLE IF NOT EXISTS `PaymentWallDB`.`PW_sources` (
  `logSourcesId` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`logSourcesId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentWallDB`.`PW_logTypes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PaymentWallDB`.`PW_logTypes` ;

CREATE TABLE IF NOT EXISTS `PaymentWallDB`.`PW_logTypes` (
  `logTypeId` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `referenceDescription` VARCHAR(120) NOT NULL,
  `valueDescription` VARCHAR(120) NOT NULL,
  PRIMARY KEY (`logTypeId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentWallDB`.`PW_Logs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PaymentWallDB`.`PW_Logs` ;

CREATE TABLE IF NOT EXISTS `PaymentWallDB`.`PW_Logs` (
  `logId` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(300) NOT NULL,
  `posttime` DATETIME NOT NULL,
  `computer` VARCHAR(45) NOT NULL,
  `username` VARCHAR(50) NOT NULL,
  `trace` VARCHAR(100) NOT NULL,
  `referenceId1` BIGINT NULL,
  `referenceId2` BIGINT NULL,
  `value1` VARCHAR(180) NULL,
  `value2` VARCHAR(180) NULL,
  `checksum` VARBINARY(250) NOT NULL,
  `logSeverityId` INT NOT NULL,
  `logSourcesId` INT NOT NULL,
  `logTypeId` INT NOT NULL,
  PRIMARY KEY (`logId`),
  INDEX `fk_PW_Logs_PW_logSeverity1_idx` (`logSeverityId` ASC) VISIBLE,
  INDEX `fk_PW_Logs_PW_sources1_idx` (`logSourcesId` ASC) VISIBLE,
  INDEX `fk_PW_Logs_PW_logTypes1_idx` (`logTypeId` ASC) VISIBLE,
  CONSTRAINT `fk_PW_Logs_PW_logSeverity1`
    FOREIGN KEY (`logSeverityId`)
    REFERENCES `PaymentWallDB`.`PW_logSeverity` (`logSeverityId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PW_Logs_PW_sources1`
    FOREIGN KEY (`logSourcesId`)
    REFERENCES `PaymentWallDB`.`PW_sources` (`logSourcesId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PW_Logs_PW_logTypes1`
    FOREIGN KEY (`logTypeId`)
    REFERENCES `PaymentWallDB`.`PW_logTypes` (`logTypeId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentWallDB`.`PW_authTypesAI`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PaymentWallDB`.`PW_authTypesAI` ;

CREATE TABLE IF NOT EXISTS `PaymentWallDB`.`PW_authTypesAI` (
  `authTypeId` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`authTypeId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentWallDB`.`PW_AI`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PaymentWallDB`.`PW_AI` ;

CREATE TABLE IF NOT EXISTS `PaymentWallDB`.`PW_AI` (
  `AIAuthId` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `LogoURL` VARCHAR(300) NOT NULL,
  `secretKey` VARBINARY(128) NOT NULL,
  `organizationName` VARCHAR(50) NOT NULL,
  `projectName` VARCHAR(50) NOT NULL,
  `PW_AIAuthcol` VARCHAR(45) NOT NULL,
  `authTypeAIId` INT NOT NULL,
  `moduleId` INT NOT NULL,
  PRIMARY KEY (`AIAuthId`),
  INDEX `fk_PW_AIAuth_PW_authTypes1_idx` (`authTypeAIId` ASC) VISIBLE,
  INDEX `fk_PW_AI_PW_modules1_idx` (`moduleId` ASC) VISIBLE,
  CONSTRAINT `fk_PW_AIAuth_PW_authTypes1`
    FOREIGN KEY (`authTypeAIId`)
    REFERENCES `PaymentWallDB`.`PW_authTypesAI` (`authTypeId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PW_AI_PW_modules1`
    FOREIGN KEY (`moduleId`)
    REFERENCES `PaymentWallDB`.`PW_modules` (`moduleId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentWallDB`.`PW_responseAIFormat`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PaymentWallDB`.`PW_responseAIFormat` ;

CREATE TABLE IF NOT EXISTS `PaymentWallDB`.`PW_responseAIFormat` (
  `responseFormatId` INT NOT NULL,
  `formatName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`responseFormatId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentWallDB`.`PW_requestAI`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PaymentWallDB`.`PW_requestAI` ;

CREATE TABLE IF NOT EXISTS `PaymentWallDB`.`PW_requestAI` (
  `requestAIId` INT NOT NULL,
  `model` VARCHAR(60) NOT NULL,
  `stream` TINYINT NULL,
  `temperature` INT NULL,
  `timestamp_granularities` TIMESTAMP NULL,
  `requestDate` DATETIME NOT NULL,
  `include` VARCHAR(300) NULL,
  `AIId` INT NOT NULL,
  PRIMARY KEY (`requestAIId`),
  INDEX `fk_PW_requestAI_PW_AI1_idx` (`AIId` ASC) VISIBLE,
  CONSTRAINT `fk_PW_requestAI_PW_AI1`
    FOREIGN KEY (`AIId`)
    REFERENCES `PaymentWallDB`.`PW_AI` (`AIAuthId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentWallDB`.`PW_speechToText`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PaymentWallDB`.`PW_speechToText` ;

CREATE TABLE IF NOT EXISTS `PaymentWallDB`.`PW_speechToText` (
  `speechToTextId` INT NOT NULL AUTO_INCREMENT,
  `languageId` INT NOT NULL,
  `audioFileId` INT NOT NULL,
  `formatId` INT NOT NULL,
  `userId` INT NOT NULL,
  `requestId` INT NOT NULL,
  PRIMARY KEY (`speechToTextId`),
  INDEX `fk_PW_speechToText_PW_languages1_idx` (`languageId` ASC) VISIBLE,
  INDEX `fk_PW_speechToText_PW_mediafiles1_idx` (`audioFileId` ASC) VISIBLE,
  INDEX `fk_PW_speechToText_PW_responseAIFormat1_idx` (`formatId` ASC) VISIBLE,
  INDEX `fk_PW_speechToText_PW_users1_idx` (`userId` ASC) VISIBLE,
  INDEX `fk_PW_speechToText_PW_requestAI1_idx` (`requestId` ASC) VISIBLE,
  CONSTRAINT `fk_PW_speechToText_PW_languages1`
    FOREIGN KEY (`languageId`)
    REFERENCES `PaymentWallDB`.`PW_languages` (`languageId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PW_speechToText_PW_mediafiles1`
    FOREIGN KEY (`audioFileId`)
    REFERENCES `PaymentWallDB`.`PW_mediafiles` (`mediafileId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PW_speechToText_PW_responseAIFormat1`
    FOREIGN KEY (`formatId`)
    REFERENCES `PaymentWallDB`.`PW_responseAIFormat` (`responseFormatId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PW_speechToText_PW_users1`
    FOREIGN KEY (`userId`)
    REFERENCES `PaymentWallDB`.`PW_users` (`userId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PW_speechToText_PW_requestAI1`
    FOREIGN KEY (`requestId`)
    REFERENCES `PaymentWallDB`.`PW_requestAI` (`requestAIId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentWallDB`.`PW_transcriptions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PaymentWallDB`.`PW_transcriptions` ;

CREATE TABLE IF NOT EXISTS `PaymentWallDB`.`PW_transcriptions` (
  `transcriptionId` INT NOT NULL,
  `userId` INT NOT NULL,
  `speechToTextId` INT NOT NULL,
  `text` TEXT NOT NULL,
  PRIMARY KEY (`transcriptionId`),
  INDEX `fk_PW_transcriptions_PW_users1_idx` (`userId` ASC) VISIBLE,
  INDEX `fk_PW_transcriptions_PW_speechToText1_idx` (`speechToTextId` ASC) VISIBLE,
  CONSTRAINT `fk_PW_transcriptions_PW_users1`
    FOREIGN KEY (`userId`)
    REFERENCES `PaymentWallDB`.`PW_users` (`userId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PW_transcriptions_PW_speechToText1`
    FOREIGN KEY (`speechToTextId`)
    REFERENCES `PaymentWallDB`.`PW_speechToText` (`speechToTextId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentWallDB`.`PW_userPrompt`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PaymentWallDB`.`PW_userPrompt` ;

CREATE TABLE IF NOT EXISTS `PaymentWallDB`.`PW_userPrompt` (
  `userPromptId` INT NOT NULL,
  `transcriptionId` INT NOT NULL,
  PRIMARY KEY (`userPromptId`),
  INDEX `fk_PW_userPrompt_PW_transcriptions1_idx` (`transcriptionId` ASC) VISIBLE,
  CONSTRAINT `fk_PW_userPrompt_PW_transcriptions1`
    FOREIGN KEY (`transcriptionId`)
    REFERENCES `PaymentWallDB`.`PW_transcriptions` (`transcriptionId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentWallDB`.`PW_systemPrompt`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PaymentWallDB`.`PW_systemPrompt` ;

CREATE TABLE IF NOT EXISTS `PaymentWallDB`.`PW_systemPrompt` (
  `systemPromptId` INT NOT NULL,
  `text` TEXT NOT NULL,
  PRIMARY KEY (`systemPromptId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentWallDB`.`PW_chainOfThought`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PaymentWallDB`.`PW_chainOfThought` ;

CREATE TABLE IF NOT EXISTS `PaymentWallDB`.`PW_chainOfThought` (
  `chainId` INT NOT NULL,
  `requestId` INT NOT NULL,
  `responseFormatId` INT NOT NULL,
  `userPromptId` INT NOT NULL,
  `systemPromptId` INT NOT NULL,
  `response` JSON NOT NULL,
  PRIMARY KEY (`chainId`),
  INDEX `fk_PW_chainOfThought_PW_requestAI1_idx` (`requestId` ASC) VISIBLE,
  INDEX `fk_PW_chainOfThought_PW_responseAIFormat1_idx` (`responseFormatId` ASC) VISIBLE,
  INDEX `fk_PW_chainOfThought_PW_userPrompt1_idx` (`userPromptId` ASC) VISIBLE,
  INDEX `fk_PW_chainOfThought_PW_systemPrompt1_idx` (`systemPromptId` ASC) VISIBLE,
  CONSTRAINT `fk_PW_chainOfThought_PW_requestAI1`
    FOREIGN KEY (`requestId`)
    REFERENCES `PaymentWallDB`.`PW_requestAI` (`requestAIId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PW_chainOfThought_PW_responseAIFormat1`
    FOREIGN KEY (`responseFormatId`)
    REFERENCES `PaymentWallDB`.`PW_responseAIFormat` (`responseFormatId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PW_chainOfThought_PW_userPrompt1`
    FOREIGN KEY (`userPromptId`)
    REFERENCES `PaymentWallDB`.`PW_userPrompt` (`userPromptId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PW_chainOfThought_PW_systemPrompt1`
    FOREIGN KEY (`systemPromptId`)
    REFERENCES `PaymentWallDB`.`PW_systemPrompt` (`systemPromptId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentWallDB`.`PW_eventType`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PaymentWallDB`.`PW_eventType` ;

CREATE TABLE IF NOT EXISTS `PaymentWallDB`.`PW_eventType` (
  `eventTypeId` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  `action1` VARCHAR(45) NOT NULL,
  `action2` VARCHAR(45) NULL,
  `specifications` TEXT NULL,
  PRIMARY KEY (`eventTypeId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentWallDB`.`PW_eventByAI`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PaymentWallDB`.`PW_eventByAI` ;

CREATE TABLE IF NOT EXISTS `PaymentWallDB`.`PW_eventByAI` (
  `eventId` VARCHAR(45) NOT NULL,
  `chainId` INT NOT NULL,
  `eventTypeId` INT NOT NULL,
  PRIMARY KEY (`eventId`),
  INDEX `fk_PW_eventByAI_PW_eventType1_idx` (`eventTypeId` ASC) VISIBLE,
  CONSTRAINT `fk_PW_eventByAI_PW_chainOfThought1`
    FOREIGN KEY (`chainId`)
    REFERENCES `PaymentWallDB`.`PW_chainOfThought` (`chainId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PW_eventByAI_PW_eventType1`
    FOREIGN KEY (`eventTypeId`)
    REFERENCES `PaymentWallDB`.`PW_eventType` (`eventTypeId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PaymentWallDB`.`PW_interactionByAI`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PaymentWallDB`.`PW_interactionByAI` ;

CREATE TABLE IF NOT EXISTS `PaymentWallDB`.`PW_interactionByAI` (
  `interactionId` INT NOT NULL,
  `eventId` VARCHAR(45) NOT NULL,
  `contactInfoId` INT NOT NULL,
  `userId` INT NOT NULL,
  `transactionId` INT NOT NULL,
  `paymentId` INT NOT NULL,
  `addressId` INT NOT NULL,
  `companyAddressId` INT NOT NULL,
  `moduleId` INT NOT NULL,
  `interactiontStartDate` DATETIME NOT NULL,
  `interactionEndDate` DATETIME NOT NULL,
  `checksum` VARBINARY(128) NOT NULL,
  PRIMARY KEY (`interactionId`),
  INDEX `fk_PW_interactionWithAI_PW_contactInfo1_idx` (`contactInfoId` ASC) VISIBLE,
  INDEX `fk_PW_interactionWithAI_PW_users1_idx` (`userId` ASC) VISIBLE,
  INDEX `fk_PW_interactionWithAI_PW_transactions1_idx` (`transactionId` ASC) VISIBLE,
  INDEX `fk_PW_interactionWithAI_PW_Payments1_idx` (`paymentId` ASC) VISIBLE,
  INDEX `fk_PW_interactionWithAI_PW_address1_idx` (`addressId` ASC) VISIBLE,
  INDEX `fk_PW_interactionWithAI_PW_companyAddress1_idx` (`companyAddressId` ASC) VISIBLE,
  INDEX `fk_PW_interactionWithAI_PW_modules1_idx` (`moduleId` ASC) VISIBLE,
  INDEX `fk_PW_interactionByAI_PW_eventByAI1_idx` (`eventId` ASC) VISIBLE,
  CONSTRAINT `fk_PW_interactionWithAI_PW_contactInfo1`
    FOREIGN KEY (`contactInfoId`)
    REFERENCES `PaymentWallDB`.`PW_contactInfo` (`contactInfoId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PW_interactionWithAI_PW_users1`
    FOREIGN KEY (`userId`)
    REFERENCES `PaymentWallDB`.`PW_users` (`userId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PW_interactionWithAI_PW_transactions1`
    FOREIGN KEY (`transactionId`)
    REFERENCES `PaymentWallDB`.`PW_transactions` (`transactionId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PW_interactionWithAI_PW_Payments1`
    FOREIGN KEY (`paymentId`)
    REFERENCES `PaymentWallDB`.`PW_Payments` (`paymentId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PW_interactionWithAI_PW_address1`
    FOREIGN KEY (`addressId`)
    REFERENCES `PaymentWallDB`.`PW_address` (`addressId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PW_interactionWithAI_PW_companyAddress1`
    FOREIGN KEY (`companyAddressId`)
    REFERENCES `PaymentWallDB`.`PW_companyAddress` (`companyAddressId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PW_interactionWithAI_PW_modules1`
    FOREIGN KEY (`moduleId`)
    REFERENCES `PaymentWallDB`.`PW_modules` (`moduleId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PW_interactionByAI_PW_eventByAI1`
    FOREIGN KEY (`eventId`)
    REFERENCES `PaymentWallDB`.`PW_eventByAI` (`eventId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
