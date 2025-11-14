
-- Borra la base de datos instituo si existeprofesores_alumnos
DROP DATABASE IF EXISTS Instituto;

-- Crea la base de datos
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
CREATE TABLE Módulo(
Codigo VARCHAR(10) PRIMARY KEY,
Nombre VARCHAR(30) NOT NULL,
Curso VARCHAR (10) NOT NULL,
DNI_Profesor CHAR(9) NOT NULL,
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
);

-- Crea la tabla Matricula
CREATE TABLE Matricula(
Nº_Expediente VARCHAR(10), -- REFERENCES Módulo(Codigo), Añadiendo esto, se asigna la FOREIGN KEY.
Codigo VARCHAR (10), -- REFERENCES Alumno(Nº_Expediente), Añadiendo esto, se asigna la FOREIGN KEY.
FOREIGN KEY (Codigo) REFERENCES Módulo(Codigo),
FOREIGN KEY (Nº_Expediente) REFERENCES Alumno(Nº_Expediente),
PRIMARY KEY (Nº_Expediente, Codigo)
);

-- Insertar filas en la tabla profesores

INSERT INTO Profesores (DNI, Nombre, Direccion, Tlf) 
VALUES ("25639043Z","Antonio Muñoz", "Av. Carlos Haya", " 953355742");

INSERT INTO Profesores (DNI, Nombre, Direccion, Tlf) 
VALUES ("33456043Z","Luis Salas", "Av. Playamar", " 653355742");

-- Modifico la clave primary Codigo de la tabla Módulo
ALTER TABLE Módulo MODIFY Codigo INT; -- ??

DESCRIBE  Módulo;
-- Inserto en la tabla Módulo, en las filas x x x x, los valores x x x x.
INSERT INTO Módulo (Codigo, Nombre, Curso, DNI_Profesor) 
VALUES ("0484", "Base de datos", 'Av. Carlos Haya', "953355742");

