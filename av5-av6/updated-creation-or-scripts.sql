

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
    endereco tp_endereco
);
/

CREATE OR REPLACE TYPE tp_telefones_emergencia AS object(
    pessoa  tp_pessoa,
    telefones_emergencia tp_telefone
);
/

CREATE OR REPLACE TYPE tp_companhia_aerea AS object(
    cnpj VARCHAR2(14),
    razao_social VARCHAR2(50),
    frota_total_de_aeronaves NUMBER,
    quantidade_total_de_funcionarios NUMBER
);
/

CREATE OR REPLACE TYPE tp_passaporte AS object(
    numero_passaporte VARCHAR2(10),
    pais_emissao VARCHAR2(30),
    data_emissao DATE,
    data_validade DATE
);
/
CREATE OR REPLACE TYPE tp_aeroporto AS object(
    codigo_aeroporto NUMBER,
    nome VARCHAR2(50),
    endereco tp_endereco
);
/
CREATE OR REPLACE TYPE tp_aeronave AS object(
    codigo_aeronave NUMBER,
    companhia_aerea tp_companhia_aerea,
    modelo VARCHAR2(20),
    capacidade NUMBER,
    ano_fabricacao NUMBER(4)
);
/
CREATE OR REPLACE TYPE tp_passageiro AS object(
    pessoa tp_pessoa,
    passaporte tp_passaporte,
    preferencia_assento VARCHAR2(20),
    nacionalidade VARCHAR2(30)
);
/
CREATE OR REPLACE TYPE tp_tripulante AS object(
    pessoa tp_pessoa,
    companhia_aerea tp_companhia_aerea,
        supervisor REF tp_tripulante,
    id_funcao NUMBER,
    numero_funcionario NUMBER,
    data_de_contratacao DATE
);
/
CREATE OR REPLACE TYPE tp_voo AS object(
    codigo_voo NUMBER,
    categoria VARCHAR2(20),
    status_voo VARCHAR2(20)
);
/
CREATE OR REPLACE TYPE tp_voo_detalhes AS object(
    voo tp_voo,
    passageiro tp_passageiro,
    portao_de_embarque VARCHAR2(2),
    origem tp_aeroporto,
    destino tp_aeroporto,
    data_decolagem DATE,
    data_aterrissagem DATE
);
/
CREATE OR REPLACE TYPE tp_bagagem AS object(
    voo tp_voo,
    passageiro tp_passageiro,
    numero_bagagem NUMBER,
    peso_bagagem NUMBER
);
/   
CREATE OR REPLACE TYPE tp_reserva AS object(
    voo tp_voo,
    passageiro tp_passageiro,
    classe VARCHAR2(20),
    numero_do_assento NUMBER
);

/

CREATE OR REPLACE TYPE tp_necessidades_especiais AS object(
    passageiro tp_passageiro,
    necessidade_especial VARCHAR2(100)
);

/

CREATE OR REPLACE TYPE tp_voa AS object(
    aeronave tp_aeronave,
    aeroporto tp_aeroporto,
    voo tp_voo
);
/

CREATE OR REPLACE TYPE tp_acomoda AS object(
    aeroporto tp_aeroporto,
    companhia_aerea tp_companhia_aerea,
    tipo VARCHAR2(20)
);
/

CREATE OR REPLACE TYPE tp_opera AS object(
    aeronave tp_aeronave,
    tripulante tp_tripulante
);
/
CREATE OR REPLACE TYPE tp_funcao_salario AS object(
    id NUMBER,
    funcao VARCHAR2(30),
    salario NUMBER(13, 3)
);


