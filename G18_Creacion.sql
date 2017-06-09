-- TUDAI 2017
-- TRABAJO PRACTICO ESPECIAL 
-- BASES DE DATOS 
-- Eduardo Bravo y Marcelo Prado



-- table: GR18_Categoria
CREATE TABLE GR18_Categoria (
    cdoCategoria varchar(20)  NOT NULL,
    cdoDisciplina varchar(10)  NOT NULL,
    descripcion varchar(200)  NOT NULL,
    edadMinima int  NOT NULL,
    edadMaxima int  NOT NULL,
    CONSTRAINT PK_GR18_categoria PRIMARY KEY (cdoCategoria,cdoDisciplina)
);

-- table: GR18_ClasificacionCompetencia
CREATE TABLE GR18_ClasificacionCompetencia (
    idCompetencia int  NOT NULL,
    tipoDoc varchar(3)  NOT NULL,
    nroDoc int  NOT NULL,
    puestoGeneral varchar(50)  NOT NULL,
    puntosGeneral int  NOT NULL,
    puestoCategoria varchar(50)  NOT NULL,
    puntosCategoria int  NOT NULL,
    CONSTRAINT PK_GR18_ClasificacionCompetencia PRIMARY KEY (idCompetencia,tipoDoc,nroDoc)
);

-- table: GR18_Competencia
CREATE TABLE GR18_Competencia (
    idCompetencia int  NOT NULL,
    cdoDisciplina varchar(10)  NOT NULL,
    nombre varchar(500)  NOT NULL,
    fecha timestamp  NULL,
    nombreLugar varchar(500)  NOT NULL,
    nombreLocalidad varchar(500)  NOT NULL,
    organizador varchar(500)  NOT NULL,
    individual bit(1)  NOT NULL,
    fechaLimiteInscripcion timestamp  NULL,
    cantJueces int  NOT NULL,
    coberturaTV bit(1)  NOT NULL,
    mapa text  NULL,
    web varchar(4000)  NULL,
    CONSTRAINT PK_GR18_competencia PRIMARY KEY (idCompetencia)
);

-- table: GR18_Deportista
CREATE TABLE GR18_Deportista (
    tipoDoc varchar(3)  NOT NULL,
    nroDoc int  NOT NULL,
    federado bit(1)  NOT NULL,
    fechaUltimaFederacion timestamp  NULL,
    nroLicencia varchar(20)  NULL,
    cdoCategoria varchar(20)  NOT NULL,
    cdoDisciplina varchar(10)  NOT NULL,
    cdoFederacion varchar(50)  NULL,
    cdoDisciplinaFederacion varchar(10)  NULL,
    CONSTRAINT PK_GR18_Deportista PRIMARY KEY (tipoDoc,nroDoc)
);

-- table: GR18_Disciplina
CREATE TABLE GR18_Disciplina (
    cdoDisciplina varchar(10)  NOT NULL,
    nombre varchar(100)  NOT NULL,
    descripcion text  NOT NULL,
    CONSTRAINT PK_GR18_Disciplina PRIMARY KEY (cdoDisciplina)
);

-- table: GR18_Equipo
CREATE TABLE GR18_Equipo (
    id int  NOT NULL,
    nombre varchar(100)  NOT NULL,
    fechaAlta timestamp  NOT NULL,
    CONSTRAINT PK_GR18_Equipo PRIMARY KEY (id)
);

-- table: GR18_EquipoDeportista
CREATE TABLE GR18_EquipoDeportista (
    id int  NOT NULL,
    tipoDoc varchar(3)  NOT NULL,
    nroDoc int  NOT NULL,
    CONSTRAINT PK_GR18_EquipoDeportista PRIMARY KEY (id,tipoDoc,nroDoc)
);

-- table: GR18_Federacion
CREATE TABLE GR18_Federacion (
    cdoFederacion varchar(50)  NOT NULL,
    cdoDisciplina varchar(10)  NOT NULL,
    nombre varchar(100)  NOT NULL,
    anioCreacion int  NULL,
    cantAfiliados int  NULL,
    CONSTRAINT PK_GR18_Federacion PRIMARY KEY (cdoFederacion,cdoDisciplina)
);

-- table: GR18_Inscripcion
CREATE TABLE GR18_Inscripcion (
    id int  NOT NULL,
    tipoDoc varchar(3)  NULL,
    nroDoc int  NULL,
    Equipo_id int  NULL,
    idCompetencia int  NOT NULL,
    fecha timestamp  NULL,
    CONSTRAINT PK_GR18_Inscripcion PRIMARY KEY (id)
);

-- table: GR18_Juez
CREATE TABLE GR18_Juez (
    tipoDoc varchar(3)  NOT NULL,
    nroDoc int  NOT NULL,
    oficial bit(1)  NOT NULL,
    nroLicencia varchar(20)  NULL,
    CONSTRAINT PK_GR18_Juez PRIMARY KEY (tipoDoc,nroDoc)
);

-- table: GR18_JuezCompetencia
CREATE TABLE GR18_JuezCompetencia (
    idCompetencia int  NOT NULL,
    tipoDoc varchar(3)  NOT NULL,
    nroDoc int  NOT NULL,
    CONSTRAINT PK_GR18_JuezCompetencia PRIMARY KEY (idCompetencia,tipoDoc,nroDoc)
);

-- table: GR18_Persona
CREATE TABLE GR18_Persona (
    tipoDoc varchar(3)  NOT NULL,
    nroDoc int  NOT NULL,
    nombre varchar(100)  NOT NULL,
    apellido varchar(100)  NOT NULL,
    direccion varchar(250)  NOT NULL,
    nombreLocalidad varchar(250)  NOT NULL,
    celular varchar(20)  NOT NULL,
    sexo char(1)  NOT NULL,
    mail varchar(100)  NULL,
    tipo char(1)  NOT NULL,
    fechaNacimiento timestamp  NOT NULL,
    CONSTRAINT PK_GR18_Persona PRIMARY KEY (tipoDoc,nroDoc)
);

-- foreign keys
-- Reference: FK_GR18_ClasificacionCompetencia_Competencia (table: GR18_ClasificacionCompetencia)
ALTER TABLE GR18_ClasificacionCompetencia ADD CONSTRAINT FK_GR18_ClasificacionCompetencia_Competencia
    FOREIGN KEY (idCompetencia)
    REFERENCES GR18_Competencia (idCompetencia)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_GR18_ClasificacionCompetencia_Deportista (table: GR18_ClasificacionCompetencia)
ALTER TABLE GR18_ClasificacionCompetencia ADD CONSTRAINT FK_GR18_ClasificacionCompetencia_Deportista
    FOREIGN KEY (tipoDoc, nroDoc)
    REFERENCES GR18_Deportista (tipoDoc, nroDoc)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_GR18_Competencia_Disciplina (table: GR18_Competencia)
ALTER TABLE GR18_Competencia ADD CONSTRAINT FK_GR18_Competencia_Disciplina
    FOREIGN KEY (cdoDisciplina)
    REFERENCES GR18_Disciplina (cdoDisciplina)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_GR18_Deportista_Categoria (table: GR18_Deportista)
ALTER TABLE GR18_Deportista ADD CONSTRAINT FK_GR18_Deportista_Categoria
    FOREIGN KEY (cdoCategoria, cdoDisciplina)
    REFERENCES GR18_Categoria (cdoCategoria, cdoDisciplina)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_GR18_Deportista_Federacion (table: GR18_Deportista)
ALTER TABLE GR18_Deportista ADD CONSTRAINT FK_GR18_Deportista_Federacion
    FOREIGN KEY (cdoFederacion, cdoDisciplinaFederacion)
    REFERENCES GR18_Federacion (cdoFederacion, cdoDisciplina)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_GR18_Deportista_Persona (table: GR18_Deportista)
ALTER TABLE GR18_Deportista ADD CONSTRAINT FK_GR18_Deportista_Persona
    FOREIGN KEY (tipoDoc, nroDoc)
    REFERENCES GR18_Persona (tipoDoc, nroDoc)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_GR18_EquipoDeportista_Deportista (table: GR18_EquipoDeportista)
ALTER TABLE GR18_EquipoDeportista ADD CONSTRAINT FK_GR18_EquipoDeportista_Deportista
    FOREIGN KEY (tipoDoc, nroDoc)
    REFERENCES GR18_Deportista (tipoDoc, nroDoc)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_GR18_EquipoDeportista_Equipo (table: GR18_EquipoDeportista)
ALTER TABLE GR18_EquipoDeportista ADD CONSTRAINT FK_GR18_EquipoDeportista_Equipo
    FOREIGN KEY (id)
    REFERENCES GR18_Equipo (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_GR18_Federacion_Disciplina (table: GR18_Federacion)
ALTER TABLE GR18_Federacion ADD CONSTRAINT FK_GR18_Federacion_Disciplina
    FOREIGN KEY (cdoDisciplina)
    REFERENCES GR18_Disciplina (cdoDisciplina)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_GR18_Inscripcion_Competencia (table: GR18_Inscripcion)
ALTER TABLE GR18_Inscripcion ADD CONSTRAINT FK_GR18_Inscripcion_Competencia
    FOREIGN KEY (idCompetencia)
    REFERENCES GR18_Competencia (idCompetencia)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_GR18_Inscripcion_Deportista (table: GR18_Inscripcion)
ALTER TABLE GR18_Inscripcion ADD CONSTRAINT FK_GR18_Inscripcion_Deportista
    FOREIGN KEY (tipoDoc, nroDoc)
    REFERENCES GR18_Deportista (tipoDoc, nroDoc)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_GR18_Inscripcion_Equipo (table: GR18_Inscripcion)
ALTER TABLE GR18_Inscripcion ADD CONSTRAINT FK_GR18_Inscripcion_Equipo
    FOREIGN KEY (Equipo_id)
    REFERENCES GR18_Equipo (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_GR18_JuezCompetencia_Competencia (table: GR18_JuezCompetencia)
ALTER TABLE GR18_JuezCompetencia ADD CONSTRAINT FK_GR18_JuezCompetencia_Competencia
    FOREIGN KEY (idCompetencia)
    REFERENCES GR18_Competencia (idCompetencia)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_GR18_JuezCompetencia_Juez (table: GR18_JuezCompetencia)
ALTER TABLE GR18_JuezCompetencia ADD CONSTRAINT FK_GR18_JuezCompetencia_Juez
    FOREIGN KEY (tipoDoc, nroDoc)
    REFERENCES GR18_Juez (tipoDoc, nroDoc)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_GR18_Juez_Persona (table: GR18_Juez)
ALTER TABLE GR18_Juez ADD CONSTRAINT FK_GR18_Juez_Persona
    FOREIGN KEY (tipoDoc, nroDoc)
    REFERENCES GR18_Persona (tipoDoc, nroDoc)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_GR18_categoria_disciplina (table: GR18_Categoria)
ALTER TABLE GR18_Categoria ADD CONSTRAINT FK_GR18_categoria_disciplina
    FOREIGN KEY (cdoDisciplina)
    REFERENCES GR18_Disciplina (cdoDisciplina)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;



------ inserts
--
--
--
--
-- Data for Name: gr18_disciplina; Type: TABLE DATA; Schema: unc_246449; Owner: unc_246449
--

INSERT INTO gr18_disciplina VALUES ('FUT', 'Fulbol 11', 'Fultbol 11');
INSERT INTO gr18_disciplina VALUES ('Tenis', 'Tenis Men', 'Tenis singler men');
INSERT INTO gr18_disciplina VALUES ('Pad', 'Paddel', 'Padel por equipo');
INSERT INTO gr18_disciplina VALUES ('FUT2', 'Futbol', 'Futbol 11');
INSERT INTO gr18_disciplina VALUES ('FUT1', 'Futbol', 'Futbol 5');
INSERT INTO gr18_disciplina VALUES ('TEN1', 'Tenis', 'Tenis single');
INSERT INTO gr18_disciplina VALUES ('TEN2', 'Tenis', 'Tenis dobles');


--
-- Data for Name: gr18_categoria; Type: TABLE DATA; Schema: unc_246449; Owner: unc_246449
--

INSERT INTO gr18_categoria VALUES ('Seniorf', 'FUT', 'Senior-futbol', 21, 31);
INSERT INTO gr18_categoria VALUES ('Juvenilt', 'Tenis', 'Juvenil-Tenis', 10, 20);
INSERT INTO gr18_categoria VALUES ('Seniort', 'Tenis', 'Senior-Tenis
', 21, 31);
INSERT INTO gr18_categoria VALUES ('juvenilf', 'FUT', 'Juvenil-Futbol', 10, 20);
INSERT INTO gr18_categoria VALUES ('SeniorF', 'FUT1', 'Senior-futbol', 21, 31);
INSERT INTO gr18_categoria VALUES ('JuvenilT', 'TEN1', 'Juvenil-Tenis', 10, 20);
INSERT INTO gr18_categoria VALUES ('SeniorT', 'TEN2', 'Senior-Tenis', 21, 31);
INSERT INTO gr18_categoria VALUES ('JuvenilF', 'FUT1', 'Juvenil-Futbol', 10, 20);


--
-- Data for Name: gr18_competencia; Type: TABLE DATA; Schema: unc_246449; Owner: unc_246449
--

INSERT INTO gr18_competencia VALUES (11, 'FUT','Futbol', '2017-06-09 00:00:00', 'Futbol', 'Fl', 'bol', B'1', '2017-06-09 00:00:00', 3,'1', 'e3e3', '3e3e');
INSERT INTO gr18_competencia VALUES (12, 'Tenis', 'tenes de noche', '2017-06-15 00:00:00', 'uncas', 'tandil', 'edu', B'1', '2017-06-16 00:00:00', 2,'1', '', '');
INSERT INTO gr18_competencia VALUES (1, 'FUT2', 'Futbol nocturno', '2017-06-09 00:00:00', 'campus', 'tandil', 'unicen', B'0', '2017-06-15 00:00:00', 3,'0', NULL, NULL);
INSERT INTO gr18_competencia VALUES (13, 'TEN2', 'tenes de dia', '2017-06-15 00:00:00', 'uncas', 'tandil', 'edu', B'1', '2017-06-16 00:00:00', 2,'1', '', '');
INSERT INTO gr18_competencia VALUES (14, 'TEN1', 'tenes de tarde', '2017-06-15 00:00:00', 'uncas', 'tandil', 'edu', B'1', '2017-06-16 00:00:00', 2,'1', '', '');




--
-- Data for Name: gr18_federacion; Type: TABLE DATA; Schema: unc_246449; Owner: unc_246449
--

INSERT INTO gr18_federacion VALUES ('PSTA', 'FUT', 'PASTA - futbol', 2010, 100);
INSERT INTO gr18_federacion VALUES ('SASTA', 'FUT', 'socias ... Futbol
', 2013, 120);
INSERT INTO gr18_federacion VALUES ('TEn', 'Tenis', 'FETENis', 2014, 300);
INSERT INTO gr18_federacion VALUES ('FEDFUT1', 'FUT1', 'Federacion de futbol 1', 2010, 200);
INSERT INTO gr18_federacion VALUES ('FEDFUT2', 'FUT1', 'Federacion de futbol 2', 2000, 120);
INSERT INTO gr18_federacion VALUES ('FEDFUT3', 'FUT2', 'Federacion de futbol 3', 2010, 10);
INSERT INTO gr18_federacion VALUES ('FEDFUT4', 'FUT2', 'Federacion de futbol 4', 2010, 230);
INSERT INTO gr18_federacion VALUES ('FEDTEN1', 'TEN1', 'Federacion de tenis 1', 2010, 200);
INSERT INTO gr18_federacion VALUES ('FEDTEN2', 'TEN1', 'Federacion de tenis 2', 2000, 120);
INSERT INTO gr18_federacion VALUES ('FEDTEN3', 'TEN2', 'Federacion de tenis 1', 2010, 200);
INSERT INTO gr18_federacion VALUES ('FEDTEN4', 'TEN2', 'Federacion de tenis 3', 2010, 10);


--
-- Data for Name: gr18_persona; Type: TABLE DATA; Schema: unc_246449; Owner: unc_246449
--

INSERT INTO gr18_persona VALUES ('dni', 20, 'sss', 'ssss', 'ss', 'sss', 'sss', 'f', 'ss', '1', '2001-01-01 00:00:00');
INSERT INTO gr18_persona VALUES ('dni', 3029291, 'marcelo', 'prado', '', '', '', 'm', '', '1', '1980-05-09 00:00:00');
INSERT INTO gr18_persona VALUES ('dni', 29587447, 'Eduardo', 'bravo', '', '', '', 'M', '', 'q', '1982-02-09 00:00:00');
INSERT INTO gr18_persona VALUES ('dni', 34587447, 'Pedro', 'bravo', '', '', '', 'M', '', 'q', '1998-04-11 00:00:00');
INSERT INTO gr18_persona VALUES ('dni', 43587447, 'Simon', 'bravo', '', '', '', 'M', '', 'q', '1999-03-01 00:00:00');


--
-- Data for Name: gr18_deportista; Type: TABLE DATA; Schema: unc_246449; Owner: unc_246449
--

INSERT INTO gr18_deportista VALUES ('dni', 20, B'1', '2017-06-22 00:00:00', '222', 'Seniorf', 'FUT', 'PSTA', 'FUT');
INSERT INTO gr18_deportista VALUES ('dni', 29587447, B'1', '2017-06-02 00:00:00', '111111', 'Seniorf', 'FUT', 'PSTA', 'FUT');
INSERT INTO gr18_deportista VALUES ('dni', 3029291, B'0', NULL, NULL, 'juvenilf', 'FUT', 'SASTA', 'FUT');
INSERT INTO gr18_deportista VALUES ('dni', 43587447, B'0', NULL, NULL, 'juvenilf', 'FUT', 'SASTA', 'FUT');
INSERT INTO gr18_deportista VALUES ('dni', 34587447, B'0', NULL, NULL, 'juvenilf', 'FUT', 'SASTA', 'FUT');


--
-- Data for Name: gr18_clasificacioncompetencia; Type: TABLE DATA; Schema: unc_246449; Owner: unc_246449
--



--
-- Data for Name: gr18_equipo; Type: TABLE DATA; Schema: unc_246449; Owner: unc_246449
--

INSERT INTO gr18_equipo VALUES (2, 'TenisMar', '2011-02-21 00:00:00');
INSERT INTO gr18_equipo VALUES (1, 'Futmagic', '2001-01-01 00:00:00');
INSERT INTO gr18_equipo VALUES (3, 'losfunda', '2001-01-01 00:00:00');
INSERT INTO gr18_equipo VALUES (4, 'heroes', '2001-01-01 00:00:00');
INSERT INTO gr18_equipo VALUES (5, 'distint', '2001-01-01 00:00:00');


--
-- Data for Name: gr18_equipodeportista; Type: TABLE DATA; Schema: unc_246449; Owner: unc_246449
--

INSERT INTO gr18_equipodeportista VALUES (1, 'dni', 29587447);
INSERT INTO gr18_equipodeportista VALUES (1, 'dni', 20);


--
-- Data for Name: gr18_inscripcion; Type: TABLE DATA; Schema: unc_246449; Owner: unc_246449
--

INSERT INTO gr18_inscripcion VALUES (12, 'dni', 20, 1, 12, '2017-06-09 00:00:00');
INSERT INTO gr18_inscripcion VALUES (11, 'dni', 29587447, 1, 12, '2017-06-15 00:00:00');


--
-- Data for Name: gr18_juez; Type: TABLE DATA; Schema: unc_246449; Owner: unc_246449
--

INSERT INTO gr18_juez VALUES ('dni', 34587447, B'0', NULL);
INSERT INTO gr18_juez VALUES ('dni', 43587447, B'1', '234424');


--
-- Data for Name: gr18_juezcompetencia; Type: TABLE DATA; Schema: unc_246449; Owner: unc_246449
--

INSERT INTO gr18_juezcompetencia VALUES (1, 'dni', 43587447);
INSERT INTO gr18_juezcompetencia VALUES (1, 'dni', 34587447);


--
-- PostgreSQL database dump complete
--


 
 
 

