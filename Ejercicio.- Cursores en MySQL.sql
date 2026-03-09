
USE employees;

DELIMITER €€
CREATE DEFINER=`root`@`localhost` PROCEDURE `cursorTest`()
BEGIN
-- Variables donde almacenar lo que nos traemos desde el SELECT
  DECLARE v_employee_id int;
  DECLARE v_first_name varchar(20);
  DECLARE v_last_name varchar(25);
  DECLARE v_email varchar(100);
  
-- Variable para controlar el fin del bucle
  DECLARE fin BOOL DEFAULT FALSE;

-- El SELECT que vamos a ejecutar
  DECLARE employees_cursor CURSOR FOR
    SELECT employee_id, first_name, last_name, email FROM employees.employees ORDER BY employee_id LIMIT 20;

-- Condición de salida
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin=TRUE;

  OPEN employees_cursor;
  get_employees: LOOP
    FETCH employees_cursor INTO v_employee_id, v_first_name, v_last_name, v_email;
    IF fin = TRUE THEN
       LEAVE get_employees;
    END IF;

	SELECT v_employee_id, v_first_name, v_last_name, v_email;

  END LOOP get_employees;

  CLOSE employees_cursor;
END €€
DELIMITER ;

CALL cursorTest();

-- Sobre la base de datos employees, realiza un cursor que recorra las filas devueltas por una instrucción SELECT que muestra el nº de empleados que trabaja en cada departamento.
-- Por tanto, el cursor  mostrará dos variables que almacenarán el código de departamento y el nº de empleados que trabaja en dicho departamento. 

-- Para ello, te puedes ayudar del script adjunto a la actividad.

-- Una vez finalizada la tarea, sube el archivo con el código del script.


-- Ej 
USE employees;

DELIMITER €€

DROP PROCEDURE IF EXISTS empleadosPorDepartamento;
CREATE PROCEDURE `empleadosPorDepartamento`()

BEGIN

-- Variables donde almacenar lo que nos traemos desde el SELECT
DECLARE id_departamento INT;
DECLARE num_Empleados INT;

-- Variable para el bucle
DECLARE fin BOOL DEFAULT FALSE;

-- Declaramos el cursor y el SELECT que vamos a ejecutar para el cursor
DECLARE empleados_dep CURSOR FOR
SELECT department_id, COUNT(*) total_empleados
FROM employees
GROUP BY department_id;

-- Esta linea cambia el valor de la variable de control del bucle cuanto salta la excepcion
DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin=TRUE;

-- Apertura del cursor y bucle
OPEN empleados_dep;

	numEmp: LOOP
    FETCH empleados_dep INTO id_departamento, num_Empleados ;
    IF fin = TRUE THEN
       LEAVE numEmp;
    END IF;

	SELECT id_departamento, num_Empleados;

  END LOOP numEmp;

  CLOSE empleados_dep;
  
END €€
DELIMITER ;

CALL empleadosPorDepartamento();


-- Con bucle repeat

USE employees;
DROP PROCEDURE IF EXISTS empleadosPorDepartamentoREPEAT;
DELIMITER €€

CREATE PROCEDURE `empleadosPorDepartamentoREPEAT`()

BEGIN

-- Variables donde almacenar lo que nos traemos desde el SELECT
DECLARE id_departamento INT;
DECLARE num_Empleados INT;

-- Variable para el bucle
DECLARE fin BOOL DEFAULT FALSE;

-- Declaramos el cursor y el SELECT que vamos a ejecutar para el cursor
DECLARE empleados_dep CURSOR FOR
SELECT department_id, COUNT(*) total_empleados
FROM employees
GROUP BY department_id;

-- Esta linea cambia el valor de la variable de control del bucle cuanto salta la excepcion
DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin=TRUE;

-- Apertura del cursor y bucle
-- Con repeat
OPEN empleados_dep;

	REPEAT
    
    FETCH empleados_dep INTO id_departamento, num_Empleados ;
    SELECT id_departamento, num_Empleados;
    UNTIL fin = true
    
	END REPEAT;

CLOSE empleados_dep;
  
END €€
DELIMITER ;

CALL empleadosPorDepartamentoREPEAT();


