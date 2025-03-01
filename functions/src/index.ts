const functions = require("firebase-functions");
const { Storage } = require("@google-cloud/storage");
const { BigQuery } = require("@google-cloud/bigquery");

const storage = new Storage();
const bigquery = new BigQuery();

const BUCKET_NAME = "big-query-test-uni.appspot.com";
const DATASET_NAME = "sales_data";
const TABLE_NAME = "sales_records";

exports.uploadToBigQuery = functions.https.onRequest(async (req: any, res: any) => {
  try {
    const fileName: string = req.query.fileName;
    if (!fileName) {
      return res.status(400).send("Missing fileName parameter");
    }

    const file = storage.bucket(BUCKET_NAME).file(fileName);

    await bigquery.dataset(DATASET_NAME).table(TABLE_NAME).load(file, {
      sourceFormat: "CSV",
      autodetect: true,
    });

    res.status(200).send("File uploaded to BigQuery successfully");
  } catch (error) {
    console.error(error);
    res.status(500).send("Error uploading file to BigQuery");
  }
});

exports.queryBigQuery = functions.https.onRequest(async (req: any, res: any): Promise<void> => {
  try {
    const query = `SELECT * FROM \`${bigquery.projectId}.${DATASET_NAME}.${TABLE_NAME}\` LIMIT 100`;
    const [rows] = await bigquery.query(query);

    res.status(200).json(rows);
  } catch (error) {
    console.error(error);
    res.status(500).send("Error querying BigQuery");
  }
});
