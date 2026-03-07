-- GRUPO 10
/*
Carlos Vinicius Lázaro Silva, Gabriel Fernandes Gonzalez de Melo, Max Araújo Silva, Matheus Barros Profeta, 
Pedro Henrique Marques Borelli, Theodoro Fernando de Andrade Salvador, Vitor Henrique Machado
*/


CREATE DATABASE solaris;
USE solaris;

CREATE TABLE cliente(
idCliente INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(50),
cnpj CHAR(14) UNIQUE,
cpf CHAR(11) UNIQUE,
senha VARCHAR(25) NOT NULL,
dtCadastro DATE DEFAULT (CURDATE())
);

CREATE TABLE fazenda(
idFazenda INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(40),
idCliente INT,
FOREIGN KEY (idCliente) REFERENCES cliente (idCliente),
cib CHAR(8), -- Certificado Imobiliário Brasileiro, código identificador de propriedades rurais
area DECIMAL (7,2)
);

CREATE TABLE endereco(
idEndereco INT PRIMARY KEY AUTO_INCREMENT,
idFazenda INT,
FOREIGN KEY (idFazenda) REFERENCES fazenda (idFazenda),
erd CHAR(11), -- Endereço Rural Digital
estrada VARCHAR(40),
km VARCHAR(8),
bairro VARCHAR(30),
cidade VARCHAR(40),
uf CHAR(2),
cep CHAR(8),
ptReferencia VARCHAR(60)
);

CREATE TABLE contato(
idContato INT PRIMARY KEY AUTO_INCREMENT,
idCliente INT,
FOREIGN KEY (idCliente) REFERENCES cliente (idCliente),
email VARCHAR(40) UNIQUE,
telefone CHAR(10),
celular CHAR(11)
);

CREATE TABLE plantio(
idPlantio INT PRIMARY KEY AUTO_INCREMENT,
idFazenda INT,
FOREIGN KEY (idFazenda) REFERENCES fazenda (idFazenda),
area DECIMAL (7,2),
cultura VARCHAR(20),
comentario VARCHAR(240),
dtCadastro DATE DEFAULT(CURDATE()),
qualidade INT -- Aqui, indicar se é uma área que recebe uma quantidade menor, maior ou suficiente de Sol
CONSTRAINT chQualidade
CHECK (qualidade BETWEEN 0 AND 10)
);

CREATE TABLE leitura(
idLeitura INT PRIMARY KEY AUTO_INCREMENT,
idPlantio INT,
FOREIGN KEY (idPlantio) REFERENCES plantio (idPlantio),
idSensor INT,
FOREIGN KEY (idSensor) REFERENCES sensor (idSensor),
inicio DATETIME,
termino DATETIME,
mediaLuz DECIMAL(5,2)
CONSTRAINT chMediaLuz
	CHECK(mediaLuz BETWEEN 0 AND 100)
);

CREATE TABLE sensor(
idSensor INT PRIMARY KEY AUTO_INCREMENT,
idPlantio INT,
FOREIGN KEY (idPlantio) REFERENCES plantio (idPlantio),
situacao VARCHAR(10),
CONSTRAINT chSituacao
	CHECK(situacao IN ('Ativo', 'Inativo', 'Manutenção')),
dtInstalacao DATE
);

-- INSERÇÃO DE DADOS

INSERT INTO cliente VALUES
(default, 'José Silva', null, '12345678910', 'senha123', default), -- Como é uma pessoa física, o campo do CNPJ fica nulo e o CPF é preenchido.
(default, 'Plantações LTD.', '12345678912345', null, 'senha234', default); -- Como é uma empresa, o campo do CPF fica nulo e o CNPJ é preenchido.

INSERT INTO contato VALUES
(default, 1, 'josesilva@email.com', '1112345678', '11912345678'),
(default, 2, 'plantacoesltd@email.com', '118765421', '11987654321'),
(default, 1, 'contato.jose.silva@email.com', null, null);

INSERT INTO fazenda VALUES
(default, 'Fazenda Família Silva', 1, '12345678', 100.45),
(default, 'Fazenda Produção de Soja', 2, '8765421', 50340.80);

INSERT INTO endereco VALUES
(default, 1, '12345678910', 'Estrada dos Campos', '70', 'Distrito dos Campos', 'Ribeirão Preto', 'SP', '00012345', 'Macieira grande e torta na esquerda'),
(default, 2, '01987654321', 'Rodovia Agrícola', '122', 'Distrito Agrícola', 'Varginha', 'MG', '00054321', null);

INSERT INTO plantio VALUES
(default, 1, 45.50, 'Trigo', 'Terreno do plantio é levemente irregular', default, 7),
(default, 2, 580.75, 'Soja', null, default, 10),
(default, 2, 268.00, 'Trigo', 'Plantio novo', default, 9);

INSERT INTO sensor VALUES
(default, 1, 'Manutenção', '2026-01-30'),
(default, 2, 'Ativo', '2026-02-21');

INSERT INTO leitura VALUES
(default, 1, '2026-01-30 06:50:00', '2026-01-30 11:50:00', 80.5, 1),
(default, 2, '2026-02-21 12:50:00', '2026-02-21 17:50:00', 98.7, 2);

-- CONSULTAS

-- Exibir dados de qualidade mostrando a classificação a partir do valor numérico obtido
SELECT qualidade, CASE
WHEN qualidade BETWEEN 0 AND 4 THEN 'Pouca luminosidade'
WHEN qualidade IN (5,6) THEN 'Luminosidade Média'
WHEN qualidade BETWEEN 7 AND 9 THEN 'Luminosidade ideal'
ELSE 'Luz excessiva'
END AS Qualidade_da_Luz
FROM plantio;

SELECT * FROM cliente WHERE cpf IS NULL; -- Exibir apenas dados de clientes que são empresas

SELECT * FROM cliente WHERE cnpj IS NULL; -- Exibir apenas dados de clientes que são pessoas físicas

SELECT * FROM contato WHERE idCliente = 1; -- Exibir todos os contatos do cliente de ID 1

SELECT * FROM endereco; -- Exibir endereços das fazendas

SELECT * FROM plantio WHERE idFazenda = 2; -- Exibir plantios da fazenda de ID 2