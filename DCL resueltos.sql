/********************************************************************************************************* 
* Script: Base de datos Instituto
*  Se realiza el diseño físico de la base de datos Instituto a partir del diagrama del modelo relacional
*  del ejercicio de clase 2 "Instituto" del Tema 2a publicado en Moodle
**********************************************************************************************************/
-- Borra la base de datos Instituto si existe
DROP DATABASE IF EXISTS instituto;  

-- Crea la base de datos Instituto
CREATE DATABASE instituto;

-- Selecciona la base de datos con la que queremos trabajar
USE instituto;

-- Crea la tabla profesores
CREATE TABLE profesores (
 DNI CHAR(9) PRIMARY KEY,
 Nombre VARCHAR(40) NOT NULL,
 Direccion VARCHAR(50) NOT NULL,
 Telefono VARCHAR(15) NOT NULL
);

-- Crea la tabla modulos
CREATE TABLE modulos (
 Codigo VARCHAR(10) PRIMARY KEY,
 Nombre VARCHAR(40) NOT NULL,
 Curso VARCHAR(10) NOT NULL,
 DNI_profesor CHAR(9),
 CONSTRAINT dni_profesor_fk 
    FOREIGN KEY (DNI_profesor) REFERENCES profesores(DNI)
); 

-- Crea la tabla alumnos
CREATE TABLE alumnos (
 N_exp VARCHAR(10) PRIMARY KEY,
 Nombre VARCHAR(40) NOT NULL,
 Apellidos VARCHAR(50) NOT NULL,
 Fecha_Nac DATE NOT NULL,
 N_exp_delegado VARCHAR(10),
 Grupo VARCHAR(10) NOT NULL,
 FOREIGN KEY (N_exp_delegado) REFERENCES alumnos(N_exp)
);

-- Crea la tabla matriculaciones
CREATE TABLE matriculaciones (
  N_exp_alumno VARCHAR(10),
  Codigo_modulo VARCHAR(10),
  PRIMARY KEY(N_exp_alumno, Codigo_modulo),
  FOREIGN KEY (N_exp_alumno) REFERENCES alumnos(N_exp)
);

-- Elimina la clave foránea de la tabla modulos
ALTER TABLE modulos DROP FOREIGN KEY dni_profesor_fk;

-- Elimina la clave primaria de la tabla modulos
ALTER TABLE modulos DROP PRIMARY KEY;

-- Cambia el tipo de datos de la columna Codigo a INT(4) ZEROFILL
ALTER TABLE modulos MODIFY Codigo INT(4) ZEROFILL;

-- Vuelve a crear la PRIMARY KEY en la tabla modulos
ALTER TABLE modulos ADD PRIMARY KEY (Codigo);

-- Vuelve a crear la FOREIGN KEY DNI_profesor en la tabla modulos
ALTER TABLE modulos ADD CONSTRAINT dni_profesor_fk 
    FOREIGN KEY (DNI_profesor) REFERENCES profesores(DNI);

-- Modificamos la columna Codigo_modulo (FK) a INT(4) ZEROFILL para que coincida el tipo de datos de la FOREIGN KEY con la PRIMARY KEY.
ALTER TABLE matriculaciones 
MODIFY Codigo_modulo INT(4) ZEROFILL;

-- Crea la FOREIGN KEY Codigo_modulo en la tabla matriculaciones
ALTER TABLE matriculaciones 
ADD CONSTRAINT Codigo_modulo_fk
FOREIGN KEY (Codigo_modulo) REFERENCES modulos(Codigo);

-- Inserta dos filas en la tabla profesores
INSERT INTO profesores (DNI, Nombre, Direccion, Telefono) 
VALUES 
 ('27896123Z', 'Antonio Muñoz', 'Av. Carlos Haya', '951345678'),
 ('33496123A', 'Luis Salas', 'Av. Playamar', '952335699');

-- Inserta dos filas en la tabla modulos
INSERT INTO modulos (Codigo, Nombre, Curso, DNI_profesor)
VALUES
 (0001, 'Programación', '1º DAW', '27896123Z'),
 (0002, 'Bases de Datos', '1º DAW', '33496123A');

-- Inserta dos filas en la tabla alumnos
INSERT INTO alumnos (N_exp, Nombre, Apellidos, Fecha_Nac, N_exp_delegado, Grupo)
VALUES
 ('A001', 'María', 'García López', '2006-03-15', 'A001', '1A'),
 ('A002', 'Juan', 'Pérez Martín', '2005-11-02', 'A001', '1A');

-- Inserta dos filas en la tabla matriculaciones
INSERT INTO matriculaciones (N_exp_alumno, Codigo_modulo)
VALUES
 ('A001', 0001),
 ('A002', 0002);

-- Elimina al alumno cuyo nº de expediente es 'A001'. Si el alumno ya está matriculado no se podrá borrar porque la opción de la clave foránea en la tabla matriculaciones es RESTRICT
-- DELETE FROM alumnos WHERE N_exp = 'A001';

/********************************************************************************************************* 
* Script: Ejemplos_alter
* Se crea una base de datos que contiene una tabla llamada usuario.
* Sobre dicha tabla se aplican diferentes comandos ALTER TABLE
**********************************************************************************************************/

-- Se borra la base de datos ejemplos_alter si existe
DROP DATABASE IF EXISTS ejemplos_alter;

-- Se crea la base de datos ejemplos_alter
CREATE DATABASE ejemplos_alter;

-- Se selecciona la base de datos ejemplos_alter
USE ejemplos_alter;

-- Se crea la tabla usuario
CREATE TABLE usuario (
 id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, -- Se define una clave primaria autoincremental
 nombre_de_usuario VARCHAR(25),
 rol ENUM('Estudiante', 'Profesor') NOT NULL -- Se define un tipo enumerado en la columna rol donde solo se permitirán dos valores: 'Estudiante' y 'Profesor'
);

-- Se modifica el tipo de datos de la columna nombre_de_usuario de la tabla usuario por VARCHAR(50) NOT NULL
ALTER TABLE usuario MODIFY nombre_de_usuario VARCHAR(50) NOT NULL;

-- Se cambia el nombre de la columna nombre_de_usuario por nombre
ALTER TABLE usuario CHANGE nombre_de_usuario nombre VARCHAR(50) NOT NULL;

-- Se establece como valor por defecto en la columna rol de la tabla usuario a 'Profesor'
ALTER TABLE usuario ALTER rol SET DEFAULT 'Profesor';

-- Se elimina el valor por defecto de la columna rol
ALTER TABLE usuario ALTER rol DROP DEFAULT;

-- Se añade la columna fecha_nacimiento de tipo DATE en la tabla usuario
ALTER TABLE usuario ADD fecha_nacimiento DATE NOT NULL;

-- Se añade la columna apellido1 de la tabla usuario después de la columna nombre
ALTER TABLE usuario ADD apellido1 VARCHAR(50) AFTER nombre;

-- Se añade la columna apellido2 de la tabla usuario después de la columna apellido1
ALTER TABLE usuario ADD apellido2 VARCHAR(50) AFTER apellido1;

-- Insertamos filas en la tabla usuario
INSERT INTO usuario (nombre, fecha_nacimiento) VALUES ('Antonio', '1990-01-01');
INSERT INTO usuario (nombre, fecha_nacimiento) VALUES ('María José', '1980-05-01');

-- Mostramos las filas de la tabla usuario
SELECT * FROM usuario;

-- Eliminamos la columna fecha de nacimiento de la tabla usuario
ALTER TABLE usuario DROP fecha_nacimiento;

-- Muestra la estructura de la tabla usuario: columnas, tipos de datos, claves, valores por defecto, etc.
DESCRIBE usuario;

-- Muestra todas las tablas de la base de datos seleccionada
SHOW TABLES;

-- Muestra la sentencia CREATE que creó la tabla usuario
SHOW CREATE TABLE usuario;