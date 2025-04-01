db.collection("candidatos").drop();

db.collection("candidatos").insertMany([
  {
    _id: 1,
    nome: "Breno Gabriel de Melo Lima",
    email: "bgml@cin.ufpe.br",
    telefone: "81 9 16349746",
    curriculo: "Curriculo Breno Gabriel de Melo Lima.pdf",
    habilidades: [
      "React",
      "NestJs",
      "Typescript",
      "SQL",
      "MongoDB",
      "Proatividade",
      "boa comunicação",
    ],
    experiência: [
      {
        empresa: "Google",
        cargo: "Engenheiro de Software Sênior",
        inicio: "2022-06-01",
        fim: "2025-02-19",
      },

      {
        empresa: "Rei do Pitaco",
        cargo: "Engenheiro de Software Pleno",
        inicio: "2022-01-01",
        fim: "2023-06-01",
      },
    ],
    formação: [
      {
        instituição: "Universidade Federal de Pernambuco",
        curso: "Ciência da Computação",
        tipo: "Mestrado",
        "data de conclusão": "2027-06-20",
      },

      {
        instituição: "Universidade Federal de Pernambuco",
        curso: "Ciência da Computação",
        tipo: "Bacharelado",
        "data de conclusão": "2025-06-20",
      },
    ],
    categoria: "Tecnologia",
  },

  {
    _id: 2,
    nome: "Lucas Henrique do Nascimento",
    email: "lhns3@cin.ufpe.br",
    telefone: "81 9 19470912",
    curriculo: "Curriculo Lucas Henrique do Nascimento.pdf",
    habilidades: [
      "LangChain",
      "LLM",
      "Python",
      "SQL",
      "MongoDB",
      "Proatividade",
      "boa comunicação",
      "Ai Agents",
    ],
    experiência: [
      {
        empresa: "Google",
        cargo: "Engenheiro de IA Sênior",
        inicio: "2025-01-01",
        fim: "2023-06-01",
      },

      {
        empresa: "Neurotech",
        cargo: "Pesquisador de Inteligência Artificial",
        inicio: "2023-06-01",
        fim: "2021-03-10",
      },

      {
        empresa: "Sidi",
        cargo: "Cientista de dados",
        inicio: "2021-03-10",
        fim: "2018-03-28",
      },
    ],
    formação: [
      {
        instituição: "Universidade Federal de Pernambuco",
        curso: "Ciência da Computação",
        tipo: "Bacharelado",
        "data de conclusão": "2027-06-20",
      },
    ],
    categoria: "Tecnologia",
  },

  {
    _id: 3,
    nome: "Pedro Baptista Santos Melo",
    email: "pbsm@cin.ufpe.br",
    telefone: "81 9 59101558",
    curriculo: "Curriculo Pedro Baptista Santos Melo.pdf",
    habilidades: [
      "React",
      "Next",
      "Typescript",
      "Tailwind",
      "ShadCn",
      "Proatividade",
      "boa comunicação",
      "Pensamento fora da caixa",
    ],
    experiência: [
      {
        empresa: "Loomi",
        cargo: "Engenheiro de frontend",
        inicio: "2023-01-01",
        fim: "2024-06-01",
      },

      {
        empresa: "Tracking Tread",
        cargo: "Desenvolvedor de frontend",
        inicio: "2019-05-12",
        fim: "2023-01-01",
      },
    ],
    formação: [
      {
        instituição: "Universidade Federal de Pernambuco",
        curso: "Ciência da Computação",
        tipo: "Bacharelado",
        "data de conclusão": "2027-06-20",
      },
    ],
    categoria: "Tecnologia",
  },

  {
    _id: 4,
    nome: "Gabriel Oliveira Santos",
    email: "gabrielSantos2022@gmail.com",
    telefone: "81 9 01294448",
    curriculo: "Curriculo Gabriel Oliveira Santos.pdf",
    habilidades: [
      "Desenvolvimento de novos produtos",
      "Controle de qualidade",
      "Segurança alimentar",
      "Microbiologia de alimentos",
      "Gestão de processos industriais",
      "Tecnologia de alimentos",
    ],
    experiência: [
      {
        empresa: "Vitarella",
        cargo: "Engenheiro de alimentos",
        inicio: "2021-04-11",
        fim: "2022-08-25",
      },
    ],
    formação: [
      {
        instituição: "Universidade de Pernambuco",
        curso: "Engenheria de alimentos",
        tipo: "Bacharelado",
        "data de conclusão": "2019-12-01",
      },
    ],
    categoria: "Engenharia",
  },

  {
    _id: 5,
    nome: "Mariana Ferreira Rocha",
    email: "mariana.rocha@email.com",
    telefone: "81 9 11025656",
    curriculo: "Curriculo Mariana Ferreira Rocha.pdf",
    habilidades: [
      "Desenvolvimento de novos produtos",
      "Controle de qualidade",
      "Segurança alimentar",
      "Microbiologia de alimentos",
      "Gestão de processos industriais",
      "Tecnologia de alimentos",
    ],
    experiência: [
      {
        empresa: "Essen Delicatessen",
        cargo: "chefe de cozinha",
        inicio: "2021-04-11",
        fim: "2015-02-25",
      },
    ],
    formação: [
      {
        instituição: "Instituo Ana Maria Braga",
        curso: "Tecnolgia em Gastrônomia",
        tipo: "Tecnólogo",
        "data de conclusão": "2014-06-12",
      },
    ],
    categoria: "Cozinha",
  },

  {
    _id: 6,
    nome: "Pedro Henrique Lima Barbosa",
    email: "pedro.lima@email.com",
    telefone: "81 9 12309487",
    curriculo: "Curriculo Pedro Henrique Lima Barbosa.pdf",
    habilidades: [
      "Diagnóstico e tratamento de doenças animais",
      "Cirurgia veterinária",
      "Atendimento clínico e emergencial",
      "Medicina preventiva e vacinação",
      "Manejo e bem-estar animal",
      "Interpretação de exames laboratoriais",
    ],
    experiência: [
      {
        empresa: "Perdigão",
        cargo: "Médico Veterinário",
        inicio: "2021-04-11",
        fim: "2015-02-25",
      },
    ],
    formação: [
      {
        instituição: "Universidade Federal Rural de Pernambuco",
        curso: "Medicina Veterinária",
        tipo: "Bacharelado",
        "data de conclusão": "2010-12-01",
      },
    ],
    categoria: "Animais",
  },

  {
    _id: 7,
    nome: "Ana Beatriz Carvalho Dias",
    email: "ana.carvalho@email.com",
    telefone: "81 9 135790864",
    curriculo: "Curriculo Ana Beatriz Carvalho Dias.pdf",
    habilidades: [
      "Atendimento ao cliente",
      "Agilidade e organização",
      "Conhecimento do cardápio e sugestões de pratos",
      "Habilidade em anotar e entregar pedidos corretamente",
      "Trabalho em equipe",
      "Boas práticas de higiene e manipulação de alimentos",
    ],
    experiência: [
      {
        empresa: "Panela cheia",
        cargo: "Garçonete",
        inicio: "2024-02-11",
        fim: "2022-07-25",
      },
    ],
    formação: [
      {
        instituição: "Escola Tecnica Estadual Maria Ramos de Barros",
        curso: "Técnico em Admnistração",
        tipo: "Curso técnico",
        "data de conclusão": "2023-12-01",
      },
    ],
    categoria: "Atendimento",
  },

  {
    _id: 8,
    nome: "Lucas Gabriel Martins Pinto",
    email: "lucas.martins@email.com",
    telefone: "81 9 12345678",
    curriculo: "Curriculo Lucas Gabriel Martins Pinto.pdf",
    habilidades: [
      "Atendimento e suporte ao cliente",
      "Resolução de problemas técnicos",
      "Conhecimento em hardware e software",
      "Instalação e configuração de sistemas",
      "Habilidade em troubleshooting",
      "Comunicação clara e didática",
    ],
    experiência: [
      {
        empresa: "Planalto Net",
        cargo: "Técnico de TI",
        inicio: "2023-04-14",
        fim: "2024-11-22",
      },
    ],
    formação: [
      {
        instituição: "Escola Tecnica Estadual Maria Ramos de Barros",
        curso: "Técnico em Redes de computadores",
        tipo: "Curso técnico",
        "data de conclusão": "2023-12-01",
      },
    ],
    categoria: "Tecnologia",
  },

  {
    _id: 9,
    nome: "Camila Oliveira Nunes",
    email: "camila.oliveira@email.com",
    telefone: "81 9 10293847",
    curriculo: "Curriculo Camila Oliveira Nunes.pdf",
    habilidades: [
      "Domínio de softwares de design (Photoshop, Illustrator, Figma)",
      "Criação de identidades visuais",
      "UX/UI Design",
      "Tipografia e teoria das cores",
      "Edição de imagens e ilustração",
      "Criatividade e pensamento visual",
    ],
    experiência: [
      {
        empresa: "ABC Consultoria",
        cargo: "Coordenadora de marketing",
        inicio: "2023-04-14",
        fim: "2024-11-22",
      },
    ],
    formação: [
      {
        instituição: "Universidade Federal de Alagoas",
        curso: "Design",
        tipo: "Bacharelado",
        "data de conclusão": "2028-07-01",
      },
    ],
    categoria: "Design",
  },

  {
    _id: 10,
    nome: "Thiago Souza Ribeiro",
    email: "thiago.souza@email.com",
    telefone: "81 9 24680011",
    curriculo: "Curriculo Thiago Souza Ribeiro.pdf",
    habilidades: [
      "Desenvolvimento front-end (HTML, CSS, JavaScript, React)",
      "Desenvolvimento back-end (Node.js, NestJS, FastAPI, Java, Python)",
      "Bancos de dados relacionais e NoSQL (MySQL, PostgreSQL, MongoDB)",
      "Consumo e criação de APIs REST e GraphQL",
      "Versionamento de código com Git e GitHub",
      "Arquitetura de software e boas práticas de desenvolvimento",
    ],
    experiência: [
      {
        empresa: "Viitra inovações",
        cargo: "Desenvolvedor fullstack",
        inicio: "2023-04-14",
        fim: "2024-11-22",
      },
    ],
    formação: [
      {
        instituição: "Universidade de Pernambuco",
        curso: "Sistema de informação",
        tipo: "Bacharelado",
        "data de conclusão": "2028-07-01",
      },
    ],
    categoria: "Tecnologia",
  },

  {
    _id: 11,
    nome: "João Victor Almeida Costa",
    email: "joao.almeida@email.com",
    telefone: "81 9 87654321",
    curriculo: "Curriculo João Victor Almeida Costa.pdf",
    habilidades: [
      "Habilidade em negociação e persuasão",
      "Conhecimento em técnicas de vendas",
      "Atendimento ao cliente e pós-venda",
      "Capacidade de identificar necessidades do cliente",
      "Gestão de relacionamento e networking",
      "Uso de CRM e análise de métricas de vendas",
    ],
    experiência: [
      {
        empresa: "ABC Consultorias",
        cargo: "Consultor de Vendas",
        inicio: "2017-04-14",
        fim: "2025-11-22",
      },

      {
        empresa: "Citi",
        cargo: "Especialista em produtos",
        inicio: "2014-08-19",
        fim: "2015-11-28",
      },
    ],
    formação: [
      {
        instituição: "Pontifica Universidade Católica",
        curso: "Ciências Contabeis",
        tipo: "Bacharelado",
        "data de conclusão": "2019-07-01",
      },
    ],
    categoria: "Contabilidades",
  },

  {
    _id: 12,
    nome: "Mariana Ferreira Rocha",
    email: " mariana.rocha@email.com",
    telefone: "81 9 92108765",
    curriculo: "Mariana Ferreira Rocha.pdf",
    habilidades: [
      "Comunicação e atendimento ao cliente",
      "Habilidade em negociação e persuasão",
      "Conhecimento em técnicas de vendas",
      "Capacidade de identificar necessidades do cliente",
      "Gestão de relacionamento e fidelização",
      "Uso de CRM e análise de métricas de vendas",
    ],
    experiência: [
      {
        empresa: "ABC Consultoria",
        cargo: "Consultora de marketing",
        inicio: "2019-02-29",
        fim: "2024-11-26",
      },

      {
        empresa: "Poli Junior",
        cargo: "Especialista em produtos",
        inicio: "2016-08-19",
        fim: "2017-11-28",
      },
    ],
    formação: [
      {
        instituição: "Pontifica Universidade Católica",
        curso: "Design",
        tipo: "Bacharelado",
        "data de conclusão": "2019-07-01",
      },
    ],
    categoria: "Design",
  },

  {
    _id: 13,
    nome: "Alex Pereira Costa",
    email: " alex.costa@email.com",
    telefone: "81 9 87650123",
    curriculo: "alex.costa@email.com.pdf",
    habilidades: [
      "Limpeza e organização de ambientes",
      "Manutenção e conservação de espaços",
      "Habilidade no manuseio de produtos de limpeza",
      "Agilidade e atenção aos detalhes",
      "Trabalho em equipe",
      "Noções de segurança no trabalho",
    ],
    experiência: [
      {
        empresa: "MobiBrasil",
        cargo: "Auxiliar de seviços gerais",
        inicio: "2021-02-29",
        fim: "2023-11-26",
      },
    ],

    formação: [],

    categoria: "Assitente",
  },

  {
    _id: 14,
    nome: "Eduardo Silva Santos",
    email: " mariana.rocha@email.com",
    telefone: "81 9 92108765",
    curriculo: "Curriculo Eduardo Silva Santos.pdf",
    habilidades: [
      "Habilidade na condução de veículos de carga refrigerada",
      "Conhecimento em normas de transporte de produtos perecíveis",
      "Planejamento de rotas e logística de entregas",
      "Noções de manutenção preventiva do veículo",
      "Cumprimento de prazos e segurança no trânsito",
      "Boa comunicação e atendimento ao cliente",
    ],
    experiência: [
      {
        empresa: "Friboi",
        cargo: "Transporte de carga",
        inicio: "2014-02-29",
        fim: "2024-07-26",
      },
    ],
    formação: [
      {
        instituição: "Grau Técnico",
        curso: "Técnico em egurança em logistica de entrega",
        tipo: "Técnico",
        "data de conclusão": "2013-04-01",
      },
    ],
    categoria: "Motorista",
  },

  {
    _id: 15,
    nome: "Rodrigo Alves Costa",
    email: " rodrigo.costa@exemplo.com",
    telefone: "81 9 92345678",
    curriculo: "Curriculo Rodrigo Alves Costa.pdf",
    habilidades: [
      "Experiência na condução de veículos de transporte de animais",
      "Conhecimento em bem-estar animal e manuseio adequado",
      "Planejamento de rotas para minimizar o estresse dos animais",
      "Habilidade em carga, descarga e acomodação segura dos animais",
      "Cumprimento das normas sanitárias e regulatórias do transporte",
      "Noções de manutenção preventiva do veículo",
    ],
    experiência: [
      {
        empresa: "KiGranja",
        cargo: "Transporte de carga viva",
        inicio: "2018-02-29",
        fim: "2023-07-26",
      },
    ],
    formação: [
      {
        instituição: "Grau Técnico",
        curso: "Técnico em egurança em logistica de entrega",
        tipo: "Técnico",
        "data de conclusão": "2012-04-01",
      },
    ],
    categoria: "Motorista",
  },

  {
    _id: 16,
    nome: "Patrícia Rocha Mendes",
    email: "patricia.mendes@exemplo.com",
    telefone: "81 9 5678901",
    curriculo: "Curriculo Patrícia Rocha Mendes.pdf",
    habilidades: [
      "Atendimento ao cliente com cordialidade",
      "Habilidade em comunicação e escuta ativa",
      "Organização e agilidade no serviço",
      "Resolução de problemas e atendimento de reclamações",
      "Trabalho em equipe",
      "Conhecimento básico em informática e sistemas de atendimento",
    ],
    experiência: [
      {
        empresa: "Clinica saude visão",
        cargo: "Secretária",
        inicio: "2018-02-29",
        fim: "2023-07-26",
      },
    ],
    formação: [],
    categoria: "Assitente",
  },

  {
    _id: 17,
    nome: "Marcos Vinícius Oliveira",
    email: " marcos.oliveira@exemplo.com",
    telefone: "81 9 93456789",
    curriculo: "Curriculo Marcos Vinícius Oliveira.pdf",
    habilidades: [
      "Atendimento e suporte ao cliente",
      "Diagnóstico e resolução de problemas técnicos",
      "Conhecimento em hardware e software",
      "Instalação e configuração de sistemas operacionais e redes",
      "Habilidade em troubleshooting",
      "Boa comunicação e paciência para lidar com usuários",
    ],
    experiência: [
      {
        empresa: "NutriBrasil",
        cargo: "Suporte técnico",
        inicio: "2020-02-29",
        fim: "2024-07-27",
      },
    ],
    formação: [
      {
        instituição: "Grau Técnico",
        curso: "Técnico informática",
        tipo: "Técnico",
        "data de conclusão": "2019-04-01",
      },
    ],
    categoria: "Tecnologia",
  },

  {
    _id: 18,
    nome: "Aline Santos Barbosa",
    email: "aline.barbosa@exemplo.com",
    telefone: "81 9 97890123",
    curriculo: "Curriculo Aline Santos Barbosa.pdf",
    habilidades: [
      "Gestão de cronogramas e prazos",
      "Liderança e coordenação de equipes",
      "Metodologias ágeis (Scrum, Kanban) e tradicionais (PMBOK)",
      "Planejamento estratégico e definição de metas",
      "Gerenciamento de riscos e resolução de problemas",
      "Comunicação eficaz e negociação com stakeholders",
    ],
    experiência: [
      {
        empresa: "Voxa Lab",
        cargo: "Gestora de projetos",
        inicio: "2020-02-29",
        fim: "2024-07-27",
      },
    ],
    formação: [
      {
        instituição: "Universidade Fdereal de Pernambuco",
        curso: "Ciência da Computação",
        tipo: "Bacharelado",
        "data de conclusão": "2025-04-01",
      },
    ],
    categoria: "Tecnologia",
  },

  {
    _id: 19,
    nome: "Rafaela Martins Cunha",
    email: "rafaela.cunha@exemplo.com",
    telefone: "81 9 98901234",
    curriculo: "Curriculo Rafaela Martins Cunha.pdf",
    habilidades: [
      "Modelagem e arquitetura de dados",
      "Manipulação e processamento de grandes volumes de dados",
      "Conhecimento em bancos de dados SQL e NoSQL",
      "Desenvolvimento de pipelines de dados (ETL/ELT)",
      "Programação em Python, SQL e ferramentas de Big Data",
      "Gestão e segurança de dados em ambientes na nuvem (AWS, GCP, Azure)",
    ],
    experiência: [
      {
        empresa: "Voxa Lab",
        cargo: "Engenheira de dados",
        inicio: "2020-02-29",
        fim: "2024-07-27",
      },
    ],
    formação: [
      {
        instituição: "Universidade Fdereal de Pernambuco",
        curso: "Engenharia da Computação",
        tipo: "Bacharelado",
        "data de conclusão": "2024-04-01",
      },
    ],
    categoria: "Tecnologia",
  },

  {
    _id: 20,
    nome: "Daniel Costa Ribeiro",
    email: "daniel.ribeiro@exemplo.com",
    telefone: "81 9 9012345",
    curriculo: "Curriculo Daniel Costa Ribeiro.pdf",
    habilidades: [
      "Desenvolvimento de software em linguagens como Java, Python, C++",
      "Conhecimento em frameworks e bibliotecas (React, Angular, Spring, Django)",
      "Gestão de versionamento de código com Git e GitHub",
      "Desenvolvimento de APIs RESTful e GraphQL",
      "Testes automatizados e controle de qualidade de código",
      "Metodologias ágeis (Scrum, Kanban) e práticas de DevOps",
    ],
    experiência: [
      {
        empresa: "Tracking Trade",
        cargo: "Engenheiro de software",
        inicio: "2020-02-29",
        fim: "2024-07-27",
      },

      {
        empresa: "Viitra inovações",
        cargo: "Engenheiro de software",
        inicio: "2020-05-20",
        fim: "2018-02-21",
      },
    ],
    formação: [
      {
        instituição: "Universidade Fdereal de Pernambuco",
        curso: "Ciência da Computação",
        tipo: "Bacharelado",
        "data de conclusão": "2025-04-01",
      },
    ],
    categoria: "Tecnologia",
  },

  {
    _id: 21,
    nome: "Beatriz Alencar Dias",
    email: "beatriz.dias@exemplo.com",
    telefone: "81 9 94445566",
    curriculo: "Curriculo Beatriz Alencar Dias.pdf",
    habilidades: [
      "Preparo e decoração de bolos e doces",
      "Conhecimento em técnicas de confeitaria (pasta americana, glacê real, chocolate)",
      "Criatividade e desenvolvimento de novos sabores e designs",
      "Habilidade em atendimento ao cliente e personalização de pedidos",
      "Controle de qualidade e segurança alimentar",
      "Gestão de tempo e organização na produção",
    ],
    experiência: [
      {
        empresa: "Dona benta",
        cargo: "Confeiteira",
        inicio: "2020-02-29",
        fim: "2024-07-27",
      },

      {
        empresa: "Essen Delicatessen",
        cargo: "Confeiteira",
        inicio: "2020-05-20",
        fim: "2018-02-21",
      },
    ],
    formação: [],
    categoria: "Alimentos",
  },

  {
    _id: 22,
    nome: "Júlia Fernanda Peixoto",
    email: "julia.peixoto@exemplo.com",
    telefone: "81 9 95556677",
    curriculo: "Curriculo Júlia Fernanda Peixoto.pdf",
    habilidades: [
      "Preparo e organização de alimentos",
      "Auxílio no corte, picagem e preparação de ingredientes",
      "Conhecimento em técnicas de cocção e utensílios de cozinha",
      "Manutenção da higiene e organização da cozinha",
      "Capacidade de seguir receitas e instruções dos chefs",
      "Trabalho em equipe e rapidez na execução das tarefas",
    ],
    experiência: [
      {
        empresa: "Restaurante Les Présidents",
        cargo: "Cozinheira",
        inicio: "2020-02-29",
        fim: "2024-07-27",
      },
    ],
    formação: [
      {
        instituição: "Universidade Fdereal Rural de Pernambuco",
        curso: "Gastronomia",
        tipo: "Bacharelado",
        "data de conclusão": "2023-04-01",
      },
    ],
    categoria: "Tecnologia",
  },

  {
    _id: 23,
    nome: "Leonardo Oliveira Castro",
    email: " leonardo.castro@exemplo.com",
    telefone: "81 9 91112233",
    curriculo: "Curriculo Leonardo Oliveira Castro.pdf",
    habilidades: [
      "Organização e gestão de agendas e compromissos",
      "Redação e elaboração de documentos administrativos",
      "Atendimento telefônico e atendimento ao cliente",
      "Controle e arquivamento de documentos",
      "Domínio de ferramentas de escritório (Word, Excel, PowerPoint)",
      "Gestão de fluxo de trabalho e apoio à equipe",
    ],
    experiência: [
      {
        empresa: "ABC Consiltoria",
        cargo: "Assistente admnistrativo",
        inicio: "2019-04-10",
        fim: "2017-09-27",
      },
    ],
    formação: [
      {
        instituição: "Universidade Fdereal Rural de Pernambuco",
        curso: "Adminstração",
        tipo: "Bacharelado",
        "data de conclusão": "2023-04-01",
      },
    ],
    categoria: "Adminstração",
  },

  {
    _id: 24,
    nome: "Felipe Andrade Monteiro",
    email: " felipe.monteiro@exemplo.com",
    telefone: "81 9 92223344",
    curriculo: "Curriculo Felipe Andrade Monteiro.pdf",
    habilidades: [
      "Habilidade na condução de diferentes tipos de veículos",
      "Conhecimento das leis de trânsito e normas de segurança",
      "Manutenção preventiva e cuidados com o veículo",
      "Planejamento de rotas e controle de tempo",
      "Capacidade de lidar com situações de trânsito e imprevistos",
      "Boa comunicação e atendimento ao cliente",
    ],
    experiência: [
      {
        empresa: "Usina Petribu",
        cargo: "Motorista",
        inicio: "2019-04-10",
        fim: "2016-03-27",
      },
    ],
    formação: [],
    categoria: "Motorista",
  },

  {
    _id: 25,
    nome: "Carlos Eduardo Nogueira",
    email: "carlos.nogueira@exemplo.com",
    telefone: "81 9 93334455",
    curriculo: "Curriculo Carlos Eduardo Nogueira.pdf",
    habilidades: [
      "Preparo e organização de ingredientes",
      "Higienização de alimentos e utensílios",
      "Apoio na montagem de pratos",
      "Conhecimento básico em técnicas de cocção",
      "Manutenção da limpeza e organização da cozinha",
      "Trabalho em equipe e agilidade no serviço",
    ],
    experiência: [
      {
        empresa: "Para lanches",
        cargo: "Assistente de cozinha",
        inicio: "2025-02-10",
        fim: "2022-09-27",
      },
    ],
    formação: [],

    categoria: "Alimentação",
  },

  {
    _id: 26,
    nome: "Luana Santos Melo",
    email: " luana.melo@exemplo.com",
    telefone: "81 9 96667788",
    curriculo: "Curriculo Luana Santos Melo.pdf",
    habilidades: [
      "Diagnóstico e tratamento de doenças em animais",
      "Realização de exames clínicos e laboratoriais",
      "Cirurgias e procedimentos veterinários",
      "Atendimento e orientação a tutores sobre cuidados com os animais",
      "Conhecimento em nutrição e bem-estar animal",
      "Habilidade em manejo de diferentes espécies",
    ],
    experiência: [
      {
        empresa: "Friboi",
        cargo: "Medica Veterinária",
        inicio: "2019-04-10",
        fim: "2017-09-27",
      },
    ],
    formação: [
      {
        instituição: "Universidade Fdereal Rural de Pernambuco",
        curso: "Zootecnia",
        tipo: "Bacharelado",
        "data de conclusão": "2023-04-01",
      },
    ],
    categoria: "Medicina Veterinária",
  },

  {
    _id: 27,
    nome: "Isadora Carvalho Ramos",
    email: "isadora.ramos@exemplo.com",
    telefone: "81 9 97778899",
    curriculo: "Curriculo Isadora Carvalho Ramos.pdf",
    habilidades: [
      "Diagnóstico e tratamento de doenças em animais",
      "Realização de exames clínicos e laboratoriais",
      "Cirurgias e procedimentos veterinários",
      "Atendimento e orientação a tutores sobre cuidados com os animais",
      "Conhecimento em nutrição e bem-estar animal",
      "Habilidade em manejo de diferentes espécies",
    ],
    experiência: [
      {
        empresa: "Friboi",
        cargo: "Medica Veterinária",
        inicio: "2019-04-10",
        fim: "2017-09-27",
      },
    ],
    formação: [
      {
        instituição: "Universidade Fdereal Rural de Pernambuco",
        curso: "Medicina Veterinária",
        tipo: "Bacharelado",
        "data de conclusão": "2025-04-01",
      },
    ],
    categoria: "Médicina Veterinária",
  },

  {
    _id: 28,
    nome: "Ricardo Augusto Barros",
    email: "ricardo.barros@exemplo.com",
    telefone: "81 9 98889900",
    curriculo: "Curriculo Ricardo Augusto Barros.pdf",
    habilidades: [
      "Limpeza e conservação de ambientes",
      "Organização de materiais e suprimentos",
      "Manutenção básica de instalações",
      "Manuseio seguro de produtos de limpeza",
      "Trabalho em equipe e proatividade",
      "Cumprimento de normas de segurança e higiene",
    ],
    experiência: [
      {
        empresa: "VeraCruz",
        cargo: "Serviços gerais",
        inicio: "2019-04-10",
        fim: "2017-09-27",
      },
    ],
    formação: [],
    categoria: "Assistente",
  },

  {
    _id: 29,
    nome: "Gabriela Lopes Freitas",
    email: " gabriela.freitas@exemplo.com",
    telefone: "81 9 99001122",
    curriculo: "Curriculo Gabriela Lopes Freitas.pdf",
    habilidades: [
      "Análise e manipulação de grandes volumes de dados",
      "Conhecimento em estatística e aprendizado de máquina",
      "Programação em Python, R e SQL",
      "Criação e otimização de modelos preditivos",
      "Visualização de dados e storytelling com ferramentas como Power BI e Tableau",
      "Trabalho com Big Data e computação em nuvem (AWS, GCP, Azure)",
    ],
    experiência: [
      {
        empresa: "Citi",
        cargo: "Especialista de dados",
        inicio: "2019-04-10",
        fim: "2017-09-27",
      },
    ],
    formação: [
      {
        instituição: "Universidade Fdereal de Pernambuco",
        curso: "Estatistica",
        tipo: "Bacharelado",
        "data de conclusão": "2022-04-01",
      },
    ],
    categoria: "Tecnologia",
  },

  {
    _id: 27,
    nome: "Vitor Hugo Pimentel",
    email: "vitor.pimentel@exemplo.com",
    telefone: "81 9 90011223",
    curriculo: "Curriculo Vitor Hugo Pimentel.pdf",
    habilidades: [
      "Análise e manipulação de grandes volumes de dados",
      "Conhecimento em estatística e aprendizado de máquina",
      "Programação em Python, R e SQL",
      "Criação e otimização de modelos preditivos",
      "Visualização de dados e storytelling com ferramentas como Power BI e Tableau",
      "Trabalho com Big Data e computação em nuvem (AWS, GCP, Azure)",
    ],
    experiência: [
      {
        empresa: "Extreme Digital Solutions",
        cargo: "Ciência de dados",
        inicio: "2022-11-10",
        fim: "2034-09-27",
      },
    ],
    formação: [
      {
        instituição: "Universidade Fdereal de Pernambuco",
        curso: "Ciência da Computação",
        tipo: "Bacharelado",
        "data de conclusão": "2025-04-01",
      },
    ],
    categoria: "Tecnologia",
  },
]);
