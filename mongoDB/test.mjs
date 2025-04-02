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

    const result = await db
      .collection("vagas")
      .aggregate([
        {
          $lookup: {
            from: "empresas",
            localField: "empresa_id",
            foreignField: "_id",
            as: "empresa_info",
          },
        },
        { $unwind: "$empresa_info" },
        {
          $group: {
            _id: "$empresa_info.Razão Social",
            total_vagas: { $sum: 1 },
            média_salarial: { $avg: "$salário" },
            menor_salário: { $min: "$salário" },
            maior_salário: { $max: "$salário" },
          },
        },
        { $sort: { total_vagas: -1 } },
      ])
      .toArray();

    console.log("Vagas:", result);

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
