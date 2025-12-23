CREATE DATABASE ESCOLA;
----------------------------------------------
--CRIAÇÃO DAS TABELAS 
CREATE TABLE professores (
    id_professor SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    especialidade VARCHAR(100),
    email VARCHAR(120)
);

CREATE TABLE aulas (
    id_aula SERIAL PRIMARY KEY,
    nome_da_aula VARCHAR(100),
    id_professor INT REFERENCES professores(id_professor)
);

CREATE TABLE alunos (
    id_aluno SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    idade INT,
    genero VARCHAR(10),
    email VARCHAR(120)
);

CREATE TABLE matriculas (
    id_matricula SERIAL PRIMARY KEY,
    id_aluno INT REFERENCES alunos(id_aluno),
    id_aula INT REFERENCES aulas(id_aula),
    data_matricula DATE
);

--TABELA DE DATAS FEITA PARA IMPORTAR O CSV COM INTUITO DE IMPORTAÇÃO DOS DADOS 
CREATE TABLE datas_import (
  id_matricula INT,
  data_matricula DATE
);

--TRANFERI OS DADOS DAQUELA TABELA PRA MINHA TABELA PRINCIPAL
UPDATE matriculas t
SET data_matricula = d.data_matricula
FROM datas_import d
WHERE t.id_matricula = d.id_matricula;


--DEPOIS EXCLUI AQUELA TABELA TEMPORÁRIA 
DROP TABLE datas_import;