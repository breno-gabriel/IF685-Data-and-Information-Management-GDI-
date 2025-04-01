use('hiring_db');

db.createCollection('empresas');
db.createCollection('vagas');
db.createCollection('processos_seletivos');
db.createCollection('candidatos');

// Inserindo algumas empresas. 

db.empresas.insertMany([

    {

        "_id" : 1, 
        "CNPJ": "12345678000101", 
        "Razão Social": "Viitra inovações", 
        "descrição": "Transformando desafios complexos em soluções inovadoras, promovendo avanços significativos em Educação, Inteligência Artificial e Ciência de Dados.",
        "endereço": {

            "rua": "Rua Ceráima",
            "bairro": "Bongi", 
            "cidade":"Recife", 
            "estado": 'pernambuco', 
            'uf': 'PE', 
            "cep": "50751500"

        }, 
        "setor": "tecnologia"

    }, 

    {

        "_id" : 2, 
        "CNPJ": "94356782000140", 
        "Razão Social": "Neurotech", 
        "descrição": "Uma marca do grupo B3, 100% brasileira, pioneira na criação de soluções avançadas de Inteligência Artificial, Machine Learning e Big Data. Nossa missão é transformar um mundo de informações confiáveis e relevantes para que nossos clientes obtenham resultados incrementais expressivos, prevendo novas oportunidades de negócios.",
        "endereço": {

            "rua": "Travessa do Normando",
            "bairro": "Pina", 
            "cidade":"Recife", 
            "estado": 'Pernambuco', 
            'uf': 'PE', 
            "cep": "51011635"

        }, 
        "setor": "tecnologia"

    }, 

    {

        "_id" : 3, 
        "CNPJ": "87078056000147", 
        "Razão Social": "Tracking trade", 
        "descrição": "Proporcionamos produtividade e eficiência nos negócios de nossos clientes",
        "endereço": {

            "rua": "Rua Oscar Luiz de Souza",
            "bairro": "Jardim Rosa", 
            "cidade":"Francisco Morato", 
            "estado": 'São Paulo', 
            'uf': 'SP', 
            "cep": "07991160"

        }, 
        "setor": "tecnologia"

    }, 

    {

        "_id" : 4, 
        "CNPJ": "77023558000117", 
        "Razão Social": "Avanade", 
        "descrição": "Quando os resultados são importantes, as pessoas falam com a Avanade. Há mais de 25 anos que ajudamos clientes de todos os setores a atingir o seu potencial máximo, desbloqueando o poder da Microsoft.",
        "endereço": {

            "rua": "Avenida central",
            "bairro": "Areias", 
            "cidade":"Recife", 
            "estado": 'Pernanbuco', 
            'uf': 'PE', 
            "cep": "50781510"

        }, 
        "setor": "tecnologia"

    }, 

    {

        "_id" : 5, 
        "CNPJ": "18907824000105", 
        "Razão Social": "Visagio", 
        "descrição": "A Visagio é uma plataforma de transformação e desenvolvimento de negócios que permite que gente boa e do bem realize feitos grandiosos",
        "endereço": {

            "rua": "Rua Subida do Curupá",
            "bairro": "Nova Descoberta", 
            "cidade":"Recife", 
            "estado": 'Pernanbuco', 
            'uf': 'PE', 
            "cep": "52190275"

        },
        "setor": "tecnologia"

    }, 

    {

        "_id" : 6, 
        "CNPJ": "36402535000136", 
        "Razão Social": "dippolum consultoria", 
        "descrição": "Empresa Júnior da UFPE Sinônimo de tecnologia transformando realidades Soluções em automação, IoT, impressão 3D e prototipação",
        "endereço": {

            "rua": "2ª Travessa Córrego do Abdias",
            "bairro": "Linha do Tiro", 
            "cidade":"Recife", 
            "estado": 'Pernanbuco', 
            'uf': 'PE', 
            "cep": "52131241"

        }, 
        "setor": "consultoria"

    }, 

    {

        "_id" : 7, 
        "CNPJ": "77830477000129", 
        "Razão Social": "Mauriceia Alimentos", 
        "descrição": "Nascemos em 1988, mas nossa história começou anos antes, numa pequena criação de aves em Nazaré da Mata, Pernambuco. Cada experiência, conhecimento e aptidão adquiridos nos levaram à busca por um espaço maior. E, em pouco tempo, tivemos que expandir para uma fábrica em Carpina, onde construímos uma fábrica de rações, granja de matrizes, incubatório e abatedouro. De lá pra cá, não paramos de crescer. Hoje, temos agroindústrias de larga produção em Pernambuco, Paraíba e Bahia.",
        "endereço": {

            "rua": "Rua Bernardo Vieira de Melo 19",
            "bairro": "Centro", 
            "cidade":"Nazaré da Mata", 
            "estado": '`Pernanbuco`', 
            'uf': 'PE', 
            "cep": "55800970"

        }, 
        "setor": "alimenticio"

    }, 

    {

        "_id" : 8, 
        "CNPJ": "86346320000113", 
        "Razão Social": "Alpargatas", 
        "descrição": "We are a global company, founded and based in Brazil for over 115 years. We are committed to delight the world with amazing brands, that convey lightness and joy to the everyday lives of our consumers. We own Havaianas brand, world leader in open shoes, known for the iconic flip-flops that represent Brazilianness, comfort and style. We have 49.2% of Rothy’s a north-american sustainable footwear Brand.",
        "endereço": {

            "rua": "Rua Deputado João Teobaldo de Azevedo",
            "bairro": "São Sebastião", 
            "cidade":"Carpina", 
            "estado": '`Pernanbuco`', 
            'uf': 'PE', 
            "cep": "55818520"

        }, 
        "setor": "calçados e têxtil"

    }, 

    {

        "_id" : 9, 
        "CNPJ": "28935720000168", 
        "Razão Social": "Bradesco", 
        "descrição": "Valorizamos muito o que temos de “humano”. Nossa trajetória só obteve tanto sucesso ao longo destes mais de 80 anos graças às pessoas que construíram e constroem, dia após dia, o trabalho do Bradesco. Isso é vir em primeiro.",
        "endereço": {

            "rua": "Rua João Antonio Tavares",
            "bairro": "Santo Antônio", 
            "cidade":"Carpina", 
            "estado": '`Pernanbuco`', 
            'uf': 'PE', 
            "cep": "55816355"

        }, 
        "setor": "financeiro"

    }, 

    {

        "_id" : 10, 
        "CNPJ": "87314842000104", 
        "Razão Social": "Confeitaria Colombo", 
        "descrição": "Café centenário decorado com fabulosos espelhos, renomado por suas iguarias e doces confeitados.",
        "endereço": {

            "rua": "Rua João Moraes",
            "bairro": "Paciência", 
            "cidade":"Rio de Janeiro", 
            "estado": '`Rio de Janeiro`', 
            'uf': 'RJ', 
            "cep": "23587620"

        }, 
        "setor": "alimenticio"

    }

])

// Inserindo alguns candidatos. 

db.candidatos.insertMany([

    {
        "_id": 1, 
        "nome": "Breno Gabriel de Melo Lima", 
        "email": "bgml@cin.ufpe.br", 
        "telefone": "81 9 16349746", 
        "curriculo": "Curriculo Breno Gabriel de Melo Lima.pdf", 
        "habilidades": ["React", "NestJs", "Typescript", "SQL", "MongoDB", "Proatividade", "boa comunicação"], 
        "experiência": [{

            "empresa": "Google", 
            "cargo": "Engenheiro de Software Sênior", 
            "inicio": "2022-06-01",
            "fim": "2025-02-19"

        }, 
        
        {

            "empresa": "Rei do Pitaco", 
            "cargo": "Engenheiro de Software Pleno", 
            "inicio": "2022-01-01",
            "fim": "2023-06-01"

        }
    
        ], 
        "formação": [

            {
                "instituição": "Universidade Federal de Pernambuco", 
                "curso": "Ciência da Computação", 
                "tipo": "Mestrado",
                "data de conclusão": "2027-06-20"
            },

            {
                "instituição": "Universidade Federal de Pernambuco", 
                "curso": "Ciência da Computação", 
                "tipo": "Bacharelado",
                "data de conclusão": "2025-06-20"
            }

        ], 
        "processos seletivos": []

    }, 

    {
        "_id": 2, 
        "nome": "Lucas Henrique do Nascimento", 
        "email": "lhns3@cin.ufpe.br", 
        "telefone": "81 9 19470912", 
        "curriculo": "Curriculo Lucas Henrique do Nascimento.pdf", 
        "habilidades": ["LangChain", "LLM", "Python", "SQL", "MongoDB", "Proatividade", "boa comunicação", "Ai Agents"], 
        "experiência": [{

            "empresa": "Google", 
            "cargo": "Engenheiro de IA Sênior", 
            "inicio": "2025-01-01",
            "fim": "2023-06-01"

        }, 
        
        {

            "empresa": "Neurotech", 
            "cargo": "Pesquisador de Inteligência Artificial", 
            "inicio": "2023-06-01",
            "fim": "2021-03-10"

        }, 

        {

            "empresa": "Sidi", 
            "cargo": "Cientista de dados", 
            "inicio": "2021-03-10",
            "fim": "2018-03-28"

        }
    
        ], 
        "formação": [

            {
                "instituição": "Universidade Federal de Pernambuco", 
                "curso": "Ciência da Computação", 
                "tipo": "Bacharelado",
                "data de conclusão": "2027-06-20"
            }

        ], 
        "processos seletivos": []

    }, 

    {
        "_id": 3, 
        "nome": "Pedro Baptista Santos Melo", 
        "email": "pbsm@cin.ufpe.br", 
        "telefone": "81 9 59101558", 
        "curriculo": "Curriculo Pedro Baptista Santos Melo.pdf", 
        "habilidades": ["React", "Next", "Typescript", "Tailwind", "ShadCn", "Proatividade", "boa comunicação", "Pensamento fora da caixa"], 
        "experiência": [{

            "empresa": "Loomi", 
            "cargo": "Engenheiro de frontend", 
            "inicio": "2023-01-01",
            "fim": "2024-06-01"

        }, 
        
        {

            "empresa": "Tracking Tread", 
            "cargo": "Desenvolvedor de frontend", 
            "inicio": "2019-05-12",
            "fim": "2023-01-01"

        }
    
        ], 
        "formação": [

            {
                "instituição": "Universidade Federal de Pernambuco", 
                "curso": "Ciência da Computação", 
                "tipo": "Bacharelado",
                "data de conclusão": "2027-06-20"
            }

        ], 
        "processos seletivos": []

    }, 

    {
        "_id": 4, 
        "nome": "Gabriel Oliveira Santos", 
        "email": "gabrielSantos2022@gmail.com", 
        "telefone": "81 9 01294448", 
        "curriculo": "Curriculo Gabriel Oliveira Santos.pdf", 
        "habilidades": [

            "Desenvolvimento de novos produtos",
            "Controle de qualidade",
            "Segurança alimentar",
            "Microbiologia de alimentos",
            "Gestão de processos industriais",
            "Tecnologia de alimentos"

          ], 
        "experiência": [{

            "empresa": "Vitarella", 
            "cargo": "Engenheiro de alimentos", 
            "inicio": "2021-04-11",
            "fim": "2022-08-25"

        }
    
        ], 
        "formação": [

            {
                "instituição": "Universidade de Pernambuco", 
                "curso": "Engenheria de alimentos", 
                "tipo": "Bacharelado",
                "data de conclusão": "2019-12-01"
            }

        ], 
        "processos seletivos": []

    }, 

    {
        "_id": 5, 
        "nome": "Mariana Ferreira Rocha", 
        "email": "mariana.rocha@email.com", 
        "telefone": "81 9 11025656", 
        "curriculo": "Curriculo Mariana Ferreira Rocha.pdf", 
        "habilidades": [

            "Desenvolvimento de novos produtos",
            "Controle de qualidade",
            "Segurança alimentar",
            "Microbiologia de alimentos",
            "Gestão de processos industriais",
            "Tecnologia de alimentos"

          ], 
        "experiência": [{

            "empresa": "Essen Delicatessen", 
            "cargo": "chefe de cozinha", 
            "inicio": "2021-04-11",
            "fim": "2015-02-25"

        }
    
        ], 
        "formação": [

            {
                "instituição": "Instituo Ana Maria Braga", 
                "curso": "Tecnolgia em Gastrônomia", 
                "tipo": "Tecnólogo",
                "data de conclusão": "2014-06-12"
            }

        ], 
        "processos seletivos": []

    }, 

    {
        "_id": 6, 
        "nome": "Pedro Henrique Lima Barbosa", 
        "email": "pedro.lima@email.com", 
        "telefone": "81 9 12309487", 
        "curriculo": "Curriculo Pedro Henrique Lima Barbosa.pdf", 
        "habilidades": [

            "Diagnóstico e tratamento de doenças animais",
            "Cirurgia veterinária",
            "Atendimento clínico e emergencial",
            "Medicina preventiva e vacinação",
            "Manejo e bem-estar animal",
            "Interpretação de exames laboratoriais"

          ], 
        "experiência": [{

            "empresa": "Perdigão", 
            "cargo": "Médico Veterinário", 
            "inicio": "2021-04-11",
            "fim": "2015-02-25"

        }
    
        ], 
        "formação": [

            {
                "instituição": "Universidade Federal Rural de Pernambuco", 
                "curso": "Medicina Veterinária", 
                "tipo": "Bacharelado",
                "data de conclusão": "2010-12-01"
            }

        ], 
        "processos seletivos": []

    }, 

    {
        "_id": 7, 
        "nome": "Ana Beatriz Carvalho Dias", 
        "email": "ana.carvalho@email.com", 
        "telefone": "81 9 135790864", 
        "curriculo": "Curriculo Ana Beatriz Carvalho Dias.pdf", 
        "habilidades": [

            "Atendimento ao cliente",
            "Agilidade e organização",
            "Conhecimento do cardápio e sugestões de pratos",
            "Habilidade em anotar e entregar pedidos corretamente",
            "Trabalho em equipe",
            "Boas práticas de higiene e manipulação de alimentos"

          ], 
        "experiência": [{

            "empresa": "Panela cheia", 
            "cargo": "Garçonete", 
            "inicio": "2024-02-11",
            "fim": "2022-07-25"

        }
    
        ], 
        "formação": [

            {
                "instituição": "Escola Tecnica Estadual Maria Ramos de Barros", 
                "curso": "Técnico em Admnistração", 
                "tipo": "Curso técnico",
                "data de conclusão": "2023-12-01"
            }

        ], 
        "processos seletivos": []

    }, 

    {
        "_id": 8, 
        "nome": "Lucas Gabriel Martins Pinto", 
        "email": "lucas.martins@email.com", 
        "telefone": "81 9 12345678", 
        "curriculo": "Curriculo Lucas Gabriel Martins Pinto.pdf", 
        "habilidades": [

            "Atendimento e suporte ao cliente",
            "Resolução de problemas técnicos",
            "Conhecimento em hardware e software",
            "Instalação e configuração de sistemas",
            "Habilidade em troubleshooting",
            "Comunicação clara e didática"

          ], 
        "experiência": [{

            "empresa": "Planalto Net", 
            "cargo": "Técnico de TI", 
            "inicio": "2023-04-14",
            "fim": "2024-11-22"

        }
    
        ], 
        "formação": [

            {
                "instituição": "Escola Tecnica Estadual Maria Ramos de Barros", 
                "curso": "Técnico em Redes de computadores", 
                "tipo": "Curso técnico",
                "data de conclusão": "2023-12-01"
            }

        ], 
        "processos seletivos": []

    }, 

    {
        "_id": 9, 
        "nome": "Camila Oliveira Nunes", 
        "email": "camila.oliveira@email.com", 
        "telefone": "81 9 10293847", 
        "curriculo": "Curriculo Camila Oliveira Nunes.pdf", 
        "habilidades": [

            "Domínio de softwares de design (Photoshop, Illustrator, Figma)",
            "Criação de identidades visuais",
            "UX/UI Design",
            "Tipografia e teoria das cores",
            "Edição de imagens e ilustração",
            "Criatividade e pensamento visual"

          ], 
        "experiência": [{

            "empresa": "Planalto Net", 
            "cargo": "Técnico de TI", 
            "inicio": "2023-04-14",
            "fim": "2024-11-22"

        }
    
        ], 
        "formação": [

            {
                "instituição": "Universidade Federal de Alagoas", 
                "curso": "Design", 
                "tipo": "Bacharelado",
                "data de conclusão": "2028-07-01"
            }

        ], 
        "processos seletivos": []

    }, 

    {
        "_id": 10, 
        "nome": "Thiago Souza Ribeiro", 
        "email": "thiago.souza@email.com", 
        "telefone": "81 9 24680011", 
        "curriculo": "Curriculo Thiago Souza Ribeiro.pdf", 
        "habilidades": [

            "Desenvolvimento front-end (HTML, CSS, JavaScript, React)",
            "Desenvolvimento back-end (Node.js, NestJS, FastAPI, Java, Python)",
            "Bancos de dados relacionais e NoSQL (MySQL, PostgreSQL, MongoDB)",
            "Consumo e criação de APIs REST e GraphQL",
            "Versionamento de código com Git e GitHub",
            "Arquitetura de software e boas práticas de desenvolvimento"

          ], 
        "experiência": [{

            "empresa": "Viitra inovações", 
            "cargo": "Desenvolvedor fullstack", 
            "inicio": "2023-04-14",
            "fim": "2024-11-22"

        }
    
        ], 
        "formação": [

            {
                "instituição": "Universidade de Pernambuco", 
                "curso": "Sistema de informação", 
                "tipo": "Bacharelado",
                "data de conclusão": "2028-07-01"
            }

        ], 
        "processos seletivos": []

    }

])