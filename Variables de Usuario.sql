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

