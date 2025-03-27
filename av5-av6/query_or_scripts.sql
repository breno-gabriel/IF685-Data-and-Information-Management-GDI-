DECLARE
    v_pessoa tp_pessoa;
    v_telefone_principal tp_telefone := tp_telefone('987654321', '11', '55');
    v_telefones_emergencia tp_telefones_varray := tp_telefones_varray(
        tp_telefone('912345678', '11', '55'),
        tp_telefone('876543219', '11', '55')
    );
    v_endereco tp_endereco := tp_endereco('01234567', 'Rua das Acácias', 100, 'São Paulo', 'SP');
BEGIN
    v_pessoa := tp_pessoa(
        cpf => '12345678901',
        nome => 'Maria',
        sobrenome => 'Silva',
        email => 'maria.silva@email.com',
        data_de_nascimento => TO_DATE('15/05/1985', 'DD/MM/YYYY'),
        telefone_principal => v_telefone_principal,
        telefones_emergencia => v_telefones_emergencia,
        endereco => v_endereco
    );
    
    v_pessoa.display_info();
END;
/