drop database ARMES_BIO;

create database ARMES_BIO;
use ARMES_BIO;



-- si un pais no desenvolupa no formarà part de la BD
create table paisos(
    nom varchar(40),
    pot_desenv int(1) not null,
    tractat_signat boolean not null

    constraint pk_paisos primary key (nom)

)engine=innodb;


create table laboratoris(
    codi int(6) zerofill auto_increment,
    -- nom null/notnull???
    nom varchar(40) , 
    pais varchar(40) not null,
    constraint pk_laboratoris primary key (codi),
    constraint fk_paisos foreign key (pais) references paisos(nom)
)engine=innodb;

create table zona_biocontencio(
    codi int(2),
    codiLab int(6),
    nivell int(1) not null,
    responsable int(3),

    constraint pk_zona_biocontencio primary key (codi,codiLab),
    constraint fk_codiLab foreign key (codiLab) references laboratoris(codi),
    constraint fk_responsable foreign key (responsable) references qualificats(num_pass)

)engine=innodb;

create table armes_biologiques(
    nom varchar(40),
    data date,
    potencial int(1) not null,
    zona int(2) not null,
    lab int(6) not null,

    constraint pk_armes_biogiques primary key (nom),
    constraint fk_zona_lab foreign key (zona,lab) references zona_biocontencio(codi,codiLab)


)engine=innodb;

create table empleats(
    num_pass int(3),
    nom varchar(40) not null,

    constraint pk_empleats primary key (num_pass)

)engine=innodb;


create table ordinaris(
    num_pass int(3),

    constraint pk_ordinaris primary key (num_pass),
    constraint fk_empleats foreign key (num_pass) references empleats(num_pass)
)engine=innodb;

create table qualificats(
    num_pass int(3),
    titulacio varchar(40<<2) not null,
    zona_assignada int(2) not null,
    lab int(6) not null,



    constraint pk_ordinaris primary key (num_pass),
    constraint fk_empleats foreign key (num_pass) references empleats(num_pass),
    constraint fk_zona_assignada foreign key (zona_assignada,lab) references zona_biocontencio(codi,codiLab)
)engine=innodb;

create table assignacions(
    data date,
    empl_ord int(3),
    zona int(2) not null,
    lab int(6) not null,
    datafi date null,

    constraint pk_assignacions primary key (data,empl_ord),
    constraint fk_ordinari foreign key (empl_ord) references ordinaris(num_pass),
    constraint fk_zona_lab foreign key (zona,lab) references zona_biocontencio(codi,codiLab)

)engine=innodb;