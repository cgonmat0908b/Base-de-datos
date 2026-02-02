USE Reservas;

-- Insertamos un nuevo usuario en la tabla usuarios
INSERT INTO usuarios (id, dni, nombre, apellidos, email, ciudad, descuento, fecha_nacimiento, fecha_alta)
VALUES ('100','12345678A','Antonio','Garcia','agarcia@gmail.com','Malaga','0.25','1990-12-12','2020-12-04');

-- Como se inserta una fila con todos los valores de campos, no haría falta
-- especificar los nombres de los campo. Aunque el orden de los valores
-- debe coincidir con el orden que tienen los campos cuando se creó la tabla
INSERT INTO usuarios
VALUES ('200','12345673A','Juan','Garcia','jgarcia@gmail.com','Malaga','0.25','1990-12-12','2020-12-04');


-- Insertar fila sin fecha de nacimiento ya que admite valores nulos
INSERT INTO usuarios (id, dni, nombre, apellidos, email, ciudad, descuento, fecha_alta)
VALUES ('300','12345673A','dauan','dwaarcia','jgarcia@gmail.com','Malaga','0.25','2020-12-04');

-- Insertar varias filas con un solo INSERT

INSERT INTO usuarios (id, dni, nombre, apellidos, email, ciudad, descuento, fecha_alta)
VALUES ('400','12345673A','dauan','dwaarcia','jgarcia@gmail.com','Malaga','0.25','2020-12-04'),
('500','12345673A','dauan','dwaarcia','jgarcia@gmail.com','Malaga','0.25','2020-12-04');

-- Creamos una nueva tabla llamada otros_usuarios exactamente igual a la tabla usuarios
CREATE TABLE otros_usuarios LIKE usuarios;
INSERT INTO otros_usuarios (id, dni, nombre, apellidos, email, descuento, ciudad,  fecha_alta)
SELECT id, dni, nombre, apellidos, email, descuento, ciudad, fecha_alta
FROM usuarios;

-- DELETE (elimina filas de una tabla)
-- Borramos todas las filas de la tabla otros_usuarios
DELETE FROM otros_usuarios;
select @@sql_safe_updates;
SET sql_safe_updates = 1;

-- Al usuario con id = 12 le ponemos como nombre "Felipe"
UPDATE usuarios SET nombre = 'Felipe' WHERE id = 12;

-- Incrementa el precio en un 10% de las pistas de tenis que tengan un precio actual inferior a 20€
UPDATE pistas 
SET precio = precio +(precio * 0.10)
WHERE precio < 20 AND tipo = 'tenis';

-- Reduce el precio de las pistas que no se han reservado todavia un 10%
UPDATE pistas
SET precio = precio - precio * 0.1
WHERE id NOT IN (SELECT id_pista FROM reservas);

--

