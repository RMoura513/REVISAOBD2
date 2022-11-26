CREATE DATABASE cliente_mercadoria
GO
USE cliente_mercadoria

CREATE TABLE cliente(
rg				VARCHAR(9)			NOT NULL,
cpf				VARCHAR(12)			NOT NULL,
nome			VARCHAR(25)			NOT NULL,
logradouro		VARCHAR(25)			NOT NULL,
num				INT					NOT NULL
)
GO
CREATE TABLE pedido(
notaFiscal		INT					NOT NULL,
valor			INT					NOT NULL,
data_pedido		DATETIME			NOT NULL,
cliente_rg		VARCHAR(9)			NOT NULL
)
GO
CREATE TABLE mercadoria(
codigo				INT					NOT NULL,
descricao			VARCHAR(25)			NOT NULL,
preco				DECIMAL(7,2)		NOT NULL,
qtd					INT					NOT NULL,
fornecedor_codigo	INT					NOT NULL
)
GO
CREATE TABLE fornecedor(
codigo				INT					NOT NULL,
nome				VARCHAR(25)			NOT NULL,
logradouro			VARCHAR(25)			NOT NULL,
num					INT					NULL,
pais				VARCHAR(10)			NOT NULL,
area				INT					NOT NULL,
telefone			VARCHAR(10)			NULL,
cnpj				VARCHAR(25)			NULL,
cidade				VARCHAR(25)			NULL,
transporte			VARCHAR(25)			NULL,
moeda				VARCHAR(3)			NOT NULL
)

INSERT INTO cliente VALUES
('29531844',	'34519878040',	'Luiz André',	'R. Astorga',	500),
('13514996x',	'84984285630',	'Maria Luiza',	'R. Piauí',	174),
('121985541',	'23354997310',	'Ana Barbara',	'Av. Jaceguai',	1141),
('23987746x',	'43587669920',	'Marcos Alberto',	'R. Quinze',	22)

INSERT INTO pedido VALUES
(1001,	754,	'2018-04-01',	'121985541'),
(1002,	350,	'2018-04-02',	'121985541'),
(1003,	30,	'2018-04-02',	'29531844'),
(1004,	1500,	'2018-04-03',	'13514996x')

INSERT INTO mercadoria VALUES
(10,	'Mouse',	24,	30,	1),
(11,	'Teclado',	50,	20,	1),
(12,	'Cx. De Som',	30,	8,	2),
(13,	'Monitor 17',	350,	4,	3),
(14,	'Notebook',	1500,	7,	4)

INSERT INTO fornecedor VALUES
(1,	'Clone',	'Av. Nações Unidas',	12000,	'BR',	55,	'1141487000',	NULL,	'São Paulo',	NULL,	'R$'),
(2,	'Logitech',	'28th Street',	100,	'USA',	1,	'2127695100',	NULL,	NULL,	'Avião',	'US$'),
(3,	'LG',	'Rod. Castello Branco',	NULL,	'BR',	55,	'0800664400',	'4159978100001',	'Sorocaba',	NULL,	'R$'),
(4,	'PcChips',	'Ponte da Amizade',	NULL,	'PY',	595,	NULL,	NULL,	NULL,	'Navio',	'US$')

ALTER TABLE cliente
ADD CONSTRAINT PK_cliente_RG PRIMARY KEY (rg)

ALTER TABLE fornecedor
ADD CONSTRAINT PK_fornecedor_codigo PRIMARY KEY (codigo)

ALTER TABLE pedido
ADD CONSTRAINT FK_pedido_clienteRG FOREIGN KEY(cliente_rg) REFERENCES cliente(rg)

ALTER TABLE mercadoria
ADD CONSTRAINT FK_mercadoria_FornecedorCodigo FOREIGN KEY(fornecedor_codigo) REFERENCES fornecedor(codigo)

SELECT (pe.valor * 0.90) AS valor FROM pedido pe
WHERE pe.notaFiscal = 1003

SELECT (pe.valor * 0.95) AS valor FROM pedido pe
WHERE pe.valor > 700.00

SELECT CAST((me.preco * 1.20) AS DECIMAL(7,2)) AS preco FROM mercadoria me
WHERE me.qtd < 10

SELECT CONVERT(CHAR(10), pe.data_pedido, 103) AS data_pedido, pe.valor FROM pedido pe, cliente cl
WHERE pe.cliente_rg = cl.rg
		AND cl.nome LIKE '%Luiz%'

SELECT DISTINCT SUBSTRING(cpf, 1, 3) + '.' + SUBSTRING(cpf, 4, 3) + '.' + SUBSTRING(cpf, 7, 3) + '-' + SUBSTRING(cpf, 10, 2) AS cpf,
cl.nome, cl.logradouro + ' ' + CAST(cl.num AS CHAR(5)) AS endereco
FROM cliente cl, pedido pe
WHERE cl.rg = pe.cliente_rg
		AND pe.notaFiscal = 1004

SELECT fo.pais, fo.transporte FROM mercadoria me, fornecedor fo
WHERE fo.codigo = me.fornecedor_codigo
		AND me.descricao LIKE '%Cx%'

SELECT me.descricao, me.qtd FROM mercadoria me, fornecedor fo
WHERE me.fornecedor_codigo = fo.codigo
		AND fo.nome = 'Clone'

SELECT 
CASE WHEN num IS NOT NULL
THEN logradouro + ' ' + CAST(num AS CHAR(5)) + ', ' + pais
ELSE logradouro + ', ' + pais
END AS endereco,

telefone =  CASE pais
WHEN 'USA' THEN '(' + SUBSTRING(telefone, 1, 3) + ')' + SUBSTRING(telefone, 4, 3) + '-' + SUBSTRING(telefone, 7, 4)
WHEN 'BR' THEN '(' + SUBSTRING(telefone, 1, 2) + ')' + SUBSTRING(telefone, 3, 4) + '-' + SUBSTRING(telefone, 7,4)
END 
FROM fornecedor


SELECT fo.moeda FROM mercadoria me, fornecedor fo
WHERE me.fornecedor_codigo = fo.codigo
		AND me.descricao LIKE '%Notebook%'

SELECT DATEDIFF(DAY, pe.data_pedido, '2019-02-03') AS dias,
pedido_antigo = CASE WHEN (DATEDIFF(MONTH, pe.data_pedido, '2019-02-03') >= 6)
THEN pe.notaFiscal
END,
pedido_recente = CASE WHEN (DATEDIFF(MONTH, pe.data_pedido, '2019-02-03') < 6)
THEN pe.notaFiscal
END
FROM pedido pe

SELECT cl.nome, COUNT(pe.notaFiscal) as qtd_pedido FROM cliente cl, pedido pe
WHERE cl.rg = pe.cliente_rg
GROUP BY cl.nome

SELECT cl.rg, cl.cpf, cl.nome FROM cliente cl LEFT OUTER JOIN pedido pe
ON cl.rg = pe.cliente_rg
WHERE pe.notaFiscal IS NULL


