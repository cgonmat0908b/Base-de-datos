USE jardineria;

-- 1) Selecciona aquellos clientes que hayan hecho algún pedido a partir de 2008.
SELECT * FROM cliente  
WHERE codigo_cliente = ANY(SELECT codigo_cliente FROM pedido WHERE YEAR(fecha_pedido) > 2008);

-- 2) Selecciona aquellos clientes que hayan hecho pedidos que contengan algún producto con una cantidad
-- menor a 10 unidades.
SELECT * FROM cliente  
WHERE codigo_cliente = ANY(SELECT codigo_cliente FROM pedido WHERE codigo_pedido = ANY(SELECT codigo_pedido FROM detalle_pedido WHERE cantidad < 10));

-- 3) Selecciona aquellos empleados que trabajen en la oficina de Madrid.
SELECT * FROM empleado
WHERE codigo_oficina = ANY (SELECT codigo_oficina FROM oficina WHERE ciudad = 'MADRID');

-- 4) Selecciona aquellos clientes que hayan efectuado pagos con PayPal.
SELECT * FROM cliente
WHERE codigo_cliente = ANY
(SELECT codigo_cliente FROM pago WHERE forma_pago = 'PayPal');

-- 5) Selecciona aquellos clientes que hayan efectuado pagos que no sea con PayPal.
SELECT * FROM cliente
WHERE codigo_cliente = ANY
(SELECT codigo_cliente FROM pago WHERE forma_pago != 'PayPal');

-- 6) Selecciona aquellos empleados que sean jefes.
SELECT * FROM empleado WHERE codigo_empleado 
IN (SELECT DISTINCT codigo_jefe FROM empleado);

-- 7) Selecciona aquellos empleados que no sean jefes.
SELECT * FROM empleado 
WHERE codigo_empleado
NOT IN (SELECT DISTINCT codigo_jefe FROM empleado WHERE codigo_jefe IS NOT NULL);

-- 8) Selecciona todos los empleados que sean jefes en España.
SELECT * FROM empleado
WHERE codigo_empleado = ANY
(SELECT codigo_jefe FROM empleado WHERE codigo_oficina = ANY
(SELECT codigo_oficina FROM oficina WHERE pais = 'España'));

-- 9) Selecciona aquellos clientes cuyo límite de crédito sea superior, al menos, al de algunos de los clientes
-- de su mismo país.
SELECT * FROM cliente C1 
WHERE C1.limite_credito > ANY
(SELECT C2.limite_credito FROM cliente C2 WHERE C1.pais = C2.pais);

-- 10) Selecciona aquellos clientes que hayan hecho, al menos, 5 pedidos durante el año 2009.
SELECT *
FROM cliente
WHERE codigo_cliente IN (
    SELECT codigo_cliente
    FROM pedido
    WHERE YEAR(fecha_pedido) = 2009
    GROUP BY codigo_cliente
    HAVING COUNT(*) >= 5
);


-- 11) Mostrar aquellos empleados que sean representantes de ventas de algún cliente de Madrid.
SELECT * FROM empleado
WHERE codigo_empleado IN
(SELECT codigo_empleado_rep_ventas FROM cliente WHERE ciudad = 'Madrid');

-- 12) Mostrar aquellos clientes que tengan algún pedido pendiente.
SELECT * FROM cliente 
WHERE codigo_cliente IN
(SELECT codigo_cliente FROM pedido WHERE estado = 'pendiente');

-- 13) Mostrar aquellos clientes que tengan algún pedido rechazado desde 2006.
SELECT * FROM cliente 
WHERE codigo_cliente IN
(SELECT codigo_cliente FROM pedido WHERE estado = 'rechazado' AND YEAR(fecha_pedido) >= 2006);

-- 14) Mostrar aquellos pedidos que tengan al menos 6 productos distintos.
SELECT * FROM pedido 
WHERE codigo_pedido in
(SELECT codigo_pedido FROM detalle_pedido 
GROUP BY codigo_pedido
HAVING COUNT(DISTINCT codigo_producto) >= 6);

-- 15) Mostrar aquellos clientes cuyos representantes de ventas alguno tenga su oficina en España.
SELECT * FROM cliente
WHERE codigo_empleado_rep_ventas IN
(SELECT codigo_empleado FROM empleado WHERE codigo_oficina IN
(SELECT codigo_oficina FROM oficina WHERE pais = 'España'));

-- 16) Mostrar aquellos empleados que no tengan como jefe a Carlos Soria.
SELECT * FROM empleado
WHERE codigo_jefe NOT IN
(SELECT codigo_jefe FROM empleado WHERE nombre = 'Carlos' AND (apellido1 = 'Soria' OR apellido2 = 'Soria'));
-- Otra manera
SELECT *
FROM empleado
WHERE codigo_jefe NOT IN (
    SELECT codigo_empleado
    FROM empleado
    WHERE nombre = 'Carlos' AND (apellido1 = 'Soria' OR apellido2 = 'Soria')
);


-- 17) Mostrar aquellos productos de los que se hayan pedido más de 50 unidades.
SELECT *
FROM producto
WHERE codigo_producto IN (
    SELECT codigo_producto
    FROM detalle_pedido
    GROUP BY codigo_producto
    HAVING SUM(cantidad) > 50
);

-- 18) Mostrar aquellos empleados que no son jefes.
SELECT * FROM empleado 
WHERE codigo_empleado
NOT IN (SELECT DISTINCT codigo_jefe FROM empleado WHERE codigo_jefe IS NOT NULL);

-- 19) Muestra aquellos productos cuyo precio de venta sea mayor que el de la media
SELECT * FROM producto
WHERE precio_venta > 
(SELECT ROUND(AVG(precio_venta)) FROM producto);
