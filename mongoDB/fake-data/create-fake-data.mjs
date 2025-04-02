import { MongoClient } from "mongodb";
import * as dotenv from "dotenv";
import { faker } from "@faker-js/faker";
dotenv.config();

const DATABASE_URL = process.env.DATABASE_URL;
if (!DATABASE_URL) {
  throw new Error("Please define DATABASE_URL in .env file");
}

const client = new MongoClient(DATABASE_URL);

async function populateVagas() {
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

populateDatabase();
