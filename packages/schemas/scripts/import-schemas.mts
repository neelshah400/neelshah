import { importJsonSchema, type ImportJsonSchemaJob } from "./schema-io.mts";

const importJsonSchemaJobs: ImportJsonSchemaJob[] = [
  {
    input: "https://raw.githubusercontent.com/reorx/jsoncv/master/schema/jsoncv.schema.json",
    name: "JsonCv",
    output: "./generated/jsoncv.ts",
  },
];

for (const job of importJsonSchemaJobs) {
  await importJsonSchema(job);
}
