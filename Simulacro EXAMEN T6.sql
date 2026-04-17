USE jardineria;
-- EXAMEN BD SIMULACRO SOBRE EL TEMA 6: PROGRAMACIÓN DE BASES DE DATOS

-- Ejercicio 1: Cursores
-- Enunciado: Crea un procedimiento almacenado llamado listar_clientes_por_region que reciba como parámetro el nombre de una región (o ciudad). 
-- El procedimiento debe utilizar un cursor para recorrer todos los clientes de esa zona y mostrar un mensaje por cada uno con el formato:
-- "Cliente: [nombre_cliente] - Contacto: [nombre_contacto] [apellido_contacto]".
DELIMITER €€
	CREATE PROCEDURE listar_clientes_por_region(nombre VARCHAR(50))
    
		BEGIN 
			DECLARE v_nombre_cliente VARCHAR(50);
            DECLARE v_nombre_contacto VARCHAR(30);
            DECLARE v_apellido_contacto VARCHAR(30);
            DECLARE v_region_cliente VARCHAR(50);
            
            DECLARE fin BOOL DEFAULT FALSE;
            
			DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin=TRUE;
            
            DECLARE recorrer CURSOR FOR
            SELECT region INTO v_region_cliente FROM cliente;
            
            IF  v_region_cliente = nombre THEN
            SELECT nombre_cliente INTO v_nombre_cliente FROM cliente;
            SELECT nombre_contacto INTO v_nombre_contacto FROM cliente;
            SELECT apellido_contacto INTO v_apellido_contacto FROM cliente;
            
            END IF;
         

            
            OPEN recorrer;
				REPEAT
					SELECT CONCAT("Cliente: " + v_nombre_cliente + "- Contacto: " + v_nombre_contacto + v_apellido_contacto);
                
                UNTIL fin = TRUE;
            
        
        END €€
    



-- Ejercicio 2: Triggers (Disparadores)
-- Enunciado: Para llevar un control de seguridad, crea una tabla llamada auditoria_pagos. Después, crea un trigger llamado pago_insert que, 
-- cada vez que se inserte un nuevo registro en la tabla pago, guarde de forma automática en la tabla de auditoría el ID del cliente, la fecha del pago, 
-- el total y la fecha/hora exacta en la que se realizó la inserción en el sistema.

CREATE TABLE auditoria_pagos(
	Id_cliente INT,
    Fecha_Pago DATE,
    Total DECIMAL(15,2),
    Tiempo_De_Insercion DATETIME
);

DELIMITER €€

CREATE TRIGGER pago_insert AFTER INSERT ON pago
FOR EACH ROW

	BEGIN
		DECLARE cliente_Auditoria INT;
		DECLARE Fecha_Pago_Auditoria DATE;
        DECLARE Total_Auditoria DECIMAL(15,2);
        
		SELECT NEW.codigo_cliente INTO cliente_Auditoria;
		SELECT NEW.fecha_pago INTO Fecha_Pago_Auditoria;
        SELECT NEW.total INTO Total_Auditoria;
        
		INSERT INTO auditoria_pagos VALUES
        (cliente_Auditoria, Fecha_Pago_Auditoria, Total_Auditoria, NOW());
        
    END €€

DELIMITER ;

INSERT INTO pago
VALUES(50, "Paypal", "Hola", "2022-12-10",15000.50 );

SELECT * FROM auditoria_pagos;
	


-- Ejercicio 3: Eventos
-- Enunciado: La empresa quiere un sistema de limpieza automática. Crea un evento en MySQL llamado limpiar_auditoria_vieja que se ejecute una vez al mes, 
-- empezando a partir de mañana. Este evento debe borrar todos los registros de la tabla auditoria_pagos (creada en el ejercicio anterior) que tengan más de 6 meses de antigüedad.

DELIMITER €€
CREATE EVENT limpiar_auditoria_vieja ON SCHEDULE EVERY 1 MONTH
STARTS NOW() + INTERVAL 24 HOUR
DO
	BEGIN
		DELETE FROM auditoria_pagos WHERE Tiempo_De_Insercion < NOW() - INTERVAL 6 MONTH;
    END €€

DELIMITER ;

