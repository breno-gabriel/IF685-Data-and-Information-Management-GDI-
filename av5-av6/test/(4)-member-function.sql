DECLARE
  v_pessoa  tp_pessoa;
  v_nome    tp_nome_completo;
  v_telefones_emergencia tp_telefones_varray := tp_telefones_varray(); -- Empty varray for emergency phones
BEGIN
  -- Initialize the pessoa object with all required parameters
  v_pessoa := tp_pessoa(
    cpf => '12345678901',
    nome => 'João',
    sobrenome => 'Silva',
    email => 'joao.silva@email.com',
    data_de_nascimento => TO_DATE('15/03/1985', 'DD/MM/YYYY'),
    telefone_principal => tp_telefone('987654321', '011', '55'),
    telefones_emergencia => v_telefones_emergencia, -- Now passing the required varray
    endereco => tp_endereco('01234567', 'Rua das Flores', 123, 'São Paulo', 'SP')
  );
  
  -- Get the full name
  v_nome := v_pessoa.obter_nome_completo();
  DBMS_OUTPUT.PUT_LINE('Nome completo: ' || v_nome.nome || ' ' || v_nome.sobrenome);
  
  -- Display all information
  v_pessoa.display_info();
END;
/