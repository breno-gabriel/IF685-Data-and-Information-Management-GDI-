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

-- Passageiros
SELECT 
    p.cpf,
    p.nome,
    t.ddd || ' ' || t.numero_telefone AS telefone_emergencia,
    t.codigo_pais
FROM tb_passageiros p, TABLE(p.telefones_emergencia) t;

-- Aeroportos

SELECT 
    DEREF(r.passageiro).cpf AS cpf_passageiro,
    a.codigo_aeroporto,
    a.nome AS aeroporto_origem,
    DEREF(r.destino).nome AS aeroporto_destino,
    DEREF(r.voo).codigo_voo as Cod_voo,
    DEREF(r.voo).status_voo as status_voo,
    
    r.data_decolagem,
    r.data_aterrissagem
    
FROM tb_aeroportos a, tb_reservas r
WHERE REF(a) = r.origem
ORDER BY a.nome, r.data_decolagem;

-- Reservas
SELECT
    r.classe,
    COUNT(*) AS quantidade_reservas,
    ROUND(AVG(b.peso_bagagem), 2) || ' kg' AS media_peso_bagagem
FROM tb_reservas r, TABLE(r.bagagens) b
GROUP BY r.classe;




SELECT DISTINCT
    DEREF(r.passageiro).cpf AS cpf,
    DEREF(r.passageiro).nome AS nome,
    b.peso_bagagem || ' kg' AS peso_bagagem
FROM tb_reservas r, TABLE(r.bagagens) b
WHERE EXISTS (
    SELECT 1 FROM TABLE(r.bagagens) b
    WHERE b.peso_bagagem > 25
);

-- Acomoda
-- Aeroportos com mais companhias que a média
SELECT 
    DEREF(a.aeroporto).nome AS aeroporto,
    COUNT(*) AS total_companhias
FROM tb_acomoda a
GROUP BY DEREF(a.aeroporto).nome
HAVING COUNT(*) > (
    SELECT AVG(COUNT(*)) 
    FROM tb_acomoda 
    GROUP BY aeroporto
)
ORDER BY total_companhias DESC;

SELECT 
    DEREF(a.aeroporto).nome AS aeroporto,
    DEREF(a.companhia_aerea).razao_social AS companhia,
    COUNT(av.codigo_aeronave) AS total_aeronaves
FROM 
    tb_acomoda a,
    tb_aeronaves av
WHERE 
    a.companhia_aerea = av.companhia_aerea
GROUP BY 
    DEREF(a.aeroporto).nome,
    DEREF(a.companhia_aerea).razao_social
ORDER BY 
    aeroporto, 
    total_aeronaves DESC;