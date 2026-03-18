/**********************************************************
*              EXAMEN BD TEMA 4 y 5 DAW (MODELO A)
**********************************************************/

-- Todos los ejercicios se realizarán sobre la base de datos jardinería

/* PARTE A – CONSULTAS */


USE jardineria;
-- 1) Muestra el nombre y el precio de venta de los productos cuyo precio sea mayor a 50.
SELECT nombre,precio_venta FROM producto WHERE precio_venta > 50;


-- 2) Muestra el nombre de los clientes que tengan límite de crédito superior a 20000. Ordena la consulta por nombre_cliente
SELECT nombre_cliente FROM cliente WHERE limite_credito > 20000 ORDER BY nombre_cliente;


-- 3) Muestra el número de pedidos realizados en cada estado.
SELECT COUNT(*), estado FROM pedido GROUP BY(estado);


-- 4) Muestra el nombre del cliente y la ciudad de su representante de ventas.

-- 5) Muestra los nombres de los clientes que han realizado algún pago superior a 5000.
SELECT nombre_cliente FROM cliente WHERE codigo_cliente IN (SELECT codigo_cliente FROM pago WHERE total > 5000);



/* PARTE B – DML */

-- 1) Inserta un nuevo pago para el cliente 10 por importe de 1500
-- con fecha actual y forma de pago "Transferencia".
INSERT INTO pago(codigo_cliente, forma_pago,id_transaccion, fecha_pago, total)
VALUES(10,"Transferencia", "ak-std-000027",  DATE(NOW()), 1500);

-- 2) Reduce en un 5% el precio de los productos cuyo precio sea mayor de 100.
SELECT * FROM producto;
UPDATE producto SET precio_venta = precio_venta * 0.95 WHERE precio_venta > 100;


-- 3) Elimina aquellos clientes que no hayan hecho ningún pedido en el año 2008
DELETE FROM pedido WHERE YEAR(fecha_pedido) != 2008; 


