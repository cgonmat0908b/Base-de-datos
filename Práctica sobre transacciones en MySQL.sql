USE jardineria;

DROP PROCEDURE realizar_pago_con_stock;

DELIMITER €€
CREATE PROCEDURE realizar_pago_con_stock(
 IN p_codigo_cliente INT,
 IN p_id_transaccion VARCHAR(50),
 IN p_importe INT,
 IN p_codigo_producto VARCHAR(15),
 IN p_cantidad INT
)

BEGIN
 DECLARE v_stock INT DEFAULT 0;

 -- MANEJADOR DE ERRORES TÉCNICOS
 DECLARE EXIT HANDLER FOR SQLEXCEPTION
 
 BEGIN
	ROLLBACK;
	SELECT 'Error técnico: Transacción anulada.' AS Estado;
 END;
 
 START TRANSACTION;
	SELECT cantidad_en_stock INTO v_stock
    FROM producto WHERE codigo_producto = p_codigo_producto;
    
    IF (v_stock - p_cantidad) < 0 THEN
		SELECT 'Cantidad en stock insuficiente. Cancelando...' AS Estado;
		ROLLBACK;
    
    ELSE
		UPDATE producto SET cantidad_en_stock = (v_stock - p_cantidad)
        WHERE codigo_producto = p_codigo_producto;
        
        INSERT INTO pago(codigo_cliente,forma_pago, id_transaccion, fecha_pago, total)
        VALUES(p_codigo_cliente, "Desconocida", p_id_transaccion, NOW(), p_importe);
        
	COMMIT;
    SELECT "Pago registrado con exito." AS Estado;
    END IF;
    
END €€

DELIMITER ;    

-- Correcto
CALL realizar_pago_con_stock(1,"ak-std-000027",1000,"11679", "3");

-- Stock en negativo
CALL realizar_pago_con_stock(1,"ak-std-000028",1000,"21636", "16");

SELECT * FROM pago;

SELECT * FROM producto;

SELECT * FROM cliente;