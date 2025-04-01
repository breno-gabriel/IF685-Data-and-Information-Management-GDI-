import { MongoClient, ObjectId } from "mongodb";
import * as dotenv from "dotenv";
dotenv.config();

const DATABASE_URL = process.env.DATABASE_URL;
if (!DATABASE_URL) {
  throw new Error("Please define DATABASE_URL in .env file");
}

const client = new MongoClient(DATABASE_URL);

async function run() {
  try {
    await client.connect();
    console.log("Successfully connected to MongoDB Atlas!");

    const db = client.db("gdi-project");

    // First, let's get the company IDs
    const viitra = await db
      .collection("empresas")
      .findOne({ "Razão Social": "Viitra inovações" });
    const neurotech = await db
      .collection("empresas")
      .findOne({ "Razão Social": "Neurotech" });
    const alpargatas = await db
      .collection("empresas")
      .findOne({ "Razão Social": "Alpargatas" });
    const trackingTrade = await db
      .collection("empresas")
      .findOne({ "Razão Social": "Tracking trade" });
    const mauriceia = await db
      .collection("empresas")
      .findOne({ "Razão Social": "Mauriceia Alimentos" });
    const colombo = await db
      .collection("empresas")
      .findOne({ "Razão Social": "Confeitaria Colombo" });

    // Drop the existing vagas collection
    await db
      .collection("vagas")
      .drop()
      .catch((err) => {
        // Ignore error if collection doesn't exist
        if (err.code !== 26) throw err;
      });

    // List all collections to verify
    const collections = await db.listCollections().toArray();
    console.log(
      "Available collections:",
      collections.map((c) => c.name)
    );
  } catch (error) {
    console.error("Error:", error);
  } finally {
    await client.close();
  }
}

run().catch(console.dir);
