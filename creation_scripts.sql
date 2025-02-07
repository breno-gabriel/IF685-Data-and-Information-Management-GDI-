DROP TABLE Acomoda CASCADE CONSTRAINTS;
DROP TABLE Voa CASCADE CONSTRAINTS;
DROP TABLE Necessidades_Especiais CASCADE CONSTRAINTS;
DROP TABLE Telefones_Emergencia CASCADE CONSTRAINTS;
DROP TABLE Voo_Detalhes CASCADE CONSTRAINTS;
DROP TABLE Opera CASCADE CONSTRAINTS;
DROP TABLE Reserva CASCADE CONSTRAINTS;
DROP TABLE Bagagem CASCADE CONSTRAINTS;
DROP TABLE Tripulante CASCADE CONSTRAINTS;
DROP TABLE Passageiro CASCADE CONSTRAINTS;
DROP TABLE Pessoa CASCADE CONSTRAINTS;
DROP TABLE Aeronave CASCADE CONSTRAINTS;
DROP TABLE Aeroporto CASCADE CONSTRAINTS;
DROP TABLE Passaporte CASCADE CONSTRAINTS;
DROP TABLE Detalhes_Telefone CASCADE CONSTRAINTS;
DROP TABLE Voo CASCADE CONSTRAINTS;
DROP TABLE Funcao_Salario CASCADE CONSTRAINTS;
DROP TABLE Companhia_Aerea CASCADE CONSTRAINTS;
DROP TABLE Endereco CASCADE CONSTRAINTS;


-- Criando tabelas.
-- populado
CREATE TABLE Endereco(
    CEP VARCHAR2(8) NOT NULL,
    Logradouro VARCHAR2(30) NOT NULL,
    Numero NUMBER,
    Cidade VARCHAR2(20) NOT NULL,
    Estado VARCHAR2(20) NOT NULL,
    CONSTRAINT CEP_pkey PRIMARY KEY (CEP)
);

--populado
CREATE TABLE Companhia_Aerea(
    CNPJ VARCHAR2(14) NOT NULL,
    Razao_social VARCHAR2(50) NOT NULL,
    Frota_total_de_aeronaves NUMBER NOT NULL,
    Quantidade_total_de_funcionarios NUMBER NOT NULL,
    CONSTRAINT Companhia_Aerea_pkey PRIMARY KEY (CNPJ)
);

-- populado
CREATE TABLE Funcao_Salario(
    id NUMBER NOT NULL,
    Funcao VARCHAR2(30) NOT NULL,
    Salario NUMBER(13, 3) NOT NULL,
    CONSTRAINT Funcao_Salario_pkey PRIMARY KEY (id),
    CONSTRAINT Funcao_salario_check CHECK (Salario >= 1518)
);

--populado
CREATE TABLE Voo(
    Codigo_voo NUMBER NOT NULL,
    Categoria VARCHAR2(20) NOT NULL,
    Status_voo VARCHAR2(20) NOT NULL,
    CONSTRAINT Voo_pkey PRIMARY KEY (Codigo_voo),
    CONSTRAINT Categoria_check 
        CHECK (Categoria IN ('Internacional', 'Nacional')),
    CONSTRAINT Status_voo_check 
        CHECK (Status_voo IN ('Agendando', 'Em andamento', 'Concluido', 'Cancelado'))
);

--populado
CREATE TABLE Detalhes_Telefone(
    Numero_de_telefone VARCHAR2(9) NOT NULL,
    DDD VARCHAR2(3) NOT NULL,
    Codigo_do_pais VARCHAR2(2) NOT NULL,
    CONSTRAINT Numero_de_telefone_pkey PRIMARY KEY (Numero_de_telefone)
);
-- populado
CREATE TABLE Passaporte(
	Numero_do_passaporte VARCHAR2(10) NOT NULL,
    Pais_de_emissao VARCHAR2(30) NOT NULL,
    Data_de_emissao DATE NOT NULL,
    Data_de_validade DATE NOT NULL,
    CONSTRAINT Passaporte_pkey PRIMARY KEY (Numero_do_passaporte)
);
--populado
CREATE TABLE Aeroporto(
    Codigo_Aeroporto NUMBER,
    Nome VARCHAR2(50) NOT NULL,
    Cep VARCHAR2(8) NOT NULL,
    CONSTRAINT Aeroporto_pkey PRIMARY KEY (Codigo_Aeroporto),
    CONSTRAINT Cep_fkey1 FOREIGN KEY (CEP) 
        REFERENCES Endereco(CEP) ON DELETE CASCADE
);
--populado
CREATE TABLE Aeronave(
    Codigo_Aeronave NUMBER NOT NULL,
    CNPJ_Companhia_aerea VARCHAR2(14) NOT NULL,
    Modelo VARCHAR2(20) NOT NULL,
    Capacidade NUMBER NOT NULL,
    Ano_de_fabricacao NUMBER(4) NOT NULL,
    CONSTRAINT Codigo_Aeronave_pkey PRIMARY KEY (Codigo_Aeronave),
    CONSTRAINT Aeronave_fkey FOREIGN KEY (CNPJ_Companhia_aerea) 
        REFERENCES Companhia_Aerea(CNPJ) ON DELETE CASCADE
);
-- populado
CREATE TABLE Pessoa(
	CPF VARCHAR2(11) NOT NULL,
    Nome VARCHAR2(30) NOT NULL,
    Sobrenome VARCHAR2(30) NOT NULL,
	Email VARCHAR2(30) NOT NULL,
    Data_de_nascimento DATE NOT NULL,
    Numero_de_telefone VARCHAR2(9),
    CEP VARCHAR2(8) NOT NULL,
    CONSTRAINT CPF_pkey PRIMARY KEY (CPF),
    CONSTRAINT Numero_fkey FOREIGN KEY (Numero_de_telefone) 
        REFERENCES Detalhes_Telefone(Numero_de_telefone) ON DELETE CASCADE,
    CONSTRAINT Cep_fkey2 FOREIGN KEY (CEP) 
        REFERENCES Endereco(CEP) ON DELETE CASCADE
);

--populado
CREATE TABLE Passageiro(
	Cpf_passageiro VARCHAR2(11) NOT NULL,
    Numero_do_passaporte VARCHAR2(10) NOT NULL,
    Pais_de_emissao VARCHAR2(30) NOT NULL,
    Preferencia_de_assento VARCHAR(20) NOT NULL,
    Nacionalidade VARCHAR(30) NOT NULL,
    CONSTRAINT Passageiro_pkey PRIMARY KEY (Cpf_passageiro),
    CONSTRAINT Numero_do_passaporte_fkey FOREIGN KEY (Numero_do_passaporte)
        REFERENCES Passaporte(Numero_do_passaporte) ON DELETE CASCADE,
    CONSTRAINT Cpf_passageiro_fkey2 FOREIGN KEY (Cpf_passageiro)
        REFERENCES Pessoa(CPF) ON DELETE CASCADE,
    CONSTRAINT Passageiro_check 
        CHECK (Preferencia_de_assento IN ('Janela', 'Meio', 'Corredor'))
);
-- populado
CREATE TABLE Tripulante(
    CPF_Tripulante VARCHAR2(11),
    CNPJ_Companhia_aerea VARCHAR2(14),
    CPF_Supervisor VARCHAR2(11),
    ID_Funcao NUMBER,
    Numero_do_Funcionario NUMBER,
    Data_de_contratacao DATE NOT NULL,
    CONSTRAINT Tripulante_pkey PRIMARY KEY (CPF_Tripulante),
    CONSTRAINT Tripulante_fkey1 FOREIGN KEY (CPF_Tripulante)
        REFERENCES Pessoa(CPF) ON DELETE CASCADE,
    CONSTRAINT Tripulante_fkey2 FOREIGN KEY (CPF_Supervisor)
        REFERENCES Tripulante(CPF_Tripulante) ON DELETE CASCADE,
    CONSTRAINT Tripulante_fkey3 FOREIGN KEY (CNPJ_Companhia_aerea)
        REFERENCES Companhia_Aerea(CNPJ) ON DELETE CASCADE,
    CONSTRAINT Tripulante_fkey4 FOREIGN KEY (ID_Funcao)
        REFERENCES Funcao_Salario(id) ON DELETE CASCADE
);

-- populado
CREATE TABLE Bagagem(
	Codigo_voo NUMBER,
    CPF_Passageiro VARCHAR2(11),
    Numero_Bagagem NUMBER,
    Peso_Bagagem NUMBER,
    CONSTRAINT Bagagem_pkey PRIMARY KEY (Codigo_voo, Cpf_passageiro, Numero_Bagagem),
    CONSTRAINT Bagagem_fkey1 FOREIGN KEY (Codigo_voo) 
        REFERENCES Voo(Codigo_Voo) ON DELETE CASCADE,
    CONSTRAINT Bagagem_fkey2 FOREIGN KEY (CPF_Passageiro) 
        REFERENCES Passageiro(CPF_Passageiro) ON DELETE CASCADE
);

-- populado
CREATE TABLE Reserva(
    Codigo_Voo NUMBER NOT NULL,
    CPF_Passageiro VARCHAR2(11) NOT NULL,
    Classe VARCHAR2(20) NOT NULL,
    Numero_do_assento NUMBER NOT NULL,
    CONSTRAINT Reserva_pkey PRIMARY KEY (Codigo_Voo, CPF_Passageiro),
    CONSTRAINT Reserva_fkey1 FOREIGN KEY (Codigo_Voo) 
        REFERENCES Voo(Codigo_voo) ON DELETE CASCADE,
    CONSTRAINT Reserva_fkey2 FOREIGN KEY (CPF_Passageiro) 
        REFERENCES Passageiro(Cpf_passageiro) ON DELETE CASCADE,
    CONSTRAINT Reserva_check CHECK (Classe IN ('Primeira', 'Segunda', 'Terceira'))
);

-- opera
CREATE TABLE Opera(
    Codigo_Aeronave NUMBER NOT NULL,
    CPF_Tripulante VARCHAR2(11) NOT NULL,
    CONSTRAINT Opera_pkey PRIMARY KEY (Codigo_Aeronave, CPF_Tripulante),
    CONSTRAINT Opera_fkey1 FOREIGN KEY (Codigo_Aeronave) 
        REFERENCES Aeronave(Codigo_Aeronave) ON DELETE CASCADE,
    CONSTRAINT Opera_fkey2 FOREIGN KEY (CPF_Tripulante) 
        REFERENCES Tripulante(CPF_Tripulante) ON DELETE CASCADE
);


CREATE TABLE Voo_Detalhes(
    Codigo_Voo NUMBER NOT NULL,
    CPF_Passageiro VARCHAR2(11) NOT NULL,
    Portao_de_Embarque VARCHAR2(2) NOT NULL,
    Origem NUMBER NOT NULL,
    Destino NUMBER NOT NULL,
    Data_decolagem DATE NOT NULL,
    Data_aterrissagem DATE NOT NULL,
    CONSTRAINT Voo_Detalhes_pkey PRIMARY KEY (Codigo_Voo, CPF_Passageiro),
    CONSTRAINT Voo_Detalhes_fkey1 FOREIGN KEY (Codigo_Voo, CPF_Passageiro)
        REFERENCES Reserva(Codigo_Voo, CPF_Passageiro) ON DELETE CASCADE,
    CONSTRAINT Voo_Detalhes_fkey2 FOREIGN KEY (Origem)
        REFERENCES Aeroporto(Codigo_aeroporto) ON DELETE CASCADE,
    CONSTRAINT Voo_Detalhes_fkey3 FOREIGN KEY (Destino)
        REFERENCES Aeroporto(Codigo_aeroporto) ON DELETE CASCADE
);

-- populado
CREATE TABLE Telefones_Emergencia(
    CPF_Pessoa VARCHAR2(11) NOT NULL,
    Numero_de_telefone VARCHAR2(9) NOT NULL,
    CONSTRAINT Telefones_Emergencia_pkey PRIMARY KEY (CPF_Pessoa, Numero_de_telefone),
    CONSTRAINT Telefones_Emergencia_fkey1 FOREIGN KEY (CPF_Pessoa)
        REFERENCES Pessoa(CPF) ON DELETE CASCADE,
    CONSTRAINT Telefones_Emergencia_fkey2 FOREIGN KEY (Numero_de_telefone)
        REFERENCES Detalhes_Telefone(Numero_de_telefone) ON DELETE CASCADE
);


-- populado
CREATE TABLE Necessidades_Especiais(
    CPF_Passageiro VARCHAR2(11) NOT NULL,
    Necessidade_Especial VARCHAR2(100) NOT NULL,
    CONSTRAINT Necessidades_Especiais_pkey PRIMARY KEY (CPF_Passageiro, Necessidade_Especial),
    CONSTRAINT Necessidades_Especiais_fkey FOREIGN KEY (CPF_Passageiro)
        REFERENCES Passageiro(CPF_Passageiro) ON DELETE CASCADE
);

--populado
CREATE TABLE Voa(
    Codigo_Aeronave NUMBER NOT NULL,
    Codigo_Aeroporto NUMBER NOT NULL,
    Codigo_Voo NUMBER NOT NULL,
    CONSTRAINT Voa_pkey PRIMARY KEY (Codigo_Aeronave, Codigo_Aeroporto, Codigo_Voo),
    CONSTRAINT Voa_fkey1 FOREIGN KEY (Codigo_Aeronave) 
        REFERENCES Aeronave(Codigo_Aeronave) ON DELETE CASCADE,
    CONSTRAINT Voa_fkey2 FOREIGN KEY (Codigo_Aeroporto) 
        REFERENCES Aeroporto(Codigo_Aeroporto) ON DELETE CASCADE,
    CONSTRAINT Voa_fkey3 FOREIGN KEY (Codigo_Voo) 
        REFERENCES Voo(Codigo_Voo) ON DELETE CASCADE
);

--populado
CREATE TABLE Acomoda(
    Codigo_Aeroporto NUMBER NOT NULL,
    CNPJ_Companhia_aerea VARCHAR2 (14),
    CONSTRAINT Acomoda_pkey PRIMARY KEY (Codigo_Aeroporto, CNPJ_Companhia_aerea),
    CONSTRAINT Codigo_Aeroporto_fkey1 FOREIGN KEY (Codigo_Aeroporto) 
        REFERENCES Aeroporto(Codigo_Aeroporto) ON DELETE CASCADE,
    CONSTRAINT CNPJ_Companhia_aerea_fkey2 FOREIGN KEY (CNPJ_Companhia_aerea) 
        REFERENCES Companhia_Aerea(CNPJ) ON DELETE CASCADE
);