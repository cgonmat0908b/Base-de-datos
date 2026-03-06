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

SELECT ()