-- -----------------------------------------------------
-- Schema youtube
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `youtube` ;

-- -----------------------------------------------------
-- Schema youtube
-- -----------------------------------------------------
CREATE SCHEMA `youtube` ;
USE `youtube` ;

-- -----------------------------------------------------
-- Table `youtube`.`usuari`
-- -----------------------------------------------------
CREATE TABLE `youtube`.`usuari` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `data_neixament` DATE NULL,
  `sexe` VARCHAR(45) NULL,
  `pais` VARCHAR(45) NULL,
  `cp` VARCHAR(45) NULL,
  `nom_canal` VARCHAR(45) NULL,
  `descripcio_canal` VARCHAR(45) NULL,
  `data_creacio_canal` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`video`
-- -----------------------------------------------------
CREATE TABLE `youtube`.`video` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `titol` VARCHAR(45) NOT NULL,
  `descripcio` VARCHAR(255) NULL,
  `mida` VARCHAR(45) NULL,
  `arxiu` VARCHAR(45) NOT NULL,
  `durada` VARCHAR(45) NULL,
  `thumb` VARCHAR(45) NULL,
  `n_reproduccions` INT UNSIGNED NOT NULL,
  `n_likes` INT UNSIGNED NOT NULL,
  `n_dislikes` INT UNSIGNED NOT NULL,
  `publicat_per` INT UNSIGNED NOT NULL,
  `estat` ENUM('public', 'ocult', 'privat') NOT NULL,
  `data_publicacio` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_video_1_idx` (`publicat_per` ASC) VISIBLE,
  CONSTRAINT `fk_video_1`
    FOREIGN KEY (`publicat_per`)
    REFERENCES `youtube`.`usuari` (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`etiqueta`
-- -----------------------------------------------------
CREATE TABLE `youtube`.`etiqueta` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`etiquetat`
-- -----------------------------------------------------
CREATE TABLE `youtube`.`etiquetat` (
  `id_video` INT UNSIGNED NOT NULL,
  `id_etiqueta` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_video`, `id_etiqueta`),
  INDEX `fk_etiquetat_2_idx` (`id_etiqueta` ASC) VISIBLE,
  CONSTRAINT `fk_etiquetat_1`
    FOREIGN KEY (`id_video`)
    REFERENCES `youtube`.`video` (`id`),
  CONSTRAINT `fk_etiquetat_2`
    FOREIGN KEY (`id_etiqueta`)
    REFERENCES `youtube`.`etiqueta` (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`subscripcio`
-- -----------------------------------------------------
CREATE TABLE `youtube`.`subscripcio` (
  `id_usuari` INT UNSIGNED NOT NULL,
  `id_canal` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_usuari`, `id_canal`),
  INDEX `fk_subscripcio_2_idx` (`id_canal` ASC) VISIBLE,
  CONSTRAINT `fk_subscripcio_1`
    FOREIGN KEY (`id_usuari`)
    REFERENCES `youtube`.`usuari` (`id`),
  CONSTRAINT `fk_subscripcio_2`
    FOREIGN KEY (`id_canal`)
    REFERENCES `youtube`.`usuari` (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`like`
-- -----------------------------------------------------
CREATE TABLE `youtube`.`like` (
  `id_usuari` INT UNSIGNED NOT NULL,
  `id_video` INT UNSIGNED NOT NULL,
  `datahora` DATETIME NOT NULL,
  `like` TINYINT NOT NULL,
  PRIMARY KEY (`id_usuari`, `id_video`),
  INDEX `fk_dislike_2_idx` (`id_video` ASC) VISIBLE,
  CONSTRAINT `fk_like_1`
    FOREIGN KEY (`id_usuari`)
    REFERENCES `youtube`.`usuari` (`id`),
  CONSTRAINT `fk_like_2`
    FOREIGN KEY (`id_video`)
    REFERENCES `youtube`.`video` (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`playlist`
-- -----------------------------------------------------
CREATE TABLE `youtube`.`playlist` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `data_creacio` DATETIME NOT NULL,
  `estat` ENUM('public', 'privat') NOT NULL,
  `id_usuari` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`, `id_usuari`),
  INDEX `fk_playlist_1_idx` (`id_usuari` ASC) VISIBLE,
  CONSTRAINT `fk_playlist_1`
    FOREIGN KEY (`id_usuari`)
    REFERENCES `youtube`.`usuari` (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`comentari`
-- -----------------------------------------------------
CREATE TABLE `youtube`.`comentari` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `creat_per` INT UNSIGNED NOT NULL,
  `id_video` INT UNSIGNED NOT NULL,
  `datahora` DATETIME NOT NULL,
  `text` VARCHAR(255) NOT NULL,
  INDEX `fk_dislike_2_idx` (`id_video` ASC) VISIBLE,
  PRIMARY KEY (`id`, `creat_per`, `id_video`),
  CONSTRAINT `fk_like_10`
    FOREIGN KEY (`creat_per`)
    REFERENCES `youtube`.`usuari` (`id`),
  CONSTRAINT `fk_like_20`
    FOREIGN KEY (`id_video`)
    REFERENCES `youtube`.`video` (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`agrada`
-- -----------------------------------------------------
CREATE TABLE `youtube`.`agrada` (
  `id_comentari` INT UNSIGNED NOT NULL,
  `id_usuari` INT UNSIGNED NOT NULL,
  `datahora` DATETIME NOT NULL,
  `agrada` TINYINT NOT NULL,
  PRIMARY KEY (`id_comentari`, `id_usuari`),
  INDEX `fk_agrada_1_idx` (`id_usuari` ASC) VISIBLE,
  CONSTRAINT `fk_agrada_1`
    FOREIGN KEY (`id_usuari`)
    REFERENCES `youtube`.`usuari` (`id`),
  CONSTRAINT `fk_agrada_2`
    FOREIGN KEY (`id_comentari`)
    REFERENCES `youtube`.`comentari` (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`contingut_playlist`
-- -----------------------------------------------------
CREATE TABLE `youtube`.`contingut_playlist` (
  `id_playlist` INT UNSIGNED NOT NULL,
  `id_video` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_playlist`, `id_video`),
  INDEX `fk_contingut_playlist_2_idx` (`id_video` ASC) VISIBLE,
  CONSTRAINT `fk_contingut_playlist_1`
    FOREIGN KEY (`id_playlist`)
    REFERENCES `youtube`.`playlist` (`id`),
  CONSTRAINT `fk_contingut_playlist_2`
    FOREIGN KEY (`id_video`)
    REFERENCES `youtube`.`video` (`id`))
ENGINE = InnoDB;

