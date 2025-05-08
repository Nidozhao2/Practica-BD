drop database ARMES_BIO;
create database ARMES_BIO;
use ARMES_BIO;



-- si un pais no desenvolupa no formarà part de la BD
create table paisos(
    nom varchar(40) not null,
    pot_desenv int(1) not null,
    tractat_signat boolean,
    constraint pk_paisos primary key (nom)
)engine=innodb;

insert into paisos(nom,pot_desenv,tractat_signat) values ('ANDORRA', 4, true);
insert into paisos(nom,pot_desenv,tractat_signat) values ('ESPANYA', 3, true);

create table empleats(
    num_pass int(3),
    nom_empleats varchar(40),

    constraint pk_empleats primary key (num_pass)

)engine=innodb;


create table ordinaris(
    num_pass_ordinaris int(3),

    constraint pk_ordinaris primary key (num_pass_ordinaris),
    constraint fk_empleats_ord foreign key (num_pass_ordinaris) references empleats(num_pass)
)engine=innodb;

create table laboratoris(
    codi_laboratoris int(6),
    nom_laboratoris varchar(40), 
    pais varchar(40),
    constraint pk_laboratoris primary key (codi_laboratoris),
    constraint fk_laboratoris_paisos foreign key (pais) references paisos(nom)
)engine=innodb;

-- insert into laboratoris(codi_laboratoris,nom_laboratoris,pais) values (1,'BCN-XXX','ANDORRA');
-- insert into laboratoris(codi_laboratoris,nom_laboratoris,pais) values (2,'MAT-YYY','ANDORRA');
-- insert into laboratoris(codi_laboratoris,nom_laboratoris,pais) values (3,'MAD-AAA','ESPANYA');
 
create table qualificats(
    num_pass_qual int(3),
    titulacio varchar(40),
    zona_assignada int(2),
    lab int(6),



    constraint pk_qualificats primary key (num_pass_qual),
    constraint fk_empleats_qual foreign key (num_pass_qual) references empleats(num_pass),
    
)engine=innodb;


create table zona_biocontencio(
    codi int(2),
    codiLab int(6) ,
    nivell varchar(1),
    responsable int(3) ,

    constraint pk_zona_biocontencio primary key (codi, codiLab),
    constraint fk_codiLab foreign key (codiLab) references laboratoris(codi_laboratoris),
    constraint fk_responsable foreign key (responsable) references qualificats(num_pass)

)engine=innodb;






-- insert into zona_biocontencio(codi,codiLab,nivell,responsable) values (1,1,'A','54321J');
-- insert into zona_biocontencio(codi,codiLab,nivell,responsable) values (2,1,'B','13245A');
-- insert into zona_biocontencio(codi,codiLab,nivell,responsable) values (1,3,'M','12345J');



-- Now alter qualificats to add the foreign key to zona_biocontencio
ALTER TABLE qualificats
ADD CONSTRAINT fk_qualificats_zona
foreign key (zona_assignada, lab) references zona_biocontencio(codi, codiLab);


create table armes_biologiques(
    nom_armes_biol varchar(40),
    data date,
    potencial int(1),
    zona int(2) not null,
    lab int(6) not null,

    constraint pk_armes_biologiques primary key (nom_armes_biol),
    constraint fk_zona_lab_armes foreign key (zona, lab) references zona_biocontencio(codi, codiLab)


)engine=innodb;

-- insert into armes_biologiques(nom_armes_biol,data,potencial,zona,lab) values ('ANTRAX','08/03/2002',7,1,1);


create table assignacions(
    data date,
    empl_ord int(3),
    zona_assignacions int(2) not null,
    lab_assignacions int(6) not null,
    datafi date,

    constraint pk_assignacions primary key (data,empl_ord),
    constraint fk_ordinari foreign key (empl_ord) references ordinaris(num_pass_ordinaris),
    constraint fk_zona_lab_assignacions foreign key (zona_assignacions,lab_assignacions) references zona_biocontencio(codi,codiLab)

)engine=innodb;