DROP DATABASE IF EXISTS ARMES_BIO;
CREATE DATABASE ARMES_BIO;
USE ARMES_BIO;

-- Create paisos table
CREATE TABLE paisos (
    nom VARCHAR(40) NOT NULL,
    pot_desenv INT(1) NOT NULL,
    tractat_signat BOOLEAN NOT NULL,
    CONSTRAINT pk_paisos PRIMARY KEY (nom)
) ENGINE=InnoDB;

-- Insert sample data into paisos
INSERT INTO paisos(nom, pot_desenv, tractat_signat) VALUES ('ANDORRA', 4, TRUE);
INSERT INTO paisos(nom, pot_desenv, tractat_signat) VALUES ('ESPANYA', 3, TRUE);

-- Create empleats table
CREATE TABLE empleats (
    num_pass INT(3),
    nom_empleats VARCHAR(40) NOT NULL,
    CONSTRAINT pk_empleats PRIMARY KEY (num_pass)
) ENGINE=InnoDB;

-- Create ordinaris table
CREATE TABLE ordinaris (
    num_pass_ordinaris INT(3),
    CONSTRAINT pk_ordinaris PRIMARY KEY (num_pass_ordinaris),
    CONSTRAINT fk_ordinaris_empleats FOREIGN KEY (num_pass_ordinaris) REFERENCES empleats(num_pass)
) ENGINE=InnoDB;

-- Create laboratoris table
CREATE TABLE laboratoris (
    codi_laboratoris INT(6),
    nom_laboratoris VARCHAR(40),
    pais VARCHAR(40) NOT NULL,
    CONSTRAINT pk_laboratoris PRIMARY KEY (codi_laboratoris),
    CONSTRAINT fk_laboratoris_paisos FOREIGN KEY (pais) REFERENCES paisos(nom)
) ENGINE=InnoDB;

-- Create qualificats table without the zona_assignada foreign key temporarily
CREATE TABLE qualificats (
    num_pass INT(3),
    titulacio VARCHAR(40) NOT NULL,
    zona_assignada INT(2) NOT NULL,
    lab INT(6),
    CONSTRAINT pk_qualificats PRIMARY KEY (num_pass),
    CONSTRAINT fk_qualificats_empleats FOREIGN KEY (num_pass) REFERENCES empleats(num_pass)
) ENGINE=InnoDB;

-- Create zona_biocontencio table with corrected foreign keys
CREATE TABLE zona_biocontencio (
    codi INT(2),
    codiLab INT(6),
    nivell VARCHAR(1) NOT NULL,
    responsable INT(3) NOT NULL,
    CONSTRAINT pk_zona_biocontencio PRIMARY KEY (codi, codiLab),
    CONSTRAINT fk_zona_lab FOREIGN KEY (codiLab) REFERENCES laboratoris(codi_laboratoris),
    CONSTRAINT fk_responsable_qualificats FOREIGN KEY (responsable) REFERENCES qualificats(num_pass)
) ENGINE=InnoDB;

-- Now alter qualificats to add the foreign key to zona_biocontencio
ALTER TABLE qualificats
ADD CONSTRAINT fk_qualificats_zona
FOREIGN KEY (zona_assignada, lab) REFERENCES zona_biocontencio(codi, codiLab);

-- Create armes_biologiques table with syntax correction
CREATE TABLE armes_biologiques (
    nom_armes_biol VARCHAR(40),
    data DATE,
    potencial INT(1) NOT NULL,
    zona INT(2) NOT NULL,
    lab INT(6) NOT NULL,
    CONSTRAINT pk_armes_biologiques PRIMARY KEY (nom_armes_biol),
    CONSTRAINT fk_armes_zona_lab FOREIGN KEY (zona, lab) REFERENCES zona_biocontencio(codi, codiLab)
) ENGINE=InnoDB;

-- Create assignacions table
CREATE TABLE assignacions (
    data DATE,
    empl_ord INT(3),
    zona_assignacions INT(2) NOT NULL,
    lab_assignacions INT(6) NOT NULL,
    datafi DATE,
    CONSTRAINT pk_assignacions PRIMARY KEY (data, empl_ord),
    CONSTRAINT fk_assignacions_ordinaris FOREIGN KEY (empl_ord) REFERENCES ordinaris(num_pass_ordinaris),
    CONSTRAINT fk_assignacions_zona_lab FOREIGN KEY (zona_assignacions, lab_assignacions) REFERENCES zona_biocontencio(codi, codiLab)
) ENGINE=InnoDB;