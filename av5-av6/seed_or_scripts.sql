
-- Inserindo Companhias Aéreas
INSERT INTO tb_companhias_aereas VALUES (tp_companhia_aerea('12345678901234', 'Azul Linhas Aéreas', 150, 7000));
INSERT INTO tb_companhias_aereas VALUES (tp_companhia_aerea('98765432109876', 'American Airlines', 200, 9000));
INSERT INTO tb_companhias_aereas VALUES (tp_companhia_aerea('11223344556677', 'Linhas Aéreas Nacionais', 100, 5000));
INSERT INTO tb_companhias_aereas VALUES (tp_companhia_aerea('88990011223344', 'Companhia Aérea Delta', 80, 3500));
INSERT INTO tb_companhias_aereas VALUES (tp_companhia_aerea('55443322110099', 'Airlines do Brasil', 50, 2500));
/

-- Inserindo Aeronaves
-- Companhia Aérea A (12345678901234)
INSERT INTO tb_aeronaves VALUES (1, (SELECT REF(c) FROM tb_companhias_aereas c WHERE c.cnpj = '12345678901234'), 'Boeing 737-800', 189, 2018);
INSERT INTO tb_aeronaves VALUES (2, (SELECT REF(c) FROM tb_companhias_aereas c WHERE c.cnpj = '12345678901234'), 'Airbus A320-200', 180, 2020);
-- Companhia Aérea B (98765432109876)
INSERT INTO tb_aeronaves VALUES (3, (SELECT REF(c) FROM tb_companhias_aereas c WHERE c.cnpj = '98765432109876'), 'Boeing 777-300ER', 396, 2015);
INSERT INTO tb_aeronaves VALUES (4, (SELECT REF(c) FROM tb_companhias_aereas c WHERE c.cnpj = '98765432109876'), 'Airbus A350-900', 315, 2019);
-- Companhia Aérea C (11223344556677)
INSERT INTO tb_aeronaves VALUES (5, (SELECT REF(c) FROM tb_companhias_aereas c WHERE c.cnpj = '11223344556677'), 'Embraer E195-E2', 146, 2021);
INSERT INTO tb_aeronaves VALUES (6, (SELECT REF(c) FROM tb_companhias_aereas c WHERE c.cnpj = '11223344556677'), 'Boeing 787-9', 290, 2017);
-- Companhia Aérea D (88990011223344)
INSERT INTO tb_aeronaves VALUES (7, (SELECT REF(c) FROM tb_companhias_aereas c WHERE c.cnpj = '88990011223344'), 'Airbus A330-200', 247, 2016);
INSERT INTO tb_aeronaves VALUES (8, (SELECT REF(c) FROM tb_companhias_aereas c WHERE c.cnpj = '88990011223344'), 'Boeing 767-300ER', 218, 2014);
-- Companhia Aérea E (55443322110099)
INSERT INTO tb_aeronaves VALUES (9, (SELECT REF(c) FROM tb_companhias_aereas c WHERE c.cnpj = '55443322110099'), 'ATR 72-600', 78, 2022);
INSERT INTO tb_aeronaves VALUES (10, (SELECT REF(c) FROM tb_companhias_aereas c WHERE c.cnpj = '55443322110099'), 'Airbus A319-100', 156, 2019);
/

-- Inserindo Passageiros
-- Passageiros Brasileiros
INSERT INTO tb_passageiros VALUES (tp_passageiro('11111111101', 'João', 'Silva', 'joao.silva@email.com', TO_DATE('1990-01-01', 'YYYY-MM-DD'), tp_telefone('11111111', '11', '55'), tp_telefones_varray(tp_telefone('22222222', '11', '55')), tp_endereco('12345678', 'Rua A', 100, 'São Paulo', 'SP'), tp_passaporte('AB123456', 'Brasil', TO_DATE('2020-01-01', 'YYYY-MM-DD'), TO_DATE('2030-01-01', 'YYYY-MM-DD')), 'Janela', 'Brasileira', NULL));
INSERT INTO tb_passageiros VALUES (tp_passageiro('22222222202', 'Maria', 'Santos', 'maria.santos@email.com', TO_DATE('1985-05-15', 'YYYY-MM-DD'), tp_telefone('33333333', '21', '55'), tp_telefones_varray(tp_telefone('44444444', '21', '55'), tp_telefone('55555555', '21', '55')), tp_endereco('98765432', 'Rua B', 200, 'Rio de Janeiro', 'RJ'), tp_passaporte('CD654321', 'Brasil', TO_DATE('2019-06-15', 'YYYY-MM-DD'), TO_DATE('2029-06-15', 'YYYY-MM-DD')), 'Meio', 'Brasileira', NULL));
INSERT INTO tb_passageiros VALUES (tp_passageiro('33333333303', 'Carlos', 'Oliveira', 'carlos.oliveira@email.com', TO_DATE('1982-10-20', 'YYYY-MM-DD'), tp_telefone('66666666', '31', '55'), tp_telefones_varray(tp_telefone('77777777', '31', '55'), tp_telefone('88888888', '31', '55'), tp_telefone('99999999', '31', '55')), tp_endereco('54321678', 'Rua C', 300, 'Belo Horizonte', 'MG'), tp_passaporte('EF987654', 'Brasil', TO_DATE('2018-11-20', 'YYYY-MM-DD'), TO_DATE('2028-11-20', 'YYYY-MM-DD')), 'Corredor', 'Brasileira', tp_nt_necessidades_especiais(tp_necessidades_especiais('Assistência para locomoção'))));
INSERT INTO tb_passageiros VALUES (tp_passageiro('44444444404', 'Ana', 'Pereira', 'ana.pereira@email.com', TO_DATE('1995-03-10', 'YYYY-MM-DD'), tp_telefone('12121212', '41', '55'), tp_telefones_varray(tp_telefone('13131313', '41', '55')), tp_endereco('67891234', 'Rua D', 400, 'Curitiba', 'PR'), tp_passaporte('GH432167', 'Brasil', TO_DATE('2021-03-10', 'YYYY-MM-DD'), TO_DATE('2031-03-10', 'YYYY-MM-DD')), 'Janela', 'Brasileira', NULL));
INSERT INTO tb_passageiros VALUES (tp_passageiro('55555555505', 'Pedro', 'Rodrigues', 'pedro.rodrigues@email.com', TO_DATE('1988-07-25', 'YYYY-MM-DD'), tp_telefone('14141414', '51', '55'), tp_telefones_varray(tp_telefone('15151515', '51', '55'), tp_telefone('16161616', '51', '55')), tp_endereco('23456789', 'Rua E', 500, 'Porto Alegre', 'RS'), tp_passaporte('IJ765432', 'Brasil', TO_DATE('2017-07-25', 'YYYY-MM-DD'), TO_DATE('2027-07-25', 'YYYY-MM-DD')), 'Meio', 'Brasileira', NULL));
INSERT INTO tb_passageiros VALUES (tp_passageiro('66666666606', 'Sofia', 'Almeida', 'sofia.almeida@email.com', TO_DATE('1992-12-05', 'YYYY-MM-DD'), tp_telefone('17171717', '61', '55'), tp_telefones_varray(tp_telefone('18181818', '61', '55'), tp_telefone('19191919', '61', '55'), tp_telefone('20202020', '61', '55')), tp_endereco('34567891', 'Rua F', 600, 'Brasília', 'DF'), tp_passaporte('KL123489', 'Brasil', TO_DATE('2022-12-05', 'YYYY-MM-DD'), TO_DATE('2032-12-05', 'YYYY-MM-DD')), 'Corredor', 'Brasileira', NULL));
INSERT INTO tb_passageiros VALUES (tp_passageiro('77777777707', 'Lucas', 'Fernandes', 'lucas.fernandes@email.com', TO_DATE('1987-09-18', 'YYYY-MM-DD'), tp_telefone('21212121', '71', '55'), tp_telefones_varray(tp_telefone('22222222', '71', '55')), tp_endereco('45678912', 'Rua G', 700, 'Salvador', 'BA'), tp_passaporte('MN987612', 'Brasil', TO_DATE('2016-09-18', 'YYYY-MM-DD'), TO_DATE('2026-09-18', 'YYYY-MM-DD')), 'Janela', 'Brasileira', NULL));
INSERT INTO tb_passageiros VALUES (tp_passageiro('88888888808', 'Isabela', 'Gomes', 'isabela.gomes@email.com', TO_DATE('1993-06-30', 'YYYY-MM-DD'), tp_telefone('23232323', '81', '55'), tp_telefones_varray(tp_telefone('24242424', '81', '55'), tp_telefone('25252525', '81', '55')), tp_endereco('56789123', 'Rua H', 800, 'Recife', 'PE'), tp_passaporte('OP345678', 'Brasil', TO_DATE('2020-06-30', 'YYYY-MM-DD'), TO_DATE('2030-06-30', 'YYYY-MM-DD')), 'Meio', 'Brasileira', NULL));
INSERT INTO tb_passageiros VALUES (tp_passageiro('10101010110', 'Camila', 'Ribeiro', 'camila.ribeiro@email.com', TO_DATE('1991-04-08', 'YYYY-MM-DD'), tp_telefone('28282828', '10', '55'), tp_telefones_varray(tp_telefone('29292929', '10', '55')), tp_endereco('67891011', 'Rua I', 900, 'Fortaleza', 'CE'), tp_passaporte('QR678912', 'Brasil', TO_DATE('2018-04-08', 'YYYY-MM-DD'), TO_DATE('2028-04-08', 'YYYY-MM-DD')), 'Janela', 'Brasileira', NULL));
INSERT INTO tb_passageiros VALUES (tp_passageiro('11111111111', 'Gustavo', 'Mendes', 'gustavo.mendes@email.com', TO_DATE('1986-12-28', 'YYYY-MM-DD'), tp_telefone('30303030', '11', '55'), tp_telefones_varray(tp_telefone('31313131', '11', '55'), tp_telefone('32323232', '11', '55')), tp_endereco('78910111', 'Rua J', 1000, 'Manaus', 'AM'), tp_passaporte('RS123456', 'Brasil', TO_DATE('2015-12-28', 'YYYY-MM-DD'), TO_DATE('2025-12-28', 'YYYY-MM-DD')), 'Meio', 'Brasileira', NULL));
INSERT INTO tb_passageiros VALUES (tp_passageiro('12121212112', 'Juliana', 'Costa', 'juliana.costa@email.com', TO_DATE('1994-07-12', 'YYYY-MM-DD'), tp_telefone('33333333', '12', '55'), tp_telefones_varray(tp_telefone('34343434', '12', '55'), tp_telefone('35353535', '12', '55'), tp_telefone('36363636', '12', '55')), tp_endereco('89101112', 'Rua K', 1100, 'Goiânia', 'GO'), tp_passaporte('TU678912', 'Brasil', TO_DATE('2021-07-12', 'YYYY-MM-DD'), TO_DATE('2031-07-12', 'YYYY-MM-DD')), 'Corredor', 'Brasileira', tp_nt_necessidades_especiais(tp_necessidades_especiais('Equipamento médico'))));
INSERT INTO tb_passageiros VALUES (tp_passageiro('13131313113', 'Thiago', 'Nunes', 'thiago.nunes@email.com', TO_DATE('1983-02-23', 'YYYY-MM-DD'), tp_telefone('37373737', '13', '55'), tp_telefones_varray(tp_telefone('38383838', '13', '55')), tp_endereco('91011121', 'Rua L', 1200, 'Belém', 'PA'), tp_passaporte('VW123456', 'Brasil', TO_DATE('2016-02-23', 'YYYY-MM-DD'), TO_DATE('2026-02-23', 'YYYY-MM-DD')), 'Janela', 'Brasileira', NULL));
INSERT INTO tb_passageiros VALUES (tp_passageiro('14141414114', 'Fernanda', 'Moraes', 'fernanda.moraes@email.com', TO_DATE('1996-09-03', 'YYYY-MM-DD'), tp_telefone('39393939', '14', '55'), tp_telefones_varray(tp_telefone('40404040', '14', '55'), tp_telefone('41414141', '14', '55')), tp_endereco('10111213', 'Rua M', 1300, 'Campo Grande', 'MS'), tp_passaporte('XY678912', 'Brasil', TO_DATE('2022-09-03', 'YYYY-MM-DD'), TO_DATE('2032-09-03', 'YYYY-MM-DD')), 'Meio', 'Brasileira', NULL));
INSERT INTO tb_passageiros VALUES (tp_passageiro('15151515115', 'Ricardo', 'Alves', 'ricardo.alves@email.com', TO_DATE('1984-06-18', 'YYYY-MM-DD'), tp_telefone('42424242', '15', '55'), tp_telefones_varray(tp_telefone('43434343', '15', '55')), tp_endereco('11121314', 'Rua N', 1400, 'João Pessoa', 'PB'), tp_passaporte('ZA123456', 'Brasil', TO_DATE('2017-06-18', 'YYYY-MM-DD'), TO_DATE('2027-06-18', 'YYYY-MM-DD')), 'Corredor', 'Brasileira', tp_nt_necessidades_especiais(tp_necessidades_especiais('Cadeira de rodas'), tp_necessidades_especiais('Assistência visual'))));
INSERT INTO tb_passageiros VALUES (tp_passageiro('16161616116', 'Patrícia', 'Leite', 'patricia.leite@email.com', TO_DATE('1997-01-28', 'YYYY-MM-DD'), tp_telefone('44444444', '16', '55'), tp_telefones_varray(tp_telefone('45454545', '16', '55'), tp_telefone('46464646', '16', '55')), tp_endereco('12131415', 'Rua O', 1500, 'Aracaju', 'SE'), tp_passaporte('BC678912', 'Brasil', TO_DATE('2023-01-28', 'YYYY-MM-DD'), TO_DATE('2033-01-28', 'YYYY-MM-DD')), 'Janela', 'Brasileira', NULL));
INSERT INTO tb_passageiros VALUES (tp_passageiro('17171717117', 'Daniel', 'Barbosa', 'daniel.barbosa@email.com', TO_DATE('1981-08-12', 'YYYY-MM-DD'), tp_telefone('47474747', '17', '55'), tp_telefones_varray(tp_telefone('48484848', '17', '55'), tp_telefone('49494949', '17', '55'), tp_telefone('50505050', '17', '55')), tp_endereco('13141516', 'Rua P', 1600, 'Macapá', 'AP'), tp_passaporte('CD123456', 'Brasil', TO_DATE('2016-08-12', 'YYYY-MM-DD'), TO_DATE('2026-08-12', 'YYYY-MM-DD')), 'Meio', 'Brasileira', tp_nt_necessidades_especiais(tp_necessidades_especiais('Oxigênio'), tp_necessidades_especiais('Assistência para locomoção'))));
INSERT INTO tb_passageiros VALUES (tp_passageiro('18181818118', 'Mariana', 'Rocha', 'mariana.rocha@email.com', TO_DATE('1998-03-22', 'YYYY-MM-DD'), tp_telefone('51515151', '18', '55'), tp_telefones_varray(tp_telefone('52525252', '18', '55')), tp_endereco('14151617', 'Rua Q', 1700, 'Boa Vista', 'RR'), tp_passaporte('EF678912', 'Brasil', TO_DATE('2022-03-22', 'YYYY-MM-DD'), TO_DATE('2032-03-22', 'YYYY-MM-DD')), 'Corredor', 'Brasileira', NULL));
INSERT INTO tb_passageiros VALUES (tp_passageiro('19191919119', 'Eduardo', 'Castro', 'eduardo.castro@email.com', TO_DATE('1985-11-05', 'YYYY-MM-DD'), tp_telefone('53535353', '19', '55'), tp_telefones_varray(tp_telefone('54545454', '19', '55'), tp_telefone('55555555', '19', '55')), tp_endereco('15161718', 'Rua R', 1800, 'Palmas', 'TO'), tp_passaporte('GH123456', 'Brasil', TO_DATE('2018-11-05', 'YYYY-MM-DD'), TO_DATE('2028-11-05', 'YYYY-MM-DD')), 'Janela', 'Brasileira', NULL));
-- Passageiros da América do Sul
INSERT INTO tb_passageiros VALUES (tp_passageiro('20202020220', 'Juan', 'Perez', 'juan.perez@email.com', TO_DATE('1980-03-15', 'YYYY-MM-DD'), tp_telefone('56565656', '56', '56'), tp_telefones_varray(tp_telefone('57575757', '56', '56')), tp_endereco('16171819', 'Calle A', 100, 'Buenos Aires', 'AR'), tp_passaporte('IJ123456', 'Argentina', TO_DATE('2019-03-15', 'YYYY-MM-DD'), TO_DATE('2029-03-15', 'YYYY-MM-DD')), 'Meio', 'Argentina', NULL));
INSERT INTO tb_passageiros VALUES (tp_passageiro('21212121221', 'Sofia', 'González', 'sofia.gonzalez@email.com', TO_DATE('1991-07-28', 'YYYY-MM-DD'), tp_telefone('58585858', '57', '57'), tp_telefones_varray(tp_telefone('59595959', '57', '57'), tp_telefone('60606060', '57', '57')), tp_endereco('17181920', 'Avenida B', 200, 'Santiago', 'CL'), tp_passaporte('KL678912', 'Chile', TO_DATE('2021-07-28', 'YYYY-MM-DD'), TO_DATE('2031-07-28', 'YYYY-MM-DD')), 'Janela', 'Chilena', NULL));
INSERT INTO tb_passageiros VALUES (tp_passageiro('22222222222', 'Mateo', 'Rodriguez', 'mateo.rodriguez@email.com', TO_DATE('1988-11-02', 'YYYY-MM-DD'), tp_telefone('61616161', '58', '58'), tp_telefones_varray(tp_telefone('62626262', '58', '58'), tp_telefone('63636363', '58', '58'), tp_telefone('64646464', '58', '58')), tp_endereco('18192021', 'Carrera C', 300, 'Bogotá', 'CO'), tp_passaporte('MN123456', 'Colômbia', TO_DATE('2018-11-02', 'YYYY-MM-DD'), TO_DATE('2028-11-02', 'YYYY-MM-DD')), 'Corredor', 'Colombiana', NULL));
-- Passageiro dos Estados Unidos
INSERT INTO tb_passageiros VALUES (tp_passageiro('23232323223', 'Emily', 'Smith', 'emily.smith@email.com', TO_DATE('1995-04-10', 'YYYY-MM-DD'), tp_telefone('65656565', '1', '1'), tp_telefones_varray(tp_telefone('66666666', '1', '1')), tp_endereco('19202122', 'Street D', 400, 'New York', 'NY'), tp_passaporte('OP678912', 'Estados Unidos', TO_DATE('2020-04-10', 'YYYY-MM-DD'), TO_DATE('2030-04-10', 'YYYY-MM-DD')), 'Janela', 'Americana', NULL));
-- Passageiro da África
INSERT INTO tb_passageiros VALUES (tp_passageiro('24242424224', 'Aisha', 'Mohammed', 'aisha.mohammed@email.com', TO_DATE('1986-09-22', 'YYYY-MM-DD'), tp_telefone('67676767', '24', '24'), tp_telefones_varray(tp_telefone('68686868', '24', '24'), tp_telefone('69696969', '24', '24')), tp_endereco('20212223', 'Avenue E', 500, 'Nairobi', 'KE'), tp_passaporte('QR123456', 'Quênia', TO_DATE('2017-09-22', 'YYYY-MM-DD'), TO_DATE('2027-09-22', 'YYYY-MM-DD')), 'Meio', 'Queniana', NULL));
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