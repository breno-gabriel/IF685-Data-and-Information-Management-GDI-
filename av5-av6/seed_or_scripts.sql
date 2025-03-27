-- Inserindo dados nas tabelas usando tipos objeto
-- Inserindo Pessoas (incluindo tripulantes e passageiros)
-- Tripulantes

-- Insert data with proper REF handling and VARRAY for phones
DECLARE
    -- Create passenger objects
    v_passageiro1 tp_passageiro;
    v_passageiro2 tp_passageiro;
    
    -- Create special needs collections
    v_necessidades1 nt_necessidades_especiais := nt_necessidades_especiais();
    v_necessidades2 nt_necessidades_especiais := nt_necessidades_especiais();
    
    -- Common objects
    v_telefone tp_telefone := tp_telefone('987654321', '11', '55');
    v_endereco tp_endereco := tp_endereco('01234567', 'Rua das Flores', 123, 'São Paulo', 'SP');
    v_telefones_emergencia tp_telefones_varray := tp_telefones_varray(
        tp_telefone('912345678', '11', '55')
    );
BEGIN
    -- Initialize passenger 1 (with special needs)
    v_passageiro1 := tp_passageiro(
        '12345678901', 'João', 'Silva', 'joao@email.com',
        TO_DATE('15/03/1985', 'DD/MM/YYYY'),
        v_telefone, v_telefones_emergencia, v_endereco,
        'BR12345678', 'Brasil', 
        TO_DATE('01/01/2020', 'DD/MM/YYYY'), TO_DATE('01/01/2030', 'DD/MM/YYYY'),
        'Janela', 'Brasileiro'
    );
    
    -- Add special needs for passenger 1 (now correctly passing the passageiro object)
    v_necessidades1.EXTEND(2);
    v_necessidades1(1) := tp_necessidades_especiais( 'Cadeira de rodas');
    v_necessidades1(2) := tp_necessidades_especiais('Assistência para embarque');
    
    -- Initialize passenger 2 (no special needs)
    v_passageiro2 := tp_passageiro(
        '98765432109', 'Maria', 'Santos', 'maria@email.com',
        TO_DATE('20/05/1990', 'DD/MM/YYYY'),
        v_telefone, v_telefones_emergencia, v_endereco,
        'BR98765432', 'Brasil', 
        TO_DATE('01/01/2021', 'DD/MM/YYYY'), TO_DATE('01/01/2031', 'DD/MM/YYYY'),
        'Corredor', 'Brasileira'
    );
    
    -- Insert into the table
    INSERT INTO tb_passageiros ( necessidades)
    VALUES (v_passageiro1, v_necessidades1);
    
    INSERT INTO tb_passageiros ( necessidades)
    VALUES (v_passageiro2, NULL);
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Passageiros cadastrados com sucesso!');
END;
/

SELECT 
    p.id_passageiro,
    p.passageiro.pessoa.nome || ' ' || p.passageiro.pessoa.sobrenome AS nome_completo,
    p.passageiro.passaporte.numero_passaporte AS passaporte,
    p.passageiro.preferencia_assento AS assento,
    n.necessidade_especial
FROM 
    tb_passageiros p,
    TABLE(p.necessidades) n
WHERE 
    p.necessidades IS NOT NULL
ORDER BY 
    p.id_passageiro, n.necessidade_especial;


DECLARE
    v_telefone_principal tp_telefone := tp_telefone('987654321', '11', '55');
    v_telefones_emergencia tp_telefones_varray := tp_telefones_varray(
        tp_telefone('912345678', '11', '55'),  
        tp_telefone('32567890', '11', '55')    
    );
    v_endereco tp_endereco := tp_endereco('01234567', 'Rua das Acácias', 100, 'São Paulo', 'SP');
    v_companhia tp_companhia_aerea := tp_companhia_aerea('12345678000199', 'Azul Linhas Aéreas', 150, 8000);
    
    -- Salary objects
    v_funcao_supervisor tp_funcao_salario_base := tp_funcao_salario_base(
        id => 1,
        funcao => 'Comandante',
        salario => 30000.00
    );
    
    v_funcao_tripulante tp_funcao_salario_base := tp_funcao_salario_base(
        id => 2,
        funcao => 'Copiloto',
        salario => 20000.00
    );
    
    v_supervisor_ref REF tp_tripulante;
    v_supervisor tp_tripulante;
BEGIN
    -- First insert the supervisor
    v_supervisor := tp_tripulante(
        cpf => '11122233344',
        nome => 'Carlos',
        sobrenome => 'Silva',
        email => 'carlos.silva@azul.com',
        data_de_nascimento => TO_DATE('15/03/1975', 'DD/MM/YYYY'),
        telefone_principal => v_telefone_principal,
        telefones_emergencia => v_telefones_emergencia,
        endereco => v_endereco,
        companhia_aerea => v_companhia,
        supervisor => NULL, -- Supervisor sem supervisor
        funcao_salario => v_funcao_supervisor,
        numero_funcionario => 1001,
        data_de_contratacao => TO_DATE('01/01/2010', 'DD/MM/YYYY'),
        nivel_seguranca => 1
    );
    
    INSERT INTO tb_tripulantes VALUES (v_supervisor);
    
    -- Get the REF to the supervisor
    SELECT REF(t) INTO v_supervisor_ref 
    FROM tb_tripulantes t 
    WHERE t.cpf = '11122233344';
    
    -- Different additional phones for the crew member
    v_telefones_emergencia := tp_telefones_varray(
        tp_telefone('998877665', '11', '55'),  -- Celular pessoal
        tp_telefone('32456789', '11', '55')    -- Telefone alternativo
    );
    
    -- Now insert the regular crew member with supervisor reference
    INSERT INTO tb_tripulantes VALUES (
        tp_tripulante(
            cpf => '22233344455',
            nome => 'Ana',
            sobrenome => 'Oliveira',
            email => 'ana.oliveira@azul.com',
            data_de_nascimento => TO_DATE('20/05/1985', 'DD/MM/YYYY'),
            telefone_principal => v_telefone_principal,
            telefones_emergencia => v_telefones_emergencia,
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
END;
/
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