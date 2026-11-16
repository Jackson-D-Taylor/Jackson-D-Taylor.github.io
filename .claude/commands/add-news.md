---
description: Add a news item — explains that there is no news section yet
argument-hint: what happened, and the date
---

The news item Jackson wants to add:

$ARGUMENTS

## Say this first, before doing anything

This site has no news or blog section. Nothing was cut to make that true; it was never built, because a news feed that stops being updated reads worse than no news feed at all.

Then work through these, in this order, and wait for an answer.

### Option A — it already has a home somewhere

Most things that feel like news fit an existing part of the site:

| What it is | Where it goes |
|---|---|
| A paper came out | `/add-publication` |
| Someone wrote about his work | the `press:` list in `src/data/site.yaml` — append an item matching the existing entries (title, outlet, date, url) |
| An award, a grant, a fellowship | the `awards:` list in `src/data/site.yaml` |
| A talk | `/add-talk` |
| An accepted observing proposal | the `proposals:` list in `src/data/site.yaml` — but only completed proposals go public, so check with him first |
| Outreach, service, a summer school | the `outreach:` list in `src/data/site.yaml` |

Work out which one this is and offer it. Copy his wording for the item rather than writing your own.

### Option B — build a news section

Only if none of the above fits. This is a bigger change and he should decide, not you. If he wants it, it means:

1. A `news` collection in `src/content.config.ts`, with its own schema (date, title, body, optional link).
2. A `templates/news.md` blank file matching that schema.
3. Somewhere to show it: an index page at `src/pages/news/index.astro`, a block on the home page, or both. Either way `/news/` becomes a live URL that has to stay stable.
4. A nav entry in the site layout.
5. A section in `ADDING_CONTENT.md` describing all of it.

Say the obvious thing too: a news section is a standing commitment to post. If he isn't sure he'll keep it up, Option A is the better answer.

Lay it out, ask, and only start once he says yes. Don't create an empty collection "ready for later".

## Either way

- Don't invent dates, outlets or URLs. Missing detail gets a `TODO:` and a question.
- Nothing private goes up: unpublished work, student information, an observing proposal that hasn't run yet. Ask if you aren't certain.
- After any change: `export PATH="/opt/homebrew/bin:$PATH" && cd /Users/jackson/Desktop/Website && npm run check && npm run build`, and report what actually happened.
- Don't commit or push.
