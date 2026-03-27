USE employees;

CREATE TABLE empleados_numero(fecha DATETIME, numEmpleados int);

/* Creamos un evento que se ejecutará a partir de ahora cada 4 segundos
durante 1 minuto que guardará el numero de empleados que tiene la 
tabla employees en un momento determinad */

DELIMITER €€
CREATE EVENT numero_empleados ON SCHEDULE EVERY 4 SECOND STARTS now()
ENDS CURRENT_TIMESTAMP + INTERVAL 1 MINUTE
DO
BEGIN
	DECLARE numEmp int default 0;
    SELECT COUNT(*) FROM employees INTO numEmp;
    INSERT INTO empleados_numero VALUES (now(), numEmp);
END €€

SELECT * FROM empleados_numero;

/* Este evento haría exactamente lo mismo que el anterior */
CREATE EVENT numero_empleados2 ON SCHEDULE EVERY 4 SECOND STARTS NOW()
ENDS CURRENT_TIMESTAMP + INTERVAL 1 MINUTE
DO
INSERT INTO empleados_numero SELECT NOW(), COUNT(*) FROM employees;

/*Eliminamos el evento numero_empleados*/
DROP EVENT numero_empleados;

/*Alteramos el evento numero_empleados*/
ALTER EVENT numero_empleados DISABLE;

/*Creamos una tabla para guardar los datos de acceso de los clientes de MySQL*/

CREATE TABLE historico_accesos(
	user varchar(50),
    host varchar(50),
    time int);

/* Creamos un evento que guarde los accesos de los usuarios al servidor MySQL a partir de ahora*/
CREATE EVENT  historico_accesos_minuto
ON SCHEDULE EVERY 1 SECOND STARTS NOW() ENDS CURRENT_TIMESTAMP + INTERVAL 1 MINUTE
ON COMPLETION PRESERVE 
DO
INSERT INTO historico_accesos SELECT user,host, time FROM information_schema.processlist;

SELECT * FROM historico_accesos;


/*Creamos tabla employees_copia con los mismos campos de la tabla employees*/
USE employees;
CREATE TABLE employees_copia LIKE employees;

/*Creamos el evento para hacer la copia de seguridad de la tabla employees
A una hora determinada los datos de la tabla
employees se volcarán en la tabla employees_copia*/

CREATE EVENT copia_tabla_employees
ON SCHEDULE AT "2026-03-27 17:57"
ON COMPLETION PRESERVE
DO
INSERT INTO employees_copia SELECT * FROM employees;

DROP EVENT copia_tabla_employees;

SELECT * FROM employees_copia;

