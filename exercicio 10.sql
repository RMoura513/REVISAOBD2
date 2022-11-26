CREATE DATABASE medicamento_cliente
GO
USE medicamento_cliente
GO
CREATE TABLE medicamento(
codigo				INT				NOT NULL,
nome				VARCHAR(30)		NOT NULL,
apresentacao		VARCHAR(30)		NOT NULL,
unidadeCadastro		VARCHAR(15)		NOT NULL,
precoProposto		DECIMAL(7, 2)	NOT NULL
PRIMARY KEY (codigo)
)
GO
CREATE TABLE cliente(
cpf					VARCHAR(20)		NOT NULL,
nome				VARCHAR(20)		NOT NULL,
rua					VARCHAR(25)		NOT NULL,
num					INT				NOT NULL,
bairro				VARCHAR(20)		NOT NULL,
telefone			VARCHAR (15)		NOT NULL
PRIMARY KEY (cpf)
)
GO
CREATE TABLE venda(
notaFiscal			INT				NOT NULL,
cliente_cpf			VARCHAR(20)		NOT NULL,
medicamento_codigo	INT		NOT NULL,
qtd					INT				NOT NULL,
valorTotal			DECIMAL(7, 2)	NOT NULL,
dataVenda			DATETIME		NOT NULL,
PRIMARY KEY (notaFiscal, valorTotal),
FOREIGN KEY (cliente_cpf) REFERENCES cliente(cpf),
FOREIGN KEY (medicamento_codigo) REFERENCES medicamento (codigo)
)


INSERT INTO medicamento VALUES
(1,	 'Acetato de medroxiprogesterona',  	 '150 mg/ml',  	 'Ampola',  	6.700),
(2,	 'Aciclovir',  	 '200mg/comp.',  	 'Comprimido',  	0.280),
(3,	 'Ácido Acetilsalicílico',  	 '500mg/comp.',  	 'Comprimido',  	0.035),
(4,	 'Ácido Acetilsalicílico',  	 '100mg/comp.',  	 'Comprimido',  	0.030),
(5,	 'Ácido Fólico',  	 '5mg/comp.',  	 'Comprimido',  	0.054),
(6,	 'Albendazol',  	 '400mg/comp. mastigável',  	 'Comprimido',  	0.560),
(7,	 'Alopurinol',  	 '100mg/comp.',  	 'Comprimido',  	0.080),
(8,	 'Amiodarona',  	 '200mg/comp.',  	 'Comprimido',  	0.200),
(9,	 'Amitriptilina(Cloridrato)',  	 '25mg/comp.',  	 'Comprimido',  	0.220),
(10, 'Amoxicilina',  	 '500mg/cáps.',  	 'Cápsula',  	0.190)


INSERT INTO cliente VALUES
('34390898700',	'Maria Zélia',	'Anhaia',	65,	'Barra Funda',	92103762),
('21345986290',	'Roseli Silva',	'Xv. De Novembro',	987,	'Centro',	82198763),
('86927981825',	'Carlos Campos',	'Voluntários da Pátria',	1276,	'Santana',	98172361),
('31098120900',	'João Perdizes',	'Carlos de Campos',	90,	'Pari',	61982371)


INSERT INTO venda VALUES
(31501,	'86927981825',	10,	3,	0.57,	'2020-11-01'),
(31501,	'86927981825',	2,	10,	2.8,	'2020-11-01'),
(31501,	'86927981825',	5,	30,	1.05,	'2020-11-01'),
(31501,	'86927981825',	8,	30,	6.6,	'2020-11-01'),
(31502,	'34390898700',	8,	15,	3,		'2020-11-01'),
(31502,	'34390898700',	2,	10,	2.8,	'2020-11-01'),
(31502,	'34390898700',	9,	10,	2.2,	'2020-11-01'),
(31503,	'31098120900',	1,	20,	134,	'2020-11-02')


SELECT DISTINCT me.nome, me.apresentacao,
CASE WHEN me.unidadeCadastro = 'Comprimido'
THEN SUBSTRING(me.unidadeCadastro, 1, 4) + '.'
ELSE me.unidadeCadastro
END AS unidadeCadastro,
me.precoProposto FROM medicamento me LEFT OUTER JOIN venda ve
ON ve.medicamento_codigo = me.codigo
WHERE me.codigo NOT IN(
		SELECT ve.medicamento_codigo FROM venda ve
		)



SELECT cl.nome FROM cliente cl, venda ve, medicamento me
WHERE cl.cpf = ve.cliente_cpf
		AND me.codigo = ve.medicamento_codigo
			AND me.nome = 'Amiodarona'



SELECT cl.cpf, cl.rua + ', ' + CAST(cl.num AS CHAR(5)) + ', ' + cl.bairro AS endereco, me.nome AS remedio, me.apresentacao, me.unidadeCadastro, me.precoProposto, ve.qtd, (me.precoProposto * ve.qtd) AS valor_total
FROM cliente cl, medicamento me, venda ve
WHERE  cl.cpf = ve.cliente_cpf
		AND me.codigo = ve.medicamento_codigo
			AND cl.nome LIKE '%Maria%'
GROUP BY cl.cpf, cl.rua, cl.num, cl.bairro, me.nome, me.apresentacao, me.unidadeCadastro, me.precoProposto, ve.qtd



SELECT CONVERT(CHAR(10), ve.dataVenda, 103) AS data_venda
FROM venda ve, cliente cl
WHERE cl.cpf = ve.cliente_cpf
		AND cl.nome LIKE '%Carlos%'



UPDATE medicamento
SET nome = 'Cloridato de Amitriptilina'
WHERE nome = 'Amitriptilina(Cloridrato)'





