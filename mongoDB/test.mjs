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

    // List all collections to verify

    const result = await db.collection("vagas").distinct("titulo");

    console.log("result:", result);

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
