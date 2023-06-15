CREATE DATABASE flutter_db;

CREATE USER 'flutter' IDENTIFIED BY 'senha123';
ALTER USER 'flutter'@'localhost' IDENTIFIED BY 'senha123';

GRANT ALL ON flutter_db.* TO 'flutter';

USE flutter_db;

CREATE TABLE tarefas (
    id SERIAL PRIMARY KEY,
    titulo TEXT,
    completado BOOLEAN
);

INSERT INTO tarefas (titulo, completado)
VALUES 
    ('Tarefa 1', 0);