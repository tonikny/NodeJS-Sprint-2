-- MySQL Script generated by MySQL Workbench
-- dimarts, 16 de novembre de 2021, 13:53:15
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pizzeria` ;
USE `pizzeria` ;

-- -----------------------------------------------------
-- Table `pizzeria`.`provincia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`provincia` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`localitat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`localitat` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `id_provincia` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`, `id_provincia`),
  INDEX `id_provincia_idx` (`id_provincia` ASC) VISIBLE,
  CONSTRAINT `id_provincia`
    FOREIGN KEY (`id_provincia`)
    REFERENCES `pizzeria`.`provincia` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`client` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NULL,
  `cognoms` VARCHAR(45) NULL,
  `adreça` VARCHAR(45) NULL,
  `cp` VARCHAR(45) NULL,
  `id_localitat` INT UNSIGNED NULL,
  PRIMARY KEY (`id`),
  INDEX `id_localitat_idx` (`id_localitat` ASC) VISIBLE,
  CONSTRAINT `id_localitat`
    FOREIGN KEY (`id_localitat`)
    REFERENCES `pizzeria`.`localitat` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`botiga`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`botiga` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `adreça` VARCHAR(45) NULL,
  `cp` VARCHAR(45) NULL,
  `id_localitat` INT UNSIGNED NULL,
  PRIMARY KEY (`id`),
  INDEX `id_localitat_idx` (`id_localitat` ASC) VISIBLE,
  CONSTRAINT `id_localitat_botiga`
    FOREIGN KEY (`id_localitat`)
    REFERENCES `pizzeria`.`localitat` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`empleat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`empleat` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `cognoms` VARCHAR(45) NOT NULL,
  `nif` VARCHAR(45) NOT NULL,
  `telf` VARCHAR(45) NULL,
  `carrec` ENUM('cuiner', 'repartidor') NOT NULL,
  `id_botiga` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `id_botiga_idx` (`id_botiga` ASC) VISIBLE,
  CONSTRAINT `id_botiga_empleat`
    FOREIGN KEY (`id_botiga`)
    REFERENCES `pizzeria`.`botiga` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`comanda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`comanda` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `data_hora` DATETIME NOT NULL,
  `tipus` ENUM('repartir', 'recollir') NOT NULL,
  `id_client` INT UNSIGNED NOT NULL,
  `preu_total` DOUBLE NOT NULL,
  `id_botiga` INT UNSIGNED NOT NULL,
  `id_empleat` INT UNSIGNED NULL,
  `entrega_repartiment` DATETIME NULL,
  PRIMARY KEY (`id`, `id_client`, `id_botiga`),
  INDEX `id_client_idx` (`id_client` ASC) VISIBLE,
  INDEX `id_botiga_idx` (`id_botiga` ASC) VISIBLE,
  INDEX `id_empleat_idx` (`id_empleat` ASC) VISIBLE,
  CONSTRAINT `id_client`
    FOREIGN KEY (`id_client`)
    REFERENCES `pizzeria`.`client` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_botiga`
    FOREIGN KEY (`id_botiga`)
    REFERENCES `pizzeria`.`botiga` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_empleat`
    FOREIGN KEY (`id_empleat`)
    REFERENCES `pizzeria`.`empleat` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`tipus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`tipus` (
  `id` INT UNSIGNED NOT NULL,
  `nom` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`categoria` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`producto` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `descripcio` VARCHAR(255) NULL,
  `imatge` VARCHAR(45) NULL,
  `preu` DOUBLE NOT NULL,
  `id_tipus` INT UNSIGNED NOT NULL,
  `id_categoria` INT UNSIGNED NULL,
  PRIMARY KEY (`id`),
  INDEX `id_tipus_idx` (`id_tipus` ASC) VISIBLE,
  INDEX `id_categoria_idx` (`id_categoria` ASC) VISIBLE,
  CONSTRAINT `id_tipus`
    FOREIGN KEY (`id_tipus`)
    REFERENCES `pizzeria`.`tipus` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_categoria`
    FOREIGN KEY (`id_categoria`)
    REFERENCES `pizzeria`.`categoria` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`linea_comanda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`linea_comanda` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `quantitat` INT NOT NULL,
  `id_comanda` INT UNSIGNED NOT NULL,
  `id_producto` INT UNSIGNED NULL,
  PRIMARY KEY (`id`, `id_comanda`),
  INDEX `id_comanda_idx` (`id_comanda` ASC) VISIBLE,
  INDEX `id_producto_idx` (`id_producto` ASC) VISIBLE,
  CONSTRAINT `id_comanda`
    FOREIGN KEY (`id_comanda`)
    REFERENCES `pizzeria`.`comanda` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_producto`
    FOREIGN KEY (`id_producto`)
    REFERENCES `pizzeria`.`producto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `pizzeria`.`provincia`
-- -----------------------------------------------------
INSERT INTO `pizzeria`.`provincia` (`id`, `nom`) VALUES (1, 'Barcelona');

-- -----------------------------------------------------
-- Data for table `pizzeria`.`localitat`
-- -----------------------------------------------------
INSERT INTO `pizzeria`.`localitat` (`id`, `nom`, `id_provincia`) VALUES (1, 'Barcelona', 1);
INSERT INTO `pizzeria`.`localitat` (`id`, `nom`, `id_provincia`) VALUES (2, 'Manresa', 1);

-- -----------------------------------------------------
-- Data for table `pizzeria`.`client`
-- -----------------------------------------------------
INSERT INTO `pizzeria`.`client` (`id`, `nom`, `cognoms`, `adreça`, `cp`, `id_localitat`) VALUES (1, 'Toni', 'Muelas', 'janckjlansckj', '08080', 1);
INSERT INTO `pizzeria`.`client` (`id`, `nom`, `cognoms`, `adreça`, `cp`, `id_localitat`) VALUES (2, 'Pep', 'Pepet', 'kjgjhlhlkj', '08081', 1);

-- -----------------------------------------------------
-- Data for table `pizzeria`.`botiga`
-- -----------------------------------------------------
INSERT INTO `pizzeria`.`botiga` (`id`, `adreça`, `cp`, `id_localitat`) VALUES (1, 'botiga1', '08080', 1);
INSERT INTO `pizzeria`.`botiga` (`id`, `adreça`, `cp`, `id_localitat`) VALUES (2, 'botiga2 ', '08082', 1);

-- -----------------------------------------------------
-- Data for table `pizzeria`.`empleat`
-- -----------------------------------------------------
INSERT INTO `pizzeria`.`empleat` (`id`, `nom`, `cognoms`, `nif`, `telf`, `carrec`, `id_botiga`) VALUES (1, 'Pere', 'Perera', '9876877t', '87676979', 'repartidor', 1);
INSERT INTO `pizzeria`.`empleat` (`id`, `nom`, `cognoms`, `nif`, `telf`, `carrec`, `id_botiga`) VALUES (2, 'Jordi', 'Jordiet', '9456877Y', '245622', 'cuiner', 1);

-- -----------------------------------------------------
-- Data for table `pizzeria`.`comanda`
-- -----------------------------------------------------
INSERT INTO `pizzeria`.`comanda` (`id`, `data_hora`, `tipus`, `id_client`, `preu_total`, `id_botiga`, `id_empleat`, `entrega_repartiment`) VALUES (1, '2021-11-16 00:00:00', 'repartir', 1, 4, 1, 1, '2021-11-16 01:00:00');

-- -----------------------------------------------------
-- Data for table `pizzeria`.`tipus`
-- -----------------------------------------------------
INSERT INTO `pizzeria`.`tipus` (`id`, `nom`) VALUES (1, 'beguda');

-- ----------------------
-- Data for table `pizzeria`.`categoria`
-- -----------------------------------------------------
INSERT INTO `pizzeria`.`categoria` (`id`, `nom`) VALUES (1, 'masa fina');

-- -----------------------------------------------------
-- Data for table `pizzeria`.`producto`
-- -----------------------------------------------------
INSERT INTO `pizzeria`.`producto` (`id`, `nom`, `descripcio`, `imatge`, `preu`, `id_tipus`, `id_categoria`) VALUES (1, 'cervesa', 'mmm', '', 2, 1, NULL);

-- -----------------------------------------------------
-- Data for table `pizzeria`.`linea_comanda`
-- -----------------------------------------------------
INSERT INTO `pizzeria`.`linea_comanda` (`id`, `quantitat`, `id_comanda`, `id_producto`) VALUES (1, 2, 1, 1);



-- VERIFICACIO:

SELECT COUNT(p.id) AS 'Begudes a Barcelona' FROM tipus as t
INNER JOIN producto AS p ON t.id = p.id_tipus
INNER JOIN linea_comanda AS l ON p.id = l.id_producto
INNER JOIN comanda AS c ON l.id_comanda = c.id
INNER JOIN botiga AS b ON c.id_botiga = b.id
INNER JOIN localitat AS lo ON b.id_localitat = lo.id
WHERE t.nom = 'beguda' AND lo.nom = 'Barcelona';

SELECT COUNT(c.id) AS 'Num comandes de l\'empleat 9876877t' FROM comanda AS c
INNER JOIN empleat AS e ON c.id_empleat = e.id
WHERE e.nif = '9876877t';



