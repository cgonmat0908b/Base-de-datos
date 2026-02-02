USE jardineria;

-- 1) Inserta una nueva oficina en la ciudad de Málaga con los siguientes datos: código Oficina-> MAL-ES, ciudad-> Málaga, pais-> España, código postal-> 29002, teléfono 952324567->, dirección1-> C/Salitre 7.
INSERT INTO oficina (codigo_oficina, ciudad, pais, codigo_postal, telefono, linea_direccion1)
VALUES('MAL-ES', 'Malaga', 'España', '29002', '952324567', 'C/Salitre 7');
SELECT * FROM oficina WHERE codigo_oficina = 'MAL-ES';

-- 2) Da de alta a un nuevo empleado con los siguientes datos: CodigoEmpleado-> 32, Nombre-> Daniel, Apellido1-> Álvarez, Apellido2-> Martín, Extensión-> 3897, Email-> dalvarez@gardening.com, CodigoOficina-> TAL-ES, CodigoJefe-> 3, Puesto-> Representante Ventas. 
INSERT INTO empleado(codigo_empleado,nombre, apellido1, apellido2, extension, email, codigo_oficina, codigo_jefe, puesto)
VALUES('32','Daniel','Álvarez','Martín','3897','dalvarez@gardening.com','TAL-ES','3','Representante Ventas');
SELECT * FROM empleado WHERE codigo_empleado = '32';

-- 3) Da de alta a un nuevo cliente con los siguientes datos: CodigoCliente -> 39, NombreCliente-> Jardines Costa del Sol, NombreContacto-> Juan, ApellidoContacto-> Ramos, Telf-> 952678923, Fax-> 952678924, direccion1-> C/Góngora 3
-- Ciudad-> Málaga, Pais-> España, CodigoPostal-> 29901 
-- La clave 39 esta duplicada, así que le asigno una que no esté
INSERT INTO cliente (codigo_cliente,nombre_cliente,nombre_contacto,apellido_contacto,telefono,fax,linea_direccion1,ciudad, pais,codigo_postal)
VALUES('59','Jardines Costa del Sol','Juan','Ramos','952678923','952678924','C/Góngora 3','Málaga','España','29901');
SELECT * FROM cliente WHERE codigo_cliente = '59';

-- 4) Crea una tabla llamada clientes_pais que almacene todos los clientes que sean de España.
CREATE TABLE clientes_pais LIKE cliente;

INSERT INTO clientes_pais SELECT *
FROM cliente WHERE pais = "España";

SELECT * FROM clientes_pais;
-- 5) Eliminamos todas las filas de la tabla anterior.
DELETE FROM clientes_pais;
SELECT * FROM clientes_pais;

-- 6) Insertamos en la tabla clientes_pais, que debe estar vacía, las filas devueltas por una consulta que devuelva los clientes que sean de Estados Unidos.
INSERT INTO clientes_pais SELECT * FROM cliente WHERE pais = "USA";
SELECT * FROM clientes_pais;

-- 7) Actualiza la tabla empleados para que el código del jefe del empleado Alberto Soria sea 1.
UPDATE empleado SET codigo_jefe = 1 WHERE nombre = "Alberto" AND apellido1 = "Soria";
SELECT * FROM empleado WHERE nombre = "Alberto" AND apellido1 = "Soria";

-- 8) Actualiza la tabla clientes para que en la columna Pais el valor "Spain" sea sustituido por "España".
SELECT * FROM cliente WHERE pais = "Spain";
UPDATE cliente SET pais = "España" WHERE pais = "Spain";
SELECT * FROM cliente WHERE pais = "España";

-- 9) Incrementa el precio de venta de los productos de la gama "Aromáticas" un 5%.
SELECT * FROM producto WHERE gama = "Aromaticas";
UPDATE producto SET precio_venta = precio_venta * 1.05 WHERE gama = "Aromaticas";
SELECT * FROM producto WHERE gama = "Aromaticas";

-- 10) Da de baja a todos los empleados que trabajen en la oficina de Londres.

-- 11) Elimina la oficina de Londres.

-- 12) Elimina aquellos clientes que no hayan realizado ningún pedido.