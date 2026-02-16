DROP DATABASE IF EXISTS biblioteca_municipal;
CREATE DATABASE IF NOT EXISTS biblioteca_municipal;

USE biblioteca_municipal;

-- Parte A

-- 1 Creación de tabla socios
DROP TABLE IF EXISTS socios;

CREATE TABLE IF NOT EXISTS socios(
id_socio INT auto_increment,
dni CHAR(9) NOT NULL UNIQUE,
nombre VARCHAR(40) NOT NULL,
apellidos VARCHAR(60) NOT NULL,
telefono VARCHAR(20), -- Varchar ya que asumo que puede ser un numero de telefono no español.
email VARCHAR(60),
fecha_alta DATE NOT NULL,
PRIMARY KEY(id_socio)
);

DESCRIBE socios;

-- 1.5 Correo electronico no repetible
ALTER TABLE socios MODIFY email VARCHAR(60) UNIQUE;

-- 2 Tabla libros
DROP TABLE IF EXISTS libros;

CREATE TABLE IF NOT EXISTS libros(
id_libro INT,
isbn VARCHAR(50) NOT NULL UNIQUE,
titulo VARCHAR(50) NOT NULL,
autor VARCHAR(50) NOT NULL,
anio_publicacion INT CHECK (anio_publicacion > 1900 AND anio_publicacion < 2100),
ejemplares_disponibles INT CHECK (ejemplares_disponibles >= 0),
PRIMARY KEY(id_libro)
);

DESCRIBE libros;

-- Modificacion de la clave primaria 
ALTER TABLE libros DROP PRIMARY KEY;
ALTER TABLE libros MODIFY COLUMN id_libro CHAR(6);
ALTER TABLE libros ADD PRIMARY KEY (id_libro);

DESCRIBE libros;

-- 3 Tabla prestamos
DROP TABLE IF EXISTS prestamos;

CREATE TABLE prestamos(
id_prestamo INT auto_increment,
id_socio INT,
id_libro CHAR(6),
fecha_prestamo DATE NOT NULL,
fecha_devolucion DATE,
PRIMARY KEY(id_prestamo),
FOREIGN KEY(id_libro) references libros(id_libro),
UNIQUE(id_socio, id_prestamo)
);

DESCRIBE prestamos;

-- Modificacion de clave foranea
ALTER TABLE prestamos
ADD CONSTRAINT fk_id_socio
FOREIGN KEY (id_socio) REFERENCES socios(id_socio);

DESCRIBE prestamos;

-- PARTE B Gestion de usuarios y roles

-- 1 
CREATE USER 'biblioteca_app'@'localhost' IDENTIFIED BY 'LibPss#2026';

-- 2
CREATE ROLE 'rol_consulta';
GRANT SELECT ON biblioteca_municipal.* TO 'rol_consulta';

-- 3
CREATE ROLE 'rol_operaciones';
GRANT INSERT, UPDATE, DELETE ON biblioteca_muncipal.* TO 'rol_operaciones';

-- 4
GRANT 'rol_operaciones' TO 'biblioteca_app'@'localhost';
GRANT 'rol_consulta' TO 'biblioteca_app'@'localhost';
SET DEFAULT ROLE 'rol_consulta' TO 'biblioteca_app'@'localhost';

FLUSH PRIVILEGES;

SHOW GRANTS FOR 'biblioteca_app'@'localhost';


 