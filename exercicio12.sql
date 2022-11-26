CREATE DATABASE plano_servico
GO
USE plano_servico
GO
CREATE TABLE plano(
codPlano			INT				NOT NULL,
nomePlano			VARCHAR(20)		NOT NULL,
valorPlano			DECIMAL(7, 2)	NOT NULL
PRIMARY KEY(codPlano)
)
GO
CREATE TABLE servico(
codServico			INT				NOT NULL,
nomeServico			VARCHAR(20)		NOT NULL,
valorServico		DECIMAL(7, 2)	NOT NULL
PRIMARY KEY(codServico)
)
GO
CREATE TABLE cliente(
codCliente			INT				NOT NULL,
nomeCliente			VARCHAR(20)		NOT NULL,
dataInicio			DATETIME		NOT NULL
PRIMARY KEY(codCliente)
)
CREATE TABLE contrato(
cliente_codCliente	INT				NOT NULL,
plano_codPlano		INT				NOT NULL,
servico_codServico	INT				NOT NULL,
status				CHAR(1)			NOT NULL,
data				DATETIME		NOT NULL
FOREIGN KEY(cliente_codCliente) REFERENCES cliente(codCliente),
FOREIGN KEY(plano_codPlano) REFERENCES plano(codPlano),
FOREIGN KEY(servico_codServico) REFERENCES servico(codServico)
)

INSERT INTO plano VALUES
(1,	'100 Minutos',	80),
(2,	'150 Minutos',	130),
(3,	'200 Minutos',	160),
(4,	'250 Minutos',	220),
(5,	'300 Minutos',	260),
(6,	'600 Minutos',	350)

INSERT INTO servico VALUES
(1,	'100 SMS',	10),
(2,	'SMS Ilimitado', 30),
(3,	'Internet 500 MB',	40),
(4,	'Internet 1 GB',	60),
(5,	'Internet 2 GB',	70)


INSERT INTO cliente VALUES
(1234,	'Cliente A',	'2012-10-15'),
(2468,	'Cliente B',	'2012-11-20'),
(3702,	'Cliente C',	'2012-11-25'),
(4936,	'Cliente D',	'2012-12-01'),
(6170,	'Cliente E',	'2012-12-18'),
(7404,	'Cliente F',	'2013-01-20'),
(8638,	'Cliente G',	'2013-01-25')


INSERT INTO contrato VALUES
(1234,	3,	1,	'E',	'2012-10-15'),
(1234,	3,	3,	'E',	'2012-10-15'),
(1234,	3,	3,	'A',	'2012-10-16'),
(1234,	3,	1,	'A',	'2012-10-16'),
(2468,	4,	4,	'E',	'2012-11-20'),
(2468,	4,	4,	'A',	'2012-11-21'),
(6170,	6,	2,	'E',	'2012-12-18'),
(6170,	6,	5,	'E',	'2012-12-19'),
(6170,	6,	2,	'A',	'2012-12-20'),
(6170,	6,	5,	'A',	'2012-12-21'),
(1234,	3,	1,	'D',	'2013-01-10'),
(1234,	3,	3,	'D',	'2013-01-10'),
(1234,	2,	1,	'E',	'2013-01-10'),
(1234,	2,	1,	'A',	'2013-01-11'),
(2468,	4,	4,	'D',	'2013-01-25'),
(7404,	2,	1,	'E',	'2013-01-20'),
(7404,	2,	5,	'E',	'2013-01-20'),
(7404,	2,	5,	'A',	'2013-01-21'),
(7404,	2,	1,	'A',	'2013-01-22'),
(8638,	6,	5,	'E',	'2013-01-25'),
(8638,	6,	5,	'A',	'2013-01-26'),
(7404,	2,	5,	'D',	'2013-02-03')


SELECT cl.nomeCliente, pl.codPlano, COUNT(co.status) as qtd_estado FROM cliente cl, plano pl, contrato co
WHERE cl.codCliente = co.cliente_codCliente
		AND pl.codPlano = co.plano_codPlano
			AND co.status = 'D'
GROUP BY cl.nomeCliente, pl.codPlano
ORDER BY cl.nomeCliente ASC




SELECT cl.nomeCliente, pl.nomePlano, COUNT(co.status) as qtd_estado FROM cliente cl, plano pl, contrato co
WHERE cl.codCliente = co.cliente_codCliente
		AND pl.codPlano = co.plano_codPlano
			AND co.status = 'A' OR co.status ='E'
GROUP BY cl.nomeCliente, pl.nomePlano
ORDER BY cl.nomeCliente




SELECT cl.nomeCliente, pl.nomePlano,
conta = CASE WHEN  (pl.valorPlano + SUM(se.valorServico)   > 400)
THEN (pl.valorPlano + SUM(se.valorServico) * 0.92)
END,
conta = CASE WHEN  (pl.valorPlano + SUM(se.valorServico) > 300 AND  pl.valorPlano + SUM(se.valorServico) < 400)
THEN  (pl.valorPlano + SUM(se.valorServico) * 0.95) 
END,
conta = CASE WHEN  (pl.valorPlano + SUM(se.valorServico) > 200 AND  pl.valorPlano + SUM(se.valorServico) < 300)
THEN  (pl.valorPlano + SUM(se.valorServico) * 0.97) 
END
FROM cliente cl, plano pl, contrato co, servico se
WHERE cl.codCliente = co.cliente_codCliente
		AND pl.codPlano = co.plano_codPlano
			AND se.codServico = co.servico_codServico
				AND co.status = 'A'
GROUP BY cl.nomeCliente, pl.nomePlano, pl.valorPlano



SELECT cl.nomeCliente, se.nomeServico, DATEDIFF(MONTH, co.data, GETDATE()) as duracao
FROM cliente cl, servico se, contrato co
WHERE cl.codCliente = co.cliente_codCliente
		AND se.codServico = co.servico_codServico
			AND co.status != 'E'




