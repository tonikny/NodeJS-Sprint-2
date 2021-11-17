-- MySQL Script generated by MySQL Workbench
-- dimarts, 16 de novembre de 2021, 17:22:56
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema optica
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema optica
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `optica` ;
USE `optica` ;

-- -----------------------------------------------------
-- Table `optica`.`proveidor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `optica`.`proveidor` ;

CREATE TABLE IF NOT EXISTS `optica`.`proveidor` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `carrer` VARCHAR(45) NULL,
  `num` VARCHAR(10) NULL,
  `pis` VARCHAR(5) NULL,
  `porta` VARCHAR(5) NULL,
  `ciutat` VARCHAR(45) NULL,
  `cp` VARCHAR(5) NULL,
  `pais` VARCHAR(45) NULL,
  `telf` VARCHAR(45) NULL,
  `fax` VARCHAR(45) NULL,
  `nif` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`marca`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `optica`.`marca` ;

CREATE TABLE IF NOT EXISTS `optica`.`marca` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `id_proveidor` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `id_proveidor_idx` (`id_proveidor` ASC) VISIBLE,
  CONSTRAINT `id_proveidor`
    FOREIGN KEY (`id_proveidor`)
    REFERENCES `optica`.`proveidor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`client`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `optica`.`client` ;

CREATE TABLE IF NOT EXISTS `optica`.`client` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `carrer` VARCHAR(45) NULL,
  `num` VARCHAR(10) NULL,
  `pis` VARCHAR(5) NULL,
  `porta` VARCHAR(5) NULL,
  `ciutat` VARCHAR(45) NULL,
  `cp` VARCHAR(5) NULL,
  `pais` VARCHAR(45) NULL,
  `telf` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `data_registre` DATE NOT NULL,
  `recomana` INT UNSIGNED NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cliente_cliente1_idx` (`recomana` ASC) VISIBLE,
  CONSTRAINT `recomana`
    FOREIGN KEY (`recomana`)
    REFERENCES `optica`.`client` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`empleat`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `optica`.`empleat` ;

CREATE TABLE IF NOT EXISTS `optica`.`empleat` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NULL,
  `nif` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`ulleres`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `optica`.`ulleres` ;

CREATE TABLE IF NOT EXISTS `optica`.`ulleres` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `graduacio_esq` DECIMAL NULL,
  `graduacio_dta` DECIMAL NULL,
  `montura` ENUM('pasta', 'flotant', 'metal') NULL,
  `color_mont` VARCHAR(45) NULL,
  `color_vidres` VARCHAR(45) NULL,
  `preu` DECIMAL NULL,
  `id_marca` INT UNSIGNED NOT NULL,
  `id_client` INT UNSIGNED NULL DEFAULT NULL,
  `id_empleat` INT UNSIGNED NULL DEFAULT NULL,
  `data_venda` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `id_marca`),
  INDEX `id_marca_idx` (`id_marca` ASC) VISIBLE,
  INDEX `id_clent_idx` (`id_client` ASC) VISIBLE,
  INDEX `id_empleat_idx` (`id_empleat` ASC) VISIBLE,
  CONSTRAINT `id_marca`
    FOREIGN KEY (`id_marca`)
    REFERENCES `optica`.`marca` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_clent`
    FOREIGN KEY (`id_client`)
    REFERENCES `optica`.`client` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_empleat`
    FOREIGN KEY (`id_empleat`)
    REFERENCES `optica`.`empleat` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `optica`.`proveidor`
-- -----------------------------------------------------
INSERT INTO `optica`.`proveidor` (`id`, `nom`, `carrer`, `num`, `pis`, `porta`, `ciutat`, `cp`, `pais`, `telf`, `fax`, `nif`) VALUES (1, 'optidistri', 'uiuyiugyui', '87', '0', '0', 'Figueres', '05968', 'Cat', '865875785', '', '867576576G');

-- -----------------------------------------------------
-- Data for table `optica`.`marca`
-- -----------------------------------------------------
INSERT INTO `optica`.`marca` (`id`, `nom`, `id_proveidor`) VALUES (1, 'raivan', 1);

-- -----------------------------------------------------
-- Data for table `optica`.`client`
-- -----------------------------------------------------
INSERT INTO `optica`.`client` (`id`, `nom`, `carrer`, `num`, `pis`, `porta`, `ciutat`, `cp`, `pais`, `telf`, `email`, `data_registre`, `recomana`) VALUES (1, 'Joan', 'sfggwegwegr', '88', '8', '8', 'Girona', '05958', 'Cat', '8765876587', 'iuwiuw@kjj', '2020-03-03', NULL);

-- -----------------------------------------------------
-- Data for table `optica`.`empleat`
-- -----------------------------------------------------
INSERT INTO `optica`.`empleat` (`id`, `nom`, `nif`) VALUES (1, 'marc', '87687687H');

-- -----------------------------------------------------
-- Data for table `optica`.`ulleres`
-- -----------------------------------------------------
INSERT INTO `optica`.`ulleres` (`id`, `graduacio_esq`, `graduacio_dta`, `montura`, `color_mont`, `color_vidres`, `preu`, `id_marca`) VALUES (1, 1, 1.2, 'pasta', 'verd', '', 50, 1);
INSERT INTO `optica`.`ulleres` (`id`, `graduacio_esq`, `graduacio_dta`, `montura`, `color_mont`, `color_vidres`, `preu`, `id_marca`, `id_client`, `id_empleat`, `data_venda`) VALUES (2, 0.5, 0.5, 'metal', 'negre', 'blanc', 60, 1, 1, 1, '2021-02-02');
INSERT INTO `optica`.`ulleres` (`id`, `graduacio_esq`, `graduacio_dta`, `montura`, `color_mont`, `color_vidres`, `preu`, `id_marca`, `id_client`, `id_empleat`, `data_venda`) VALUES (3, 2, 2, 'metal', 'verd', 'negre', 70, 1, 1, 1, '2021-06-06');


-- VERIFICACIO:

-- Ulleres comprades per en 'Joan' al 2021
SELECT DISTINCT u.* FROM ulleres AS u
INNER JOIN client AS c ON u.id_client = c.id
WHERE c.nom = 'Joan' AND YEAR(u.data_venda) = 2021;

-- Ulleres comprades per en 'Joan' entre Abril del 2020 i Abril del 2021
SELECT DISTINCT u.* FROM ulleres AS u
INNER JOIN client AS c ON u.id_client = c.id
WHERE c.nom = 'Joan' AND u.data_venda BETWEEN '2020-04-01' AND '2021-03-31';

-- Ulleres venudes per en 'marc' al 2021
SELECT DISTINCT u.*, m.nom FROM ulleres AS u
INNER JOIN empleat AS e ON u.id_empleat = e.id
INNER JOIN marca AS m ON u.id_marca = m.id
WHERE e.nom = 'marc' AND YEAR(u.data_venda) = '2021';

-- Distribuidors dels que s'han venut ulleres
SELECT DISTINCT p.nom FROM proveidor AS p
INNER JOIN marca AS m ON p.id = m.id_proveidor
INNER JOIN ulleres AS u ON m.id = u.id_marca
WHERE u.data_venda IS NOT NULL;

