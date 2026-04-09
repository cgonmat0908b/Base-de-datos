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
-- Usar employees

/* 1) Haz que no se pueda añadir un nuevo departamento si el número de caracteres del nombre a añadir es
inferior a 5 caracteres.*/ 


/*2) Cada vez que se añada un nuevo departamento, asigna como 'manager' del nuevo departamento al
empleado que esté actualmente trabajando y que lleve más tiempo en la empresa, y, además, no sea
manager de ningún otro departamento.

3) Crea una tabla de nombre REGISTRO con las columnas:
• id autonumérica Clave primaria
• usuario: varchar(100)
• tabla: varchar(100)
• operacion: varchar(10)
• fecha-hora: datetime
Crea un nuevo usuario de nombre 'Gestiona_Triggers' que tenga permisos para crear y ejecutar triggers.
Conéctate con dicho usuario y crea los triggers necesarios para que:
• Se registren las operaciones de alta, baja y modificación sobre la tabla 'departments'.
• Si ya existen triggers creados, nos los modifiques, crea uno nuevo.
• Impide que se pueda añadir o modificar un salario a un empleado si este es inferior a 30000
euros o superior a 300000 euros anuales.
Nota: Acuérdate de otorgar los permisos necesarios al usuario creado para poder acceder a las tablas
NEW y OLD.

*/

/* 4) Crea una tabla de nombre CONTADOR con las columnas:
• id autonumérica: clave primaria
• tipo: varchar(100)
• valor: int

Añade dos filas a la tabla con los valores siguientes:
ID TIPO VALOR
1 numEmpleados 0
2 numDepartamentos 0

Haz que cada vez que haya alguna operación que modifique el número de empleados o de
departamentos, se actualice el número total de los mismos en la tabla contador.

*/

-- RELACIÓN DE EJERCICIOS SOBRE EVENTOS
-- Usar employees

/*
1) Queremos registrar, cada 1 minuto en el día de hoy y durante unos 10 minutos desde el momento
de creación del evento, qué usuarios están accediendo a la base de datos employees. Estos usuarios
(sus nombres y equipos) deberán quedar registrados en una tabla de nombre
'historico_usuarios_hora' en la que se guardará el nombre del usuario, así como el día-hora-minuto
en el que se produjo el registro de actividad.
Pista: La tabla del diccionario de datos donde se guarda esta información es
information_schema.processlist.

2) Haz que el día 30 de enero del 2021 a las 23:15 se guarde una copia de los datos de la tabla
departments en una tabla creada por ti previamente de nombre dept_copia.

3) Crea una tabla de nombre empleados_numero_mensual que guarde el número de empleados que
tiene la empresa. Haz que se ejecute una vez cada 4 días después de que se cree el evento.

4) Haz que el día 1 de enero de cada año se actualicen lossalarios de los manager de cada departamento
un 10% que estén trabajando actualmente en la empresa. Esta actualización se debe producir
durante 5 años a partir del actual.
Cambia la hora del sistema para comprobar que se ejecuta el evento.

*/

-- RELACIÓN DE EJERCICIOS SOBRE VISTAS
-- Usar employees

/*1) Crea una vista que muestre los nombres de los empleados que tengan un salario por encima de los
85.000 euros.
Crea un usuario nuevo y dale permisos para que pueda usar la vista (seleccionar).
Conéctate con dicho usuario y comprueba que puede hacer uso de la vista.

2) Crea una vista que muestre los datos de la tabla 'titles' pero sólo de los empleados que siguen
trabajando actualmente.
Prueba a añadir, borrar o modificar alguno de los datos que obtiene dicha vista.
Modifica la vista para que verifique que los datos nuevos cumplan las condiciones de la vista.
Crea un usuario nuevo (o usa uno de los ya creados) y dale permisos para que pueda usar la vista
(seleccionar, modificar y borrar, pero no insertar). ¿Qué ocurre cuando dicho usuario intenta
actualizar algunos de los datos de la vista?

3) Crea una vista que muestre los datos de los empleados que pertenecen al 'staf'. Los datos a
mostrar son los que se encuentran en la tabla 'employees'.
Crea una vista, que haciendo uso de la vista anterior, muestre los nombres de los empleados y el
departamento en el que trabaja (su nombre).
¿Qué datos podrían ser actualizados/añadidos en la vista anterior?

4) Crea una vista que muestre los empleados que hayan nacido entre 1950 y 1955 y haz que dicha
vista se ejecute con los permisos del usuario que la utilice.
Crea un usuario nuevo (o usa uno de los ya creados) y dale permisos para que pueda hacer todas
las operaciones sobre la vista.

*/

