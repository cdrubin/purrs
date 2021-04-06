
-- -----------------------------------------------------
-- Table attribute_status
-- -----------------------------------------------------
CREATE TABLE attribute_status (
  attribute_status_value VARCHAR(20) NOT NULL,
  PRIMARY KEY (attribute_status_value));




-- -----------------------------------------------------
-- Table content_series
-- -----------------------------------------------------
CREATE TABLE content_series (
  content_series_cuid VARCHAR(32) NOT NULL,
  content_series_displayvalue VARCHAR(255) NULL,
  content_series_abbrev VARCHAR(45) NULL,
  content_series_description TEXT NULL,
  content_series_ordering INT NULL,
  content_series_status VARCHAR(20) NOT NULL,
  PRIMARY KEY (content_series_cuid),
  CONSTRAINT fk_content_series_attribute_status1
    FOREIGN KEY (content_series_status)
    REFERENCES attribute_status (attribute_status_value)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);    
   

-- -----------------------------------------------------
-- Table content_type
-- -----------------------------------------------------
CREATE TABLE content_type (
  content_type_cuid VARCHAR(32) NOT NULL,
  content_type_displayvalue VARCHAR(255) NULL,
  content_type_abbrev VARCHAR(45) NULL,
  content_type_description TEXT NULL,
  content_type_ordering INT NULL,
  content_type_status VARCHAR(20) NOT NULL,
  PRIMARY KEY (content_type_cuid),
  CONSTRAINT fk_content_type_attribute_status1
    FOREIGN KEY (content_type_status)
    REFERENCES attribute_status (attribute_status_value)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

 
-- -----------------------------------------------------
-- Table datum_status
-- -----------------------------------------------------
CREATE TABLE datum_status (
  datum_status_value VARCHAR(30) NOT NULL,
  PRIMARY KEY (datum_status_value));


-- -----------------------------------------------------
-- Table content
-- -----------------------------------------------------
CREATE TABLE content (
  c_id SERIAL NOT NULL,
  c_code VARCHAR(32) NOT NULL,
  c_content_series_cuid VARCHAR(32) NOT NULL,
  c_content_type_cuid VARCHAR(32) NOT NULL,
  c_cover_title VARCHAR(255) NULL,
  c_abbrev_title VARCHAR(40) NULL,
  c_word_count INTEGER NULL,
  c_page_count INTEGER NULL,
  c_description TEXT NULL,
  c_keywords TEXT NULL,
  c_created TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  c_updated TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  c_datum_status VARCHAR(20) NOT NULL,
  c_notes TEXT NULL,
  PRIMARY KEY (c_id),
  UNIQUE (c_code),
  CONSTRAINT fk_content_datum_status1
    FOREIGN KEY (c_datum_status)
    REFERENCES datum_status (datum_status_value)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_content_content_series1
    FOREIGN KEY (c_content_series_cuid)
    REFERENCES content_series (content_series_cuid)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_content_content_type1
    FOREIGN KEY (c_content_type_cuid)
    REFERENCES content_type (content_type_cuid)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
   
CREATE INDEX content_cover_title ON content ( c_cover_title ); 
   


-- -----------------------------------------------------
-- Table instance_delivery_format
-- -----------------------------------------------------

CREATE TABLE instance_delivery_format (
  instance_delivery_format_cuid VARCHAR(32) NOT NULL,
  instance_delivery_format_displayvalue VARCHAR(255) NULL,
  instance_delivery_format_abbrev VARCHAR(45) NULL,
  instance_delivery_format_description TEXT NULL,
  instance_delivery_format_ordering INT NULL,
  instance_delivery_format_status VARCHAR(20) NOT NULL,
  PRIMARY KEY (instance_delivery_format_cuid),
  CONSTRAINT fk_instance_delivery_format_attribute_status1
    FOREIGN KEY (instance_delivery_format_status)
    REFERENCES attribute_status (attribute_status_value)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

   

-- -----------------------------------------------------
-- Table instance_print_specification
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS instance_print_specification (
  instance_print_specification_cuid VARCHAR(32) NOT NULL,
  instance_print_specification_displayvalue VARCHAR(255) NULL,
  instance_print_specification_abbrev VARCHAR(45) NULL,
  instance_print_specification_description TEXT NULL,
  instance_print_specification_size_wxh VARCHAR(255) NULL,
  instance_print_specification_size_d VARCHAR(255) NULL,
  instance_print_specification_weight_g VARCHAR(45) NULL,
  instance_print_specification_page_count VARCHAR(255) NULL,
  instance_print_specification_text_stock VARCHAR(255) NULL,
  instance_print_specification_cover_stock TEXT NULL,
  instance_print_specification_binding VARCHAR(255) NULL,
  instance_print_specification_print_text VARCHAR(255) NULL,
  instance_print_specification_print_cover VARCHAR(255) NULL,
  instance_print_specification_finishing TEXT NULL,
  instance_print_specification_dieline VARCHAR(255) NULL,
  instance_print_specification_inserts TEXT NULL,
  instance_print_specification_carton_pack_quantity VARCHAR(255) NULL,
  instance_print_specification_carton_size_lxwxh VARCHAR(255) NULL,
  instance_print_specification_carton_weight_kg VARCHAR(255) NULL,
  instance_print_specification_ordering INT NULL,
  instance_print_specification_status VARCHAR(20) NOT NULL,
  PRIMARY KEY (instance_print_specification_cuid),
  UNIQUE (instance_print_specification_abbrev),
  CONSTRAINT fk_print_specification_attribute_status1
    FOREIGN KEY (instance_print_specification_status)
    REFERENCES attribute_status (attribute_status_value)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table instance
-- -----------------------------------------------------
CREATE TABLE instance (
  i_id SERIAL NOT NULL,
  i_c_code VARCHAR(32) NOT NULL,
  i_code VARCHAR(32) NOT NULL,
  i_external_id VARCHAR(255) NULL,
  i_external_url VARCHAR(255) NULL,
  i_image_url VARCHAR(128) NULL,
  i_instance_delivery_format_cuid VARCHAR(32) NULL,
  i_instance_print_specification_cuid VARCHAR(32) NULL,
  i_created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  i_updated TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  i_datum_status VARCHAR(30) NOT NULL,
  i_notes TEXT NULL,
  PRIMARY KEY (i_id),
  UNIQUE (i_code),
  CONSTRAINT fk_instance_instance_delivery_format1
    FOREIGN KEY (i_instance_delivery_format_cuid)
    REFERENCES instance_delivery_format (instance_delivery_format_cuid)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_instance_datum_status1
    FOREIGN KEY (i_datum_status)
    REFERENCES datum_status (datum_status_value)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_instance_content1
    FOREIGN KEY (i_c_code)
    REFERENCES content (c_code)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_instance_print_specification1
    FOREIGN KEY (i_instance_print_specification_cuid)
    REFERENCES instance_print_specification (instance_print_specification_cuid)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table program_component_program
-- -----------------------------------------------------
CREATE TABLE program_component_program (
  program_component_program_cuid VARCHAR(32) NOT NULL,
  program_component_program_displayvalue VARCHAR(255) NULL DEFAULT NULL,
  program_component_program_abbrev VARCHAR(45) NULL,
  program_component_program_description TEXT NULL,
  program_component_program_ordering INT NULL,
  program_component_program_status VARCHAR(20) NOT NULL,
  PRIMARY KEY (program_component_program_cuid),
  CONSTRAINT fk_program_component_program_attribute_status1
    FOREIGN KEY (program_component_program_status)
    REFERENCES attribute_status (attribute_status_value)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table program_component_type
-- -----------------------------------------------------
CREATE TABLE program_component_type (
  program_component_type_cuid VARCHAR(32) NOT NULL,
  program_component_type_displayvalue VARCHAR(255) NULL,
  program_component_type_abbrev VARCHAR(45) NULL,
  program_component_type_description TEXT NULL,
  program_component_type_ordering INT NULL,
  program_component_type_status VARCHAR(20) NOT NULL,
  PRIMARY KEY (program_component_type_cuid),
  CONSTRAINT fk_program_component_type_attribute_status1
    FOREIGN KEY (program_component_type_status)
    REFERENCES attribute_status (attribute_status_value)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table program_component
-- -----------------------------------------------------
CREATE TABLE program_component (
  pc_id SERIAL NOT NULL,
  pc_program_component_program_cuid VARCHAR(32) NOT NULL,
  pc_i_code VARCHAR(32) NOT NULL,
  pc_program_component_type_cuid VARCHAR(32) NOT NULL,
  pc_datum_status VARCHAR(30) NOT NULL,
  PRIMARY KEY (pc_id),
  CONSTRAINT fk_program_component_component1
    FOREIGN KEY (pc_i_code)
    REFERENCES instance (i_code)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_program_component_datum_status1
    FOREIGN KEY (pc_datum_status)
    REFERENCES datum_status (datum_status_value)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,    
  CONSTRAINT fk_program_component_program_component_program1
    FOREIGN KEY (pc_program_component_program_cuid)
    REFERENCES program_component_program (program_component_program_cuid)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_program_component_program_component_type1
    FOREIGN KEY (pc_program_component_type_cuid)
    REFERENCES program_component_type (program_component_type_cuid)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


   
-- -----------------------------------------------------
-- Data for table attribute_status
-- -----------------------------------------------------
INSERT INTO attribute_status (attribute_status_value) VALUES ('ACTIVE');
INSERT INTO attribute_status (attribute_status_value) VALUES ('RETIRED');
INSERT INTO attribute_status (attribute_status_value) VALUES ('PLANNED');
INSERT INTO attribute_status (attribute_status_value) VALUES ('INVALID');


-- -----------------------------------------------------
-- Data for table datum_status
-- -----------------------------------------------------
INSERT INTO datum_status (datum_status_value) VALUES ('active');
INSERT INTO datum_status (datum_status_value) VALUES ('retired');
INSERT INTO datum_status (datum_status_value) VALUES ('planned');
INSERT INTO datum_status (datum_status_value) VALUES ('invalid');
   

-- -----------------------------------------------------
-- Data for table content_series
-- -----------------------------------------------------
INSERT into content_series (content_series_cuid,content_series_displayvalue,content_series_abbrev,content_series_description,content_series_ordering,content_series_status) VALUES
	 ('X-CSERIES-0001','Up and Up','UnU',NULL,NULL,'ACTIVE'),
	 ('X-CSERIES-0002','Starting To Be A Master','StBM',NULL,NULL,'ACTIVE'),
	 ('X-CSERIES-0003','Emotional Kindness','EKind',NULL,NULL,'ACTIVE');
	 
	
-- -----------------------------------------------------
-- Data for table content_type
-- -----------------------------------------------------
INSERT INTO content_type (content_type_cuid,content_type_displayvalue,content_type_abbrev,content_type_description,content_type_ordering,content_type_status) VALUES
	 ('X-CTYPE-0001','Teacher''s Guide','TG',NULL,NULL,'ACTIVE'),
	 ('X-CTYPE-0002','Comprehension Card','CC',NULL,NULL,'ACTIVE'),
	 ('X-CTYPE-0003','Writing Project Organizer','WPO',NULL,NULL,'ACTIVE'),
	 ('X-CTYPE-0004','Reader','READ',NULL,NULL,'ACTIVE'),
	 ('X-CTYPE-0005','Teachers Resource System','TRS',NULL,NULL,'ACTIVE');
	 

-- -----------------------------------------------------
-- Data for table content
-- -----------------------------------------------------
INSERT INTO content (c_code,c_content_series_cuid,c_content_type_cuid,c_cover_title,c_abbrev_title,c_word_count,c_page_count,c_description,c_keywords,c_created,c_updated,c_datum_status,c_notes) VALUES
	 ('C-00000002','X-CSERIES-0001','X-CTYPE-0004','Sitting Up','Sitting Up',NULL,NULL,NULL,NULL,'2021-04-06 14:08:07.090656','2021-04-06 14:08:07.090656','active',NULL),
	 ('C-00000003','X-CSERIES-0001','X-CTYPE-0004','Standing Up','Standing Up',NULL,NULL,NULL,NULL,'2021-04-06 14:08:07.099598','2021-04-06 14:08:07.099598','active',NULL),
	 ('C-00000004','X-CSERIES-0001','X-CTYPE-0004','Jumping Up','Jumping Up',NULL,NULL,NULL,NULL,'2021-04-06 14:08:07.102692','2021-04-06 14:08:07.102692','active',NULL),
	 ('C-00000005','X-CSERIES-0002','X-CTYPE-0001','Masters are Patient','Masters are Patient',NULL,NULL,NULL,NULL,'2021-04-06 14:08:07.105913','2021-04-06 14:08:07.105913','active',NULL),
	 ('C-00000006','X-CSERIES-0002','X-CTYPE-0004','Masters are Patient','Masters are Patient',NULL,NULL,NULL,NULL,'2021-04-06 14:08:07.108912','2021-04-06 14:08:07.108912','active',NULL),
	 ('C-00000007','X-CSERIES-0003','X-CTYPE-0005','I Feel Too','I Feel Too',NULL,NULL,NULL,NULL,'2021-04-06 14:08:07.111429','2021-04-06 14:08:07.111429','active',NULL),
	 ('C-00000008','X-CSERIES-0003','X-CTYPE-0003','I Feel Too','I Feel Too',NULL,NULL,NULL,NULL,'2021-04-06 14:08:07.113947','2021-04-06 14:08:07.113947','active',NULL),
	 ('C-00000009','X-CSERIES-0003','X-CTYPE-0002','I Feel Sadness Too','I Feel Sadness Too',NULL,NULL,NULL,NULL,'2021-04-06 14:08:07.117454','2021-04-06 14:08:07.117454','active',NULL),
	 ('C-00000010','X-CSERIES-0003','X-CTYPE-0001','I Feel Sadness Too','I Feel Sadness Too',NULL,NULL,NULL,NULL,'2021-04-06 14:08:07.119826','2021-04-06 14:08:07.119826','active',NULL),
	 ('C-00000001','X-CSERIES-0001','X-CTYPE-0004','Looking Up','Looking Up',NULL,NULL,NULL,NULL,'2021-04-06 14:02:47.100373','2021-04-06 14:02:47.100373','active',NULL);	
	
	
-- -----------------------------------------------------
-- Data for table instance_delivery_format
-- -----------------------------------------------------
INSERT INTO instance_delivery_format (instance_delivery_format_cuid,instance_delivery_format_displayvalue,instance_delivery_format_abbrev,instance_delivery_format_description,instance_delivery_format_ordering,instance_delivery_format_status) VALUES
	 ('X-IDELFORM-0001','HTML','HTML',NULL,NULL,'ACTIVE'),
	 ('X-IDELFORM-0002','PDF','PDF',NULL,NULL,'ACTIVE'),
	 ('X-IDELFORM-0003','ePub','EPUB',NULL,NULL,'ACTIVE');

	
-- -----------------------------------------------------
-- Data for table instance_print_specification
-- -----------------------------------------------------
INSERT INTO instance_print_specification (instance_print_specification_cuid,instance_print_specification_displayvalue,instance_print_specification_abbrev,instance_print_specification_description,instance_print_specification_size_wxh,instance_print_specification_size_d,instance_print_specification_weight_g,instance_print_specification_page_count,instance_print_specification_text_stock,instance_print_specification_cover_stock,instance_print_specification_binding,instance_print_specification_print_text,instance_print_specification_print_cover,instance_print_specification_finishing,instance_print_specification_dieline,instance_print_specification_inserts,instance_print_specification_carton_pack_quantity,instance_print_specification_carton_size_lxwxh,instance_print_specification_carton_weight_kg,instance_print_specification_ordering,instance_print_specification_status) VALUES
	 ('X-IPRINTSPEC-0001','Reader Elementary','Reader Elementary',NULL,'6.75 x 6',NULL,NULL,'8pp + cover','115 gsm Mattart (76#)','260 gsm 2/S Artcard (12 pt)','Saddle-Stitch','4c x 4c','4c x 4c','Film lamination outside',' UV inside',NULL,NULL,'312','14.25 x 12.625 x 4.875',NULL,'ACTIVE'),
	 ('X-IPRINTSPEC-0002','Reader Emergent','Reader Emergent',NULL,'6.75 x 6',NULL,NULL,'16pp + cover','115 gsm Mattart (76#)','260 gsm 2/S Artcard (12 pt)','Saddle-Stitch','4c x 4c','4c x 4c','Film lamination outside',' UV inside',NULL,NULL,'240','14.25 x 12.625 x 4.875',NULL,'ACTIVE'),
	 ('X-IPRINTSPEC-0003','Card Teacher','Card Teacher',NULL,NULL,NULL,NULL,'','260 gsm 2/S Artcard (12 pt)',NULL,'Trim to size','4c x 4c',NULL,'Two-sided gloss lamination',NULL,NULL,NULL,NULL,NULL,NULL,'ACTIVE');	


-- -----------------------------------------------------
-- Data for table instance
-- -----------------------------------------------------	
INSERT INTO instance (i_c_code,i_code,i_external_id,i_external_url,i_image_url,i_instance_delivery_format_cuid,i_instance_print_specification_cuid,i_created,i_updated,i_datum_status,i_notes) VALUES
	 ('C-00000001','I-D1',NULL,NULL,NULL,'X-IDELFORM-0001',NULL,'2021-04-06 14:40:22.05663','2021-04-06 14:40:22.05663','active',NULL),
	 ('C-00000001','I-D2',NULL,NULL,NULL,'X-IDELFORM-0002',NULL,'2021-04-06 14:40:22.062755','2021-04-06 14:40:22.062755','active',NULL),
	 ('C-00000001','I-P1',NULL,NULL,NULL,NULL,'X-IPRINTSPEC-0001','2021-04-06 14:40:22.065309','2021-04-06 14:40:22.065309','active',NULL),
	 ('C-00000002','I-D3',NULL,NULL,NULL,'X-IDELFORM-0001',NULL,'2021-04-06 14:40:22.068522','2021-04-06 14:40:22.068522','active',NULL),
	 ('C-00000002','I-D4',NULL,NULL,NULL,'X-IDELFORM-0002',NULL,'2021-04-06 14:40:22.078636','2021-04-06 14:40:22.078636','active',NULL),
	 ('C-00000002','I-P2',NULL,NULL,NULL,NULL,'X-IPRINTSPEC-0001','2021-04-06 14:40:22.081137','2021-04-06 14:40:22.081137','active',NULL),
	 ('C-00000003','I-D5',NULL,NULL,NULL,'X-IDELFORM-0001',NULL,'2021-04-06 14:40:22.083629','2021-04-06 14:40:22.083629','active',NULL),
	 ('C-00000003','I-D6',NULL,NULL,NULL,'X-IDELFORM-0002',NULL,'2021-04-06 14:40:22.088601','2021-04-06 14:40:22.088601','active',NULL),
	 ('C-00000003','I-P3',NULL,NULL,NULL,NULL,'X-IPRINTSPEC-0001','2021-04-06 14:40:22.091228','2021-04-06 14:40:22.091228','active',NULL),
	 ('C-00000004','I-D7',NULL,NULL,NULL,'X-IDELFORM-0001',NULL,'2021-04-06 14:40:22.093798','2021-04-06 14:40:22.093798','active',NULL);
INSERT INTO instance (i_c_code,i_code,i_external_id,i_external_url,i_image_url,i_instance_delivery_format_cuid,i_instance_print_specification_cuid,i_created,i_updated,i_datum_status,i_notes) VALUES
	 ('C-00000004','I-D8',NULL,NULL,NULL,'X-IDELFORM-0002',NULL,'2021-04-06 14:40:22.097','2021-04-06 14:40:22.097','active',NULL),
	 ('C-00000004','I-P4',NULL,NULL,NULL,NULL,'X-IPRINTSPEC-0001','2021-04-06 14:40:22.099067','2021-04-06 14:40:22.099067','active',NULL),
	 ('C-00000005','I-P5',NULL,NULL,NULL,NULL,NULL,'2021-04-06 14:40:22.101283','2021-04-06 14:40:22.101283','active',NULL),
	 ('C-00000005','I-P6',NULL,NULL,NULL,NULL,NULL,'2021-04-06 14:40:22.10324','2021-04-06 14:40:22.10324','active',NULL),
	 ('C-00000005','I-P7',NULL,NULL,NULL,NULL,NULL,'2021-04-06 14:40:22.105241','2021-04-06 14:40:22.105241','active',NULL),
	 ('C-00000006','I-P8',NULL,NULL,NULL,NULL,NULL,'2021-04-06 14:40:22.107294','2021-04-06 14:40:22.107294','active',NULL),
	 ('C-00000006','I-P9',NULL,NULL,NULL,NULL,NULL,'2021-04-06 14:40:22.10961','2021-04-06 14:40:22.10961','active',NULL),
	 ('C-00000006','I-P10',NULL,NULL,NULL,NULL,NULL,'2021-04-06 14:40:22.11212','2021-04-06 14:40:22.11212','active',NULL),
	 ('C-00000007','I-D9',NULL,NULL,NULL,'X-IDELFORM-0001',NULL,'2021-04-06 14:40:22.114207','2021-04-06 14:40:22.114207','active',NULL),
	 ('C-00000007','I-D10',NULL,NULL,NULL,'X-IDELFORM-0003',NULL,'2021-04-06 14:40:22.116782','2021-04-06 14:40:22.116782','active',NULL);
INSERT INTO instance (i_c_code,i_code,i_external_id,i_external_url,i_image_url,i_instance_delivery_format_cuid,i_instance_print_specification_cuid,i_created,i_updated,i_datum_status,i_notes) VALUES
	 ('C-00000008','I-D11',NULL,NULL,NULL,'X-IDELFORM-0001',NULL,'2021-04-06 14:40:22.119424','2021-04-06 14:40:22.119424','active',NULL),
	 ('C-00000008','I-D12',NULL,NULL,NULL,'X-IDELFORM-0002',NULL,'2021-04-06 14:40:22.122894','2021-04-06 14:40:22.122894','active',NULL),
	 ('C-00000008','I-D13',NULL,NULL,NULL,'X-IDELFORM-0003',NULL,'2021-04-06 14:40:22.126436','2021-04-06 14:40:22.126436','active',NULL),
	 ('C-00000008','I-P11',NULL,NULL,NULL,NULL,NULL,'2021-04-06 14:40:22.128678','2021-04-06 14:40:22.128678','active',NULL),
	 ('C-00000008','I-P12',NULL,NULL,NULL,NULL,NULL,'2021-04-06 14:40:22.130951','2021-04-06 14:40:22.130951','active',NULL),
	 ('C-00000009','I-D14',NULL,NULL,NULL,'X-IDELFORM-0002',NULL,'2021-04-06 14:40:22.136016','2021-04-06 14:40:22.136016','active',NULL),
	 ('C-00000009','I-P13',NULL,NULL,NULL,NULL,NULL,'2021-04-06 14:40:22.138022','2021-04-06 14:40:22.138022','active',NULL),
	 ('C-00000009','I-P14',NULL,NULL,NULL,NULL,NULL,'2021-04-06 14:40:22.139952','2021-04-06 14:40:22.139952','active',NULL),
	 ('C-00000010','I-D15',NULL,NULL,NULL,'X-IDELFORM-0002',NULL,'2021-04-06 14:40:22.142183','2021-04-06 14:40:22.142183','active',NULL),
	 ('C-00000010','I-D16',NULL,NULL,NULL,'X-IDELFORM-0001',NULL,'2021-04-06 14:40:22.144623','2021-04-06 14:40:22.144623','active',NULL);
INSERT INTO instance (i_c_code,i_code,i_external_id,i_external_url,i_image_url,i_instance_delivery_format_cuid,i_instance_print_specification_cuid,i_created,i_updated,i_datum_status,i_notes) VALUES
	 ('C-00000010','I-D17',NULL,NULL,NULL,'X-IDELFORM-0003',NULL,'2021-04-06 14:40:22.147153','2021-04-06 14:40:22.147153','active',NULL),
	 ('C-00000010','I-P15',NULL,NULL,NULL,NULL,NULL,'2021-04-06 14:40:22.149839','2021-04-06 14:40:22.149839','active',NULL),
	 ('C-00000010','I-P16',NULL,NULL,NULL,NULL,NULL,'2021-04-06 14:40:22.152036','2021-04-06 14:40:22.152036','active',NULL);	
	
	
-- -----------------------------------------------------
-- Data for table program_component_program
-- -----------------------------------------------------
INSERT INTO program_component_program (program_component_program_cuid,program_component_program_displayvalue,program_component_program_abbrev,program_component_program_description,program_component_program_ordering,program_component_program_status) VALUES
	 ('X-PCPROG-0001','Ascent Together','AT',NULL,NULL,'ACTIVE'),
	 ('X-PCPROG-0002','Better Stronger Collaborating','BSC',NULL,NULL,'ACTIVE');
	 

-- -----------------------------------------------------
-- Data for table program_component_type
-- -----------------------------------------------------
INSERT INTO program_component_type (program_component_type_cuid,program_component_type_displayvalue,program_component_type_abbrev,program_component_type_description,program_component_type_ordering,program_component_type_status) VALUES
	 ('X-PCTYPE-0001','(see content type)','(see content type)',NULL,NULL,'ACTIVE'),
	 ('X-PCTYPE-0002','Levelled Reader','Levelled Reader',NULL,NULL,'ACTIVE'),
	 ('X-PCTYPE-0003','Program Navigator','Program Navigator',NULL,NULL,'ACTIVE');
	

   
