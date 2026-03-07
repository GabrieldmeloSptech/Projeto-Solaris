CREATE DATABASE solaris;
USE solaris;

CREATE TABLE usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf CHAR(11) UNIQUE,
    cnpj CHAR(14) UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    telefone CHAR(10),
    celular CHAR(11),
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE fazenda (
    id_fazenda INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    nome_fazenda VARCHAR(100) NOT NULL,
    area_total DECIMAL(10,2),
    cib CHAR(8), -- certificado imobiliário brasileiro
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

CREATE TABLE endereco (
    id_endereco INT AUTO_INCREMENT PRIMARY KEY,
    id_fazenda INT NOT NULL,
    estrada VARCHAR(60),
    bairro VARCHAR(40),
    cidade VARCHAR(40),
    uf CHAR(2),
    cep CHAR(8),
    ponto_referencia VARCHAR(100),
    FOREIGN KEY (id_fazenda) REFERENCES fazenda(id_fazenda)
);

CREATE TABLE area_plantio (
    id_area INT AUTO_INCREMENT PRIMARY KEY,
    id_fazenda INT NOT NULL,
    nome_area VARCHAR(100),
    cultura VARCHAR(50),
    area_hectare DECIMAL(10,2),
    descricao VARCHAR(255),
    data_cadastro DATE DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_fazenda) REFERENCES fazenda(id_fazenda)
);

CREATE TABLE sensor (
    id_sensor INT AUTO_INCREMENT PRIMARY KEY,
    id_area INT NOT NULL,
    situacao VARCHAR(15),
    data_instalacao DATE,
    CONSTRAINT chSituacao
    CHECK (situacao IN ('Ativo','Inativo','Manutenção')),
    FOREIGN KEY (id_area) REFERENCES area_plantio(id_area)
);


CREATE TABLE leitura_luminosidade (
    id_leitura INT AUTO_INCREMENT PRIMARY KEY,
    id_sensor INT NOT NULL,
    valor_luminosidade INT NOT NULL,
    data_hora DATETIME NOT NULL,
    FOREIGN KEY (id_sensor) REFERENCES sensor(id_sensor)
);

INSERT INTO usuario (nome, cpf, cnpj, email, senha, telefone, celular)
VALUES 
('João da Silva', '12345678901', NULL, 'joao@email.com', 'senha123', '1134567890', '11987654321'), -- com cpf
('AgroTech LTDA', NULL, '12345678000199', 'contato@agrotech.com', 'senha456', '1145678901', '11991234567'); -- cnpj

INSERT INTO fazenda (id_usuario, nome_fazenda, area_total, cib)
VALUES
(1, 'Fazenda Sol Nascente', 150.50, 'A1234567'),
(2, 'Fazenda Boa Colheita', 320.75, 'B7654321');

INSERT INTO endereco (id_fazenda, estrada, bairro, cidade, uf, cep, ponto_referencia)
VALUES
(1, 'Estrada Rural SP-45', 'Zona Rural', 'Ribeirão Preto', 'SP', '14000000', 'Próximo ao silo de milho'),
(2, 'Rodovia MG-12', 'Distrito Agrícola', 'Uberlândia', 'MG', '38400000', 'Próximo ao posto agrícola');

INSERT INTO area_plantio (id_fazenda, nome_area, cultura, area_hectare, descricao)
VALUES
(1, 'Talhão Norte', 'Soja', 45.30, 'Área com ótima incidência solar durante todo o dia'),
(1, 'Talhão Sul', 'Milho', 30.00, 'Área parcialmente sombreada pela manhã'),
(2, 'Plantio Leste', 'Trigo', 80.50, 'Área recém preparada para plantio'),
(2, 'Plantio Oeste', 'Soja', 120.00, 'Grande área destinada à produção de soja');

INSERT INTO sensor (id_area, situacao, data_instalacao)
VALUES
(1, 'Ativo', '2026-02-10'),
(2, 'Ativo', '2026-02-12'),
(3, 'Manutenção', '2026-02-15'),
(4, 'Ativo', '2026-02-18');

INSERT INTO leitura_luminosidade (id_sensor, valor_luminosidade, data_hora)
VALUES
(1, 720, '2026-03-01 08:00:00'),
(1, 850, '2026-03-01 12:00:00'),
(1, 640, '2026-03-01 17:00:00'),
(2, 600, '2026-03-01 08:10:00'),
(2, 780, '2026-03-01 12:10:00'),
(2, 590, '2026-03-01 17:10:00'),
(3, 500, '2026-03-01 09:00:00'),
(4, 900, '2026-03-01 11:00:00'),
(4, 870, '2026-03-01 15:00:00');