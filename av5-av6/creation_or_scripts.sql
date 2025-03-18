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

CREATE OR REPLACE TYPE BODY tp_pessoa AS
    -- Constructor function
    CONSTRUCTOR FUNCTION tp_pessoa(
        p_cpf VARCHAR2,
        p_nome VARCHAR2,
        p_sobrenome VARCHAR2,
        p_email VARCHAR2,
        p_data_nascimento DATE
    ) RETURN SELF AS RESULT IS
    BEGIN
        self.cpf := p_cpf;
        self.nome := p_nome;
        self.sobrenome := p_sobrenome;
        self.email := p_email;
        self.data_nascimento := p_data_nascimento;
        RETURN;
    END;

    -- Member function to get full name
    MEMBER FUNCTION get_nome_completo RETURN VARCHAR2 IS
    BEGIN
        RETURN self.nome || ' ' || self.sobrenome;
    END;

    -- Member function to get age
    MEMBER FUNCTION get_idade RETURN NUMBER IS
    BEGIN
        RETURN FLOOR(MONTHS_BETWEEN(SYSDATE, self.data_nascimento) / 12);
    END;
END;
/

CREATE OR REPLACE TYPE tp_tripulante UNDER tp_pessoa (
    funcao VARCHAR2(30),
    salario NUMBER(13, 3),
    numero_funcionario NUMBER,
    data_contratacao DATE,
    supervisionados tp_nt_tripulante
);
/

CREATE OR REPLACE TYPE BODY tp_tripulante AS
    -- Member function to get total supervisionados
    MEMBER FUNCTION get_total_supervisionados RETURN NUMBER IS
    BEGIN
        IF self.supervisionados IS NULL THEN
            RETURN 0;
        END IF;
        RETURN self.supervisionados.COUNT;
    END;

    -- Member procedure to add supervisionado
    MEMBER PROCEDURE add_supervisionado(p_ref_tripulante REF tp_tripulante) IS
        v_ref tp_ref_tripulante := tp_ref_tripulante(p_ref_tripulante);
    BEGIN
        IF self.supervisionados IS NULL THEN
            self.supervisionados := tp_nt_tripulante();
        END IF;
        self.supervisionados.extend;
        self.supervisionados(self.supervisionados.last) := v_ref;
    END;

    -- Order member function to compare salaries
    ORDER MEMBER FUNCTION compare_salary(p_tripulante IN tp_tripulante) RETURN INTEGER IS
    BEGIN
        IF self.salario < p_tripulante.salario THEN
            RETURN -1;
        ELSIF self.salario > p_tripulante.salario THEN
            RETURN 1;
        ELSE
            RETURN 0;
        END IF;
    END;
END;
/

CREATE OR REPLACE TYPE tp_ref_tripulante AS OBJECT(
    ref_tripulante REF tp_tripulante
);
/

CREATE OR REPLACE TYPE tp_nt_tripulante AS TABLE OF tp_ref_tripulante;
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

CREATE OR REPLACE TYPE BODY tp_passageiro AS
    -- Override constructor
    OVERRIDING CONSTRUCTOR FUNCTION tp_passageiro(
        p_cpf VARCHAR2,
        p_nome VARCHAR2,
        p_sobrenome VARCHAR2,
        p_email VARCHAR2,
        p_data_nascimento DATE,
        p_nacionalidade VARCHAR2
    ) RETURN SELF AS RESULT IS
    BEGIN
        self.cpf := p_cpf;
        self.nome := p_nome;
        self.sobrenome := p_sobrenome;
        self.email := p_email;
        self.data_nascimento := p_data_nascimento;
        self.nacionalidade := p_nacionalidade;
        RETURN;
    END;

    -- Member procedure to add necessidade especial
    MEMBER PROCEDURE add_necessidade_especial(p_necessidade VARCHAR2) IS
        v_necessidade tp_necessidade_especial := tp_necessidade_especial(p_necessidade);
    BEGIN
        IF self.necessidades_especiais IS NULL THEN
            self.necessidades_especiais := tp_necessidades_especiais();
        END IF;
        self.necessidades_especiais.extend;
        self.necessidades_especiais(self.necessidades_especiais.last) := v_necessidade;
    END;
END;
/

CREATE OR REPLACE TYPE tp_ref_passageiro AS OBJECT(
    ref_passageiro REF tp_passageiro
);
/

CREATE TABLE tb_passageiros OF tp_passageiro (
    passaporte NOT NULL,
    necessidades_especiais NOT NULL,
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

CREATE OR REPLACE TYPE tp_ref_aeronave AS OBJECT(
    ref_aeronave REF tp_aeronave
);
/

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

CREATE OR REPLACE TYPE BODY tp_companhia_aerea AS
    -- Member function to get total funcionarios
    MEMBER FUNCTION get_total_funcionarios RETURN NUMBER IS
    BEGIN
        IF self.funcionarios IS NULL THEN
            RETURN 0;
        END IF;
        RETURN self.funcionarios.COUNT;
    END;

    -- Member function to get total aeronaves
    MEMBER FUNCTION get_total_aeronaves RETURN NUMBER IS
    BEGIN
        IF self.aeronaves IS NULL THEN
            RETURN 0;
        END IF;
        RETURN self.aeronaves.COUNT;
    END;

    -- Member procedure to add funcionario
    MEMBER PROCEDURE add_funcionario(p_ref_tripulante REF tp_tripulante) IS
        v_ref tp_ref_tripulante := tp_ref_tripulante(p_ref_tripulante);
    BEGIN
        IF self.funcionarios IS NULL THEN
            self.funcionarios := tp_nt_tripulante();
        END IF;
        self.funcionarios.extend;
        self.funcionarios(self.funcionarios.last) := v_ref;
    END;

    -- Member procedure to add aeronave
    MEMBER PROCEDURE add_aeronave(p_aeronave tp_aeronave) IS
    BEGIN
        IF self.aeronaves IS NULL THEN
            self.aeronaves := tp_nt_aeronave();
        END IF;
        self.aeronaves.extend;
        self.aeronaves(self.aeronaves.last) := p_aeronave;
    END;
END;
/

CREATE OR REPLACE TYPE tp_ref_companhia_aerea AS OBJECT(
    ref_companhia_aerea REF tp_companhia_aerea
);
/

CREATE TABLE tb_companhia_aerea OF tp_companhia_aerea (
    cnpj NOT NULL,
    razao_social NOT NULL,
    frota_total_aeronaves NOT NULL,
    quantidade_total_funcionarios NOT NULL,
    funcionarios NOT NULL,
    CONSTRAINT pk_companhia_aerea PRIMARY KEY (cnpj)
) NESTED TABLE funcionarios STORE AS nt_funcionarios
NESTED TABLE aeronaves STORE AS nt_aeronaves;
/

CREATE OR REPLACE TYPE tp_aeroporto AS OBJECT (
    codigo NUMBER,
    nome VARCHAR2(30),
    endereco tp_endereco,
    pais VARCHAR2(30),
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
    tripulante tp_ref_tripulante NOT NULL,
    aeronave tp_ref_aeronave NOT NULL,
    CONSTRAINT pk_opera PRIMARY KEY (tripulante, aeronave)
);
/

CREATE TABLE tb_acomoda (
    aeroporto tp_ref_aeroporto NOT NULL,
    companhia_aerea tp_ref_companhia_aerea NOT NULL,
    CONSTRAINT pk_acomoda PRIMARY KEY (aeroporto, companhia_aerea)
);
/

CREATE TABLE tb_reservas (
    voo tp_ref_voo NOT NULL,
    passageiro tp_ref_passageiro NOT NULL,
    bagagem tp_nt_bagagem NOT NULL,
    data_decolagem DATE NOT NULL,
    data_aterrissagem DATE NOT NULL,
    classe VARCHAR2(20) NOT NULL,
    status_reserva VARCHAR2(20) NOT NULL,
    numero_assento NUMBER NOT NULL,
    portao_embarque VARCHAR2(20) NOT NULL,
    origem NUMBER NOT NULL, -- codigo do aeroporto de origem
    destino NUMBER NOT NULL, -- codigo do aeroporto de destino
    CONSTRAINT pk_reservas PRIMARY KEY (voo, passageiro),
    CONSTRAINT chk_classe CHECK (classe IN ('Econômica', 'Executiva', 'Primeira Classe')),
    CONSTRAINT chk_status_reserva CHECK (status_reserva IN ('Confirmada', 'Cancelada', 'Em espera')),
) NESTED TABLE bagagem STORE AS nt_bagagens;
/

-- Relação N:N:1 
CREATE TABLE tb_voa(
    voo tp_ref_voo,
    aeroporto tp_ref_aeroporto,
    aeronave tp_ref_aeronave,
    CONSTRAINT pk_voa PRIMARY KEY (voo, aeroporto, aeronave)
);
/

-- Example of using SCOPE IS
ALTER TYPE tp_ref_tripulante ADD SCOPE FOR (ref_tripulante) IS tb_tripulantes;
ALTER TYPE tp_ref_passageiro ADD SCOPE FOR (ref_passageiro) IS tb_passageiros;
ALTER TYPE tp_ref_companhia_aerea ADD SCOPE FOR (ref_companhia_aerea) IS tb_companhia_aerea;

-- Example of inserting with constructor
INSERT INTO tb_pessoas 
VALUES (
    tp_pessoa(
        '12345678901',
        'João',
        'Silva',
        'joao@email.com',
        TO_DATE('1990-01-01', 'YYYY-MM-DD'),
        tp_endereco('12345678', 'Rua A', 123, 'São Paulo', 'SP'),
        tp_telefone('123456789', '011', '55'),
        tp_telefones_emergencia(
            tp_telefone('987654321', '011', '55')
        )
    )
);

-- Adding missing features

-- 1. NOT INSTANTIABLE type and member
CREATE OR REPLACE TYPE tp_funcionario AS OBJECT (
    id NUMBER,
    cargo VARCHAR2(30)
) NOT INSTANTIABLE NOT FINAL;
/

-- 2. MAP MEMBER FUNCTION example
CREATE OR REPLACE TYPE tp_produto AS OBJECT (
    codigo NUMBER,
    preco NUMBER,
    MAP MEMBER FUNCTION get_order RETURN NUMBER
);
/

CREATE OR REPLACE TYPE BODY tp_produto AS
    MAP MEMBER FUNCTION get_order RETURN NUMBER IS
    BEGIN
        RETURN preco;
    END;
END;
/

-- 3. FINAL MEMBER example
CREATE OR REPLACE TYPE tp_cliente AS OBJECT (
    id NUMBER,
    nome VARCHAR2(100),
    FINAL MEMBER FUNCTION get_id RETURN NUMBER
);
/

CREATE OR REPLACE TYPE BODY tp_cliente AS
    FINAL MEMBER FUNCTION get_id RETURN NUMBER IS
    BEGIN
        RETURN self.id;
    END;
END;
/

-- 4. More ALTER TYPE examples
ALTER TYPE tp_pessoa ADD ATTRIBUTE (
    data_cadastro DATE
) CASCADE;

-- 5. WITH ROWID REFERENCES example
CREATE TABLE tb_historico_voos (
    id NUMBER PRIMARY KEY,
    voo_ref REF tp_voo WITH ROWID
);