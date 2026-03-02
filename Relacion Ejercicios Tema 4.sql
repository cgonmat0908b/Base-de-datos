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

-- 3) Crea un procedimiento que muestre el año actual.
DROP PROCEDURE IF EXISTS actual;

-- 4) Crea una función, llamado incrementa_en_uno, que incremente en uno un número entero que le
-- pasemos a la función.

-- 5) Crea una función que reciba como parámetro un número y devuelva TRUE si el número es impar y
-- FALSE si el número es par.