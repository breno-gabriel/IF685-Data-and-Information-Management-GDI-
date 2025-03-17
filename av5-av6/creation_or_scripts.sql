-- Eliminando as tabelas, caso existam
DROP TABLE IF EXISTS tb_pessoas;
DROP TABLE IF EXISTS tb_tripulantes;
DROP TABLE IF EXISTS tb_passageiros;
DROP TABLE IF EXISTS tb_aeronaves;
DROP TABLE IF EXISTS tb_companhia_aerea;
DROP TABLE IF EXISTS tb_aeroportos;
DROP TABLE IF EXISTS tb_voos;

-- Eliminando os tipos, caso existam
DROP TYPE IF EXISTS tp_endereco;
DROP TYPE IF EXISTS tp_telefone;
DROP TYPE IF EXISTS tp_telefones_emergencia;
DROP TYPE IF EXISTS tp_passaporte;
DROP TYPE IF EXISTS tp_necessidade_especial;
DROP TYPE IF EXISTS tp_necessidades_especiais
DROP TYPE IF EXISTS tp_pessoa;
DROP TYPE IF EXISTS tp_tripulante;
DROP TYPE IF EXISTS tp_nt_tripulante;
DROP TYPE IF EXISTS tp_passageiro;
DROP TYPE IF EXISTS tp_aeronave;
DROP TYPE IF EXISTS tp_nt_aeronave;
DROP TYPE IF EXISTS tp_companhia_aerea;
DROP TYPE IF EXISTS tp_aeroporto;
DROP TYPE IF EXISTS tp_voo;

CREATE OR REPLACE TYPE tp_endereco AS OBJECT (
    cep VARCHAR2(8),
    logradouro VARCHAR2(30),
    numero NUMBER,
    cidade VARCHAR2(20),
    estado VARCHAR2(20),
);
/

CREATE OR REPLACE TYPE tp_telefone AS OBJECT (
    numero_telefone VARCHAR2(9),
    ddd VARCHAR2(3),
    codigo_pais VARCHAR2(2)
);
/

CREATE OR REPLACE TYPE tp_telefones_emergencia AS VARRAY(5) OF tp_telefone;
/

CREATE OR REPLACE TYPE tp_passaporte AS OBJECT (
    numero_passaporte VARCHAR2(10),
    pais_emissao VARCHAR2(30),
    data_emissao DATE,
    data_validade DATE
);
/

CREATE OR REPLACE TYPE tp_necessidade_especial AS OBJECT(
    necessidade_especial VARCHAR2(100)
);
/

CREATE OR REPLACE TYPE tp_necessidades_especiais AS TABLE OF tp_necessidade_especial; 
/

CREATE OR REPLACE TYPE tp_pessoa AS OBJECT (
    cpf VARCHAR2(11),
    nome VARCHAR2(30),
    sobrenome VARCHAR2(30),
    email VARCHAR2(30),
    data_nascimento DATE,
    endereco tp_endereco,
    telefone tp_telefone,
    telefones tp_telefones_emergencia
);
/

CREATE TABLE tb_pessoas OF tp_pessoa (
    cpf NOT NULL,
    nome NOT NULL,
    sobrenome NOT NULL,
    email NOT NULL,
    data_nascimento NOT NULL,
    endereco NOT NULL,
    telefones NOT NULL
    CONSTRAINT pk_pessoa PRIMARY KEY (cpf)
);
/

CREATE OR REPLACE TYPE tp_tripulante UNDER tp_pessoa (
    funcao VARCHAR2(30),
    salario NUMBER(13, 3),
    numero_funcionario NUMBER,
    data_contratacao DATE
);
/

CREATE OR REPLACE TYPE tp_nt_tripulante AS TABLE OF tp_tripulante;
/

CREATE OR REPLACE TYPE tp_tripulante UNDER tp_pessoa (
    funcao VARCHAR2(30),
    salario NUMBER(13, 3),
    numero_funcionario NUMBER,
    data_contratacao DATE,
    supervisionados tp_nt_tripulante
);
/

CREATE TABLE tb_tripulantes OF tp_tripulante(
    funcao NOT NULL,
    salario NOT NULL,
    numero_funcionario NOT NULL,
    data_contratacao NOT NULL
)
NESTED TABLE supervisionados STORE AS nt_supervisionados;
/

CREATE OR REPLACE TYPE tp_passageiro UNDER tp_pessoa (
    passaporte tp_passaporte,
    necessidades_especiais tp_necessidades_especiais,
    preferencia_assento VARCHAR2(20),
    nacionalidade VARCHAR2(30)
);
/

CREATE TABLE tb_passageiros OF tp_passageiro (
    passaporte NOT NULL,
    necessidades_especiais NOT NULL,
    preferencia_assento NOT NULL,
    nacionalidade NOT NULL,
    CONSTRAINT chk_preferencia_assento CHECK (preferencia_assento IN ('Janela', 'Meio', 'Corredor')),
) NESTED TABLE necessidades_especiais STORE AS nt_necessidades_especiais;
/

CREATE OR REPLACE TYPE tp_aeronave AS OBJECTO (
    codigo NUMBER,
    modelo VARCHAR2(20),
    capacidade NUMBER,
    ano_fabricacao DATE,
);
/

CREATE OR REPLACE TYPE tp_nt_aeronave AS TABLE OF tp_aeronave;

CREATE TABLE tp_aeronaves OF tp_aeronave (
    codigo NOT NULL,
    modelo NOT NULL,
    capacidade NOT NULL,
    ano_fabricacao NOT NULL,
    CONSTRAINT pk_aeronave PRIMARY KEY (codigo)
);
/

CREATE OR REPLACE TYPE tp_companhia_aerea AS OBJECT (
    cnpj VARCHAR2(14),
    razao_social VARCHAR2(50),
    frota_total_aeronaves NUMBER,
    quantidade_total_funcionarios NUMBER,
    funcionarios tp_nt_tripulante,
    aeronaves tp_nt_aeronave    
);
/

CREATE TABLE tb_companhia_aerea OF tp_companhia_aerea (
    cnpj NOT NULL,
    razao_social NOT NULL,
    frota_total_aeronaves NOT NULL,
    quantidade_total_funcionarios NOT NULL,
    funcionarios NOT NULL,
    CONSTRAINT pk_companhia_aerea PRIMARY KEY (cnpj)
) NESTED TABLE funcionarios STORE AS nt_necessidades_especiais
NESTED TABLE aeronaves STORE AS nt_aeronaves;
/

CREATE OR REPLACE TYPE tp_aeroporto AS OBJECT (
    codigo NUMBER,
    nome VARCHAR2(30),
    endereco tp_endereco,
    pais VARCHAR2(30),
);
/

CREATE TABLE tb_aeroportos OF tp_aeroporto (
    codigo NOT NULL,
    nome NOT NULL,
    endereco NOT NULL,
    pais NOT NULL,
    CONSTRAINT pk_aeroporto PRIMARY KEY (codigo)
);
/

CREATE OR REPLACE TYPE tp_voo AS OBJECT (
    codigo NUMBER,
    categoria VARCHAR2(20),
    status_voo VARCHAR2(20)
);
/

CREATE TABLE tb_voos OF tp_voo (
    codigo NOT NULL,
    categoria NOT NULL,
    status_voo NOT NULL,
    CONSTRAINT pk_voo PRIMARY KEY (codigo),
    CONSTRAINT chk_categoria CHECK (categoria IN ('Internacional', 'Nacional')),
    CONSTRAINT chk_status_voo CHECK (status_voo IN ('Agendando', 'Em andamento', 'Concluido', 'Cancelado'))
);
/