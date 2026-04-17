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
USE employees;
/* 1) Haz que no se pueda añadir un nuevo departamento si el número de caracteres del nombre a añadir es
inferior a 5 caracteres.*/ 

DELIMITER $$

CREATE TRIGGER trg_departments_nombre_min_ins
BEFORE INSERT ON departments
FOR EACH ROW
BEGIN
    IF CHAR_LENGTH(TRIM(NEW.department_name)) < 5 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El nombre del departamento debe tener al menos 5 caracteres';
    END IF;
END$$

DELIMITER ;


/*2) Cada vez que se añada un nuevo departamento, asigna como 'manager' del nuevo departamento al
empleado que esté actualmente trabajando y que lleve más tiempo en la empresa, y, además, no sea
manager de ningún otro departamento.*/
ALTER TABLE departments
ADD COLUMN manager_id INT NULL,
ADD CONSTRAINT fk_departments_manager
FOREIGN KEY (manager_id) REFERENCES employees(employee_id)
ON DELETE SET NULL
ON UPDATE CASCADE;


DELIMITER $$

CREATE TRIGGER trg_departments_asignar_manager
BEFORE INSERT ON departments
FOR EACH ROW
BEGIN
    DECLARE v_manager INT;

    SELECT e.employee_id
    INTO v_manager
    FROM employees e
    WHERE e.employee_id NOT IN (
        SELECT d.manager_id
        FROM departments d
        WHERE d.manager_id IS NOT NULL
    )
    ORDER BY e.hire_date ASC, e.employee_id ASC
    LIMIT 1;

    SET NEW.manager_id = v_manager;
END$$

DELIMITER ;


/* 3) Crea una tabla de nombre REGISTRO con las columnas:
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


CREATE TABLE IF NOT EXISTS registro (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario VARCHAR(100),
    tabla_nombre VARCHAR(100),
    operacion VARCHAR(10),
    fecha_hora DATETIME
);

CREATE USER IF NOT EXISTS 'Gestiona_Triggers'@'localhost'
IDENTIFIED BY 'ClaveSegura123!';

DELIMITER $$

CREATE TRIGGER trg_departments_registro_ins
AFTER INSERT ON departments
FOR EACH ROW
BEGIN
    INSERT INTO registro(usuario, tabla_nombre, operacion, fecha_hora)
    VALUES (CURRENT_USER(), 'departments', 'ALTA', NOW());
END$$

CREATE TRIGGER trg_departments_registro_upd
AFTER UPDATE ON departments
FOR EACH ROW
BEGIN
    INSERT INTO registro(usuario, tabla_nombre, operacion, fecha_hora)
    VALUES (CURRENT_USER(), 'departments', 'MODIFICACION', NOW());
END$$

CREATE TRIGGER trg_departments_registro_del
AFTER DELETE ON departments
FOR EACH ROW
BEGIN
    INSERT INTO registro(usuario, tabla_nombre, operacion, fecha_hora)
    VALUES (CURRENT_USER(), 'departments', 'BAJA', NOW());
END$$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER trg_employees_salario_rango_ins
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    IF NEW.salary < 30000 OR NEW.salary > 300000 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El salario debe estar entre 30000 y 300000 euros anuales';
    END IF;
END$$

CREATE TRIGGER trg_employees_salario_rango_upd
BEFORE UPDATE ON employees
FOR EACH ROW
BEGIN
    IF NEW.salary < 30000 OR NEW.salary > 300000 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El salario debe estar entre 30000 y 300000 euros anuales';
    END IF;
END$$

DELIMITER ;




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

DROP TABLE IF EXISTS contador;

CREATE TABLE contador (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tipo VARCHAR(100),
    valor INT
);

INSERT INTO contador (id, tipo, valor) VALUES
(1, 'numEmpleados', 0),
(2, 'numDepartamentos', 0)
ON DUPLICATE KEY UPDATE
tipo = VALUES(tipo),
valor = VALUES(valor);

UPDATE contador
SET valor = (SELECT COUNT(*) FROM employees)
WHERE tipo = 'numEmpleados';

UPDATE contador
SET valor = (SELECT COUNT(*) FROM departments)
WHERE tipo = 'numDepartamentos';

DROP TRIGGER IF EXISTS trg_contador_employees_insert;

DELIMITER $$

CREATE TRIGGER trg_contador_employees_insert
AFTER INSERT ON employees
FOR EACH ROW
BEGIN
    UPDATE contador
    SET valor = valor + 1
    WHERE tipo = 'numEmpleados';
END$$

DELIMITER ;

DROP TRIGGER IF EXISTS trg_contador_employees_delete;

DELIMITER $$

CREATE TRIGGER trg_contador_employees_delete
AFTER DELETE ON employees
FOR EACH ROW
BEGIN
    UPDATE contador
    SET valor = valor - 1
    WHERE tipo = 'numEmpleados';
END$$

DELIMITER ;

DROP TRIGGER IF EXISTS trg_contador_departments_insert;

DELIMITER $$

CREATE TRIGGER trg_contador_departments_insert
AFTER INSERT ON departments
FOR EACH ROW
BEGIN
    UPDATE contador
    SET valor = valor + 1
    WHERE tipo = 'numDepartamentos';
END$$

DELIMITER ;


DROP TRIGGER IF EXISTS trg_contador_departments_delete;

DELIMITER $$

CREATE TRIGGER trg_contador_departments_delete
AFTER DELETE ON departments
FOR EACH ROW
BEGIN
    UPDATE contador
    SET valor = valor - 1
    WHERE tipo = 'numDepartamentos';
END$$

DELIMITER ;

-- RELACIÓN DE EJERCICIOS SOBRE EVENTOS
-- Usar employees
SET GLOBAL event_scheduler = ON;

/*
1) Queremos registrar, cada 1 minuto en el día de hoy y durante unos 10 minutos desde el momento
de creación del evento, qué usuarios están accediendo a la base de datos employees. Estos usuarios
(sus nombres y equipos) deberán quedar registrados en una tabla de nombre
'historico_usuarios_hora' en la que se guardará el nombre del usuario, así como el día-hora-minuto
en el que se produjo el registro de actividad.
Pista: La tabla del diccionario de datos donde se guarda esta información es
information_schema.processlist.*/
DROP TABLE IF EXISTS historico_usuarios_hora;

CREATE TABLE historico_usuarios_hora (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario VARCHAR(100),
    host_equipo VARCHAR(255),
    fecha_hora DATETIME
);

DROP EVENT IF EXISTS ev_historico_usuarios_10min;

DELIMITER $$

CREATE EVENT ev_historico_usuarios_10min
ON SCHEDULE EVERY 1 MINUTE
STARTS NOW()
ENDS NOW() + INTERVAL 10 MINUTE
DO
BEGIN
    INSERT INTO historico_usuarios_hora (usuario, host_equipo, fecha_hora)
    SELECT USER, HOST, NOW()
    FROM information_schema.PROCESSLIST
    WHERE DB = 'employees';
END$$

DELIMITER ;

/*2) Haz que el día 30 de enero del 2021 a las 23:15 se guarde una copia de los datos de la tabla
departments en una tabla creada por ti previamente de nombre dept_copia.*/
DROP TABLE IF EXISTS dept_copia;

CREATE TABLE dept_copia LIKE departments;

DROP EVENT IF EXISTS ev_copia_departments_20210130;

CREATE EVENT ev_copia_departments_20210130
ON SCHEDULE AT '2021-01-30 23:15:00'
DO
INSERT INTO dept_copia
SELECT * FROM departments;

DROP EVENT IF EXISTS ev_copia_departments_prueba;

CREATE EVENT ev_copia_departments_prueba
ON SCHEDULE AT NOW() + INTERVAL 5 MINUTE
DO
INSERT INTO dept_copia
SELECT * FROM departments;

/*3) Crea una tabla de nombre empleados_numero_mensual que guarde el número de empleados que
tiene la empresa. Haz que se ejecute una vez cada 4 días después de que se cree el evento.*/
DROP TABLE IF EXISTS empleados_numero_mensual;

CREATE TABLE empleados_numero_mensual (
    id INT AUTO_INCREMENT PRIMARY KEY,
    fecha_registro DATETIME,
    numero_empleados INT
);

DROP EVENT IF EXISTS ev_num_empleados_cada_4_dias;

CREATE EVENT ev_num_empleados_cada_4_dias
ON SCHEDULE EVERY 4 DAY
STARTS NOW()
DO
INSERT INTO empleados_numero_mensual (fecha_registro, numero_empleados)
SELECT NOW(), COUNT(*)
FROM employees;



/*4) Haz que el día 1 de enero de cada año se actualicen lossalarios de los manager de cada departamento
un 10% que estén trabajando actualmente en la empresa. Esta actualización se debe producir
durante 5 años a partir del actual.
Cambia la hora del sistema para comprobar que se ejecuta el evento.

*/
DROP EVENT IF EXISTS ev_subida_anual_managers;

CREATE EVENT ev_subida_anual_managers
ON SCHEDULE EVERY 1 YEAR
STARTS '2027-01-01 00:00:00'
ENDS '2031-01-01 00:00:00'
DO
UPDATE employees e
JOIN departments d ON e.employee_id = d.manager_id
SET e.salary = e.salary * 1.10;



-- RELACIÓN DE EJERCICIOS SOBRE VISTAS
-- Usar employees

/*1) Crea una vista que muestre los nombres de los empleados que tengan un salario por encima de los
85.000 euros.
Crea un usuario nuevo y dale permisos para que pueda usar la vista (seleccionar).
Conéctate con dicho usuario y comprueba que puede hacer uso de la vista.*/
DROP VIEW IF EXISTS vw_empleados_salario_superior_85000;

CREATE VIEW vw_empleados_salario_superior_85000 AS
SELECT employee_id, first_name, last_name, salary
FROM employees
WHERE salary > 85000;

DROP USER IF EXISTS 'usuario_vistas'@'localhost';
CREATE USER 'usuario_vistas'@'localhost' IDENTIFIED BY 'UsuarioVistas_123';

GRANT SELECT ON employees.vw_empleados_salario_superior_85000
TO 'usuario_vistas'@'localhost';

FLUSH PRIVILEGES;

SELECT * FROM vw_empleados_salario_superior_85000;

/*2) Crea una vista que muestre los datos de la tabla 'titles' pero sólo de los empleados que siguen
trabajando actualmente.
Prueba a añadir, borrar o modificar alguno de los datos que obtiene dicha vista.
Modifica la vista para que verifique que los datos nuevos cumplan las condiciones de la vista.
Crea un usuario nuevo (o usa uno de los ya creados) y dale permisos para que pueda usar la vista
(seleccionar, modificar y borrar, pero no insertar). ¿Qué ocurre cuando dicho usuario intenta
actualizar algunos de los datos de la vista?*/
DROP VIEW IF EXISTS vw_empleados_actuales;

CREATE VIEW vw_empleados_actuales AS
SELECT employee_id, first_name, last_name, email, hire_date, salary, department_id
FROM employees
WITH CHECK OPTION;

SELECT * FROM vw_empleados_actuales;

UPDATE vw_empleados_actuales
SET salary = 50000
WHERE employee_id = 103;

DELETE FROM vw_empleados_actuales
WHERE employee_id = 107;

GRANT SELECT, UPDATE, DELETE
ON employees.vw_empleados_actuales
TO 'usuario_vistas'@'localhost';

FLUSH PRIVILEGES;

/*3) Crea una vista que muestre los datos de los empleados que pertenecen al 'staf'. Los datos a
mostrar son los que se encuentran en la tabla 'employees'.
Crea una vista, que haciendo uso de la vista anterior, muestre los nombres de los empleados y el
departamento en el que trabaja (su nombre).
¿Qué datos podrían ser actualizados/añadidos en la vista anterior?*/
DROP VIEW IF EXISTS vw_staff;

CREATE VIEW vw_staff AS
SELECT e.*
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE d.department_name = 'Administration';

DROP VIEW IF EXISTS vw_staff_nombre_departamento;

CREATE VIEW vw_staff_nombre_departamento AS
SELECT 
    v.employee_id,
    CONCAT(v.first_name, ' ', v.last_name) AS nombre_empleado,
    d.department_name
FROM vw_staff v
JOIN departments d ON v.department_id = d.department_id;

/*4) Crea una vista que muestre los empleados que hayan nacido entre 1950 y 1955 y haz que dicha
vista se ejecute con los permisos del usuario que la utilice.
Crea un usuario nuevo (o usa uno de los ya creados) y dale permisos para que pueda hacer todas
las operaciones sobre la vista.

*/

ALTER TABLE employees
ADD COLUMN birth_date DATE NULL;

DROP VIEW IF EXISTS vw_empleados_nacidos_1950_1955;

CREATE ALGORITHM = MERGE
SQL SECURITY INVOKER
VIEW vw_empleados_nacidos_1950_1955 AS
SELECT *
FROM employees
WHERE birth_date BETWEEN '1950-01-01' AND '1955-12-31';

DROP USER IF EXISTS 'usuario_invoker'@'localhost';
CREATE USER 'usuario_invoker'@'localhost' IDENTIFIED BY 'UsuarioInvoker_123';

GRANT SELECT, INSERT, UPDATE, DELETE
ON employees.vw_empleados_nacidos_1950_1955
TO 'usuario_invoker'@'localhost';

FLUSH PRIVILEGES;

