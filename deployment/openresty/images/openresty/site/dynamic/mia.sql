-- -----------------------------------------------------
-- Table `content_series`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `content_series` ;

CREATE TABLE IF NOT EXISTS `content_series` (
  `content_series_cuid` VARCHAR(32) NOT NULL,
  `content_series_shortvalue` VARCHAR(255) NULL,
  `content_series_displayvalue` VARCHAR(255) NULL,
  `content_series_abbrev` VARCHAR(45) NULL,
  `content_series_description` TEXT NULL,
  `content_series_ordering` INT NULL,
  `content_series_status` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`content_series_cuid`),
  INDEX `fk_content_series_attribute_status1_idx` (`content_series_status` ASC),
  CONSTRAINT `fk_content_series_attribute_status1`
    FOREIGN KEY (`content_series_status`)
    REFERENCES `attribute_status` (`attribute_status_value`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `content_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `content_type` ;

CREATE TABLE IF NOT EXISTS `content_type` (
  `content_type_cuid` VARCHAR(32) NOT NULL,
  `content_type_shortvalue` VARCHAR(255) NULL,
  `content_type_displayvalue` VARCHAR(255) NULL,
  `content_type_abbrev` VARCHAR(45) NULL,
  `content_type_description` TEXT NULL,
  `content_type_ordering` INT NULL,
  `content_type_status` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`content_type_cuid`),
  INDEX `fk_content_type_attribute_status1_idx` (`content_type_status` ASC),
  CONSTRAINT `fk_content_type_attribute_status1`
    FOREIGN KEY (`content_type_status`)
    REFERENCES `attribute_status` (`attribute_status_value`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `content`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `content` ;

CREATE TABLE IF NOT EXISTS `content` (
  `c_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `c_code` VARCHAR(32) NOT NULL,
  `c_content_series_cuid` VARCHAR(32) NOT NULL,
  `c_content_type_cuid` VARCHAR(32) NOT NULL,
  `c_cover_title` VARCHAR(255) NULL,
  `c_abbrev_title` VARCHAR(40) NULL,
  `c_word_count` VARCHAR(45) NULL,
  `c_page_count` INT UNSIGNED NULL,
  `c_description` TEXT NULL,
  `c_keywords` TEXT NULL,
  `c_created` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `c_updated` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `c_datum_status` INT NOT NULL,
  `c_notes` TEXT NULL,
  PRIMARY KEY (`c_id`),
  UNIQUE INDEX `C_CODE_UNIQUE` (`c_code` ASC),
  INDEX `TITLE` (`c_title` ASC),
  INDEX `fk_content_content_type1_idx` (`c_content_type_cuid` ASC),
  INDEX `fk_content_content_series1_idx` (`c_content_series_cuid` ASC),
  INDEX `C_CODE` (`c_code` ASC),
  INDEX `fk_content_datum_status1` (`c_datum_status` ASC),
  CONSTRAINT `fk_content_datum_status1`
    FOREIGN KEY (`c_datum_status`)
    REFERENCES `datum_status` (`datum_status_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_content_content_series1`
    FOREIGN KEY (`c_content_series_cuid`)
    REFERENCES `content_series` (`content_series_cuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_content_content_type1`
    FOREIGN KEY (`c_content_type_cuid`)
    REFERENCES `content_type` (`content_type_cuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `instance_delivery_format`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `instance_delivery_format` ;

CREATE TABLE IF NOT EXISTS `component_delivery_format` (
  `instance_delivery_format_cuid` VARCHAR(32) NOT NULL,
  `instance_delivery_format_displayvalue` VARCHAR(255) NULL,
  `instance_delivery_format_abbrev` VARCHAR(45) NULL,
  `instance_delivery_format_description` TEXT NULL,
  `instance_delivery_format_ordering` INT NULL,
  `instance_delivery_format_status` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`instance_delivery_format_cuid`),
  INDEX `fk_instance_delivery_format_attribute_status1_idx` (`instance_delivery_format_status` ASC),
  INDEX `fk_instance_delivery_format_modality1_idx` (`instance_delivery_format_modality` ASC),
  CONSTRAINT `fk_instance_delivery_format_attribute_status1`
    FOREIGN KEY (`instance_delivery_format_status`)
    REFERENCES `attribute_status` (`attribute_status_value`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_instance_delivery_format_modality1`
    FOREIGN KEY (`instance_delivery_format_modality`)
    REFERENCES `modality` (`modality_value`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `instance_print_specification`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `instance_print_specification` ;

CREATE TABLE IF NOT EXISTS `instance_print_specification` (
  `instance_print_specification_cuid` VARCHAR(32) NOT NULL,
  `instance_print_specification_shortvalue` VARCHAR(255) NOT NULL,
  `instance_print_specification_displayvalue` VARCHAR(255) NULL,
  `instance_print_specification_abbrev` VARCHAR(45) NULL,
  `instance_print_specification_description` TEXT NULL,
  `instance_print_specification_size_wxh` VARCHAR(255) NULL,
  `instance_print_specification_size_d` VARCHAR(255) NULL,
  `instance_print_specification_weight_g` VARCHAR(45) NULL,
  `instance_print_specification_page_count` VARCHAR(255) NULL,
  `instance_print_specification_text_stock` VARCHAR(255) NULL,
  `instance_print_specification_cover_stock` TEXT NULL,
  `instance_print_specification_binding` VARCHAR(255) NULL,
  `instance_print_specification_print_text` VARCHAR(255) NULL,
  `instance_print_specification_print_cover` VARCHAR(255) NULL,
  `instance_print_specification_finishing` TEXT NULL,
  `instance_print_specification_dieline` VARCHAR(255) NULL,
  `instance_print_specification_inserts` TEXT NULL,
  `instance_print_specification_carton_pack_quantity` VARCHAR(255) NULL,
  `instance_print_specification_carton_size_lxwxh` VARCHAR(255) NULL,
  `instance_print_specification_carton_weight_kg` VARCHAR(255) CHARACTER SET 'utf8' NULL DEFAULT NULL,
  `instance_print_specification_ordering` INT NULL,
  `instance_print_specification_status` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`instance_print_specification_cuid`),
  UNIQUE INDEX `ps_name_UNIQUE` (`instance_print_specification_shortvalue` ASC),
  INDEX `fk_print_specification_attribute_status1_idx` (`instance_print_specification_status` ASC),
  CONSTRAINT `fk_print_specification_attribute_status1`
    FOREIGN KEY (`instance_print_specification_status`)
    REFERENCES `attribute_status` (`attribute_status_value`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `instance`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `instance` ;

CREATE TABLE IF NOT EXISTS `instance` (
  `i_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `i_c_code` VARCHAR(32) NOT NULL,
  `i_code` VARCHAR(32) NOT NULL,
  `i_external_id` VARCHAR(255) NULL,
  `i_external_url` VARCHAR(255) NULL,
  `i_image_url` VARCHAR(128) NULL,
  `i_instance_delivery_format_cuid` VARCHAR(32) NOT NULL,
  `i_instance_print_specification_cuid` VARCHAR(32) NULL,
  `i_created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `i_updated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `i_datum_status` INT NOT NULL,
  `i_notes` TEXT NULL,
  PRIMARY KEY (`i_id`),
  UNIQUE INDEX `I_CODE_UNIQUE` (`o_code` ASC),
  INDEX `fk_instance_content1_idx` (`o_c_code` ASC),
  INDEX `I_CODE` (`i_code` ASC),
  INDEX `fk_instance_instance_delivery_format1_idx` (`i_instance_delivery_format_cuid` ASC),
  INDEX `fk_instance_print_specification1_idx` (`i_instance_print_specification_cuid` ASC),
  INDEX `fk_instance_datum_status1` (`i_datum_status` ASC),
  CONSTRAINT `fk_instance_instance_delivery_format1`
    FOREIGN KEY (`i_instance_delivery_format_cuid`)
    REFERENCES `instance_delivery_format` (`instance_delivery_format_cuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_instance_datum_status1`
    FOREIGN KEY (`i_datum_status`)
    REFERENCES `datum_status` (`datum_status_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_component_content1`
    FOREIGN KEY (`i_c_code`)
    REFERENCES `content` (`c_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_component_print_specification1`
    FOREIGN KEY (`i_component_print_specification_cuid`)
    REFERENCES `component_print_specification` (`component_print_specification_cuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `program_component_program`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `program_component_program` ;

CREATE TABLE IF NOT EXISTS `program_component_program` (
  `program_component_program_cuid` VARCHAR(32) NOT NULL,
  `program_component_program_displayvalue` VARCHAR(255) NULL DEFAULT NULL,
  `program_component_program_abbrev` VARCHAR(45) NULL,
  `program_component_program_description` TEXT NULL,
  `program_component_program_ordering` INT NULL,
  `program_component_program_status` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`program_component_program_cuid`),
  INDEX `fk_program_component_program_attribute_status1_idx` (`program_component_program_status` ASC),
  CONSTRAINT `fk_program_component_program_attribute_status1`
    FOREIGN KEY (`program_component_program_status`)
    REFERENCES `attribute_status` (`attribute_status_value`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `program_component_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `program_component_type` ;

CREATE TABLE IF NOT EXISTS `program_component_type` (
  `program_component_type_cuid` VARCHAR(32) NOT NULL,
  `program_component_type_shortvalue` VARCHAR(255) NULL,
  `program_component_type_displayvalue` VARCHAR(255) NULL,
  `program_component_type_abbrev` VARCHAR(45) NULL,
  `program_component_type_description` TEXT NULL,
  `program_component_type_ordering` INT NULL,
  `program_component_type_status` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`program_component_type_cuid`),
  INDEX `fk_program_component_type_attribute_status1_idx` (`program_component_type_status` ASC),
  CONSTRAINT `fk_program_component_type_attribute_status1`
    FOREIGN KEY (`program_component_type_status`)
    REFERENCES `attribute_status` (`attribute_status_value`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `program_component`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `program_component` ;

CREATE TABLE IF NOT EXISTS `program_component` (
  `pc_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `pc_program_component_program_cuid` VARCHAR(32) NOT NULL,
  `pc_o_code` VARCHAR(32) NOT NULL,
  `pc_program_component_type_cuid` VARCHAR(32) NOT NULL,
  PRIMARY KEY (`pc_id`),
  INDEX `fk_program_component_program_component_program1_idx` (`pc_program_component_program_cuid` ASC),
  INDEX `fk_program_component_program_component_type1_idx` (`pc_program_component_type_cuid` ASC),
  INDEX `fk_program_component_component1_idx` (`pc_o_code` ASC),
  CONSTRAINT `fk_program_component_component1`
    FOREIGN KEY (`pc_o_code`)
    REFERENCES `component` (`o_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_program_component_program_component_program1`
    FOREIGN KEY (`pc_program_component_program_cuid`)
    REFERENCES `program_component_program` (`program_component_program_cuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_program_component_program_component_type1`
    FOREIGN KEY (`pc_program_component_type_cuid`)
    REFERENCES `program_component_type` (`program_component_type_cuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `content_content_relationship`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `content_content_relationship` ;

CREATE TABLE IF NOT EXISTS `content_content_relationship` (
  `content_content_relationship_cuid` VARCHAR(32) NOT NULL,
  `content_content_relationship_shortvalue` VARCHAR(255) NULL,
  `content_content_relationship_displayvalue` VARCHAR(255) NULL,
  `content_content_relationship_abbrev` VARCHAR(45) NULL,
  `content_content_relationship_description` TEXT NULL,
  `content_content_relationship_directionality` VARCHAR(45) NOT NULL DEFAULT 'UNI-DIRECTIONAL',
  `content_content_relationship_ordering` INT NULL,
  `content_content_relationship_status` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`content_content_relationship_cuid`),
  UNIQUE INDEX `content_content_relationship_cuid` (`content_content_relationship_cuid` ASC));


-- -----------------------------------------------------
-- Table `content_content_relationship_association`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `content_content_relationship_association` ;

CREATE TABLE IF NOT EXISTS `content_content_relationship_association` (
  `ccra_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `ccra_c_code_A` VARCHAR(32) NOT NULL,
  `ccra_content_content_relationship_cuid` VARCHAR(32) NOT NULL,
  `ccra_c_code_B` VARCHAR(32) NOT NULL,
  PRIMARY KEY (`ccra_id`),
  INDEX `fk_content_content_relationship_content2_idx` (`ccra_c_code_B` ASC),
  UNIQUE INDEX `NOT_THE_SAME_RELATIONSHIP_TWICE` (`ccra_c_code_A` ASC, `ccra_c_code_B` ASC, `ccra_content_content_relationship_cuid` ASC),
  INDEX `fk_content_content_relationship_rename_content_content_rela_idx` (`ccra_content_content_relationship_cuid` ASC),
  INDEX `fk_content_content_relationship_content1_idx` (`ccra_c_code_A` ASC),
  CONSTRAINT `fk_content_content_relationship_content1`
    FOREIGN KEY (`ccra_c_code_A`)
    REFERENCES `content` (`c_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_content_content_relationship_content2`
    FOREIGN KEY (`ccra_c_code_B`)
    REFERENCES `content` (`c_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_content_content_relationship_rename_content_content_relati1`
    FOREIGN KEY (`ccra_content_content_relationship_cuid`)
    REFERENCES `content_content_relationship` (`content_content_relationship_cuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



-- -----------------------------------------------------
-- Table `assembly_product_line`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `assembly_product_line` ;

CREATE TABLE IF NOT EXISTS `assembly_product_line` (
  `assembly_product_line_cuid` VARCHAR(32) NOT NULL,
  `assembly_product_line_shortvalue` VARCHAR(255) NULL,
  `assembly_product_line_publisher` VARCHAR(25) NULL,
  `assembly_product_line_displayvalue` VARCHAR(255) NULL,
  `assembly_product_line_abbrev` VARCHAR(45) NULL,
  `assembly_product_line_description` TEXT NULL,
  `assembly_product_line_ordering` INT NULL,
  `assembly_product_line_status` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`assembly_product_line_cuid`),
  INDEX `fk_assembly_product_line_attribute_status1_idx` (`assembly_product_line_status` ASC),
  INDEX `fk_assembly_product_line_publisher1_idx` (`assembly_product_line_publisher` ASC),
  CONSTRAINT `fk_assembly_product_line_publisher1`
    FOREIGN KEY (`assembly_product_line_publisher`)
    REFERENCES `publisher` (`publisher_value`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_assembly_product_line_attribute_status1`
    FOREIGN KEY (`assembly_product_line_status`)
    REFERENCES `attribute_status` (`attribute_status_value`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `assembly_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `assembly_type` ;

CREATE TABLE IF NOT EXISTS `assembly_type` (
  `assembly_type_cuid` VARCHAR(32) NOT NULL,
  `assembly_type_shortvalue` VARCHAR(255) NULL,
  `assembly_type_displayvalue` VARCHAR(255) NULL,
  `assembly_type_abbrev` VARCHAR(45) NULL,
  `assembly_type_description` TEXT NULL,
  `assembly_type_ordering` INT NULL,
  `assembly_type_status` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`assembly_type_cuid`),
  INDEX `fk_assembly_type_attribute_status1_idx` (`assembly_type_status` ASC),
  CONSTRAINT `fk_assembly_type_attribute_status1`
    FOREIGN KEY (`assembly_type_status`)
    REFERENCES `attribute_status` (`attribute_status_value`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);



-- -----------------------------------------------------
-- Table `assembly`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `assembly` ;

CREATE TABLE IF NOT EXISTS `assembly` (
  `a_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `a_code` VARCHAR(32) NOT NULL,
  `a_assembly_product_line_cuid` VARCHAR(32) NOT NULL,
  `a_assembly_family_id` INT UNSIGNED NOT NULL,
  `a_assembly_type_cuid` VARCHAR(32) NOT NULL,
  `a_assembly_modality_cuid` VARCHAR(32) NOT NULL,
  `a_assembly_variation_cuid` VARCHAR(32) NOT NULL,
  `a_name` VARCHAR(255) NOT NULL,
  `a_abbrev_name` VARCHAR(40) NULL,
  `a_erp_name` VARCHAR(60) NULL,
  `a_override_erp_name` VARCHAR(60) NULL,
  `a_description` VARCHAR(255) NULL,
  `a_promotional_text` TEXT NULL,
  `a_legacy_product_code` VARCHAR(45) NULL,
  `a_internal_hash` VARCHAR(128) NULL,
  `a_simplified_hash` VARCHAR(128) NULL,
  `a_tlsh_digest` VARCHAR(134) NULL,
  `a_image_url` VARCHAR(128) NULL,
  `a_sole_source` TINYINT(1) NULL,
  `a_created` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `a_verified` TIMESTAMP NULL,
  `a_updated` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `a_assembly_recipe_json` TEXT NULL,
  `a_assembly_recipe_notes` TEXT NULL,
  `a_assembly_instructions` TEXT NULL,
  `a_notes` TEXT NULL,
  `a_datum_status` INT NOT NULL,
  PRIMARY KEY (`a_id`),
  UNIQUE INDEX `A_CODE_UNIQUE` (`a_code` ASC),
  UNIQUE INDEX `UNIQUE_ASSEMBLY` (`a_assembly_product_line_cuid` ASC, `a_assembly_family_id` ASC, `a_assembly_type_cuid` ASC, `a_assembly_modality_cuid` ASC, `a_assembly_variation_cuid` ASC),
  INDEX `A_CODE` (`a_code` ASC),
  INDEX `fk_assembly_assembly_type1_idx` (`a_assembly_type_cuid` ASC),
  INDEX `fk_assembly_assembly_modality1_idx` (`a_assembly_modality_cuid` ASC),
  INDEX `fk_assembly_assembly_product_line1_idx` (`a_assembly_product_line_cuid` ASC),
  INDEX `fk_assembly_assembly_variation1_idx` (`a_assembly_variation_cuid` ASC),
  INDEX `fk_assembly_assembly_family1_idx` (`a_assembly_family_id` ASC),
  INDEX `fk_assembly_datum_status1` (`a_datum_status` ASC),
  CONSTRAINT `fk_assembly_datum_status1`
    FOREIGN KEY (`a_datum_status`)
    REFERENCES `datum_status` (`datum_status_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_assembly_assembly_family1`
    FOREIGN KEY (`a_assembly_family_id`)
    REFERENCES `assembly_family` (`af_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_assembly_assembly_modality1`
    FOREIGN KEY (`a_assembly_modality_cuid`)
    REFERENCES `assembly_modality` (`assembly_modality_cuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_assembly_assembly_product_line1`
    FOREIGN KEY (`a_assembly_product_line_cuid`)
    REFERENCES `assembly_product_line` (`assembly_product_line_cuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_assembly_assembly_type1`
    FOREIGN KEY (`a_assembly_type_cuid`)
    REFERENCES `assembly_type` (`assembly_type_cuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_assembly_assembly_variation1`
    FOREIGN KEY (`a_assembly_variation_cuid`)
    REFERENCES `assembly_variation` (`assembly_variation_cuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `content_area`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `content_area` ;

CREATE TABLE IF NOT EXISTS `content_area` (
  `content_area_cuid` VARCHAR(32) NOT NULL,
  `content_area_shortvalue` VARCHAR(255) NULL,
  `content_area_displayvalue` VARCHAR(255) NULL,
  `content_area_abbrev` VARCHAR(45) NULL,
  `content_area_description` TEXT NULL,
  `content_area_ordering` INT NULL,
  `content_area_status` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`content_area_cuid`),
  INDEX `fk_content_area_attribute_status1_idx` (`content_area_status` ASC),
  CONSTRAINT `fk_content_area_attribute_status1`
    FOREIGN KEY (`content_area_status`)
    REFERENCES `attribute_status` (`attribute_status_value`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `content_area_association`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `content_area_association` ;

CREATE TABLE IF NOT EXISTS `content_area_association` (
  `caa_content_area_association_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `caa_c_code` VARCHAR(32) NOT NULL,
  `caa_content_area_cuid` VARCHAR(32) NOT NULL,
  PRIMARY KEY (`caa_content_area_association_id`),
  INDEX `fk_content_area_association_content1_idx` (`caa_c_code` ASC),
  INDEX `fk_content_area_association_content_area1_idx` (`caa_content_area_cuid` ASC),
  UNIQUE INDEX `NOT_THE_SAME_ASSOCIATION_TWICE` (`caa_c_code` ASC, `caa_content_area_cuid` ASC),
  CONSTRAINT `fk_content_area_association_content1`
    FOREIGN KEY (`caa_c_code`)
    REFERENCES `content` (`c_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_content_area_association_content_area1`
    FOREIGN KEY (`caa_content_area_cuid`)
    REFERENCES `content_area` (`content_area_cuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

    
-- -----------------------------------------------------
-- Table `content_genre`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `content_genre` ;

CREATE TABLE IF NOT EXISTS `content_genre` (
  `content_genre_cuid` VARCHAR(32) NOT NULL,
  `content_genre_shortvalue` VARCHAR(255) NULL,
  `content_genre_displayvalue` VARCHAR(255) NULL,
  `content_genre_abbrev` VARCHAR(45) NULL,
  `content_genre_description` TEXT NULL,
  `content_genre_ordering` INT NULL,
  `content_genre_status` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`content_genre_cuid`),
  INDEX `fk_content_genre_attribute_status1_idx` (`content_genre_status` ASC),
  CONSTRAINT `fk_content_genre_attribute_status1`
    FOREIGN KEY (`content_genre_status`)
    REFERENCES `attribute_status` (`attribute_status_value`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `content_genre_association`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `content_genre_association` ;

CREATE TABLE IF NOT EXISTS `content_genre_association` (
  `cga_content_genre_association_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `cga_c_code` VARCHAR(32) NOT NULL,
  `cga_content_genre_cuid` VARCHAR(32) NOT NULL,
  PRIMARY KEY (`cga_content_genre_association_id`),
  INDEX `fk_content_genre_association_content_genre1_idx` (`cga_content_genre_cuid` ASC),
  INDEX `fk_content_genre_association_content1_idx` (`cga_c_code` ASC),
  UNIQUE INDEX `NOT_THE_SAME_ASSOCIATION_TWICE` (`cga_c_code` ASC, `cga_content_genre_cuid` ASC),
  CONSTRAINT `fk_content_genre_association_content_genre1`
    FOREIGN KEY (`cga_content_genre_cuid`)
    REFERENCES `content_genre` (`content_genre_cuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_content_genre_association_content1`
    FOREIGN KEY (`cga_c_code`)
    REFERENCES `content` (`c_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `content_language`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `content_language` ;

CREATE TABLE IF NOT EXISTS `content_language` (
  `content_language_cuid` VARCHAR(32) NOT NULL,
  `content_language_shortvalue` VARCHAR(255) NULL,
  `content_language_displayvalue` VARCHAR(255) NULL,
  `content_language_abbrev` VARCHAR(45) NULL,
  `content_language_description` TEXT NULL,
  `content_language_ordering` INT NULL,
  `content_language_status` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`content_language_cuid`),
  INDEX `fk_content_language_attribute_status1_idx` (`content_language_status` ASC),
  CONSTRAINT `fk_content_language_attribute_status1`
    FOREIGN KEY (`content_language_status`)
    REFERENCES `attribute_status` (`attribute_status_value`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `content_language_association`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `content_language_association` ;

CREATE TABLE IF NOT EXISTS `content_language_association` (
  `cla_content_language_association_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `cla_c_code` VARCHAR(32) NOT NULL,
  `cla_content_language_cuid` VARCHAR(32) NOT NULL,
  PRIMARY KEY (`cla_content_language_association_id`),
  INDEX `fk_content_language_association_content1_idx` (`cla_c_code` ASC),
  INDEX `fk_content_language_association_content_language1_idx` (`cla_content_language_cuid` ASC),
  UNIQUE INDEX `NOT_THE_SAME_ASSOCIATION_TWICE` (`cla_c_code` ASC, `cla_content_language_cuid` ASC),
  CONSTRAINT `fk_content_language_association_content1`
    FOREIGN KEY (`cla_c_code`)
    REFERENCES `content` (`c_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_content_language_association_content_language1`
    FOREIGN KEY (`cla_content_language_cuid`)
    REFERENCES `content_language` (`content_language_cuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `content_lexile`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `content_lexile` ;

CREATE TABLE IF NOT EXISTS `content_lexile` (
  `content_lexile_cuid` VARCHAR(32) NOT NULL,
  `content_lexile_shortvalue` VARCHAR(255) NULL,
  `content_lexile_displayvalue` VARCHAR(255) NULL,
  `content_lexile_abbrev` VARCHAR(45) NULL,
  `content_lexile_description` TEXT NULL,
  `content_lexile_ordering` INT NULL,
  `content_lexile_status` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`content_lexile_cuid`),
  INDEX `fk_content_lexile_attribute_status1_idx` (`content_lexile_status` ASC),
  CONSTRAINT `fk_content_lexile_attribute_status1`
    FOREIGN KEY (`content_lexile_status`)
    REFERENCES `attribute_status` (`attribute_status_value`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `content_lexile_association`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `content_lexile_association` ;

CREATE TABLE IF NOT EXISTS `content_lexile_association` (
  `cla_content_lexile_association_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `cla_c_code` VARCHAR(32) NOT NULL,
  `cla_content_lexile_cuid` VARCHAR(32) NOT NULL,
  PRIMARY KEY (`cla_content_lexile_association_id`),
  INDEX `fk_content_lexile_association_content1_idx` (`cla_c_code` ASC),
  INDEX `fk_content_lexile_association_content_lexile1_idx` (`cla_content_lexile_cuid` ASC),
  UNIQUE INDEX `NOT_THE_SAME_ASSOCIATION_TWICE` (`cla_c_code` ASC, `cla_content_lexile_cuid` ASC),
  CONSTRAINT `fk_content_lexile_association_content1`
    FOREIGN KEY (`cla_c_code`)
    REFERENCES `content` (`c_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_content_lexile_association_content_lexile1`
    FOREIGN KEY (`cla_content_lexile_cuid`)
    REFERENCES `content_lexile` (`content_lexile_cuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `content_localized_for`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `content_localized_for` ;

CREATE TABLE IF NOT EXISTS `content_localized_for` (
  `content_localized_for_cuid` VARCHAR(32) NOT NULL,
  `content_localized_for_shortvalue` VARCHAR(255) NULL,
  `content_localized_for_displayvalue` VARCHAR(255) NULL,
  `content_localized_for_abbrev` VARCHAR(45) NULL,
  `content_localized_for_description` TEXT NULL,
  `content_localized_for_ordering` INT NULL,
  `content_localized_for_status` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`content_localized_for_cuid`),
  INDEX `fk_content_localized_for_attribute_status1_idx` (`content_localized_for_status` ASC),
  CONSTRAINT `fk_content_localized_for_attribute_status1`
    FOREIGN KEY (`content_localized_for_status`)
    REFERENCES `attribute_status` (`attribute_status_value`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `content_localized_for_association`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `content_localized_for_association` ;

CREATE TABLE IF NOT EXISTS `content_localized_for_association` (
  `clfa_content_localized_for_association_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `clfa_c_code` VARCHAR(32) NOT NULL,
  `clfa_content_localized_for_cuid` VARCHAR(32) NOT NULL,
  PRIMARY KEY (`clfa_content_localized_for_association_id`),
  INDEX `fk_content_localized_for_association_content_localized_for1_idx` (`clfa_content_localized_for_cuid` ASC),
  INDEX `fk_content_localized_for_association_content1_idx` (`clfa_c_code` ASC),
  UNIQUE INDEX `NOT_THE_SAME_ASSOCIATION_TWICE` (`clfa_c_code` ASC, `clfa_content_localized_for_cuid` ASC),
  CONSTRAINT `fk_content_localized_for_association_content_localized_for1`
    FOREIGN KEY (`clfa_content_localized_for_cuid`)
    REFERENCES `content_localized_for` (`content_localized_for_cuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_content_localized_for_association_content1`
    FOREIGN KEY (`clfa_c_code`)
    REFERENCES `content` (`c_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);



-- -----------------------------------------------------
-- Table `content_series_parent`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `content_series_parent` ;

CREATE TABLE IF NOT EXISTS `content_series_parent` (
  `content_series_parent_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `content_series_parent_name` VARCHAR(100) NULL,
  `content_series_cuid` VARCHAR(32) NULL,
  PRIMARY KEY (`content_series_parent_id`),
  INDEX `fk_content_series_parent_content_series1_idx` (`content_series_cuid` ASC),
  CONSTRAINT `fk_content_series_parent_content_series1`
    FOREIGN KEY (`content_series_cuid`)
    REFERENCES `content_series` (`content_series_cuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `assembly_hierarchical_ordering`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `assembly_hierarchical_ordering` ;

CREATE TABLE IF NOT EXISTS `assembly_hierarchical_ordering` (
  `aho_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `aho_a_code` VARCHAR(32) NULL,
  `aho_ordering` INT UNSIGNED NULL,
  `aho_contains_o_code` VARCHAR(32) NULL,
  `aho_contains_a_code` VARCHAR(32) NULL,
  PRIMARY KEY (`aho_id`),
  INDEX `fk_assembly_internal_ordering_assembly1_idx` (`aho_a_code` ASC),
  INDEX `fk_assembly_internal_ordering_assembly2_idx` (`aho_contains_a_code` ASC),
  INDEX `fk_assembly_internal_ordering_component1_idx` (`aho_contains_o_code` ASC),
  CONSTRAINT `fk_assembly_internal_ordering_assembly1`
    FOREIGN KEY (`aho_a_code`)
    REFERENCES `assembly` (`a_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_assembly_internal_ordering_assembly2`
    FOREIGN KEY (`aho_contains_a_code`)
    REFERENCES `assembly` (`a_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_assembly_internal_ordering_component1`
    FOREIGN KEY (`aho_contains_o_code`)
    REFERENCES `component` (`o_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);



-- -----------------------------------------------------
-- Table `component_print_specification_association`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `component_print_specification_association` ;

CREATE TABLE IF NOT EXISTS `component_print_specification_association` (
  `cpsa_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `cpsa_component_print_specification_cuid` VARCHAR(32) NULL,
  `cpsa_content_series_cuid` VARCHAR(32) NULL,
  `cpsa_content_type_cuid` VARCHAR(32) NULL,
  `cpsa_component_delivery_format_cuid` VARCHAR(32) NULL,
  `cpsa_notes` TEXT NULL,
  PRIMARY KEY (`cpsa_id`),
  UNIQUE INDEX `UNIQUE_ASSOCIATION` (`cpsa_component_print_specification_cuid` ASC, `cpsa_content_series_cuid` ASC, `cpsa_content_type_cuid` ASC, `cpsa_component_delivery_format_cuid` ASC),
  INDEX `fk_print_specification_association_print_specification1_idx` (`cpsa_component_print_specification_cuid` ASC),
  INDEX `fk_print_specification_association_content_series1_idx` (`cpsa_content_series_cuid` ASC),
  INDEX `fk_print_specification_association_content_type1_idx` (`cpsa_content_type_cuid` ASC),
  INDEX `fk_print_specification_association_component_delivery_format1` (`cpsa_component_delivery_format_cuid` ASC),
  CONSTRAINT `fk_print_specification_association_print_specification1`
    FOREIGN KEY (`cpsa_component_print_specification_cuid`)
    REFERENCES `component_print_specification` (`component_print_specification_cuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_print_specification_association_content_series1`
    FOREIGN KEY (`cpsa_content_series_cuid`)
    REFERENCES `content_series` (`content_series_cuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_print_specification_association_component_delivery_format1`
    FOREIGN KEY (`cpsa_component_delivery_format_cuid`)
    REFERENCES `component_delivery_format` (`component_delivery_format_cuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_print_specification_association_content_type1`
    FOREIGN KEY (`cpsa_content_type_cuid`)
    REFERENCES `content_type` (`content_type_cuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;




-- -----------------------------------------------------
-- Table `program_component_unit`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `program_component_unit` ;

CREATE TABLE IF NOT EXISTS `program_component_unit` (
  `program_component_unit_cuid` VARCHAR(32) NOT NULL,
  `program_component_unit_shortvalue` VARCHAR(255) NULL,
  `program_component_unit_displayvalue` VARCHAR(255) NULL,
  `program_component_unit_abbrev` VARCHAR(45) NULL,
  `program_component_unit_description` TEXT NULL,
  `program_component_unit_ordering` INT NULL,
  `program_component_unit_status` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`program_component_unit_cuid`),
  INDEX `fk_program_component_unit_attribute_status1_idx` (`program_component_unit_status` ASC),
  CONSTRAINT `fk_program_component_unit_attribute_status1`
    FOREIGN KEY (`program_component_unit_status`)
    REFERENCES `attribute_status` (`attribute_status_value`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `program_component_unit_association`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `program_component_unit_association` ;

CREATE TABLE IF NOT EXISTS `program_component_unit_association` (
  `pcua_program_component_unit_association_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `pcua_pc_id` INT UNSIGNED NOT NULL,
  `pcua_program_component_unit_cuid` VARCHAR(32) NOT NULL,
  PRIMARY KEY (`pcua_program_component_unit_association_id`),
  UNIQUE INDEX `NOT_THE_SAME_ASSOCIATION_TWICE` (`pcua_pc_id` ASC, `pcua_program_component_unit_cuid` ASC),
  INDEX `fk_program_component_unit_association_program_component_uni_idx` (`pcua_program_component_unit_cuid` ASC),
  INDEX `fk_program_component_unit_association_program_component1_idx` (`pcua_pc_id` ASC),
  CONSTRAINT `fk_program_component_unit_association_program_component1`
    FOREIGN KEY (`pcua_pc_id`)
    REFERENCES `program_component` (`pc_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_program_component_unit_association_program_component_unit1`
    FOREIGN KEY (`pcua_program_component_unit_cuid`)
    REFERENCES `program_component_unit` (`program_component_unit_cuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);



-- -----------------------------------------------------
-- Table `program_component_week`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `program_component_week` ;

CREATE TABLE IF NOT EXISTS `program_component_week` (
  `program_component_week_cuid` VARCHAR(32) NOT NULL,
  `program_component_week_shortvalue` VARCHAR(255) NULL,
  `program_component_week_displayvalue` VARCHAR(255) NULL,
  `program_component_week_abbrev` VARCHAR(45) NULL,
  `program_component_week_description` TEXT NULL,
  `program_component_week_ordering` INT NULL,
  `program_component_week_status` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`program_component_week_cuid`),
  INDEX `fk_program_component_week_attribute_status1_idx` (`program_component_week_status` ASC),
  CONSTRAINT `fk_program_component_week_attribute_status1`
    FOREIGN KEY (`program_component_week_status`)
    REFERENCES `attribute_status` (`attribute_status_value`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `program_component_week_association`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `program_component_week_association` ;

CREATE TABLE IF NOT EXISTS `program_component_week_association` (
  `pcwa_program_component_week_association_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `pcwa_pc_id` INT UNSIGNED NOT NULL,
  `pcwa_program_component_week_cuid` VARCHAR(32) NOT NULL,
  PRIMARY KEY (`pcwa_program_component_week_association_id`),
  INDEX `fk_program_component_week_association_program_component1_idx` (`pcwa_pc_id` ASC),
  INDEX `fk_program_component_week_association_program_component_wee_idx` (`pcwa_program_component_week_cuid` ASC),
  INDEX `NOT_THE_SAME_ASSOCIATION_TWICE` (`pcwa_pc_id` ASC, `pcwa_program_component_week_cuid` ASC),
  CONSTRAINT `fk_program_component_week_association_program_component1`
    FOREIGN KEY (`pcwa_pc_id`)
    REFERENCES `program_component` (`pc_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_program_component_week_association_program_component_week1`
    FOREIGN KEY (`pcwa_program_component_week_cuid`)
    REFERENCES `program_component_week` (`program_component_week_cuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `program_component_instructional_setting`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `program_component_instructional_setting` ;

CREATE TABLE IF NOT EXISTS `program_component_instructional_setting` (
  `program_component_instructional_setting_cuid` VARCHAR(32) NOT NULL,
  `program_component_instructional_setting_shortvalue` VARCHAR(255) NULL,
  `program_component_instructional_setting_displayvalue` VARCHAR(255) NULL,
  `program_component_instructional_setting_abbrev` VARCHAR(45) NULL,
  `program_component_instructional_setting_description` TEXT NULL,
  `program_component_instructional_setting_ordering` INT NULL,
  `program_component_instructional_setting_status` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`program_component_instructional_setting_cuid`),
  INDEX `fk_program_component_instructional_setting_attribute_status_idx` (`program_component_instructional_setting_status` ASC),
  CONSTRAINT `fk_program_component_instructional_setting_attribute_status1`
    FOREIGN KEY (`program_component_instructional_setting_status`)
    REFERENCES `attribute_status` (`attribute_status_value`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `program_component_instructional_setting_association`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `program_component_instructional_setting_association` ;

CREATE TABLE IF NOT EXISTS `program_component_instructional_setting_association` (
  `pcisa_program_component_instructional_setting_association_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `pcisa_pc_id` INT UNSIGNED NOT NULL,
  `pcisa_program_component_instructional_setting_cuid` VARCHAR(32) NOT NULL,
  PRIMARY KEY (`pcisa_program_component_instructional_setting_association_id`),
  INDEX `fk_program_component_instructional_setting_association_prog_idx` (`pcisa_program_component_instructional_setting_cuid` ASC),
  INDEX `fk_program_component_instructional_setting_association_prog_idx1` (`pcisa_pc_id` ASC),
  INDEX `NOT_THE_SAME_ASSOCIATION_TWICE` (`pcisa_pc_id` ASC, `pcisa_program_component_instructional_setting_cuid` ASC),
  CONSTRAINT `fk_program_component_instructional_setting_association_progra1`
    FOREIGN KEY (`pcisa_program_component_instructional_setting_cuid`)
    REFERENCES `program_component_instructional_setting` (`program_component_instructional_setting_cuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_program_component_instructional_setting_association_progra2`
    FOREIGN KEY (`pcisa_pc_id`)
    REFERENCES `program_component` (`pc_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `program_component_grade`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `program_component_grade` ;

CREATE TABLE IF NOT EXISTS `program_component_grade` (
  `program_component_grade_cuid` VARCHAR(32) NOT NULL,
  `program_component_grade_shortvalue` VARCHAR(255) NULL,
  `program_component_grade_displayvalue` VARCHAR(255) NULL,
  `program_component_grade_abbrev` VARCHAR(45) NULL,
  `program_component_grade_description` TEXT NULL,
  `program_component_grade_ordering` INT NULL,
  `program_component_grade_status` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`program_component_grade_cuid`),
  INDEX `fk_program_component_grade_attribute_status1_idx` (`program_component_grade_status` ASC),
  CONSTRAINT `fk_program_component_grade_attribute_status1`
    FOREIGN KEY (`program_component_grade_status`)
    REFERENCES `attribute_status` (`attribute_status_value`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `program_component_grade_association`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `program_component_grade_association` ;

CREATE TABLE IF NOT EXISTS `program_component_grade_association` (
  `pcga_program_component_grade_association_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `pcga_pc_id` INT UNSIGNED NOT NULL,
  `pcga_program_component_grade_cuid` VARCHAR(32) NOT NULL,
  PRIMARY KEY (`pcga_program_component_grade_association_id`),
  UNIQUE INDEX `NOT_THE_SAME_ASSOCIATION_TWICE` (`pcga_pc_id` ASC, `pcga_program_component_grade_cuid` ASC),
  INDEX `fk_program_component_grade_association_program_component1_idx` (`pcga_pc_id` ASC),
  INDEX `fk_program_component_grade_association_program_component_gr_idx` (`pcga_program_component_grade_cuid` ASC),
  CONSTRAINT `fk_program_component_grade_association_program_component1`
    FOREIGN KEY (`pcga_pc_id`)
    REFERENCES `program_component` (`pc_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_program_component_grade_association_program_component_grade1`
    FOREIGN KEY (`pcga_program_component_grade_cuid`)
    REFERENCES `program_component_grade` (`program_component_grade_cuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);



-- -----------------------------------------------------
-- Table `assembly_assembly_relationship`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `assembly_assembly_relationship` ;

CREATE TABLE IF NOT EXISTS `assembly_assembly_relationship` (
  `assembly_assembly_relationship_cuid` VARCHAR(32) NOT NULL,
  `assembly_assembly_relationship_shortvalue` VARCHAR(50) NULL,
  `assembly_assembly_relationship_displayvalue` VARCHAR(100) NULL,
  `assembly_assembly_relationship_abbrev` VARCHAR(45) NULL,
  `assembly_assembly_relationship_description` TEXT NULL,
  `assembly_assembly_relationship_ordering` INT NULL,
  `assembly_assembly_relationship_status` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`assembly_assembly_relationship_cuid`),
  UNIQUE INDEX `assembly_assembly_relationship_cuid` (`assembly_assembly_relationship_cuid` ASC));


-- -----------------------------------------------------
-- Table `assembly_assembly_relationship_association`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `assembly_assembly_relationship_association` ;

CREATE TABLE IF NOT EXISTS `assembly_assembly_relationship_association` (
  `aara_id` INT NOT NULL,
  `aara_a_code_A` VARCHAR(32) NULL,
  `aara_assembly_assembly_relationship_cuid` VARCHAR(32) NULL,
  `aara_a_code_B` VARCHAR(32) NULL,
  PRIMARY KEY (`aara_id`),
  INDEX `fk_assembly_relationship_assembly_assembly_relationship1_idx` (`aara_assembly_assembly_relationship_cuid` ASC),
  INDEX `fk_assembly_relationship_assembly1_idx` (`aara_a_code_A` ASC),
  INDEX `fk_assembly_relationship_assembly2_idx` (`aara_a_code_B` ASC),
  UNIQUE INDEX `NOT_THE_SAME_RELATIONSHIP_TWICE` (`aara_a_code_A` ASC, `aara_assembly_assembly_relationship_cuid` ASC, `aara_a_code_B` ASC),
  CONSTRAINT `fk_assembly_relationship_assembly_assembly_relationship1`
    FOREIGN KEY (`aara_assembly_assembly_relationship_cuid`)
    REFERENCES `assembly_assembly_relationship` (`assembly_assembly_relationship_cuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_assembly_relationship_assembly1`
    FOREIGN KEY (`aara_a_code_A`)
    REFERENCES `assembly` (`a_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_assembly_relationship_assembly2`
    FOREIGN KEY (`aara_a_code_B`)
    REFERENCES `assembly` (`a_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `content_contributor_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `content_contributor_type` ;

CREATE TABLE IF NOT EXISTS `content_contributor_type` (
  `content_contributor_type_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `content_contributor_type_code` VARCHAR(20) NULL,
  `content_contributor_type_shortvalue` VARCHAR(32) NOT NULL,
  `content_contributor_type_group` VARCHAR(32) NOT NULL,
  `content_contributor_type_displayvalue` VARCHAR(255) NULL,
  `content_contributor_type_description` VARCHAR(255) NULL,
  PRIMARY KEY (`content_contributor_type_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `content_contributor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `content_contributor` ;

CREATE TABLE IF NOT EXISTS `content_contributor` (
  `cc_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `cc_fullname` VARCHAR(255) NULL,
  `cc_prefix` VARCHAR(255) NULL,
  `cc_firstname` VARCHAR(255) NULL,
  `cc_middlename` VARCHAR(255) NULL,
  `cc_lastname` VARCHAR(255) NULL,
  `cc_suffix` VARCHAR(255) NULL,
  `cc_phone` VARCHAR(255) NULL,
  `cc_email` VARCHAR(255) NULL,
  `cc_company` VARCHAR(255) NULL,
  `cc_primary_language` VARCHAR(255) NULL,
  `cc_fluent_languages` VARCHAR(255) NULL,
  PRIMARY KEY (`cc_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `content_contributor_association`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `content_contributor_association` ;

CREATE TABLE IF NOT EXISTS `content_contributor_association` (
  `cca_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `cca_c_code` VARCHAR(32) NULL,
  `cca_content_contributor_id` INT UNSIGNED NULL,
  `cca_content_contributor_type_id` INT UNSIGNED NULL,
  `cca_ordering` INT NULL,
  PRIMARY KEY (`cca_id`),
  INDEX `fk_content_contributor_association_content1_idx` (`cca_c_code` ASC),
  INDEX `fk_content_contributor_association_content_contributor1_idx` (`cca_content_contributor_id` ASC),
  INDEX `fk_content_contributor_association_content_contributor_type_idx` (`cca_content_contributor_type_id` ASC),
  CONSTRAINT `fk_content_contributor_association_content1`
    FOREIGN KEY (`cca_c_code`)
    REFERENCES `content` (`c_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_content_contributor_association_content_contributor1`
    FOREIGN KEY (`cca_content_contributor_id`)
    REFERENCES `content_contributor` (`cc_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_content_contributor_association_content_contributor_type1`
    FOREIGN KEY (`cca_content_contributor_type_id`)
    REFERENCES `content_contributor_type` (`content_contributor_type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



-- -----------------------------------------------------
-- Table `assembly_contains_assembly`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `assembly_contains_assembly` ;

CREATE TABLE IF NOT EXISTS `assembly_contains_assembly` (
  `aca_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `aca_a_code` VARCHAR(32) NULL,
  `aca_contains_a_code` VARCHAR(32) NULL,
  `aca_at_level` INT UNSIGNED NULL,
  INDEX `fk_assembly_contains_assembly_assembly1_idx` (`aca_a_code` ASC),
  INDEX `fk_assembly_contains_assembly_assembly2_idx` (`aca_contains_a_code` ASC),
  PRIMARY KEY (`aca_id`),
  CONSTRAINT `fk_assembly_contains_assembly_assembly1`
    FOREIGN KEY (`aca_a_code`)
    REFERENCES `assembly` (`a_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_assembly_contains_assembly_assembly2`
    FOREIGN KEY (`aca_contains_a_code`)
    REFERENCES `assembly` (`a_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);



-- -----------------------------------------------------
-- Table `content_content_monitor_reading_strategy_association`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `content_content_monitor_reading_strategy_association` ;

CREATE TABLE IF NOT EXISTS `content_content_monitor_reading_strategy_association` (
  `ccmrsa_content_content_monitor_reading_strategy_association_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `ccmrsa_c_code_A` VARCHAR(32) NOT NULL,
  `ccmrsa_content_content_monitor_reading_strategy_cuid` VARCHAR(32) NOT NULL,
  `ccmrsa_c_code_B` VARCHAR(32) NOT NULL,
  PRIMARY KEY (`ccmrsa_content_content_monitor_reading_strategy_association_id`),
  INDEX `fk_content_content_monitor_reading_strategy_association_con_idx` (`ccmrsa_content_content_monitor_reading_strategy_cuid` ASC),
  INDEX `fk_content_content_monitor_reading_strategy_association_con_idx1` (`ccmrsa_c_code_A` ASC),
  INDEX `fk_content_content_monitor_reading_strategy_association_con_idx2` (`ccmrsa_c_code_B` ASC),
  UNIQUE INDEX `NOT_THE_SAME_RELATIONSHIP_TWICE` (`ccmrsa_c_code_A` ASC, `ccmrsa_content_content_monitor_reading_strategy_cuid` ASC, `ccmrsa_c_code_B` ASC),
  CONSTRAINT `fk_content_content_monitor_reading_strategy_association_conte1`
    FOREIGN KEY (`ccmrsa_content_content_monitor_reading_strategy_cuid`)
    REFERENCES `content_content_monitor_reading_strategy` (`content_content_monitor_reading_strategy_cuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_content_content_monitor_reading_strategy_association_conte2`
    FOREIGN KEY (`ccmrsa_c_code_A`)
    REFERENCES `content` (`c_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_content_content_monitor_reading_strategy_association_conte3`
    FOREIGN KEY (`ccmrsa_c_code_B`)
    REFERENCES `content` (`c_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `content_bisac_code`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `content_bisac_code` ;

CREATE TABLE IF NOT EXISTS `content_bisac_code` (
  `content_bisac_code_id` VARCHAR(32) NOT NULL,
  `content_bisac_code_shortvalue` VARCHAR(255) NULL,
  `content_bisac_code_displayvalue` VARCHAR(255) NULL,
  `content_bisac_code_abbrev` VARCHAR(45) NULL,
  `content_bisac_code_description` TEXT NULL,
  `content_bisac_code_ordering` INT NULL,
  `content_bisac_code_status` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`content_bisac_code_id`),
  INDEX `fk_content_bisac_attribute_status1_idx` (`content_bisac_code_status` ASC),
  CONSTRAINT `fk_content_bisac_attribute_status1`
    FOREIGN KEY (`content_bisac_code_status`)
    REFERENCES `attribute_status` (`attribute_status_value`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `content_bisac_code_association`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `content_bisac_code_association` ;

CREATE TABLE IF NOT EXISTS `content_bisac_code_association` (
  `cbca_content_bisac_code_association_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `cbca_c_code` VARCHAR(32) CHARACTER SET 'utf8' NOT NULL,
  `cbca_content_bisac_code_id` VARCHAR(32) CHARACTER SET 'utf8' NOT NULL,
  `cbca_ordering` INT UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`cbca_content_bisac_code_association_id`),
  UNIQUE INDEX `NOT_THE_SAME_ASSOCIATION_TWICE` (`cbca_c_code` ASC, `cbca_content_bisac_code_id` ASC),
  INDEX `fk_content_bisac_association_content_bisac1_idx` (`cbca_content_bisac_code_id` ASC),
  INDEX `fk_content_bisac_association_content1_idx` (`cbca_c_code` ASC),
  CONSTRAINT `fk_content_bisac_association_content_bisac1`
    FOREIGN KEY (`cbca_content_bisac_code_id`)
    REFERENCES `content_bisac_code` (`content_bisac_code_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_content_bisac_association_content1`
    FOREIGN KEY (`cbca_c_code`)
    REFERENCES `content` (`c_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);



-- -----------------------------------------------------
-- Table `assembly_alias`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `assembly_alias` ;

CREATE TABLE IF NOT EXISTS `assembly_alias` (
  `aa_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `aa_a_code` VARCHAR(32) NULL,
  `aa_alias` VARCHAR(255) NULL,
  `aa_notes` TEXT NULL,
  PRIMARY KEY (`aa_id`),
  INDEX `fk_assembly_alias_assembly1_idx` (`aa_a_code` ASC),
  CONSTRAINT `fk_assembly_alias_assembly1`
    FOREIGN KEY (`aa_a_code`)
    REFERENCES `assembly` (`a_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `content_contributor_roles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `content_contributor_roles` ;

CREATE TABLE IF NOT EXISTS `content_contributor_roles` (
  `ccr_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `ccr_content_contributor_id` INT UNSIGNED NULL,
  `ccr_content_contributor_type_id` INT UNSIGNED NULL,
  PRIMARY KEY (`ccr_id`),
  INDEX `fk_content_contributor_roles_content_contributor1_idx` (`ccr_content_contributor_id` ASC),
  INDEX `fk_content_contributor_roles_content_contributor_type1_idx` (`ccr_content_contributor_type_id` ASC),
  CONSTRAINT `fk_content_contributor_roles_content_contributor1`
    FOREIGN KEY (`ccr_content_contributor_id`)
    REFERENCES `content_contributor` (`cc_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_content_contributor_roles_content_contributor_type1`
    FOREIGN KEY (`ccr_content_contributor_type_id`)
    REFERENCES `content_contributor_type` (`content_contributor_type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `assembly_language`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `assembly_language` ;

CREATE TABLE IF NOT EXISTS `assembly_language` (
  `assembly_language_cuid` VARCHAR(32) NOT NULL,
  `assembly_language_shortvalue` VARCHAR(255) NULL,
  `assembly_language_displayvalue` VARCHAR(255) NULL,
  `assembly_language_abbrev` VARCHAR(45) NULL,
  `assembly_language_description` TEXT NULL,
  `assembly_language_ordering` INT NULL,
  `assembly_language_status` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`assembly_language_cuid`),
  INDEX `fk_assembly_language_attribute_status1_idx` (`assembly_language_status` ASC),
  CONSTRAINT `fk_assembly_language_attribute_status1`
    FOREIGN KEY (`assembly_language_status`)
    REFERENCES `attribute_status` (`attribute_status_value`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `assembly_language_association`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `assembly_language_association` ;

CREATE TABLE IF NOT EXISTS `assembly_language_association` (
  `ala_assembly_language_association_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `ala_a_code` VARCHAR(32) NOT NULL,
  `ala_assembly_language_cuid` VARCHAR(32) NOT NULL,
  PRIMARY KEY (`ala_assembly_language_association_id`),
  INDEX `fk_assembly_language_association_assembly_language1_idx` (`ala_assembly_language_cuid` ASC),
  INDEX `fk_assembly_language_association_assembly1_idx` (`ala_a_code` ASC),
  CONSTRAINT `fk_assembly_language_association_assembly_language1`
    FOREIGN KEY (`ala_assembly_language_cuid`)
    REFERENCES `assembly_language` (`assembly_language_cuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_assembly_language_association_assembly1`
    FOREIGN KEY (`ala_a_code`)
    REFERENCES `assembly` (`a_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `assembly_type_association`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `assembly_type_association` ;

CREATE TABLE IF NOT EXISTS `assembly_type_association` (
  `ata_assembly_type_association_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ata_a_code` VARCHAR(32) CHARACTER SET 'utf8' NOT NULL,
  `ata_assembly_type_cuid` VARCHAR(32) CHARACTER SET 'utf8' NOT NULL,
  PRIMARY KEY (`ata_assembly_type_association_id`),
  INDEX `fk_assembly_type_association_assembly3_idx` (`ata_a_code` ASC),
  INDEX `fk_assembly_type_association_assembly_type1_idx` (`ata_assembly_type_cuid` ASC),
  CONSTRAINT `fk_assembly_type_association_assembly3`
    FOREIGN KEY (`ata_a_code`)
    REFERENCES `assembly` (`a_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_assembly_type_association_assembly_type1`
    FOREIGN KEY (`ata_assembly_type_cuid`)
    REFERENCES `assembly_type` (`assembly_type_cuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;



-- -----------------------------------------------------
-- Table `assembly_grade`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `assembly_grade` ;

CREATE TABLE IF NOT EXISTS `assembly_grade` (
  `assembly_grade_cuid` VARCHAR(32) NOT NULL,
  `assembly_grade_shortvalue` VARCHAR(255) NULL,
  `assembly_grade_displayvalue` VARCHAR(255) NULL,
  `assembly_grade_abbrev` VARCHAR(45) NULL,
  `assembly_grade_description` TEXT NULL,
  `assembly_grade_ordering` INT NULL,
  `assembly_grade_status` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`assembly_grade_cuid`),
  INDEX `fk_assembly_grade_attribute_status1_idx` (`assembly_grade_status` ASC),
  CONSTRAINT `fk_assembly_grade_attribute_status1`
    FOREIGN KEY (`assembly_grade_status`)
    REFERENCES `attribute_status` (`attribute_status_value`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `assembly_grade_association`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `assembly_grade_association` ;

CREATE TABLE IF NOT EXISTS `assembly_grade_association` (
  `aga_assembly_grade_association_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `aga_a_code` VARCHAR(32) NOT NULL,
  `aga_assembly_grade_cuid` VARCHAR(32) NOT NULL,
  PRIMARY KEY (`aga_assembly_grade_association_id`),
  INDEX `fk_assembly_grade_association_assembly_grade1_idx` (`aga_assembly_grade_cuid` ASC),
  INDEX `fk_assembly_grade_association_assembly1_idx` (`aga_a_code` ASC),
  CONSTRAINT `fk_assembly_grade_association_assembly_grade1`
    FOREIGN KEY (`aga_assembly_grade_cuid`)
    REFERENCES `assembly_grade` (`assembly_grade_cuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_assembly_grade_association_assembly1`
    FOREIGN KEY (`aga_a_code`)
    REFERENCES `assembly` (`a_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);



-- -----------------------------------------------------
-- Table `assembly_genre`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `assembly_genre` ;

CREATE TABLE IF NOT EXISTS `assembly_genre` (
  `assembly_genre_cuid` VARCHAR(32) NOT NULL,
  `assembly_genre_shortvalue` VARCHAR(255) NULL,
  `assembly_genre_displayvalue` VARCHAR(255) NULL,
  `assembly_genre_abbrev` VARCHAR(45) NULL,
  `assembly_genre_description` TEXT NULL,
  `assembly_genre_ordering` INT NULL,
  `assembly_genre_status` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`assembly_genre_cuid`),
  INDEX `fk_assembly_genre_attribute_status1_idx` (`assembly_genre_status` ASC),
  CONSTRAINT `fk_assembly_genre_attribute_status1`
    FOREIGN KEY (`assembly_genre_status`)
    REFERENCES `attribute_status` (`attribute_status_value`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `assembly_genre_association`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `assembly_genre_association` ;

CREATE TABLE IF NOT EXISTS `assembly_genre_association` (
  `aga_assembly_genre_association_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `aga_a_code` VARCHAR(32) NOT NULL,
  `aga_assembly_genre_cuid` VARCHAR(32) NOT NULL,
  PRIMARY KEY (`aga_assembly_genre_association_id`),
  INDEX `fk_assembly_X_association_assembly_genre1_idx` (`aga_assembly_genre_cuid` ASC),
  INDEX `fk_assembly_X_association_assembly1_idx` (`aga_a_code` ASC),
  CONSTRAINT `fk_assembly_X_association_assembly_genre1`
    FOREIGN KEY (`aga_assembly_genre_cuid`)
    REFERENCES `assembly_genre` (`assembly_genre_cuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_assembly_X_association_assembly1`
    FOREIGN KEY (`aga_a_code`)
    REFERENCES `assembly` (`a_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);



-- -----------------------------------------------------
-- Table `assembly_content_area`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `assembly_content_area` ;

CREATE TABLE IF NOT EXISTS `assembly_content_area` (
  `assembly_content_area_cuid` VARCHAR(32) NOT NULL,
  `assembly_content_area_shortvalue` VARCHAR(255) NULL,
  `assembly_content_area_displayvalue` VARCHAR(255) NULL,
  `assembly_content_area_abbrev` VARCHAR(45) NULL,
  `assembly_content_area_description` TEXT NULL,
  `assembly_content_area_ordering` INT NULL,
  `assembly_content_area_status` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`assembly_content_area_cuid`),
  INDEX `fk_assembly_content_area_attribute_status1_idx` (`assembly_content_area_status` ASC),
  CONSTRAINT `fk_assembly_content_area_attribute_status1`
    FOREIGN KEY (`assembly_content_area_status`)
    REFERENCES `attribute_status` (`attribute_status_value`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `assembly_content_area_association`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `assembly_content_area_association` ;

CREATE TABLE IF NOT EXISTS `assembly_content_area_association` (
  `acaa_assembly_content_area_association_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `acaa_a_code` VARCHAR(32) NOT NULL,
  `acaa_assembly_content_area_cuid` VARCHAR(32) NOT NULL,
  PRIMARY KEY (`acaa_assembly_content_area_association_id`),
  INDEX `fk_assembly_content_area_association_assembly_content_area1_idx` (`acaa_assembly_content_area_cuid` ASC),
  INDEX `fk_assembly_content_area_association_assembly1_idx` (`acaa_a_code` ASC),
  CONSTRAINT `fk_assembly_content_area_association_assembly_content_area1`
    FOREIGN KEY (`acaa_assembly_content_area_cuid`)
    REFERENCES `assembly_content_area` (`assembly_content_area_cuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_assembly_content_area_association_assembly1`
    FOREIGN KEY (`acaa_a_code`)
    REFERENCES `assembly` (`a_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `assembly_lexile`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `assembly_lexile` ;

CREATE TABLE IF NOT EXISTS `assembly_lexile` (
  `assembly_lexile_cuid` VARCHAR(32) NOT NULL,
  `assembly_lexile_shortvalue` VARCHAR(255) NULL,
  `assembly_lexile_displayvalue` VARCHAR(255) NULL,
  `assembly_lexile_abbrev` VARCHAR(45) NULL,
  `assembly_lexile_description` TEXT NULL,
  `assembly_lexile_ordering` INT NULL,
  `assembly_lexile_status` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`assembly_lexile_cuid`),
  INDEX `fk_assembly_lexile_attribute_status1_idx` (`assembly_lexile_status` ASC),
  CONSTRAINT `fk_assembly_lexile_attribute_status1`
    FOREIGN KEY (`assembly_lexile_status`)
    REFERENCES `attribute_status` (`attribute_status_value`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `assembly_lexile_association`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `assembly_lexile_association` ;

CREATE TABLE IF NOT EXISTS `assembly_lexile_association` (
  `ala_assembly_lexile_association_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `ala_a_code` VARCHAR(32) NOT NULL,
  `ala_assembly_lexile_cuid` VARCHAR(32) NOT NULL,
  PRIMARY KEY (`ala_assembly_lexile_association_id`),
  INDEX `fk_assembly_lexile_association_assembly_lexile1_idx` (`ala_assembly_lexile_cuid` ASC),
  INDEX `fk_assembly_lexile_association_assembly1_idx` (`ala_a_code` ASC),
  CONSTRAINT `fk_assembly_lexile_association_assembly_lexile1`
    FOREIGN KEY (`ala_assembly_lexile_cuid`)
    REFERENCES `assembly_lexile` (`assembly_lexile_cuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_assembly_lexile_association_assembly1`
    FOREIGN KEY (`ala_a_code`)
    REFERENCES `assembly` (`a_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `assembly_age`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `assembly_age` ;

CREATE TABLE IF NOT EXISTS `assembly_age` (
  `assembly_age_cuid` VARCHAR(32) NOT NULL,
  `assembly_age_shortvalue` VARCHAR(255) NULL,
  `assembly_age_displayvalue` VARCHAR(255) NULL,
  `assembly_age_abbrev` VARCHAR(45) NULL,
  `assembly_age_description` TEXT NULL,
  `assembly_age_ordering` INT NULL,
  `assembly_age_status` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`assembly_age_cuid`),
  INDEX `fk_assembly_age_attribute_status1_idx` (`assembly_age_status` ASC),
  CONSTRAINT `fk_assembly_age_attribute_status1`
    FOREIGN KEY (`assembly_age_status`)
    REFERENCES `attribute_status` (`attribute_status_value`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `assembly_age_association`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `assembly_age_association` ;

CREATE TABLE IF NOT EXISTS `assembly_age_association` (
  `aaa_assembly_age_association_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `aaa_a_code` VARCHAR(32) NOT NULL,
  `aaa_assembly_age_cuid` VARCHAR(32) NOT NULL,
  PRIMARY KEY (`aaa_assembly_age_association_id`),
  INDEX `fk_assembly_age_association_assembly_age1_idx` (`aaa_assembly_age_cuid` ASC),
  INDEX `fk_assembly_age_association_assembly1_idx` (`aaa_a_code` ASC),
  CONSTRAINT `fk_assembly_age_association_assembly_age1`
    FOREIGN KEY (`aaa_assembly_age_cuid`)
    REFERENCES `assembly_age` (`assembly_age_cuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_assembly_age_association_assembly1`
    FOREIGN KEY (`aaa_a_code`)
    REFERENCES `assembly` (`a_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `product` ;

CREATE TABLE IF NOT EXISTS `product` (
  `p_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `p_code` VARCHAR(32) NOT NULL,
  `p_o_code` VARCHAR(32) NULL,
  `p_a_code` VARCHAR(32) NULL,
  `p_copyright_year` INT UNSIGNED NULL,
  `p_isbn` VARCHAR(255) NULL,
  `p_gtin` VARCHAR(255) NULL,
  `p_nimas_identifier` VARCHAR(255) NULL,
  `p_vendor_product_code` VARCHAR(60) NULL,
  `p_launch_price` DECIMAL(13,2) NULL,
  `p_replaced_by` VARCHAR(32) NULL,
  `p_created` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `p_updated` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`p_id`),
  UNIQUE INDEX `pcode_UNIQUE` (`p_code` ASC),
  INDEX `p_o_code` (`p_o_code` ASC),
  INDEX `p_a_code` (`p_a_code` ASC),
  INDEX `p_code` (`p_code` ASC),
  INDEX `fk_product_product1_idx` (`p_replaced_by` ASC),
  CONSTRAINT `fk_product_product1`
    FOREIGN KEY (`p_replaced_by`)
    REFERENCES `product` (`p_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `assembly_instructional_setting`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `assembly_instructional_setting` ;

CREATE TABLE IF NOT EXISTS `assembly_instructional_setting` (
  `assembly_instructional_setting_cuid` VARCHAR(32) NOT NULL,
  `assembly_instructional_setting_shortvalue` VARCHAR(255) NULL,
  `assembly_instructional_setting_displayvalue` VARCHAR(255) NULL,
  `assembly_instructional_setting_abbrev` VARCHAR(45) NULL,
  `assembly_instructional_setting_description` TEXT NULL,
  `assembly_instructional_setting_ordering` INT NULL,
  `assembly_instructional_setting_status` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`assembly_instructional_setting_cuid`),
  INDEX `fk_assembly_instructional_setting_attribute_status1_idx` (`assembly_instructional_setting_status` ASC),
  CONSTRAINT `fk_assembly_instructional_setting_attribute_status1`
    FOREIGN KEY (`assembly_instructional_setting_status`)
    REFERENCES `attribute_status` (`attribute_status_value`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `assembly_instructional_setting_association`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `assembly_instructional_setting_association` ;

CREATE TABLE IF NOT EXISTS `assembly_instructional_setting_association` (
  `aisa_assembly_instructional_setting_association_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `aisa_a_code` VARCHAR(32) NOT NULL,
  `aisa_assembly_instructional_setting_cuid` VARCHAR(32) NOT NULL,
  PRIMARY KEY (`aisa_assembly_instructional_setting_association_id`),
  INDEX `fk_assembly_instructional_setting_association_assembly_inst_idx` (`aisa_assembly_instructional_setting_cuid` ASC),
  INDEX `fk_assembly_instructional_setting_association_assembly1_idx` (`aisa_a_code` ASC),
  CONSTRAINT `fk_assembly_instructional_setting_association_assembly_instru1`
    FOREIGN KEY (`aisa_assembly_instructional_setting_cuid`)
    REFERENCES `assembly_instructional_setting` (`assembly_instructional_setting_cuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_assembly_instructional_setting_association_assembly1`
    FOREIGN KEY (`aisa_a_code`)
    REFERENCES `assembly` (`a_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);



-- -----------------------------------------------------
-- Table `product_line_instructional_approach`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `product_line_instructional_approach` ;

CREATE TABLE IF NOT EXISTS `product_line_instructional_approach` (
  `product_line_instructional_approach_cuid` VARCHAR(32) NOT NULL,
  `product_line_instructional_approach_shortvalue` VARCHAR(255) NULL,
  `product_line_instructional_approach_displayvalue` VARCHAR(255) NULL,
  `product_line_instructional_approach_abbrev` VARCHAR(45) NULL,
  `product_line_instructional_approach_description` TEXT NULL,
  `product_line_instructional_approach_ordering` INT NULL,
  `product_line_instructional_approach_status` VARCHAR(20) NULL,
  PRIMARY KEY (`product_line_instructional_approach_cuid`),
  INDEX `fk_product_line_instructional_approach_attribute_status1_idx` (`product_line_instructional_approach_status` ASC),
  CONSTRAINT `fk_product_line_instructional_approach_attribute_status1`
    FOREIGN KEY (`product_line_instructional_approach_status`)
    REFERENCES `attribute_status` (`attribute_status_value`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);





-- -----------------------------------------------------
-- Table `assembly_genre_derived_association`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `assembly_genre_derived_association` ;

CREATE TABLE IF NOT EXISTS `assembly_genre_derived_association` (
  `agda_assembly_genre_derived_association_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `agda_a_code` VARCHAR(32) NOT NULL,
  `agda_assembly_genre_cuid` VARCHAR(32) NOT NULL,
  `agda_weight` INT NULL,
  PRIMARY KEY (`agda_assembly_genre_derived_association_id`),
  INDEX `fk_assembly_genre_derived_association_assembly1_idx` (`agda_a_code` ASC),
  INDEX `fk_assembly_genre_derived_association_assembly_genre1_idx` (`agda_assembly_genre_cuid` ASC),
  CONSTRAINT `fk_assembly_genre_derived_association_assembly1`
    FOREIGN KEY (`agda_a_code`)
    REFERENCES `assembly` (`a_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_assembly_genre_derived_association_assembly_genre1`
    FOREIGN KEY (`agda_assembly_genre_cuid`)
    REFERENCES `assembly_genre` (`assembly_genre_cuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);



-- -----------------------------------------------------
-- Table `assembly_instructional_setting_derived_association`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `assembly_instructional_setting_derived_association` ;

CREATE TABLE IF NOT EXISTS `assembly_instructional_setting_derived_association` (
  `aisda_assembly_instructional_setting_derived_association_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `aisda_a_code` VARCHAR(32) NOT NULL,
  `aisda_assembly_instructional_setting_cuid` VARCHAR(32) NOT NULL,
  `aisda_weight` INT NULL,
  PRIMARY KEY (`aisda_assembly_instructional_setting_derived_association_id`),
  INDEX `fk_assembly_instructional_setting_derived_association_assem_idx` (`aisda_a_code` ASC),
  INDEX `fk_assembly_instructional_setting_derived_association_assem_idx1` (`aisda_assembly_instructional_setting_cuid` ASC),
  CONSTRAINT `fk_assembly_instructional_setting_derived_association_assembly1`
    FOREIGN KEY (`aisda_a_code`)
    REFERENCES `assembly` (`a_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_assembly_instructional_setting_derived_association_assembl1`
    FOREIGN KEY (`aisda_assembly_instructional_setting_cuid`)
    REFERENCES `assembly_instructional_setting` (`assembly_instructional_setting_cuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);



-- -----------------------------------------------------
-- Table `assembly_type_derived_association`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `assembly_type_derived_association` ;

CREATE TABLE IF NOT EXISTS `assembly_type_derived_association` (
  `atda_assembly_type_derived_association_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `atda_a_code` VARCHAR(32) NOT NULL,
  `atda_assembly_type_cuid` VARCHAR(32) NOT NULL,
  `atda_weight` INT NULL,
  PRIMARY KEY (`atda_assembly_type_derived_association_id`),
  INDEX `fk_assembly_type_derived_association_assembly1_idx` (`atda_a_code` ASC),
  INDEX `fk_assembly_type_derived_association_assembly_type1_idx` (`atda_assembly_type_cuid` ASC),
  CONSTRAINT `fk_assembly_type_derived_association_assembly1`
    FOREIGN KEY (`atda_a_code`)
    REFERENCES `assembly` (`a_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_assembly_type_derived_association_assembly_type1`
    FOREIGN KEY (`atda_assembly_type_cuid`)
    REFERENCES `assembly_type` (`assembly_type_cuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `assembly_language_derived_association`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `assembly_language_derived_association` ;

CREATE TABLE IF NOT EXISTS `assembly_language_derived_association` (
  `alda_assembly_language_derived_association_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `alda_a_code` VARCHAR(32) NOT NULL,
  `alda_assembly_language_cuid` VARCHAR(32) NOT NULL,
  `alda_weight` INT NULL,
  PRIMARY KEY (`alda_assembly_language_derived_association_id`),
  INDEX `fk_assembly_language_derived_association_assembly1_idx` (`alda_a_code` ASC),
  INDEX `fk_assembly_language_derived_association_assembly_language1_idx` (`alda_assembly_language_cuid` ASC),
  CONSTRAINT `fk_assembly_language_derived_association_assembly1`
    FOREIGN KEY (`alda_a_code`)
    REFERENCES `assembly` (`a_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_assembly_language_derived_association_assembly_language1`
    FOREIGN KEY (`alda_assembly_language_cuid`)
    REFERENCES `assembly_language` (`assembly_language_cuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);




-- -----------------------------------------------------
-- Table `assembly_grade_derived_association`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `assembly_grade_derived_association` ;

CREATE TABLE IF NOT EXISTS `assembly_grade_derived_association` (
  `agda_assembly_grade_derived_association_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `agda_a_code` VARCHAR(32) NOT NULL,
  `agda_assembly_grade_cuid` VARCHAR(32) NOT NULL,
  `agda_weight` INT NULL,
  PRIMARY KEY (`agda_assembly_grade_derived_association_id`),
  INDEX `fk_assembly_grade_derived_association_assembly1_idx` (`agda_a_code` ASC),
  INDEX `fk_assembly_grade_derived_association_assembly_grade1_idx` (`agda_assembly_grade_cuid` ASC),
  CONSTRAINT `fk_assembly_grade_derived_association_assembly1`
    FOREIGN KEY (`agda_a_code`)
    REFERENCES `assembly` (`a_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_assembly_grade_derived_association_assembly_grade1`
    FOREIGN KEY (`agda_assembly_grade_cuid`)
    REFERENCES `assembly_grade` (`assembly_grade_cuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);




-- -----------------------------------------------------
-- Table `assembly_content_area_derived_association`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `assembly_content_area_derived_association` ;

CREATE TABLE IF NOT EXISTS `assembly_content_area_derived_association` (
  `acada_assembly_content_area_derived_association_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `acada_a_code` VARCHAR(32) NOT NULL,
  `acada_assembly_content_area_cuid` VARCHAR(32) NOT NULL,
  `acada_weight` INT NULL,
  PRIMARY KEY (`acada_assembly_content_area_derived_association_id`),
  INDEX `fk_assembly_content_area_derived_association_assembly1_idx` (`acada_a_code` ASC),
  INDEX `fk_assembly_content_area_derived_association_assembly_conte_idx` (`acada_assembly_content_area_cuid` ASC),
  CONSTRAINT `fk_assembly_content_area_derived_association_assembly1`
    FOREIGN KEY (`acada_a_code`)
    REFERENCES `assembly` (`a_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_assembly_content_area_derived_association_assembly_content1`
    FOREIGN KEY (`acada_assembly_content_area_cuid`)
    REFERENCES `assembly_content_area` (`assembly_content_area_cuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `assembly_lexile_derived_association`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `assembly_lexile_derived_association` ;

CREATE TABLE IF NOT EXISTS `assembly_lexile_derived_association` (
  `alda_assembly_lexile_derived_association_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `alda_a_code` VARCHAR(32) NOT NULL,
  `alda_assembly_lexile_cuid` VARCHAR(32) NOT NULL,
  `alda_weight` INT NULL,
  PRIMARY KEY (`alda_assembly_lexile_derived_association_id`),
  INDEX `fk_assembly_lexile_derived_association_assembly1_idx` (`alda_a_code` ASC),
  INDEX `fk_assembly_lexile_derived_association_assembly_lexile1_idx` (`alda_assembly_lexile_cuid` ASC),
  CONSTRAINT `fk_assembly_lexile_derived_association_assembly1`
    FOREIGN KEY (`alda_a_code`)
    REFERENCES `assembly` (`a_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_assembly_lexile_derived_association_assembly_lexile1`
    FOREIGN KEY (`alda_assembly_lexile_cuid`)
    REFERENCES `assembly_lexile` (`assembly_lexile_cuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `assembly_age_derived_association`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `assembly_age_derived_association` ;

CREATE TABLE IF NOT EXISTS `assembly_age_derived_association` (
  `aada_assembly_age_derived_association_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `aada_a_code` VARCHAR(32) NOT NULL,
  `aada_assembly_age_cuid` VARCHAR(32) NOT NULL,
  `aada_weight` INT NULL,
  PRIMARY KEY (`aada_assembly_age_derived_association_id`),
  INDEX `fk_assembly_X_derived_association_assembly1_idx` (`aada_a_code` ASC),
  INDEX `fk_assembly_age_derived_association_assembly_age1_idx` (`aada_assembly_age_cuid` ASC),
  CONSTRAINT `fk_assembly_X_derived_association_assembly1`
    FOREIGN KEY (`aada_a_code`)
    REFERENCES `assembly` (`a_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_assembly_age_derived_association_assembly_age1`
    FOREIGN KEY (`aada_assembly_age_cuid`)
    REFERENCES `assembly_age` (`assembly_age_cuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);




-- -----------------------------------------------------
-- Table `product_line`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `product_line` ;

CREATE TABLE IF NOT EXISTS `product_line` (
  `pl_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `pl_assembly_product_line_cuid` VARCHAR(32) NOT NULL,
  `pl_product_line_market_segment_cuid` VARCHAR(32) NULL,
  PRIMARY KEY (`pl_id`),
  INDEX `fk_product_line_assembly_product_line1_idx` (`pl_assembly_product_line_cuid` ASC),
  INDEX `fk_product_line_product_line_market_segment1_idx` (`pl_product_line_market_segment_cuid` ASC),
  CONSTRAINT `fk_product_line_assembly_product_line1`
    FOREIGN KEY (`pl_assembly_product_line_cuid`)
    REFERENCES `assembly_product_line` (`assembly_product_line_cuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_line_product_line_market_segment1`
    FOREIGN KEY (`pl_product_line_market_segment_cuid`)
    REFERENCES `product_line_market_segment` (`product_line_market_segment_cuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;




-- -----------------------------------------------------
-- Table `product_line_instructional_approach_association`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `product_line_instructional_approach_association` ;

CREATE TABLE IF NOT EXISTS `product_line_instructional_approach_association` (
  `pliaa_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `pliaa_assembly_product_line_cuid` VARCHAR(32) NOT NULL,
  `pliaa_product_line_instructional_approach_cuid` VARCHAR(32) NOT NULL,
  PRIMARY KEY (`pliaa_id`),
  INDEX `fk_product_line_instructional_approach_association_product__idx1` (`pliaa_product_line_instructional_approach_cuid` ASC),
  INDEX `fk_product_line_instructional_approach_association_assembly_idx` (`pliaa_assembly_product_line_cuid` ASC),
  CONSTRAINT `fk_product_line_instructional_approach_association_product_li2`
    FOREIGN KEY (`pliaa_product_line_instructional_approach_cuid`)
    REFERENCES `product_line_instructional_approach` (`product_line_instructional_approach_cuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_line_instructional_approach_association_assembly_p1`
    FOREIGN KEY (`pliaa_assembly_product_line_cuid`)
    REFERENCES `assembly_product_line` (`assembly_product_line_cuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `program_component_module`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `program_component_module` ;

CREATE TABLE IF NOT EXISTS `program_component_module` (
  `program_component_module_cuid` VARCHAR(32) NOT NULL,
  `program_component_module_shortvalue` VARCHAR(255) NULL,
  `program_component_module_displayvalue` VARCHAR(255) NULL,
  `program_component_module_abbrev` VARCHAR(45) NULL,
  `program_component_module_description` TEXT NULL,
  `program_component_module_ordering` INT NULL,
  `program_component_module_status` VARCHAR(20) NULL,
  PRIMARY KEY (`program_component_module_cuid`),
  INDEX `fk_program_component_module_attribute_status1_idx` (`program_component_module_status` ASC),
  CONSTRAINT `fk_program_component_module_attribute_status1`
    FOREIGN KEY (`program_component_module_status`)
    REFERENCES `attribute_status` (`attribute_status_value`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `program_component_module_association`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `program_component_module_association` ;

CREATE TABLE IF NOT EXISTS `program_component_module_association` (
  `pcma_program_component_module_association_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `pcma_pc_id` INT UNSIGNED NOT NULL,
  `pcma_program_component_module_cuid` VARCHAR(32) NOT NULL,
  PRIMARY KEY (`pcma_program_component_module_association_id`),
  INDEX `fk_program_component_mod_association_program_component2_idx` (`pcma_pc_id` ASC),
  INDEX `fk_program_component_mod_association_program_component_mod_idx` (`pcma_program_component_module_cuid` ASC),
  CONSTRAINT `fk_program_component_mod_association_program_component2`
    FOREIGN KEY (`pcma_pc_id`)
    REFERENCES `program_component` (`pc_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_program_component_mod_association_program_component_mod1`
    FOREIGN KEY (`pcma_program_component_module_cuid`)
    REFERENCES `program_component_module` (`program_component_module_cuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);



-- -----------------------------------------------------
-- Table `datum_status`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `datum_status` ;

CREATE TABLE IF NOT EXISTS `datum_status` (
  `datum_status_code` INT NOT NULL,
  `datum_status_value` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`datum_status_code`));


-- -----------------------------------------------------
-- Data for table `datum_status`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `datum_status` (`datum_status_code`, `datum_status_value`) VALUES (DEFAULT, 'active');
INSERT INTO `datum_status` (`datum_status_code`, `datum_status_value`) VALUES (DEFAULT, 'retired');
INSERT INTO `datum_status` (`datum_status_code`, `datum_status_value`) VALUES (DEFAULT, 'planned');
INSERT INTO `datum_status` (`datum_status_code`, `datum_status_value`) VALUES (DEFAULT, 'invalid');

COMMIT;


-- -----------------------------------------------------
-- Table `attribute_status`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `attribute_status` ;

CREATE TABLE IF NOT EXISTS `attribute_status` (
  `attribute_status_value` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`attribute_status_value`));


-- -----------------------------------------------------
-- Data for table `attribute_status`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `attribute_status` (`attribute_status_value`) VALUES ('ACTIVE');
INSERT INTO `attribute_status` (`attribute_status_value`) VALUES ('RETIRED');
INSERT INTO `attribute_status` (`attribute_status_value`) VALUES ('PLANNED');
INSERT INTO `attribute_status` (`attribute_status_value`) VALUES ('INVALID');

COMMIT;


-- -----------------------------------------------------
-- Data for table `modality`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `modality` (`modality_value`) VALUES ('PHYSICAL');
INSERT INTO `modality` (`modality_value`) VALUES ('DIGITAL');

COMMIT;




-- -----------------------------------------------------
-- Data for table `content_contributor_type`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `content_contributor_type` (`content_contributor_type_id`, `content_contributor_type_code`, `content_contributor_type_shortvalue`, `content_contributor_type_group`, `content_contributor_type_displayvalue`, `content_contributor_type_description`) VALUES (DEFAULT, NULL, 'ANIMATOR', 'ANIMATOR        ', 'Animated by               ', 'Animator                                 ');
INSERT INTO `content_contributor_type` (`content_contributor_type_id`, `content_contributor_type_code`, `content_contributor_type_shortvalue`, `content_contributor_type_group`, `content_contributor_type_displayvalue`, `content_contributor_type_description`) VALUES (DEFAULT, 'A12', 'ILLUSTRATOR', 'ANIMATOR        ', 'Illustrated by            ', 'Illustrator                              ');
INSERT INTO `content_contributor_type` (`content_contributor_type_id`, `content_contributor_type_code`, `content_contributor_type_shortvalue`, `content_contributor_type_group`, `content_contributor_type_displayvalue`, `content_contributor_type_description`) VALUES (DEFAULT, 'B05', 'ADAPTED_BY', 'AUTHOR          ', 'Adapted by                ', 'Adapter                                  ');
INSERT INTO `content_contributor_type` (`content_contributor_type_id`, `content_contributor_type_code`, `content_contributor_type_shortvalue`, `content_contributor_type_group`, `content_contributor_type_displayvalue`, `content_contributor_type_description`) VALUES (DEFAULT, 'A01', 'AUTHOR', 'AUTHOR          ', 'Written by                ', 'Author                                   ');
INSERT INTO `content_contributor_type` (`content_contributor_type_id`, `content_contributor_type_code`, `content_contributor_type_shortvalue`, `content_contributor_type_group`, `content_contributor_type_displayvalue`, `content_contributor_type_description`) VALUES (DEFAULT, 'A10', 'BASED_ON_A_BOOK_BY', 'AUTHOR          ', 'Based on a Book by        ', 'Based on a Book by (From an idea by)     ');
INSERT INTO `content_contributor_type` (`content_contributor_type_id`, `content_contributor_type_code`, `content_contributor_type_shortvalue`, `content_contributor_type_group`, `content_contributor_type_displayvalue`, `content_contributor_type_description`) VALUES (DEFAULT, NULL, 'CO_AUTHOR', 'AUTHOR          ', 'Co-written by             ', 'Co-author                                ');
INSERT INTO `content_contributor_type` (`content_contributor_type_id`, `content_contributor_type_code`, `content_contributor_type_shortvalue`, `content_contributor_type_group`, `content_contributor_type_displayvalue`, `content_contributor_type_description`) VALUES (DEFAULT, 'C01', 'COMPILED_BY', 'AUTHOR          ', 'Compiled By               ', 'Compiled By                              ');
INSERT INTO `content_contributor_type` (`content_contributor_type_id`, `content_contributor_type_code`, `content_contributor_type_shortvalue`, `content_contributor_type_group`, `content_contributor_type_displayvalue`, `content_contributor_type_description`) VALUES (DEFAULT, 'B03', 'RETOLD_BY', 'AUTHOR          ', 'Retold By                 ', 'Retold By                                ');
INSERT INTO `content_contributor_type` (`content_contributor_type_id`, `content_contributor_type_code`, `content_contributor_type_shortvalue`, `content_contributor_type_group`, `content_contributor_type_displayvalue`, `content_contributor_type_description`) VALUES (DEFAULT, 'B06', 'TRANSLATOR', 'AUTHOR          ', 'Translated by             ', 'Translator                               ');
INSERT INTO `content_contributor_type` (`content_contributor_type_id`, `content_contributor_type_code`, `content_contributor_type_shortvalue`, `content_contributor_type_group`, `content_contributor_type_displayvalue`, `content_contributor_type_description`) VALUES (DEFAULT, 'A02', 'WITH', 'AUTHOR          ', 'With                      ', 'With (or as told to; \'ghost\' author)     ');
INSERT INTO `content_contributor_type` (`content_contributor_type_id`, `content_contributor_type_code`, `content_contributor_type_shortvalue`, `content_contributor_type_group`, `content_contributor_type_displayvalue`, `content_contributor_type_description`) VALUES (DEFAULT, 'A11', 'DESIGNER', 'DESIGNER', 'Designed by', 'Designer');
INSERT INTO `content_contributor_type` (`content_contributor_type_id`, `content_contributor_type_code`, `content_contributor_type_shortvalue`, `content_contributor_type_group`, `content_contributor_type_displayvalue`, `content_contributor_type_description`) VALUES (DEFAULT, 'B01', 'EDITOR', 'EDITOR', 'Edited by', 'Editor');
INSERT INTO `content_contributor_type` (`content_contributor_type_id`, `content_contributor_type_code`, `content_contributor_type_shortvalue`, `content_contributor_type_group`, `content_contributor_type_displayvalue`, `content_contributor_type_description`) VALUES (DEFAULT, NULL, 'ANIMATOR', 'ILLUSTRATOR', 'Animated by', 'Animator');
INSERT INTO `content_contributor_type` (`content_contributor_type_id`, `content_contributor_type_code`, `content_contributor_type_shortvalue`, `content_contributor_type_group`, `content_contributor_type_displayvalue`, `content_contributor_type_description`) VALUES (DEFAULT, 'A12', 'ILLUSTRATOR', 'ILLUSTRATOR', 'Illustrated by', 'Illustrator');
INSERT INTO `content_contributor_type` (`content_contributor_type_id`, `content_contributor_type_code`, `content_contributor_type_shortvalue`, `content_contributor_type_group`, `content_contributor_type_displayvalue`, `content_contributor_type_description`) VALUES (DEFAULT, 'C01', 'COMPILED_BY', 'PRINTER', 'Compiled By', 'Compiled By');
INSERT INTO `content_contributor_type` (`content_contributor_type_id`, `content_contributor_type_code`, `content_contributor_type_shortvalue`, `content_contributor_type_group`, `content_contributor_type_displayvalue`, `content_contributor_type_description`) VALUES (DEFAULT, NULL, 'PRINTER', 'PRINTER', 'Printed by', 'Printer');
INSERT INTO `content_contributor_type` (`content_contributor_type_id`, `content_contributor_type_code`, `content_contributor_type_shortvalue`, `content_contributor_type_group`, `content_contributor_type_displayvalue`, `content_contributor_type_description`) VALUES (DEFAULT, 'C01', 'COMPILED_BY', 'PUBLISHER', 'Compiled By', 'Compiled By');
INSERT INTO `content_contributor_type` (`content_contributor_type_id`, `content_contributor_type_code`, `content_contributor_type_shortvalue`, `content_contributor_type_group`, `content_contributor_type_displayvalue`, `content_contributor_type_description`) VALUES (DEFAULT, NULL, 'PUBLISHER', 'PUBLISHER', 'Published by', 'Publisher');
INSERT INTO `content_contributor_type` (`content_contributor_type_id`, `content_contributor_type_code`, `content_contributor_type_shortvalue`, `content_contributor_type_group`, `content_contributor_type_displayvalue`, `content_contributor_type_description`) VALUES (DEFAULT, 'B05', 'ADAPTED_BY', 'TRANSLATOR', 'Adapted by', 'Adapter');
INSERT INTO `content_contributor_type` (`content_contributor_type_id`, `content_contributor_type_code`, `content_contributor_type_shortvalue`, `content_contributor_type_group`, `content_contributor_type_displayvalue`, `content_contributor_type_description`) VALUES (DEFAULT, 'B03', 'RETOLD_BY', 'TRANSLATOR', 'Retold By', 'Retold By');
INSERT INTO `content_contributor_type` (`content_contributor_type_id`, `content_contributor_type_code`, `content_contributor_type_shortvalue`, `content_contributor_type_group`, `content_contributor_type_displayvalue`, `content_contributor_type_description`) VALUES (DEFAULT, 'B06', 'TRANSLATOR', 'TRANSLATOR', 'Translated by', 'Translator');

COMMIT;


-- -----------------------------------------------------
-- Data for table `role`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `role` (`r_id`, `r_name`) VALUES (111, 'authenticated_user');
INSERT INTO `role` (`r_id`, `r_name`) VALUES (222, 'admin');
INSERT INTO `role` (`r_id`, `r_name`) VALUES (333, 'master_editor');
INSERT INTO `role` (`r_id`, `r_name`) VALUES (444, 'content_editor');
INSERT INTO `role` (`r_id`, `r_name`) VALUES (555, 'component_editor');
INSERT INTO `role` (`r_id`, `r_name`) VALUES (666, 'program_editor');
INSERT INTO `role` (`r_id`, `r_name`) VALUES (777, 'api_consumer');
INSERT INTO `role` (`r_id`, `r_name`) VALUES (888, 'component_reviewer');
INSERT INTO `role` (`r_id`, `r_name`) VALUES (999, 'assembly_reviewer');
INSERT INTO `role` (`r_id`, `r_name`) VALUES (699, 'assembly_editor');
INSERT INTO `role` (`r_id`, `r_name`) VALUES (505, 'component_code_editor');

COMMIT;

