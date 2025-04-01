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
    const viitra = await db.collection("empresas").findOne({ "Razão Social": "Viitra inovações" });
    const neurotech = await db.collection("empresas").findOne({ "Razão Social": "Neurotech" });
    const alpargatas = await db.collection("empresas").findOne({ "Razão Social": "Alpargatas" });
    const trackingTrade = await db.collection("empresas").findOne({ "Razão Social": "Tracking trade" });
    const mauriceia = await db.collection("empresas").findOne({ "Razão Social": "Mauriceia Alimentos" });
    const colombo = await db.collection("empresas").findOne({ "Razão Social": "Confeitaria Colombo" });

    // Drop the existing vagas collection
    await db.collection("vagas").drop().catch(err => {
      // Ignore error if collection doesn't exist
      if (err.code !== 26) throw err;
    });

    // Now insert the vagas with references to the companies
    await db.collection("vagas").insertMany([
      {
        _id: 1,
        titulo: "Desenvolvimento frontend",
        descrição: "Estamos em busca de um Desenvolvedor Frontend apaixonado por tecnologia e inovação para se juntar ao nosso time! Se você tem experiência com desenvolvimento de interfaces modernas, foco em usabilidade e performance, e gosta de trabalhar em equipe, essa vaga é para você!",
        empresa_id: viitra ? viitra._id : null,
        beneficios: [
          "Plano de saúde e odontológico",
          "Vale alimentação ou refeição",
          "Horário flexível",
          "Opção de trabalho remoto ou híbrido",
          "Auxílio para cursos e certificações",
          "Ambiente colaborativo e inovador"
        ],
        requisitos: [
          "Experiência com HTML, CSS e JavaScript",
          "Conhecimento avançado em React.js ou Vue.js",
          "Familiaridade com ferramentas de versionamento como Git",
          "Experiência com consumo de APIs REST e GraphQL",
          "Boas práticas de UI/UX",
          "Capacidade de trabalhar em equipe e boa comunicação",
          "Diferencial: experiência com Tailwind CSS e TypeScript"
        ],
        tipo: "CLT",
        salário: 4000.00,
        localização: "Recife",
        data_publicação: new Date("2025-04-01")
      },
      {
        _id: 2,
        titulo: "Cientista de Dados",
        descrição: "Estamos em busca de um Cientista de Dados talentoso para integrar nosso time! Se você tem paixão por análise de dados, modelagem preditiva e deseja trabalhar com grandes volumes de informação para gerar insights estratégicos, essa vaga é para você!",
        empresa_id: neurotech ? neurotech._id : null,
        beneficios: [
          "Plano de saúde e odontológico",
          "Vale alimentação ou refeição",
          "Horário flexível",
          "Opção de trabalho remoto ou híbrido",
          "Auxílio para cursos e certificações",
          "Ambiente colaborativo e inovador"
        ],
        requisitos: [
          "Experiência com Python e bibliotecas como Pandas, NumPy e Scikit-learn",
          "Conhecimento em SQL e manipulação de bancos de dados",
          "Experiência com Machine Learning e modelos preditivos",
          "Familiaridade com ferramentas de visualização de dados",
          "Conhecimento em engenharia de dados e ETL",
          "Diferencial: experiência com Big Data e frameworks como Spark"
        ],
        tipo: "PJ",
        salário: 6500.00,
        localização: "Recife",
        data_publicação: new Date("2025-03-20")
      },
      {
        _id: 3,
        titulo: "Auxiliar de Serviços Gerais",
        descrição: "Estamos em busca de um Auxiliar de Serviços Gerais para atuar na limpeza e organização de nosso ambiente de trabalho. Se você é proativo, comprometido e gosta de trabalhar em equipe, essa vaga é para você!",
        empresa_id: alpargatas ? alpargatas._id : null,
        beneficios: [
          "Vale transporte",
          "Vale alimentação ou refeição",
          "Plano de saúde",
          "Seguro de vida",
          "Ambiente de trabalho organizado e acolhedor"
        ],
        requisitos: [
          "Experiência prévia na função (desejável)",
          "Conhecimento básico em produtos e equipamentos de limpeza",
          "Comprometimento com a organização e higiene do ambiente",
          "Boa disposição física",
          "Pontualidade e responsabilidade"
        ],
        tipo: "CLT",
        salário: 2000.00,
        localização: "Carpina",
        data_publicação: new Date("2025-03-25")
      },
      {
        _id: 4,
        titulo: "Engenheiro de Software",
        descrição: "Estamos em busca de um Engenheiro de Software talentoso para integrar nosso time! Se você tem experiência no desenvolvimento de software escalável, arquitetura de sistemas e boas práticas de engenharia, essa vaga é para você!",
        empresa_id: trackingTrade ? trackingTrade._id : null,
        beneficios: [
          "Plano de saúde e odontológico",
          "Vale alimentação ou refeição",
          "Horário flexível",
          "Opção de trabalho remoto ou híbrido",
          "Auxílio para cursos e certificações",
          "Ambiente colaborativo e inovador"
        ],
        requisitos: [
          "Experiência com linguagens como Java, Python ou JavaScript",
          "Conhecimento em arquitetura de software e design patterns",
          "Experiência com bancos de dados relacionais e NoSQL",
          "Familiaridade com desenvolvimento de APIs REST e GraphQL",
          "Conhecimento em práticas ágeis (Scrum, Kanban)",
          "Experiência com ferramentas de CI/CD"
        ],
        tipo: "CLT",
        salário: 5000.00,
        localização: "São Paulo",
        data_publicação: new Date("2025-03-25")
      },
      {
        _id: 5,
        titulo: "Cozinheiro(a)",
        descrição: "Estamos em busca de uma Cozinheira dedicada para integrar nossa equipe. A pessoa selecionada será responsável pela preparação de pratos com qualidade, seguindo as normas de higiene e segurança alimentar.",
        empresa_id: mauriceia ? mauriceia._id : null,
        beneficios: [
          "Salário competitivo",
          "Vale alimentação",
          "Vale transporte",
          "Assistência médica e odontológica",
          "Seguro de vida",
          "Possibilidade de crescimento profissional"
        ],
        requisitos: [
          "Experiência prévia como cozinheira",
          "Conhecimento das normas de higiene e segurança alimentar",
          "Capacidade de trabalhar em equipe e sob pressão",
          "Comprometimento e responsabilidade",
          "Disponibilidade para trabalhar em turnos ou horários flexíveis"
        ],
        tipo: "CLT",
        salário: 3200.00,
        localização: "Recife",
        data_publicação: new Date("2025-03-25")
      },
      {
        _id: 6,
        titulo: "Motorista de Carga Viva",
        descrição: "Estamos em busca de um Motorista de Carga Viva para atuar no transporte de animais vivos de forma segura e responsável.",
        empresa_id: colombo ? colombo._id : null,
        beneficios: [
          "Salário competitivo",
          "Vale alimentação",
          "Vale transporte",
          "Assistência médica e odontológica",
          "Seguro de vida",
          "Possibilidade de crescimento profissional"
        ],
        requisitos: [
          "CNH categoria D ou E",
          "Experiência com transporte de carga viva",
          "Conhecimento das normas de transporte de animais",
          "Disponibilidade para viagens",
          "Comprometimento com o bem-estar animal"
        ],
        tipo: "CLT",
        salário: 3200.00,
        localização: "Recife",
        data_publicação: new Date("2025-03-25")
      }
    ]);

    console.log("Vagas inseridas com sucesso!");
    
    // List all collections to verify
    const collections = await db.listCollections().toArray();
    console.log("Available collections:", collections.map(c => c.name));

  } catch (error) {
    console.error("Error:", error);
  } finally {
    await client.close();
  }
}

run().catch(console.dir);
