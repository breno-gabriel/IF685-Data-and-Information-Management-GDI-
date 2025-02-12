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

--- Essa consulta utiliza um cursor para listar todos os voos e seus respectivos aeroportos de origem e destino.

DECLARE
    CURSOR voo_cursor IS
        SELECT V.Codigo_voo, A1.Nome AS Aeroporto_Origem, A2.Nome AS Aeroporto_Destino
        FROM Voo V
        JOIN Voo_Detalhes VD ON V.Codigo_voo = VD.Codigo_Voo
        JOIN Aeroporto A1 ON VD.Origem = A1.Codigo_Aeroporto
        JOIN Aeroporto A2 ON VD.Destino = A2.Codigo_Aeroporto;
        
    voo_record voo_cursor%ROWTYPE;
BEGIN
    OPEN voo_cursor;
    LOOP
        FETCH voo_cursor INTO voo_record;
        EXIT WHEN voo_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Voo: ' || voo_record.Codigo_voo || 
                             ', Origem: ' || voo_record.Aeroporto_Origem || 
                             ', Destino: ' || voo_record.Aeroporto_Destino);
    END LOOP;
    CLOSE voo_cursor;
END;
/

--- Consulta que utiliza um loop WHILE exibe os nomes dos passageiros que possuem reservas registradas no banco.

DECLARE
    TYPE t_passageiros IS TABLE OF passageiro%ROWTYPE;
    v_passageiros t_passageiros;
    v_index NUMBER := 1;
BEGIN
    -- Coletar todos os passageiros que têm reservas cadastradas
    SELECT * BULK COLLECT INTO v_passageiros
    FROM passageiro p 
    WHERE EXISTS (
        SELECT 1 FROM reserva r WHERE r.cpf_passageiro = p.cpf_passageiro
    );

    -- Percorrer a coleção usando um loop WHILE
    WHILE v_index <= v_passageiros.COUNT LOOP
        DECLARE
            v_nome pessoa.Nome%TYPE;
        BEGIN
            -- Buscar o nome do passageiro na tabela Pessoa
            SELECT Nome INTO v_nome 
            FROM Pessoa 
            WHERE CPF = v_passageiros(v_index).cpf_passageiro;

            DBMS_OUTPUT.PUT_LINE('Passageiro: ' || v_nome || ' ( CPF: ' || v_passageiros(v_index).cpf_passageiro || ')');
        END;

        v_index := v_index + 1;
    END LOOP;
END;



--- Utiliza a clausula FOR para exibir todas as reservas de voos, mostrando o ID da reserva e o nome do passageiro.

DECLARE
    CURSOR c_reservas IS
        SELECT r.codigo_voo, pe.nome 
        FROM reserva r
        JOIN passageiro p ON r.cpf_passageiro = p.cpf_passageiro
        JOIN pessoa pe ON p.cpf_passageiro = pe.cpf;
BEGIN
    -- Percorrendo todas as reservas usando um loop FOR
    FOR v_reserva IN c_reservas LOOP
        DBMS_OUTPUT.PUT_LINE('Reserva Voo: ' || v_reserva.codigo_voo || ' - Passageiro: ' || v_reserva.nome);
    END LOOP;
END;

--- Utiliza LOOP EXIT WHEN para iterar sobre todas as linhas da tabela Pessoa e imprime o CPF de cada pessoa.

DECLARE
    CURSOR pessoa_cursor IS
        SELECT CPF FROM Pessoa;
    pessoa_record pessoa_cursor%ROWTYPE;
BEGIN
    OPEN pessoa_cursor;
    LOOP
        FETCH pessoa_cursor INTO pessoa_record;
        EXIT WHEN pessoa_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('CPF: ' || pessoa_record.CPF);
    END LOOP;
    CLOSE pessoa_cursor;
END;
/

 --- Utilizando PROCEDURE para inserir um novo passageiro na tabela Passageiro.

CREATE OR REPLACE PROCEDURE InserirPessoaComTelefone(
    p_CPF IN VARCHAR2,
    p_Nome IN VARCHAR2,
    p_Sobrenome IN VARCHAR2,
    p_Email IN VARCHAR2,
    p_Data_de_nascimento IN DATE,
    p_Numero_de_telefone IN VARCHAR2,
    p_DDD IN VARCHAR2,
    p_Codigo_do_pais IN VARCHAR2,
    p_CEP IN VARCHAR2
) AS
BEGIN
    -- Inserir número de telefone na tabela Detalhes_Telefone
    INSERT INTO Detalhes_Telefone (
        Numero_de_telefone, DDD, Codigo_do_pais
    ) VALUES (
        p_Numero_de_telefone, p_DDD, p_Codigo_do_pais
    );

    -- Inserir pessoa na tabela Pessoa
    INSERT INTO Pessoa (
        CPF, Nome, Sobrenome, Email, Data_de_nascimento, Numero_de_telefone, CEP
    ) VALUES (
        p_CPF, p_Nome, p_Sobrenome, p_Email, p_Data_de_nascimento, p_Numero_de_telefone, p_CEP
    );

    COMMIT;
END;
/

BEGIN
    InserirPessoaComTelefone(
        '12345678036', 
        'João', 
        'Silva', 
        'joao.silva@example.com', 
        TO_DATE('1990-01-01', 'YYYY-MM-DD'), 
        '123456789', 
        '011', 
        '55', 
        '30150080'
    );
END;
/

-- Package Specification
CREATE OR REPLACE PACKAGE voo_utils AS
    FUNCTION CalcularOcupacao(p_Codigo_Voo IN Voo.Codigo_voo%TYPE) RETURN NUMBER;
    FUNCTION CalcularTotalPassageiros(p_Codigo_Voo IN Voo.Codigo_voo%TYPE) RETURN NUMBER;
END voo_utils;
/

-- Package Body
CREATE OR REPLACE PACKAGE BODY voo_utils AS
    --- FUNCTION que calcula a ocupação de um voo com base no número de reservas e a capacidade da aeronave.
    FUNCTION CalcularOcupacao(p_Codigo_Voo IN Voo.Codigo_voo%TYPE) RETURN NUMBER IS
        v_Total_Reservas NUMBER;
        v_Capacidade_Aeronave NUMBER;
        v_Ocupacao NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_Total_Reservas 
        FROM Reserva
        WHERE Codigo_Voo = p_Codigo_Voo;

        SELECT a.Capacidade INTO v_Capacidade_Aeronave 
        FROM Aeronave a
        JOIN Voa v ON a.Codigo_Aeronave = v.Codigo_Aeronave
        WHERE v.Codigo_Voo = p_Codigo_Voo;

        v_Ocupacao := (v_Total_Reservas / v_Capacidade_Aeronave) * 100;
        RETURN v_Ocupacao;
    END CalcularOcupacao;

    FUNCTION CalcularTotalPassageiros(p_Codigo_Voo IN Voo.Codigo_voo%TYPE) RETURN NUMBER IS
        v_Total_Passageiros NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_Total_Passageiros
        FROM Reserva
        WHERE Codigo_Voo = p_Codigo_Voo;

        RETURN v_Total_Passageiros;
    END CalcularTotalPassageiros;
END voo_utils;
/


CREATE OR REPLACE PROCEDURE InserirPessoaECalcularOcupacao(
    p_CPF IN VARCHAR2,
    p_Nome IN VARCHAR2,
    p_Sobrenome IN VARCHAR2,
    p_Email IN VARCHAR2,
    p_Data_de_nascimento IN DATE,
    p_Numero_de_telefone IN VARCHAR2,
    p_DDD IN VARCHAR2,
    p_Codigo_do_pais IN VARCHAR2,
    p_CEP IN VARCHAR2,
    p_Codigo_Voo IN Voo.Codigo_voo%TYPE
) AS
    v_Ocupacao NUMBER;
BEGIN
    -- Inserir número de telefone na tabela Detalhes_Telefone
    INSERT INTO Detalhes_Telefone (
        Numero_de_telefone, DDD, Codigo_do_pais
    ) VALUES (
        p_Numero_de_telefone, p_DDD, p_Codigo_do_pais
    );

    -- Inserir pessoa na tabela Pessoa
    INSERT INTO Pessoa (
        CPF, Nome, Sobrenome, Email, Data_de_nascimento, Numero_de_telefone, CEP
    ) VALUES (
        p_CPF, p_Nome, p_Sobrenome, p_Email, p_Data_de_nascimento, p_Numero_de_telefone, p_CEP
    );

    -- Calcular a ocupação do voo
    v_Ocupacao := CalcularOcupacao(p_Codigo_Voo);

    -- Exibir a ocupação do voo
    DBMS_OUTPUT.PUT_LINE('A ocupação do voo ' || p_Codigo_Voo || ' é: ' || v_Ocupacao || '%');

    COMMIT;
END;
/

DECLARE
    v_Codigo_Voo Voo.Codigo_voo%TYPE := 1; -- Substitua pelo código do voo desejado
    v_Total_Passageiros NUMBER;
BEGIN
    -- Calcular o número total de passageiros para o voo
    v_Total_Passageiros := voo_utils.CalcularTotalPassageiros(v_Codigo_Voo);

    -- Exibir o número total de passageiros
    DBMS_OUTPUT.PUT_LINE('O número total de passageiros no voo ' || v_Codigo_Voo || ' é: ' || v_Total_Passageiros);
END;
/

 CREATE SEQUENCE log_reservas_sequence
 START WITH     1
 INCREMENT BY   1
 NOMAXVALUE
 NOCACHE
 NOCYCLE;


CREATE TABLE log_reservas(
    id number,
	Tipo_de_acao VARCHAR2(15),
	Hora TIMESTAMP,
    Codigo_Voo NUMBER,
    Numero_do_assento NUMBER,
    CPF_Passageiro VARCHAR2(11),
    CONSTRAINT Log_reservas_pkey PRIMARY KEY (id),
    CONSTRAINT Log_reservas_fkey1 FOREIGN KEY (Codigo_Voo)
        REFERENCES Voo(Codigo_voo) ON DELETE CASCADE,
    CONSTRAINT Log_reservas_fkey2 FOREIGN KEY (CPF_Passageiro)
        REFERENCES Passageiro(Cpf_passageiro) ON DELETE CASCADE
);

-- CREATE OR REPLACE TRIGGER POR LINHA
CREATE OR REPLACE TRIGGER reservas_alt
AFTER INSERT OR UPDATE OR DELETE ON Reserva
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO log_reservas (id,tipo_de_acao, hora, Codigo_Voo, Numero_do_assento, CPF_Passageiro)
        VALUES (log_reservas_sequence.NEXTVAL, 'INSERCAO', SYSDATE, :NEW.Codigo_Voo, :NEW.Numero_do_assento, :NEW.CPF_Passageiro);

    ELSIF UPDATING THEN
        INSERT INTO log_reservas (id,tipo_de_acao, hora, Codigo_Voo, Numero_do_assento, CPF_Passageiro)
        VALUES (log_reservas_sequence.NEXTVAL, 'ATUALIZACAO', SYSDATE, :NEW.Codigo_Voo, :NEW.Numero_do_assento, :NEW.CPF_Passageiro);

    ELSIF DELETING THEN
        INSERT INTO log_reservas (id,tipo_de_acao, hora, Codigo_Voo, Numero_do_assento, CPF_Passageiro)
        VALUES (log_reservas_sequence.NEXTVAL, 'REMOCAO', SYSDATE, :OLD.Codigo_Voo, :OLD.Numero_do_assento, :OLD.CPF_Passageiro);
    END IF;
END;

DELETE FROM Reserva WHERE CPF_Passageiro = '12345678901';
INSERT INTO Reserva (Codigo_Voo, CPF_Passageiro, Classe, Numero_do_assento) 
    VALUES (1, '12345678901', 'Primeira', 5);
    
INSERT INTO Voo_Detalhes (Codigo_Voo, CPF_Passageiro, Portao_de_Embarque, Origem, Destino, Data_Decolagem, Data_aterrissagem)
    VALUES (1, '12345678901', '20', 11, 7, TO_DATE('2025-02-06 15:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-02-06 18:00:00', 'YYYY-MM-DD HH24:MI:SS'));

SELECT * FROM log_reservas;
-- Utilizando CASE WHEN para caracterizar o tipo de bagagem pela sua quantidade e peso, e atribuindo um valor de acordo com o CPF do passageiro

DECLARE
    TYPE BagagemInfo IS RECORD (
        codigo_voo Voo.codigo_voo%TYPE,
        nome_passageiro Pessoa.nome%TYPE,
        peso_total NUMBER,
        quantidade NUMBER,
        categoria VARCHAR2(50),
        valor_taxa NUMBER
    );
    
    v_bagagem BagagemInfo;
BEGIN
    SELECT 
        b.codigo_voo,
        p.nome,
        SUM(b.peso_bagagem) as peso_total,
        COUNT(*) as quantidade_bagagens,
        CASE 
            WHEN COUNT(*) = 0 THEN 'Sem Bagagem'
            WHEN SUM(b.peso_bagagem) > 30 THEN 'Peso Excedido'
            WHEN COUNT(*) > 1 THEN 'Múltiplas Bagagens'
            ELSE 'Bagagem Regular'
        END as categoria,
        CASE
            WHEN SUM(b.peso_bagagem) <= 10 THEN 0
            ELSE 100
        END as valor_taxa
    INTO v_bagagem
    FROM Bagagem b
    JOIN Passageiro pa ON b.cpf_passageiro = pa.cpf_passageiro
    JOIN Pessoa p ON pa.cpf_passageiro = p.cpf
    JOIN Voo v ON b.codigo_voo = v.codigo_voo
    WHERE b.cpf_passageiro = '23456789012'
    GROUP BY b.codigo_voo, p.nome, v.categoria;

    DBMS_OUTPUT.PUT_LINE('Voo: ' || v_bagagem.codigo_voo);
    DBMS_OUTPUT.PUT_LINE('Passageiro: ' || v_bagagem.nome_passageiro);
    DBMS_OUTPUT.PUT_LINE('Peso Total: ' || v_bagagem.peso_total || 'kg');
    DBMS_OUTPUT.PUT_LINE('Quantidade de Bagagens: ' || v_bagagem.quantidade);
    DBMS_OUTPUT.PUT_LINE('Categoria: ' || v_bagagem.categoria);
    DBMS_OUTPUT.PUT_LINE('Taxa a Pagar: R$ ' || v_bagagem.valor_taxa);
END;

-- Utilização do trigger de comando para registrar as alterações salariais

-- 1. Criação da tabela de logs para armazenar as alterações salariais

CREATE TABLE Log_Salarios_Tripulantes (
    ID_Log NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    ID_Tripulante NUMBER,
    Funcao VARCHAR2(30),
    Salario_Antigo NUMBER(13, 3),
    Salario_Novo NUMBER(13,3),
    Usuar
)



--- Esse bloco tenta inserir um registro na tabela Endereco. Se ocorrer uma exceção, como um valor duplicado (DUP_VAL_ON_INDEX), ou qualquer outra exceção (OTHERS), uma mensagem de erro será exibida

DECLARE
    v_count NUMBER;
BEGIN
    -- Tentando inserir um registro na tabela Endereco
    INSERT INTO Endereco (CEP, Logradouro, Numero, Cidade, Estado)
    VALUES ('12345678', 'Rua Exemplo', 123, 'Cidade Exemplo', 'Estado Exemplo');

    -- Verificando se o registro foi inserido
    SELECT COUNT(*) INTO v_count FROM Endereco WHERE CEP = '12345678';

    -- Se o registro não foi inserido, lançar uma exceção
    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Falha ao inserir o registro na tabela Endereco.');
    END IF;

    DBMS_OUTPUT.PUT_LINE('Registro inserido com sucesso.');

EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Erro: Registro duplicado.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro: ' || SQLERRM);
END;
/