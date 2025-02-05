DROP TABLE Aeroporto CASCADE CONSTRAINTS;

DROP TABLE Companhia_Aerea CASCADE CONSTRAINTS;

DROP TABLE Funcao_Salario CASCADE CONSTRAINTS;

DROP TABLE Aeronave CASCADE CONSTRAINTS;

DROP TABLE Voo CASCADE CONSTRAINTS;

DROP TABLE Pessoa CASCADE CONSTRAINTS;

DROP TABLE Passaporte CASCADE CONSTRAINTS;

DROP TABLE Passageiro CASCADE CONSTRAINTS;

DROP TABLE Tripulante CASCADE CONSTRAINTS;

DROP TABLE Bagagem CASCADE CONSTRAINTS;

DROP TABLE Acomoda CASCADE CONSTRAINTS;

DROP TABLE Opera CASCADE CONSTRAINTS;

DROP TABLE Reserva CASCADE CONSTRAINTS;

DROP TABLE Voo_Detalhes CASCADE CONSTRAINTS;

DROP TABLE Telefones_Emergencia CASCADE CONSTRAINTS;

DROP TABLE Detalhes_Telefone_Emergencia CASCADE CONSTRAINTS;

DROP TABLE Necessidades_Especiais CASCADE CONSTRAINTS;

DROP TABLE Voa CASCADE CONSTRAINTS;


-- Criando tabelas. 

CREATE TABLE Aeroporto (
    Codigo_Aeroporto NUMBER, 
    Nome VARCHAR2(50),
    Cep CHAR(8),  
    Logradouro VARCHAR2(30),
    Numero NUMBER, 
    Estado VARCHAR2(20),
    Cidade VARCHAR2(20), 
    CONSTRAINT Aeroporto_pkey PRIMARY KEY (Codigo_Aeroporto)
);

CREATE TABLE Companhia_Aerea (
    CNPJ VARCHAR2(14), 
    Razao_social VARCHAR2(50),
    Frota_total_de_aeronaves NUMBER,  
    Quantidade_total_de_funcionarios NUMBER,
    CONSTRAINT Companhia_Aerea_pkey PRIMARY KEY (CNPJ)
);

CREATE TABLE Funcao_Salario(

    id NUMBER, 
	Funcao VARCHAR2(25), 
    Salario NUMBER(13, 3), 
    CONSTRAINT Funcao_Salario_pkey PRIMARY KEY (id)
    
);

CREATE TABLE Aeronave (
    Codigo_Aeronave NUMBER PRIMARY KEY, 
    CNPJ_Companhia_aerea VARCHAR2(14),  
    Modelo VARCHAR2(20), 
    Capacidade NUMBER, 
    Ano_de_fabricacao NUMBER(4),
    CONSTRAINT Aeronave_fkey 
    FOREIGN KEY (CNPJ_Companhia_aerea) REFERENCES Companhia_Aerea(CNPJ)
);


CREATE TABLE Voo(

	Codigo_voo VARCHAR2(15), 
    Categoria VARCHAR2(20) CHECK (Categoria IN ('Internacional', 'Nacional')), 
    Status VARCHAR2(20) CHECK (Status IN ('Agendando', 'Em andamento', 'Concluido', 'Cancelado')),
    CONSTRAINT Voo_pkey 
    PRIMARY KEY (Codigo_voo)
    
);

CREATE TABLE Pessoa(

	CPF VARCHAR2(11), 
    Nome VARCHAR2(30), 
    Sobrenome VARCHAR2(30), 
    Codigo_do_pais VARCHAR2(2), 
    DDD VARCHAR2(2), 
    Numero_de_telefone VARCHAR2(9),
	Email VARCHAR2(30), 
    Data_de_nascimento DATE, 
    Cep VARCHAR2(8), 
    Logradouro VARCHAR2(30), 
    Numero NUMBER, 
    Estado VARCHAR2(20), 
    Cidade VARCHAR2(20), 
    CONSTRAINT CPF_pkey 
    PRIMARY KEY (CPF)
    
);

CREATE TABLE Passaporte(

	Numero_do_passaporte VARCHAR2(10), 
    PaIs_de_emissao VARCHAR2(30),
    CONSTRAINT Passaporte_pkey PRIMARY KEY (Numero_do_passaporte)
    
);

CREATE TABLE Passageiro(

	Cpf_passageiro VARCHAR2(11), 
    Numero_do_passaporte VARCHAR2(10), 
    Pais_de_emissao VARCHAR2(30),
	Data_de_emissao DATE, 
    Data_de_validade DATE, 
    Preferencia_de_assento VARCHAR(20), 
    Nacionalidade VARCHAR(30),
    CONSTRAINT Passageiro_pkey PRIMARY KEY (Cpf_passageiro)
    
);

CREATE TABLE Tripulante (
    CPF_Tripulante VARCHAR2(11), 
    CNPJ_Companhia_aerea VARCHAR2(14), 
    CPF_Supervisor VARCHAR2(11),
    ID_Funcao NUMBER,
    Numero_do_Funcionario NUMBER, 
    Data_de_contratacao DATE, 
    CONSTRAINT Tripulante_pkey PRIMARY KEY (CPF_Tripulante),
    CONSTRAINT Tripulante_fkey1 FOREIGN KEY (CPF_Tripulante) REFERENCES Pessoa(CPF), 
    CONSTRAINT Tripulante_fkey2 FOREIGN KEY (CPF_Supervisor) REFERENCES Tripulante(CPF_Tripulante), 
    CONSTRAINT Tripulante_fkey3 FOREIGN KEY (CNPJ_Companhia_aerea) REFERENCES Companhia_Aerea(CNPJ), 
    CONSTRAINT Tripulante_fkey4 FOREIGN KEY (ID_Funcao) REFERENCES Funcao_Salario(id)
);

CREATE TABLE Bagagem(

	Codigo_voo VARCHAR2(15), 
    CPF_Passageiro VARCHAR2(11), 
    Numero_Bagagem NUMBER, 
    Peso_Bagagem NUMBER,
    CONSTRAINT Bagagem_pkey PRIMARY KEY (Codigo_voo), 
    CONSTRAINT Bagagem_fkey1 FOREIGN KEY (Codigo_voo) REFERENCES Voo(Codigo_Voo),
    CONSTRAINT Bagagem_fkey2 FOREIGN KEY (CPF_Passageiro) REFERENCES Passageiro(CPF_Passageiro)
    
);

CREATE TABLE Acomoda(
    Codigo_Aeroporto NUMBER, 
    CNPJ_Companhia_Aerea VARCHAR2(14), 
    CONSTRAINT Acomoda_pkey PRIMARY KEY (Codigo_Aeroporto, CNPJ_Companhia_Aerea), 
    CONSTRAINT Acomoda_fkey1 FOREIGN KEY (Codigo_Aeroporto) REFERENCES Aeroporto(Codigo_Aeroporto), 
    CONSTRAINT Acomoda_fkey2 FOREIGN KEY (CNPJ_Companhia_Aerea) REFERENCES Companhia_Aerea(CNPJ)
);

CREATE TABLE Opera(
    Codigo_Aeronave NUMBER, 
    CPF_Tripulante VARCHAR2(11), 
    CONSTRAINT Opera_pkey PRIMARY KEY (Codigo_Aeronave, CPF_Tripulante), 
    CONSTRAINT Opera_fkey1 FOREIGN KEY (Codigo_Aeronave) REFERENCES Aeronave(Codigo_Aeronave), 
    CONSTRAINT Opera_fkey2 FOREIGN KEY (CPF_Tripulante) REFERENCES Tripulante(CPF_Tripulante)
);

CREATE TABLE Reserva(
    Codigo_Voo VARCHAR2(15), 
    CPF_Passageiro VARCHAR2(11), 
    Classe VARCHAR2(20), 
    Status VARCHAR2(20) CHECK (Status IN ('Agendando', 'Em andamento', 'Concluido', 'Cancelado')),
    Numero_do_assento NUMBER, 
    CONSTRAINT Reserva_pkey PRIMARY KEY (Codigo_Voo, CPF_Passageiro), 
    CONSTRAINT Reserva_fkey1 FOREIGN KEY (Codigo_Voo) REFERENCES Voo(Codigo_voo),
    CONSTRAINT Reserva_fkey2 FOREIGN KEY (CPF_Passageiro) REFERENCES Passageiro(Cpf_passageiro)
);

CREATE TABLE Voo_Detalhes(
    Codigo_Voo VARCHAR2(15), 
    CPF_Passageiro VARCHAR2(11), 
    Portao_de_embarque VARCHAR2(10), 
    Origem VARCHAR2(30), 
    Destino VARCHAR2(30), 
    CONSTRAINT Voo_Detalhes_pkey PRIMARY KEY (Codigo_Voo, CPF_Passageiro), 
    CONSTRAINT Voo_Detalhes_fkey FOREIGN KEY (Codigo_Voo, CPF_Passageiro) REFERENCES Reserva(Codigo_Voo, CPF_Passageiro)
);

CREATE TABLE Detalhes_Telefone_Emergencia(
    Numero_do_telefone VARCHAR2(9), 
    DDD VARCHAR2(2), 
    Codigo_do_Pais VARCHAR2(2), 
    CONSTRAINT Detalhes_Telefone_Emergencia_pkey PRIMARY KEY (Numero_do_telefone)
);

CREATE TABLE Telefones_Emergencia(
    CPF_Pessoa VARCHAR2(11), 
    Numero_do_telefone VARCHAR2(9), 
    CONSTRAINT Telefones_Emergencia_pkey PRIMARY KEY (CPF_Pessoa, Numero_do_telefone), 
    CONSTRAINT Telefones_Emergencia_fkey1 FOREIGN KEY (CPF_Pessoa) REFERENCES Pessoa(CPF),
    CONSTRAINT Telefones_Emergencia_fkey2 FOREIGN KEY (Numero_do_telefone) REFERENCES Detalhes_Telefone_Emergencia(Numero_do_telefone)
);


CREATE TABLE Necessidades_Especiais(
    CPF_Passageiro VARCHAR2(11), 
    Necessidade_especial VARCHAR2(50), 
    CONSTRAINT Necessidades_Especiais_pkey PRIMARY KEY (CPF_Passageiro, Necessidade_especial), 
    CONSTRAINT Necessidades_Especiais_fkey FOREIGN KEY (CPF_Passageiro) REFERENCES Passageiro(Cpf_passageiro)
);

CREATE TABLE Voa(
    Codigo_Aeronave NUMBER, 
    Codigo_Aeroporto NUMBER, 
    Codigo_Voo VARCHAR2(15), 
    CONSTRAINT Voa_pkey PRIMARY KEY (Codigo_Aeronave, Codigo_Aeroporto, Codigo_Voo), 
    CONSTRAINT Voa_fkey1 FOREIGN KEY (Codigo_Aeronave) REFERENCES Aeronave(Codigo_Aeronave), 
    CONSTRAINT Voa_fkey2 FOREIGN KEY (Codigo_Aeroporto) REFERENCES Aeroporto(Codigo_Aeroporto), 
    CONSTRAINT Voa_fkey3 FOREIGN KEY (Codigo_Voo) REFERENCES Voo(Codigo_voo)
);
