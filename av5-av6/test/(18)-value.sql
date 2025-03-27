DECLARE
    tripulante tp_tripulante;
BEGIN
    SELECT VALUE(C) INTO tripulante FROM tb_tripulantes C WHERE C.cpf = '22233344455';
    tripulante.display_info();
END;
/
