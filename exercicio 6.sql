CREATE DATABASE motorista_viagem
GO
USE motorista_viagem
GO

CREATE TABLE motorista(
codigo			INT				NOT NULL,
nome			VARCHAR(25)		NOT NULL,
dataNasc		DATETIME		NOT NULL,
naturalidade	VARCHAR(25)		NOT NULL
)
GO
CREATE TABLE onibus(
placa			VARCHAR(25)		NOT NULL,
marca			VARCHAR(25)		NOT NULL,
ano				INT				NOT NULL,
descricao		VARCHAR(25)		NOT NULL
)
GO
CREATE TABLE viagem(
codigo				INT				NOT NULL,
onibus_placa		VARCHAR(25)		NOT NULL,
motorista_codigo	INT				NOT NULL,
hora_saida			TIME			NOT NULL,
hora_chegada		TIME			NOT NULL,
destino				VARCHAR(25)		NOT NULL
)

INSERT INTO motorista VALUES
(12341, 'Julio Cesar', '1978-04-18', 'São Paulo'),
(12342, 'Mario Carmo', '2002-07-29', 'Americana'),
(12343, 'Lucio Castro', '1969-12-01', 'Campinas'),
(12344, 'André Figueiredo', '1999-05-14', 'São Paulo'),
(12345, 'Luiz Carlos', '2001-01-09', 'São Paulo')

INSERT INTO onibus VALUES
('adf0965', 'Mercedes', 1999, 'Leito'),               
('bhg7654', 'Mercedes', 2002, 'Sem Banheiro'),        
('dtr2093', 'Mercedes', 2001, 'Ar Condicionado'),     
('gui7625', 'Volvo', 2001, 'Ar Condicionado')   

INSERT INTO viagem VALUES
(101,	'adf0965',   	12343,	'10:00',	'12:00',	'Campinas'),
(102,	'gui7625',   	12341,	'7:00',	'12:00',	'Araraquara'),
(103,	'bhg7654',   	12345,	'14:00',	'22:00',	'Rio de Janeiro'),
(104,	'dtr2093',   	12344,	'18:00',	'21:00',	'Sorocaba')


ALTER TABLE motorista
ADD CONSTRAINT PK_codigo PRIMARY KEY (codigo)

ALTER TABLE onibus
ADD CONSTRAINT PK_placa PRIMARY KEY (placa)

ALTER TABLE viagem
ADD CONSTRAINT PK_viagem_codigo PRIMARY KEY (codigo)

ALTER TABLE viagem
ADD CONSTRAINT FK_onibus_placa FOREIGN KEY (onibus_placa) REFERENCES onibus (placa)

ALTER TABLE viagem
ADD CONSTRAINT FK_motorista_codigo FOREIGN KEY (motorista_codigo) REFERENCES motorista (codigo)

SELECT CONVERT(CHAR(5), vi.hora_saida, 108) AS hora_saida, CONVERT(CHAR(5), vi.hora_chegada, 108) AS hora_chegada, vi.destino
FROM viagem vi

SELECT mo.nome FROM viagem vi, motorista mo
WHERE vi.motorista_codigo = mo.codigo
		AND vi.destino = 'Sorocaba'

SELECT ob.descricao FROM onibus ob, viagem vi
WHERE vi.destino = 'Rio de Janeiro'
		AND ob.placa = vi.onibus_placa

SELECT ob.descricao, ob.marca, ob.ano FROM onibus ob, motorista mo, viagem vi
WHERE ob.placa = vi.onibus_placa
		AND mo.codigo = vi.motorista_codigo
			AND mo.nome = 'Luiz Carlos'

SELECT mo.nome, mo.naturalidade, DATEDIFF(YEAR, mo.dataNasc, GETDATE()) AS idade
FROM motorista mo
WHERE DATEDIFF(YEAR, mo.dataNasc, GETDATE()) > 30


