
-- Parte A Diseño Físico de bases de datos
CREATE DATABASE IF NOT EXISTS plataforma_proyectos;
-- CHARACTER SET COLLATE

-- 1 Tabla desarroladores
USE plataforma_proyectos;
CREATE TABLE IF NOT EXISTS desarrolladores(
id_desarrollador INT UNSIGNED auto_increment PRIMARY KEY,
usuario VARCHAR(30) NOT NULL UNIQUE,
email VARCHAR(50) NOT NULL UNIQUE,
fecha_registro DATE NOT NULL,
nivel_experiencia ENUM('Junior','Mid','Senior') NOT NULL
);
DESCRIBE desarrolladores;

-- 2 Tabla Proyectos
USE plataforma_proyectos;
CREATE TABLE IF NOT EXISTS proyectos(
id_proyecto INT UNSIGNED auto_increment PRIMARY KEY,
nombre VARCHAR(20) NOT NULL,
descripcion VARCHAR(200),
fecha_inicio DATE NOT NULL,
fecha_fin DATE,
estado ENUM('Planificado', 'En desarrollo', 'Finalizado') NOT NULL
);
DESCRIBE proyectos;

-- 3 Tabla asignaciones
USE plataforma_proyectos;
CREATE TABLE IF NOT EXISTS asignaciones(
id_asignacion INT UNSIGNED auto_increment PRIMARY KEY,
id_desarrollador INT,
id_proyecto INT,
rol VARCHAR(40) NOT NULL,
fecha_asignacion DATE NOT NULL,
FOREIGN KEY (id_desarrollador) REFERENCES desarrolladores(id_desarrollador),
FOREIGN KEY (id_proyecto) REFERENCES proyectos(id_proyecto),
UNIQUE (id_desarrollador, id_proyecto)
);
DESCRIBE asignaciones;

-- Parte B Gestión de usuarios y roles

-- 1
CREATE USER IF NOT EXISTS'proyectos_app' @'localhost' 
IDENTIFIED BY 'DevPass$2026';

-- 2
CREATE ROLE 'lectura';
GRANT SELECT ON plataforma_proyectos.* TO 'lectura';

-- 3 
CREATE ROLE 'rol_edicion';
GRANT INSERT, UPDATE ON plataforma_proyectos.* TO 'rol_edicion';

-- 4 
GRANT 'lectura', 'rol_edicion' TO 'proyectos_app'@'localhost';
SET DEFAULT ROLE 'lectura' TO 'proyectos_app'@'localhost';

-- 5 
SELECT USER,HOST FROM mysql.user;
DROP USER 'proyectos_app'@'localhost';
DROP ROLE 'lectura';
DROP ROLE 'rol_edicion';
