CREATE DATABASE solaris;
USE solaris;

CREATE TABLE cliente(
idCliente INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(50),
cnpj CHAR(14),
cpf CHAR(11),
senha INT NOT NULL,
dtCadastro DATE
);

CREATE TABLE fazenda(
idFazenda INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(40),
idCliente INT,
FOREIGN KEY (idCliente) REFERENCES cliente (idCliente),
cib CHAR(8), -- Certificado Imobiliário Brasileiro, código identificador de propriedades rurais
area INT
);

CREATE TABLE endereco(
idEndereco INT PRIMARY KEY AUTO_INCREMENT,
idFazenda INT,
FOREIGN KEY (idFazenda) REFERENCES fazenda (idFazenda),
erd CHAR, -- Endereço Rural Digital
estrada VARCHAR(40),
km VARCHAR(4),
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
email VARCHAR(40),
telefone CHAR(10),
celular CHAR(11)
);

CREATE TABLE plantio(
idPlantio INT PRIMARY KEY AUTO_INCREMENT,
idFazenda INT,
FOREIGN KEY (idFazenda) REFERENCES fazenda (idFazenda),
area INT,
cultura VARCHAR(20),
comentario VARCHAR(240),
dtCadastro DATE,
qualidade VARCHAR(20) -- Aqui, indicar se é uma área que recebe uma quantidade menor, maior ou suficiente de Sol
);

CREATE TABLE leitura(
idLeitura INT PRIMARY KEY AUTO_INCREMENT,
idPlantio INT,
FOREIGN KEY (idPlantio) REFERENCES plantio (idPlantio),
inicio DATETIME,
termino DATETIME,
mediaLuz DECIMAL(5,2)
);