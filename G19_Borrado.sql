DROP VIEW GR19_puntosDeportistas;

DROP VIEW GR19_deportistassinclasificar;

DROP VIEW GR19_competenciasordenadas;

DROP FUNCTION IF EXISTS GR19_jueces;

DROP FUNCTION IF EXISTS GR19_clasificacion;

DROP FUNCTION IF EXISTS GR19_equipos;

DROP FUNCTION IF EXISTS GR19_lista_deportista;

DROP TRIGGER IF EXISTS TR_GR19_ClasificacionCompetencia_mismos ON GR19_ClasificacionCompetencia;

DROP TRIGGER IF EXISTS TR_GR19_Inscripcion_Individuales ON GR19_Inscripcion;

DROP TRIGGER IF EXISTS TR_GR19_juezcompetencia_Juezdeportista ON GR19_juezcompetencia;

DROP TRIGGER IF EXISTS TR_GR19_equipodeportista_Juezdeportista ON GR19_equipodeportista;

DROP TRIGGER IF EXISTS TR_GR19_Inscripcion_Juezdeportista ON GR19_Inscripcion;

DROP FUNCTION IF EXISTS TRFN_GR19_Multiplestablas_Juezdeportista;

ALTER TABLE "GR19_Inscripcion"
DROP CONSTRAINT "GR19_ck_2";

ALTER TABLE "GR19_Inscripcion"
DROP CONSTRAINT "GR19_ck_1";

DROP TRIGGER IF EXISTS TR_GR19_Inscripcion_FechaLimite ON GR19_Inscripcion;

DROP FUNCTION IF EXISTS TRFN_GR19_Inscripcion_FechaLimite;

DROP TRIGGER TR_GR19_Equipo_Masdetres ON GR19_Equipo;

DROP FUNCTION IF EXISTS TRFN_GR19_Equipo_Masdetres;

ALTER TABLE "GR19_Competencia"
DROP CONSTRAINT "GR19_ck_1";

ALTER TABLE "GR19_Categoria"
DROP CONSTRAINT "FK_GR19_categoria_disciplina";

ALTER TABLE "GR19_Juez"
DROP CONSTRAINT "FK_GR19_Juez_Persona";


ALTER TABLE "GR19_JuezCompetencia"
DROP CONSTRAINT "FK_GR19_JuezCompetencia_Juez";

ALTER TABLE "GR19_JuezCompetencia"
DROP CONSTRAINT "FK_GR19_JuezCompetencia_Competencia";

ALTER TABLE "GR19_Inscripcion"
DROP CONSTRAINT "FK_GR19_Inscripcion_Equipo";

ALTER TABLE "GR19_Inscripcion"
DROP CONSTRAINT "FK_GR19_Inscripcion_Deportista";

ALTER TABLE "GR19_Inscripcion"
DROP CONSTRAINT "FK_GR19_Inscripcion_Competencia";


ALTER TABLE "GR19_Federacion"
DROP CONSTRAINT "FK_GR19_Federacion_Disciplina";


ALTER TABLE "GR19_EquipoDeportista"
DROP CONSTRAINT "FK_GR19_EquipoDeportista_Equipo";
ALTER TABLE "GR19_EquipoDeportista"
DROP CONSTRAINT "FK_GR19_EquipoDeportista_Deportista";
ALTER TABLE "GR19_Deportista"
DROP CONSTRAINT "FK_GR19_Deportista_Persona";
ALTER TABLE "GR19_Deportista"
DROP CONSTRAINT "FK_GR19_Deportista_Federacion";
ALTER TABLE "GR19_Deportista"
DROP CONSTRAINT "FK_GR19_Deportista_Categoria";
ALTER TABLE "GR19_Competencia"
DROP CONSTRAINT "FK_GR19_Competencia_Disciplina";
ALTER TABLE "GR19_ClasificacionCompetencia"
DROP CONSTRAINT "FK_GR19_ClasificacionCompetencia_Deportista";
ALTER TABLE "GR19_ClasificacionCompetencia"
DROP CONSTRAINT "FK_GR19_ClasificacionCompetencia_Competencia";


DROP TABLE GR19_Persona;
DROP TABLE GR19_JuezCompetencia;
DROP TABLE GR19_Juez;
DROP TABLE GR19_Inscripcion;
DROP TABLE GR19_Federacion;
DROP TABLE GR19_EquipoDeportista;
DROP TABLE GR19_Equipo;
DROP TABLE GR19_Disciplina;
DROP TABLE GR19_Deportista;
DROP TABLE GR19_Competencia;
DROP TABLE GR19_ClasificacionCompetencia;
DROP TABLE GR19_Categoria;


