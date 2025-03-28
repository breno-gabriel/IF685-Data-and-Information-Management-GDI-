---- ()

-- Companhia Aérea
SELECT a.codigo_aeronave, a.modelo, DEREF(REF(c)).razao_social as Razao_social
FROM tb_aeronaves a, tb_companhias_aereas c
WHERE a.companhia_aerea = REF(c);


SELECT a.codigo_aeronave, a.modelo, DEREF(REF(comp)).razao_social as Razao_social
FROM tb_aeronaves a, tb_companhias_aereas comp
WHERE a.companhia_aerea  IN (
    SELECT REF(c) 
    FROM tb_companhias_aereas c
    WHERE c.quantidade_total_de_funcionarios > 3500
);


-- Aeronaves
SELECT 
    DEREF(a.companhia_aerea).razao_social AS companhia,
    a.modelo,
    a.ano_fabricacao,
    a.capacidade
FROM tb_aeronaves a
ORDER BY 
    DEREF(a.companhia_aerea).razao_social,
    a.ano_fabricacao DESC
FETCH FIRST 5 ROWS ONLY;

-- Tripulantes

-- Consulta para encontrar o tripulante com o maior salário e exibir suas informações
DECLARE
    v_tripulante_ref REF tp_tripulante;
    v_tripulante tp_tripulante;
BEGIN
    -- Encontra o tripulante com o maior salário
    SELECT REF(t) INTO v_tripulante_ref
    FROM tb_tripulantes t
    WHERE t.funcao_salario.salario = (SELECT MAX(t2.funcao_salario.calcular_salario()) FROM tb_tripulantes t2);

    -- Dereferencia o objeto tripulante
    SELECT DEREF(v_tripulante_ref) INTO v_tripulante FROM dual;

    -- Exibe as informações do tripulante usando a procedure display_info
    v_tripulante.display_info();
END;
/

-- Voos
-- Consulta para ordenar voos por prioridade de status usando a função MAP
SELECT v.codigo_voo, v.categoria, v.status_voo
FROM tb_voos v
ORDER BY v.status_priority();

-- Voa
-- Conta o número de voos com categoria 'Nacional' a partir da tabela tb_voa
SELECT count(*) from tb_voa v where DEREF(v.voo).categoria = 'Nacional';
-- Opera
-- Esta consulta lista o cpf, nome e função dos tripulantes que estão operando na aeronave com código 1.
SELECT
    DEREF(o.tripulante).cpf AS cpf_tripulante,
    DEREF(o.tripulante).nome AS nome_tripulante,
    DEREF(o.tripulante).funcao_salario.funcao AS funcao_tripulante
FROM
    tb_opera o
WHERE
    DEREF(o.aeronave).codigo_aeronave = 1;