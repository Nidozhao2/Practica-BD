drop database if exists ARMES_BIO;
create database ARMES_BIO;
use ARMES_BIO;



-- si un pais no desenvolupa no formarà part de la BD
create table paisos(
    nom varchar(40) not null,
    pot_desenv int(1) not null,
    tractat_signat boolean not null,
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





insert into paisos(nom,pot_desenv,tractat_signat) values ('ANDORRA', 4, true);
insert into paisos(nom,pot_desenv,tractat_signat) values ('ESPANYA', 3, true);


insert into empleats(num_pass,nom_empleats) values ("12345A","Anna Poblet");
insert into empleats(num_pass,nom_empleats) values ("12345J","Jordi Guasch");
insert into empleats(num_pass,nom_empleats) values ("54321J","Joan Domenech");
insert into empleats(num_pass,nom_empleats) values ("24351N","Neus Gimot");
insert into empleats(num_pass,nom_empleats) values ("98765P","Pau Cosip");
insert into empleats(num_pass,nom_empleats) values ("67890G","Gemma Puig");
insert into empleats(num_pass,nom_empleats) values ("22222L","Laia Claret");
insert into empleats(num_pass,nom_empleats) values ("33333M","Maria Rovira");
insert into empleats(num_pass,nom_empleats) values ("44444B","Bernat Pino");

insert into ordinaris(num_pass) values ("12345J");
insert into ordinaris(num_pass) values ("98765P");
insert into ordinaris(num_pass) values ("67890G");



insert into laboratoris(codi_laboratoris,nom_laboratoris,pais) values (1,'BCN-XXX','ANDORRA');
insert into laboratoris(codi_laboratoris,nom_laboratoris,pais) values (2,'MAT-YYY','ANDORRA');
insert into laboratoris(codi_laboratoris,nom_laboratoris,pais) values (3,'MAD-AAA','ESPANYA');
 
insert into qualificats(num_pass,titulacio,zona_assignada,lab) values ('54321J','ENG. QUIMIC',NULL,NULL);
insert into qualificats(num_pass,titulacio,zona_assignada,lab) values ('12345A','ENG. QUIMIC',NULL,NULL);
insert into qualificats(num_pass,titulacio,zona_assignada,lab) values ('24351N','ENG. QUIMIC',NULL,NULL);


 insert into zona_biocontencio(codi,codiLab,nivell,responsable) values (1,1,'A','54321J');
 insert into zona_biocontencio(codi,codiLab,nivell,responsable) values (2,1,'B','12345A');

 insert into armes_biologiques(nom_armes_biol,data,potencial,zona,lab) values ('ANTRAX','2002-03-08',7,1,1);







insert into assignacions(data,empl_ord,zona_assignacions,lab_assignacions,datafi) values ('2013-11-03','12345J',1,1,NULL);
insert into assignacions(data,empl_ord,zona_assignacions,lab_assignacions,datafi) values ('2013-11-03','98765P',1,1,NULL);
insert into assignacions(data,empl_ord,zona_assignacions,lab_assignacions,datafi) values ('2013-05-03','98765P',2,1,"2013-11-2");
insert into assignacions(data,empl_ord,zona_assignacions,lab_assignacions,datafi) values ('2013-05-03','67890G',2,1,"2013-11-2");

insert into qualificats(num_pass,titulacio,zona_assignada,lab) values ('22222L','ENG. QUIMIC',1,1);
insert into qualificats(num_pass,titulacio,zona_assignada,lab) values ('33333M','ENG. QUIMIC',1,1);
insert into qualificats(num_pass,titulacio,zona_assignada,lab) values ('44444B','ENG. QUIMIC',1,1);
