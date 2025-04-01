db.collection("candidatos").aggregate([
  { $match: { nome: "Breno Gabriel de Melo Lima" } },
]);
