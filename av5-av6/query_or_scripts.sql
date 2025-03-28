---- ()

SELECT a.codigo_aeronave, a.modelo, REF(c) AS companhia_ref
FROM tb_aeronaves a, tb_companhias_aereas c
WHERE a.companhia_aerea = REF(c);

