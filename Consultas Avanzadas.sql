USE reservas;

-- 1. Introducción (Conceptos Básicos)

-- Las subconsultas son consultas anidadas dentro de otras sentencia SQL (SELECT, INSERT, UPDATE O DELETE)

-- Ej1: Obtenere todas las pistas cuyo precio sea superior al precio medio de todas las pistas
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


