DECLARE
    v_telefone tp_telefone := tp_telefone('987654321', '11', '55');
    v_endereco tp_endereco := tp_endereco('01234567', 'Rua das Acácias', '100', 'São Paulo', 'SP');
    v_companhia tp_companhia_aerea := tp_companhia_aerea('12345678000199', 'Azul Linhas Aéreas', 150, 8000);
    v_funcao tp_funcao_salario_base := tp_funcao_salario_base(1, 'Piloto', 25000.00);
    v_tripulante tp_tripulante;
BEGIN
   
    v_tripulante := tp_tripulante(
        cpf => '11122233344',
        nome => 'Carlos',
        sobrenome => 'Silva',
        email => 'carlos.silva@azul.com',
        data_de_nascimento => TO_DATE('15/03/1975', 'DD/MM/YYYY'),
        telefone => v_telefone,
        endereco => v_endereco,
        companhia_aerea => v_companhia,
        supervisor => NULL,
        funcao_salario => v_funcao,
        numero_funcionario => 1001,
        data_de_contratacao => TO_DATE('01/01/2015', 'DD/MM/YYYY'),
        nivel_seguranca => 1
    );
    
    -- Display information
    v_tripulante.display_info();
    DBMS_OUTPUT.PUT_LINE('Salário Total: ' || v_tripulante.calcular_salario());
END;
/