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

    await db.collection("candidatos").updateOne(
      { _id: 1 }, // Filtra o candidato pelo ID
      { $addToSet: { habilidades: "Python" } }
    );

    const result = await db.collection("candidatos").findOne({ _id: 1 });

    console.log(result);
  } catch (error) {
    console.error("Error:", error);
  } finally {
    await client.close();
  }
}

run().catch(console.dir);
