-- Práctica Nº 1.- Consultas básicas.
USE jardineria;

-- Ej1 Obtener la ciudad y el teléfono de las oficinas de EEUU
SELECT ciudad, telefono FROM oficina WHERE pais = "EEUU";

-- Ej2 Obtener el cargo, nombre, apellidos e email del jefe de la empresa.
SELECT puesto, nombre, apellido1, apellido2, email FROM empleado WHERE codigo_jefe IS NULL;

-- Ej3. Obtener el nombre, apellidos y cargo de aquellos que no sean representante de ventas.
SELECT nombre, apellido1, apellido2, puesto
FROM empleado
WHERE puesto <> 'Representante Ventas';

-- Ej4. Obtener el número de clientes que tiene la empresa
SELECT COUNT(*) AS total_clientes
FROM cliente;

-- Ej5. Obtener el nombre de los clientes españoles.alter
SELECT nombre_cliente
FROM cliente
WHERE pais = 'Spain';

-- Ej6. Obtener cuántos clientes tiene la empresa en cada país.
SELECT pais, COUNT(*) AS total_clientes
FROM cliente
GROUP BY pais;

-- Ej7. Obtener cuántos clientes tiene la empresa en la ciudad de Madrid.
SELECT COUNT(*) AS total_clientes
FROM cliente
WHERE ciudad = 'Madrid';

-- Ej8. Obtener el código de empleado y el número de clientes al que atiende cada representante de ventas.
SELECT codigo_empleado_rep_ventas AS codigo_empleado,
       COUNT(*) AS total_clientes
FROM cliente
GROUP BY codigo_empleado_rep_ventas;

-- Ej9. Obtener cuál fue el primer y último pago que hizo el cliente cuyo código es el número 3.
SELECT 
  MIN(fecha_pago) AS primer_pago,
  MAX(fecha_pago) AS ultimo_pago
FROM pago
WHERE codigo_cliente = 3;

-- Ej10. Obtener el código de cliente de aquellos clientes que hicieron pagos en 2008.
SELECT DISTINCT codigo_cliente
FROM pago
WHERE YEAR(fecha_pago) = 2008;

-- Ej11. Obtener los distintos estados por los que puede pasar un pedido.
SELECT DISTINCT estado
FROM pedido;

-- Ej12. Obtener el número de pedido, código de cliente, fecha requerida y fecha de entrega de los pedidos que no han sido entregados a tiempo.
SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega
FROM pedido
WHERE fecha_entrega IS NOT NULL
AND fecha_entrega > fecha_esperada;

-- Ej13. Obtener cuántos productos existen en cada línea de pedido.
SELECT codigo_pedido, COUNT(*) AS total_productos
FROM detalle_pedido
GROUP BY codigo_pedido;

-- Ej14. Obtener un listado de los 20 códigos de productos más pedidos ordenado por cantidad pedida.
SELECT codigo_producto, SUM(cantidad) AS cantidad_total
FROM detalle_pedido
GROUP BY codigo_producto
ORDER BY cantidad_total DESC
LIMIT 20;

-- Ej15. Obtener el número de pedido, código de cliente, fecha requerida y fecha de 
-- entrega de los pedidos cuya fecha de entrega ha sido al menos dos días antes
-- de la fecha requerida. (Usar la función addDate)
SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega
FROM pedido
WHERE fecha_entrega <= ADDDATE(fecha_esperada, -2);

-- Ej16. Obtener el nombre, apellidos, oficina y cargo de aquellos que no sean
-- representantes de ventas.
SELECT e.nombre, e.apellido1, e.apellido2, o.ciudad, e.puesto
FROM empleado e
JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
WHERE e.puesto <> 'Representante Ventas';

-- Ej17. Obtener el número de clientes que tiene asignado cada representante de ventas.
SELECT codigo_empleado_rep_ventas AS codigo_empleado,
       COUNT(*) AS total_clientes
FROM cliente
GROUP BY codigo_empleado_rep_ventas;

-- Ej18. Obtener un listado con el precio total de cada pedido.
SELECT codigo_pedido,
       SUM(cantidad * precio_unidad) AS total_pedido
FROM detalle_pedido
GROUP BY codigo_pedido;

-- Ej19. Obtener cuántos pedidos tiene cada cliente en cada estado.
SELECT codigo_cliente, estado, COUNT(*) AS total_pedidos
FROM pedido
GROUP BY codigo_cliente, estado;

-- Ej20. Obtener una lista con el código de oficina, ciudad, región y país de aquellas
-- oficinas que estén en países que cuyo nombre empiece por “E”.
SELECT codigo_oficina, ciudad, region, pais
FROM oficina
WHERE pais LIKE 'E%';

-- Ej21. Obtener el nombre, gama, dimensiones, cantidad en stock y el precio de
-- venta de los cinco productos más caros.
SELECT nombre, gama, dimensiones, cantidad_en_stock, precio_venta
FROM producto
ORDER BY precio_venta DESC
LIMIT 5;

-- Ej22. Obtener el código y la facturación de aquellos pedidos mayores de 2000 euros.
SELECT codigo_pedido,
       SUM(cantidad * precio_unidad) AS facturacion
FROM detalle_pedido
GROUP BY codigo_pedido
HAVING facturacion > 2000;

-- Ej23. Obtener una lista de los productos mostrando el stock total, la gama y el proveedor.
SELECT nombre, cantidad_en_stock, gama, proveedor
FROM producto;

-- Ej24. Obtener el número de pedidos y código de cliente de aquellos pedidos cuya
-- fecha de pedido sea igual a la de la fecha de entrega.
SELECT codigo_pedido, codigo_cliente
FROM pedido
WHERE fecha_pedido = fecha_entrega;

