CREATE DATABASE plano_saude
GO
USE plano_saude
GO
CREATE TABLE planoDeSaude(
codigo			INT			NOT NULL,
nome			VARCHAR(20)	NOT NULL,
telefone		VARCHAR(15)	NOT NULL
PRIMARY KEY(codigo)
)
GO
CREATE TABLE paciente(
cpf					VARCHAR(20)	NOT NULL,
nome				VARCHAR(20)	NOT NULL,
rua					VARCHAR(25)	NOT NULL,
num					INT			NOT NULL,
bairro				VARCHAR(15)	NOT NULL,
telefone			VARCHAR(15)	NOT NULL,
planoDeSaude_codigo	INT			NOT NULL
PRIMARY KEY(cpf),
FOREIGN KEY(planoDeSaude_codigo) REFERENCES planoDeSaude(codigo)
)
GO
CREATE TABLE medico(
codigo				INT			NOT NULL,
nome				VARCHAR(20)	NOT NULL,
especialidade		VARCHAR(25)	NOT NULL,
planoDeSaude_codigo	INT			NOT NULL,
PRIMARY KEY(codigo),
FOREIGN KEY(planoDeSaude_codigo) REFERENCES planoDeSaude(codigo)
)
GO
CREATE TABLE consulta(
medico_codigo		INT			NOT NULL,
paciente_cpf		VARCHAR(20)		NOT NULL,
dataHora			DATETIME	NOT NULL,
diagnostico			VARCHAR(20)	NOT NULL
PRIMARY KEY(dataHora, diagnostico),
FOREIGN KEY(medico_codigo) REFERENCES medico(codigo),
FOREIGN KEY(paciente_cpf) REFERENCES paciente(cpf)
)

INSERT INTO planoDeSaude VALUES
(1234,	'Amil',	41599856),
(2345,	'Sul América',	45698745),
(3456,	'Unimed',	48759836),
(4567,	'Bradesco Saúde',	47265897),
(5678,	'Intermédica',	41415269)

INSERT INTO paciente VALUES
(85987458920,	'Maria Paula',	'R. Voluntários da Pátria',	589,	'Santana',	'98458741',	2345),
(87452136900,	'Ana Julia',	'R. XV de Novembro',	657,	'Centro',	'69857412',	5678),
(23659874100,	'João Carlos',	'R. Sete de Setembro',	12,	'República',	'74859632',	1234),
(63259874100,	'José Lima',	'R. Anhaia',	768,	'Barra Funda',	'96524156',	2345)

INSERT INTO medico VALUES
(1,	'Claudio',	'Clínico Geral',	1234),
(2,	'Larissa',	'Ortopedista',	2345),
(3,	'Juliana',	'Otorrinolaringologista',	4567),
(4,	'Sérgio',	'Pediatra',	1234),
(5,	'Julio',	'Clínico Geral',	4567),
(6,	'Samara',	'Cirurgião',	1234)


INSERT INTO consulta VALUES
(1,	'85987458920',	'2021-02-10 10:30:00',	'Gripe'),
(2,	'23659874100',	'2021-02-10 11:00:00',	'Pé Fraturado'),
(4,	'85987458920',	'2021-02-11 14:00:00',	'Pneumonia'),
(1,	'23659874100',	'2021-02-11 15:00:00',	'Asma'),
(3,	'87452136900',	'2021-02-11 16:00:00',	'Sinusite'),
(5,	'63259874100',	'2021-02-11 17:00:00',	'Rinite'),
(4,	'23659874100',	'2021-02-11 18:00:00',	'Asma'),
(5,	'63259874100',	'2021-02-12 10:00:00',	'Rinoplastia')



SELECT me.nome, me.especialidade 
FROM medico me, planoDeSaude ps
WHERE me.planoDeSaude_codigo = ps.codigo
		AND ps.nome = 'Amil'




SELECT pa.nome, pa.rua + ', ' + CAST(pa.num AS CHAR(5)) + ', ' + pa.bairro AS endereco, pa.telefone, ps.nome
FROM paciente pa, planoDeSaude ps
WHERE ps.codigo = pa.planoDeSaude_codigo




SELECT ps.telefone FROM paciente pa, planoDeSaude ps
WHERE pa.planoDeSaude_codigo = ps.codigo
		AND pa.nome LIKE '%Ana%'



SELECT ps.nome FROM planoDeSaude ps LEFT OUTER JOIN paciente pa
ON ps.codigo = pa.planoDeSaude_codigo
WHERE ps.codigo NOT IN(
		SELECT pa.planoDeSaude_codigo FROM paciente pa
		)


SELECT ps.nome FROM planoDeSaude ps LEFT OUTER JOIN medico me
ON ps.codigo = me.planoDeSaude_codigo
WHERE ps.codigo NOT IN(
		SELECT me.planoDeSaude_codigo FROM medico me
		)



SELECT CONVERT(CHAR(10), co.dataHora, 103) AS data_consulta, CONVERT(CHAR(10), co.dataHora, 108) AS hora_consulta, me.nome, pa.nome, co.diagnostico 
FROM consulta co, medico me, paciente pa
WHERE co.medico_codigo = me.codigo
		AND co.paciente_cpf = pa.cpf


SELECT me.nome, co.dataHora, co.diagnostico FROM medico me, consulta co, paciente pa
WHERE co.medico_codigo = me.codigo
		AND co.paciente_cpf = pa.cpf
			AND pa.nome LIKE '%José%'



SELECT co.diagnostico, COUNT(co.diagnostico) as qtd FROM consulta co
GROUP BY co.diagnostico



SELECT COUNT(ps.codigo) as qtd FROM planoDeSaude ps LEFT OUTER JOIN medico me
ON ps.codigo = me.planoDeSaude_codigo
WHERE ps.codigo NOT IN(
		SELECT me.planoDeSaude_codigo FROM medico me
		)



UPDATE paciente
SET nome = 'João Carlos da Silva'
WHERE nome = 'João Carlos'


DELETE planoDeSaude
WHERE nome = 'Unimed'


EXEC sp_rename 'dbo.paciente.rua', 'logradouro', 'column'


--Inserir uma coluna, na tabela Paciente, de nome data_nasc e inserir os valores (1990-04-18,1981-03-25,2004-09-04 e 1986-06-18) respectivamente

ALTER TABLE paciente
ADD data_nasc			DATETIME			NULL

UPDATE paciente
SET data_nasc = '1990-04-18'
WHERE cpf = '85987458920'

UPDATE paciente
SET data_nasc = '1981-03-25'
WHERE cpf = '87452136900'

UPDATE paciente
SET data_nasc = '2004-09-04'
WHERE cpf = '23659874100'

UPDATE paciente
SET data_nasc = '1986-06-18'
WHERE cpf = '63259874100'




