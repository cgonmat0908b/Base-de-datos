-- RELACIÓN DE EJERCICIOS SOBRE PROCEDIMIENTOS Y FUNCIONES

-- 1) Realiza un procedimiento que muestre el texto “hola mundo” sobre la base de datos MySQL.
USE MySQL;

DROP PROCEDURE IF EXISTS holaMundo;
DELIMITER €€
CREATE PROCEDURE MySQL.holaMundo()
BEGIN
	SELECT "Hola mundo";
END €€
DELIMITER ;

CALL holaMundo();

-- 2) Crea un procedimiento que muestre la versión de MySQL.
DROP PROCEDURE IF EXISTS ver;
USE MySQL;
DELIMITER €€
CREATE PROCEDURE MySQL.ver()
BEGIN
	SELECT VERSION();
END €€
DELIMITER ;

CALL ver();

-- Base de datos en la que guardamos funciones/procedimientos de los ejercicios 3,4 y 5
DROP DATABASE IF EXISTS funciones;
CREATE DATABASE funciones;

-- 3) Crea un procedimiento que muestre el año actual.
DROP PROCEDURE IF EXISTS actual;
DELIMITER €€

CREATE PROCEDURE funciones.actual()
BEGIN 
	SELECT DATE(NOW());
END €€

DELIMITER ;

CALL funciones.actual();

-- 4) Crea una función, llamado incrementa_en_uno, que incremente en uno un número entero que le
-- pasemos a la función.
DROP FUNCTION IF EXISTS incrementa_en_uno;
DELIMITER €€

-- Funcion
CREATE FUNCTION funciones.incrementa_en_uno(num INT) RETURNS INT DETERMINISTIC
BEGIN 
	DECLARE numIncrementado INT DEFAULT 0;
    SET numIncrementado = num + 1;
    RETURN numIncrementado;
END €€

DELIMITER ;

-- Uso de funcion
SELECT funciones.incrementa_en_uno(5);

-- 5) Crea una función que reciba como parámetro un número y devuelva TRUE si el número es impar y
-- FALSE si el número es par.
DROP FUNCTION IF EXISTS funciones.esPar;
DELIMITER €€

-- Funcion
CREATE FUNCTION funciones.esPar(num INT) RETURNS VARCHAR(20) DETERMINISTIC
BEGIN 
	DECLARE resultado VARCHAR(20) DEFAULT "Desconocido";
    
    IF num % 2 = 0 THEN
		SET resultado = "FALSE";
	ELSE
		SET resultado = "TRUE";
	END IF;
    
	RETURN resultado;
END €€

DELIMITER ;

SELECT funciones.esPar(8);


-- RELACIÓN DE EJERCICIOS SOBRE TRIGGERS


