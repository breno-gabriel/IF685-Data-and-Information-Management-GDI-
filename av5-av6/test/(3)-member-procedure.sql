DECLARE
    v_telefone_principal tp_telefone := tp_telefone('987654321', '011', '55');
    v_telefones_emergencia tp_telefones_varray := tp_telefones_varray(); -- Empty varray for emergency phones
    v_endereco tp_endereco := tp_endereco('01234567', 'Rua das Flores', 123, 'São Paulo', 'SP');
    v_pessoa tp_pessoa;
BEGIN
    -- Initialize the pessoa object with all required parameters
    v_pessoa := tp_pessoa(
        cpf => '12345678901',
        nome => 'João',
        sobrenome => 'Silva',
        email => 'joao.silva@email.com',
        data_de_nascimento => TO_DATE('15/03/1985', 'DD/MM/YYYY'),
        telefone_principal => v_telefone_principal,
        telefones_emergencia => v_telefones_emergencia, -- Passing the empty varray
        endereco => v_endereco
    );
    
    -- Display the information
    v_pessoa.display_info();
END;
/