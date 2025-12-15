# Creación de roles

#Consulta de cuenta de usuarios creadas en el servidor
SELECT USER,HOST FROM mysql.user;

DROP ROLE IF EXISTS 'lectura_escritura', 'lectura', 'escritura';
CREATE ROLE 'lectura_escritura', 'lectura', 'escritura';

#Permisos de los roles
GRANT ALL PRIVILEGES  ON jardineria.* TO 'lectura_escritura';
GRANT SELECT ON jardineria.* TO 'lectura';
GRANT INSERT, UPDATE, DELETE ON jardineria.* TO 'escritura';

#Creación de usuario 
DROP USER IF EXISTS 'admin'@'localhost';
CREATE USER 'admin' @'localhost' IDENTIFIED BY '1234';

#Creación de usuario 
DROP USER IF EXISTS 'leer1'@'localhost';
CREATE USER 'leer1' @'localhost' IDENTIFIED BY '1234';

#Creación de usuario 
DROP USER IF EXISTS 'leer2'@'localhost';
CREATE USER 'leer2' @'localhost' IDENTIFIED BY '1234';

#Creación de usuario 
DROP USER IF EXISTS 'escribir1'@'localhost';
CREATE USER 'escribir1' @'localhost' IDENTIFIED BY '1234';

#Creación de usuario 
DROP USER IF EXISTS 'escribir2'@'localhost';
CREATE USER 'escribir2' @'localhost' IDENTIFIED BY '1234';

# Asignación de roles
GRANT 'lectura_escritura' TO 'admin'@'localhost';
GRANT 'lectura' TO 'leer1'@'localhost', 'leer2'@'localhost';
GRANT 'escritura' TO 'escribir1'@'localhost', 'escribir2'@'localhost';

#Activación de los roles 
SET DEFAULT ROLE 'lectura_escritura' TO 'admin'@'localhost';
SET DEFAULT ROLE 'lectura' TO 'leer1'@'localhost', 'leer2'@'localhost';
SET DEFAULT ROLE'escritura' TO 'escribir1'@'localhost', 'escribir2'@'localhost';


