USE jardineria;
-- EXAMEN BD TEMA 6.- PROGRAMACIÓN DE BASES DE DATOS

-- 1º CURSO DAW

-- 1) PROCEDIMIENTOS Y FUNCIONES

-- Crea un procedimiento almacenado llamado resumenPagos. Se debe mostrar la cantidad total de pagos que se realizaron en un año determinado agrupados por la forma de pago.
-- Por tanto, los campos a mostrar serán: Año, FormaPago, CantidadTotal.
-- Los datos se mostrarán ordenados ascendentemente por el campo FormaPago.
-- El procedimiento deberá recibir como parámetro el año sobre el que se desea realizar el resumen.

DROP PROCEDURE resumenPagos;

-- Creación del procedimiento
DELIMITER €€

CREATE PROCEDURE resumenPagos(IN p_anio INT)
BEGIN
    SELECT 
        YEAR(fecha_pago) AS Año,
        forma_Pago AS FormaPago,
        SUM(total) AS CantidadTotal
    FROM pago
    WHERE YEAR(fecha_pago) = p_anio
    GROUP BY YEAR(fecha_pago), forma_pago
    ORDER BY forma_pago ASC;
END €€

DELIMITER ;

-- Llamada al procedimiento
CALL resumenPagos(2008);



-- 2) TRIGGERS

-- Crea un trigger llamado alarma_pedidos_pendientes. Dicho trigger almacenará en una tabla, llamada pedidos_pendientes, aquellos pedidos que estén pendientes de ser entregados.
-- La tabla debe contener los siguientes campos: codigoPedido, FechaPedido, FechaEsperada, Estado, Comentarios, CodigoCliente.

-- Creaciçon de la tabla.
CREATE TABLE pedidos_pendientes(
	codigoPedido INT,
    FechaPedido DATE,
    FechaEsperada DATE,
    Estado VARCHAR(15),
    Comentarios TEXT,
    CodigoCliente INT
);

DROP TRIGGER IF EXISTS alarma_pedidos_pendientes;

-- Creación del trigger
DELIMITER €€
CREATE TRIGGER alarma_pedidos_pendientes 
AFTER INSERT ON pedido
FOR EACH ROW

	BEGIN
		IF NEW.Estado = 'Pendiente' THEN
        
		INSERT INTO pedidos_pendientes
        VALUES(NEW.codigo_pedido, NEW.fecha_pedido, NEW.fecha_esperada, NEW.estado, NEW.comentarios, NEW.codigo_cliente);
        
        END IF;
    END€€
DELIMITER ;

-- Comprobación del trigger
INSERT INTO pedido(codigo_pedido,fecha_pedido,fecha_esperada,estado,codigo_cliente)
VALUES(1500, NOW(), NOW() + INTERVAL 7 DAY, "Pendiente", 5);

SELECT * FROM pedido WHERE codigo_pedido = 1500;
SELECT * FROM pedidos_pendientes;

 -- 3) EVENTOS O VISTAS
 
-- Crea una vista llamada empleadosOficina que muestre solo los empleados que trabajen en España. 
-- La vista debe contener los siguientes campos: CodigoEmpleado, Nombre, Apellido1, Apellido2, CodigoOficina, Ciudad, Pais, Telefono. 
-- Configura la vista para que cuando ésta se actualice siga cumpliendo las condiciones que se incluyeron en su definición.
-- Intenta insertar un empleado nuevo que trabaje en España utilizando dicha vista. ¿Es esta vista actualizable? Razona la respuesta. 

DROP VIEW empleadosOficina;

-- Creación de la primera vista con la que haré join
CREATE VIEW datosEmpleado AS
SELECT codigo_empleado, nombre,apellido1,apellido2,codigo_oficina
FROM empleado ;

-- Creación de la segunda vista, que unirá la primera
CREATE VIEW empleadosOficina AS
SELECT de.codigo_empleado,de.nombre,de.apellido1,de.apellido2,de.codigo_oficina,
		eo.ciudad, eo.pais, eo.telefono
FROM datosEmpleado de
JOIN oficina eo ON de.codigo_oficina = eo.codigo_oficina WHERE pais = "España" ;

-- Comprobación de la vista
SELECT * FROM empleadosOficina;

-- En vistas que unen tablas (JOIN), solo se pueden actualizar columnas de una única tabla base a la vez, en este caso no se puede.
 