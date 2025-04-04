db.candidatos.aggregate([
  { $match: { nome: "Breno Gabriel de Melo Lima" } },
]);

db.candidatos.find().pretty();

db.candidatos
  .find({
    "experiência.fim": { $gte: "2022-04-01" }, // Ajuste a data conforme necessário
  })
  .toArray();

await db.candidatos
  .find({
    habilidades: { $regex: "React", $options: "i" }, // Busca candidatos que tenham "React" nas habilidades (case insensitive)
  })
  .toArray();

const candidatos = await db.candidatos
  .find({})
  .sort({ _id: 1 })
  .limit(3)
  .toArray();

await db.candidatos
  .aggregate([
    {
      $addFields: {
        nomeFormatado: {
          $function: {
            body: function (nome) {
              return nome.toUpperCase();
            },
            args: ["$nome"],
            lang: "js",
          },
        },
      },
    },
  ])
  .toArray();

await db.candidatos
  .find({
    habilidades: { $size: 5 },
  })
  .toArray();

await db.candidatos
  .find({
    habilidades: {
      $all: [
        "React",
        "Next",
        "Typescript",
        "Tailwind",
        "ShadCn",
        "Proatividade",
        "boa comunicação",
        "Pensamento fora da caixa",
      ],
    },
  })
  .toArray();

db.candidatos.updateOne(
  { _id: 1 }, // Filtra o candidato pelo ID
  { $addToSet: { habilidades: "Python" } }
);

db.candidatos.insert(
  {
    _id: 120,
    nome: "Fabio Andrade",
    email: "fabio.andrade@email.com",
    telefone: "81 9 99576543",
    curriculo: "Curriculo Fabio Andrade.pdf",
    habilidades: [
      "Desenvolvimento de projetos de biotecnologia",
      "Conhecimento em biologia molecular e genética",
      "Técnicas de laboratório e análise de dados biológicos",
      "Elaboração de relatórios técnicos e artigos científicos",
      "Comunicação e trabalho em equipe",
    ],
    experiência: [
      {
        empresa: "Biotechnology Research Ltda.",
        cargo: "Biotecnologista",
        inicio: "2020-12-01",
        fim: "2023-12-31",
      },
    ],
    formação: [
      {
        instituição: "Universidade Federal de Pernambuco",
        curso: "Biotecnologia",
        tipo: "Bacharelado",
        "data de conclusão": "2019-12-15",
      },
    ],
    categoria: "Biotecnologia",
  },
)