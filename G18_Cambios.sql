-- TUDAI 2017
-- TRABAJO PRACTICO ESPECIAL 
-- BASES DE DATOS 
-- Eduardo Bravo y Marcelo Prado
-- G18_Cambios.sql


-- a. Debe haber al menos un juez para cada competencia.

--    trigger que haga:
--    a la hora de empezar la competencia deberia tener un juez

-- Restriccion en tabla nueva a crear
    

ALTER TABLE GR18_Competencia 
ADD CONSTRAINT gr18_ck_1 CHECK ( cantJueces > 0 ); 


-- b. Un deportista no puede formar parte de más de tres equipos en un mismo año.
-- Restriccion en tabla GR18_Inscripcion

/*

-- va al informe

CREATE ASSERSTION gr18_ck_2
CHECK NOT EXISTS ( 
        SELECT E.nrodoc, count(E.id), EXTRACT (YEAR from I.fechaalta) as anio
        FROM GR18_Equipo I
        JOIN GR18_EquipoDeportista E
        ON (I.id = E.id)
        WHERE I.id IS NOT NULL
        GROUP BY E.nrodoc, anio
        HAVING count(E.id) > 3
);
*/

-- TRIGGER
CREATE OR REPLACE FUNCTION TRFN_GR18_Equipo_Masdetres() 
RETURNS trigger AS $$
DECLARE cantidad integer;    
BEGIN    
    SELECT E.nrodoc, INTO cantidad count(E.id), EXTRACT (YEAR from I.fechaalta) as anio
    FROM GR18_Equipo I
    JOIN GR18_EquipoDeportista E
    ON (I.id = E.id)
    WHERE I.id IS NOT NULL
    GROUP BY E.nrodoc, anio
    HAVING count(E.id) > 3;
    IF (cantidad > 3) THEN
        RAISE EXCEPTION 'Un deportista no puede formar parte de más de tres equipos en un mismo año.';
    END IF;    
    RETURN NEW;
END; $$
LANGUAGE 'plpgsql';

DROP TRIGGER TR_GR18_Equipo_Masdetres ON GR18_Equipo;
CREATE TRIGGER TR_GR18_Equipo_Masdetres
AFTER INSERT ON GR18_Equipo
FOR EACH STATEMENT EXECUTE PROCEDURE TRFN_GR18_Equipo_Masdetres();



-- c. Las inscripciones no se pueden realizar luego de la fecha límite de inscripción.
-- Restriccion en tabla GR18_Inscripcion
    

/*

-- va al informe


CREATE ASSERSTION gr18_ck_2
CHECK NOT EXISTS ( 
    SELECT 1
    FROM GR18_Inscripcion I
    JOIN GR18_Competencia C
    ON (C.idCompetencia = I.idCompetencia)
    WHERE I.fecha > C.fechaLimiteInscripcion
);

*/

CREATE OR REPLACE FUNCTION TRFN_GR18_Inscripcion_FechaLimite() 
RETURNS trigger AS $$
DECLARE flag integer;    
BEGIN    
    SELECT INTO flag 1
    FROM GR18_Inscripcion I
    JOIN GR18_Competencia C
    ON (C.idCompetencia = I.idCompetencia)
    WHERE I.fecha > C.fechaLimiteInscripcion;
    IF (flag = 1) THEN
        RAISE EXCEPTION 'Las inscripciones no se pueden realizar luego de la fecha límite de inscripción.';
    END IF;    
    RETURN NEW;
END; $$
LANGUAGE 'plpgsql';

DROP TRIGGER IF EXISTS TR_GR18_Inscripcion_FechaLimite ON GR18_Inscripcion;
CREATE TRIGGER TR_GR18_Inscripcion_FechaLimite
AFTER INSERT ON GR18_Inscripcion
FOR EACH STATEMENT EXECUTE PROCEDURE TRFN_GR18_Inscripcion_FechaLimite();




-- d. Para cada categoría la edad mínima debe ser por lo menos 10 años menos que la edad máxima.
-- Restriccion en la tabla: 

    ALTER TABLE GR18_Categoria
    ADD CONSTRAINT gr18_ck_1 CHECK( edadMinima <= (edadMaxima-10));

-- e. Sólo es posible realizar inscripciones de equipos o de deportistas; no de ambos.

    ALTER TABLE GR18_Inscripcion
    ADD CONSTRAINT gr18_ck_2 CHECK( (
        Equipo_id IS NULL AND 
        tipoDoc IS NOT NULL AND 
        nroDoc IS NOT NULL) OR (
        Equipo_id IS NOT NULL AND 
        tipoDoc IS NULL AND 
        nroDoc IS NULL) );

-- f. Un juez que también es deportista, no puede participar en una competencia en la 
-- cual se desempeña como juez.
-- RESTRICCIONES EN: GR18_JuezCompetencia, GR18_Inscripcion and GR18_EquipoDeportista

    CREATE OR REPLACE FUNCTION TRFN_GR18_Multiplestablas_Juezdeportista() 
        RETURNS trigger AS $$
        DECLARE flag1 integer;
        DECLARE flag2 integer;    
        BEGIN    
            SELECT INTO flag1  1
                FROM GR18_Inscripcion I
                JOIN GR18_JuezCompetencia J
                ON (I.nroDoc = J.nroDoc AND I.tipoDoc = J.tipoDoc AND I.idCompetencia = J.idCompetencia)
            UNION
            SELECT 1
                FROM GR18_Inscripcion I
                JOIN GR18_EquipoDeportista E
                ON (I.Equipo_id = E.Id)
                JOIN GR18_JuezCompetencia J
                ON (E.nroDoc = J.nroDoc AND E.tipoDoc = J.tipoDoc AND I.idCompetencia = J.idCompetencia);
            IF (flag1 = 1) THEN
                RAISE EXCEPTION 'Un juez que también es deportista, no puede participar en una competencia en la cual se desempeña como juez';
        END IF;    
        RETURN NEW;
    END; $$
    LANGUAGE 'plpgsql';



    DROP TRIGGER IF EXISTS TR_GR18_Inscripcion_Juezdeportista ON GR18_Inscripcion;
    CREATE TRIGGER TR_GR18_Inscripcion_Juezdeportista
    AFTER INSERT ON GR18_Inscripcion
    FOR EACH STATEMENT EXECUTE PROCEDURE TRFN_GR18_Multiplestablas_Juezdeportista();


    DROP TRIGGER IF EXISTS TR_GR18_equipodeportista_Juezdeportista ON GR18_equipodeportista;
    CREATE TRIGGER TR_GR18_equipodeportista_Juezdeportista
    AFTER INSERT ON GR18_equipodeportista
    FOR EACH STATEMENT EXECUTE PROCEDURE TRFN_GR18_Multiplestablas_Juezdeportista();


    DROP TRIGGER IF EXISTS TR_GR18_juezcompetencia_Juezdeportista ON GR18_juezcompetencia;
    CREATE TRIGGER TR_GR18_juezcompetencia_Juezdeportista
    AFTER INSERT ON GR18_juezcompetencia
    FOR EACH STATEMENT EXECUTE PROCEDURE TRFN_GR18_Multiplestablas_Juezdeportista();





-- g. Si la competencia es grupal no se deben permitir inscripciones individuales.

-- VA AL INFORME
/*
CREATE ASSERSTION gr18_ck_3
CHECK NOT EXISTS ( 
    SELECT 1 
    FROM GR18_Inscripcion I
    JOIN GR18_Competencia C
    ON (I.idCompetencia = C.idCompetencia)
    WHERE I.individual = B'1'
*/


    CREATE OR REPLACE FUNCTION TRFN_GR18_Inscripcion_Individuales() RETURNS trigger AS $$
        DECLARE flag integer;
        BEGIN                
            SELECT INTO flag 1 
            FROM GR18_Inscripcion I
            JOIN GR18_Competencia C
            ON (I.idCompetencia = C.idCompetencia)
            WHERE C.individual = B'1';
                IF (flag = 1) THEN
                    RAISE EXCEPTION 'La competencia es grupal por lo tanto no se deben permitir inscripciones individuales';
            END IF;    
            RETURN NEW;
        END; $$
    LANGUAGE 'plpgsql';


    DROP TRIGGER IF EXISTS TR_GR18_Inscripcion_Individuales ON GR18_Inscripcion;
    CREATE TRIGGER TR_GR18_Inscripcion_Individuales
    AFTER INSERT ON GR18_Inscripcion
    FOR EACH STATEMENT EXECUTE PROCEDURE TRFN_GR18_Inscripcion_Individuales();




-- h. Se debe controlar que en la clasificación, por cada competencia grupal, todos los integrantes de cada equipo tengan asignados los mismos puntos y puestos
-- restriccion de tabla: GR18_ClasificacionCompetencia


    CREATE OR REPLACE FUNCTION TRFN_GR18_ClasificacionCompetencia_mismos() RETURNS trigger AS $$
        DECLARE flag integer;
        BEGIN   
    SELECT INTO flag COUNT(*) as cantidad, CC.puestoGeneral, CC.puntosGeneral, CC.idCompetencia, I.Equipo_id 
    FROM GR18_ClasificacionCompetencia CC
    JOIN GR18_Competencia C
    ON ( CC.idCompetencia = C.idCompetencia )
    JOIN GR18_Inscripcion I 
    ON ( I.idCompetencia = C.idCompetencia )
    JOIN GR18_EquipoDeportista E
    ON ( E.id = I.Equipo_id )
    JOIN GR18_Deportista D
    ON ( E.nroDoc = D.nroDoc AND E.tipoDoc = D.tipoDoc )
    WHERE C.individual = B'0'
    GROUP BY ( CC.puestoGeneral, CC.puntosGeneral, CC.idCompetencia, I.Equipo_id )
    HAVING COUNT(*) <> (SELECT COUNT(*) FROM GR18_EquipoDeportista WHERE id = I.Equipo_id );

               IF (flag = 1) THEN
                    RAISE EXCEPTION 'La competencia es grupal por lo tanto no se deben permitir inscripciones individuales';
            END IF;    
            RETURN NEW;
        END; $$
    LANGUAGE 'plpgsql';


    DROP TRIGGER IF EXISTS TR_GR18_ClasificacionCompetencia_mismos ON GR18_ClasificacionCompetencia;
    CREATE TRIGGER TR_GR18_ClasificacionCompetencia_mismos
    AFTER INSERT ON GR18_ClasificacionCompetencia
    FOR EACH STATEMENT EXECUTE PROCEDURE TRFN_GR18_ClasificacionCompetencia_mismos();



---
--- 
--- SERVICIOS
---
--- 1)

CREATE OR REPLACE FUNCTION lista_deportista(INTEGER) RETURNS TABLE() AS $A$
DECLARE
	mi_consulta RECORD;
BEGIN
	FOR mi_consulta IN 
        SELECT * 
        FROM  GR18_Competencia C
        JOIN GR18_Inscripcion I
        ON ( I.idCompetencia = C.idCompetencia )
        LEFT JOIN GR18_Equipo E
        ON ( E.id = I.Equipo_id )
        LEFT JOIN GR18_EquipoDeportista ED
        ON ( E.id = ED.id )
        LEFT JOIN GR18_Deportista D
        ON ( ED.tipoDoc = D.tipoDoc AND E.nroDoc = D.nroDoc )
   
        LEFT JOIN GR18_Deportista DD
        ON ( I.tipoDoc = DD.tipoDoc AND I.nroDoc = DD.nroDoc ) 
        JOIN GR18_Persona P
        ON ( P.tipoDoc = D.tipoDoc AND P.nroDoc = D.nroDoc ) 
        WHERE idCompetencia = $1
	LOOP




    --        mostrar mi record

		--INSERT INTO REPORTEPROBLEMA VALUES (
				--mi_consulta.id_producto, 
                -- no se como hacerlo aca
    END LOOP;
	RETURN 1;
END;
$A$ 
LANGUAGE 'plpgsql';


--- 2)

CREATE OR REPLACE FUNCTION equipos(INTEGER) RETURNS SETOF RECORDS AS $A$
DECLARE
	mi_consulta RECORD;
BEGIN
--	DELETE FROM REPORTEPROBLEMA;
	FOR mi_consulta IN 

        SELECT E.nombre  
        FROM GR18_Equipo E
        JOIN GR18_EquipoDeportista ED
        ON ( E.id = ED.id )
        JOIN LEFT GR18_Deportista D
        ON ( ED.tipoDoc = D.tipoDoc AND E.nroDoc = D.nroDoc )
        WHERE D.nroDoc = $1
		LOOP
		INSERT INTO REPORTEPROBLEMA VALUES (
        --mi_consulta.id_producto, 
        -- no se como hacerlo aca
    END LOOP;
	RETURN 1;
END;
$A$ 
LANGUAGE 'plpgsql';



--- 3)





CREATE OR REPLACE FUNCTION clasificacion(INTEGER) RETURNS SETOF RECORDS AS $A$
DECLARE
	mi_consulta RECORD;
BEGIN
--	DELETE FROM REPORTEPROBLEMA;
	FOR mi_consulta IN 

        SELECT P.apellido, P.nombre, puestoGeneral, puntosGeneral  
        FROM GR18_ClasificacionCompetencia CC
        JOIN GR18_Deportista D
        ON ( CC.tipoDoc = D.tipoDoc AND 
        CC.nroDoc = D.nroDoc )
        JOIN GR18_Persona P
        ON ( P.tipoDoc = D.tipoDoc AND P.nroDoc = D.nroDoc ) 
        WHERE idCompetencia = $1
        ORDER BY CC.puestoGeneral ASC 
		LOOP
		INSERT INTO REPORTEPROBLEMA VALUES (
        --mi_consulta.id_producto, 
        -- no se como hacerlo aca
    END LOOP;
	RETURN 1;
END;
$A$ 
LANGUAGE 'plpgsql';



--- 4)



CREATE OR REPLACE FUNCTION jueces(INTEGER) RETURNS SETOF RECORDS AS $A$
DECLARE
	mi_consulta RECORD;
BEGIN
--	DELETE FROM REPORTEPROBLEMA;
	FOR mi_consulta IN 

        SELECT C.*
        FROM GR18_JuezCompetencia JC
        JOIN GR18_Competencia C
        ON (C.idCompetencia = JC.idCompetencia)
        WHERE JC.nroDoc = $1
		LOOP
		INSERT INTO REPORTEPROBLEMA VALUES (
        --mi_consulta.id_producto, 
        -- no se como hacerlo aca
    END LOOP;
	RETURN 1;
END;
$A$ 
LANGUAGE 'plpgsql';


---
--- 
--- VISTAS
---
--- 1) 

CREATE VIEW competenciasOrdenadas AS
    (
        SELECT  DISTINCT C.*
        FROM GR18_Competencia C
        JOIN GR18_Inscripcion I
        ON ( C.idCompetencia = I.idCompetencia)
        JOIN GR18_EquipoDeportista E
        ON (E.id = I.Equipo_id)
        WHERE I.nroDoc, I.tipoDoc NOT IN ( SELECT nroDoc, tipoDoc FROM GR18_ClasificacionCompetencia)
    )
    UNION
    (
        SELECT DISTINCT C.*
        FROM GR18_Competencia C
        JOIN GR18_Inscripcion I
        ON ( C.idCompetencia = I.idCompetencia)
        WHERE I.nroDoc, I.tipoDoc NOT IN ( SELECT nroDoc, tipoDoc FROM GR18_ClasificacionCompetencia)
    );




--- 2)

CREATE VIEW puntosDeportistas AS

SELECT P.*, SUM(puntosCategoria), SUM(puntosGeneral)
FROM GR18_ClasificacionCompetencia C
JOIN GR18_Persona P
ON (P.tipoDoc = C.tipoDoc AND P.nroDoc = C.nroDoc)
WHERE EXTRACT(YEAR FROM fecha) = EXTRACT(YEAR from CURRENT_TIMESTAMP);






