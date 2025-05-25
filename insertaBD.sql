-- -- si un pais no desenvolupa no formarà part de la BD

-- drop trigger if exists potencial_arma;
-- delimiter //
-- create trigger potencial_arma
-- after insert on armes_biologiques
-- for each row 
-- begin
--     if armes_biologiques.potencial > 5 then
--         update zona_biocontencio 
--         set nivell = 'A'
--         where codi = armes_biologiques.zona;
--     end if;
-- end;
-- //
-- delimiter ;

-- if responsable from zona_biocontencio is null then
--     set responsable = null for each row;
-- end if;

-- drop trigger if exists destitucio;
-- delimiter //
-- create trigger destitucio
-- update on zona_biocontencio
-- for each row
-- //
-- delimiter ;



insert into paisos(nom,pot_desenv,tractat_signat) values ('ANDORRA', 4, true);
insert into paisos(nom,pot_desenv,tractat_signat) values ('ESPANYA', 3, true);

insert into empleats(num_pass,nom_empleats) values ("13245A","Anna Poblet");
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
insert into qualificats(num_pass,titulacio,zona_assignada,lab) values ('13245A','ENG. QUIMIC',NULL,NULL);
insert into qualificats(num_pass,titulacio,zona_assignada,lab) values ('24351N','ENG. QUIMIC',NULL,NULL);

 insert into zona_biocontencio(codi,codiLab,nivell,responsable) values (1,1,'A','54321J');
 insert into zona_biocontencio(codi,codiLab,nivell,responsable) values (2,1,'B','13245A');

 insert into armes_biologiques(nom_armes_biol,data,potencial,zona,lab) values ('ANTRAX','2002-03-08',7,1,1);
    insert into armes_biologiques(nom_armes_biol,data,potencial,zona,lab) values ('VIRUS','2002-03-08',7,2,1);


insert into assignacions(data,empl_ord,zona_assignacions,lab_assignacions,datafi) values ('2013-11-03','12345J',1,1,NULL);
insert into assignacions(data,empl_ord,zona_assignacions,lab_assignacions,datafi) values ('2013-11-03','98765P',1,1,NULL);
insert into assignacions(data,empl_ord,zona_assignacions,lab_assignacions,datafi) values ('2013-05-03','98765P',2,1,"2013-11-2");
insert into assignacions(data,empl_ord,zona_assignacions,lab_assignacions,datafi) values ('2013-05-03','67890G',2,1,"2013-11-2");


insert into qualificats(num_pass,titulacio,zona_assignada,lab) values ('22222L','ENG. QUIMIC',1,1);
insert into qualificats(num_pass,titulacio,zona_assignada,lab) values ('33333M','ENG. QUIMIC',1,1);
insert into qualificats(num_pass,titulacio,zona_assignada,lab) values ('44444B','ENG. QUIMIC',1,1);


