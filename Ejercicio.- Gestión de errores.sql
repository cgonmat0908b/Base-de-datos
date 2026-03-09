USE employees;

DROP PROCEDURE IF EXISTS employee_add;
DELIMITER €€
CREATE DEFINER=`root`@`localhost` PROCEDURE `employee_add`(numEmp int,  nombre varchar(20), apellidos varchar(25), email VARCHAR(100))

BEGIN
    DECLARE error boolean default false;

    DECLARE CONTINUE HANDLER FOR SQLSTATE '23000'
    BEGIN
        SET error = TRUE;
    END;
    
    INSERT INTO employees(employee_id, first_name, last_name , email , hire_date, job_id, salary)
    VALUES (numEmp,nombre, apellidos , email ,'1990-01-01', 13, 3000);
    
    IF (error) THEN
	SELECT -1,'Clave primaria duplicada';
    ELSE
        SELECT 0,'Fila añadida';
    END IF;

END €€
DELIMITER ;

CALL employee_add(90,"Juan", "Sanchez Gomez", "jsg@gmail.com");

SELECT * FROM employees WHERE employee_id = 90;

-- Sobre la base de datos employees realiza un script que inserte un registro en la tabla departments.
-- El script deberá capturar el error en el caso en que se intente añadir un registro con una clave primaria que ya existe en la tabla.

-- Para ello, puedes guiarte a partir del script que se adjunta en la actividad.

DROP PROCEDURE IF EXISTS add_departments;
DELIMITER €€
CREATE PROCEDURE `add_departments`(id_departamento INT, nombre_departamento VARCHAR(30), id_localizacion INT)

BEGIN
	DECLARE error boolean default false;
    DECLARE CONTINUE HANDLER FOR SQLSTATE '23000'
    BEGIN
        SET error = TRUE;
    END;
    
	INSERT INTO departments(department_id, department_name, location_id)
    VALUES (id_departamento, nombre_departamento, id_localizacion);

	IF (error) THEN
	SELECT -1,'Clave primaria duplicada';
    ELSE
        SELECT 0,'Fila añadida';
    END IF;
    
END €€
DELIMITER ;

CALL add_departments(34, "Recursos Humanos", 1700);

SELECT * FROM departments WHERE department_id = 34;