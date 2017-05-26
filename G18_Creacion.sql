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

-- End of file.

