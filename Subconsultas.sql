USE reservas;

-- 1. Introducción (Conceptos Básicos)

-- Las subconsultas son consultas anidadas dentro de otras sentencia SQL (SELECT, INSERT, UPDATE O DELETE)

-- Ej1: Obtener todas las pistas cuyo precio sea superior al precio medio de todas las pistas
SELECT * FROM pistas WHERE precio > (SELECT AVG(precio) FROM pistas);

-- Ejercicio 2: Listar los usuarios que viven en la misma ciudad que el usuario con ID 1
SELECT * FROM usuarios WHERE ciudad = (SELECT ciudad FROM usuarios WHERE ID = 1);

-- Ejercicio 3: Mostrar los polideportivos situados en la misma ciudad
-- donde se ecuentra el polideportivo "San José"
SELECT * FROM polideportivos WHERE ciudad = (SELECT ciudad FROM polideportivos WHERE nombre = 'San José');

-- Subconsultas de resultado único
-- Estas subconsultas  devuelven una sola fila y una sola columna
-- Se usan con operadores de comparación estándar.

-- Ej 1 Obtener el código, tipo y precio de la pista más cara.
SELECT codigo, tipo, precio FROM pistas WHERE precio = (SELECT Max(precio) FROM pistas);

-- Ej 2: Mostar los datos del usuario que realizó la primera reserva registrada (el menor ID)
SELECT * FROM usuarios WHERE id = (SELECT id_usuario FROM usuario_reserva WHERE id_reserva = (SELECT MIN(id_reserva) FROM usuario_reserva));

-- Ej 3 Listar las pistas del mismo tipo que la pista con código 'MUVF2634'
SELECT * FROM pistas WHERE tipo = (SELECT tipo FROM pistas WHERE codigo = 'MUVF2634');

SELECT p1.*
FROM pistas p1
INNER JOIN pistas p2 ON p1.tipo = p2.tipo
WHERE p2.codigo = 'MUVF2634';

-- Subconsultas de lista de valores
-- Se usa el operador IN con subconsulta
-- Se usa cuando la subconsulta devuelve una columna pero varias filas

-- Ej 1 Listar los nombres y apellidos de los usuarios que han realizado alguna reserva
SELECT * FROM usuario_reserva;
SELECT nombre, apellidos, id FROM usuarios WHERE id IN (SELECT DISTINCT id_usuario FROM usuario_reserva);

-- Ej 2 Motras los polideportivos que tiene pistas de tipo tenis 
SELECT * FROM polideportivos WHERE id IN (SELECT id_polideportivo FROM pistas WHERE tipo = 'tenis');

-- Ej 3 Obtener los datos de las pistas que han estado cerradas alguna vez()
SELECT * FROM pistas WHERE id IN (SELECT id_pista FROM pistas_cerradas);

-- La comparación modificada (ANY, ALL)
-- El test ANY
-- Devuelve verdadero si la comparaciób es cierta para al menos 1
-- Devuelve verdadero si la comparación es cierta para todo

-- Ej 1 Buscar pistas que sean más baratas que alguna de las pistas ID 1
SELECT * FROM pistas WHERE id_polideportivo = 1;
SELECT * FROM pistas WHERE precio < ANY (SELECT precio FROM pistas WHERE id_polideportivo = 1);

-- Ej 2 Listar usuarios cuyo ID sea mayor que algun de los IDs de usuarios de la ciudad Huesca
SELECT * FROM usuarios WHERE id > ANY (SELECT id FROM usuarios WHERE ciudad = 'Huesca');

-- Ejercicio 3 Seleccionar reservas cuya fecha de uso sea posterior
-- a alguna de las fechas de revisión programadas en pistas abiertas
SELECT * FROM reservas WHERE fecha_uso > ANY (SELECT proxima_revision FROM pistas_abiertas);

-- 3.2.2 El test ALL 
-- Devuelve verdadero si la comparación es cierta para todos los valores de la lista

-- Ejercicio1 : Obtener la pista cuyo precio sea mayor o igual
-- que todas las demás pistas(otra forma de sacar el máximo)alter
SELECT * FROM pistas WHERE precio >= ALL(SELECT precio FROM pistas);

-- Ejercicio2:  Listar polideportivos cuyo ID sea menor que
-- todos los ID de polideportivos en 'Teruel'
SELECT * FROM  polideportivos WHERE id < ALL (SELECT id FROM polideportivos WHERE ciudad = 'Teruel');

-- Ejercicio3: Encontrar pistas que sean más caras que todas las pistas de tipo 'ping-pong'
SELECT * FROM pistas pistas WHERE precio > ALL (SELECT DISTINCT precio FROM pistas WHERE tipo = 'ping-pong');

-- Subconsultas con cualquier numero de columnas (EXISTS)
-- El operador EXISTS solo comprueba si la subconsulta devuelve alguna fila,
-- sin importa el contenido de las columnas.

-- Ejercicio 1: Mostrar todos los usuarios que han asistido como invitados a alguna reserva
-- tabla usario_reserva
SELECT * FROM usuarios u WHERE EXISTS (SELECT 1 FROM usuario_usuario uu WHERE uu.id_amigo = u.id);

-- Ejercicio 2: Seleccionar las pistas que actualmente estan abiertas
-- existen en la tabla pistas_abiertas
SELECT * FROM pistas p WHERE EXISTS(SELECT 1 FROM pistas_abiertas pa WHERE p.id = pa.id_pista);

-- Ejercicio 2.1: Seleccionar las pistas que actualmente no aparecen en la tabla pistas_abiertas
SELECT * FROM pistas p WHERE NOT EXISTS(SELECT 1 FROM pistas_abiertas pa WHERE p.id = pa.id_pista);

-- Ejercicio 3 Listar los polideportivos que tienen
-- al menos una pista cuyo precio por hora sea superior a 10€
SELECT * FROM polideportivos p WHERE EXISTS (SELECT 1 FROM pistas pi WHERE pi.id_polideportivo = p.id AND pi.precio > 10);

-- Con INNER JOIN
SELECT pol.*, pi.* FROM polideportivos pol 
INNER JOIN pistas pi
ON pi.id_polideportivo = pol.id
WHERE pi.precio > 10;

-- Ejercicio 4: Muestra el dni, nombre, apellidos, email y ciudad de los usuarios que 
-- nunca hayan hecho una reserva
SELECT dni, nombre, apellidos, email, ciudad FROM usuarios u
WHERE NOT EXISTS (SELECT 1 FROM usuario_reserva ur WHERE u.id = ur.id_usuario);

-- Sin el uso de NOT EXISTS
SELECT * FROM usuarios u WHERE id NOT IN(SELECT DISTINCT id_usuario FROM usuario_reserva);




