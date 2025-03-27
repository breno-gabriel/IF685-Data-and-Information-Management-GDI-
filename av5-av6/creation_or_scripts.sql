

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
CREATE OR REPLACE TYPE tp_endereco AS OBJECT (
    cep VARCHAR2(8),
    logradouro VARCHAR2(50),
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



CREATE OR REPLACE TYPE tp_passaporte AS OBJECT (
    numero_passaporte VARCHAR2(10),
    pais_emissao VARCHAR2(30),
    data_emissao DATE,
    data_validade DATE
);
/
CREATE OR REPLACE TYPE tp_pessoa AS object(
    cpf VARCHAR2(11),
    nome VARCHAR2(30),
    sobrenome VARCHAR(30),
    email VARCHAR2(30),
    data_de_nascimento DATE,
    telefone tp_telefone,
    telefones_emergencia tp_telefones_emergencia
) NOT FINAL NOT INSTANTIABLE;
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
    preferencia_assento NOT NULL,
    nacionalidade NOT NULL,
    CONSTRAINT chk_preferencia_assento CHECK (preferencia_assento IN ('Janela', 'Meio', 'Corredor'))
) NESTED TABLE necessidades_especiais STORE AS nt_necessidades_especiais;
/

CREATE OR REPLACE TYPE tp_aeronave AS OBJECT (
    codigo NUMBER,
    modelo VARCHAR2(20),
    capacidade NUMBER,
    ano_fabricacao NUMBER(4)
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
    nome VARCHAR2(50),
    endereco tp_endereco,
)
/

CREATE OR REPLACE TYPE tp_telefones_emergencia AS object(
    pessoa  tp_pessoa,
    telefones_emergencia tp_telefone,
);
/
