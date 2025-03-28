DECLARE
    v_passageiro tp_passageiro;
    v_telefone_principal tp_telefone := tp_telefone('987654321', '11', '55');
    v_telefones_emergencia tp_telefones_varray := tp_telefones_varray(
        tp_telefone('912345678', '11', '55'),
        tp_telefone('876543219', '11', '55')
    );
    v_endereco tp_endereco := tp_endereco('01234567', 'Rua das Acácias', 100, 'São Paulo', 'SP');
    v_necessidades tp_nt_necessidades_especiais := tp_nt_necessidades_especiais(
        tp_necessidades_especiais('Nenhuma')
    );
BEGIN
    -- Create a new passageiro using the constructor with all required parameters
    v_passageiro := tp_passageiro(
        p_cpf => '12345678901',
        p_nome => 'João',
        p_sobrenome => 'Silva',
        p_email => 'joao.silva@email.com',
        p_data_nasc => TO_DATE('15/03/1985', 'DD/MM/YYYY'),
        p_telefone_principal => v_telefone_principal,
        p_telefones_emergencia => v_telefones_emergencia,
        p_endereco => v_endereco,
        p_num_passaporte => 'AB12345678',
        p_pais_emissao => 'Brasil',
        p_data_emissao => TO_DATE('01/01/2020', 'DD/MM/YYYY'),
        p_data_validade => TO_DATE('01/01/2030', 'DD/MM/YYYY'),
        p_preferencia_assento => 'Janela',
        p_nacionalidade => 'Brasileira',
        p_necessidades_especiais => v_necessidades
    );
    
    DBMS_OUTPUT.PUT_LINE('Passageiro criado com sucesso:');
    DBMS_OUTPUT.PUT_LINE('Nome: ' || v_passageiro.nome || ' ' || v_passageiro.sobrenome);
    DBMS_OUTPUT.PUT_LINE('Passaporte: ' || v_passageiro.passaporte.numero_passaporte);
    
    -- Test error cases
    BEGIN
        v_passageiro := tp_passageiro(
            p_cpf => '123', -- CPF inválido
            p_nome => 'Maria',
            p_sobrenome => 'Santos',
            p_email => 'maria@email.com',
            p_data_nasc => TO_DATE('20/05/1990', 'DD/MM/YYYY'),
            p_telefone_principal => v_telefone_principal,
            p_telefones_emergencia => v_telefones_emergencia,
            p_endereco => v_endereco,
            p_num_passaporte => 'X123', -- Passaporte inválido
            p_pais_emissao => 'Brasil',
            p_data_emissao => SYSDATE,
            p_data_validade => SYSDATE+365,
            p_preferencia_assento => 'CENTRO', -- Assento inválido
            p_nacionalidade => 'Brasileira',
            p_necessidades_especiais => v_necessidades
        );
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Erro esperado: ' || SQLERRM);
    END;
END;
/