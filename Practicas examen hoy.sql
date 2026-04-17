USE jadineria;

-- Procedimientos almacenados 
/*Ej 1
Crea un procedimiento llamado listar_pedidos_cliente que reciba como parámetro el codigo_cliente y muestre:

código del pedido
fecha del pedido
estado
comentarios

Ordenados por fecha.*/

DROP PROCEDURE listar_pedidos_cliente;
DELIMITER €€
CREATE PROCEDURE listar_pedidos_cliente(IN cod INT)
BEGIN
    
    SELECT codigo_pedido, fecha_pedido, estado, comentarios
    FROM pedido
    WHERE codigo_cliente = cod;

END €€
DELIMITER ;

CALL listar_pedidos_cliente(5);

/* Ej 2
Crea un procedimiento llamado actualizar_limite_credito que reciba:

codigo_cliente
nuevo_limite

y actualice el límite de crédito del cliente.*/
DELIMITER €€
CREATE PROCEDURE actualizar_limite_credito(IN cod INT, IN nuevo DECIMAL(15,2))

BEGIN
	UPDATE cliente SET limite_credito = nuevo WHERE codigo_cliente = cod;
END€€

DELIMITER ;

CALL actualizar_limite_credito(1,5000);

/*FUNCIONES
*/

/* Ej1
Crea una función llamada total_pagado_cliente que reciba el codigo_cliente y devuelva el total de dinero pagado por ese cliente.*/

DROP FUNCTION total_pagado_cliente;
DELIMITER €€

CREATE FUNCTION total_pagado_cliente(cod INT) 
RETURNS DECIMAL(15,2)
DETERMINISTIC

BEGIN
	DECLARE v_total DECIMAL(15,2);
    SELECT SUM(total) INTO v_total FROM pago WHERE codigo_cliente = cod;
	RETURN v_total;
END €€
DELIMITER ;


SELECT total_pagado_cliente(1);

/*EJ 2
Crea una función llamada total_pedidos_cliente que reciba el codigo_cliente y devuelva el número total de pedidos realizados por ese cliente.
*/

DROP FUNCTION total_pedidos_cliente;

DELIMITER €€
CREATE FUNCTION total_pedidos_cliente(cod INT)
RETURNS INT
DETERMINISTIC

BEGIN
	DECLARE v_total INT;
    SELECT COUNT(*) INTO v_total FROM pedido WHERE codigo_cliente = cod;
 
	RETURN v_total;
END €€
DELIMITER ;

SELECT total_pedidos_cliente(5);

-- Cursores

/* Ej1
Ejercicio 1

Crea un trigger que se ejecute antes de insertar un pedido y:

compruebe si el cliente tiene límite de crédito menor a 1000
en ese caso, impida la inserción
*/

DELIMITER €€
CREATE TRIGGER limite_credito BEFORE INSERT ON pedido
FOR EACH ROW

BEGIN
    DECLARE limite_cliente DECIMAL(15,2);
    SELECT limite_credito INTO limite_cliente FROM cliente WHERE NEW.codigo_cliente = codigo_cliente;
	IF limite_cliente < 1000 THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Valor negativo, no valido, abortando UPDATE.';
    END IF;
    
END€€
DELIMITER ;

