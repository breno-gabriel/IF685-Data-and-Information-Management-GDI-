DECLARE
    v_telefone_principal tp_telefone := tp_telefone('987654321', '11', '55');
    v_telefones_emergencia tp_telefones_varray := tp_telefones_varray(
        tp_telefone('912345678', '11', '55'),  -- Celular
        tp_telefone('32567890', '11', '55')    -- Telefone residencial
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
    
    v_tripulante tp_tripulante;
BEGIN
   
       -- First insert the supervisor
    v_tripulante := tp_tripulante(
        cpf => '11122233344',
        nome => 'Carlos',
        sobrenome => 'Silva',
        email => 'carlos.silva@azul.com',
        data_de_nascimento => TO_DATE('15/03/1975', 'DD/MM/YYYY'),
        telefone_principal => v_telefone_principal,
        telefones_emergencia => v_telefones_emergencia,
        endereco => v_endereco,
        companhia_aerea => v_companhia,
        supervisor => NULL, -- Supervisor não tem supervisor
        funcao_salario => v_funcao_tripulante,
        numero_funcionario => 1001,
        data_de_contratacao => TO_DATE('01/01/2010', 'DD/MM/YYYY'),
        nivel_seguranca => 1
    );
    

    
    -- Display information
    v_tripulante.display_info();
    DBMS_OUTPUT.PUT_LINE('Salário Total: ' || v_tripulante.calcular_salario());
END;
/