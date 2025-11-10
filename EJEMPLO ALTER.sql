DROP DATABASE IF EXISTS ejemplos_alter;

CREATE DATABASE ejemplos_alter;

USE ejemplos_alter;

CREATE TABLE usuario (
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(25),
rol ENUM('Estudiante', 'Profesor') NOT NULL
);

DESCRIBE usuario;
SHOW TABLES;
SHOW CREATE TABLE usuario;

ALTER TABLE usuario MODIFY nombre VARCHAR (50) NOT NULL;

ALTER TABLE usuario CHANGE nombre usuario VARCHAR (50) NOT NULL;


ALTER TABLE usuario ALTER rol SET DEFAULT 'Profesor';
ALTER TABLE usuario ALTER rol DROP DEFAULT;
ALTER TABLE usuario ADD fecha_nacimiento DATE NOT NULL;

ALTER TABLE usuario ADD apellido1 VARCHAR(50) AFTER usuario;
ALTER TABLE usuario ADD apellido2 VARCHAR(50) AFTER apellido1;
ALTER TABLE usuario DROP fecha_nacimiento;

INSERT INTO usuario (usuario, fecha_nacimiento) VALUES('Antonio', '1990-01-01');
INSERT INTO usuario (usuario, fecha_nacimiento) VALUES('María', '1980-01-01');
Select * FROM usuario;