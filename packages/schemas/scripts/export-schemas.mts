import { exportJsonSchema, type ExportJsonSchemaJob } from "./schema-io.mts";

const exportJsonSchemaJobs: ExportJsonSchemaJob[] = [
  {
    input: "./src/resume.ts",
    name: "Resume",
    output: "./dist/resume.schema.json",
    target: "draft-07",
  },
];

for (const job of exportJsonSchemaJobs) {
  await exportJsonSchema(job);
}
