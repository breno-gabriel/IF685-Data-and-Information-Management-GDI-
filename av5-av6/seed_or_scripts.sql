-- Inserindo dados nas tabelas usando tipos objeto
-- Inserindo Pessoas (incluindo tripulantes e passageiros)
-- Tripulantes

INSERT INTO tb_tripulantes VALUES (
    tp_tripulante(
        '67890123456',
        'Juliana',
        'Ferreira',
        'juliana.ferreira@email.com',
        TO_DATE('1998-12-18', 'YYYY-MM-DD'),
        tp_endereco('50010030', 'Avenida Guararapes', 150, 'Recife', 'Pernambuco'),
        tp_telefone('112233445', '11', '55'),
        tp_telefones_emergencia(
            tp_telefone('988776655', '011', '55'),
            tp_telefone('977665544', '011', '55')
        ),
        'Piloto',
        15000.00,
        1001,
        TO_DATE('2015-06-10', 'YYYY-MM-DD'),
        NULL
    )
);

INSERT INTO tb_tripulantes VALUES (
    tp_tripulante(
        '78901234567',
        'Roberto',
        'Almeida',
        'roberto.almeida@email.com',
        TO_DATE('1975-04-25', 'YYYY-MM-DD'),
        tp_endereco('60010040', 'Avenida Beira Mar', 200, 'Fortaleza', 'Ceará'),
        tp_telefone('112233445', '21', '55'),
        tp_telefones_emergencia(
            tp_telefone('988776635', '011', '55'),
            tp_telefone('977665549', '011', '55')
        ),
        'Piloto',
        15000.00,
        1001,
        TO_DATE('2015-06-10', 'YYYY-MM-DD'),
        NULL
    )
);

INSERT INTO tb_tripulantes VALUES (
    tp_tripulante(
        '77889900112',
        'Diego',
        'Azevedo',
        'diego.azevedo@email.com',
        TO_DATE('1984-11-23', 'YYYY-MM-DD'),
        tp_endereco('60050060', 'Rua Dragão do Mar', 150, 'Fortaleza', 'Ceará'),
        tp_telefone('109876543', '86', '55'),
        tp_telefones_emergencia(
            tp_telefone('968776635', '011', '55'),
            tp_telefone('927665549', '011', '55')
        ),
        'Copiloto',
        12000.00,
        1002,
        TO_DATE('2018-03-20', 'YYYY-MM-DD'),
        NULL
    )
);

INSERT INTO tb_tripulantes VALUES (
    tp_tripulante(
        '11223344556',
        'André',
        'Gomes',
        'andre.gomes@email.com',
        TO_DATE('1986-01-22', 'YYYY-MM-DD'),
        tp_endereco('01122000', 'Rua Augusta', 500, 'São Paulo', 'São Paulo'),
        tp_telefone('765432109', '212', '1'),
        tp_telefones_emergencia(
            tp_telefone('968776455', '011', '55'),
            tp_telefone('927661039', '011', '55')
        ),
        'Engenheiro de Voo',
        11000.00,
        1004,
        TO_DATE('2019-07-05', 'YYYY-MM-DD'),
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

-- Inserindo Aeronaves
INSERT INTO tb_aeronaves VALUES (tp_aeronave(1,'Boeing 737',180,2015));
INSERT INTO tb_aeronaves VALUES (tp_aeronave(2,'Airbus A320',150,2018));
INSERT INTO tb_aeronaves VALUES (tp_aeronave(3,'Embraer E195',120,2019));
INSERT INTO tb_aeronaves VALUES (tp_aeronave(4,'Boeing 737-800',189,2015));
INSERT INTO tb_aeronaves VALUES (tp_aeronave(5,'Boeing 777-300',350,2017));
INSERT INTO tb_aeronaves VALUES (tp_aeronave(6,'Airbus A350',325,2021));
INSERT INTO tb_aeronaves VALUES (tp_aeronave(7,'Boeing 747-8',410,2014));
INSERT INTO tb_aeronaves VALUES (tp_aeronave(8,'Airbus A320neo',195,2020));


-- Inserindo Companhias Aéreas
INSERT INTO tb_companhia_aerea VALUES (tp_companhia_aerea('12345678901234','LATAM Airlines Brasil',150,20000,
tp_nt_tripulante(),tp_nt_aeronave()));
INSERT INTO tb_companhia_aerea VALUES (tp_companhia_aerea('98765432109876','Gol Linhas Aéreas',120,15000,
tp_nt_tripulante(),tp_nt_aeronave()));
INSERT INTO tb_companhia_aerea VALUES (tp_companhia_aerea('45678901234567','Azul Linhas Aéreas',130, 18000,
tp_nt_tripulante(),tp_nt_aeronave()));
/

-- Inserindo Aeroportos
-- Aeroportos Nacionais
INSERT INTO tb_aeroportos VALUES (tp_aeroporto(1, 'Aeroporto de Congonhas', 
tp_endereco('04626002', 'Av. Washington Luís', 120, 'São Paulo', 'SP'), 'Brasil'));
INSERT INTO tb_aeroportos VALUES (tp_aeroporto(2, 'Aeroporto Santos Dumont', 
tp_endereco('20021340', 'Praça Sen. Salgado Filho', 150, 'Rio de Janeiro', 'RJ'), 'Brasil'));
INSERT INTO tb_aeroportos VALUES (tp_aeroporto(3, 'Aeroporto de Brasília', 
tp_endereco('71608900', 'Lago Sul', 300, 'Brasília', 'DF'), 'Brasil'));
INSERT INTO tb_aeroportos VALUES (tp_aeroporto(4, 'Aeroporto de Guarulhos', 
tp_endereco('07143000', 'Rod. Hélio Smidt', 45, 'Guarulhos', 'SP'), 'Brasil'));
INSERT INTO tb_aeroportos VALUES (tp_aeroporto(5, 'Aeroporto de Confins', 
tp_endereco('33900000', 'LMG-800', 30, 'Confins', 'MG'), 'Brasil'));
INSERT INTO tb_aeroportos VALUES (tp_aeroporto(6, 'Aeroporto de Porto Alegre', 
tp_endereco('90200310', 'Av. Severo Dullius', 400, 'Porto Alegre', 'RS'), 'Brasil'));
INSERT INTO tb_aeroportos VALUES (tp_aeroporto(7, 'Aeroporto de Salvador', 
tp_endereco('41520021', 'Praça Gago Coutinho', 450, 'Salvador', 'BA'), 'Brasil'));
INSERT INTO tb_aeroportos VALUES (tp_aeroporto(8, 'Aeroporto de Recife', 
tp_endereco('51120360', 'Praça Min. Salgado Filho', 260, 'Recife', 'PE'), 'Brasil'));
INSERT INTO tb_aeroportos VALUES (tp_aeroporto(9, 'Aeroporto de Curitiba', 
tp_endereco('81520900', 'Av. Rocha Pombo', 700, 'Curitiba', 'PR'), 'Brasil'));
INSERT INTO tb_aeroportos VALUES (tp_aeroporto(10, 'Aeroporto de Fortaleza', 
tp_endereco('60811341', 'Av. Sen. Carlos Jereissati', 200, 'Fortaleza', 'CE'), 'Brasil'));
INSERT INTO tb_aeroportos VALUES (tp_aeroporto(11, 'Aeroporto de Manaus', 
tp_endereco('69042000', 'Av. Santos Dumont', 301, 'Manaus', 'AM'), 'Brasil'));
INSERT INTO tb_aeroportos VALUES (tp_aeroporto(12, 'Aeroporto de Belém', 
tp_endereco('66115000', 'Av. Júlio César', 500, 'Belém', 'PA'), 'Brasil'));

-- Aeroportos Internacionais
INSERT INTO tb_aeroportos VALUES (tp_aeroporto(13, 'Aeroporto Internacional de Narita', 
tp_endereco('2820011', '1-1 Furugome', 140, 'Narita', 'CH'), 'Japão'));
INSERT INTO tb_aeroportos VALUES (tp_aeroporto(14, 'Aeroporto Internacional de Heathrow', 
tp_endereco('2856093', 'Bath Road', 400, 'Londres', 'IN'), 'Reino Unido'));
INSERT INTO tb_aeroportos VALUES (tp_aeroporto(15, 'Aeroporto Internacional de Dubai', 
tp_endereco('6320011', 'Al Twar', 308, 'Dubai', 'DU'), 'Emirados Árabes Unidos'));
INSERT INTO tb_aeroportos VALUES (tp_aeroporto(16, 'Aeroporto Internacional de Changi', 
tp_endereco('918146', 'Airport Boulevard', 600, 'Singapura', 'SI'), 'Singapura'));
/

-- Inserindo Voos
INSERT INTO tb_voos VALUES (tp_voo(101, 'Nacional', 'Agendado'));
INSERT INTO tb_voos VALUES (tp_voo(102, 'Internacional', 'Em andamento'));
INSERT INTO tb_voos VALUES (tp_voo(103, 'Nacional', 'Concluido'));
INSERT INTO tb_voos VALUES (tp_voo(104, 'Internacional', 'Cancelado'));
INSERT INTO tb_voos VALUES (tp_voo(105, 'Nacional', 'Atrasado'));
INSERT INTO tb_voos VALUES (tp_voo(106, 'Internacional', 'Agendado'));
INSERT INTO tb_voos VALUES (tp_voo(107, 'Nacional', 'Em andamento'));
INSERT INTO tb_voos VALUES (tp_voo(108, 'Internacional', 'Concluido'));
/