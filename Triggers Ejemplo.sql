

-- Se crea una base de datos

CREATE DATABASE prueba;

USE prueba;

CREATE TABLE account(
	acct_num int,
    amount DECIMAL(10,2)
);

-- Se crea un trigger que devuelve la suma total de cantidad (amount);

CREATE TRIGGER ins_sum BEFORE INSERT ON account
FOR EACH ROW
SET @sum = @sum + NEW.amount;


set @sum = 0;

INSERT INTO account VALUES
	(137,2500.56),
	(139, 2100.00),
	(140, 100.00);
    
SELECT @sum;

-- Muestra los triggers de la base de datos prueba
SHOW TRIGGERS FROM prueba;

-- Muestra los datos del trigger ins_sum
SHOW CREATE TRIGGER ins_sum;

SHOW TRIGGERS WHERE 'Definer' LIKE 'root%';

--  CREAMOS TABLA usuario 
CREATE TABLE usuario(
	id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(20)
);

-- Creamos la tabla logs_usuarios
CREATE TABLE logs_usuarios(
	id INT AUTO_INCREMENT PRIMARY KEY,
	mensaje VARCHAR(255),
    fecha DATETIME
);

-- Creamos un trigger para registrar en al tabla logs_usuarios, 
-- los usuarios que fueron dados de alta en la tabla de usuarios

DELIMITER €€

CREATE TRIGGER tras_insertar_usuario
AFTER INSERT ON usuario
FOR EACH ROW
BEGIN
	INSERT INTO logs_usuarios(mensaje,fecha)
    VALUES (CONCAT('Nuevo usuario credo: ' , NEW.nombre), NOW());
END €€

-- Insertar usuario
INSERT INTO usuario(nombre) VALUES ('Alejandro');

-- Comprobar funcionamiento de trigger
SELECT * FROM logs_usuarios;


-- Creamos la tabla productos
CREATE TABLE producto(
	id INT AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR(100),
    stock INT
);
 
-- Crear Trigger para validar la cantidad en stock que debe ser 0 o positiva de un producto ya existente
DELIMITER €€
CREATE TRIGGER validacion
BEFORE UPDATE ON producto
FOR EACH ROW
BEGIN

	IF NEW.stock < 0 THEN
		SET NEW.stock = 0;
	END IF;
    
END€€

-- Insertamos un valor negativo en stock
INSERT INTO producto(nombre,stock) VALUES('Zapatilla', -50);
INSERT INTO producto(nombre,stock) VALUES('Pc', 10);

-- Revisamos los valores
SELECT * FROM producto;

-- Actualizamos la tabla y comprobamos
UPDATE producto SET stock = -10 WHERE stock = -50;
SELECT * FROM producto;

-- El valor del stock pasa de ser negativo a 0 debido al Trigger previamente creado


-- Creamos un trigger que se activara cuando se realice una actualización
-- sobre la tabla productos y se modifique el stock a un valor negativo,
-- en este caso mostrará un mensaje indicando el error y se cancelará
-- la operación.
DROP TRIGGER validacion;

DELIMITER €€

CREATE TRIGGER cancelarStockNegativo
BEFORE UPDATE ON producto
FOR EACH ROW
BEGIN	
	IF NEW.stock < 0 THEN
		 SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Valor negativo, no valido, abortando UPDATE.';
	END IF;
    
END €€

-- Datos antes del trigger:
SELECT * FROM producto;

-- Comprobación del trigger
UPDATE producto SET stock = -10 WHERE stock = 0; 



-- Otro ejercicio.

-- Creamos la base de datos y la seleccionamos
CREATE DATABASE IF NOT EXISTS empresa_db;
USE empresa_db;

-- Funciones Utiles
SELECT CHAR_LENGTH('Esto es SQL');
SELECT UPPER('Esto es SQL');
SELECT LOWER('Esto es SQL');

-- Devuelve los caracteres empezando de derecha a izquierda 
SELECT RIGHT('Esto es SQL', 3);
SELECT LEFT('Esto es SQL', 4);


-- Creamos la tabla empleados
CREATE TABLE IF NOT EXISTS empleados(
	id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    dni CHAR(9)
);

-- Creamos un trigger para comprobar si el DNI tiene el formato correcto,
-- es decir,9 caracteres de longituD y el último caracter es una letra.
-- El trigger se ejecutará antes de una inserción o actualización sobre la 
-- tabla empleados

-- Trigger BEFORE INSERT
DELIMITER €€

CREATE TRIGGER dniCorrectoInsert
BEFORE INSERT ON empleados
FOR EACH ROW

BEGIN

	IF LENGTH(NEW.dni) != 9 OR RIGHT(NEW.dni, 1) NOT BETWEEN 'A' AND 'Z'
    THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El dni no es correcto.';
    END IF;

END €€


-- Trigger BEFORE UPDATE
DELIMITER €€

CREATE TRIGGER dniCorrectoUpdate
BEFORE UPDATE ON empleados
FOR EACH ROW

BEGIN

	IF LENGTH(NEW.dni) != 9 OR RIGHT(NEW.dni, 1) NOT BETWEEN 'A' AND 'Z'
    THEN 
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El dni no es correcto.';
    END IF;

END €€

-- 1 insert correcto y uno incorrecto
INSERT INTO empleados(nombre, dni) 
VALUES('Paco', '26548930Z'), ('Juan', '8547344b');

-- Update con dni incorrecto
UPDATE empleados SET dni = '2535343z' WHERE dni = '26548930Z';
SELECT * FROM empleados;

