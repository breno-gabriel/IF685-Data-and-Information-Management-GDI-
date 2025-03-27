DECLARE
    v_telefone tp_telefone := tp_telefone('987654321', '011', '55');
    v_endereco tp_endereco := tp_endereco('01234567', 'Rua das Flores', '123', 'São Paulo', 'SP');
    v_pessoa tp_pessoa := tp_pessoa(
        '12345678901',
        'João',
        'Silva',
        'joao.silva@email.com',
        TO_DATE('15/03/1985', 'DD/MM/YYYY'),
        v_telefone,
        v_endereco
    );
BEGIN
    v_pessoa.display_info();
END;
/