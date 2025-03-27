DECLARE
  v_pessoa  tp_pessoa := tp_pessoa(
    '12345678901',
    'João',
    'Silva',
    'joao.silva@email.com',
    TO_DATE('15/03/1985', 'DD/MM/YYYY'),
    tp_telefone('987654321', '011', '55'),
    tp_endereco('01234567', 'Rua das Flores', '123', 'São Paulo', 'SP')
  );
  v_nome    tp_nome_completo;
BEGIN
  v_nome := v_pessoa.obter_nome_completo();
  DBMS_OUTPUT.PUT_LINE('Nome completo: ' || v_nome.nome || ' ' || v_nome.sobrenome);
END;
/