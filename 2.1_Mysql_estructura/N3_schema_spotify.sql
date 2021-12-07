-- -----------------------------------------------------
-- Schema spotify
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `spotify` ;

-- -----------------------------------------------------
-- Schema spotify
-- -----------------------------------------------------
CREATE SCHEMA `spotify` ;
USE `spotify` ;

-- -----------------------------------------------------
-- Table `spotify`.`usuari`
-- -----------------------------------------------------
CREATE TABLE `spotify`.`usuari` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `data_neixement` DATE NULL,
  `sexe` VARCHAR(45) NULL,
  `pais` VARCHAR(45) NULL,
  `cp` VARCHAR(45) NULL,
  `premium` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`subscripcio`
-- -----------------------------------------------------
CREATE TABLE `spotify`.`subscripcio` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `data_inici` DATETIME NOT NULL,
  `data_renovacio` DATETIME NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`tarjeta`
-- -----------------------------------------------------
CREATE TABLE `spotify`.`tarjeta` (
  `num` VARCHAR(25) NOT NULL,
  `mes` VARCHAR(2) NULL,
  `any` VARCHAR(2) NULL,
  `codi` VARCHAR(3) NULL,
  PRIMARY KEY (`num`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`pagament`
-- -----------------------------------------------------
CREATE TABLE `spotify`.`pagament` (
  `num_ordre` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `data` DATETIME NOT NULL,
  `total` DOUBLE NOT NULL,
  `id_usuari` INT UNSIGNED NOT NULL,
  `id_subscripcio` INT UNSIGNED NOT NULL,
  `paypal_user` VARCHAR(45) NULL,
  `tarjeta` VARCHAR(45) NULL,
  PRIMARY KEY (`num_ordre`, `id_usuari`, `id_subscripcio`),
  INDEX `fk_pagament_2_idx` (`id_subscripcio` ASC) VISIBLE,
  INDEX `fk_pagament_1_idx` (`id_usuari` ASC) VISIBLE,
  INDEX `fk_pagament_3_idx` (`tarjeta` ASC) VISIBLE,
  CONSTRAINT `fk_pagament_1`
    FOREIGN KEY (`id_usuari`)
    REFERENCES `spotify`.`usuari` (`id`),
  CONSTRAINT `fk_pagament_2`
    FOREIGN KEY (`id_subscripcio`)
    REFERENCES `spotify`.`subscripcio` (`id`),
  CONSTRAINT `fk_pagament_3`
    FOREIGN KEY (`tarjeta`)
    REFERENCES `spotify`.`tarjeta` (`num`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`playlist`
-- -----------------------------------------------------
CREATE TABLE `spotify`.`playlist` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `titol` VARCHAR(45) NOT NULL,
  `n_cancons` INT UNSIGNED NOT NULL,
  `data_creacio` DATETIME NOT NULL,
  `data_esborrat` DATETIME NULL,
  `pertany` INT UNSIGNED NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_playlist_1_idx` (`pertany` ASC) VISIBLE,
  CONSTRAINT `fk_playlist_1`
    FOREIGN KEY (`pertany`)
    REFERENCES `spotify`.`usuari` (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`comparticio`
-- -----------------------------------------------------
CREATE TABLE `spotify`.`comparticio` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_playlist` INT UNSIGNED NOT NULL,
  `id_usuari` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`, `id_playlist`, `id_usuari`),
  INDEX `fk_comparticio_2_idx` (`id_playlist` ASC) VISIBLE,
  INDEX `fk_comparticio_1_idx` (`id_usuari` ASC) VISIBLE,
  CONSTRAINT `fk_comparticio_1`
    FOREIGN KEY (`id_usuari`)
    REFERENCES `spotify`.`usuari` (`id`),
  CONSTRAINT `fk_comparticio_2`
    FOREIGN KEY (`id_playlist`)
    REFERENCES `spotify`.`playlist` (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`artista`
-- -----------------------------------------------------
CREATE TABLE `spotify`.`artista` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NULL,
  `imatge` VARCHAR(255) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`album`
-- -----------------------------------------------------
CREATE TABLE `spotify`.`album` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `titol` VARCHAR(45) NOT NULL,
  `any` VARCHAR(4) NULL,
  `imatge` VARCHAR(255) NULL,
  `id_artista` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_album_1_idx` (`id_artista` ASC) VISIBLE,
  CONSTRAINT `fk_album_1`
    FOREIGN KEY (`id_artista`)
    REFERENCES `spotify`.`artista` (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`canco`
-- -----------------------------------------------------
CREATE TABLE `spotify`.`canco` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `titol` VARCHAR(45) NOT NULL,
  `durada_seg` INT UNSIGNED NULL,
  `n_reproduccions` INT UNSIGNED NOT NULL,
  `id_album` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_canco_1_idx` (`id_album` ASC) VISIBLE,
  CONSTRAINT `fk_canco_1`
    FOREIGN KEY (`id_album`)
    REFERENCES `spotify`.`album` (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`afegiment`
-- -----------------------------------------------------
CREATE TABLE `spotify`.`afegiment` (
  `id_comparticio` INT UNSIGNED NOT NULL,
  `id_canco` INT UNSIGNED NOT NULL,
  `data` DATETIME NOT NULL,
  PRIMARY KEY (`id_comparticio`, `id_canco`),
  INDEX `fk_afegiment_2_idx` (`id_canco` ASC) VISIBLE,
  CONSTRAINT `fk_afegiment_1`
    FOREIGN KEY (`id_comparticio`)
    REFERENCES `spotify`.`comparticio` (`id`),
  CONSTRAINT `fk_afegiment_2`
    FOREIGN KEY (`id_canco`)
    REFERENCES `spotify`.`canco` (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`seguiment`
-- -----------------------------------------------------
CREATE TABLE `spotify`.`seguiment` (
  `id_usuari` INT UNSIGNED NOT NULL,
  `id_artista` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_usuari`, `id_artista`),
  INDEX `fk_seguiment_2_idx` (`id_artista` ASC) VISIBLE,
  CONSTRAINT `fk_seguiment_1`
    FOREIGN KEY (`id_usuari`)
    REFERENCES `spotify`.`usuari` (`id`),
  CONSTRAINT `fk_seguiment_2`
    FOREIGN KEY (`id_artista`)
    REFERENCES `spotify`.`artista` (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`relacionat`
-- -----------------------------------------------------
CREATE TABLE `spotify`.`relacionat` (
  `id_artista` INT UNSIGNED NOT NULL,
  `artista_relacionat` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_artista`, `artista_relacionat`),
  INDEX `fk_relacionat_2_idx` (`artista_relacionat` ASC) VISIBLE,
  CONSTRAINT `fk_relacionat_1`
    FOREIGN KEY (`id_artista`)
    REFERENCES `spotify`.`artista` (`id`),
  CONSTRAINT `fk_relacionat_2`
    FOREIGN KEY (`artista_relacionat`)
    REFERENCES `spotify`.`artista` (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`album_favorit`
-- -----------------------------------------------------
CREATE TABLE `spotify`.`album_favorit` (
  `id_usuari` INT UNSIGNED NOT NULL,
  `id_album` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_usuari`, `id_album`),
  INDEX `fk_album_favorit_2_idx` (`id_album` ASC) VISIBLE,
  CONSTRAINT `fk_album_favorit_1`
    FOREIGN KEY (`id_usuari`)
    REFERENCES `spotify`.`usuari` (`id`),
  CONSTRAINT `fk_album_favorit_2`
    FOREIGN KEY (`id_album`)
    REFERENCES `spotify`.`album` (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`canco_favorita`
-- -----------------------------------------------------
CREATE TABLE `spotify`.`canco_favorita` (
  `id_usuari` INT UNSIGNED NOT NULL,
  `id_canco` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_usuari`, `id_canco`),
  INDEX `fk_canco_favorita_2_idx` (`id_canco` ASC) VISIBLE,
  CONSTRAINT `fk_canco_favorita_1`
    FOREIGN KEY (`id_usuari`)
    REFERENCES `spotify`.`usuari` (`id`),
  CONSTRAINT `fk_canco_favorita_2`
    FOREIGN KEY (`id_canco`)
    REFERENCES `spotify`.`canco` (`id`))
ENGINE = InnoDB;
