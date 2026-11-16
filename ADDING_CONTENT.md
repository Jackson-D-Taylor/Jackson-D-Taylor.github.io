# Adding content

Notes to self for when I've forgotten how this works.

The short version: **one paper is one file.** Everything else on the site —
the publications index, the paper's own page, the plain-language summary, the
figures — is generated from that file. There is no database and no admin
panel. Add a file, the page appears.

---

## Running the site locally

Node and npm came from Homebrew, so they live in `/opt/homebrew/bin`. If a
terminal says `command not found: npm`, that's why:

```sh
export PATH="/opt/homebrew/bin:$PATH"
cd ~/Desktop/Website
npm install        # only needed the first time, or after pulling new deps
npm run dev        # http://localhost:4321 — reloads as you save
```

Before pushing anything:

```sh
npm run check      # type and schema errors, with file and line
npm run build      # the real build; catches things dev mode lets slide
```

`npm run check` is what tells you a frontmatter field is missing or the wrong
type. Read its output — it names the file and the field.

---

## Adding a paper

### With the slash command

In Claude Code:

```
/add-publication ~/Desktop/Website/source_material/Papers/the-paper.pdf
```

or paste the title page and abstract after the command instead of a path. It
reads the paper, pulls out the metadata, asks about anything it can't find,
proposes a filename, writes the file, drafts the plain-language summary, and
runs the build.

It will not add figures on its own and it will not mark the summary reviewed.
Both of those are mine to do.

### By hand

```sh
cp templates/publication.md src/content/publications/my-slug.md
```

Then fill it in. The template has every field with a comment explaining it.
Fields I don't have a value for either come out of the file (if optional) or
get a `TODO:` (if required), never a guess.

### Picking the filename

**The filename is the URL.** `src/content/publications/exotrojans.md` is served
at `/publications/exotrojans/`. Nothing else determines the address.

Which means: once a page is live and someone has linked to it — a collaborator,
an email, a CV, a journal's "author's website" field — renaming that file
breaks their link. Silently. So pick the name once:

- short, lowercase, hyphenated
- something sayable out loud
- no year, no volume number, no author surname

The six already in use set the pattern: `algorithmic-pulsar-timer`,
`exotrojans`, `free-floating-objects`, `sporadic-radio-pulsar`,
`redback-j2053`, `terzan5-ten-pulsars`.

If a URL truly has to change later, add a redirect from the old one. Don't
just rename.

---

## What every field means

The schema lives in `src/content.config.ts`. It's the thing that rejects a
malformed file at build time, so it and the template have to stay in step: if
one changes, change the other and update this page too.

### The paper itself

| Field | Required | What it is |
|---|---|---|
| `title` | yes | Exactly as the journal prints it. If arXiv has a different title, the journal's wins. |
| `authors` | yes | The author list in printed order, `First Last`. Order is the thing people check; get it right. |
| `authorPosition` | yes | My place in that list, counting from 1. |
| `firstAuthor` | yes | `true` only when `authorPosition` is 1. |
| `authorsTruncated` | no | `true` when `authors` holds a shortened list. The page then prints "and N others". |
| `authorCount` | yes | The real total, even when the list above is shortened. |
| `journal` | yes | Spelled out, not abbreviated. |
| `volume` | no | Leave out when there isn't one yet. |
| `articleNumber` | no | `128`, `L6`, `A166`. |
| `pages` | no | Page range, or page count if that's all the paper gives. |
| `year` | yes | Four digits. For an advance article, the copyright-line year. |
| `published` | no | The publication date, `YYYY-MM-DD`, when the paper prints one. Received / revised / accepted dates are not this. |
| `status` | no | Shown instead of volume and pages for something not yet typeset, e.g. `Advance article`. Delete it once the real numbers exist. |
| `doi` | yes | Bare DOI. No `https://`, no `doi.org/`. |
| `arxiv` | no | Preprints only. Bare identifier, no `arXiv:` prefix. Once a paper is published, leave this blank — the DOI covers it. |
| `collaboration` | no | Only when a collaboration is printed under the author list. One thanked in the acknowledgements doesn't count. |
| `topic` | no | Two or three words for the index page, e.g. `Pulsar timing`. |
| `weight` | no | Ordering within a year on the index; higher sorts first. Defaults to 0 and usually stays there. |
| `explainer` | no | Key into `src/components/explainers/index.ts`, when a paper has an interactive explainer. |
| `explainerReviewed` | no | `false` by default. The interactive is hidden until this is `true` — same idea as `lay.reviewed`, below. |

The abstract goes in the body of the file, below the closing `---`. Verbatim,
with the journal's own characters (−, ⊙, ∼, χ²) left alone.

### `lay` — the plain-language summary

| Field | Required | Limit |
|---|---|---|
| `reviewed` | yes | `true` / `false` — see below |
| `hook` | yes | 220 characters. The whole paper in one sentence. |
| `keyNumber.value` | no | 24 characters |
| `keyNumber.label` | no | 140 characters |
| `whatWeDid` | yes | 800 characters |
| `whatWeFound` | yes | 800 characters |
| `whyItMatters` | yes | 600 characters |
| `analogy` | yes | 600 characters. Rendered in a labelled box so it reads as a comparison, not a claim. |
| `glossary` | yes | between 3 and 5 entries; `term` 60 characters, `definition` 260 |

The limits aren't arbitrary. They're what keeps the summary to a single printed
sheet, which is the whole point of it.

`keyNumber` is optional but worth finding, especially on a paper with no
figures — it's the only thing on that page that isn't a paragraph.

---

## The `lay.reviewed` gate

`lay.reviewed` starts `false` and **nothing in the `lay` block appears on the
site until it's `true`.**

The reason: everything else in a publication file is copied off the paper, so
it's either right or it's a typo. The plain-language summary is new prose
written *about* my work, and it's the part a journalist or a relative or a
prospective student will actually read. If it overstates a result, that's on
me, not on whoever drafted it.

So the gate is a hard one. A draft goes in with the flag left `false`.
I read every sentence. If a sentence is wrong, I fix it or cut it.
Then I set:

```yaml
lay:
  reviewed: true
```

Any time the summary is edited again, the flag goes back to `false` until I've
re-read it. The build never flips it — only I do.

The interactive explainer has its own switch, `explainerReviewed`, and works the
same way: hidden until I've played with it and set it to `true`. The two are
separate so a summary can go up before its interactive is ready, or the other
way round.

---

## Figures

### How a figure gets approved

Same idea as the summary, with the approval built into the data instead of a
flag. A figure appears on the site **only** if it's listed in that paper's
`figures` array. There is deliberately no `approved: false` state, so there's
no flag anyone can forget to check: if it isn't in the list, it isn't on the
site.

`figures: []` is a perfectly normal state. Several of the papers have none,
and their pages are built to look deliberate without them.

### Converting them

Originals live in `source_material/`, which never gets published. The web
copies go in `public/figures/<slug>/` and the conversion is done by:

```sh
scripts/convert-figures.sh
```

That script does the resizing, the WebP conversion, and the MP4/WebM pair plus
poster frame for anything animated. It needs ffmpeg, also from Homebrew, so
the same `export PATH="/opt/homebrew/bin:$PATH"` applies. Read the top of the
script for its arguments.

Then add an entry to `figures` pointing at the converted file:

```yaml
figures:
  - src: /figures/exotrojans/trojan-libration-poster.webp
    alt: Companion drifting back and forth around the Lagrange point over one libration cycle.
    kind: animation
    video:
      mp4: /figures/exotrojans/trojan-libration.mp4
      webm: /figures/exotrojans/trojan-libration.webm
      poster: /figures/exotrojans/trojan-libration-poster.webp
    unpublished: true
```

Field notes:

- `alt` is required and has to describe what the data show, not what the image
  is. "A plot" helps nobody.
- `kind` is `result` (numbered, captioned, links to full size), `logo` (never
  numbered or captioned) or `animation` (needs the `video` block).
- `caption` is new prose, so it's mine to approve like anything else.
- `unpublished: true` marks a working figure rather than the peer-reviewed
  published version. Any `true` on a page puts the standing notice above the
  figures explaining that.

---

## Why `source_material/` is gitignored

It's a couple of hundred megabytes of PDFs, raw figures and originals, and some
of it isn't mine to publish — unpublished figures, draft material, figures
whose copyright sits with the journal rather than with me.

So it stays on my laptop. It's listed in `.gitignore` and that line doesn't
come out. The only things that reach the repository are the converted copies
in `public/figures/`, which I've looked at one by one.

If I ever work on this from another machine, the site builds fine without
`source_material/` — it's reference material, not a build input.

---

## Site-wide information

Name, affiliation, links, education, awards, proposals, memberships, skills,
outreach and press all live in `src/data/site.yaml`. One file. The layouts read
from it; nothing is typed into a page template.

Editing the CV means editing that YAML. Keep each new entry in the same shape
as the ones around it — the layouts expect those field names.

---

## Things that aren't here

No `/talks/` section (talks are on the CV), no `/projects/` section (projects
are described on the paper they belong to), no news or blog. The
`/add-talk`, `/add-project` and `/add-news` commands exist anyway: each one
explains where the thing actually goes, and offers to build the missing
section if that's what I want. None of them will quietly create an empty
collection.

---

## Checklist for a new paper

1. `cp templates/publication.md src/content/publications/<slug>.md` — or run `/add-publication`.
2. Fill in the metadata off the paper. `TODO:` for anything missing.
3. Paste the abstract into the body, unedited.
4. Draft the `lay` block, leave `reviewed: false`.
5. Read the `lay` block properly. Fix what's wrong. Set `reviewed: true`.
6. Convert and add only the figures I'm happy to publish.
7. `npm run check && npm run build`.
8. `npm run dev` and look at the page.
9. Commit. Push. The site redeploys on its own — see DEPLOYING.md.
