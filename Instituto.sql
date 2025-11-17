
-- Borra la base de datos instituo si existeprofesores_alumnos
DROP DATABASE IF EXISTS Instituto;

-- Crea la base de datos Instituto
CREATE DATABASE Instituto;

-- Selecciono la base de datos "Instituto"
USE Instituto;

-- Crea la tabla Profesores
CREATE TABLE Profesores(
DNI CHAR(9) PRIMARY KEY ,
Nombre VARCHAR (40) NOT NULL,
Tlf VARCHAR (15) NOT NULL,
Direccion VARCHAR(50) NOT NULL
);

-- Crea la tabla Módulo
CREATE TABLE Modulo(
Codigo VARCHAR(10) PRIMARY KEY,
Nombre VARCHAR(40) NOT NULL,
Curso VARCHAR (10) NOT NULL,
DNI_Profesor CHAR(9) NOT NULL,
CONSTRAINT dni_profesor_fk
FOREIGN KEY (DNI_Profesor) REFERENCES Profesores(DNI)
);

-- Crea la tabla Alumno
CREATE TABLE Alumno (
Nº_Expediente VARCHAR (10) PRIMARY KEY,
Nombre VARCHAR (40) NOT NULL,
Apellidos VARCHAR (50) NOT NULL,
Fecha_Nacimiento DATE NOT NULL,
Nº_Expediente_Delegado VARCHAR (10),
Grupo VARCHAR (10) NOT NULL,
FOREIGN KEY (Nº_Expediente_Delegado) REFERENCES Alumno(Nº_Expediente)
ON DELETE CASCADE ON UPDATE CASCADE
);

-- Crea la tabla Matricula
CREATE TABLE Matricula(
Nº_Expediente VARCHAR(10), -- REFERENCES Modulo(Codigo), Añadiendo esto, se asigna la FOREIGN KEY.
Codigo VARCHAR (10), -- REFERENCES Alumno(Nº_Expediente), Añadiendo esto, se asigna la FOREIGN KEY.
PRIMARY KEY (Nº_Expediente, Codigo),
FOREIGN KEY (Nº_Expediente) REFERENCES Alumno(Nº_Expediente)
ON DELETE CASCADE ON UPDATE CASCADE
);

-- Elimina la clave foránea de la tabla modulos
ALTER TABLE Modulo DROP FOREIGN KEY DNI_Profesor_fk;

-- Elimina la clave primaria de la tabla modulos
ALTER TABLE Modulo DROP PRIMARY KEY;

-- Cambia el tipo de datos de la columna Codigo a INT (4) ZEROFILL
ALTER TABLE Modulo MODIFY Codigo INT(4) ZEROFILL;

-- Vuelve a crear la PRIMARY KEY en la tabla modulos
ALTER TABLE Modulo ADD PRIMARY KEY (Codigo);

-- Vuelve a crear la FOREIGN KEY DNI_Profesor en la tabla modulo
ALTER TABLE Modulo ADD CONSTRAINT DNI_Profesor_fk
FOREIGN KEY (DNI_Profesor) REFERENCES Profesores(DNI);

-- Modificamos la columna Codigo_modulo (FK) a INT (4) ZEROFILL para que coincida el tipo de datos
ALTER TABLE Matricula
MODIFY Codigo INT(4) ZEROFILL; -- ?

-- Crea la FOREIGN KEY Codigo en la tabla Matricula
ALTER TABLE Matricula
ADD CONSTRAINT Codigo_fk
FOREIGN KEY (Codigo) REFERENCES Modulo (Codigo);


-- Inserta dos filas en la tabla Profesores
INSERT INTO Profesores (DNI, Nombre, Direccion, Tlf)
VALUES
('25739063Q', 'Antonio Muñoz', 'Av. Carlos Haya', '953832934'),
('33894859Z', 'Luis Salas', 'Av. Playamar', '643928343');

-- Muestro las filas de la tabla Profesores
SELECT * FROM Profesores;

-- Inserta dos filas en la tabla Modulo

INSERT INTO Modulo (Codigo, Nombre, Curso, DNI_Profesor) 
VALUES
("485", "Programacion", '1º DAW', "33894859Z"),
("484", "Base de datos", '1º DAW', "25739063Q");

-- Muestro las filas de la tabla Modulo
SELECT * FROM Modulo;

-- Inserta dos filas en la tabla Alumno
INSERT INTO Alumno (Nº_Expediente, Nombre, Apellidos, Fecha_Nacimiento, Nº_Expediente_Delegado, Grupo)
VALUES
('A039','Cristian','González Mateo','2004-09-08','A039','1º DAW'),
('B485','Juan','Gomez Perez','2002-11-21','A039','1º DAW');

-- Muestro las filas de la tabla Alumno
SELECT * FROM Alumno;

-- Inserta dos filas en la tabla Matricula
INSERT INTO Matricula (Nº_Expediente, Codigo)
VALUES
('A039','485'),
('B485','485');

-- Muestro las filas de la tabla Matricula
SELECT * FROM Matricula;

-- Elimina una fila de la tabla Alumno
DELETE FROM Alumno WHERE Nº_Expediente = 'B485';

SELECT * FROM Alumno;





