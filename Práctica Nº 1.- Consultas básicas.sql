-- Práctica Nº 1.- Consultas básicas.
USE jardineria;

-- Ej1 Obtener la ciudad y el teléfono de las oficinas de EEUU
SELECT ciudad, telefono FROM oficina WHERE pais = "EEUU";

-- Ej2 Obtener el cargo, nombre, apellidos e email del jefe de la empresa.
SELECT puesto, nombre, apellido1, apellido2, email FROM empleado WHERE codigo_jefe IS NULL;