
-- Borra la base de datos Tienda De Moviles si existe
DROP DATABASE IF EXISTS Tienda_De_Moviles;

-- Crea la base de datos Instituto
CREATE DATABASE Tienda_De_Moviles;

-- Selecciono la base de datos "Instituto"
USE Tienda_De_Moviles;

-- Crea la tabla Empleados
CREATE TABLE Empleados(
DNI CHAR(9) PRIMARY KEY ,
Nombre VARCHAR (40) NOT NULL,
Apellidos VARCHAR (40) NOT NULL,
Fecha_alta DATE  NOT NULL,
Cuenta_ban VARCHAR(40) NOT NULL
);

-- Crea la tabla Clientes
CREATE TABLE Clientes(
DNI CHAR(9) PRIMARY KEY ,
Nombre VARCHAR (40) NOT NULL,
Apellidos VARCHAR (40) NOT NULL,
Tarjeta_credito VARCHAR(25) NOT NULL
);

-- Crea la tabla Ventas
CREATE TABLE Ventas(
Cod_venta VARCHAR(8) NOT NULL,
Fecha DATETIME NOT NULL ,
DNI_empleado CHAR(9) NOT NULL,
DNI_cliente CHAR(9) NOT NULL,
PRIMARY KEY (Cod_venta),
FOREIGN KEY (DNI_empleado) REFERENCES Empleados(DNI),
FOREIGN KEY (DNI_cliente) REFERENCES Clientes(DNI)
);

 -- Este script solo se ejecuta en el caso de que se requiera que la clave primaria este compuesta por Fecha y DNI_cliente
 /*
ALTER TABLE Ventas
DROP PRIMARY KEY;

ALTER TABLE Ventas
ADD PRIMARY KEY(Fecha,DNI_cliente);
 -- Fin de script
 */
 
 -- A la hora de crear Moviles_ventas tambien se ha de cambiar la tabla y quedaria así:
 /*
 CREATE TABLE Moviles_ventas(
Cod_movil VARCHAR(8) NOT NULL,
Fecha DATETIME NOT NULL,
DNI_cliente CHAR(9) NOT NULL,
Color VARCHAR (15) NOT NULL,
PRIMARY KEY (Cod_movil, Fecha, DNI_cliente),
FOREIGN KEY (Cod_movil) REFERENCES Moviles(Cod_movil),
FOREIGN KEY (Fecha, DNI_cliente) REFERENCES Ventas(Fecha, DNI_cliente)
);
 */

-- Crea la tabla Moviles
CREATE TABLE Moviles(
Cod_movil VARCHAR(8) PRIMARY KEY NOT NULL,
Fabricante VARCHAR(20) NOT NULL,
Marca VARCHAR (20) NOT NULL,
Modelo VARCHAR (20) NOT NULL,
Precio_coste DECIMAL(6,2) NOT NULL,
Precio_venta DECIMAL(6,2) NOT NULL
);

-- Crea la tabla Moviles_ventas
CREATE TABLE Moviles_ventas(
Cod_movil VARCHAR(8) NOT NULL,
Cod_venta VARCHAR(8) NOT NULL,
Color VARCHAR (15) NOT NULL,
PRIMARY KEY (Cod_movil, Cod_venta),
FOREIGN KEY (Cod_movil) REFERENCES Moviles(Cod_movil),
FOREIGN KEY (Cod_venta) REFERENCES Ventas (Cod_venta) 
);

-- Inserta dos filas en la tabla Empleados
INSERT INTO Empleados(DNI,Nombre,Apellidos,Fecha_alta,Cuenta_ban)
VALUES
('73485934Z','Juan','Gimenez Redondo','2024-07-21','ES12 1234 1234 12 1234567890'),
('65473827A','Marco','Sanchez Torres','2020-01-30','ES23 3214 8549 45 9430567120');

-- Muestra la tabla Empleados
SELECT * FROM Empleados;

-- Inserta dos filas en la tabla Clientes
INSERT INTO Clientes(DNI,Nombre,Apellidos,Tarjeta_credito)
VALUES
('52373827A','Francisco','Franco Carabalí','7849 2015 3467 1182'),
('35473827B','Alberto','Delgado Alto','5449 2345 1267 1156');

-- Muestra la tabla Clientes
SELECT * FROM Clientes;

-- Inserta dos filas en la tabla Moviles
INSERT INTO Moviles(Cod_movil,Fabricante,Marca,Modelo,Precio_coste,Precio_venta)
VALUES
('54','Apple','Apple','Iphone 15','300.99','709.99'),
('34','Samsung','Samsung','Samsung galaxy S25','250.00','699.00');

-- Muestra la tabla Moviles
SELECT * FROM Moviles;

-- Inserta dos filas en la tabla Ventas
INSERT INTO Ventas(Cod_venta,Fecha,DNI_empleado,DNI_cliente)
VALUES
('32','2025-11-17 15:34','73485934Z','52373827A'),
('63','2025-09-21 18:47','65473827A','35473827B');

-- Muestra la tabla Ventas
SELECT * FROM Ventas;

-- Inserta dos filas en la tabla Moviles_ventas
INSERT INTO Moviles_ventas(Cod_movil, Cod_venta,Color)
VALUES
('54','32','Blanco'),
('34','63','Azul');

-- Muestra la tabla Moviles_ventas
SELECT * FROM Moviles_ventas;