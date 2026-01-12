USE reservas;

 -- Muestra los nombre de los usuarios de manera ascendente
 SELECT nombre FROM usuarios ORDER BY nombre;
 
-- Muestra los nombres de los usuarios sin repeticiones
SELECT DISTINCT nombre FROM usuarios ORDER BY nombre;

-- Muestra los apellidos y nombre de los usuarios ordenador por ambos campos
SELECT DISTINCT apellidos, nombre FROM usuarios ORDER BY apellidos DESC, nombre;

-- Muestra toda la información de los usuarios
SELECT * FROM usuarios;

-- Muestra el nombre y dirección de los polideportivos de Zaragoza
SELECT nombre, direccion, ciudad FROM polideportivos WHERE ciudad = 'Zaragoza';

-- Usando un alias para los campos nombre y apellidos, lo que va entre "" es el alias que se le da a la columna
SELECT nombre "nom", apellidos "apell" FROM usuarios ORDER BY apellidos, nombre;

-- Usando la función CONCAT para concatenar los apellidos y el nombre en una sola columna
SELECT CONCAT(apellidos, ', ', nombre) "Apellidos y Nombre" FROM usuarios ORDER BY nombre ASC;

-- Muestra los usuarios cuyo descuento sea distinto a 0.1
SELECT * FROM usuarios WHERE ROUND(descuento, 2) != 0.1;

-- Muestra todos los usuarios que no sean de Zaragoza
SELECT * FROM usuarios WHERE NOT (ciudad = 'Zaragoza');

-- Muestra todos los usuarios que sean de Zaragoza y Soria
SELECT * FROM usuarios WHERE (ciudad = 'Zaragoza' OR ciudad = 'Soria');

 -- Muestra todos los usuarios que sean de Zaragoza y Soria y además hayan nacido a partir del año 2013
 SELECT * FROM usuarios WHERE (ciudad = 'Zaragoza' OR ciudad = 'Soria') AND fecha_nacimiento >= '2013-01-01';
 
 -- Nombre de los polideportivos que están en una ciudad cuyo nombre empieza por Z y tiene 8 caracteres
 SELECT nombre,ciudad FROM polideportivos WHERE ciudad LIKE 'Z_______';
 
  -- Muestra los usuarios cuyo nombre empiece por B y termine en A.
SELECT * FROM usuarios WHERE nombre LIKE 'B%A';

 -- Muestra los usuarios cuyo nombre tenga 6 caracteres.
 SELECT * FROM usuarios WHERE nombre LIKE '______';
 
 -- Uso del IN, util para filtrar una columna con los valores que queremos
 SELECT nombre, extension, ciudad FROM polideportivos WHERE ciudad IN ('Zaragoza', 'Huesca', 'Teruel');
 
 -- Muestra los usuarios que no vivan ni en Huesca ni en Teruel usando el operador IN
 SELECT * FROM usuarios WHERE ciudad NOT IN ('Teruel', 'Huesca');
  
	-- Muestra los usuarios cuya fecha de nacimiento esté comprendida entre el dia 1 de enero de 2023 y el 31 de diciembre de 2014
 SELECT * FROM usuarios WHERE fecha_nacimiento BETWEEN '2013-01-01' AND '2014-12-31';
 
 -- Lo mismo sin el uso de BETWEEN
  SELECT * FROM usuarios WHERE fecha_nacimiento >= '2013-01-01' AND fecha_nacimiento <= '2014-12-31';
  
  -- Muestra los 10 primeros usuarios ordenador por apellido y nombre.
  SELECT * FROM usuarios ORDER BY apellidos, nombre LIMIT 10;
  
    -- Muestra el ultimo usuario ordenado por apellido y nombre.
  SELECT * FROM usuarios ORDER BY apellidos DESC , nombre DESC LIMIT 1;
  
 
 -- Funciones AGREGADAS o de RESUMEN
  
  -- Funcion Count
  -- Numero de pistas
  SELECT COUNT(*) "Número de Pistas" FROM pistas;
  
  -- Numero de polideportivos en Zaragoza
 SELECT COUNT(*) "Polideportivos en Zaragoza" FROM polideportivos WHERE ciudad = 'Zaragoza';
 
 -- Función SUM()
 -- Cuanto dinero costaría alquilar todas las pistas del polideportivo cuyo id es 23
 SELECT ROUND(SUM(precio),2) FROM pistas WHERE id_polideportivo = '23';
 
 -- Precio de la pista más barata
 SELECT MIN(precio) "Pista más barata" FROM pistas;
 
 -- Precio media "AVG"
 SELECT AVG(precio) FROM pistas;
 
 -- Esto esta mal
 SELECT * FROM pistas WHERE MIN(precio);
 
 
 
   -- Funciones ESCALARES
   
 -- Convertir cadena de caracteres en mayúsculas
 SELECT UPPER('SQL es un lenguaje de consulta estructurado');
 
 -- Nombres de todos los usuarios de la tabla usuarios en Mayusculas (UPPER)
 SELECT UPPER(nombre) "Nombres Mayusculas" FROM usuarios;
 
  -- Nombres de todos los usuarios de la tabla usuarios en Minusculas (LOWER)
 SELECT LOWER(nombre) "Nombres Mayusculas" FROM usuarios;
 
 -- Longitud de una cadena de caracteres (LENGTH)
 SELECT LENGTH(nombre) "Longitud" FROM usuarios;
 
  -- Concatenar cadenas de caracteres
 SELECT CONCAT(nombre, ', ', apellidos) FROM usuarios;
 
  -- Elimina espacioes en blanco al principio y al final de la cadena de caracteres
 SELECT TRIM('        !Curso de SQL!        ');
   
   -- Reemplaza un caracter por otro dentro de una cadena
 SELECT REPLACE ('ABC ABC ABC', 'A', 'C');
 
  -- Invierte una cadena de caracteres
  SELECT REVERSE('AGALAM');
  
  -- Devuelve la fecha y hora actual
  SELECT SYSDATE();
  SELECT NOW();
  -- Ambas funciones hacen lo mismo
  
  -- Redondea el numero a decimales
  SELECT ROUND(2570.5234, 2);
  
  -- Muestra los usuarios que hayan nacido en el 2013 ordenados por fecha de nacimiento
  SELECT * FROM usuarios WHERE fecha_nacimiento >= '2013-01-01' AND fecha_nacimiento < DATE_ADD('2013-01-01', INTERVAL 1 YEAR) ORDER BY fecha_nacimiento;
  
  -- Segunda opción de realizar la misma consulta, usando el operador + en vez de DATE_ADD.
  SELECT * FROM usuarios WHERE fecha_nacimiento >= '2013-01-01' AND fecha_nacimiento < ('2013-01-01' + INTERVAL 1 YEAR) ORDER BY fecha_nacimiento;
  
  -- Muestra la diferenia en dias entre las dos fechas indicadas.
  SELECT DATEDIFF('2022-02-23', '2022-01-01'); -- Positivo
  SELECT DATEDIFF('2022-01-01', '2022-02-23'); -- Negativo
  
  SELECT '2013-01-01' - INTERVAL 12 MONTH;
  
  -- Consulta de resumen usando GROUP BY
  
  -- Número de polideportivos que hay en cada ciudad
  SELECT ciudad, COUNT(*) AS cantidad_polideportivos FROM polideportivos GROUP BY ciudad ORDER BY ciudad;
  
  -- Cuantos usuarios hay en cada ciudad
  SELECT ciudad, COUNT(*) N_Usuarios FROM usuarios GROUP BY ciudad ORDER BY ciudad;
  
  -- Cuántos polideportivos hay en cada ciudad, solamente aquellas con más de 10 
  -- Para añadir clausulas al ORDER BY ha de usarse HAVING en vez de WHERE.
  SELECT ciudad, COUNT(*) N_Usuarios FROM polideportivos GROUP BY ciudad HAVING COUNT(*) > 10 ORDER BY ciudad;
  
  -- Cuantas pistas de cada deporte hay?
  SELECT * FROM reservas.pistas;
  SELECT tipo, COUNT(*) N_Pistas FROM pistas GROUP BY tipo;
  
  -- Cuantas pista de cada deporte hay, solo mostrando los deportes con más de 50 pistas
  SELECT tipo, COUNT(*) N_Pistas FROM pistas GROUP BY tipo HAVING COUNT(*) > 50 ORDER BY tipo;
  
  -- Quiero saber el precio promedio de cada tipo de pista
  SELECT tipo, AVG(precio) AS Precio_Medio, COUNT(*) N_Pistas FROM pistas GROUP BY tipo;
  
  -- Quiero saber los tipos de pistas que tiene un precio medio mayor a 9€
  SELECT tipo, ROUND(AVG(precio),2) AS Precio_Min, COUNT(*) N_Pistas 
  FROM pistas GROUP BY tipo HAVING ROUND(AVG(precio),2) > 9;
  
  -- ¿Cuál es la pista más barata y su tipo de pista más barata? 
  SELECT tipo, MIN(precio) precio_min FROM pistas GROUP BY tipo
  ORDER BY MIN(precio) ASC LIMIT 1;
  
  -- ¿Cuál es la pista más cara y su tipo de pista?
  SELECT tipo, MAX(precio) precio_max FROM pistas GROUP BY tipo
  ORDER BY MAX(precio) DESC LIMIT 1;
  
  -- Consultas Multitablas
  
  -- Mostramos la información de las pistas con sus reservas
  SELECT pistas.id 'pistas_id', codigo, tipo, reservas.id 'reservas_id',
  fecha_reserva, fecha_uso, id_pista
  FROM pistas, reservas
  WHERE pistas.id = reservas.id_pista
  ORDER BY pistas.id;
  
 -- Muestra toda la información de los usuarios 
 -- que hicieron alguna reserva
 
 SELECT usuarios.id 'usuario_id', dni, nombre, apellidos, email,
 ciudad, fecha_nacimiento,id_reserva, asiste, id_usuario
 FROM usuarios, usuario_reserva
 WHERE usuarios.id = id_usuario 
 ORDER BY apellidos, nombre;
 
 -- Con INNER JOIN, mucho más eficiente ya que no realiza el calculo cartesiano ese
 
 SELECT usuarios.id 'usuario_id', dni, nombre, apellidos, email,
 ciudad, fecha_nacimiento,id_reserva, asiste, id_usuario
 FROM usuarios INNER JOIN usuario_reserva
 ON usuarios.id = id_usuario
 ORDER BY apellidos, nombre;
 
 -- Mostrar toda la información de los polideportivos junto con las 
 -- pistas que tiene cada uno de ellos
 
 -- Con INNER JOIN 
 SELECT polideportivos.id 'polideportivo_id', nombre, direccion,
 ciudad, extension, pistas.id 'pista_id', codigo, tipo, precio,
 id_polideportivo
 FROM polideportivos
 INNER JOIN pistas
 ON polideportivos.id = id_polideportivo;
 
 -- Sin INNER JOIN
 SELECT polideportivos.id 'polideportivo_id', nombre, direccion,
 ciudad, extension, pistas.id 'pista_id', codigo, tipo, precio,
 id_polideportivo
 FROM polideportivos, pistas
 WHERE polideportivos.id = id_polideportivo;
 
 
 

  
  
  
  
  
  
  
  