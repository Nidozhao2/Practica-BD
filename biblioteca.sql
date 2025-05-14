-- Exercici de la biblioteca
-- una opcio possible

DROP DATABASE IF EXISTS Biblioteca;
CREATE DATABASE Biblioteca;
USE Biblioteca;

CREATE TABLE Autors (
	nom_autor varchar(40),
	nacionalitat varchar(20),
	CONSTRAINT pk_autors PRIMARY KEY (nom_autor)
) ENGINE=InnoDB;

CREATE TABLE Obres (
	codi_obra int(5) zerofill auto_increment,
	titol varchar(50) NOT NULL,
	editorial varchar(40),
	CONSTRAINT pk_obres PRIMARY KEY(codi_obra)
) ENGINE=InnoDB;

CREATE TABLE escriu (
	nom_autor varchar(40),
	codi_obra int(5) zerofill,
	ordre int(2),
	CONSTRAINT pk_escriu PRIMARY KEY (nom_autor,codi_obra),
	CONSTRAINT fk_autor_escriu FOREIGN KEY (nom_autor) REFERENCES Autors(nom_autor),
	CONSTRAINT fk_obra_escrita FOREIGN KEY (codi_obra) REFERENCES Obres(codi_obra)
) ENGINE=InnoDB;

CREATE TABLE Volums(
	codi_obra int(5) zerofill,
	num_volum int(3),
	titol varchar(50),
	CONSTRAINT pk_volums PRIMARY KEY (codi_obra, num_volum),
	CONSTRAINT fk_obra_volum FOREIGN KEY (codi_obra) REFERENCES Obres(codi_obra)
) ENGINE=InnoDB;

CREATE TABLE Edicions(
	codi_obra int(5) zerofill,
	num_volum int(3),
	num_edicio int(3),

	any_ed int(4),
	num_planes int(4),
	isbn varchar(15),
	CONSTRAINT pk_edicions PRIMARY KEY(codi_obra, num_volum, num_edicio),
	CONSTRAINT fk_volum_edicio FOREIGN KEY (codi_obra, num_volum) REFERENCES Volums(codi_obra, num_volum)
) ENGINE=InnoDB;

CREATE TABLE Exemplars(
	codi_exemplar int(5) zerofill auto_increment,
	codi_obra int(5) zerofill not null,
	num_volum int(3) not null,
	num_edicio int(3) not null,
	tipus_prestec enum('normal','consulta_sala','cap_de_setmana'),
	CONSTRAINT pk_exemplars PRIMARY KEY (codi_exemplar),
	CONSTRAINT fk_edicio_exemplar FOREIGN KEY (codi_obra, num_volum, num_edicio) REFERENCES Edicions(codi_obra, num_volum, num_edicio)
) ENGINE=InnoDB;

CREATE TABLE Temes(
	nom_tema varchar(30),
	descripcio varchar(50),
	CONSTRAINT pk_temes PRIMARY KEY (nom_tema)
) ENGINE=InnoDB;

CREATE TABLE es(
	codi_obra int(5) zerofill not null,
	nom_tema varchar(30) not null,
	CONSTRAINT pk_es PRIMARY KEY (codi_obra, nom_tema),
	CONSTRAINT fk_es_obra FOREIGN KEY (codi_obra) REFERENCES Obres(codi_obra),
	CONSTRAINT fk_es_tema FOREIGN KEY (nom_tema) REFERENCES Temes(nom_tema)
) ENGINE=InnoDB;

CREATE TABLE Subtemes(
	nom_tema1 varchar(30),
	nom_tema2 varchar(30),
	CONSTRAINT pk_subtemes PRIMARY KEY (nom_tema1, nom_tema2),
	CONSTRAINT fk_subtema1 FOREIGN KEY (nom_tema1) REFERENCES Temes(nom_tema),
	CONSTRAINT fk_subtema2 FOREIGN KEY (nom_tema2) REFERENCES Temes(nom_tema)
) ENGINE=InnoDB;

CREATE TABLE Poblacions(
	nom VARCHAR(50),
	n_hab int,
	CONSTRAINT pk_poblacions PRIMARY KEY (nom)
) ENGINE=InnoDB;

CREATE TABLE Socis(
	dni varchar(9),
	nom varchar(30) not null,
	data_alta date not null,
	adreca varchar(50),
	poblacio varchar(50),
	data_naix date,
	CONSTRAINT pk_socis PRIMARY KEY (dni),
	CONSTRAINT fk_soci_viu FOREIGN KEY(poblacio) REFERENCES Poblacions(nom)
) ENGINE=InnoDB;

CREATE TABLE Prestecs(
	codi_exemplar int(5) zerofill,
	data_ini date,
	dni varchar(9) not null,
	data_fi date,
	prorrogat char(1),
	CONSTRAINT pk_prestecs PRIMARY KEY (codi_exemplar, data_ini),
	CONSTRAINT fk_exemplar_prestec FOREIGN KEY (codi_exemplar) REFERENCES Exemplars(codi_exemplar),
	CONSTRAINT ck_prorrogat CHECK (prorrogat IN ('S','N') ), -- NOTA: Els checks no es control.len en MySQL
	CONSTRAINT fk_soci_prestec FOREIGN KEY (dni) REFERENCES Socis(dni)
	
) ENGINE=InnoDB;

CREATE TABLE Soliciten_Obra(
	dni varchar(9),
	codi_obra int(5) zerofill,
	data_reserva date not null,
	CONSTRAINT pk_soliciten_obra PRIMARY KEY (dni, codi_obra),
	CONSTRAINT fk_soci_sol_obra FOREIGN KEY (dni) references Socis(dni),
	CONSTRAINT fk_soliciten_obra FOREIGN KEY (codi_obra) references Obres(codi_obra)
) ENGINE=InnoDB;

CREATE TABLE Soliciten_Volum(
	dni varchar(9),
	codi_obra int(5) zerofill,
	num_volum int(3),
	data_reserva date not null,
	CONSTRAINT pk_soliciten_volum PRIMARY KEY (dni, codi_obra, num_volum),
	CONSTRAINT fk_soci_sol_volum FOREIGN KEY (dni) REFERENCES Socis(dni),
	CONSTRAINT fk_soliciten_volum FOREIGN KEY (codi_obra, num_volum) REFERENCES Volums(codi_obra, num_volum)
) ENGINE=InnoDB;

CREATE TABLE Soliciten_Edicio(
	dni varchar(9),
	codi_obra int(5) zerofill,
	num_volum int(3),
	num_edicio int(3),
	data_reserva date not null,
	CONSTRAINT pk_soliciten_edicio PRIMARY KEY (dni, codi_obra, num_volum, num_edicio),
	CONSTRAINT fk_soci_sol_edicio FOREIGN KEY (dni) REFERENCES Socis(dni),
	CONSTRAINT fk_soliciten_edicio FOREIGN KEY (codi_obra, num_volum, num_edicio) REFERENCES Edicions(codi_obra, num_volum, num_edicio)
) ENGINE=InnoDB;


INSERT INTO Autors (nom_autor, nacionalitat) VALUES
('Ignacio Zahonero Martinez', 'espanyola');
INSERT INTO Autors (nom_autor, nacionalitat) VALUES
('J. Glenn Brookshear', NULL);
INSERT INTO Autors (nom_autor, nacionalitat) VALUES
('Luis Joyanes Aguilar', 'espanyola');
INSERT INTO Autors (nom_autor, nacionalitat) VALUES
('Paul Dubois', NULL);

INSERT INTO Obres (codi_obra, titol, editorial) VALUES
(00001, 'MySQL', 'Addison-Wesley');
INSERT INTO Obres (codi_obra, titol, editorial) VALUES
(00002, 'MySQL Cookbook', 'O''Reilly');
INSERT INTO Obres (codi_obra, titol, editorial) VALUES
(00003, 'Computer science: an overview', 'Addison-Wesley');
INSERT INTO Obres (codi_obra, titol, editorial) VALUES
(00004, 'Programación en C', 'McGraw-Hill');

INSERT INTO escriu (nom_autor, codi_obra, ordre) VALUES
('Ignacio Zahonero Martinez', 00004, 2);
INSERT INTO escriu (nom_autor, codi_obra, ordre) VALUES
('J. Glenn Brookshear', 00003, 1);
INSERT INTO escriu (nom_autor, codi_obra, ordre) VALUES
('Luis Joyanes Aguilar', 00004, 1);
INSERT INTO escriu (nom_autor, codi_obra, ordre) VALUES
('Paul Dubois', 00001, 1);
INSERT INTO escriu (nom_autor, codi_obra, ordre) VALUES
('Paul Dubois', 00002, 1);

INSERT INTO Volums (codi_obra, num_volum, titol) VALUES
(00001, 1, 'MySQL');
INSERT INTO Volums (codi_obra, num_volum, titol) VALUES
(00002, 1, 'MySQL Cookbook');
INSERT INTO Volums (codi_obra, num_volum, titol) VALUES
(00003, 1, 'Computer science : an overview');
INSERT INTO Volums (codi_obra, num_volum, titol) VALUES
(00004, 1, 'Metodología, estructura de datos y objetos');
INSERT INTO Volums (codi_obra, num_volum, titol) VALUES
(00004, 2, 'Libro de problemas');

INSERT INTO Edicions (codi_obra, num_volum, num_edicio, any_ed, num_planes, isbn) VALUES
(00001, 1, 1, 1999, 756, '0-7357-0921-1');
INSERT INTO Edicions (codi_obra, num_volum, num_edicio, any_ed, num_planes, isbn) VALUES
(00001, 1, 3, 2005, 1320, '0-672-32673-6');
INSERT INTO Edicions (codi_obra, num_volum, num_edicio, any_ed, num_planes, isbn) VALUES
(00001, 1, 4, 2008, 1200, '0-672-32938-7');
INSERT INTO Edicions (codi_obra, num_volum, num_edicio, any_ed, num_planes, isbn) VALUES
(00002, 1, 2, 2006, 948, '059652708X');
INSERT INTO Edicions (codi_obra, num_volum, num_edicio, any_ed, num_planes, isbn) VALUES
(00003, 1, 5, 1997, 483, '0805346325');
INSERT INTO Edicions (codi_obra, num_volum, num_edicio, any_ed, num_planes, isbn) VALUES
(00004, 1, 1, 2001, 735, '84-481-3013-8');
INSERT INTO Edicions (codi_obra, num_volum, num_edicio, any_ed, num_planes, isbn) VALUES
(00004, 2, 1, 2001, 324, '8448107004');
INSERT INTO Edicions (codi_obra, num_volum, num_edicio, any_ed, num_planes, isbn) VALUES
(00004, 2, 2, 2004, 375, '8448107184');

INSERT INTO Exemplars (codi_exemplar, codi_obra, num_volum, num_edicio, tipus_prestec) VALUES
(00001, 00001, 1, 4, 'normal');
INSERT INTO Exemplars (codi_exemplar, codi_obra, num_volum, num_edicio, tipus_prestec) VALUES
(00002, 00001, 1, 4, 'consulta_sala');
INSERT INTO Exemplars (codi_exemplar, codi_obra, num_volum, num_edicio, tipus_prestec) VALUES
(00003, 00001, 1, 3, 'normal');
INSERT INTO Exemplars (codi_exemplar, codi_obra, num_volum, num_edicio, tipus_prestec) VALUES
(00004, 00001, 1, 1, 'normal');
INSERT INTO Exemplars (codi_exemplar, codi_obra, num_volum, num_edicio, tipus_prestec) VALUES
(00005, 00001, 1, 1, 'normal');
INSERT INTO Exemplars (codi_exemplar, codi_obra, num_volum, num_edicio, tipus_prestec) VALUES
(00006, 00001, 1, 1, 'consulta_sala');
INSERT INTO Exemplars (codi_exemplar, codi_obra, num_volum, num_edicio, tipus_prestec) VALUES
(00007, 00002, 1, 2, 'normal');
INSERT INTO Exemplars (codi_exemplar, codi_obra, num_volum, num_edicio, tipus_prestec) VALUES
(00008, 00002, 1, 2, 'consulta_sala');
INSERT INTO Exemplars (codi_exemplar, codi_obra, num_volum, num_edicio, tipus_prestec) VALUES
(00009, 00003, 1, 5, 'normal');
INSERT INTO Exemplars (codi_exemplar, codi_obra, num_volum, num_edicio, tipus_prestec) VALUES
(00010, 00004, 1, 1, 'normal');
INSERT INTO Exemplars (codi_exemplar, codi_obra, num_volum, num_edicio, tipus_prestec) VALUES
(00011, 00004, 1, 1, 'consulta_sala');
INSERT INTO Exemplars (codi_exemplar, codi_obra, num_volum, num_edicio, tipus_prestec) VALUES
(00012, 00004, 2, 1, 'normal');
INSERT INTO Exemplars (codi_exemplar, codi_obra, num_volum, num_edicio, tipus_prestec) VALUES
(00013, 00004, 2, 1, 'consulta_sala');
INSERT INTO Exemplars (codi_exemplar, codi_obra, num_volum, num_edicio, tipus_prestec) VALUES
(00014, 00004, 2, 2, 'normal');
INSERT INTO Exemplars (codi_exemplar, codi_obra, num_volum, num_edicio, tipus_prestec) VALUES
(00015, 00004, 2, 2, 'consulta_sala');


INSERT INTO Temes (nom_tema, descripcio) VALUES
('Algorismica', 'Llibres sobre algorismica i esquemes algorismics');
INSERT INTO Temes (nom_tema, descripcio) VALUES
('Aplicacions', 'Llibres sobre aplicacions informàtiques');
INSERT INTO Temes (nom_tema, descripcio) VALUES
('Bases de Dades', 'Llibres sobre l''apassionant món de les bases de da');
INSERT INTO Temes (nom_tema, descripcio) VALUES
('Informàtica', 'Llibres sobre informàtica en general');
INSERT INTO Temes (nom_tema, descripcio) VALUES
('Llenguatges', 'Llibres sobre llenguatges de programació');
INSERT INTO Temes (nom_tema, descripcio) VALUES
('Programació', 'Llibres sobre llenguatges de programació i altres ');

INSERT INTO es (codi_obra, nom_tema) VALUES
(00001, 'Bases de Dades');
INSERT INTO es (codi_obra, nom_tema) VALUES
(00002, 'Bases de Dades');
INSERT INTO es (codi_obra, nom_tema) VALUES
(00003, 'Informàtica');
INSERT INTO es (codi_obra, nom_tema) VALUES
(00001, 'Llenguatges');
INSERT INTO es (codi_obra, nom_tema) VALUES
(00002, 'Llenguatges');
INSERT INTO es (codi_obra, nom_tema) VALUES
(00004, 'Programació');

INSERT INTO Subtemes (nom_tema1, nom_tema2) VALUES
('Programació', 'Algorismica');
INSERT INTO Subtemes (nom_tema1, nom_tema2) VALUES
('Informàtica', 'Aplicacions');
INSERT INTO Subtemes (nom_tema1, nom_tema2) VALUES
('Informàtica', 'Bases de Dades');
INSERT INTO Subtemes (nom_tema1, nom_tema2) VALUES
('Programació', 'Llenguatges');
INSERT INTO Subtemes (nom_tema1, nom_tema2) VALUES
('Informàtica', 'Programació');

INSERT INTO Poblacions(nom, n_hab) VALUES ('Tarragona',130323);
INSERT INTO Poblacions(nom, n_hab) VALUES ('Reus',107118);
INSERT INTO Poblacions(nom, n_hab) VALUES ('Salou',26650);
INSERT INTO Poblacions(nom, n_hab) VALUES ('Torredembarra',15312);

INSERT INTO Socis (dni, nom, data_alta, adreca, poblacio, data_naix) VALUES
('11111111A', 'Joan Casals Solà', '2005-04-15', 'c/ Montseny, 28','Tarragona','1974-09-15');
INSERT INTO Socis (dni, nom, data_alta, adreca, poblacio, data_naix) VALUES
('22222222B', 'Teresa Badia Compte', '2007-06-28', 'c/Solana, 15','Tarragona','1975-01-17');
INSERT INTO Socis (dni, nom, data_alta, adreca, poblacio, data_naix) VALUES
('33333333C', 'Joana Masdeu Torres', '2005-03-18', 'c/Aixaviga, 14','Reus','1975-12-26');
INSERT INTO Socis (dni, nom, data_alta, adreca, poblacio, data_naix) VALUES
('44444444D', 'Lluís Solé  Segura', '2008-09-12', 'c/ Muralla, 27','Salou','1984-03-24');
INSERT INTO Socis (dni, nom, data_alta, adreca, poblacio, data_naix) VALUES
('55555555E', 'Andreu Buenafuente', '2008-09-31', NULL,NULL,'1969-05-17');




