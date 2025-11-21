-- Borra la base de datos Tienda De Moviles si existe
DROP DATABASE IF EXISTS Cadena_Editorial;

-- Crea la base de datos Tienda_De_Moviles
CREATE DATABASE Cadena_Editorial;

-- Selecciono la base de datos Tienda_De_Moviles
USE Cadena_Editorial;

CREATE TABLE Sucursal(
Codigo VARCHAR(10) NOT NULL PRIMARY KEY,
Domicilio VARCHAR(40)NOT NULL,
Tlf INT (9) NOT NULL
);

CREATE TABLE Periodista(
NIF CHAR(9) NOT NULL PRIMARY KEY,
Nombre VARCHAR(30) NOT NULL,
Apellidos VARCHAR(30) NOT NULL,
Tlf INT (9) NOT NULL,
Especialidad VARCHAR(20)
);

CREATE TABLE Revistas(
NºRegistro INT (10) AUTO_INCREMENT NOT NULL PRIMARY KEY,
Periocidad VARCHAR (20) NOT NULL,
Tipo VARCHAR (20) NOT NULL
);

CREATE TABLE Empleados(
NIF CHAR(9) NOT NULL PRIMARY KEY,
Nombre VARCHAR(30) NOT NULL,
Apellidos VARCHAR(30) NOT NULL,
Tlf INT (9) NOT NULL,
Codigo_Sucursal VARCHAR(10), 
FOREIGN KEY (Codigo_Sucursal) REFERENCES Sucursal(Codigo)
);

CREATE TABLE Publican(
Codigo_Sucursal VARCHAR(10), 
NºRegistro INT (10),
PRIMARY KEY (Codigo_Sucursal,NºRegistro),
FOREIGN KEY (Codigo_Sucursal) REFERENCES Sucursal(Codigo),
FOREIGN KEY (NºRegistro) REFERENCES Revistas(NºRegistro)
);

CREATE TABLE Escriben(
NºRegistro INT (10),
NIF CHAR(9),
PRIMARY KEY (NºRegistro, NIF),
FOREIGN KEY (NºRegistro) REFERENCES Revistas(NºRegistro),
FOREIGN KEY (NIF) REFERENCES Periodista(NIF)
);

CREATE TABLE Ejemplares(
Fecha DATE NOT NULL,
NºRegistro INT (10),
NºPaginas INT (5),
NºEjemplares INT(6),
PRIMARY KEY (Fecha, NºRegistro),
FOREIGN KEY (NºRegistro) REFERENCES Revistas(NºRegistro)
);

CREATE TABLE Secciones(
Titulo VARCHAR(30) NOT NULL,
NºRegistro INT (10),
Extension VARCHAR (30),
PRIMARY KEY (Titulo, NºRegistro),
FOREIGN KEY (NºRegistro) REFERENCES Revistas(NºRegistro)
);

SELECT * FROM Sucursal;
SELECT * FROM Periodista;
SELECT * FROM Revistas;
SELECT * FROM Empleados;
SELECT * FROM Publican;
SELECT * FROM Escriben;
SELECT * FROM Ejemplares;
SELECT * FROM  Secciones;
