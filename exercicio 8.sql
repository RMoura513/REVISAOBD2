CREATE DATABASE cliente_corredor
GO
USE cliente_corredor
GO

CREATE TABLE cliente(
codigo				INT				NOT NULL,
nome				VARCHAR(25)		NOT NULL,
endereco			VARCHAR(40)		NOT NULL,
telefone			INT				NOT NULL,
telefoneComercial	INT				NULL
PRIMARY KEY(codigo)
)
GO
CREATE TABLE mercadoria(
codigo				INT				NOT NULL,
nome				VARCHAR(25)		NOT NULL,
tipoMercadoria_codigo	INT			NOT NULL,
corredores_codigo		INT			NOT NULL,
valor				DECIMAL(7, 2)	NOT NULL
PRIMARY KEY(codigo),
FOREIGN KEY(tipoMercadoria_codigo) REFERENCES tipoMercadoria (codigo),
FOREIGN KEY(corredores_codigo) REFERENCES corredores (codigo)
)
GO
CREATE TABLE corredores(
codigo						INT				NOT NULL,
tipoMercadoria_codigo		INT				NOT NULL,
nome						VARCHAR(25)		NULL
PRIMARY KEY(codigo),
FOREIGN KEY(tipoMercadoria_codigo) REFERENCES tipoMercadoria (codigo)
)
GO
CREATE TABLE tipoMercadoria(
codigo				INT				NOT NULL,
nome				VARCHAR(25)		NOT NULL
PRIMARY KEY(codigo)
)
GO
CREATE TABLE compra(
notaFiscal			INT				NOT NULL,
cliente_codigo		INT				NOT NULL,
valor				DECIMAL( 7, 2)	NOT NULL
PRIMARY KEY(notaFiscal),
FOREIGN KEY(cliente_codigo) REFERENCES cliente (codigo)
)


INSERT INTO cliente VALUES
(1,	'Luis Paulo',	'R. Xv de Novembro, 100',	45657878, NULL),	
(2,	'Maria Fernanda',	'R. Anhaia, 1098',	27289098,	40040090),
(3,	'Ana Claudia',	'Av. Voluntários da Pátria, 876',	21346548, NULL),
(4,	'Marcos Henrique',	'R. Pantojo, 76',	51425890,	30394540),
(5,	'Emerson Souza',	'R. Pedro Álvares Cabral, 97',	44236545,	39389900),
(6,	'Ricardo Santos',	'Trav. Hum, 10',	98789878, NULL)	


INSERT INTO mercadoria VALUES
(1001,	'Pão de Forma',	10001,	101,	3.5),
(1002,	'Presunto',	10002,	101,	2.0),
(1003,	'Cream Cracker',	10003,	103,	4.5),
(1004,	'Água Sanitária',	10004,	104,	6.5),
(1005,	'Maçã',	10005,	105,	0.9),
(1006,	'Palha de Aço',	10006,	106,	1.3),
(1007,	'Lasanha',	10007,	107,	9.7)


INSERT INTO corredores VALUES
(101,	10001,	'Padaria'),
(102,	10002,	'Calçados'),
(103,	10003,	'Biscoitos'),
(104,	10004,	'Limpeza'),
(105,   10005, NULL),		
(106,   10006, NULL),		
(107,	10007,	'Congelados')


INSERT INTO tipoMercadoria VALUES
(10001,	'Pães'),
(10002,	'Frios'),
(10003,	'Bolacha'),
(10004,	'Clorados'),
(10005,	'Frutas'),
(10006,	'Esponjas'),
(10007,	'Massas'),
(10008,	'Molhos')


INSERT INTO compra VALUES
(1234,	2,	200),
(2345,	4,	156),
(3456,	6,	354),
(4567,	3,	19)


SELECT co.valor FROM compra co, cliente cl
WHERE cl.codigo = co.cliente_codigo
		AND cl.nome LIKE '%Luis%'

SELECT co.valor FROM compra co, cliente cl
WHERE co.cliente_codigo = cl.codigo
		AND cl.nome LIKE '%Marcos%'

SELECT cl.endereco, cl.telefone FROM compra co, cliente cl
WHERE cl.codigo = co.cliente_codigo
		AND co.notaFiscal = 4567

SELECT me.valor FROM mercadoria me, tipoMercadoria tm
WHERE me.tipoMercadoria_codigo = tm.codigo
		AND tm.nome = 'Pães'

SELECT co.nome FROM corredores co, mercadoria me
WHERE co.codigo = me.corredores_codigo
		AND me.nome = 'Lasanha'


SELECT co.nome FROM corredores co, tipoMercadoria tm
WHERE co.tipoMercadoria_codigo = tm.codigo
		AND tm.nome = 'Clorados'














