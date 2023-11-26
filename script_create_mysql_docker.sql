CREATE DATABASE IF NOT EXISTS Mindbridge_maquina;
USE Mindbridge_maquina;

CREATE TABLE Maquina(
	id INT PRIMARY KEY AUTO_INCREMENT,
    hostname VARCHAR(50) NOT NULL,
	sistemaOperacional VARCHAR(50) NOT NULL,
	processador VARCHAR(50) NOT NULL,
	ram DOUBLE NOT NULL,
	armazenamento DOUBLE NOT NULL
    );

CREATE TABLE RegistroMaquina(
	id INT PRIMARY KEY AUTO_INCREMENT,
	dtRegistro DATETIME NOT NULL,
	usoRam DOUBLE,
	usoProcessador DOUBLE,
    fkMaquina INT NOT NULL,
	foreign key (fkMaquina) references Maquina(id)
);

CREATE TABLE Alertas(
	id INT PRIMARY KEY AUTO_INCREMENT,
	componente CHAR(3),
	tipo VARCHAR(45),
	fkRegistro INT,
	FOREIGN KEY (fkRegistro) REFERENCES RegistroMaquina(id),
	CHECK (tipo = 'Atenção' OR tipo = 'Crítico')
);

CREATE TABLE JanelasAbertas (
	id INT PRIMARY KEY AUTO_INCREMENT,
	dtRegistro DATETIME NOT NULL,
	PID INT NOT NULL,
	idJanela INT NOT NULL,
	titulo VARCHAR(1500),
	comando VARCHAR(1500),
	localizacao VARCHAR(1500),
	visivel VARCHAR(45),
	fkMaquina INT NOT NULL,
	foreign key (fkMaquina) references Maquina(id)
);

select * from maquina;
select * from registromaquina;
select * from alertas;
select * from JanelasAbertas;

select * from JanelasAbertas
	WHERE comando NOT LIKE '%Windows%';
    
    SELECT JanelasAbertas.titulo, COUNT(JanelasAbertas.id) as QuantidadeUtilizada
      FROM JanelasAbertas
      JOIN Maquina ON JanelasAbertas.fkMaquina = Maquina.id
      WHERE  JanelasAbertas.comando NOT LIKE '%Windows%'
      GROUP BY JanelasAbertas.titulo
		ORDER BY COUNT(JanelasAbertas.id) DESC
      LIMIT 5;
    