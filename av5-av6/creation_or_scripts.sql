-- Bloco PL para dropar todas as tabelas
DECLARE
  v_count NUMBER;
BEGIN
  SELECT COUNT(*) INTO v_count FROM user_tables;
  IF v_count > 0 THEN
    FOR rec IN (SELECT table_name FROM user_tables) LOOP
      EXECUTE IMMEDIATE 'DROP TABLE ' || rec.table_name || ' CASCADE CONSTRAINTS';
    END LOOP;
  END IF;
END;
/

-- Bloco PL para dropar todos os tipos
DECLARE
  v_count NUMBER;
BEGIN
  SELECT COUNT(*) INTO v_count FROM user_types;
  IF v_count > 0 THEN
    FOR rec IN (SELECT type_name FROM user_types) LOOP
      EXECUTE IMMEDIATE 'DROP TYPE ' || rec.type_name || ' FORCE';
    END LOOP;
  END IF;
END;
/


-- Tipos

CREATE OR REPLACE TYPE tp_endereco AS OBJECT (
    cep VARCHAR2(8),
    logradouro VARCHAR2(30),
    numero NUMBER,
    cidade VARCHAR2(20),
    estado VARCHAR2(20)
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

CREATE OR REPLACE TYPE tp_bagagem AS OBJECT(
    numero NUMBER,
    peso NUMBER
);
/

CREATE OR REPLACE TYPE tp_nt_bagagem AS TABLE OF tp_bagagem;
/

-- Entidades
CREATE OR REPLACE TYPE tp_pessoa AS OBJECT (
    cpf VARCHAR2(11),
    nome VARCHAR2(30),
    sobrenome VARCHAR2(30),
    email VARCHAR2(30),
    data_nascimento DATE,
    endereco tp_endereco,
    telefone tp_telefone,
    telefones_emergencia tp_telefones_emergencia
) NOT FINAL;
/

CREATE TABLE tb_pessoas OF tp_pessoa (
    cpf NOT NULL,
    nome NOT NULL,
    sobrenome NOT NULL,
    email NOT NULL,
    data_nascimento NOT NULL,
    endereco NOT NULL,
    telefones_emergencia NOT NULL,
    CONSTRAINT pk_pessoa PRIMARY KEY (cpf)
);
/

CREATE OR REPLACE TYPE tp_ref_tripulante AS OBJECT(
    ref_tripulante REF tp_tripulante
);
/

CREATE OR REPLACE TYPE tp_nt_tripulante AS TABLE OF tp_ref_tripulante;
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

CREATE OR REPLACE TYPE tp_ref_passageiro AS OBJECT(
    ref_passageiro REF tp_passageiro
);
/

CREATE TABLE tb_passageiros OF tp_passageiro (
    passaporte NOT NULL,
    preferencia_assento NOT NULL,
    nacionalidade NOT NULL,
    CONSTRAINT chk_preferencia_assento CHECK (preferencia_assento IN ('Janela', 'Meio', 'Corredor'))
) NESTED TABLE necessidades_especiais STORE AS nt_necessidades_especiais;
/

CREATE OR REPLACE TYPE tp_aeronave AS OBJECT (
    codigo NUMBER,
    modelo VARCHAR2(20),
    capacidade NUMBER,
    ano_fabricacao DATE
);
/

CREATE OR REPLACE TYPE tp_nt_aeronave AS TABLE OF tp_aeronave;
/

CREATE OR REPLACE TYPE tp_ref_aeronave AS OBJECT(
    ref_aeronave REF tp_aeronave
);
/

CREATE TABLE tb_aeronaves OF tp_aeronave (
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

CREATE OR REPLACE TYPE tp_ref_companhia_aerea AS OBJECT(
    ref_companhia_aerea REF tp_companhia_aerea
);
/

CREATE TABLE tb_companhias_aereas OF tp_companhia_aerea (
    cnpj NOT NULL,
    razao_social NOT NULL,
    frota_total_aeronaves NOT NULL,
    quantidade_total_funcionarios NOT NULL,
    CONSTRAINT pk_companhia_aerea PRIMARY KEY (cnpj)
) NESTED TABLE funcionarios STORE AS nt_funcionarios
NESTED TABLE aeronaves STORE AS nt_aeronaves;
/

CREATE OR REPLACE TYPE tp_aeroporto AS OBJECT (
    codigo NUMBER,
    nome VARCHAR2(30),
    endereco tp_endereco,
    pais VARCHAR2(30)
);
/

CREATE OR REPLACE TYPE tp_ref_aeroporto AS OBJECT(
    ref_aeroporto REF tp_aeroporto
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

CREATE OR REPLACE TYPE tp_ref_voo AS OBJECT(
    ref_voo REF tp_voo
);
/

CREATE TABLE tb_voos OF tp_voo (
    codigo NOT NULL,
    categoria NOT NULL,
    status_voo NOT NULL,
    CONSTRAINT pk_voo PRIMARY KEY (codigo),
    CONSTRAINT chk_categoria CHECK (categoria IN ('Internacional', 'Nacional')),
    CONSTRAINT chk_status_voo CHECK (status_voo IN ('Agendado', 'Em andamento', 'Concluido', 'Cancelado', 'Atrasado'))
);
/

-- Relações N:M modeladas como tabelas de junção
CREATE TABLE tb_opera (
    tripulante tp_ref_tripulante,
    aeronave tp_ref_aeronave,
    tripulante_id NUMBER, -- É necessário esse ID pois tripulante, nem aeronave podem ser chaves primárias
    aeronave_id NUMBER,   
    CONSTRAINT pk_opera PRIMARY KEY (tripulante_id, aeronave_id)
);
/

CREATE TABLE tb_acomoda (
    aeroporto tp_ref_aeroporto,
    companhia_aerea tp_ref_companhia_aerea,
    aeroporto_codigo NUMBER,
    companhia_aerea_cnpj VARCHAR2(14),
    CONSTRAINT pk_acomoda PRIMARY KEY (aeroporto_codigo, companhia_aerea_cnpj)
);
/

CREATE TABLE tb_reservas (
    voo tp_ref_voo,
    passageiro tp_ref_passageiro,
    voo_codigo NUMBER,
    passageiro_CPF VARCHAR2(11),
    bagagem tp_nt_bagagem,
    data_decolagem DATE NOT NULL,
    data_aterrissagem DATE NOT NULL,
    classe VARCHAR2(20) NOT NULL,
    status_reserva VARCHAR2(20) NOT NULL,
    numero_assento NUMBER NOT NULL,
    portao_embarque VARCHAR2(20) NOT NULL,
    origem NUMBER NOT NULL, -- codigo do aeroporto de origem
    destino NUMBER NOT NULL, -- codigo do aeroporto de destino
    CONSTRAINT pk_reservas PRIMARY KEY (voo_codigo, passageiro_CPF),
    CONSTRAINT chk_classe CHECK (classe IN ('Econômica', 'Executiva', 'Primeira Classe')),
    CONSTRAINT chk_status_reserva CHECK (status_reserva IN ('Confirmada', 'Cancelada', 'Em espera'))
) NESTED TABLE bagagem STORE AS nt_bagagens;
/

-- Relação N:N:1 
CREATE TABLE tb_voa(
    voo tp_ref_voo,
    aeroporto tp_ref_aeroporto,
    aeronave tp_ref_aeronave,
    voo_codigo NUMBER,
    aeroporto_codigo NUMBER,
    aeronave_codigo NUMBER,
    CONSTRAINT pk_voa PRIMARY KEY (voo_codigo, aeroporto_codigo, aeronave_codigo)
);
/