DROP VIEW GR19_puntosDeportistas;

DROP VIEW GR19_deportistassinclasificar;

DROP VIEW GR19_competenciasordenadas;

DROP FUNCTION IF EXISTS GR19_jueces();

DROP FUNCTION IF EXISTS GR19_clasificacion();

DROP FUNCTION IF EXISTS GR19_equipos();

DROP FUNCTION IF EXISTS GR19_lista_deportista();

DROP TRIGGER IF EXISTS TR_GR19_ClasificacionCompetencia_mismos ON GR19_ClasificacionCompetencia;

DROP TRIGGER IF EXISTS TR_GR19_Inscripcion_Individuales ON GR19_Inscripcion;

DROP TRIGGER IF EXISTS TR_GR19_juezcompetencia_Juezdeportista ON GR19_juezcompetencia;

DROP TRIGGER IF EXISTS TR_GR19_equipodeportista_Juezdeportista ON GR19_equipodeportista;

DROP TRIGGER IF EXISTS TR_GR19_Inscripcion_Juezdeportista ON GR19_Inscripcion;

DROP FUNCTION IF EXISTS TRFN_GR19_Multiplestablas_Juezdeportista();

ALTER TABLE GR19_Inscripcion DROP CONSTRAINT "gr19_ck_2";

DROP TRIGGER IF EXISTS TR_GR19_Inscripcion_FechaLimite ON GR19_Inscripcion;

DROP FUNCTION IF EXISTS TRFN_GR19_Inscripcion_FechaLimite();

DROP TRIGGER TR_GR19_Equipo_Masdetres ON GR19_Equipo;

DROP FUNCTION IF EXISTS TRFN_GR19_Equipo_Masdetres();

ALTER TABLE GR19_Competencia DROP CONSTRAINT "gr19_ck_1";

ALTER TABLE GR19_Categoria DROP CONSTRAINT "fk_gr19_categoria_disciplina";

ALTER TABLE GR19_Juez DROP CONSTRAINT "fk_gr19_juez_persona";

ALTER TABLE GR19_JuezCompetencia DROP CONSTRAINT "fk_gr19_juezcompetencia_juez";

ALTER TABLE GR19_JuezCompetencia DROP CONSTRAINT "fk_gr19_juezcompetencia_competencia";

ALTER TABLE GR19_Inscripcion DROP CONSTRAINT "fk_gr19_inscripcion_equipo";

ALTER TABLE GR19_Inscripcion DROP CONSTRAINT "fk_gr19_inscripcion_deportista";

ALTER TABLE GR19_Inscripcion DROP CONSTRAINT "fk_gr19_inscripcion_competencia";

ALTER TABLE GR19_Federacion DROP CONSTRAINT "fk_gr19_federacion_disciplina";

ALTER TABLE GR19_EquipoDeportista DROP CONSTRAINT "fk_gr19_equipodeportista_equipo";

ALTER TABLE GR19_EquipoDeportista DROP CONSTRAINT "fk_gr19_equipodeportista_deportista";

ALTER TABLE GR19_Deportista DROP CONSTRAINT "fk_gr19_deportista_persona";
ALTER TABLE GR19_Deportista DROP CONSTRAINT "fk_gr19_deportista_federacion";
ALTER TABLE GR19_Deportista DROP CONSTRAINT "fk_gr19_deportista_categoria";
ALTER TABLE GR19_Competencia DROP CONSTRAINT "fk_gr19_competencia_disciplina";
ALTER TABLE GR19_ClasificacionCompetencia DROP CONSTRAINT "fk_gr19_clasificacioncompetencia_deportista";
ALTER TABLE GR19_ClasificacionCompetencia DROP CONSTRAINT "fk_gr19_clasificacioncompetencia_competencia";


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
