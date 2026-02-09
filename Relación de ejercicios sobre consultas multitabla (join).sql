USE jardineria;

-- 1) Selecciona aquellos clientes que hayan hecho algún pedido a partir de 2008.
SELECT DISTINCT c.*
FROM cliente c
JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
WHERE YEAR(p.fecha_pedido) > 2008;

-- 2) Selecciona aquellos clientes que hayan hecho pedidos que contengan algún producto con una cantidad
-- menor a 10 unidades.
SELECT DISTINCT c.*
FROM cliente c
JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
JOIN detalle_pedido d ON p.codigo_pedido = d.codigo_pedido
WHERE d.cantidad < 10;

-- 3) Selecciona aquellos empleados que trabajen en la oficina de Madrid.
SELECT e.*
FROM empleado e
JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
WHERE o.ciudad = 'Madrid';

-- 4) Selecciona aquellos clientes que hayan efectuado pagos con PayPal.
SELECT DISTINCT c.*
FROM cliente c
JOIN pago p ON c.codigo_cliente = p.codigo_cliente
WHERE p.forma_pago = 'PayPal';

-- 5) Selecciona aquellos clientes que hayan efectuado pagos que no sea con PayPal.
SELECT DISTINCT c.*
FROM cliente c
JOIN pago p ON c.codigo_cliente = p.codigo_cliente
WHERE p.forma_pago <> 'PayPal';

-- 6) Selecciona aquellos empleados que sean jefes.
SELECT DISTINCT e.*
FROM empleado e
JOIN empleado e2 ON e.codigo_empleado = e2.codigo_jefe;

-- 7) Selecciona aquellos empleados que no sean jefes.
SELECT e.*
FROM empleado e
LEFT JOIN empleado e2 ON e.codigo_empleado = e2.codigo_jefe
WHERE e2.codigo_jefe IS NULL;

-- 8) Selecciona todos los empleados que sean jefes en España.
SELECT DISTINCT j.*
FROM empleado j
JOIN empleado e ON j.codigo_empleado = e.codigo_jefe
JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
WHERE o.pais = 'España';

-- 9) Selecciona aquellos clientes cuyo límite de crédito sea superior, al menos, al de algunos de los clientes
-- de su mismo país.
SELECT DISTINCT c1.*
FROM cliente c1
JOIN cliente c2 
  ON c1.pais = c2.pais 
 AND c1.limite_credito > c2.limite_credito;

-- 10) Selecciona aquellos clientes que hayan hecho, al menos, 5 pedidos durante el año 2009.
SELECT c.*
FROM cliente c
JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
WHERE YEAR(p.fecha_pedido) = 2009
GROUP BY c.codigo_cliente
HAVING COUNT(*) >= 5;

-- 11) Mostrar aquellos empleados que sean representantes de ventas de algún cliente de Madrid.
SELECT DISTINCT e.*
FROM empleado e
JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
WHERE c.ciudad = 'Madrid';

-- 12) Mostrar aquellos clientes que tengan algún pedido pendiente.
SELECT DISTINCT c.*
FROM cliente c
JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
WHERE p.estado = 'pendiente';

-- 13) Mostrar aquellos clientes que tengan algún pedido rechazado desde 2006.
SELECT DISTINCT c.*
FROM cliente c
JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
WHERE p.estado = 'rechazado'
AND YEAR(p.fecha_pedido) >= 2006;

-- 14) Mostrar aquellos pedidos que tengan al menos 6 productos distintos.
SELECT p.*
FROM pedido p
JOIN detalle_pedido d ON p.codigo_pedido = d.codigo_pedido
GROUP BY p.codigo_pedido
HAVING COUNT(DISTINCT d.codigo_producto) >= 6;

-- 15) Mostrar aquellos clientes cuyos representantes de ventas alguno tenga su oficina en España.
SELECT DISTINCT c.*
FROM cliente c
JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
WHERE o.pais = 'España';

-- 16) Mostrar aquellos empleados que no tengan como jefe a Carlos Soria.
SELECT e.*
FROM empleado e
LEFT JOIN empleado j 
  ON e.codigo_jefe = j.codigo_empleado
WHERE NOT (j.nombre = 'Carlos' 
       AND (j.apellido1 = 'Soria' OR j.apellido2 = 'Soria'));

-- 17) Mostrar aquellos productos de los que se hayan pedido más de 50 unidades.
SELECT p.*
FROM producto p
JOIN detalle_pedido d ON p.codigo_producto = d.codigo_producto
GROUP BY p.codigo_producto
HAVING SUM(d.cantidad) > 50;

-- 18) Mostrar aquellos empleados que no son jefes.
SELECT e.*
FROM empleado e
LEFT JOIN empleado e2 ON e.codigo_empleado = e2.codigo_jefe
WHERE e2.codigo_jefe IS NULL;

-- 19) Muestra aquellos productos cuyo precio de venta sea mayor que el de la media.
SELECT p.*
FROM producto p
JOIN (
    SELECT AVG(precio_venta) AS media
    FROM producto
) m
WHERE p.precio_venta > m.media;
