/* Crea una vista en la base de datos jardinería para mostrar los nombres de los clientes de la ciudad de Madrid,
junto con los nombres y apellidos de sus representantes de ventas */
USE jardineria;

CREATE VIEW clientes_empleados AS
SELECT codigo_cliente, nombre_cliente, ciudad, nombre as nombreRep, apellido1 as apellido1Rep, apellido2 as apellido2Rep
FROM cliente JOIN empleado ON (codigo_empleado_rep_ventas = codigo_empleado)
WHERE ciudad = 'Madrid';

/* Mostramos la vista que hemos creado */
SELECT * FROM clientes_empleados;

/* Modificamos la vista, cambiando la ciudad a Málaga del cliente Beragua
Comprobamos que la modificación se produce porque no se ha incluido la cláusula WITH CHECK OPTION */
UPDATE clientes_empleados SET ciudad = 'Málaga' WHERE nombre_cliente = 'Beragua';

/* Deshacemos la operación anterior */
UPDATE cliente SET ciudad = 'Madrid' WHERE nombre_cliente= 'Beragua';

/* Modificamos la vista para incluir la cláusula WITH CHECK OPTION*/
ALTER VIEW clientes_empleados AS
SELECT codigo_cliente, nombre_cliente, ciudad, nombre as nombreRep, apellido1 as apellido1Rep, apellido2 as apellido2Rep
FROM cliente JOIN empleado ON (codigo_empleado_rep_ventas = codigo_empleado)
WHERE ciudad = 'Madrid'
WITH CHECK OPTION;

/* Modificamos la vista, cambiando la ciudad a Málaga del cliente Beragua
Comprobamos que la modificación no se produce al incluir la cláusula WITH CHECK OPTION.
Esta cláusula obliga a que las inserciones y modificaciones en la vista deban cumplir
las condiciones de la sentencia SELECT de la vista.
En este ejemplo era que los clientes deben residir en Madrid. */
UPDATE clientes_empleados SET ciudad = 'Málaga' WHERE nombre_cliente= 'Beragua';

/* Creamos un nuevo usuario con los permisos necesarios para crear la vista anterior */
CREATE USER creador_vista IDENTIFIED BY '1234';
GRANT CREATE VIEW, SELECT ON jardineria.* TO creador_vista;

/* Concede al usuario anterior los permisos necesarios para insertar,
eliminar o actualizar la vista */
GRANT INSERT, DROP, UPDATE ON jardineria.clientes_empleados To creador_vista;
GRANT INSERT, DROP, UPDATE ON jardineria.cliente TO creador_vista;
GRANT INSERT, DROP, UPDATE ON jardineria.empleado To creador_vista;

/* Iniciar sesión con el usuario anterior y ejecutar la vista */
SELECT * FROM jardineria.clientes_empleados;

/* Actualiza la vista pero se actualizan todos los clientes que tienen el apellido Pérez.
Este actualización no se realiza bien porque afecta a más de una tabla */
UPDATE clientes_empleados SET Apellido2Rep = 'Pérez' WHERE codigo_cliente=7;

/* Si quisiéramos insertar o eliminar una fila en la vista no lo podríamos hacer directamente,
tendríamos que realizar un insert o delete en las tablas que conforman la vista
(clientes y empleados)
/* Eliminamos la vista */
DROP VIEW clientes_empleados;

/* Eliminamos el usuario ejecuta_vista */
DROP USER creador_vista;





