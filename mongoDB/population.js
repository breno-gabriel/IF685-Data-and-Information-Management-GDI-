use('hiring_db');

db.createCollection('empresas');
db.createCollection('vagas');
db.createCollection('processos_seletivos');
db.createCollection('candidatos');

db.empresas.insertMany(

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

        }

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
            "estado": 'pernambuco', 
            'uf': 'PE', 
            "cep": "51011635"

        }

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

        }

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
            "estado": 'Recife', 
            'uf': 'PE', 
            "cep": "50781510"

        }

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
            "estado": 'Recife', 
            'uf': 'PE', 
            "cep": "52190275"

        }

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
            "estado": 'Recife', 
            'uf': 'PE', 
            "cep": "52131241"

        }

    }

)