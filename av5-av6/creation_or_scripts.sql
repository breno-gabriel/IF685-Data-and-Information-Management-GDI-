

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
    endereco tp_endereco,
)
/

CREATE OR REPLACE TYPE tp_telefones_emergencia AS object(
    pessoa  tp_pessoa,
    telefones_emergencia tp_telefone,
);
/
