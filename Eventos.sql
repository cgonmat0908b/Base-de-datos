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