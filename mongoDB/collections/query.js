// 1. Análise de Candidatos por Nível de Experiência
db.candidatos.aggregate([
  {
    $group: {
      _id: "$nível_experiência",
      total_candidatos: { $sum: 1 },
      média_pretensão_salarial: { $avg: "$pretensão_salarial" }
    }
  },
  { $sort: { total_candidatos: -1 } }
]);

// 2. Total de Vagas por Empresa com Estatísticas Salariais
db.vagas.aggregate([
  {
    $lookup: {
      from: "empresas",
      localField: "empresa_id",
      foreignField: "_id",
      as: "empresa_info"
    }
  },
  { $unwind: "$empresa_info" },
  {
    $group: {
      _id: "$empresa_info.Razão Social",
      total_vagas: { $sum: 1 },
      média_salarial: { $avg: "$salário" },
      menor_salário: { $min: "$salário" },
      maior_salário: { $max: "$salário" }
    }
  },
  { $sort: { total_vagas: -1 } }
]);

// 3. Empresas por Setor com Contagem de Funcionários
db.empresas.aggregate([
  {
    $group: {
      _id: "$setor",
      total_empresas: { $sum: 1 },
      total_funcionários: { $sum: "$número_funcionários" },
      empresas: { $push: "$Razão Social" }
    }
  },
  { $sort: { total_empresas: -1 } }
]);

// 4. Análise Cruzada: Vagas vs Candidatos por Área
db.vagas.aggregate([
  {
    $lookup: {
      from: "candidatos",
      let: { vaga_titulo: "$titulo" },
      pipeline: [
        {
          $match: {
            $expr: {
              $in: ["$$vaga_titulo", "$áreas_interesse"]
            }
          }
        }
      ],
      as: "candidatos_interessados"
    }
  },
  {
    $group: {
      _id: "$titulo",
      total_vagas: { $sum: 1 },
      total_candidatos: { $sum: { $size: "$candidatos_interessados" } },
      salário_médio: { $avg: "$salário" }
    }
  },
  { $sort: { total_candidatos: -1 } }
]);

// 5. Estatísticas de Vagas por Localização e Tipo
db.vagas.aggregate([
  {
    $group: {
      _id: {
        localização: "$localização",
        tipo: "$tipo"
      },
      quantidade: { $sum: 1 },
      média_salarial: { $avg: "$salário" },
      empresas_distintas: { $addToSet: "$empresa_id" }
    }
  },
  {
    $project: {
      localização: "$_id.localização",
      tipo: "$_id.tipo",
      quantidade: 1,
      média_salarial: 1,
      número_empresas: { $size: "$empresas_distintas" }
    }
  },
  { $sort: { quantidade: -1 } }
]);
