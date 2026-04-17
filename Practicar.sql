-- Procedimientos Almacenados

/*
Ejercicio 1

Crea un procedimiento llamado mostrar_pedidos_cliente que reciba como parámetro el código de un cliente y muestre:

codigo_pedido
fecha_pedido
estado

Solo deben aparecer los pedidos del cliente indicado.
*/

DELIMITER €€
CREATE PROCEDURE mostrar_pedidos_cliente(IN cod INT)
BEGIN 

	SELECT codigo_pedido, fecha_pedido, estado
    FROM pedido WHERE codigo_cliente = cod;

END €€
DELIMITER ;

CALL mostrar_pedidos_cliente(5);

/*Crea un procedimiento llamado listar_productos_gama que reciba como parámetro el nombre de una gama y muestre:

codigo_producto
nombre
precio_venta
cantidad_en_stock

Solo deben mostrarse los productos que pertenezcan a esa gama.
*/
DELIMITER €€
CREATE PROCEDURE listar_productos_gama(IN nombre VARCHAR(50))
	BEGIN
		SELECT codigo_producto, nombre, precio_venta, cantidad_en_stock
		FROM producto WHERE gama = nombre;
    END €€
DELIMITER ;

CALL listar_productos_gama("Herramientas");

/*2. Funciones
Ejercicio 1

Crea una función llamada cantidad_pedidos_cliente que reciba el código de un cliente y devuelva cuántos pedidos ha realizado.
*/
DELIMITER €€
CREATE FUNCTION cantidad_pedidos_cliente(cod INT)
RETURNS INT
DETERMINISTIC
	BEGIN
		DECLARE cantidad INT;
		SET cantidad = (SELECT COUNT(*) FROM pedido WHERE codigo_cliente = cod);
        RETURN cantidad;
	END €€
DELIMITER ;

SELECT cantidad_pedidos_cliente(5);
/*Ejercicio 2

Crea una función llamada total_pagado_cliente que reciba el código de un cliente y devuelva la suma total de sus pagos.

Si no tiene pagos, debe devolver 0.
*/
DELIMITER €€
CREATE FUNCTION total_pagado_cliente(cod INT)
RETURNS DECIMAL(15,2)
DETERMINISTIC
	BEGIN
		DECLARE p_total DECIMAL(15,2);
        
        IF cod NOT IN (SELECT codigo_cliente FROM pedido) THEN
        SET p_total = 0;
        
        ELSE
        SELECT SUM(total) INTO p_total 
        FROM pago WHERE codigo_cliente = cod;
        
        END IF;
        
        RETURN p_total;
        
    END €€
DELIMITER ;

SELECT total_pagado_cliente(5);

/*
3. Cursores
Ejercicio 1

Crea un procedimiento llamado listar_empleados_oficina que reciba como parámetro un código de oficina.

Debe usar un cursor para recorrer los empleados de esa oficina y mostrar un mensaje con este formato:

Empleado: [nombre] [apellido1] - Puesto: [puesto]
*/
DELIMITER €€

CREATE PROCEDURE listar_empleados_oficina(IN cod_oficina VARCHAR(10))
BEGIN
    DECLARE fin INT DEFAULT FALSE;
    
    DECLARE v_nombre VARCHAR(50);
    DECLARE v_apellido1 VARCHAR(50);
    DECLARE v_puesto VARCHAR(50);
    
    -- Cursor
    DECLARE cursor_empleados CURSOR FOR
        SELECT nombre, apellido1, puesto
        FROM empleado
        WHERE codigo_oficina = cod_oficina;
    
    -- Handler
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin = TRUE;
    
    OPEN cursor_empleados;
    
    bucle: LOOP
        FETCH cursor_empleados INTO v_nombre, v_apellido1, v_puesto;
        
        IF fin THEN
            LEAVE bucle;
        END IF;
        
        SELECT CONCAT('Empleado: ', v_nombre, ' ', v_apellido1, ' - Puesto: ', v_puesto);
        
    END LOOP;
    
    CLOSE cursor_empleados;
    
END €€

DELIMITER ;



/*Ejercicio 2

Crea un procedimiento llamado listar_productos_sin_stock que use un cursor para recorrer todos los productos cuya cantidad_en_stock sea igual a 0.

Debe mostrar un mensaje por cada uno con este formato:

Producto sin stock: [nombre] - Gama: [gama]*/
DELIMITER €€

CREATE PROCEDURE listar_productos_sin_stock()
BEGIN
    DECLARE fin INT DEFAULT FALSE;
    
    DECLARE v_nombre VARCHAR(70);
    DECLARE v_gama VARCHAR(50);
    
    -- Cursor
    DECLARE cursor_productos CURSOR FOR
        SELECT nombre, gama
        FROM producto
        WHERE cantidad_en_stock = 0;
    
    -- Handler
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin = TRUE;
    
    OPEN cursor_productos;
    
    bucle: LOOP
        FETCH cursor_productos INTO v_nombre, v_gama;
        
        IF fin THEN
            LEAVE bucle;
        END IF;
        
        SELECT CONCAT('Producto sin stock: ', v_nombre, ' - Gama: ', v_gama);
        
    END LOOP;
    
    CLOSE cursor_productos;
    
END €€

DELIMITER ;	



/*4. Triggers
Ejercicio 1

Crea una tabla llamada auditoria_clientes con los siguientes campos:

codigo_cliente
nombre_cliente
fecha_insercion

Después, crea un trigger llamado cliente_insert que se ejecute
después de insertar un cliente y guarde automáticamente esos datos en la tabla de auditoría.
*/
CREATE TABLE auditoria_clientes(
	codigo_cliente INT,
    nombre_cliente VARCHAR(50),
    fecha_insercion DATE
);

DROP TRIGGER cliente_insert;

DELIMITER €€
CREATE TRIGGER cliente_insert AFTER INSERT ON cliente
FOR EACH ROW

	BEGIN
    INSERT INTO auditoria_clientes 
    VALUES (NEW.codigo_cliente, NEW.nombre_cliente, NOW());
    
    END €€
    
DELIMITER ;


/*Ejercicio 2

Crea una tabla llamada auditoria_productos con los siguientes campos:

codigo_producto
nombre
precio_venta
fecha_modificacion

Después, crea un trigger llamado producto_update_precio que se ejecute
 después de actualizar un producto y guarde un registro en la auditoría
 cuando se modifique su precio_venta.*/
 
 CREATE TABLE auditoria_productos(
	codigo_producto VARCHAR(15),
    nombre VARCHAR(70),
    precio_venta DECIMAL(15,2),
    fecha_modificacion DATE
 );
 
DROP TRIGGER producto_update_precio;

DELIMITER €€
CREATE TRIGGER producto_update_precio 
AFTER UPDATE ON producto
 FOR EACH ROW
 
	BEGIN
    
    IF NEW.precio_venta != OLD.precio_venta THEN
    
		INSERT INTO auditoria_productos
		VALUES(NEW.codigo_producto, NEW.nombre, NEW.precio_venta, NOW());
        
	END IF;
    
    END €€
    
DELIMITER ;

/*Ejercicio 1

Crea un evento llamado borrar_pedidos_rechazados_antiguos
 que se ejecute cada mes y elimine los pedidos con estado
 'Rechazado' cuya fecha_pedido tenga más de 2 años.
*/
DELIMITER €€
CREATE EVENT borrar_pedidos_rechazados_antiguos
ON SCHEDULE EVERY 1 MONTH
STARTS NOW()
DO

	BEGIN	
		DELETE FROM pedido WHERE fecha_pedido < (NOW() - INTERVAL 2 YEAR) AND estado = 'Rechazado';        
	END €€
    
DELIMITER ;

/*Ejercicio 2

Crea un evento llamado actualizar_estado_pendiente
que se ejecute cada día y ponga el estado 'Pendiente' a los pedidos que:

no tengan fecha_entrega
y cuya fecha_esperada ya haya pasado
*/

DELIMITER €€
CREATE EVENT actualizar_estado_pendiente
ON SCHEDULE EVERY 1 DAY
STARTS NOW()
DO
	BEGIN
		UPDATE pedido SET estado = 'Pendiente' WHERE fecha_entrega IS NULL AND fecha_esperada <  NOW();
    END €€
    
DELIMITER ;

-- 6. Vistas
-- 1
CREATE VIEW vista_clientes_madrid AS
SELECT 
    codigo_cliente,
    nombre_cliente,
    nombre_contacto,
    telefono,
    ciudad
FROM cliente
WHERE region = 'Madrid';

-- 2
CREATE VIEW vista_productos_caros AS
SELECT 
    codigo_producto,
    nombre,
    gama,
    precio_venta
FROM producto
WHERE precio_venta > 50;

