import { mkdir, writeFile } from "node:fs/promises";
import { createRequire } from "node:module";
import path from "node:path";
import { fileURLToPath, pathToFileURL } from "node:url";

import { jsonSchemaToZod } from "json-schema-to-zod";
import * as z from "zod";

const require = createRequire(import.meta.url);

type JsonRefsModule = {
  resolveRefsAt(input: string): Promise<{ resolved: object }>;
};

const JsonRefs = require("json-refs") as JsonRefsModule;

const thisDir = path.dirname(fileURLToPath(import.meta.url));
const packageDir = path.resolve(thisDir, "..");

export type ImportJsonSchemaJob = {
  input: string;
  name: string;
  output: string;
};

export type ExportJsonSchemaJob = {
  input: string;
  name: string;
  output: string;
  target?: "draft-04" | "draft-07" | "draft-2020-12" | "openapi-3.0";
};

export async function importJsonSchema({
  input,
  name,
  output,
}: ImportJsonSchemaJob): Promise<void> {
  const { resolved: inputJsonSchema } = await JsonRefs.resolveRefsAt(input);

  const outputTypeScriptModule = jsonSchemaToZod(inputJsonSchema, {
    module: "esm",
    name,
    type: true,
    zodVersion: 4,
  });

  const outputPath = path.resolve(packageDir, output);
  await mkdir(path.dirname(outputPath), { recursive: true });
  await writeFile(outputPath, `${outputTypeScriptModule}\n`, "utf8");

  console.log(`Imported ${path.relative(packageDir, outputPath)}`);
}

export async function exportJsonSchema({
  input,
  name,
  output,
  target = "draft-07",
}: ExportJsonSchemaJob): Promise<void> {
  const inputPath = path.resolve(packageDir, input);
  const inputTypeScriptModule = (await import(pathToFileURL(inputPath).href)) as Record<
    string,
    z.ZodType
  >;
  const inputZodSchema = inputTypeScriptModule[name];
  if (!inputZodSchema) {
    throw new Error(`Export "${name}" not found in ${path.relative(packageDir, inputPath)}`);
  }

  const outputJsonSchema = z.toJSONSchema(inputZodSchema, { target });

  const outputPath = path.resolve(packageDir, output);
  await mkdir(path.dirname(outputPath), { recursive: true });
  await writeFile(outputPath, `${JSON.stringify(outputJsonSchema, null, 2)}\n`, "utf8");

  console.log(`Exported ${path.relative(packageDir, outputPath)}`);
}
