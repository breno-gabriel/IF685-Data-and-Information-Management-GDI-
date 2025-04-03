import { MongoClient, ObjectId } from "mongodb";
import * as dotenv from "dotenv";
import { faker } from "@faker-js/faker";
dotenv.config();

const DATABASE_URL = process.env.DATABASE_URL;
if (!DATABASE_URL) {
  throw new Error("Please define DATABASE_URL in .env file");
}

const client = new MongoClient(DATABASE_URL);

function getRandomElements(array, count) {
  const shuffled = array.sort(() => 0.5 - Math.random());
  return shuffled.slice(0, count);
}

async function criarProcessoSeletivo() {
  await client.connect();
  const db = client.db("gdi-project");
  const vagasCollection = db.collection("vagas");
  const candidatosCollection = db.collection("candidatos");
  const processoCollection = db.collection("processos_seletivos");
  await db.collection("processos_seletivos").drop();

  // Buscar vagas e candidatos existentes no banco
  // Buscar vagas e candidatos existentes no banco
  const vagas = await vagasCollection.find({}).toArray();
  const candidatos = await candidatosCollection.find({}).toArray();

  const processos = vagas.map((vaga) => {
    // Selecionar aleatoriamente 1 a 3 vagas para o processo seletivo
    const vagasSelecionadas = getRandomElements(
      vagas,
      Math.floor(Math.random() * 3) + 1
    );

    // Definir etapas padrão para o processo seletivo
    const etapas = [
      {
        nome: "Triagem de Currículos",
        descricao: "Análise inicial dos currículos recebidos",
        data_prevista: new Date("2025-04-05"),
      },
      {
        nome: "Entrevista Técnica",
        descricao: "Avaliação técnica dos candidatos",
        data_prevista: new Date("2025-04-10"),
      },
      {
        nome: "Entrevista Final",
        descricao: "Última fase da entrevista",
        data_prevista: new Date("2025-04-15"),
      },
    ];

    // Selecionar aleatoriamente 2 a 5 candidatos para o processo seletivo
    const candidatosSelecionados = getRandomElements(
      candidatos,
      Math.floor(Math.random() * 4) + 2
    ).map((candidato) => ({
      candidato_id: candidato._id,
      status: "Em análise",
      etapa_atual: "Triagem de Currículos",
    }));

    let descricoes;
    if (
      vaga.titulo.toLowerCase().includes("desenvolvimento") ||
      vaga.titulo.toLowerCase().includes("cientista")
    ) {
      descricoes = [
        "Estamos em busca de profissionais talentosos para inovar no setor de tecnologia!",
        "Nosso objetivo é recrutar os melhores desenvolvedores para transformar o mercado digital.",
        "Uma grande oportunidade para aqueles que desejam crescer em um ambiente tecnológico dinâmico!",
      ];
    } else if (vaga.titulo.toLowerCase().includes("engenharia")) {
      descricoes = [
        "Procuramos engenheiros comprometidos com inovação e qualidade para grandes projetos.",
        "Uma excelente oportunidade para profissionais que desejam fazer a diferença na engenharia!",
        "Nosso processo seletivo visa encontrar talentos para desafios estruturais e técnicos.",
      ];
    } else {
      descricoes = [
        "Estamos recrutando profissionais qualificados para integrar nossa equipe!",
        "Se você busca uma oportunidade de crescimento, este processo seletivo é para você.",
        "Nosso objetivo é encontrar os melhores talentos para nosso time.",
      ];
    }

    const processoSeletivo = {
      vagas: vagasSelecionadas.map((v) => v._id),
      etapas,
      candidatos: candidatosSelecionados,
      descricao: faker.helpers.arrayElement(descricoes),
      responsavel: faker.person.fullName(),
      data_criacao: new Date(),
      status: faker.helpers.arrayElement([
        "Aberto",
        "Em andamento",
        "Encerrado",
      ]),
    };

    return processoSeletivo;
  });

  // // Inserir os processos no MongoDB

  await processoCollection.insertMany(processos);
  console.log("Processos seletivos inseridos com sucesso!");
}

criarProcessoSeletivo();
