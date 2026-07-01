import { z } from "zod";

import { JsonCv } from "../generated/jsoncv.ts";

const baseEducationSchema = JsonCv.shape.education.unwrap();
const baseEducationEntrySchema = baseEducationSchema.element;

const educationEntrySchema = baseEducationEntrySchema.safeExtend({
  location: z.string().describe("e.g. College Park, MD").optional(),
  highlights: z
    .array(z.string().describe("e.g. Dean's List"))
    .describe("Specify multiple accomplishments")
    .optional(),
});

export const Resume = JsonCv.safeExtend({
  education: z.array(educationEntrySchema).optional(),
});

export type Resume = z.infer<typeof Resume>;
