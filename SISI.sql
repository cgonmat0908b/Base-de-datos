DELIMITER $$

CREATE PROCEDURE resumenPagos(IN p_anio INT)
BEGIN
    SELECT 
        YEAR(fechaPago) AS Año,
        formaPago AS FormaPago,
        SUM(total) AS CantidadTotal
    FROM pago
    WHERE YEAR(fechaPago) = p_anio
    GROUP BY YEAR(fechaPago), formaPago
    ORDER BY formaPago ASC;
END $$

DELIMITER ;