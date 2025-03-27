DECLARE
    v_companhia_aerea1 tp_companhia_aerea := tp_companhia_aerea('12345678901234', 'Companhia A', 100, 200);
    v_companhia_aerea2 tp_companhia_aerea := tp_companhia_aerea('12345678901234', 'Companhia B', 100, 200);
    v_aeronave1 tp_aeronave := tp_aeronave(1, v_companhia_aerea1, 'Modelo A', 100, 2020);
    v_aeronave2 tp_aeronave := tp_aeronave(2, v_companhia_aerea2, 'Modelo B', 200, 2015);
    v_result NUMBER;
BEGIN
    v_result := v_aeronave1.comparar_aeronave(v_aeronave2);
    IF v_result = -1 THEN
        DBMS_OUTPUT.PUT_LINE('Aeronave 1 é menor que a Aeronave 2');
    ELSIF v_result = 1 THEN
        DBMS_OUTPUT.PUT_LINE('Aeronave 1 é maior que a Aeronave 2');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Aeronave 1 é igual a Aeronave 2');
    END IF;
END;
/