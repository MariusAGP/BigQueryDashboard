import {CallableRequest, HttpsError} from 'firebase-functions/v2/https';

const { onCall } = require("firebase-functions/v2/https");
const { Storage } = require("@google-cloud/storage");
const { BigQuery } = require("@google-cloud/bigquery");

const storage = new Storage();
const bigquery = new BigQuery();

const BUCKET_NAME = "big-query-test-uni.firebasestorage.app";
const DATASET_NAME = "sales_data";
const TABLE_NAME = "sales_records";
const PROJECT_ID = "big-query-test-uni"

exports.uploadToBigQuery = onCall(
  {
    maxInstances: 2,
    region: "europe-west3", // Frankfurt
    enforceAppCheck: true, // Reject requests with missing or invalid App Check tokens.
  },
  async (request: CallableRequest) => {
    if (!request.auth) {
      throw new HttpsError("permission-denied", "Unauthorized");
    }

    const fileName: string = request.data.fileName;
    if (!fileName) {
      throw new HttpsError("invalid-argument", "Missing fileName parameter");
    }

    try {
      const file = storage.bucket(BUCKET_NAME).file(fileName);
      await bigquery.dataset(DATASET_NAME).table(TABLE_NAME).load(file, {
        sourceFormat: "CSV",
        autodetect: true,
      });

      return { message: "File uploaded to BigQuery successfully" };
    } catch (error) {
      console.error(error);
      throw new HttpsError("internal", "Error processing request");
    }
  }
);

exports.queryBigQuery = onCall(
  {
    maxInstances: 2,
    region: "europe-west3", // Frankfurt
    enforceAppCheck: true, // Reject requests with missing or invalid App Check tokens.
  },
  async (request: CallableRequest) => {
    if (!request.auth) {
      throw new HttpsError("permission-denied", "Unauthorized");
    }

    try {
      const query = `SELECT * FROM \`${PROJECT_ID}.${DATASET_NAME}.${TABLE_NAME}\` LIMIT 1000`;
      const [rows] = await bigquery.query(query);

      return rows;
    } catch (error) {
      console.error(error);
      throw new HttpsError("internal", "Error querying BigQuery");
    }
  }
);
