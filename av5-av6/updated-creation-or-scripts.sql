-- Bloco PL para dropar todos as tabelas
DECLARE
  v_count NUMBER;
BEGIN
  SELECT COUNT(*) INTO v_count FROM user_tables;
  IF v_count > 0 THEN
    FOR rec IN (SELECT table_name FROM user_tables) LOOP
      BEGIN
        EXECUTE IMMEDIATE 'DROP TABLE ' || rec.table_name || ' CASCADE CONSTRAINTS';
      EXCEPTION
        WHEN OTHERS THEN
          DBMS_OUTPUT.PUT_LINE('Erro ao dropar a tabela ' || rec.table_name || ': ' || SQLERRM);
      END;
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

-- TYPES
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

CREATE OR REPLACE TYPE tp_nome_completo AS OBJECT (
    nome VARCHAR2(30),
    sobrenome VARCHAR2(30)
);
/

CREATE OR REPLACE TYPE tp_telefones_varray AS VARRAY(3) OF tp_telefone;
/

-- (11) HERANÇA DE TIPOS (UNDER/NOT FINAL)
CREATE OR REPLACE TYPE tp_pessoa AS OBJECT (
    cpf VARCHAR2(11),
    nome VARCHAR2(30),
    sobrenome VARCHAR2(30),  -- Fixed: was VARCHAR without length
    email VARCHAR2(30),
    data_de_nascimento DATE,
    telefone_principal tp_telefone,
    telefones_emergencia tp_telefones_varray, 
    endereco tp_endereco,
    MEMBER PROCEDURE display_info,
    MEMBER FUNCTION obter_nome_completo RETURN tp_nome_completo
) NOT FINAL;
/
-------------------------------------------------------------------------------
-- (3) Member Procedure
-- (4) Member Function
CREATE OR REPLACE TYPE BODY tp_pessoa AS
    MEMBER PROCEDURE display_info IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('CPF: ' || cpf);
        DBMS_OUTPUT.PUT_LINE('Nome: ' || nome);
        DBMS_OUTPUT.PUT_LINE('Sobrenome: ' || sobrenome);
        DBMS_OUTPUT.PUT_LINE('Email: ' || email);
        DBMS_OUTPUT.PUT_LINE('Data de Nascimento: ' || TO_CHAR(data_de_nascimento, 'DD/MM/YYYY'));
        
        -- Telefone principal
        DBMS_OUTPUT.PUT_LINE('Telefone Principal: ' || 
                            telefone_principal.codigo_pais || ' ' || 
                            telefone_principal.ddd || ' ' || 
                            telefone_principal.numero_telefone);
        
        -- Telefones adicionais
        IF telefones_emergencia IS NOT NULL AND telefones_emergencia.COUNT > 0 THEN
            DBMS_OUTPUT.PUT_LINE('Telefones de emergência:');
            FOR i IN 1..telefones_emergencia.COUNT LOOP
                DBMS_OUTPUT.PUT_LINE(i || ': ' || 
                                    telefones_emergencia(i).codigo_pais || ' ' || 
                                    telefones_emergencia(i).ddd || ' ' || 
                                    telefones_emergencia(i).numero_telefone);
            END LOOP;
        END IF;
        
        -- Endereço
        DBMS_OUTPUT.PUT_LINE('Endereço - CEP: ' || endereco.cep);
        DBMS_OUTPUT.PUT_LINE('Endereço completo: ' || 
                            endereco.logradouro || ', ' || 
                            endereco.numero || ' - ' || 
                            endereco.cidade || '/' || 
                            endereco.estado);
    END display_info;

    MEMBER FUNCTION obter_nome_completo RETURN tp_nome_completo IS
    BEGIN
        RETURN tp_nome_completo(nome, sobrenome);
    END obter_nome_completo;
END;

-----------------------------------------------------------------------
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
    endereco tp_endereco,
    pais VARCHAR2(30)
);
/

CREATE OR REPLACE TYPE tp_aeronave AS object(
    codigo_aeronave NUMBER,
    companhia_aerea REF tp_companhia_aerea,
    modelo VARCHAR2(20),
    capacidade NUMBER,
    ano_fabricacao NUMBER(4),
    ORDER MEMBER FUNCTION comparar_aeronave(p_aeronave tp_aeronave) RETURN NUMBER
);
/

-- (5) Order Member Function
CREATE OR REPLACE TYPE BODY tp_aeronave AS
    ORDER MEMBER FUNCTION comparar_aeronave(p_aeronave tp_aeronave) RETURN NUMBER IS
    BEGIN
        -- Primary comparison by capacity
        IF self.capacidade < p_aeronave.capacidade THEN
            RETURN -1;
        ELSIF self.capacidade > p_aeronave.capacidade THEN
            RETURN 1;
        ELSE
            -- Secondary comparison by year of manufacture
            IF self.ano_fabricacao < p_aeronave.ano_fabricacao THEN
                RETURN -1;
            ELSIF self.ano_fabricacao > p_aeronave.ano_fabricacao THEN
                RETURN 1;
            ELSE
                RETURN 0;
            END IF;
        END IF;
    END comparar_aeronave;
END;
/

------------------------------

CREATE OR REPLACE TYPE tp_necessidades_especiais AS object(
    necessidade_especial VARCHAR2(100)
);
/

CREATE OR REPLACE TYPE tp_nt_necessidades_especiais AS TABLE OF tp_necessidades_especiais;
/

CREATE OR REPLACE TYPE tp_passageiro UNDER tp_pessoa(
    passaporte tp_passaporte,
    preferencia_assento VARCHAR2(20),
    nacionalidade VARCHAR2(30),
    necessidades_especiais tp_nt_necessidades_especiais,
    CONSTRUCTOR FUNCTION tp_passageiro(
        p_cpf VARCHAR2,
        p_nome VARCHAR2,
        p_sobrenome VARCHAR2,
        p_email VARCHAR2,
        p_data_nasc DATE,
        p_telefone_principal tp_telefone,
        p_telefones_emergencia tp_telefones_varray,
        p_endereco tp_endereco,
        p_num_passaporte VARCHAR2,
        p_pais_emissao VARCHAR2,
        p_data_emissao DATE,
        p_data_validade DATE,
        p_preferencia_assento VARCHAR2,
        p_nacionalidade VARCHAR2,
        p_necessidades_especiais tp_nt_necessidades_especiais
    ) RETURN SELF AS RESULT
);
/

-- (7) Constructor Function
CREATE OR REPLACE TYPE BODY tp_passageiro AS
    CONSTRUCTOR FUNCTION tp_passageiro(
        p_cpf VARCHAR2,
        p_nome VARCHAR2,
        p_sobrenome VARCHAR2,
        p_email VARCHAR2,
        p_data_nasc DATE,
        p_telefone_principal tp_telefone,
        p_telefones_emergencia tp_telefones_varray,
        p_endereco tp_endereco,
        p_num_passaporte VARCHAR2,
        p_pais_emissao VARCHAR2,
        p_data_emissao DATE,
        p_data_validade DATE,
        p_preferencia_assento VARCHAR2,
        p_nacionalidade VARCHAR2,
        p_necessidades_especiais tp_nt_necessidades_especiais
    ) RETURN SELF AS RESULT IS
    BEGIN
        -- Validate CPF length (Brazilian ID)
        IF LENGTH(p_cpf) != 11 THEN
            RAISE_APPLICATION_ERROR(-20001, 'CPF deve conter 11 dígitos');
        END IF;
        
        -- Validate passport number format
        IF LENGTH(p_num_passaporte) != 10 THEN
            RAISE_APPLICATION_ERROR(-20002, 'Número de passaporte deve conter 10 caracteres');
        END IF;
        
        -- Validate seat preference
        IF p_preferencia_assento NOT IN ('Janela', 'Meio', 'Corredor') THEN
            RAISE_APPLICATION_ERROR(-20003, 'Preferência de assento inválida. Opções: Janela, Meio, Corredor');
        END IF;
        
        -- Validate passport dates
        IF p_data_emissao > p_data_validade THEN
            RAISE_APPLICATION_ERROR(-20004, 'Data de emissão não pode ser posterior à data de validade');
        END IF;
        
        -- Initialize the nested objects
        SELF.pessoa := tp_pessoa(
            p_cpf,
            p_nome,
            p_sobrenome,
            p_email,
            p_data_nasc,
            p_telefone_principal,
            p_telefones_emergencia,
            p_endereco
        );
        
        SELF.passaporte := tp_passaporte(
            p_num_passaporte,
            p_pais_emissao,
            p_data_emissao,
            p_data_validade
        );
        
        SELF.preferencia_assento := p_preferencia_assento;
        SELF.nacionalidade := p_nacionalidade;
        SELF.necessidades_especiais := p_necessidades_especiais;
        
        RETURN;
    END;
END;
/

-- (10) NOT INSTANTIABLE member 
CREATE OR REPLACE TYPE tp_funcao_salario AS OBJECT (
    id NUMBER,
    funcao VARCHAR2(30),
    salario NUMBER(13, 3),
    
   
    NOT INSTANTIABLE MEMBER FUNCTION calcular_salario RETURN NUMBER
) NOT FINAL NOT INSTANTIABLE;
/

CREATE OR REPLACE TYPE tp_funcao_salario_base UNDER tp_funcao_salario (
    -- Override the abstract method
    OVERRIDING MEMBER FUNCTION calcular_salario RETURN NUMBER
);
/

CREATE OR REPLACE TYPE BODY tp_funcao_salario_base AS
    OVERRIDING MEMBER FUNCTION calcular_salario RETURN NUMBER IS
    BEGIN
        RETURN salario; 
    END calcular_salario;
END;
/

-- (11) HERANÇA DE TIPOS (UNDER/NOT FINAL)
-- (9) FINAL MEMBER
CREATE OR REPLACE TYPE tp_tripulante UNDER tp_pessoa (
    companhia_aerea REF tp_companhia_aerea,
    supervisor REF tp_tripulante,
    funcao_salario tp_funcao_salario_base, -- Using the concrete subtype
    numero_funcionario NUMBER,
    data_de_contratacao DATE,
    
    OVERRIDING MEMBER PROCEDURE display_info,
  
    MEMBER FUNCTION calcular_salario RETURN NUMBER
) FINAL;
/

-- (12) ALTER TYPE
ALTER TYPE tp_tripulante
ADD ATTRIBUTE (nivel_seguranca NUMBER) CASCADE;
/
-- (8) Overriding Member Function
CREATE OR REPLACE TYPE BODY tp_tripulante AS
    OVERRIDING MEMBER PROCEDURE display_info IS
        v_supervisor_nome VARCHAR2(61);
    BEGIN
        -- Display personal information
        DBMS_OUTPUT.PUT_LINE('=== Informações Pessoais ===');
        DBMS_OUTPUT.PUT_LINE('CPF: ' || cpf);
        DBMS_OUTPUT.PUT_LINE('Nome: ' || nome || ' ' || sobrenome);
        DBMS_OUTPUT.PUT_LINE('Email: ' || email);
        DBMS_OUTPUT.PUT_LINE('Data Nascimento: ' || TO_CHAR(data_de_nascimento, 'DD/MM/YYYY'));
        
        -- Display professional information
        DBMS_OUTPUT.PUT_LINE('=== Informações Profissionais ===');
        DBMS_OUTPUT.PUT_LINE('Companhia Aérea: ' || companhia_aerea.razao_social);
        DBMS_OUTPUT.PUT_LINE('Número Funcionário: ' || numero_funcionario);
        DBMS_OUTPUT.PUT_LINE('Data Contratação: ' || TO_CHAR(data_de_contratacao, 'DD/MM/YYYY'));
        DBMS_OUTPUT.PUT_LINE('Salário Base: ' || funcao_salario.calcular_salario());
        DBMS_OUTPUT.PUT_LINE('Nível de Segurança: ' || nivel_seguranca);
        
        -- Display supervisor information if exists
        BEGIN
            IF supervisor IS NOT NULL THEN
                SELECT DEREF(supervisor).nome || ' ' || DEREF(supervisor).sobrenome 
                INTO v_supervisor_nome
                FROM dual;
                DBMS_OUTPUT.PUT_LINE('Supervisor: ' || v_supervisor_nome);
            ELSE
                DBMS_OUTPUT.PUT_LINE('Supervisor: Não atribuído');
            END IF;
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Erro ao recuperar supervisor: ' || SQLERRM);
        END;
        
        -- Display contact information
        DBMS_OUTPUT.PUT_LINE('=== Informações de Contato ===');
        DBMS_OUTPUT.PUT_LINE('Telefone: ' || telefone_principal.ddd || ' ' || telefone_principal.numero_telefone);
        DBMS_OUTPUT.PUT_LINE('Endereço: ' || endereco.logradouro || ', ' || 
                            endereco.numero || ' - ' || endereco.cidade || 
                            '/' || endereco.estado || ' - CEP: ' || endereco.cep);
    END display_info;
    
    MEMBER FUNCTION calcular_salario RETURN NUMBER IS
        v_salario_base NUMBER;
        v_bonus NUMBER := 0;
    BEGIN
        -- Get base salary from the function/salary object
        v_salario_base := funcao_salario.calcular_salario();
        
        -- Calculate bonus based on hire date (example logic)
        IF MONTHS_BETWEEN(SYSDATE, data_de_contratacao) > 60 THEN -- 5 years
            v_bonus := v_salario_base * 0.20; -- 20% bonus
        ELSIF MONTHS_BETWEEN(SYSDATE, data_de_contratacao) > 24 THEN -- 2 years
            v_bonus := v_salario_base * 0.10; -- 10% bonus
        END IF;
        
        RETURN v_salario_base + v_bonus;
    END calcular_salario;
END;
/

CREATE OR REPLACE TYPE tp_voo AS object(
    codigo_voo NUMBER,
    categoria VARCHAR2(20),
    status_voo VARCHAR2(20),
    MAP MEMBER FUNCTION status_priority RETURN NUMBER
);
/

-- (6) Map Member Function
CREATE OR REPLACE TYPE BODY tp_voo AS
    MAP MEMBER FUNCTION status_priority RETURN NUMBER IS
        v_priority NUMBER;
    BEGIN
        CASE self.status_voo
            WHEN 'Agendando' THEN v_priority := 1;
            WHEN 'Em andamento' THEN v_priority := 2;
            WHEN 'Concluido' THEN v_priority := 3;
            WHEN 'Cancelado' THEN v_priority := 4;
            ELSE v_priority := 5;
        END CASE;
        RETURN v_priority * 1000000 + self.codigo_voo;
    END status_priority;
END;
/

CREATE OR REPLACE TYPE tp_bagagem AS object(
    numero_bagagem NUMBER,
    peso_bagagem NUMBER
);
/ 

CREATE OR REPLACE TYPE tp_bagagem_varray AS VARRAY(3) OF tp_bagagem;
/

CREATE OR REPLACE TYPE tp_reserva AS object(
    voo REF tp_voo,
    passageiro REF tp_passageiro,
    origem REF tp_aeroporto,
    destino REF tp_aeroporto,
    classe VARCHAR2(20),
    numero_do_assento NUMBER,
    portao_de_embarque VARCHAR2(2),
    data_decolagem DATE,
    data_aterrissagem DATE,
    bagagens tp_bagagem_varray  
);
/

CREATE OR REPLACE TYPE tp_voa AS object(
    aeronave REF tp_aeronave,
    aeroporto REF tp_aeroporto,
    voo REF tp_voo
);
/

CREATE OR REPLACE TYPE tp_acomoda AS object(
    aeroporto REF tp_aeroporto,
    companhia_aerea REF tp_companhia_aerea
);
/

CREATE OR REPLACE TYPE tp_opera AS object(
    aeronave REF tp_aeronave,
    tripulante REF tp_tripulante
);
/

-- TABLES
-- (18) CREATE TABLE OF
-- (16) SCOPE IS
CREATE TABLE tb_companhias_aereas OF tp_companhia_aerea (
    CONSTRAINT pk_companhia_aerea PRIMARY KEY (cnpj)
);
/

CREATE TABLE tb_aeronaves OF tp_aeronave (
    CONSTRAINT pk_aeronave PRIMARY KEY (codigo_aeronave),
    companhia_aerea WITH ROWID REFERENCES tb_companhias_aereas
);
/

CREATE TABLE tb_passageiros OF tp_passageiro(
    CONSTRAINT pk_passageiro PRIMARY KEY (cpf),
    CONSTRAINT chk_preferencia_assento CHECK (preferencia_assento IN ('Janela', 'Meio', 'Corredor'))
) NESTED TABLE necessidades_especiais STORE AS tb_nt_necessidades_especiais;
/

CREATE TABLE tb_tripulantes OF tp_tripulante (
    CONSTRAINT pk_tripulante PRIMARY KEY (cpf),
    supervisor SCOPE IS tb_tripulantes
) OBJECT IDENTIFIER IS PRIMARY KEY;
/

CREATE TABLE tb_aeroportos OF tp_aeroporto (
    CONSTRAINT pk_aeroporto PRIMARY KEY (codigo_aeroporto)
);
/

CREATE TABLE tb_voos OF tp_voo (
    CONSTRAINT pk_voo PRIMARY KEY (codigo_voo),
    CONSTRAINT chk_status_voo CHECK (status_voo IN ('Agendado', 'Em andamento', 'Concluído', 'Cancelado')),
    CONSTRAINT chk_categoria CHECK (categoria IN ('Internacional', 'Nacional'))
);
/

CREATE TABLE tb_reservas OF tp_reserva (
    origem WITH ROWID REFERENCES tb_aeroportos,
    destino WITH ROWID REFERENCES tb_aeroportos,
    voo WITH ROWID REFERENCES tb_voos,
    passageiro WITH ROWID REFERENCES tb_passageiros,
    CONSTRAINT chk_classe CHECK (classe IN ('Primeira Classe', 'Executiva', 'Econômica'))
);
/

CREATE TABLE tb_voa OF tp_voa (
    aeronave WITH ROWID REFERENCES tb_aeronaves,
    aeroporto WITH ROWID REFERENCES tb_aeroportos,
    voo WITH ROWID REFERENCES tb_voos
);
/

CREATE TABLE tb_acomoda OF tp_acomoda (
    aeroporto WITH ROWID REFERENCES tb_aeroportos,
    companhia_aerea WITH ROWID REFERENCES tb_companhias_aereas
);
/

CREATE TABLE tb_opera OF tp_opera (
    aeronave WITH ROWID REFERENCES tb_aeronaves,
    tripulante WITH ROWID REFERENCES tb_tripulantes
);
/