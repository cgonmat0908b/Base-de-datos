# Creación de roles
DROP ROLE IF EXISTS 'lectura_escritura', 'lectura', 'escritura';
CREATE ROLE 'lectura_escritura', 'lectura', 'escritura';

#Permisos de los roles
GRANT ALL PRIVILEGES  ON jardineria.* TO 'lectura_escritura';
GRANT SELECT ON jardineria.* TO 'lectura';
GRANT INSERT, UPDATE, DELETE ON jardineria.* TO 'escritura';

#Creación de usuario con todos los permisos menos conceder sus propios permisos
DROP USER IF EXISTS 'admin'@'localhost';
CREATE USER 'admin' @'localhost' IDENTIFIED BY '1234';
GRANT 'lectura_escritura' TO 'admin';

#Creación de usuario con permisos de consulta de tablas
DROP USER IF EXISTS 'juan'@'localhost';
CREATE USER 'juan' @'localhost' IDENTIFIED BY '1234';
GRANT 'lectura' TO 'juan';

#Creación de usuario con permisos de modificación de tablas
DROP USER IF EXISTS 'pepe'@'localhost';
CREATE USER 'pepe' @'localhost' IDENTIFIED BY '1234';
GRANT 'escritura' TO 'pepe';