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
