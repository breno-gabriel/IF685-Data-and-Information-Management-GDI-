// 1. Atualizar salário do Engenheiro de Software para 2000
db.vagas.updateOne({ _id: 4 }, { $set: { salário: 2000.0 } });

// 2. Adicionar novo benefício para todas as vagas CLT
db.vagas.updateMany(
  { tipo: "CLT" },
  {
    $push: {
      beneficios: "Participação nos Lucros",
    },
  }
);
