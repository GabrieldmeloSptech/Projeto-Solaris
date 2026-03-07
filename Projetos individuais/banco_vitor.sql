CREATE DATABASE projeto;

USE projeto;

CREATE TABLE empresa(
idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
nomeEmpresa VARCHAR (50) NOT NULL,
cnpjEmpresa CHAR(14) NOT NULL UNIQUE,
senhaEmpresa VARCHAR(50) NOT NULL,
dtCadastro DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE plantio(
idPlantio INT AUTO_INCREMENT PRIMARY KEY,
areaTotal VARCHAR(255),
semente VARCHAR(50),
idEmpresa INT,
FOREIGN KEY (idEmpresa) REFERENCES empresa (idEmpresa),
informacaoArea VARCHAR(50),
dtCadastro DATE
);

CREATE TABLE sensorLeitura(
idLeitura INT PRIMARY KEY AUTO_INCREMENT,
sensor VARCHAR(50),
idEmpresa INT,
FOREIGN KEY (idEmpresa) REFERENCES empresa (idEmpresa),
situacaoSensor VARCHAR(50) NOT NULL,
CONSTRAINT chSituacao 
CHECK (situacaoSensor = 'Ativo' OR situacaoSensor = 'Inativo' OR situacaoSensor = 'Manunteção'),
dtInstalcao DATE
);
