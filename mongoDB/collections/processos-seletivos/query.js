// Procura processos seletivos com status "Aberto"
db.processos_seletivos.find({ status: "Aberto" });

// Projeta as vagas que estão sendo disputadas do processo seletivo com ID 67edbb1daef882da62966cea
db.processos_seletivos.find({ _id: ObjectId("67edbb1daef882da62966cea") }, { vagas: 1 });

// Projeta as etapas do processo seletivo com ID 67edbb1daef882da62966cef
db.processos_seletivos.find({ _id: ObjectId("67edbb1daef882da62966cef") }, { etapas: 1 });

// Projeta os candidatos do processo seletivo com ID 67edbb1daef882da62966cf2
db.processos_seletivos.find({ _id: ObjectId("67edbb1daef882da62966cf2") }, { candidatos: 1 });

// Procura processos seletivos com responsável "Mr. Tommy Bednar"
db.processos_seletivos.find({ responsavel: "Mr. Tommy Bednar" });

// Conta a quantidade de candidados que estão em alguma etapa do processo seletivo dentre todos os processos seletivos
db.processos_seletivos.aggregate([
    { $unwind: "$candidatos" },
    { $group: { _id: "$candidatos.etapa_atual", total: { $sum: 1 } } }
  ]);

// Procura candidatos em uma etapa específica do processo seletivo
db.processos_seletivos.aggregate([
    {$unwind: '$candidatos'},
    {$match: {'candidatos.etapa_atual': 'Triagem de Currículos'}}
])

// Procura processos seletivos com etapas com data prevista menor que 10/04/2025
db.processos_seletivos.find({ "etapas.data_prevista": { $lte: ISODate("2025-04-10T00:00:00Z") } });