DROP SEQUENCE aeroporto_sequence
DROP SEQUENCE voo_sequence
DROP SEQUENCE aeronave_sequence
DROP SEQUENCE passaporte_sequence
DROP SEQUENCE bagagem_sequence
DROP SEQUENCE funcao_sequence

CREATE SEQUENCE aeroporto_sequence
 START WITH     1
 INCREMENT BY   1
 NOMAXVALUE
 NOCACHE
 NOCYCLE;

 CREATE SEQUENCE voo_sequence
 START WITH     1
 INCREMENT BY   1
 NOMAXVALUE
 NOCACHE
 NOCYCLE;

 CREATE SEQUENCE aeronave_sequence
 START WITH     1
 INCREMENT BY   1
 NOMAXVALUE
 NOCACHE
 NOCYCLE;

CREATE SEQUENCE passaporte_sequence
 START WITH     1
 INCREMENT BY   1
 NOMAXVALUE
 NOCACHE
 NOCYCLE;

CREATE SEQUENCE bagagem_sequence
 START WITH     1
 INCREMENT BY   1
 NOMAXVALUE
 NOCACHE
 NOCYCLE;

 CREATE SEQUENCE funcao_sequence
 START WITH     1
 INCREMENT BY   1
 NOMAXVALUE
 NOCACHE
 NOCYCLE;

--  INSERT INTO Detalhes_Telefone_Emergencia (  Codigo_do_Pais, DDD, Numero_do_Telefone )
--     VALUES ('55', '011','987654321'  );

---Inserindo as funções e salarios.

INSERT INTO Funcao_Salario (id, Funcao, Salario) VALUES (funcao_sequence.NEXTVAL, 'Atendente de Check-in', 3200.000);
INSERT INTO Funcao_Salario (id, Funcao, Salario) VALUES (funcao_sequence.NEXTVAL, 'Agente de Segurança', 2900.500);
INSERT INTO Funcao_Salario (id, Funcao, Salario) VALUES (funcao_sequence.NEXTVAL, 'Controlador de Tráfego Aéreo', 8500.750);
INSERT INTO Funcao_Salario (id, Funcao, Salario) VALUES (funcao_sequence.NEXTVAL, 'Piloto', 15000.000);
INSERT INTO Funcao_Salario (id, Funcao, Salario) VALUES (funcao_sequence.NEXTVAL, 'Copiloto', 12000.000);
INSERT INTO Funcao_Salario (id, Funcao, Salario) VALUES (funcao_sequence.NEXTVAL, 'Mecânico de Aeronaves', 5000.250);
INSERT INTO Funcao_Salario (id, Funcao, Salario) VALUES (funcao_sequence.NEXTVAL, 'Despachante Operacional', 4800.000);
INSERT INTO Funcao_Salario (id, Funcao, Salario) VALUES (funcao_sequence.NEXTVAL, 'Funcionário de Bagagem', 2500.000);
INSERT INTO Funcao_Salario (id, Funcao, Salario) VALUES (funcao_sequence.NEXTVAL, 'Assistente de Pista', 2800.750);
INSERT INTO Funcao_Salario (id, Funcao, Salario) VALUES (funcao_sequence.NEXTVAL, 'Supervisor de Terminal', 6200.000);



--- Inserindo os passaportes.
INSERT INTO Passaporte (Numero_do_passaporte, Pais_de_emissao, Data_de_emissao, Data_de_validade)
VALUES ('A123456789', 'Brasil', TO_DATE('2020-01-15', 'YYYY-MM-DD'), TO_DATE('2030-01-15', 'YYYY-MM-DD'));

INSERT INTO Passaporte (Numero_do_passaporte, Pais_de_emissao, Data_de_emissao, Data_de_validade)
VALUES ('B987654321', 'Estados Unidos', TO_DATE('2018-06-10', 'YYYY-MM-DD'), TO_DATE('2028-06-10', 'YYYY-MM-DD'));

INSERT INTO Passaporte (Numero_do_passaporte, Pais_de_emissao, Data_de_emissao, Data_de_validade)
VALUES ('C456789012', 'França', TO_DATE('2022-11-01', 'YYYY-MM-DD'), TO_DATE('2032-11-01', 'YYYY-MM-DD'));

INSERT INTO Passaporte (Numero_do_passaporte, Pais_de_emissao, Data_de_emissao, Data_de_validade)
VALUES ('D112233445', 'Alemanha', TO_DATE('2019-03-20', 'YYYY-MM-DD'), TO_DATE('2029-03-20', 'YYYY-MM-DD'));

INSERT INTO Passaporte (Numero_do_passaporte, Pais_de_emissao, Data_de_emissao, Data_de_validade)
VALUES ('E223344556', 'Argentina', TO_DATE('2021-07-05', 'YYYY-MM-DD'), TO_DATE('2031-07-05', 'YYYY-MM-DD'));




---Inserindo endereços.
INSERT INTO Endereco (CEP, Logradouro, Numero, Cidade, Estado) VALUES ('01001000', 'Avenida Paulista', 1578, 'São Paulo', 'São Paulo');
INSERT INTO Endereco (CEP, Logradouro, Numero, Cidade, Estado) VALUES ('20040002', 'Rua da Assembleia', 98, 'Rio de Janeiro', 'Rio de Janeiro');
INSERT INTO Endereco (CEP, Logradouro, Numero, Cidade, Estado) VALUES ('30120040', 'Rua dos Guajajaras', 1450, 'Belo Horizonte', 'Minas Gerais');
INSERT INTO Endereco (CEP, Logradouro, Numero, Cidade, Estado) VALUES ('40010010', 'Avenida Sete de Setembro', 400, 'Salvador', 'Bahia');
INSERT INTO Endereco (CEP, Logradouro, Numero, Cidade, Estado) VALUES ('80010020', 'Rua XV de Novembro', 230, 'Curitiba', 'Paraná');
INSERT INTO Endereco (CEP, Logradouro, Numero, Cidade, Estado) VALUES ('50010030', 'Avenida Guararapes', 150, 'Recife', 'Pernambuco');
INSERT INTO Endereco (CEP, Logradouro, Numero, Cidade, Estado) VALUES ('60010040', 'Avenida Beira Mar', 200, 'Fortaleza', 'Ceará');
INSERT INTO Endereco (CEP, Logradouro, Numero, Cidade, Estado) VALUES ('70040050', 'Esplanada dos Ministérios', NULL, 'Brasília', 'Distrito Federal');
INSERT INTO Endereco (CEP, Logradouro, Numero, Cidade, Estado) VALUES ('80010020', 'Rua das Flores', 300, 'Curitiba', 'Paraná');
INSERT INTO Endereco (CEP, Logradouro, Numero, Cidade, Estado) VALUES ('90030070', 'Avenida Borges de Medeiros', 400, 'Porto Alegre', 'Rio Grande do Sul');
INSERT INTO Endereco (CEP, Logradouro, Numero, Cidade, Estado) VALUES ('01122000', 'Rua Augusta', 500, 'São Paulo', 'São Paulo');
INSERT INTO Endereco (CEP, Logradouro, Numero, Cidade, Estado) VALUES ('20230010', 'Rua do Ouvidor', 250, 'Rio de Janeiro', 'Rio de Janeiro');
INSERT INTO Endereco (CEP, Logradouro, Numero, Cidade, Estado) VALUES ('30150080', 'Avenida Afonso Pena', 1200, 'Belo Horizonte', 'Minas Gerais');
INSERT INTO Endereco (CEP, Logradouro, Numero, Cidade, Estado) VALUES ('40020030', 'Rua Chile', 350, 'Salvador', 'Bahia');
INSERT INTO Endereco (CEP, Logradouro, Numero, Cidade, Estado) VALUES ('80030040', 'Avenida Batel', 678, 'Curitiba', 'Paraná');
INSERT INTO Endereco (CEP, Logradouro, Numero, Cidade, Estado) VALUES ('50040050', 'Rua da Aurora', 90, 'Recife', 'Pernambuco');
INSERT INTO Endereco (CEP, Logradouro, Numero, Cidade, Estado) VALUES ('60050060', 'Rua Dragão do Mar', 150, 'Fortaleza', 'Ceará');
INSERT INTO Endereco (CEP, Logradouro, Numero, Cidade, Estado) VALUES ('70060070', 'Setor Comercial Sul', 100, 'Brasília', 'Distrito Federal');
INSERT INTO Endereco (CEP, Logradouro, Numero, Cidade, Estado) VALUES ('90040080', 'Rua Padre Chagas', 120, 'Porto Alegre', 'Rio Grande do Sul');
INSERT INTO Endereco (CEP, Logradouro, Numero, Cidade, Estado) VALUES ('68900020', 'Avenida FAB', 250, 'Macapá', 'Amapá');

INSERT INTO Endereco (CEP, Logradouro, Numero, Cidade, Estado) VALUES ('65020090', 'Avenida Litorânea', 180, 'São Luís', 'Maranhão');
INSERT INTO Endereco (CEP, Logradouro, Numero, Cidade, Estado) VALUES ('57025010', 'Rua do Comércio', 75, 'Maceió', 'Alagoas');
INSERT INTO Endereco (CEP, Logradouro, Numero, Cidade, Estado) VALUES ('76801020', 'Avenida Jorge Teixeira', 500, 'Porto Velho', 'Rondônia');
INSERT INTO Endereco (CEP, Logradouro, Numero, Cidade, Estado) VALUES ('88010030', 'Rua Bocaiúva', 210, 'Florianópolis', 'Santa Catarina');
INSERT INTO Endereco (CEP, Logradouro, Numero, Cidade, Estado) VALUES ('58040040', 'Avenida Epitácio Pessoa', 350, 'João Pessoa', 'Paraíba');
INSERT INTO Endereco (CEP, Logradouro, Numero, Cidade, Estado) VALUES ('69050050', 'Rua dos Andradas', 120, 'Manaus', 'Amazonas');
INSERT INTO Endereco (CEP, Logradouro, Numero, Cidade, Estado) VALUES ('79060060', 'Rua 14 de Julho', 90, 'Campo Grande', 'Mato Grosso do Sul');
INSERT INTO Endereco (CEP, Logradouro, Numero, Cidade, Estado) VALUES ('66970070', 'Rua Manoel Barata', 200, 'Belém', 'Pará');
INSERT INTO Endereco (CEP, Logradouro, Numero, Cidade, Estado) VALUES ('76820080', 'Avenida Amazonas', 80, 'Ji-Paraná', 'Rondônia');
INSERT INTO Endereco (CEP, Logradouro, Numero, Cidade, Estado) VALUES ('69310090', 'Rua Cecília Brasil', 150, 'Boa Vista', 'Roraima');



---Inserindo companhias aereas.
INSERT INTO Companhia_Aerea (CNPJ, Razao_social, Frota_total_de_aeronaves, Quantidade_total_de_funcionarios) VALUES ('12345678000101', 'Azul Linhas Aéreas', 160, 12000);
INSERT INTO Companhia_Aerea (CNPJ, Razao_social, Frota_total_de_aeronaves, Quantidade_total_de_funcionarios) VALUES ('98765432000199', 'Gol Linhas Aéreas', 140, 10000);
INSERT INTO Companhia_Aerea (CNPJ, Razao_social, Frota_total_de_aeronaves, Quantidade_total_de_funcionarios) VALUES ('56789012000188', 'Latam Airlines Brasil', 200, 15000);
INSERT INTO Companhia_Aerea (CNPJ, Razao_social, Frota_total_de_aeronaves, Quantidade_total_de_funcionarios) VALUES ('34567890000177', 'American Airlines', 850, 120000);
INSERT INTO Companhia_Aerea (CNPJ, Razao_social, Frota_total_de_aeronaves, Quantidade_total_de_funcionarios) VALUES ('23456789000166', 'Lufthansa', 750, 110000);
INSERT INTO Companhia_Aerea (CNPJ, Razao_social, Frota_total_de_aeronaves, Quantidade_total_de_funcionarios) VALUES ('45678901000155', 'Emirates Airlines', 260, 62000);
INSERT INTO Companhia_Aerea (CNPJ, Razao_social, Frota_total_de_aeronaves, Quantidade_total_de_funcionarios) VALUES ('67890123000144', 'Qatar Airways', 230, 45000);
INSERT INTO Companhia_Aerea (CNPJ, Razao_social, Frota_total_de_aeronaves, Quantidade_total_de_funcionarios) VALUES ('78901234000133', 'British Airways', 280, 55000);
INSERT INTO Companhia_Aerea (CNPJ, Razao_social, Frota_total_de_aeronaves, Quantidade_total_de_funcionarios) VALUES ('89012345000122', 'Air France', 300, 75000);
INSERT INTO Companhia_Aerea (CNPJ, Razao_social, Frota_total_de_aeronaves, Quantidade_total_de_funcionarios) VALUES ('90123456000111', 'Delta Airlines', 900, 91000);


---Inserindo Voo.
INSERT INTO Voo (Codigo_voo, Categoria, Status_voo) VALUES (voo_sequence.NEXTVAL, 'Nacional', 'Agendando');
INSERT INTO Voo (Codigo_voo, Categoria, Status_voo) VALUES (voo_sequence.NEXTVAL, 'Internacional', 'Em andamento');
INSERT INTO Voo (Codigo_voo, Categoria, Status_voo) VALUES (voo_sequence.NEXTVAL, 'Nacional', 'Concluido');
INSERT INTO Voo (Codigo_voo, Categoria, Status_voo) VALUES (voo_sequence.NEXTVAL, 'Internacional', 'Cancelado');
INSERT INTO Voo (Codigo_voo, Categoria, Status_voo) VALUES (voo_sequence.NEXTVAL, 'Nacional', 'Agendando');
INSERT INTO Voo (Codigo_voo, Categoria, Status_voo) VALUES (voo_sequence.NEXTVAL, 'Internacional', 'Em andamento');
INSERT INTO Voo (Codigo_voo, Categoria, Status_voo) VALUES (voo_sequence.NEXTVAL, 'Nacional', 'Concluido');
INSERT INTO Voo (Codigo_voo, Categoria, Status_voo) VALUES (voo_sequence.NEXTVAL, 'Internacional', 'Cancelado');
INSERT INTO Voo (Codigo_voo, Categoria, Status_voo) VALUES (voo_sequence.NEXTVAL, 'Nacional', 'Agendando');
INSERT INTO Voo (Codigo_voo, Categoria, Status_voo) VALUES (voo_sequence.NEXTVAL, 'Internacional', 'Em andamento');

---Inserindo detalhes telefone.

INSERT INTO Detalhes_Telefone (Numero_de_telefone, DDD, Codigo_do_pais) VALUES ('998877665', '71', '55');
INSERT INTO Detalhes_Telefone (Numero_de_telefone, DDD, Codigo_do_pais) VALUES ('887766554', '85', '55');
INSERT INTO Detalhes_Telefone (Numero_de_telefone, DDD, Codigo_do_pais) VALUES ('776655443', '48', '55');
INSERT INTO Detalhes_Telefone (Numero_de_telefone, DDD, Codigo_do_pais) VALUES ('665544332', '92', '55');
INSERT INTO Detalhes_Telefone (Numero_de_telefone, DDD, Codigo_do_pais) VALUES ('554433221', '98', '55');
INSERT INTO Detalhes_Telefone (Numero_de_telefone, DDD, Codigo_do_pais) VALUES ('112233445', '11', '55'); 
INSERT INTO Detalhes_Telefone (Numero_de_telefone, DDD, Codigo_do_pais) VALUES ('223344556', '21', '55'); 
INSERT INTO Detalhes_Telefone (Numero_de_telefone, DDD, Codigo_do_pais) VALUES ('334455667', '61', '55'); 

INSERT INTO Detalhes_Telefone (Numero_de_telefone, DDD, Codigo_do_pais)  VALUES ('987654321', '213', '1');
INSERT INTO Detalhes_Telefone (Numero_de_telefone, DDD, Codigo_do_pais)  VALUES ('876543210', '305', '1');
INSERT INTO Detalhes_Telefone (Numero_de_telefone, DDD, Codigo_do_pais)  VALUES ('765432109', '312', '1');
INSERT INTO Detalhes_Telefone (Numero_de_telefone, DDD, Codigo_do_pais)  VALUES ('654321098', '702', '1');

INSERT INTO Detalhes_Telefone (Numero_de_telefone, DDD, Codigo_do_pais)  VALUES ('543210987', '39', '39');
INSERT INTO Detalhes_Telefone (Numero_de_telefone, DDD, Codigo_do_pais)  VALUES ('432109876', '34', '34');
INSERT INTO Detalhes_Telefone (Numero_de_telefone, DDD, Codigo_do_pais)  VALUES ('321098765', '46', '46');
INSERT INTO Detalhes_Telefone (Numero_de_telefone, DDD, Codigo_do_pais)  VALUES ('210987654', '31', '31');

INSERT INTO Detalhes_Telefone (Numero_de_telefone, DDD, Codigo_do_pais)  VALUES ('109876543', '86', '86');
INSERT INTO Detalhes_Telefone (Numero_de_telefone, DDD, Codigo_do_pais)  VALUES ('987654321', '91', '91');
INSERT INTO Detalhes_Telefone (Numero_de_telefone, DDD, Codigo_do_pais)  VALUES ('876543210', '82', '82');
INSERT INTO Detalhes_Telefone (Numero_de_telefone, DDD, Codigo_do_pais)  VALUES ('765432109', '65', '65');
INSERT INTO Detalhes_Telefone (Numero_de_telefone, DDD, Codigo_do_pais)  VALUES ('654321098', '62', '62');

INSERT INTO Detalhes_Telefone (Numero_de_telefone, DDD, Codigo_do_pais) VALUES ('445566778', '44', '44'); 

INSERT INTO Detalhes_Telefone (Numero_de_telefone, DDD, Codigo_do_pais) VALUES ('556677889', '81', '81'); 


--Inserindo Aeroporto --CEP (fkey)
INSERT INTO Aeroporto (Codigo_Aeroporto, Nome, Cep) VALUES (aeroporto_sequence.NEXTVAL, 'Aeroporto de Guarulhos', '01001000');
INSERT INTO Aeroporto (Codigo_Aeroporto, Nome, Cep) VALUES (aeroporto_sequence.NEXTVAL, 'Aeroporto Santos Dumont', '20040002');
INSERT INTO Aeroporto (Codigo_Aeroporto, Nome, Cep) VALUES (aeroporto_sequence.NEXTVAL, 'Aeroporto de Confins', '30120040');
INSERT INTO Aeroporto (Codigo_Aeroporto, Nome, Cep) VALUES (aeroporto_sequence.NEXTVAL, 'Aeroporto de Salvador', '80010020');
INSERT INTO Aeroporto (Codigo_Aeroporto, Nome, Cep) VALUES (aeroporto_sequence.NEXTVAL, 'Aeroporto Pinto Martins', '80010020');



---Inserindo aeronaves

INSERT INTO Aeronave (Codigo_Aeronave, CNPJ_Companhia_aerea, Modelo, Capacidade, Ano_de_fabricacao) 
VALUES (aeronave_sequence.NEXTVAL, '12345678000101', 'Airbus A320', 180, 2018);
INSERT INTO Aeronave (Codigo_Aeronave, CNPJ_Companhia_aerea, Modelo, Capacidade, Ano_de_fabricacao) 
VALUES (aeronave_sequence.NEXTVAL, '12345678000101', 'Embraer E195', 132, 2020);
INSERT INTO Aeronave (Codigo_Aeronave, CNPJ_Companhia_aerea, Modelo, Capacidade, Ano_de_fabricacao) 
VALUES (aeronave_sequence.NEXTVAL, '98765432000199', 'Boeing 737-800', 189, 2015);
INSERT INTO Aeronave (Codigo_Aeronave, CNPJ_Companhia_aerea, Modelo, Capacidade, Ano_de_fabricacao) 
VALUES (aeronave_sequence.NEXTVAL, '56789012000188', 'Boeing 777-300', 396, 2017);
INSERT INTO Aeronave (Codigo_Aeronave, CNPJ_Companhia_aerea, Modelo, Capacidade, Ano_de_fabricacao) 
VALUES (aeronave_sequence.NEXTVAL, '56789012000188', 'Airbus A350', 350, 2021);
INSERT INTO Aeronave (Codigo_Aeronave, CNPJ_Companhia_aerea, Modelo, Capacidade, Ano_de_fabricacao) 
VALUES (aeronave_sequence.NEXTVAL, '34567890000177', 'Boeing 787-9', 296, 2019);
INSERT INTO Aeronave (Codigo_Aeronave, CNPJ_Companhia_aerea, Modelo, Capacidade, Ano_de_fabricacao) 
VALUES (aeronave_sequence.NEXTVAL, '23456789000166', 'Airbus A380', 850, 2015);
INSERT INTO Aeronave (Codigo_Aeronave, CNPJ_Companhia_aerea, Modelo, Capacidade, Ano_de_fabricacao) 
VALUES (aeronave_sequence.NEXTVAL, '45678901000155', 'Boeing 777X', 425, 2022);
INSERT INTO Aeronave (Codigo_Aeronave, CNPJ_Companhia_aerea, Modelo, Capacidade, Ano_de_fabricacao) 
VALUES (aeronave_sequence.NEXTVAL, '67890123000144', 'Airbus A350', 325, 2021);
INSERT INTO Aeronave (Codigo_Aeronave, CNPJ_Companhia_aerea, Modelo, Capacidade, Ano_de_fabricacao) 
VALUES (aeronave_sequence.NEXTVAL, '78901234000133', 'Boeing 747-8', 410, 2014);
INSERT INTO Aeronave (Codigo_Aeronave, CNPJ_Companhia_aerea, Modelo, Capacidade, Ano_de_fabricacao) 
VALUES (aeronave_sequence.NEXTVAL, '89012345000122', 'Airbus A320neo', 195, 2020);
INSERT INTO Aeronave (Codigo_Aeronave, CNPJ_Companhia_aerea, Modelo, Capacidade, Ano_de_fabricacao) 
VALUES (aeronave_sequence.NEXTVAL, '90123456000111', 'Boeing 737 MAX', 210, 2021);
INSERT INTO Aeronave (Codigo_Aeronave, CNPJ_Companhia_aerea, Modelo, Capacidade, Ano_de_fabricacao) 
VALUES (aeronave_sequence.NEXTVAL, '90123456000111', 'Boeing 767-300', 261, 2016);

SELECT * FROM Funcao_Salario; 

SELECT * FROM Passaporte; 

SELECT * FROM Companhia_Aerea;

-- Inserindo pessoas
INSERT INTO Pessoa (CPF, Nome, Sobrenome, Email, Data_de_nascimento, Numero_de_telefone, CEP) 
VALUES ('12345678901', 'Lucas', 'Silva', 'lucas.silva@email.com', TO_DATE('1995-03-15', 'YYYY-MM-DD'), '998877665', '01001000');
INSERT INTO Pessoa (CPF, Nome, Sobrenome, Email, Data_de_nascimento, Numero_de_telefone, CEP) 
VALUES ('23456789012', 'Mariana', 'Souza', 'mariana.souza@email.com', TO_DATE('1988-07-22', 'YYYY-MM-DD'), '887766554', '20040002');
INSERT INTO Pessoa (CPF, Nome, Sobrenome, Email, Data_de_nascimento, Numero_de_telefone, CEP) 
VALUES ('34567890123', 'Fernando', 'Oliveira', 'fernando.oliveira@email.com', TO_DATE('1990-11-05', 'YYYY-MM-DD'), '776655443', '30120040');
INSERT INTO Pessoa (CPF, Nome, Sobrenome, Email, Data_de_nascimento, Numero_de_telefone, CEP) 
VALUES ('45678901234', 'Amanda', 'Costa', 'amanda.costa@email.com', TO_DATE('1985-05-12', 'YYYY-MM-DD'), '665544332', '40010010');
INSERT INTO Pessoa (CPF, Nome, Sobrenome, Email, Data_de_nascimento, Numero_de_telefone, CEP) 
VALUES ('56789012345', 'Carlos', 'Pereira', 'carlos.pereira@email.com', TO_DATE('1992-09-30', 'YYYY-MM-DD'), '554433221', '80010020');
INSERT INTO Pessoa (CPF, Nome, Sobrenome, Email, Data_de_nascimento, Numero_de_telefone, CEP) 
VALUES ('67890123456', 'Juliana', 'Ferreira', 'juliana.ferreira@email.com', TO_DATE('1998-12-18', 'YYYY-MM-DD'), '112233445', '50010030');
INSERT INTO Pessoa (CPF, Nome, Sobrenome, Email, Data_de_nascimento, Numero_de_telefone, CEP) 
VALUES ('78901234567', 'Roberto', 'Almeida', 'roberto.almeida@email.com', TO_DATE('1975-04-25', 'YYYY-MM-DD'), '223344556', '60010040');
INSERT INTO Pessoa (CPF, Nome, Sobrenome, Email, Data_de_nascimento, Numero_de_telefone, CEP) 
VALUES ('89012345678', 'Tatiane', 'Lima', 'tatiane.lima@email.com', TO_DATE('2000-06-10', 'YYYY-MM-DD'), '334455667', '70040050');
INSERT INTO Pessoa (CPF, Nome, Sobrenome, Email, Data_de_nascimento, Numero_de_telefone, CEP) 
VALUES ('90123456789', 'Eduardo', 'Rodrigues', 'eduardo.rodrigues@email.com', TO_DATE('1983-08-07', 'YYYY-MM-DD'), '987654321', '80010020');
INSERT INTO Pessoa (CPF, Nome, Sobrenome, Email, Data_de_nascimento, Numero_de_telefone, CEP) 
VALUES ('01234567890', 'Beatriz', 'Martins', 'beatriz.martins@email.com', TO_DATE('1997-10-03', 'YYYY-MM-DD'), '876543210', '90030070');
INSERT INTO Pessoa (CPF, Nome, Sobrenome, Email, Data_de_nascimento, Numero_de_telefone, CEP) 
VALUES ('11223344556', 'André', 'Gomes', 'andre.gomes@email.com', TO_DATE('1986-01-22', 'YYYY-MM-DD'), '765432109', '01122000');
INSERT INTO Pessoa (CPF, Nome, Sobrenome, Email, Data_de_nascimento, Numero_de_telefone, CEP) 
VALUES ('22334455667', 'Fernanda', 'Barbosa', 'fernanda.barbosa@email.com', TO_DATE('1993-03-29', 'YYYY-MM-DD'), '654321098', '20230010');
INSERT INTO Pessoa (CPF, Nome, Sobrenome, Email, Data_de_nascimento, Numero_de_telefone, CEP) 
VALUES ('33445566778', 'Ricardo', 'Mendes', 'ricardo.mendes@email.com', TO_DATE('1979-07-14', 'YYYY-MM-DD'), '543210987', '30150080');
INSERT INTO Pessoa (CPF, Nome, Sobrenome, Email, Data_de_nascimento, Numero_de_telefone, CEP) 
VALUES ('44556677889', 'Larissa', 'Carvalho', 'larissa.carvalho@email.com', TO_DATE('2002-09-08', 'YYYY-MM-DD'), '432109876', '40020030');
INSERT INTO Pessoa (CPF, Nome, Sobrenome, Email, Data_de_nascimento, Numero_de_telefone, CEP) 
VALUES ('55667788990', 'Paulo', 'Nogueira', 'paulo.nogueira@email.com', TO_DATE('1991-05-17', 'YYYY-MM-DD'), '321098765', '80030040');
INSERT INTO Pessoa (CPF, Nome, Sobrenome, Email, Data_de_nascimento, Numero_de_telefone, CEP) 
VALUES ('66778899001', 'Gabriela', 'Ramos', 'gabriela.ramos@email.com', TO_DATE('1996-12-02', 'YYYY-MM-DD'), '210987654', '50040050');
INSERT INTO Pessoa (CPF, Nome, Sobrenome, Email, Data_de_nascimento, Numero_de_telefone, CEP) 
VALUES ('77889900112', 'Diego', 'Azevedo', 'diego.azevedo@email.com', TO_DATE('1984-11-23', 'YYYY-MM-DD'), '109876543', '60050060');
INSERT INTO Pessoa (CPF, Nome, Sobrenome, Email, Data_de_nascimento, Numero_de_telefone, CEP) 
VALUES ('88990011223', 'Aline', 'Teixeira', 'aline.teixeira@email.com', TO_DATE('1972-06-19', 'YYYY-MM-DD'), '987654321', '70060070');
INSERT INTO Pessoa (CPF, Nome, Sobrenome, Email, Data_de_nascimento, Numero_de_telefone, CEP) 
VALUES ('99001122334', 'Rodrigo', 'Campos', 'rodrigo.campos@email.com', TO_DATE('2001-08-31', 'YYYY-MM-DD'), '876543210', '90040080');
INSERT INTO Pessoa (CPF, Nome, Sobrenome, Email, Data_de_nascimento, Numero_de_telefone, CEP) 
VALUES ('10111222334', 'Camila', 'Monteiro', 'camila.monteiro@email.com', TO_DATE('1994-04-13', 'YYYY-MM-DD'), '556677889', '68900020');


-- Inserindo passageiros

-- Inserindo tripulantes

-- Inserindo bagagens

-- Inserindo reservas

-- Inserindo opera

-- Inserindo voo_detalhes

-- Inserindo telefone_emergencia

-- Inserindo necessidades_especiais

-- Inserindo Voa
INSERT INTO Voa (Codigo_Aeronave, Codigo_Aeroporto, Codigo_Voo) 
VALUES (1, 1, '1');
INSERT INTO Voa (Codigo_Aeronave, Codigo_Aeroporto, Codigo_Voo) 
VALUES (2, 2, '2');
INSERT INTO Voa (Codigo_Aeronave, Codigo_Aeroporto, Codigo_Voo) 
VALUES (3, 3, '3');
INSERT INTO Voa (Codigo_Aeronave, Codigo_Aeroporto, Codigo_Voo) 
VALUES (4, 4, '4');
INSERT INTO Voa (Codigo_Aeronave, Codigo_Aeroporto, Codigo_Voo) 
VALUES (5, 5, '5');
INSERT INTO Voa (Codigo_Aeronave, Codigo_Aeroporto, Codigo_Voo) 
VALUES (6, 1, '6');
INSERT INTO Voa (Codigo_Aeronave, Codigo_Aeroporto, Codigo_Voo) 
VALUES (7, 2, '7');
INSERT INTO Voa (Codigo_Aeronave, Codigo_Aeroporto, Codigo_Voo) 
VALUES (8, 3, '8');
INSERT INTO Voa (Codigo_Aeronave, Codigo_Aeroporto, Codigo_Voo) 
VALUES (9, 4, '9');
INSERT INTO Voa (Codigo_Aeronave, Codigo_Aeroporto, Codigo_Voo) 
VALUES (10, 5, '10');


-- Inserindo Acomoda
INSERT INTO Acomoda (Codigo_Aeroporto, CNPJ_Companhia_aerea) 
VALUES (1, '12345678000101');
INSERT INTO Acomoda (Codigo_Aeroporto, CNPJ_Companhia_aerea) 
VALUES (2, '98765432000199');
INSERT INTO Acomoda (Codigo_Aeroporto, CNPJ_Companhia_aerea) 
VALUES (3, '56789012000188');
INSERT INTO Acomoda (Codigo_Aeroporto, CNPJ_Companhia_aerea) 
VALUES (4, '34567890000177');
INSERT INTO Acomoda (Codigo_Aeroporto, CNPJ_Companhia_aerea) 
VALUES (5, '23456789000166');
INSERT INTO Acomoda (Codigo_Aeroporto, CNPJ_Companhia_aerea) 
VALUES (1, '45678901000155');
INSERT INTO Acomoda (Codigo_Aeroporto, CNPJ_Companhia_aerea) 
VALUES (2, '67890123000144');
INSERT INTO Acomoda (Codigo_Aeroporto, CNPJ_Companhia_aerea) 
VALUES (3, '78901234000133');
INSERT INTO Acomoda (Codigo_Aeroporto, CNPJ_Companhia_aerea) 
VALUES (4, '89012345000122');
INSERT INTO Acomoda (Codigo_Aeroporto, CNPJ_Companhia_aerea) 
VALUES (5, '90123456000111');