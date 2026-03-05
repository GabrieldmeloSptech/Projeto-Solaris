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
idCliente INT,
FOREIGN KEY (idCliente) REFERENCES cliente (idCliente),
nome VARCHAR(40),
cib CHAR(8), 
area DECIMAL (7,2)
);

CREATE TABLE endereco(
idEndereco INT PRIMARY KEY AUTO_INCREMENT,
idFazenda INT,
FOREIGN KEY (idFazenda) REFERENCES fazenda (idFazenda),
bairro VARCHAR(30),
cidade VARCHAR(40),
uf CHAR(2),
cep CHAR(8)
);

CREATE TABLE contato(
idContato INT PRIMARY KEY AUTO_INCREMENT,
idCliente INT,
FOREIGN KEY (idCliente) REFERENCES cliente (idCliente),
email VARCHAR(50),
telefone CHAR(10),
celular CHAR(11)
);

CREATE TABLE plantacao(
idPlantacao INT PRIMARY KEY AUTO_INCREMENT,
idFazenda INT,
FOREIGN KEY (idFazenda) REFERENCES fazenda (idFazenda),
area_hectar DECIMAL (10,2),
semente VARCHAR(20),
Qtdsol INT 
CONSTRAINT chQtdsol
CHECK (Qtdsol BETWEEN 0 AND 10));


CREATE TABLE leitura(
idLeitura INT PRIMARY KEY AUTO_INCREMENT,
idPlantacao INT,
FOREIGN KEY (idPlantacao) REFERENCES plantacao (idPlantacao),
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
idPlantacao INT,
FOREIGN KEY (idPlantacao) REFERENCES plantacao (idPlantacao),
situacao VARCHAR(10),
CONSTRAINT chSituacao
	CHECK(situacao IN ('Ativo', 'Inativo', 'Manutenção')),
dtInstalacao DATE
);


INSERT INTO fazenda VALUES
(default,1, 'Fazenda casinha branca', '12345678', 100.45),
(default,2, 'Fazenda verde e amarelo', '8765421', 50340.80);

INSERT INTO cliente VALUES
(default, 'José da Silva', null, '12345678910', 'senha123', default),
(default, 'Plantações LTD.', '12345678912345', null, 'senha234', default); 

INSERT INTO contato VALUES
(default,2, 'jessicadaiane@email.com', '1112338691', '11123383484'),
(default,1, 'joaopedefeijao@email.com', '1159843025', '11987654321'),
(default,1, 'joaogomes@email.com', null, null);


INSERT INTO endereco VALUES
(default,1,'Distrito da soja', 'miguelopolis', 'SP', '00892596'),
(default,2,'Distrito Agrícola', 'varzelandia', 'MG', '06754523');

INSERT INTO plantacao VALUES
(default, 1, 45.50, 'Trigo', 'Terreno do plantio é levemente irregular', default, 7),
(default, 2, 580.75, 'Soja', null, default, 10),
(default, 2, 268.00, 'Trigo', 'Plantio novo', default, 9);

INSERT INTO sensor VALUES
(default, 1, 'Manutenção', '2026-01-30'),
(default, 2, 'Ativo', '2026-02-21');

INSERT INTO leitura VALUES
(default, 1, '2026-01-30 06:50:00', '2026-01-30 11:50:00', 80.5, 1),
(default, 2, '2026-02-21 12:50:00', '2026-02-21 17:50:00', 98.7, 2);

