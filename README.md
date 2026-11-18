# jackson-d-taylor.github.io

Personal research site for Jackson D. Taylor — pulsar timing, nanohertz
gravitational waves, dynamics. Built so that adding a paper means adding one
file.

## Stack

Astro, static output. TypeScript. Plain CSS, no framework. Fonts are
self-hosted from `public/fonts/`, so the site makes no third-party requests.
Deployed to GitHub Pages by the workflow in `.github/workflows/deploy.yml`.

## Running it

Node and npm came from Homebrew and live in `/opt/homebrew/bin`. If a shell
can't find `npm`, that's the reason:

```sh
export PATH="/opt/homebrew/bin:$PATH"

npm install      # first time, or after dependencies change
npm run dev      # http://localhost:4321
npm run check    # type and content-schema errors
npm run build    # production build into dist/
```

Run `npm run check` and `npm run build` before pushing. Dev mode is more
forgiving than the real build.

## Layout

```
src/
  content/publications/   one Markdown file per paper — filename is the URL
  content.config.ts       the schema every publication file is checked against
  data/site.yaml          name, links, affiliation, education, awards, CV data
  pages/                  routes
  layouts/                page shells
  components/             shared pieces, including the paper explainers
  styles/                 global.css and the design tokens
public/
  figures/<slug>/         web-optimised figures, approved one at a time
  fonts/                  self-hosted woff2
templates/                blank content files to copy
scripts/                  figure conversion
source_material/          private reference material — gitignored, never published
.claude/commands/         slash commands: /add-publication and friends
```

## URLs

`/`, `/research/`, `/publications/`, `/publications/<slug>/`, `/cv/`, `/board-game/`, `/3d-printing/`, `/404`.

A publication's filename is its URL. Renaming the file breaks any link anyone
has to that page, so don't — add a redirect instead.

## Where to look next

- **[ADDING_CONTENT.md](ADDING_CONTENT.md)** — adding a paper, what each
  frontmatter field means, how the plain-language summaries and figures get
  approved.
- **[DEPLOYING.md](DEPLOYING.md)** — GitHub Pages setup, custom domain, DNS,
  HTTPS.
