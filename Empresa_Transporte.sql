DROP DATABASE IF EXISTS empresa_transporte;

CREATE DATABASE empresa_transporte;

USE empresa_transporte;

CREATE TABLE Camioneros(
DNI CHAR(9) PRIMARY KEY ,
Nombre VARCHAR (20),
Tlf INT,
Direccion VARCHAR(30),
Salario DOUBLE,
Poblacion VARCHAR(30)
);

CREATE TABLE Provincias(
Codigo INT PRIMARY KEY ,
Descripcion VARCHAR(30),
Destinatario VARCHAR(30),
Direccion VARCHAR(30)
);

CREATE TABLE Camiones (
Matricula CHAR (7)  PRIMARY KEY,
Modelo VARCHAR (20),
Tipo VARCHAR (20),
Potencia INT
);

CREATE TABLE Paquetes(
Codigo INT AUTO_INCREMENT PRIMARY KEY,
DNI_camioneros CHAR(9),
Codigo_provincia INT,
Descripcion VARCHAR(20),
Destinatario VARCHAR(20),
Direccion VARCHAR(20),
FOREIGN KEY (DNI_camioneros)  REFERENCES Camioneros(DNI),
FOREIGN KEY (Codigo_provincia) REFERENCES Provincias(Codigo)
);

CREATE TABLE Conduce(
Fecha DATE,
Matricula CHAR(7),
DNI_camionero CHAR(9),
PRIMARY KEY (Fecha),
FOREIGN KEY (Matricula) REFERENCES Camiones(Matricula),
FOREIGN KEY (DNI_camionero) REFERENCES Camioneros(DNI)
);

DESCRIBE Camioneros;
DESCRIBE Provincias;
DESCRIBE Camiones;
DESCRIBE Paquetes;
DESCRIBE Conduce;
