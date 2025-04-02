import { MongoClient } from "mongodb";
import * as dotenv from "dotenv";
import { faker } from "@faker-js/faker";
dotenv.config();

const DATABASE_URL = process.env.DATABASE_URL;
if (!DATABASE_URL) {
  throw new Error("Please define DATABASE_URL in .env file");
}

const client = new MongoClient(DATABASE_URL);

async function populateCompanies() {
  try {
    await client.connect();
    const db = client.db("gdi-project"); // Replace with your database name
    const collection = db.collection("empresas");

    let fakeCompanies = [];
    for (let i = 0; i < 100; i++) {
      fakeCompanies.push({
        _id: i + 10, // Start after your existing IDs
        CNPJ: faker.string.numeric(14),
        "Razão Social": faker.company.name(),
        descrição: faker.company.catchPhrase(),
        endereço: {
          rua: faker.location.street(),
          bairro: faker.location.city(),
          cidade: faker.location.city(),
          estado: faker.location.state(),
          uf: faker.location.countryCode(),
          cep: faker.location.zipCode(),
        },
        setor: faker.helpers.arrayElement([
          "tecnologia",
          "consultoria",
          "alimenticio",
          "calçados e têxtil",
          "financeiro",
          "educação",
        ]),
      });
    }

    const result = await collection.insertMany(fakeCompanies);
    console.log(`${result.insertedCount} fake companies inserted.`);
  } catch (error) {
    console.error("Error populating database:", error);
  } finally {
    await client.close();
  }
}

async function createVagasForEmpresas() {
  try {
    await client.connect();
    const db = client.db("gdi-project"); // Replace with your database name
    const empresasCollection = db.collection("empresas");
    const vagasCollection = db.collection("vagas");

    const allCompanies = await empresasCollection.find().toArray();
    const lastVaga = await vagasCollection
      .find()
      .sort({ _id: -1 })
      .limit(1)
      .toArray();
    let nextId = lastVaga.length > 0 ? lastVaga[0]._id + 1 : 1;
    let fakeVagas = [];

    for (const company of allCompanies) {
      const hasVagas = await vagasCollection.findOne({
        empresa_id: company._id,
      });
      if (!hasVagas) {
        for (let i = 0; i < 2; i++) {
          fakeVagas.push({
            _id: nextId++,
            titulo: faker.person.jobTitle(),
            descrição: faker.lorem.sentences(3),
            empresa_id: company._id,
            beneficios: faker.helpers.arrayElements(
              [
                "Plano de saúde e odontológico",
                "Vale alimentação ou refeição",
                "Horário flexível",
                "Opção de trabalho remoto ou híbrido",
                "Auxílio para cursos e certificações",
                "Ambiente colaborativo e inovador",
              ],
              4
            ),
            requisitos: faker.helpers.arrayElements(
              [
                "Experiência prévia na área",
                "Conhecimento técnico relevante",
                "Habilidades de comunicação",
                "Capacidade de trabalho em equipe",
                "Familiaridade com ferramentas e softwares específicos",
                "Disponibilidade para horários flexíveis",
              ],
              5
            ),
            tipo: faker.helpers.arrayElement(["CLT", "PJ", "Freelancer"]),
            salário: faker.number.int({
              min: 2000,
              max: 10000,
              precision: 0.01,
            }),
            localização: company.endereço.cidade,
            data_publicação: faker.date.recent(),
          });
        }
      }
    }

    if (fakeVagas.length > 0) {
      const vagasResult = await vagasCollection.insertMany(fakeVagas);
      console.log(`${vagasResult.insertedCount} fake vagas inserted.`);
    } else {
      console.log("No new fake vagas were needed.");
    }
  } catch (error) {
    console.error("Error creating job vacancies:", error);
  } finally {
    await client.close();
  }
}

async function createCandidatos() {
  try {
    await client.connect();
    const db = client.db("gdi-project"); // Replace with your database name
    const candidatosCollection = db.collection("candidatos");

    let candidatos = [];

    const lastCandidato = await db
      .collection("candidatos")
      .find()
      .sort({ _id: -1 })
      .limit(1)
      .toArray();
    let nextId = lastCandidato.length > 0 ? lastCandidato[0]._id + 1 : 1;
    // Create 5 fake candidatos
    for (let i = 0; i < 50; i++) {
      candidatos.push({
        _id: nextId + i + 1,
        nome: faker.person.fullName(),
        email: faker.internet.email(),
        telefone: faker.phone.number(),
        curriculo: `Curriculo ${faker.person.fullName()}.pdf`,
        habilidades: [
          faker.word.adjective(),
          faker.word.adjective(),
          faker.word.adjective(),
          faker.word.adjective(),
          faker.word.adjective(),
        ],
        experiência: [
          {
            empresa: faker.company.name(),
            cargo: faker.person.jobTitle,
            inicio: faker.date.past().toISOString().split("T")[0],
            fim: faker.date.future().toISOString().split("T")[0],
          },
          {
            empresa: faker.company.name(),
            cargo: faker.person.jobTitle(),
            inicio: faker.date.past().toISOString().split("T")[0],
            fim: faker.date.future().toISOString().split("T")[0],
          },
        ],
        formação: [
          {
            instituição: faker.company.name(),
            curso: faker.person.jobType(),
            tipo: faker.helpers.arrayElement([
              "Bacharelado",
              "Mestrado",
              "Tecnólogo",
            ]),
            "data de conclusão": faker.date
              .future()
              .toISOString()
              .split("T")[0],
          },
        ],
        categoria: faker.helpers.arrayElement([
          "Tecnologia",
          "Engenharia",
          "Cozinha",
        ]),
      });
    }

    const result = await candidatosCollection.insertMany(candidatos);
    console.log(`${result.insertedCount} fake candidatos inserted.`);
  } catch (error) {
    console.error("Error creating candidatos:", error);
  } finally {
    await client.close();
  }
}

// Call the function
createCandidatos();
