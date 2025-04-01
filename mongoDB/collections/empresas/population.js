db.collection("empresas").insertMany([
  {
    _id: 1,
    CNPJ: "12345678000101",
    "Razão Social": "Viitra inovações",
    descrição:
      "Transformando desafios complexos em soluções inovadoras, promovendo avanços significativos em Educação, Inteligência Artificial e Ciência de Dados.",
    endereço: {
      rua: "Rua Ceráima",
      bairro: "Bongi",
      cidade: "Recife",
      estado: "pernambuco",
      uf: "PE",
      cep: "50751500",
    },
    setor: "tecnologia",
  },

  {
    _id: 2,
    CNPJ: "94356782000140",
    "Razão Social": "Neurotech",
    descrição:
      "Uma marca do grupo B3, 100% brasileira, pioneira na criação de soluções avançadas de Inteligência Artificial, Machine Learning e Big Data. Nossa missão é transformar um mundo de informações confiáveis e relevantes para que nossos clientes obtenham resultados incrementais expressivos, prevendo novas oportunidades de negócios.",
    endereço: {
      rua: "Travessa do Normando",
      bairro: "Pina",
      cidade: "Recife",
      estado: "Pernambuco",
      uf: "PE",
      cep: "51011635",
    },
    setor: "tecnologia",
  },

  {
    _id: 3,
    CNPJ: "87078056000147",
    "Razão Social": "Tracking trade",
    descrição:
      "Proporcionamos produtividade e eficiência nos negócios de nossos clientes",
    endereço: {
      rua: "Rua Oscar Luiz de Souza",
      bairro: "Jardim Rosa",
      cidade: "Francisco Morato",
      estado: "São Paulo",
      uf: "SP",
      cep: "07991160",
    },
    setor: "tecnologia",
  },

  {
    _id: 4,
    CNPJ: "77023558000117",
    "Razão Social": "Avanade",
    descrição:
      "Quando os resultados são importantes, as pessoas falam com a Avanade. Há mais de 25 anos que ajudamos clientes de todos os setores a atingir o seu potencial máximo, desbloqueando o poder da Microsoft.",
    endereço: {
      rua: "Avenida central",
      bairro: "Areias",
      cidade: "Recife",
      estado: "Pernanbuco",
      uf: "PE",
      cep: "50781510",
    },
    setor: "tecnologia",
  },

  {
    _id: 5,
    CNPJ: "36402535000136",
    "Razão Social": "dippolum consultoria",
    descrição:
      "Empresa Júnior da UFPE Sinônimo de tecnologia transformando realidades Soluções em automação, IoT, impressão 3D e prototipação",
    endereço: {
      rua: "2ª Travessa Córrego do Abdias",
      bairro: "Linha do Tiro",
      cidade: "Recife",
      estado: "Pernanbuco",
      uf: "PE",
      cep: "52131241",
    },
    setor: "consultoria",
  },

  {
    _id: 6,
    CNPJ: "77830477000129",
    "Razão Social": "Mauriceia Alimentos",
    descrição:
      "Nascemos em 1988, mas nossa história começou anos antes, numa pequena criação de aves em Nazaré da Mata, Pernambuco. Cada experiência, conhecimento e aptidão adquiridos nos levaram à busca por um espaço maior. E, em pouco tempo, tivemos que expandir para uma fábrica em Carpina, onde construímos uma fábrica de rações, granja de matrizes, incubatório e abatedouro. De lá pra cá, não paramos de crescer. Hoje, temos agroindústrias de larga produção em Pernambuco, Paraíba e Bahia.",
    endereço: {
      rua: "Rua Bernardo Vieira de Melo 19",
      bairro: "Centro",
      cidade: "Nazaré da Mata",
      estado: "`Pernanbuco`",
      uf: "PE",
      cep: "55800970",
    },
    setor: "alimenticio",
  },

  {
    _id: 7,
    CNPJ: "86346320000113",
    "Razão Social": "Alpargatas",
    descrição:
      "We are a global company, founded and based in Brazil for over 115 years. We are committed to delight the world with amazing brands, that convey lightness and joy to the everyday lives of our consumers. We own Havaianas brand, world leader in open shoes, known for the iconic flip-flops that represent Brazilianness, comfort and style. We have 49.2% of Rothy’s a north-american sustainable footwear Brand.",
    endereço: {
      rua: "Rua Deputado João Teobaldo de Azevedo",
      bairro: "São Sebastião",
      cidade: "Carpina",
      estado: "`Pernanbuco`",
      uf: "PE",
      cep: "55818520",
    },
    setor: "calçados e têxtil",
  },

  {
    _id: 8,
    CNPJ: "87314842000104",
    "Razão Social": "Confeitaria Colombo",
    descrição:
      "Café centenário decorado com fabulosos espelhos, renomado por suas iguarias e doces confeitados.",
    endereço: {
      rua: "Rua João Moraes",
      bairro: "Paciência",
      cidade: "Rio de Janeiro",
      estado: "`Rio de Janeiro`",
      uf: "RJ",
      cep: "23587620",
    },
    setor: "alimenticio",
  },
]);
