await db
  .collection("vagas")
  .aggregate([{ $match: { tipo: "CLT" } }, { $count: "CLT" }])
  .toArray();

await db
  .collection("vagas")
  .aggregate([
    {
      $group: {
        _id: {
          localização: "$localização",
          tipo: "$tipo",
        },
        quantidade: { $sum: 1 },
        média_salarial: { $avg: "$salário" },
        empresas_distintas: { $addToSet: "$empresa_id" },
      },
    },
    {
      $project: {
        localização: "$_id.localização",
        tipo: "$_id.tipo",
        quantidade: 1,
        média_salarial: 1,
        número_empresas: { $size: "$empresas_distintas" },
      },
    },
    { $sort: { quantidade: -1 } },
  ])
  .toArray();

await db
  .collection("vagas")
  .aggregate([
    {
      $lookup: {
        from: "empresas",
        localField: "empresa_id",
        foreignField: "_id",
        as: "empresa_info",
      },
    },
    { $unwind: "$empresa_info" },
    {
      $group: {
        _id: "$empresa_info.Razão Social",
        total_vagas: { $sum: 1 },
        média_salarial: { $avg: "$salário" },
        menor_salário: { $min: "$salário" },
        maior_salário: { $max: "$salário" },
      },
    },
    { $sort: { total_vagas: -1 } },
  ])
  .toArray();

await db
  .collection("vagas")
  .find({
    beneficios: { $exists: true, $eq: [] },
  })
  .toArray();

db.collection("vagas").mapReduce(
  function () {
    emit(this.tipo, 1);
  },
  function (key, values) {
    return Array.sum(values);
  },
  {
    out: "vagas_por_tipo",
  }
);

await db.collection("vagas").createIndex({ titulo: "text", descrição: "text" });

await db
  .collection("vagas")
  .find({
    $text: { $search: "frontend" },
  })
  .toArray();

await db
  .collection("vagas")
  .aggregate([
    {
      $project: {
        titulo: 1,
        beneficios: {
          $filter: {
            input: "$beneficios",
            as: "beneficio",
            cond: {
              $in: [
                "$$beneficio",
                ["Plano de saúde", "Vale alimentação", "Horário flexível"],
              ],
            },
          },
        },
      },
    },
  ])
  .toArray();
