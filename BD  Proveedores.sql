DROP DATABASE IF EXISTS proveedores;
CREATE DATABASE proveedores CHARSET utf8mb4;
USE proveedores;

CREATE TABLE categoria (
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR (100) NOT NULL);

CREATE TABLE pieza (
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
color VARCHAR(50) NOT NULL,
precio DECIMAL(7,2) NOT NULL,
id_categoria INT UNSIGNED NOT NULL,
FOREIGN KEY (id_categoria) REFERENCES categoria(id)
ON DELETE CASCADE 
ON UPDATE CASCADE);

INSERT INTO categoria VALUES (1, 'Categoria A');
INSERT INTO categoria VALUES (2, 'Categoria B');
INSERT INTO categoria VALUES (3, 'Categoria C');

INSERT INTO pieza VALUES (1, 'Pieza 1', 'Blanco' , 25.90, 1);
INSERT INTO pieza VALUES (2, 'Pieza 2', 'Verde' , 32.95, 1);
INSERT INTO pieza VALUES (3, 'Pieza 3', 'Rojo' , 12.00, 2);
INSERT INTO pieza VALUES (4, 'Pieza 4', 'Azul' , 24.50, 2);

SELECT * FROM categoria;
SELECT * FROM pieza;

