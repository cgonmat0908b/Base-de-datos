/**********************************************************
*             EXAMEN BD TEMA 4 y 5 (SIMULACRO)
**********************************************************

-- Todos los ejercicios se realizarán sobre la base de datos jardinería 

/* PARTE A – Tema 4.- REALIZACIÓN DE CONSULTAS */
USE jardineria;

SELECT * FROM empleado;
-- 1) Selecciona a aquellos empleados que sean directores de oficinas cuyos códigos terminen en "USA"
SELECT * FROM empleado WHERE puesto = "Director Oficina" AND codigo_oficina LIKE "%-USA";

-- 2) Selecciona a aquellos clientes que residan en España. Ordena la consulta por el nombre del cliente ascendentemente.
SELECT * FROM cliente WHERE pais = "España" ORDER BY nombre_cliente ASC;

-- 3) Muestra la media de la cantidad en stock de cada gama de productos. Ordena la consulta por la media de la cantidad en stock descendentemente.
SELECT AVG(cantidad_en_stock) Media, gama FROM producto GROUP BY gama ORDER BY Media DESC;


-- 4) Selecciona aquellos empleados que tengan como jefe a Ruben López.
SELECT * FROM empleado WHERE codigo_jefe = (SELECT codigo_empleado FROM empleado WHERE nombre = "Ruben" AND apellido1 = "López"); 

-- 5) Muestra los códigos de los clientes cuyas cantidades pagadas en cada una de sus transacciones
-- estén por encima de la media.

SELECT codigo_cliente FROM pago GROUP BY codigo_cliente
HAVING MIN(total) > (SELECT AVG(total) FROM pago);

/* PARTE B – Tema 5.- TRATAMIENTO DE DATOS (DML) */

-- 1) Inserta un nuevo cliente (usa datos ficticios).
-- Inserta solo los datos que sean obligatorios

INSERT INTO cliente(codigo_cliente, nombre_cliente,telefono, fax, linea_direccion1,ciudad)
VALUES(39,"Paco", "643181272", "ABCDE", "Calle Lapislazuli", "Malaga");

SELECT * FROM cliente WHERE codigo_cliente = 39;

-- 2) Incrementa en un 10% el precio de venta de los productos cuyo precio esté por debajo de 20
SELECT * FROM producto WHERE precio_venta < 20;
UPDATE producto SET precio_venta = precio_venta * 1.10 WHERE precio_venta < 20;

-- 3) Elimina los clientes que sean de Madrid y Barcelona
SELECT * FROM cliente WHERE ciudad = "Madrid" OR ciudad = "Barcelona";
DELETE FROM cliente WHERE ciudad = "Madrid" OR ciudad = "Barcelona";


