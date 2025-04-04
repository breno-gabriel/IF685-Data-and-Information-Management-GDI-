db.empresas.countDocuments({ setor: "tecnologia" });

await db.empresas.updateOne(
  { _id: 13 },
  {
    $set: {
      CNPJ: "98765432000199",
      "Razão Social": "Technology Solutions",
      descrição:
        "Empresa especializada em soluções tecnológicas para o mercado financeiro.",
      endereço: {
        rua: "Av. Paulista",
        bairro: "Bela Vista",
        cidade: "São Paulo",
        estado: "São Paulo",
        uf: "SP",
        cep: "01311-000",
      },
      setor: "tecnologia",
    },
  },
  { upsert: true }
);

await db.empresas.findOne({
  CNPJ: "98765432000199",
});

const empresas = await db
  .empresas
  .find({
    $where: function () {
      return this.endereço && this.endereço.cidade === "Recife";
    },
  })
  .toArray();

console.log(empresas);
