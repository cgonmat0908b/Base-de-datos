
#Crear cuenta de usuario
CREATE USER IF NOT EXISTS'miguel' @'localhost' IDENTIFIED BY '1234';

#Consulta de cuenta de usuarios creadas en el servidor
SELECT USER,HOST FROM mysql.user;

#Borrar cuenta de usuario
DROP USER IF EXISTS 'miguel'@'localhost';

#Asignamos los permisos con todos los permisos
DROP USER IF EXISTS 'miguel'@'localhost';
CREATE USER 'miguel' @'localhost' IDENTIFIED BY '1234';
GRANT ALL PRIVILEGES ON jardineria.* TO 'miguel'@'localhost';

#Creamos otro usuario con ciertos permisos
DROP USER IF EXISTS 'antonio'@'localhost';
CREATE USER 'antonio' @'localhost' IDENTIFIED BY '1234';
GRANT SELECT, INSERT, UPDATE, DELETE ON jardineria.* TO 'antonio' @'localhost';

#Creamos un usuario con permiso SELECT y con la posibilidad de dar el mismo permiso a otros usuarios
DROP USER IF EXISTS 'pepe'@'localhost';
CREATE USER 'pepe' @'localhost' IDENTIFIED BY '1234';
GRANT SELECT ON jardineria.cliente TO 'pepe' @'localhost' WITH GRANT OPTION;

#Eliminamos los permisos de antonio
REVOKE SELECT, INSERT, UPDATE, DELETE ON jardineria.* FROM 'antonio'@'localhost';

#Muestra los permisos que tiene el usuario
SHOW GRANTS FOR 'antonio'@'localhost';

# Este comando refresca los privilegios para que se aplique de manera inmediata
FLUSH PRIVILEGES;
