USE employees;

-- Variable de usuario
-- Las variables de usuario deben comenzar su nombre con el simbolo @
-- Para asignar un valor a una variable de usuario usaremos la orden de SQL SET

SET @nombre = 'pepe';
SET @edad = 12;

SELECT @nombre, @edad;

-- Ejemplos de uso de variables del usuario

-- 1) Encuentra los ids d los empleados que tienen un sueldo superior a 5.000
set @salarioMinimo = 5000;

SELECT DISTINCT *
FROM employees
WHERE salary > @salarioMinimo;

-- 2 Guarda el valor de una consulta en una variable
SELECT count(*)
INTO @numEmpleados
FROM employees
WHERE department_id = 5;

SELECT @numEmpleados;

-- 3 Guardar mas valores
-- teniendo en cuenta que cada variable se corresponde en el mismo orden con el select asociado
-- El numero de columnas obtenidas en el select se deben corresponder con el mismo numero de vairables
-- Si el select tiene 4 columnas, 4 variables en la clausula INTO
SELECT max(salary), min(salary)
INTO @max, @min
FROM employees;

SELECT @max SalarioMax, @min SalarioMin;


-- 4 Podemos asignar valores a varias variables en la misma linea

set @dept_no = '100', @dept_name = 'Departamento de prueba';
INSERT INTO departments(department_id,department_name) VALUES(@dept_no,@dept_name);

SELECT * FROM departments WHERE department_id = '100';

-- 5 podemos generar nuevas variables en base a valores de otras variables, 
-- por medio de expresiones

SET @dep_no = '100', @dept_name = 'Departamento de prueba';
SET @cadenaCompleta = CONCAT(@dept_no, ' > ', @dept_name);
SELECT @cadenaCompleta;

-- Procedimientos Almacenados

-- Crear procedimiento
DELIMITER EE
CREATE PROCEDURE employees.department_getList()
BEGIN 
SELECT department_id, department_name
FROM departments;
END EE
DELIMITER ;

-- Llamada de procedimiento 
CALL department_getList();

-- Listar procedimientos
SHOW PROCEDURE STATUS;

SHOW PROCEDURE STATUS
WHERE Db = 'employees';

-- Visualizar el codigo de un procedimiento
SHOW CREATE PROCEDURE employees.department_getList;

-- Modificar un procedimiento
ALTER PROCEDURE employees.department_getList
COMMENT 'Obtiene un listado de todos los departamentos';
SHOW PROCEDURE STATUS
WHERE Db = 'employees';

-- Borrar un procedimiento
DROP PROCEDURE IF EXISTS employees.department_getList;

-- Crear un procedimieento que indique si un numero es positivo o negatio

delimiter €€
CREATE procedure signo(IN val int )
begin
	declare respuesta TEXT;
	IF val = 0 THEN
		set respuesta = "El cero no es ni positivo ni negativo";
	elseif val > 0 THEN
		set respuesta = CONCAT(val , " es positivo");
	elseif val < 0 THEN
		set respuesta = CONCAT(val , " es negativo");
	end IF;
    SELECT respuesta;
end€€
delimiter ;

CALL signo(1);

-- Crear procedimiento que convierta una nota numerica a una cualitativa (texto)

DELIMITER €€
CREATE PROCEDURE nota_a_txt(IN num INT)
BEGIN
	DECLARE respuesta VARCHAR(35);
	IF num > 10 OR num < 0 THEN 
		SET respuesta = "Numero introducido no valido";
	ELSE 
		CASE num 
			WHEN 10 THEN SET respuesta = "Sobresaliente";
			WHEN 9 THEN SET respuesta = "Sobresaliente";
			WHEN 8 THEN SET respuesta = "Notable";
			WHEN 7 THEN SET respuesta = "Notable";
			WHEN 6 THEN SET respuesta = "Bien";
			WHEN 5 THEN SET respuesta = "Aprobado";
			ELSE SET respuesta = "Insuficiente";
		END CASE;
	END IF;
SELECT respuesta;

END €€
DELIMITER ;

CALL nota_a_txt(11);
CALL nota_a_txt(-5);
CALL nota_a_txt(10);
CALL nota_a_txt(7);
CALL nota_a_txt(6);
CALL nota_a_txt(5);

-- Estructuras de repeticion Bucles, WHILE

DELIMITER €€
CREATE PROCEDURE bucle(INOUT num INT)
BEGIN
	DECLARE i INT DEFAULT 1;
    WHILE i <= 5 DO
		SET num = num + 1;
        SET i = i + 1;
	END WHILE;
END €€
DELIMITER ;

SET @num = 21;
CALL bucle(@num);
SELECT @num;

-- Bucle REPEAT

DELIMITER €€
CREATE PROCEDURE bucleRepeat(INOUT num INT)
BEGIN 
	DECLARE i INT DEFAULT 1;
    REPEAT
		SET num = num + 1;
        SET i = i + 1;
	UNTIL i > 5
	END REPEAT;
END €€
DELIMITER ;

CALL bucleRepeat(@num);
SELECT @num;

-- Bucle LOOP LEAVE

DELIMITER €€
CREATE PROCEDURE loopp()
BEGIN 
	DECLARE contador BIGINT DEFAULT 1;
    bucleLoop: LOOP
		SET contador = contador + 1;
		IF contador = 10 THEN
			LEAVE bucleLoop;
		END IF;
        SELECT contador;
	END LOOP bucleLoop;
END €€;
DELIMITER ;

CALL loopp();


-- Funciones

DELIMITER €€
CREATE FUNCTION ejemploFuncion() RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
	RETURN 'hola';
END €€
DELIMITER ;

SELECT ejemploFuncion();

-- Funcion que devuelva el mayor de tres numeros pasados como parametros

DELIMITER €€
CREATE FUNCTION mayorDeTres( x INT, y INT, z INT) RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE num INT DEFAULT 0;
	IF x > y THEN
		SET num = x;
	ELSE
		SET num = y;
	END IF;
    
    IF z > num THEN
		SET num = z;
	END IF;
    RETURN num;
END €€

SELECT mayorDeTres(15,10,20);


-- Crea una función que devuelva el nombre de un empleado a partir de su id empleado

DELIMITER €€
CREATE FUNCTION nomEmpleado(id INT) RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
	DECLARE nom VARCHAR(20);
    SELECT first_name INTO nom FROM employees WHERE employee_id = id;
    RETURN nom;
END €€
DELIMITER ;

SELECT nomEmpleado(206);
SELECT employee_id FROM employees;

SELECT * FROM employees;

-- Consulta para saber el nombre del jefe de cada empleado con la funcion anterior
SELECT *, nomEmpleado(manager_id) nombre_Manager FROM employees;






    





