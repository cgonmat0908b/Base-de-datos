USE jardineria;

-- Ejercicio 1: Cursores
-- Enunciado: Crea un procedimiento almacenado llamado listar_clientes_por_region que reciba como parámetro el nombre de una región (o ciudad). 
-- El procedimiento debe utilizar un cursor para recorrer todos los clientes de esa zona y mostrar un mensaje por cada uno con el formato:
-- "Cliente: [nombre_cliente] - Contacto: [nombre_contacto] [apellido_contacto]".

DROP PROCEDURE IF EXISTS listar_clientes_por_region;
DELIMITER €€

CREATE PROCEDURE listar_clientes_por_region(IN parametro VARCHAR(50))

BEGIN

	DECLARE v_nombre_cliente VARCHAR(50);
    DECLARE v_nombre_contacto VARCHAR(30);
    DECLARE v_apellido_contacto VARCHAR(30);
    DECLARE fin BOOL DEFAULT FALSE;
    
    DECLARE recorrer_Cursor CURSOR FOR
    SELECT nombre_cliente, nombre_contacto, apellido_contacto FROM jardineria.cliente WHERE pais = parametro OR region = parametro;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin=TRUE;
    
    OPEN recorrer_Cursor;
    REPEAT 
    
		FETCH recorrer_Cursor INTO v_nombre_cliente, v_nombre_contacto, v_apellido_contacto;
        SELECT v_nombre_cliente, v_nombre_contacto, v_apellido_contacto;
        
	UNTIL fin = TRUE
    
    END REPEAT;
    CLOSE recorrer_Cursor;
    
END €€
DELIMITER ;

CALL listar_clientes_por_region("USA");