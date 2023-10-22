-- DROP DATABASE if exists Mindbridge;
CREATE DATABASE if not exists Mindbridge;
USE Mindbridge;

CREATE TABLE InstituicaoEnsino(
idInstituicaoEnsino INT PRIMARY KEY AUTO_INCREMENT,
nomeEscola VARCHAR(50) NOT NULL,
CNPJ INT NOT NULL,
CEP INT NOT NULL,
Logradouro VARCHAR(50) NOT NULL,
numeroLogradouro VARCHAR(6) NOT NULL,
Complemento VARCHAR(6),
Bairro VARCHAR(50) NOT NULL,
Cidade VARCHAR(50) NOT NULL,
Estado VARCHAR(50) NOT NULL,
Telefone VARCHAR(25) NOT NULL,
modalidadeEnsino VARCHAR(50) NOT NULL,
CHECK (modalidadeEnsino = 'Escola' OR modalidadeEnsino = 'Escola de Cursos' OR 
modalidadeEnsino = 'Escola Técnica' OR modalidadeEnsino  = 'Universidade')
);

insert into InstituicaoEnsino values (null, 'Colégio Santo André',473478393,24976910,'Avenida Sapopemba','8900',null,'Jardim Sapopemba', 'São Paulo','SP','1127689453','Escola');

CREATE TABLE UsuarioInstituicao(
idAdmin INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(50) NOT NULL,
sobrenome VARCHAR(50) NOT NULL,
email VARCHAR(100)NOT NULL,
senha VARCHAR(50),
fkInstituicao INT,
FOREIGN KEY (fkInstituicao) REFERENCES InstituicaoEnsino(idInstituicaoEnsino)
);

-- update UsuarioInstituicao set senha = "sptech123" where idAdmin = 1;
-- select * from InstituicaoEnsino inner join UsuarioInstituicao;

CREATE TABLE UsuarioAluno(
idAluno INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(50) NOT NULL,
sobrenome VARCHAR(50) NOT NULL,
email VARCHAR(100)NOT NULL,
senha VARCHAR(50),
fkInstituicao INT,
FOREIGN KEY (fkInstituicao) REFERENCES InstituicaoEnsino(idInstituicaoEnsino)
);

insert into UsuarioAluno VALUES (null, 'Matheus', 'Lima', 'matheus.slima@sptech.school', 'sptech123', 1);

CREATE TABLE Pontuacao(
idPontuacao INT PRIMARY KEY AUTO_INCREMENT,
Pontos INT,
fkAluno INT,
FOREIGN KEY (fkAluno) REFERENCES UsuarioAluno(idAluno)
);

CREATE TABLE ociosidade (
idOciosidade int primary key auto_increment,
hora time,
fkAluno int,
FOREIGN KEY (fkAluno) REFERENCES UsuarioAluno(idAluno),
fkInstituicao int,
FOREIGN KEY (fkInstituicao) REFERENCES InstituicaoEnsino(idInstituicaoEnsino)
);

CREATE TABLE programas(
idProgramas int primary key,
nome varchar(45),
fkAluno int,
FOREIGN KEY (fkAluno) REFERENCES UsuarioAluno(idAluno),
fkInstituicao int,
FOREIGN KEY (fkInstituicao) REFERENCES InstituicaoEnsino(idInstituicaoEnsino)
);

CREATE TABLE Sala(
idSala INT PRIMARY KEY AUTO_INCREMENT,
Numero INT,
Andar INT,
fkInstituicao INT,
FOREIGN KEY (fkInstituicao) REFERENCES InstituicaoEnsino(idInstituicaoEnsino)
);
CREATE TABLE Turma(
idTurma INT PRIMARY KEY auto_increment,
nomeTurma VARCHAR(50),
ano varchar(45)
);

CREATE TABLE Horario(
idHorario INT PRIMARY KEY auto_increment,
Inicio varchar(50),
Fim varchar(50),
fkTurma INT,
FOREIGN KEY (fkTurma) REFERENCES Turma(idTurma)
);

CREATE TABLE Maquinas(
idMaquinas INT PRIMARY KEY AUTO_INCREMENT,
IP INT NOT NULL,
SistemaOperacional VARCHAR(50) NOT NULL,
Processador VARCHAR(50) NOT NULL,
RAM INT NOT NULL,
Disco INT NOT NULL,
fkInstituicao INT,
FOREIGN KEY (fkInstituicao) REFERENCES InstituicaoEnsino(idInstituicaoEnsino),
fkSala INT,
FOREIGN KEY (fkSala) REFERENCES Sala(idSala)
);

CREATE TABLE registroMaquina(
idRegistroMaquina INT PRIMARY KEY AUTO_INCREMENT,
TemperaturaProcessador varchar(50),
usoRam varchar(50),
usoProcessador varchar(50),
usoDisco varchar(50),
downloadRede varchar(50),
dispositivosUSB varchar(50),
dtHora TIMESTAMP NOT NULL default current_timestamp,
fkMaquinas INT,
FOREIGN KEY (fkMaquinas) REFERENCES Maquinas(idMaquinas)
);

CREATE TABLE Alertas(
idAlerta INT PRIMARY KEY AUTO_INCREMENT,
dataHora DATETIME,
fkMaquinas INT,
FOREIGN KEY (fkMaquinas) REFERENCES Maquinas(idMaquinas)
);

-- select * from registroMaquina;