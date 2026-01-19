USE reservas;

-- Operador UNION
-- Obtener una lista de todos los correos electrónicos de los usuarios y,
-- en la misma columna, los códigos de todas las pistas registradas.
SELECT id_pista FROM pistas_abiertas
UNION 
SELECT id FROM pistas;

-- Listar los nombres de los polideportivos localizados en 'Huesca'
-- junto con los nombres de los usuarios que viven en 'Huesca'
SELECT nombre FROM polideportivos WHERE ciudad = 'Huesca'
UNION 
SELECT nombre FROM usuarios WHERE ciudad = 'Huesca';

-- Operador EXCEPT 
-- Listar los IDs de usuarios que nunca han realizado una reserva.
SELECT id FROM usuarios
EXCEPT 
SELECT id_usuario FROM usuario_reserva;

-- Obtener los IDs de los polideportivos que no tienen ninguna pista de tipo 'tenis'
SELECT id FROM polideportivos 
EXCEPT
SELECT id_polideportivo FROM pistas WHERE tipo = 'tenis';

-- Obtener todos los datos de los polideportivos que no tengan pista de tipo 'tenis'

SELECT * FROM polideportivos WHERE id IN
(SELECT id FROM polideportivos 
EXCEPT
SELECT id_polideportivo FROM pistas WHERE tipo = 'tenis');

--  OPERADOR INTERSECT
-- Encontrar las ciudades donde viven usuarios y donde también existen
-- polideportivos registrados.
SELECT ciudad FROM usuarios
INTERSECT
SELECT ciudad FROM polideportivos;

-- Obtener los IDs de pistan que están en la tabla general de pistas y también
-- marcadas expresamente como abiertas.
SELECT id FROM pistas
INTERSECT
SELECT id_pista FROM pistas_abiertas;

-- PRODUCTO CARTESIANO

-- Generar todas las combinaciones posibles entre nombre de usuarios 
-- y nombres de polideportivos.
SELECT u.nombre, po.nombre 
FROM usuarios u
CROSS JOIN polideportivos po;

SELECT u.nombre, po.nombre
FROM usuarios u, polideportivos po;

-- Crear un listado de todos los tipos de pistas existentes con todas
-- las ciudades donde hay polideportivos
SELECT p.tipo, po.ciudad 
FROM pistas p
CROSS JOIN polideportivos po;

-- Composición Interna INNER JOIN

-- Obtener los datos de las pistas (codigo y precio) junto con la fecha
-- de su próxima revisión si estan abiertas.
SELECT p.codigo, p.precio, pa.proxima_revision
FROM pistas p
INNER JOIN pistas_abiertas ap ON p.id = pa.id_pista;

-- Listar el nombre de los polideportivos y el tipo de pistas que contien, 
-- solo para aquellos que tiene pistas de 'baloncesto'
SELECT poli.nombre, p.tipo
FROM polideportivos poli
INNER JOIN pistas p ON poli.id = p.id_polideportivo WHERE tipo = 'baloncesto';

-- Composición externa (LEFT, RIGHT Y FULL OUTER JOIN)

-- Listar todas las pistas y si estan abiertas, mostrar su fecha de última reserva
-- las que no estén en pistas_abiertas mostrarán NULL

-- LEFT JOIN realiza la misma función que INNER JOIN pero también incluye los datos que le pedímos que no 
-- contengan el mismo dato en ambas tablas.
SELECT p.codigo, pa.fecha_ultima_reserva 
FROM pistas p
LEFT JOIN pistas_abiertas pa ON p.id = pa.id_pista;

-- RIGHT JOIN 
-- Listar todos los polideportivos y las pistas que tiene asociadas,
-- incluyendo polideportivos que aún no tienen pistas registradas.
SELECT po.*, p.*
FROM pistas p
RIGHT JOIN polideportivos po ON p.id_polideportivo = po.id;

-- FULL JOIN
-- Mostrar los nombre de los usuarios con id de sus reservas
-- de modo que aparezcan usuarios sin reserva y reservas sin usuario
-- (si las hubiera). Nota: En MySQL se simula con UNION de LEFT y RIGHT JOIN

SELECT u.nombre, r.id_reserva AS id_reserva
FROM usuarios u
LEFT JOIN usuario_reserva r ON u.id = r.id_usuario
UNION
SELECT u.nombre, r.id_reserva AS id_reserva
FROM usuarios u
RIGHT JOIN usuario_reserva r ON u.id = r.id_usuario; 

