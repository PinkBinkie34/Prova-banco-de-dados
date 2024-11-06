CREATE DATABASE escola /*Criando a tabela*/

USE escola/*Usando a tabela*/

CREATE TABLE Alunos (
    NM BIGINT PRIMARY KEY,                        -- NM seria o numero de matricula 
    Nome VARCHAR(100) NOT NULL,                   -- Define que "Nome" é um texto de até 100 caracteres e não pode ser nulo.
    Endereco VARCHAR(100),                        
	Contato_Emergência BIGINT NOT NULL,            -- Define o contato de emergência.
	Notas FLOAT
);

INSERT INTO Alunos (NM, Nome, Endereco, Contato_Emergência,Notas) --Criando a tabela alunos
VALUES 
(123456789, 'Pedro', 'Rua A', 945214497,5.2),
(123356780, 'Gabriel', 'Rua A', 245114596,10.0),
(223356788, 'Leonardo', 'Rua C', 915314456,3.3),
(425457787, 'Tiago', 'Rua D', 585281721,5.7);

SELECT * --Olhando a tabela alunos
FROM Alunos

CREATE TABLE Professor (
    CPF BIGINT PRIMARY KEY,                       -- CPF como chave primaria
    Nome VARCHAR(100) NOT NULL,                   -- Define que "Nome" é um texto de até 100 caracteres e não pode ser nulo.
    Endereco VARCHAR(100),                        
	Contato_Emergência BIGINT NOT NULL,           -- Define o contato de emergência.
	Salário BIGINT ,                              -- Define o Salário

);

INSERT INTO Professor (CPF, Nome, Endereco, Contato_Emergência,Salário) --Criando a tabela professores
VALUES 
(22347658904, 'Claudio', 'Rua prof1',235152596,10000),
(12345638901, 'Otavio', 'Rua B',945311197,5500),
(32042678923, 'Jose', 'Rua prof1',915464432,2000),
(50346645945, 'Adriano', 'Rua A',583265712,5000);

SELECT *
FROM Professor

CREATE TABLE Pais (
    CPF BIGINT PRIMARY KEY,                       -- CPF como chave primaria
    Nome VARCHAR(100) NOT NULL,                   -- Define Nome do responsável.
    Endereco VARCHAR(100),                        
	Aluno BIGINT NOT NULL,                        -- Filho da escola.
	Profissão VARCHAR(100),                             -- Profissão do responsável.
	Email VARCHAR(100),    
	Notas FLOAT,
	FOREIGN KEY (Aluno) REFERENCES Alunos(NM),
);

INSERT INTO Pais(CPF, Nome, Endereco,Aluno,Profissão,Email,Notas) --Criando a tabela pais
VALUES 
(50390623906, 'Rita', 'Rua A','123456789','Engenharia','rita.neusa@gmail.com',5.2),
(50984310299, 'Rita', 'Rua A','123356780','Engenharia','rita.neusa@gmail.com',10.0),
(83720832913, 'Alfredo','Rua C','223356788','Advogado','Alfredo.Silva12@gmail.com', 3.3),
(49382490653, 'Luis', 'Rua D','425457787','Professor','Luis123@gmail.com',5.7 )


SELECT *
FROM Pais



--Trigger para n ser possivel deletar os dados da tabela professor
CREATE OR ALTER TRIGGER Deletar_Tabela
ON Professor
INSTEAD OF DELETE
AS
BEGIN
	PRINT 'Esses dados não podem ser deletados' --printa que n foi possivel deletar
END
GO
--testando pra ver se deleta
DELETE FROM Professor
WHERE CPF = 22347658904

SELECT *
FROM Professor

--Criando uma funcao para verificar quem foi aprovado
CREATE FUNCTION Aprovado (@nota FLOAT)
RETURNS VARCHAR(12)
AS
BEGIN
 DECLARE @resultado VARCHAR(12)
    IF @Nota>=6.0
	SET @resultado='Aprovado'
	ELSE
	SET @resultado='reprovado'

	RETURN @resultado
END;
--Montando o view para apresentar quem foi aprovado
 CREATE VIEW Status_Aprovado AS
 SELECT Nome,
 notas,
 dbo.Aprovado(notas) AS 'status'
 FROM Alunos
 --usando a funcao junto com o view para ver quem foi aprovado
SELECT*
FROM Status_Aprovado

--usando o window function para adcionar ua média por régua aos alunos
SELECT 
Nome,notas,AVG(notas)OVER(ORDER BY nome)
AS média
FROM Alunos
--usando o CTE para achar quem tme mais de um filho nas escola
WITH DoisFilhos AS(
    SELECT
	   aluno,
	  nome,
	  notas
	  FROM Pais
	  INNER JOIN Alunos
	ON Aluno.NM=pais.Aluno
)
--vendo quem tem mais de 2 filhos na tabela
SELECT
nome,
notas
FROM AjudaAlunos

IF EXISTS (SELECT 1 FROM SYS.OBJECTS WHERE TYPE = 'P' AND NAME = 'AdionarAluno')
     BEGIN
         DROP PROCEDURE AdionarAluno
     END
GO
--usando o procedure para adcionar alunos
CREATE PROCEDURE AdionarAluno
    @NM BIGINT, 
    @Nome VARCHAR(100),
    @Endereco VARCHAR(100),                        
	@Contato_Emergência BIGINT ,            
	@Notas FLOAT
	AS
	INSERT INTO Alunos(NM, Nome, Endereco, Contato_Emergência,Notas)
	VALUES(@NM, @Nome, @Endereco, @Contato_Emergência,@Notas)
	SELECT *FROM Alunos
	GO

	EXEC AdionarAluno
	@NM=900986729, 
	@Nome='Vitor',
	@Endereco='Rua O',
	@Contato_Emergência=505012497,
	@Notas=2.3

	--usando o loop para fazer uma contagem
	DECLARE @contador INT
	SET @contador=1
	WHILE @contador<=10)
	BEGIN
	PRINT @contador
	SET @contador=@contador+1
	END



