drop database if exists ARMES_BIO;
create database ARMES_BIO;
use ARMES_BIO;

-- si un pais no desenvolupa no formarà part de la BD

create table paisos(
    nom varchar(40) not null,
    pot_desenv int(1) not null,
    tractat_signat int(1) not null,
    constraint pk_paisos primary key (nom)
)engine=InnoDB;

create table empleats(
    num_pass varchar(6),
    nom_empleats varchar(40) not null,
    constraint pk_empleats primary key (num_pass)
)engine=innodb;

create table ordinaris(
    num_pass varchar(6),
    constraint pk_ordinaris primary key (num_pass),
    constraint fk_empleats_ord foreign key (num_pass) references empleats(num_pass)
)engine=innodb;

create table laboratoris(
    codi_laboratoris int(6),
    nom_laboratoris varchar(40), 
    pais varchar(40) not null,
    constraint pk_laboratoris primary key (codi_laboratoris),
    constraint fk_laboratoris_paisos foreign key (pais) references paisos(nom)
)engine=innodb;

create table qualificats (
    num_pass varchar(6),
    titulacio varchar(40) not null,
    zona_assignada int(2),
    lab int(6),
    constraint pk_qualificats primary key (num_pass),
    constraint fk_empleats_qual foreign key (num_pass) references empleats(num_pass)
)ENGINE=InnoDB;

create table zona_biocontencio(
    codi int(2),
    codiLab int(6),
    nivell varchar(1) not null,
    responsable varchar(6) not null,
    constraint pk_zona_biocontencio primary key (codi, codiLab),
    constraint fk_codiLab foreign key (codiLab) references laboratoris(codi_laboratoris),
    constraint fk_responsable foreign key (responsable) references qualificats(num_pass)
)engine=innodb;

ALTER TABLE qualificats
ADD CONSTRAINT fk_qualificats_zona
foreign key (zona_assignada, lab) references zona_biocontencio(codi, codiLab);

create table armes_biologiques(
    nom_armes_biol varchar(40),
    data date,
    potencial int(1) not null,
    zona int(2) not null,
    lab int(6) not null,
    constraint pk_armes_biologiques primary key (nom_armes_biol),
    constraint fk_zona_lab_armes foreign key (zona, lab) references zona_biocontencio(codi, codiLab)
)engine=innodb;

create table assignacions(
    data date,
    empl_ord varchar(6),
    zona_assignacions int(2),
    lab_assignacions int(6) ,
    datafi date,
    constraint pk_assignacions primary key (data,empl_ord),
    constraint fk_ordinari foreign key (empl_ord) references ordinaris(num_pass),
    constraint fk_zona_lab_assignacions foreign key (zona_assignacions,lab_assignacions) references zona_biocontencio(codi,codiLab)
)engine=innodb;



