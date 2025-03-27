DECLARE
    -- Create passenger objects
    v_passageiro1 tp_passageiro;
    v_passageiro2 tp_passageiro;
    
    -- Create special needs collections
    v_necessidades1 nt_necessidades_especiais := nt_necessidades_especiais();
    v_necessidades2 nt_necessidades_especiais := nt_necessidades_especiais();
    
    -- Common objects
    v_telefone tp_telefone := tp_telefone('987654321', '11', '55');
    v_endereco tp_endereco := tp_endereco('01234567', 'Rua das Flores', 123, 'São Paulo', 'SP');
    v_telefones_emergencia tp_telefones_varray := tp_telefones_varray(
        tp_telefone('912345678', '11', '55')
    );
BEGIN
    -- Initialize passenger 1 (with special needs)
    v_passageiro1 := tp_passageiro(
        '12345678901', 'João', 'Silva', 'joao@email.com',
        TO_DATE('15/03/1985', 'DD/MM/YYYY'),
        v_telefone, v_telefones_emergencia, v_endereco,
        'BR12345678', 'Brasil', 
        TO_DATE('01/01/2020', 'DD/MM/YYYY'), TO_DATE('01/01/2030', 'DD/MM/YYYY'),
        'Janela', 'Brasileiro'
    );
    
    -- Add special needs for passenger 1 (now correctly passing the passageiro object)
    v_necessidades1.EXTEND(2);
    v_necessidades1(1) := tp_necessidades_especiais( 'Cadeira de rodas');
    v_necessidades1(2) := tp_necessidades_especiais('Assistência para embarque');
    
    -- Initialize passenger 2 (no special needs)
    v_passageiro2 := tp_passageiro(
        '98765432109', 'Maria', 'Santos', 'maria@email.com',
        TO_DATE('20/05/1990', 'DD/MM/YYYY'),
        v_telefone, v_telefones_emergencia, v_endereco,
        'BR98765432', 'Brasil', 
        TO_DATE('01/01/2021', 'DD/MM/YYYY'), TO_DATE('01/01/2031', 'DD/MM/YYYY'),
        'Corredor', 'Brasileira'
    );
    
    -- Insert into the table
    INSERT INTO tb_passageiros (passageiro, necessidades)
    VALUES (v_passageiro1, v_necessidades1);
    
    INSERT INTO tb_passageiros (passageiro, necessidades)
    VALUES (v_passageiro2, NULL);
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Passageiros cadastrados com sucesso!');
END;
/

SELECT 

    p.passageiro.pessoa.nome || ' ' || p.passageiro.pessoa.sobrenome AS nome_completo,
    p.passageiro.passaporte.numero_passaporte AS passaporte,
    p.passageiro.preferencia_assento AS assento,
    n.necessidade_especial
FROM 
    tb_passageiros p,
    TABLE(p.necessidades) n
WHERE 
    p.necessidades IS NOT NULL