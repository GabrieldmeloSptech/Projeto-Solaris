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