-- Step 3: Test the display_info method
DECLARE
    v_supervisor tp_tripulante;
    v_tripulante tp_tripulante;
BEGIN
    -- Retrieve supervisor
    SELECT VALUE(t) INTO v_supervisor 
    FROM tripulantes t 
    WHERE t.numero_funcionario = 1001;
    
    -- Retrieve tripulante
    SELECT VALUE(t) INTO v_tripulante 
    FROM tripulantes t 
    WHERE t.numero_funcionario = 2001;
    
    -- Display information
    DBMS_OUTPUT.PUT_LINE('=== Supervisor ===');
    v_supervisor.display_info();
    
    DBMS_OUTPUT.PUT_LINE('=== Tripulante ===');
    v_tripulante.display_info();
END;