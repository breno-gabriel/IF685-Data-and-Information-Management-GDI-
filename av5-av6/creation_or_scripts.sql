DROP TABLE tb_tripulantes;


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
CREATE OR REPLACE TYPE tp_nome_completo AS OBJECT (
    nome VARCHAR2(30),
    sobrenome VARCHAR2(30)
);
/
-- (11) HERANÇA DE TIPOS (UNDER/NOT FINAL)
CREATE OR REPLACE TYPE tp_pessoa AS OBJECT (
    cpf VARCHAR2(11),
    nome VARCHAR2(30),
    sobrenome VARCHAR2(30),  -- Fixed: was VARCHAR without length
    email VARCHAR2(30),
    data_de_nascimento DATE,
    telefone tp_telefone,
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
        DBMS_OUTPUT.PUT_LINE('Telefone: ' || telefone.numero_telefone);
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
CREATE OR REPLACE TYPE tp_passageiro AS object(
    pessoa tp_pessoa,
    passaporte tp_passaporte,
    preferencia_assento VARCHAR2(20),
    nacionalidade VARCHAR2(30),
    CONSTRUCTOR FUNCTION tp_passageiro(
        p_cpf VARCHAR2,
        p_nome VARCHAR2,
        p_sobrenome VARCHAR2,
        p_email VARCHAR2,
        p_data_nasc DATE,
        p_num_passaporte VARCHAR2,
        p_pais_emissao VARCHAR2,
        p_data_emissao DATE,
        p_data_validade DATE,
        p_preferencia_assento VARCHAR2,
        p_nacionalidade VARCHAR2
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
        p_num_passaporte VARCHAR2,
        p_pais_emissao VARCHAR2,
        p_data_emissao DATE,
        p_data_validade DATE,
        p_preferencia_assento VARCHAR2,
        p_nacionalidade VARCHAR2
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
            NULL,  -- telefone (can be set separately)
            NULL   -- endereco (can be set separately)
        );
        
        SELF.passaporte := tp_passaporte(
            p_num_passaporte,
            p_pais_emissao,
            p_data_emissao,
            p_data_validade
        );
        
        SELF.preferencia_assento := p_preferencia_assento;
        SELF.nacionalidade := p_nacionalidade;
        
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
CREATE OR REPLACE TYPE tp_tripulante UNDER tp_pessoa (
    companhia_aerea tp_companhia_aerea,
    supervisor REF tp_tripulante,
    funcao_salario tp_funcao_salario_base, -- Using the concrete subtype
    numero_funcionario NUMBER,
    data_de_contratacao DATE,
    
    OVERRIDING MEMBER PROCEDURE display_info,
  
    MEMBER FUNCTION calcular_salario RETURN NUMBER
);
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
        DBMS_OUTPUT.PUT_LINE('Telefone: ' || telefone.ddd || ' ' || telefone.numero_telefone);
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

-- (9) FINAL Member
CREATE OR REPLACE TYPE tp_voo_detalhes AS object(
    voo tp_voo,
    passageiro tp_passageiro,
    portao_de_embarque VARCHAR2(2),
    origem tp_aeroporto,
    destino tp_aeroporto,
    data_decolagem DATE,
    data_aterrissagem DATE
) FINAL;
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


-- (18) CREATE TABLE OF
CREATE TABLE tb_tripulantes OF tp_tripulante (
    -- You can add constraints here if needed
    CONSTRAINT pk_tripulante PRIMARY KEY (cpf),
    CONSTRAINT fk_tripulante_supervisor 
        FOREIGN KEY (supervisor) REFERENCES tb_tripulantes
) OBJECT IDENTIFIER IS PRIMARY KEY;



-- (17) INSERT INTO
-- (15)  REF
DECLARE
    v_telefone tp_telefone := tp_telefone('987654321', '11', '55');
    v_endereco tp_endereco := tp_endereco('01234567', 'Rua das Acácias', '100', 'São Paulo', 'SP');
    v_companhia tp_companhia_aerea := tp_companhia_aerea('12345678000199', 'Azul Linhas Aéreas', 150, 8000);
    
    -- Criar objeto de função/salário para o supervisor
    v_funcao_supervisor tp_funcao_salario_base := tp_funcao_salario_base(
        id => 1,
        funcao => 'Comandante',
        salario => 30000.00
    );
    
    -- Criar objeto de função/salário para o tripulante
    v_funcao_tripulante tp_funcao_salario_base := tp_funcao_salario_base(
        id => 2,
        funcao => 'Copiloto',
        salario => 20000.00
    );
    
    v_supervisor_ref REF tp_tripulante;
    v_supervisor tp_tripulante;
BEGIN
    -- Primeiro criar o objeto supervisor
    v_supervisor := tp_tripulante(
        cpf => '11122233344',
        nome => 'Carlos',
        sobrenome => 'Silva',
        email => 'carlos.silva@azul.com',
        data_de_nascimento => TO_DATE('15/03/1975', 'DD/MM/YYYY'),
        telefone => v_telefone,
        endereco => v_endereco,
        companhia_aerea => v_companhia,
        supervisor => NULL, -- Supervisor não tem supervisor
        funcao_salario => v_funcao_supervisor,
        numero_funcionario => 1001,
        data_de_contratacao => TO_DATE('01/01/2010', 'DD/MM/YYYY'),
        nivel_seguranca => 1
    );
    
    -- Inserir o supervisor e obter sua REF
    INSERT INTO tb_tripulantes VALUES (v_supervisor);
    
    SELECT REF(P) into v_supervisor_ref FROM tb_tripulantes P;

    -- Agora criar e inserir o tripulante regular com referência ao supervisor
    INSERT INTO tb_tripulantes VALUES (
        tp_tripulante(
            cpf => '22233344455',
            nome => 'Ana',
            sobrenome => 'Oliveira',
            email => 'ana.oliveira@azul.com',
            data_de_nascimento => TO_DATE('20/05/1985', 'DD/MM/YYYY'),
            telefone => v_telefone,
            endereco => v_endereco,
            companhia_aerea => v_companhia,
            supervisor => v_supervisor_ref,
            funcao_salario => v_funcao_tripulante,
            numero_funcionario => 2001,
            data_de_contratacao => TO_DATE('15/06/2015', 'DD/MM/YYYY'),
            nivel_seguranca => 2
        )
    );
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('Tripulantes inseridos com sucesso!');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro: ' || SQLERRM);
        ROLLBACK;
END;
/




