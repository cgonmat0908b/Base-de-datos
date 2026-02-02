-- Ejercicios del DML
DROP DATABASE prueba_DML;

CREATE DATABASE IF NOT EXISTS prueba_DML;

USE prueba_DML;

-- Tabla usuarios

CREATE TABLE IF NOT EXISTS usuarios (
id int PRIMARY KEY,
dni CHAR(9),
nombre VARCHAR(20),
apellidos VARCHAR(20),
email VARCHAR(20),
ciudad VARCHAR(20),
fecha_nacimiento DATE,
descuento numeric(3,2),
fecha_alta DATE);

-- Insert de un usuarios

INSERT INTO usuarios (id, dni, nombre, apellidos, email, ciudad, descuento,
fecha_nacimiento, fecha_alta)
VALUES (101, '12345678A', 'Antonio', 'Garcia', 'agarcia@gmail.com', 'Malaga', 
0.25, '1990-12-12', '2020-12-04');

-- Insert de 2 usuarios omitiendo fecha_nacimieto

INSERT INTO usuarios (id, dni, nombre, apellidos, email, ciudad, descuento,
fecha_alta)
VALUES (300, '12345678A', 'Pepe', 'Sanz', 'psanz@gmail.com', 'Malaga', 0.25, '1990-12-12'),
(301, '98765432Z', 'Luis', 'Perez', 'lperez@gmail.com', 'Malaga', 0.25, '1988-01-03');

-- Mostramos las filas de la tabla usuarios
SELECT * FROM usuarios;

-- Creamos una tabla llamada otros_usuarios exactamente igual a la tabla usuarios
CREATE TABLE otros_usuarios LIKE usuarios;

-- Mostramos las filas de la tabla otros_usuarios
SELECT * FROM otros_usuarios;

-- Insertamos en la tabla otros_usuarios, que esta vacia, las filas devueltas por la instruccion SELECT No introducimos ni ciudad ni fecha_nacimiento
INSERT INTO otros_usuarios (id, dni, nombre, apellidos, email, descuento, fecha_alta)
SELECT id, dni, nombre, apellidos, email, descuento, fecha_alta
FROM usuarios;

-- Mostramos las filas de la tabla otros_usuarios
SELECT * FROM otros_usuarios;

-- Cambiamos la ciudad al usuario con id = 100
UPDATE usuarios SET ciudad='Madrid' WHERE id=101;

-- Cambiamos la ciudad a Madrid al usuario cuyo nombre es Pepe y Apellido Sanz
UPDATE usuarios SET ciudad= 'Madrid' WHERE nombre='Pepe' AND apellidos='Sanz';

-- Cambiamos la ciudad de todos los usuarios a Malaga
UPDATE usuarios SET ciudad='Malaga';

DELETE FROM usuarios WHERE nombre = 'Pepe';