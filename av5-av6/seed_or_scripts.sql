-- Inserindo dados nas tabelas usando tipos objeto

-- Inserindo Companhias Aéreas
INSERT INTO tb_companhia_aerea VALUES (
    tp_companhia_aerea(
        '12345678901234',
        'LATAM Airlines Brasil',
        150,
        20000,
        tp_nt_tripulante(),
        tp_nt_aeronave()
    )
);

INSERT INTO tb_companhia_aerea VALUES (
    tp_companhia_aerea(
        '98765432109876',
        'Gol Linhas Aéreas',
        120,
        15000,
        tp_nt_tripulante(),
        tp_nt_aeronave()
    )
);

INSERT INTO tb_companhia_aerea VALUES (
    tp_companhia_aerea(
        '45678901234567',
        'Azul Linhas Aéreas',
        130,
        18000,
        tp_nt_tripulante(),
        tp_nt_aeronave()
    )
);

-- Inserindo Pessoas (incluindo tripulantes e passageiros)
-- Tripulantes
INSERT INTO tb_tripulantes VALUES (
    tp_tripulante(
        '11122233344',
        'Carlos',
        'Silva',
        'carlos.silva@latam.com',
        TO_DATE('1980-05-15', 'YYYY-MM-DD'),
        tp_endereco('04578000', 'Av Paulista', 1000, 'São Paulo', 'SP'),
        tp_telefone('999887766', '011', '55'),
        tp_telefones_emergencia(
            tp_telefone('988776655', '011', '55'),
            tp_telefone('977665544', '011', '55')
        ),
        'Piloto',
        15000.00,
        12345,
        TO_DATE('2010-01-01', 'YYYY-MM-DD'),
        NULL
    )
);

INSERT INTO tb_tripulantes VALUES (
    tp_tripulante(
        '22233344455',
        'Ana',
        'Santos',
        'ana.santos@latam.com',
        TO_DATE('1985-08-20', 'YYYY-MM-DD'),
        tp_endereco('04578001', 'Rua Augusta', 500, 'São Paulo', 'SP'),
        tp_telefone('999776655', '011', '55'),
        tp_telefones_emergencia(
            tp_telefone('988665544', '011', '55')
        ),
        'Comissária',
        8000.00,
        12346,
        TO_DATE('2015-03-15', 'YYYY-MM-DD'),
        NULL
    )
);

-- Passageiros
INSERT INTO tb_passageiros VALUES (
    tp_passageiro(
        '33344455566',
        'João',
        'Oliveira',
        'joao.oliveira@email.com',
        TO_DATE('1990-03-25', 'YYYY-MM-DD'),
        tp_endereco('04578002', 'Rua Oscar Freire', 200, 'São Paulo', 'SP'),
        tp_telefone('999665544', '011', '55'),
        tp_telefones_emergencia(
            tp_telefone('988554433', '011', '55')
        ),
        tp_passaporte('AB123456', 'Brasil', TO_DATE('2020-01-01', 'YYYY-MM-DD'), TO_DATE('2030-01-01', 'YYYY-MM-DD')),
        tp_necessidades_especiais(
            tp_necessidade_especial('Cadeira de rodas')
        ),
        'Janela',
        'Brasileiro'
    )
);

INSERT INTO tb_passageiros VALUES (
    tp_passageiro(
        '44455566677',
        'Maria',
        'Costa',
        'maria.costa@email.com',
        TO_DATE('1988-07-12', 'YYYY-MM-DD'),
        tp_endereco('04578003', 'Alameda Santos', 300, 'São Paulo', 'SP'),
        tp_telefone('999554433', '011', '55'),
        tp_telefones_emergencia(
            tp_telefone('988443322', '011', '55')
        ),
        tp_passaporte('CD789012', 'Brasil', TO_DATE('2019-06-01', 'YYYY-MM-DD'), TO_DATE('2029-06-01', 'YYYY-MM-DD')),
        tp_necessidades_especiais(),
        'Corredor',
        'Brasileira'
    )
);

-- Inserindo Aeroportos
INSERT INTO tb_aeroportos VALUES (
    tp_aeroporto(
        1,
        'Aeroporto de Guarulhos',
        tp_endereco('07190100', 'Rod. Hélio Smidt', 0, 'Guarulhos', 'SP'),
        'Brasil'
    )
);

INSERT INTO tb_aeroportos VALUES (
    tp_aeroporto(
        2,
        'Aeroporto de Congonhas',
        tp_endereco('04626911', 'Av. Washington Luis', 0, 'São Paulo', 'SP'),
        'Brasil'
    )
);

INSERT INTO tb_aeroportos VALUES (
    tp_aeroporto(
        3,
        'Aeroporto do Galeão',
        tp_endereco('21941900', 'Av. Vinte de Janeiro', 0, 'Rio de Janeiro', 'RJ'),
        'Brasil'
    )
);

-- Inserindo Aeronaves
INSERT INTO tp_aeronaves VALUES (
    tp_aeronave(
        1,
        'Boeing 737',
        180,
        TO_DATE('2015-01-01', 'YYYY-MM-DD')
    )
);

INSERT INTO tp_aeronaves VALUES (
    tp_aeronave(
        2,
        'Airbus A320',
        150,
        TO_DATE('2018-06-15', 'YYYY-MM-DD')
    )
);

INSERT INTO tp_aeronaves VALUES (
    tp_aeronave(
        3,
        'Embraer E195',
        120,
        TO_DATE('2019-03-30', 'YYYY-MM-DD')
    )
);

-- Inserindo Voos
INSERT INTO tb_voos VALUES (
    tp_voo(
        1,
        TO_DATE('2024-03-20 10:00', 'YYYY-MM-DD HH24:MI'),
        TO_DATE('2024-03-20 12:00', 'YYYY-MM-DD HH24:MI'),
        'A1',
        'Nacional',
        'Agendando'
    )
);

INSERT INTO tb_voos VALUES (
    tp_voo(
        2,
        TO_DATE('2024-03-21 14:00', 'YYYY-MM-DD HH24:MI'),
        TO_DATE('2024-03-21 16:00', 'YYYY-MM-DD HH24:MI'),
        'B2',
        'Nacional',
        'Agendando'
    )
);

-- Atualizando referências de supervisionados
DECLARE
    v_ref_supervisor REF tp_tripulante;
    v_ref_supervisionado REF tp_tripulante;
BEGIN
    -- Obtendo referência do supervisor
    SELECT REF(t) INTO v_ref_supervisor
    FROM tb_tripulantes t
    WHERE t.cpf = '11122233344';
    
    -- Obtendo referência do supervisionado
    SELECT REF(t) INTO v_ref_supervisionado
    FROM tb_tripulantes t
    WHERE t.cpf = '22233344455';
    
    -- Adicionando supervisionado
    UPDATE tb_tripulantes t
    SET t.supervisionados = tp_nt_tripulante(tp_ref_tripulante(v_ref_supervisionado))
    WHERE t.cpf = '11122233344';
END;
/

-- Atualizando funcionários e aeronaves da companhia aérea
DECLARE
    v_ref_tripulante1 REF tp_tripulante;
    v_ref_tripulante2 REF tp_tripulante;
BEGIN
    -- Obtendo referências dos tripulantes
    SELECT REF(t) INTO v_ref_tripulante1
    FROM tb_tripulantes t
    WHERE t.cpf = '11122233344';
    
    SELECT REF(t) INTO v_ref_tripulante2
    FROM tb_tripulantes t
    WHERE t.cpf = '22233344455';
    
    -- Atualizando LATAM com funcionários e aeronaves
    UPDATE tb_companhia_aerea c
    SET c.funcionarios = tp_nt_tripulante(
            tp_ref_tripulante(v_ref_tripulante1),
            tp_ref_tripulante(v_ref_tripulante2)
        ),
        c.aeronaves = tp_nt_aeronave(
            tp_aeronave(1, 'Boeing 737', 180, TO_DATE('2015-01-01', 'YYYY-MM-DD')),
            tp_aeronave(2, 'Airbus A320', 150, TO_DATE('2018-06-15', 'YYYY-MM-DD'))
        )
    WHERE c.cnpj = '12345678901234';
END;
/

-- Exemplo de utilização das funções membro
-- Obtendo nome completo e idade de uma pessoa
SELECT p.get_nome_completo() as nome_completo, 
       p.get_idade() as idade
FROM tb_pessoas p
WHERE p.cpf = '11122233344';

-- Obtendo total de supervisionados de um tripulante
SELECT t.get_total_supervisionados() as total_supervisionados
FROM tb_tripulantes t
WHERE t.cpf = '11122233344';

-- Obtendo total de funcionários e aeronaves de uma companhia aérea
SELECT c.get_total_funcionarios() as total_funcionarios,
       c.get_total_aeronaves() as total_aeronaves
FROM tb_companhia_aerea c
WHERE c.cnpj = '12345678901234';

-- Ordenando tripulantes por salário usando ORDER MEMBER FUNCTION
SELECT t.cpf, t.nome, t.salario
FROM tb_tripulantes t
ORDER BY VALUE(t);