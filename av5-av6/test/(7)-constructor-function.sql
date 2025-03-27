DECLARE
    v_passageiro tp_passageiro;
BEGIN
    -- Create a new passageiro using the constructor
    v_passageiro := tp_passageiro(
        p_cpf => '12345678901',
        p_nome => 'João',
        p_sobrenome => 'Silva',
        p_email => 'joao.silva@email.com',
        p_data_nasc => TO_DATE('15/03/1985', 'DD/MM/YYYY'),
        p_num_passaporte => 'AB12345678',
        p_pais_emissao => 'Brasil',
        p_data_emissao => TO_DATE('01/01/2020', 'DD/MM/YYYY'),
        p_data_validade => TO_DATE('01/01/2030', 'DD/MM/YYYY'),
        p_preferencia_assento => 'Janela',
        p_nacionalidade => 'Brasileira'
    );
    
    DBMS_OUTPUT.PUT_LINE('Passageiro criado com sucesso:');
    DBMS_OUTPUT.PUT_LINE('Nome: ' || v_passageiro.pessoa.nome || ' ' || v_passageiro.pessoa.sobrenome);
    DBMS_OUTPUT.PUT_LINE('Passaporte: ' || v_passageiro.passaporte.numero_passaporte);
    

    BEGIN
        v_passageiro := tp_passageiro(
            '123', -- CPF inválido
            'Maria',
            'Santos',
            'maria@email.com',
            TO_DATE('20/05/1990', 'DD/MM/YYYY'),
            'X123', -- Passaporte inválido
            'Brasil',
            SYSDATE,
            SYSDATE+365,
            'CENTRO', -- Assento inválido
            'Brasileira'
        );
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Erro esperado: ' || SQLERRM);
    END;
END;
/