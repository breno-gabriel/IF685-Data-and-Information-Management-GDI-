-- ALTER TABLE
ALTER TABLE Pessoa
    ADD (RG VARCHAR2(10));

-- CREATE INDEX
CREATE INDEX numero_do_passaporte_index
    ON Passageiro(Numero_do_passaporte);

CREATE INDEX salario_index 
    ON Funcao(salario);

CREATE INDEX pessoa_cpf_index
    ON Pessoa(CPF)

-- INSERT INTO

INSERT INTO Detalhes_Telefone (Numero_de_telefone, DDD, Codigo_do_pais) VALUES ('987651324', '71', '55');

INSERT INTO Pessoa (CPF, Nome, Sobrenome, Email, Data_de_nascimento, Numero_de_telefone, CEP, RG)  
VALUES ('33663864014', 'Pedro Henrique', 'de Araujo Baptista', 'phab@gmail.com', TO_DATE('2002-11-07', 'YYYY-MM-DD'), '987651324', '50040050');

-- UPDATE
UPDATE Telefones_Emergencia
    SET Numero_de_telefone = "997807321"
    WHERE CPF_Pessoa = "23456789012";

UPDATE Pessoa SET RG = '11300821'  WHERE CPF = '33663864014';
UPDATE Pessoa SET RG = '123456789' WHERE CPF = '12345678901';
UPDATE Pessoa SET RG = '987654321' WHERE CPF = '45678901234';
UPDATE Pessoa SET RG = '567890123' WHERE CPF = '44556677889';
UPDATE Pessoa SET RG = '456123789' WHERE CPF = '88990011223';
UPDATE Pessoa SET RG = '789456123' WHERE CPF = '99001122334';

-- DELETE
DELETE FROM Pessoa
    WHERE CPF = '33445566778'; 

-- SELECT-FROM-WHERE 

SELECT * FROM Pessoa; 

-- BETWEEN

SELECT Tripulante.CPF_Tripulante, Pessoa.Nome, Funcao_salario.salario FROM Pessoa
    INNER JOIN Tripulante ON Pessoa.CPF = Tripulante.CPF_Tripulante
    INNER JOIN Funcao_salario ON Funcao_salario.id = Tripulante.ID_Funcao
    WHERE Funcao_salario.salario BETWEEN 5000.000 AND 11000.000
    ORDER BY Funcao_salario.salario DESC;  

-- IN

-- Retornar o nome das companhias aéreas que operam em aeroportos localizados no estado do Paraná
SELECT razao_social
FROM Companhia_Aerea
WHERE cnpj IN (
    SELECT cnpj_companhia_aerea
    FROM Acomoda
    WHERE codigo_aeroporto IN (
        SELECT codigo_aeroporto
        FROM Aeroporto
        WHERE cep IN (
            SELECT cep
            FROM Endereco
            WHERE estado = 'Paraná'
        )
    )
);

-- LIKE

--- Retorna todos os aeroportos internacionais. 
SELECT * FROM Aeroporto WHERE Nome LIKE 'Aeroporto Internacional%';

-- IS NULL ou IS NOT NULL

--- Retorna as pessoas com RG cadastrado. 
SELECT CPF, Nome, Sobrenome, RG FROM Pessoa
    WHERE RG IS NOT NULL;

--- Retorna as pessoas com RG não cadastrado. 
SELECT CPF, Nome, Sobrenome FROM Pessoa
    WHERE RG IS NULL;

-- INNER JOIN

--- Retorna o nome, cpf e numero do passaporte de todos os passageiros que emitiram o documento no Brasil. 
SELECT Pessoa.Nome, Passageiro.Cpf_passageiro, Passageiro.Numero_do_passaporte FROM Pessoa
    INNER JOIN Passageiro ON Pessoa.CPF = Passageiro.Cpf_passageiro
    INNER JOIN Passaporte ON Passageiro.Numero_do_passaporte = Passaporte.Numero_do_passaporte
    WHERE Passaporte.Pais_de_emissao = 'Brasil'
    ORDER BY Pessoa.Nome;

-- MAX
-- AVG

-- Retornar nome e função do(s) funcionario(s) com o maior salário. Além disso, retorna a média salarial dos funcionários. 
SELECT Pessoa.Nome, Funcao_Salario.Funcao, Funcao_Salario.Salario, (SELECT AVG(Salario) FROM Funcao_Salario) AS MEDIA_SALARIAL FROM Pessoa 
    JOIN Tripulante ON Pessoa.CPF = Tripulante.CPF_Tripulante
    JOIN Funcao_Salario ON Funcao_Salario.id = Tripulante.ID_Funcao
    WHERE Funcao_Salario.Salario = (SELECT MAX(Salario) FROM Funcao_Salario); 

-- MIN
-- Retorna o menor salário das funções
SELECT MIN(Salario) AS Menor_Salario
FROM Funcao_Salario;
-- Retorna o modelo e o código da aeronave mais velha de cada companhia aérea
SELECT a.codigo_aeronave, a.modelo, a.ano_de_fabricacao, a.CNPJ_COMPANHIA_AEREA
FROM Aeronave a
WHERE a.ano_de_fabricacao = (
    SELECT MIN(a2.ano_de_fabricacao) 
    FROM Aeronave a2
    WHERE a2.CNPJ_COMPANHIA_AEREA = a.CNPJ_COMPANHIA_AEREA
);


-- COUNT
-- Retornar quantos passageiros não são brasileiros
SELECT COUNT (*) AS total_nao_brasileiros
FROM PASSAGEIRO p
WHERE p.nacionalidade NOT LIKE 'Brasileira';
-- Retornar quais as aeronaves mais velhas de cada companhia aérea
SELECT a.codigo_aeronave, a.modelo, a.capacidade, a.ano_de_fabricacao, a.CNPJ_COMPANHIA_AEREA
FROM Aeronave a
WHERE a.ano_de_fabricacao = (
    SELECT MIN(a2.ano_de_fabricacao) 
    FROM Aeronave a2
    WHERE a2.CNPJ_COMPANHIA_AEREA = a.CNPJ_COMPANHIA_AEREA
);


-- LEFT ou RIGHT ou FULL OUTER JOIN 
-- Retorna uma tabela com o nome supervisor com seu fucionario supervisionado
SELECT p2.nome AS funcionario, p1.nome AS supervisor FROM Tripulante tr1
    FULL OUTER JOIN Tripulante tr2 ON (tr1.CPF_Tripulante = tr2.CPF_Supervisor)
    LEFT OUTER JOIN Pessoa p1 on (p1.CPF = tr1.CPF_Tripulante)
    LEFT OUTER JOIN Pessoa p2 on (p2.CPF = tr2.CPF_Tripulante)


-- SUBCONSULTA COM OPERADOR RELACIONAL
-- SUBCONSULTA COM IN

-- Retorna o nome das pessoas com bagagens no voo cujo código da aeronave é 9
SELECT nome 
FROM Pessoa 
WHERE cpf IN (
    SELECT cpf_passageiro 
    FROM Bagagem 
    WHERE codigo_voo IN (
        SELECT codigo_voo 
        FROM Voa 
        WHERE codigo_aeronave = 9
    )
);~


 -- SUBCONSULTA COM ANY
 -- Todos os tripulantes que foram contratados antes do ano de fabricação de qualquer aeronave
SELECT * FROM Tripulante
    WHERE EXTRACT(YEAR from Tripulante.Data_de_contratacao) < ANY (
        SELECT Ano_de_fabricacao from Aeronave
    );


-- SUBCONSULTA COM ALL
-- Todos os tripulantes que não
SELECT p1.nome, fr1.Funcao, p1.Data_de_nascimento FROM Tripulante tr1
    INNER JOIN  Pessoa p1 ON tr1.CPF_Tripulante = p1.CPF
    INNER JOIN  Funcao_Salario fr1 ON fr1.id = tr1.ID_Funcao
    WHERE fr1.Funcao <> 'Piloto' AND p1.Data_de_nascimento < ANY (
        SELECT p2.Data_de_nascimento FROM Tripulante tr2
        INNER JOIN Pessoa p2 on tr2.CPF_Tripulante = p2.CPF
    	INNER JOIN  Funcao_Salario fr2 ON fr2.id = tr2.ID_Funcao
    	WHERE fr2.Funcao = 'Piloto'
    );
   

-- ORDER BY
SELECT Pessoa.nome, Funcao_Salario.Salario from Tripulante
    INNER JOIN Pessoa on Pessoa.CPF = Tripulante.CPF_Tripulante
    INNER JOIN Funcao_Salario on Funcao_Salario.id = Tripulante.ID_Funcao
    WHERE Funcao_Salario.Funcao = 'Comissário de Bordo'
    ORDER BY Funcao_Salario.Salario;

-- GROUP BY
-- HAVING
--- Encontra a função que possui o menor salário médio.

SELECT Funcao, AVG(Salario) AS Salario_Medio
FROM Funcao_Salario
GROUP BY Funcao
HAVING AVG(Salario) < 8500;

-- UNION ou INTERSECT ou MINUS

-- 1. Lista de passageiros que têm reserva
SELECT DISTINCT p.Cpf_passageiro, pe.Nome, pe.Sobrenome, 'Possui Reserva' AS Status_Passageiro FROM Passageiro p
    JOIN Reserva r ON p.Cpf_passageiro = r.CPF_Passageiro
    JOIN Pessoa pe ON p.Cpf_passageiro = pe.CPF

UNION

-- 2. Lista de passageiros que já realizaram um voo
SELECT DISTINCT p.Cpf_passageiro, pe.Nome, pe.Sobrenome, 'Já Viajou' AS Status_Passageiro FROM Passageiro p
    JOIN Reserva r ON p.Cpf_passageiro = r.CPF_Passageiro
    JOIN Voo_Detalhes vd ON r.Codigo_Voo = vd.Codigo_Voo AND r.CPF_Passageiro = vd.CPF_Passageiro
    JOIN Pessoa pe ON p.Cpf_passageiro = pe.CPF;


-- 3. Lista de passageiros que têm reserva, mas ainda não viajaram
SELECT DISTINCT p.Cpf_passageiro, pe.Nome, pe.Sobrenome, 'Possui Reserva, Mas Não Viajou' AS Status_Passageiro FROM Passageiro p
    JOIN Reserva r ON p.Cpf_passageiro = r.CPF_Passageiro
    LEFT JOIN Voo_Detalhes vd ON r.Codigo_Voo = vd.Codigo_Voo AND r.CPF_Passageiro = vd.CPF_Passageiro
    JOIN Pessoa pe ON p.Cpf_passageiro = pe.CPF
    WHERE vd.CPF_Passageiro IS NULL

MINUS

-- Removendo os passageiros que já viajaram
SELECT DISTINCT p.Cpf_passageiro, pe.Nome, pe.Sobrenome, 'Já Viajou' AS Status_Passageiro FROM Passageiro p
    JOIN Reserva r ON p.Cpf_passageiro = r.CPF_Passageiro
    JOIN Voo_Detalhes vd ON r.Codigo_Voo = vd.Codigo_Voo AND r.CPF_Passageiro = vd.CPF_Passageiro
    JOIN Pessoa pe ON p.Cpf_passageiro = pe.CPF;


-- 4. Lista de passageiros cadastrados, mas que nunca fizeram reserva
SELECT DISTINCT p.Cpf_passageiro, pe.Nome, pe.Sobrenome, 'Nunca Fez Reserva' AS Status_Passageiro FROM Passageiro p
    JOIN Pessoa pe ON p.Cpf_passageiro = pe.CPF

MINUS

SELECT DISTINCT r.CPF_Passageiro, pe.Nome, pe.Sobrenome, 'Possui Reserva' AS Status_Passageiro FROM Reserva r
    JOIN Passageiro p ON r.CPF_Passageiro = p.Cpf_passageiro
    JOIN Pessoa pe ON p.Cpf_passageiro = pe.CPF;


-- CREATE VIEW

--- Criando visão para retornar todas as informações sobre os funcionarios. 
CREATE VIEW funcionarios AS 
SELECT Pessoa.Nome, Tripulante.CPF_Tripulante, Funcao_Sialario.Funcao, Funcao_Salario.Salario FROM Pessoa
    INNER JOIN Tripulante ON Pessoa.CPF = Tripulante.CPF_Tripulante
    INNER JOIN Funcao_Salario ON Funcao_Salario.id = Tripulante.ID_Funcao;

-- GRANT / REVOKE

GRANT SELECT, INSERT ON Passageiro TO P