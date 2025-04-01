await db
  .collection("vagas")
  .aggregate([{ $match: { tipo: "CLT" } }, { $count: "CLT" }])
  .toArray();

await db
  .collection("vagas")
  .aggregate([
    {
      $group: {
        _id: "$localização",
        total_vagas: { $sum: 1 },
        média_salarial: { $avg: "$salário" },
        menor_salário: { $min: "$salário" },
        maior_salário: { $max: "$salário" },
      },
    },
    {
      $sort: { total_vagas: -1 },
    },
  ])
  .toArray();
