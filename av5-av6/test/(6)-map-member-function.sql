DECLARE
    v_voo1 tp_voo := tp_voo(101, 'Doméstico', 'Agendando');
    v_voo2 tp_voo := tp_voo(102, 'Internacional', 'Em andamento');
    v_voo3 tp_voo := tp_voo(103, 'Doméstico', 'Concluido');
    v_voo4 tp_voo := tp_voo(104, 'Internacional', 'Cancelado');
    v_voo5 tp_voo := tp_voo(105, 'Doméstico', 'Outro status');
    
    v_resultado1 NUMBER;
    v_resultado2 NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== Testando valores MAP individuais ===');
    
    DBMS_OUTPUT.PUT_LINE('Voo 101 (Agendando): ' || v_voo1.status_priority());
    DBMS_OUTPUT.PUT_LINE('Voo 102 (Em andamento): ' || v_voo2.status_priority());
    DBMS_OUTPUT.PUT_LINE('Voo 103 (Concluido): ' || v_voo3.status_priority());
    DBMS_OUTPUT.PUT_LINE('Voo 104 (Cancelado): ' || v_voo4.status_priority());
    DBMS_OUTPUT.PUT_LINE('Voo 105 (Outro status): ' || v_voo5.status_priority());
    
    DBMS_OUTPUT.PUT_LINE('=== Testando comparações diretas ===');
    
    v_resultado1 := v_voo1.status_priority();
    v_resultado2 := v_voo2.status_priority();
    
    IF v_resultado1 < v_resultado2 THEN
        DBMS_OUTPUT.PUT_LINE('Voo Agendando vem antes de Voo Em andamento (CORRETO)');
    ELSE
        DBMS_OUTPUT.PUT_LINE('ERRO: Ordenação incorreta entre status');
    END IF;
    
    v_voo1.codigo_voo := 201;
    v_voo2.codigo_voo := 202;
    v_voo2.status_voo := 'Agendando'; 
    
    v_resultado1 := v_voo1.status_priority();
    v_resultado2 := v_voo2.status_priority();
    
    IF v_resultado1 < v_resultado2 THEN
        DBMS_OUTPUT.PUT_LINE('Voo 201 vem antes de Voo 202 quando mesmo status (CORRETO)');
    ELSE
        DBMS_OUTPUT.PUT_LINE('ERRO: Ordenação por código incorreta');
    END IF;
    
END;
/
