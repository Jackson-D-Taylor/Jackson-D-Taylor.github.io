import { defineCollection, z } from 'astro:content';
import { glob, file } from 'astro/loaders';

/* ------------------------------------------------------------------ *
 * Figures
 *
 * A figure appears in a paper's `figures` array ONLY if Jackson has
 * approved it for publication. There is deliberately no `approved: false`
 * state — absence IS the approval record, so there is no flag to forget
 * to check. An empty array is a fully supported state: two papers have
 * no figures at all, so that path is exercised on every build.
 * ------------------------------------------------------------------ */
const figure = z.object({
  /** Path under /public, e.g. "/figures/exotrojans/libration.webp" */
  src: z.string(),
  /** Required. Describes what the data show, not just what the image is. */
  alt: z.string().max(600),
  /** Shown beneath the figure. New prose — needs Jackson's approval. */
  caption: z.string().max(400).optional(),
  /**
   * 'result'   — a scientific figure: numbered, captioned, linkable at full size
   * 'logo'     — an identity mark: never numbered, never captioned
   * 'animation'— a video (supply `video`); poster frame shown until played
   */
  kind: z.enum(['result', 'logo', 'animation']).default('result'),
  /** Video sources for kind: 'animation'. */
  video: z
    .object({
      mp4: z.string(),
      webm: z.string().optional(),
      poster: z.string().optional(),
    })
    .optional(),
  /** Optional link to the full-resolution original. */
  full: z.string().optional(),
  /**
   * Marks a figure as working material rather than a published,
   * peer-reviewed figure. Papers with any such figure show a standing
   * notice above the figure section.
   */
  unpublished: z.boolean().default(false),
});

/* ------------------------------------------------------------------ *
 * Plain-language summary ("the one-pager")
 *
 * This is NEW prose, not Jackson's words. Nothing here renders publicly
 * until `reviewed` is set to true, per paper. The length caps are what
 * keep the printed version to a single sheet.
 * ------------------------------------------------------------------ */
const lay = z.object({
  /** Gate. Stays false until Jackson has read and approved every sentence. */
  reviewed: z.boolean().default(false),
  /** The whole paper in one sentence. */
  hook: z.string().max(300),
  /** One striking number, set large. Also the visual anchor when no figure exists. */
  keyNumber: z
    .object({ value: z.string().max(24), label: z.string().max(140) })
    .optional(),
  whatWeDid: z.string().max(900),
  whatWeFound: z.string().max(800),
  whyItMatters: z.string().max(600),
  /** Everyday comparison. Rendered in a labelled box so it reads as an analogy. */
  analogy: z.string().max(600),
  glossary: z
    .array(z.object({ term: z.string().max(60), definition: z.string().max(260) }))
    .min(3)
    .max(5),
});

/* ------------------------------------------------------------------ *
 * Publications — one file per paper. Filename = slug = URL.
 * Renaming a file changes a live URL, so don't.
 * ------------------------------------------------------------------ */
const publications = defineCollection({
  loader: glob({ pattern: '**/*.md', base: './src/content/publications' }),
  schema: z.object({
    title: z.string(),
    /** Exact author list, in exact order, copied from the paper. */
    authors: z.array(z.string()),
    /** 1-based position of Jackson in `authors`. */
    authorPosition: z.number().int().positive(),
    firstAuthor: z.boolean(),
    /** Set when the printed list is truncated, e.g. 53 authors shown as 10 + et al. */
    authorsTruncated: z.boolean().default(false),
    authorCount: z.number().int().positive(),
    journal: z.string(),
    /** Absent for advance articles that have no volume yet. */
    volume: z.string().optional(),
    articleNumber: z.string().optional(),
    pages: z.string().optional(),
    year: z.number().int(),
    /** Publication date where the paper prints one. */
    published: z.coerce.date().optional(),
    /** Shown instead of volume/pages when a paper is not yet typeset. */
    status: z.string().optional(),
    doi: z.string(),
    arxiv: z.string().optional(),
    collaboration: z.string().optional(),
    /** Short label for the index page, e.g. "Pulsar timing". */
    topic: z.string().optional(),
    /** Ordering on the index; higher sorts first within a year. */
    weight: z.number().default(0),
    /** Key into the explainer registry (src/components/explainers/index.ts). */
    explainer: z.string().optional(),
    figures: z.array(figure).default([]),
    lay,
  }),
});

/* ------------------------------------------------------------------ *
 * Site-wide data. Each top-level key in src/data/site.yaml is one entry.
 * ------------------------------------------------------------------ */
const site = defineCollection({
  loader: file('./src/data/site.yaml'),
  schema: z.record(z.string(), z.any()),
});

export const collections = { publications, site };
