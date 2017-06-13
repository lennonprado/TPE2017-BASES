-- TUDAI 2017
-- TRABAJO PRACTICO ESPECIAL
-- BASES DE DATOS
-- Eduardo Bravo y Marcelo Prado



-- table: GR19_Categoria
CREATE TABLE GR19_Categoria (
    cdoCategoria varchar(20)  NOT NULL,
    cdoDisciplina varchar(10)  NOT NULL,
    descripcion varchar(200)  NOT NULL,
    edadMinima int  NOT NULL,
    edadMaxima int  NOT NULL,
    CONSTRAINT PK_GR19_categoria PRIMARY KEY (cdoCategoria,cdoDisciplina)
);

-- table: GR19_ClasificacionCompetencia
CREATE TABLE GR19_ClasificacionCompetencia (
    idCompetencia int  NOT NULL,
    tipoDoc varchar(3)  NOT NULL,
    nroDoc int  NOT NULL,
    puestoGeneral varchar(50)  NOT NULL,
    puntosGeneral int  NOT NULL,
    puestoCategoria varchar(50)  NOT NULL,
    puntosCategoria int  NOT NULL,
    CONSTRAINT PK_GR19_ClasificacionCompetencia PRIMARY KEY (idCompetencia,tipoDoc,nroDoc)
);

-- table: GR19_Competencia
CREATE TABLE GR19_Competencia (
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
    CONSTRAINT PK_GR19_competencia PRIMARY KEY (idCompetencia)
);

-- table: GR19_Deportista
CREATE TABLE GR19_Deportista (
    tipoDoc varchar(3)  NOT NULL,
    nroDoc int  NOT NULL,
    federado bit(1)  NOT NULL,
    fechaUltimaFederacion timestamp  NULL,
    nroLicencia varchar(20)  NULL,
    cdoCategoria varchar(20)  NOT NULL,
    cdoDisciplina varchar(10)  NOT NULL,
    cdoFederacion varchar(50)  NULL,
    cdoDisciplinaFederacion varchar(10)  NULL,
    CONSTRAINT PK_GR19_Deportista PRIMARY KEY (tipoDoc,nroDoc)
);

-- table: GR19_Disciplina
CREATE TABLE GR19_Disciplina (
    cdoDisciplina varchar(10)  NOT NULL,
    nombre varchar(100)  NOT NULL,
    descripcion text  NOT NULL,
    CONSTRAINT PK_GR19_Disciplina PRIMARY KEY (cdoDisciplina)
);

-- table: GR19_Equipo
CREATE TABLE GR19_Equipo (
    id int  NOT NULL,
    nombre varchar(100)  NOT NULL,
    fechaAlta timestamp  NOT NULL,
    CONSTRAINT PK_GR19_Equipo PRIMARY KEY (id)
);

-- table: GR19_EquipoDeportista
CREATE TABLE GR19_EquipoDeportista (
    id int  NOT NULL,
    tipoDoc varchar(3)  NOT NULL,
    nroDoc int  NOT NULL,
    CONSTRAINT PK_GR19_EquipoDeportista PRIMARY KEY (id,tipoDoc,nroDoc)
);

-- table: GR19_Federacion
CREATE TABLE GR19_Federacion (
    cdoFederacion varchar(50)  NOT NULL,
    cdoDisciplina varchar(10)  NOT NULL,
    nombre varchar(100)  NOT NULL,
    anioCreacion int  NULL,
    cantAfiliados int  NULL,
    CONSTRAINT PK_GR19_Federacion PRIMARY KEY (cdoFederacion,cdoDisciplina)
);

-- table: GR19_Inscripcion
CREATE TABLE GR19_Inscripcion (
    id int  NOT NULL,
    tipoDoc varchar(3)  NULL,
    nroDoc int  NULL,
    Equipo_id int  NULL,
    idCompetencia int  NOT NULL,
    fecha timestamp  NULL,
    CONSTRAINT PK_GR19_Inscripcion PRIMARY KEY (id)
);

-- table: GR19_Juez
CREATE TABLE GR19_Juez (
    tipoDoc varchar(3)  NOT NULL,
    nroDoc int  NOT NULL,
    oficial bit(1)  NOT NULL,
    nroLicencia varchar(20)  NULL,
    CONSTRAINT PK_GR19_Juez PRIMARY KEY (tipoDoc,nroDoc)
);

-- table: GR19_JuezCompetencia
CREATE TABLE GR19_JuezCompetencia (
    idCompetencia int  NOT NULL,
    tipoDoc varchar(3)  NOT NULL,
    nroDoc int  NOT NULL,
    CONSTRAINT PK_GR19_JuezCompetencia PRIMARY KEY (idCompetencia,tipoDoc,nroDoc)
);

-- table: GR19_Persona
CREATE TABLE GR19_Persona (
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
    CONSTRAINT PK_GR19_Persona PRIMARY KEY (tipoDoc,nroDoc)
);

-- foreign keys
-- Reference: FK_GR19_ClasificacionCompetencia_Competencia (table: GR19_ClasificacionCompetencia)
ALTER TABLE GR19_ClasificacionCompetencia ADD CONSTRAINT FK_GR19_ClasificacionCompetencia_Competencia
    FOREIGN KEY (idCompetencia)
    REFERENCES GR19_Competencia (idCompetencia)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: FK_GR19_ClasificacionCompetencia_Deportista (table: GR19_ClasificacionCompetencia)
ALTER TABLE GR19_ClasificacionCompetencia ADD CONSTRAINT FK_GR19_ClasificacionCompetencia_Deportista
    FOREIGN KEY (tipoDoc, nroDoc)
    REFERENCES GR19_Deportista (tipoDoc, nroDoc)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: FK_GR19_Competencia_Disciplina (table: GR19_Competencia)
ALTER TABLE GR19_Competencia ADD CONSTRAINT FK_GR19_Competencia_Disciplina
    FOREIGN KEY (cdoDisciplina)
    REFERENCES GR19_Disciplina (cdoDisciplina)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: FK_GR19_Deportista_Categoria (table: GR19_Deportista)
ALTER TABLE GR19_Deportista ADD CONSTRAINT FK_GR19_Deportista_Categoria
    FOREIGN KEY (cdoCategoria, cdoDisciplina)
    REFERENCES GR19_Categoria (cdoCategoria, cdoDisciplina)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: FK_GR19_Deportista_Federacion (table: GR19_Deportista)
ALTER TABLE GR19_Deportista ADD CONSTRAINT FK_GR19_Deportista_Federacion
    FOREIGN KEY (cdoFederacion, cdoDisciplinaFederacion)
    REFERENCES GR19_Federacion (cdoFederacion, cdoDisciplina)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: FK_GR19_Deportista_Persona (table: GR19_Deportista)
ALTER TABLE GR19_Deportista ADD CONSTRAINT FK_GR19_Deportista_Persona
    FOREIGN KEY (tipoDoc, nroDoc)
    REFERENCES GR19_Persona (tipoDoc, nroDoc)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: FK_GR19_EquipoDeportista_Deportista (table: GR19_EquipoDeportista)
ALTER TABLE GR19_EquipoDeportista ADD CONSTRAINT FK_GR19_EquipoDeportista_Deportista
    FOREIGN KEY (tipoDoc, nroDoc)
    REFERENCES GR19_Deportista (tipoDoc, nroDoc)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: FK_GR19_EquipoDeportista_Equipo (table: GR19_EquipoDeportista)
ALTER TABLE GR19_EquipoDeportista ADD CONSTRAINT FK_GR19_EquipoDeportista_Equipo
    FOREIGN KEY (id)
    REFERENCES GR19_Equipo (id)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: FK_GR19_Federacion_Disciplina (table: GR19_Federacion)
ALTER TABLE GR19_Federacion ADD CONSTRAINT FK_GR19_Federacion_Disciplina
    FOREIGN KEY (cdoDisciplina)
    REFERENCES GR19_Disciplina (cdoDisciplina)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: FK_GR19_Inscripcion_Competencia (table: GR19_Inscripcion)
ALTER TABLE GR19_Inscripcion ADD CONSTRAINT FK_GR19_Inscripcion_Competencia
    FOREIGN KEY (idCompetencia)
    REFERENCES GR19_Competencia (idCompetencia)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: FK_GR19_Inscripcion_Deportista (table: GR19_Inscripcion)
ALTER TABLE GR19_Inscripcion ADD CONSTRAINT FK_GR19_Inscripcion_Deportista
    FOREIGN KEY (tipoDoc, nroDoc)
    REFERENCES GR19_Deportista (tipoDoc, nroDoc)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: FK_GR19_Inscripcion_Equipo (table: GR19_Inscripcion)
ALTER TABLE GR19_Inscripcion ADD CONSTRAINT FK_GR19_Inscripcion_Equipo
    FOREIGN KEY (Equipo_id)
    REFERENCES GR19_Equipo (id)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: FK_GR19_JuezCompetencia_Competencia (table: GR19_JuezCompetencia)
ALTER TABLE GR19_JuezCompetencia ADD CONSTRAINT FK_GR19_JuezCompetencia_Competencia
    FOREIGN KEY (idCompetencia)
    REFERENCES GR19_Competencia (idCompetencia)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: FK_GR19_JuezCompetencia_Juez (table: GR19_JuezCompetencia)
ALTER TABLE GR19_JuezCompetencia ADD CONSTRAINT FK_GR19_JuezCompetencia_Juez
    FOREIGN KEY (tipoDoc, nroDoc)
    REFERENCES GR19_Juez (tipoDoc, nroDoc)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: FK_GR19_Juez_Persona (table: GR19_Juez)
ALTER TABLE GR19_Juez ADD CONSTRAINT FK_GR19_Juez_Persona
    FOREIGN KEY (tipoDoc, nroDoc)
    REFERENCES GR19_Persona (tipoDoc, nroDoc)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: FK_GR19_categoria_disciplina (table: GR19_Categoria)
ALTER TABLE GR19_Categoria ADD CONSTRAINT FK_GR19_categoria_disciplina
    FOREIGN KEY (cdoDisciplina)
    REFERENCES GR19_Disciplina (cdoDisciplina)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;



------ inserts
--
--
--
--
-- Data for Name: GR19_disciplina; Type: TABLE DATA; Schema: unc_246449; Owner: unc_246449
--

INSERT INTO GR19_disciplina VALUES ('FUT', 'Fulbol 11', 'Fultbol 11');
INSERT INTO GR19_disciplina VALUES ('Tenis', 'Tenis Men', 'Tenis singler men');
INSERT INTO GR19_disciplina VALUES ('Pad', 'Paddel', 'Padel por equipo');
INSERT INTO GR19_disciplina VALUES ('FUT2', 'Futbol', 'Futbol 11');
INSERT INTO GR19_disciplina VALUES ('FUT1', 'Futbol', 'Futbol 5');
INSERT INTO GR19_disciplina VALUES ('TEN1', 'Tenis', 'Tenis single');
INSERT INTO GR19_disciplina VALUES ('TEN2', 'Tenis', 'Tenis dobles');


--
-- Data for Name: GR19_categoria; Type: TABLE DATA; Schema: unc_246449; Owner: unc_246449
--

INSERT INTO GR19_categoria VALUES ('Seniorf', 'FUT', 'Senior-futbol', 21, 31);
INSERT INTO GR19_categoria VALUES ('Juvenilt', 'Tenis', 'Juvenil-Tenis', 10, 20);
INSERT INTO GR19_categoria VALUES ('Seniort', 'Tenis', 'Senior-Tenis
', 21, 31);
INSERT INTO GR19_categoria VALUES ('juvenilf', 'FUT', 'Juvenil-Futbol', 10, 20);
INSERT INTO GR19_categoria VALUES ('SeniorF', 'FUT1', 'Senior-futbol', 21, 31);
INSERT INTO GR19_categoria VALUES ('JuvenilT', 'TEN1', 'Juvenil-Tenis', 10, 20);
INSERT INTO GR19_categoria VALUES ('SeniorT', 'TEN2', 'Senior-Tenis', 21, 31);
INSERT INTO GR19_categoria VALUES ('JuvenilF', 'FUT1', 'Juvenil-Futbol', 10, 20);


--
-- Data for Name: GR19_competencia; Type: TABLE DATA; Schema: unc_246449; Owner: unc_246449
--

INSERT INTO GR19_competencia VALUES (11, 'FUT','Futbol', '2017-06-09 00:00:00', 'Futbol', 'Fl', 'bol', B'1', '2017-06-09 00:00:00', 3,'1', 'e3e3', '3e3e');
INSERT INTO GR19_competencia VALUES (12, 'Tenis', 'tenes de noche', '2017-06-15 00:00:00', 'uncas', 'tandil', 'edu', B'1', '2017-06-16 00:00:00', 2,'1', '', '');
INSERT INTO GR19_competencia VALUES (1, 'FUT2', 'Futbol nocturno', '2017-06-09 00:00:00', 'campus', 'tandil', 'unicen', B'0', '2017-06-15 00:00:00', 3,'0', NULL, NULL);
INSERT INTO GR19_competencia VALUES (13, 'TEN2', 'tenes de dia', '2017-06-15 00:00:00', 'uncas', 'tandil', 'edu', B'1', '2017-06-16 00:00:00', 2,'1', '', '');
INSERT INTO GR19_competencia VALUES (14, 'TEN1', 'tenes de tarde', '2017-06-15 00:00:00', 'uncas', 'tandil', 'edu', B'1', '2017-06-16 00:00:00', 2,'1', '', '');




--
-- Data for Name: GR19_federacion; Type: TABLE DATA; Schema: unc_246449; Owner: unc_246449
--

INSERT INTO GR19_federacion VALUES ('PSTA', 'FUT', 'PASTA - futbol', 2010, 100);
INSERT INTO GR19_federacion VALUES ('SASTA', 'FUT', 'socias ... Futbol
', 2013, 120);
INSERT INTO GR19_federacion VALUES ('TEn', 'Tenis', 'FETENis', 2014, 300);
INSERT INTO GR19_federacion VALUES ('FEDFUT1', 'FUT1', 'Federacion de futbol 1', 2010, 200);
INSERT INTO GR19_federacion VALUES ('FEDFUT2', 'FUT1', 'Federacion de futbol 2', 2000, 120);
INSERT INTO GR19_federacion VALUES ('FEDFUT3', 'FUT2', 'Federacion de futbol 3', 2010, 10);
INSERT INTO GR19_federacion VALUES ('FEDFUT4', 'FUT2', 'Federacion de futbol 4', 2010, 230);
INSERT INTO GR19_federacion VALUES ('FEDTEN1', 'TEN1', 'Federacion de tenis 1', 2010, 200);
INSERT INTO GR19_federacion VALUES ('FEDTEN2', 'TEN1', 'Federacion de tenis 2', 2000, 120);
INSERT INTO GR19_federacion VALUES ('FEDTEN3', 'TEN2', 'Federacion de tenis 1', 2010, 200);
INSERT INTO GR19_federacion VALUES ('FEDTEN4', 'TEN2', 'Federacion de tenis 3', 2010, 10);


--
-- Data for Name: GR19_persona; Type: TABLE DATA; Schema: unc_246449; Owner: unc_246449
--

INSERT INTO GR19_persona VALUES ('dni', 20, 'sss', 'ssss', 'ss', 'sss', 'sss', 'f', 'ss', '1', '2001-01-01 00:00:00');
INSERT INTO GR19_persona VALUES ('dni', 3029291, 'marcelo', 'prado', '', '', '', 'm', '', '1', '1980-05-09 00:00:00');
INSERT INTO GR19_persona VALUES ('dni', 29587447, 'Eduardo', 'bravo', '', '', '', 'M', '', 'q', '1982-02-09 00:00:00');
INSERT INTO GR19_persona VALUES ('dni', 34587447, 'Pedro', 'bravo', '', '', '', 'M', '', 'q', '1998-04-11 00:00:00');
INSERT INTO GR19_persona VALUES ('dni', 43587447, 'Simon', 'bravo', '', '', '', 'M', '', 'q', '1999-03-01 00:00:00');


--
-- Data for Name: GR19_deportista; Type: TABLE DATA; Schema: unc_246449; Owner: unc_246449
--

INSERT INTO GR19_deportista VALUES ('dni', 20, B'1', '2017-06-22 00:00:00', '222', 'Seniorf', 'FUT', 'PSTA', 'FUT');
INSERT INTO GR19_deportista VALUES ('dni', 29587447, B'1', '2017-06-02 00:00:00', '111111', 'Seniorf', 'FUT', 'PSTA', 'FUT');
INSERT INTO GR19_deportista VALUES ('dni', 3029291, B'0', NULL, NULL, 'juvenilf', 'FUT', 'SASTA', 'FUT');
INSERT INTO GR19_deportista VALUES ('dni', 43587447, B'0', NULL, NULL, 'juvenilf', 'FUT', 'SASTA', 'FUT');
INSERT INTO GR19_deportista VALUES ('dni', 34587447, B'0', NULL, NULL, 'juvenilf', 'FUT', 'SASTA', 'FUT');


--
-- Data for Name: GR19_clasificacioncompetencia; Type: TABLE DATA; Schema: unc_246449; Owner: unc_246449
--



--
-- Data for Name: GR19_equipo; Type: TABLE DATA; Schema: unc_246449; Owner: unc_246449
--

INSERT INTO GR19_equipo VALUES (2, 'TenisMar', '2011-02-21 00:00:00');
INSERT INTO GR19_equipo VALUES (1, 'Futmagic', '2001-01-01 00:00:00');
INSERT INTO GR19_equipo VALUES (3, 'losfunda', '2001-01-01 00:00:00');
INSERT INTO GR19_equipo VALUES (4, 'heroes', '2001-01-01 00:00:00');
INSERT INTO GR19_equipo VALUES (5, 'distint', '2001-01-01 00:00:00');


--
-- Data for Name: GR19_equipodeportista; Type: TABLE DATA; Schema: unc_246449; Owner: unc_246449
--

INSERT INTO GR19_equipodeportista VALUES (1, 'dni', 29587447);
INSERT INTO GR19_equipodeportista VALUES (1, 'dni', 20);


--
-- Data for Name: GR19_inscripcion; Type: TABLE DATA; Schema: unc_246449; Owner: unc_246449
--

INSERT INTO GR19_inscripcion VALUES (11, 'dni', 20, NULL, 12, '2017-06-09 00:00:00');
INSERT INTO GR19_inscripcion VALUES (12, 'dni', 29587447, NULL, 12, '2017-06-15 00:00:00');
INSERT INTO GR19_inscripcion VALUES (13, NULL, NULL, 1, 12, '2017-06-09 00:00:00');

--
-- Data for Name: GR19_juez; Type: TABLE DATA; Schema: unc_246449; Owner: unc_246449
--

INSERT INTO GR19_juez VALUES ('dni', 34587447, B'0', NULL);
INSERT INTO GR19_juez VALUES ('dni', 43587447, B'1', '234424');


--
-- Data for Name: GR19_juezcompetencia; Type: TABLE DATA; Schema: unc_246449; Owner: unc_246449
--

INSERT INTO GR19_juezcompetencia VALUES (1, 'dni', 43587447);
INSERT INTO GR19_juezcompetencia VALUES (1, 'dni', 34587447);


--
-- PostgreSQL database dump complete
--
