use mysql;
ALTER USER 'root'@'localhost' IDENTIFIED BY 'password';
FLUSH PRIVILEGES;

CREATE DATABASE IF NOT EXISTS `wordpress`;
CREATE USER 'admin'@'%' IDENTIFIED BY 'admin' ;
GRANT ALL PRIVILEGES ON wordpress.* TO 'admin'@'%';
FLUSH PRIVILEGES;
