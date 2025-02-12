-- Bloco anônimo com Record, SELECT ... INTO e %TYPE para buscar um passageiro pelo CPF

DECLARE
    TYPE PassageiroInfo IS RECORD(
        Nome Pessoa.Nome%TYPE,
        Sobrenome Pessoa.Sobrenome%TYPE
    );

    v_passageiro Passageiro_Info;

BEGIN
    SELECT Nome, Sobrenome INTO v_passageiro
    FROM Pessoa WHERE CPF = '12345678901'

    DBMS_OUTPUT.PUT_LINE('Nome: ' || v_passageiro.Nome || ' ' || v_passageiro.Sobrenome);
END;

-- Bloco anônimo com Estrutura de dados do tipo TABLE e usando %ROWTYPE para retornar o nome de um passageiro que já fez alguma viagem

DECLARE
    TYPE TabelaPassageiros IS TABLE OF Pessoa%ROWTYPE;

    v_passageiros TabelaPassageiros;

BEGIN
    SELECT * INTO v_passageiros(1) FROM Pessoa pe
    JOIN Passageiro p ON pe.CPF = p.Cpf_passageiro
    JOIN Reserva r ON p.Cpf_passageiro = r.CPF_Passageiro
    WHERE ROWNUM = 1;

    DBMS_OUTPUT.PUT_LINE('Passageiro: ' || v_passageiro(1).Nome || ' ' || v_passageiro(1).Sobrenome);
END;

-- Bloco anônimo que utiliza IF ELSIF para categorizar um voo de acordo com a quantidade de reservas ocupadas

DECLARE
    v_Codigo_Voo Voo.Codigo_voo%TYPE := 1;
    v_Total_Reservas NUMBER;
    v_Capacidade_Aeronave NUMBER;
    v_Ocupacao FLOAT;

BEGIN
    -- Buscar a quantidade de reservas para o voo
    SELECT COUNT(*) INTO v_Total_Reservas FROM Reserva
    WHERE Codigo_Voo = v_Codigo_Voo;

    -- Buscar a capacidade da aeronave que opera o voo
    SELECT a.Capacidade INTO v_Capacidade_Aeronave FROM Aeronave a
    JOIN Voa v ON a.Codigo_Aeronave = v.Codigo_Aeronave
    WHERE v.Codigo_Voo = v_Codigo_Voo;

    -- Calculando a ocupação das reservas em relação à capacidade da aeronave
    v_Ocupacao := (v_Total_Reservas / v_Capacidade_Aeronave) * 100;

    -- Classificando o voo com base no número de reservas
    IF v_Total_Reservas = 0 THEN
        DBMS_OUTPUT.PUT_LINE('O voo está vazio. ');
    ELSIF v_Ocupacao < 40 THEN
        DBMS_OUTPUT.PUT_LINE('O voo tem capacidade mediana ocupada. ');
    ELSIF v_Ocupacao BETWEEN 40 AND 80 THEN
        DBMS_OUTPUT.PUT_LINE('O voo está moderadamente cheio. ');
    ELSE
        DBMS_OUTPUT.PUT_LINE('O voo está cheio. ');
    END IF;
END;

-- USO DE RECORD
-- USO DE ESTRUTURA DE DADOS DO TIPO TABLE
-- BLOCO ANÔNIMO
-- CREATE PROCEDURE
-- CREATE FUNCTION
-- %TYPE
-- %ROWTYPE
-- IF ELSIF
-- CASE WHEN
-- LOOP EXIT WHEN
-- WHILE LOOP
-- FOR IN LOOP
-- SELECT … INTO
-- CURSOR (OPEN, FETCH e CLOSE)
-- EXCEPTION WHEN
-- USO DE PARÂMETROS (IN, OUT ou IN OUT)
-- CREATE OR REPLACE PACKAGE
-- CREATE OR REPLACE PACKAGE BODY
-- CREATE OR REPLACE TRIGGER (COMANDO)
CREATE TABLE log_reservas(
	Tipo_de_acao VARCHAR2(15),
	Hora TIMESTAMP,
    Codigo_Voo NUMBER,
    Numero_do_assento NUMBER,
    CPF_Passageiro VARCHAR2(11),
    CONSTRAINT Log_reservas_fkey1 FOREIGN KEY (Codigo_Voo)
        REFERENCES Voo(Codigo_voo) ON DELETE CASCADE,
    CONSTRAINT Log_reservas_fkey2 FOREIGN KEY (CPF_Passageiro)
        REFERENCES Passageiro(Cpf_passageiro) ON DELETE CASCADE,
);


CREATE OR REPLACE TRIGGER reservas_alt
AFTER INSERT OR UPDATE OR DELETE ON Reserva
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO log_provas (tipo_de_acao, hora, Codigo_Voo, Numero_do_assento, CPF_Passageiro)
        VALUES ('INSERCAO', SYSDATE, :NEW.Codigo_Voo, :NEW.Numero_do_assento, :NEW.CPF_Passageiro);

    ELSIF UPDATING THEN
        INSERT INTO log_provas (tipo_de_acao, hora, Codigo_Voo, Numero_do_assento, CPF_Passageiro)
        VALUES ('ATUALIZACAO', SYSDATE, :NEW.Codigo_Voo, :NEW.Numero_do_assento, :NEW.CPF_Passageiro);

    ELSIF DELETING THEN
        INSERT INTO log_provas (tipo_de_acao, hora, Codigo_Voo, Numero_do_assento, CPF_Passageiro)
        VALUES ('REMOCAO', SYSDATE, :OLD.Codigo_Voo, :OLD.Numero_do_assento, :OLD.CPF_Passageiro);
    END IF;
END;

-- CREATE OR REPLACE TRIGGER (LINHA)


