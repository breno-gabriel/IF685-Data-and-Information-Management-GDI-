db.collection("candidatos").aggregate([
  { $match: { nome: "Breno Gabriel de Melo Lima" } },
]);

db.candidatos.find().pretty();

db.collection("candidatos")
  .find({
    "experiência.fim": { $gte: "2022-04-01" }, // Ajuste a data conforme necessário
  })
  .toArray();

await db
  .collection("candidatos")
  .find({
    habilidades: { $regex: "React", $options: "i" }, // Busca candidatos que tenham "React" nas habilidades (case insensitive)
  })
  .toArray();

const candidatos = await db
  .collection("candidatos")
  .find({})
  .sort({ _id: -1 })
  .limit(3)
  .toArray();

await db
  .collection("candidatos")
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

await db
  .collection("candidatos")
  .find({
    habilidades: { $size: 5 },
  })
  .toArray();

await db
  .collection("candidatos")
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

db.collection("candidatos").updateOne(
  { _id: 1 }, // Filtra o candidato pelo ID
  { $addToSet: { habilidades: "Python" } }
);
