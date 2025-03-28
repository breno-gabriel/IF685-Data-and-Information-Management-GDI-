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