---
description: Add a talk — explains that talks live on the CV, not in their own section
argument-hint: title, venue, date (or paste the details)
---

The talk Jackson wants to add:

$ARGUMENTS

## Say this first, before doing anything

This site has no `/talks/` section. Talks live on the CV page instead — that was a deliberate call when the site was built, not an oversight.

Then offer him the two options, in this order, and wait for an answer.

### Option A — put it on the CV (almost certainly what he wants)

The CV page at `/cv/` is built from `src/data/site.yaml`. Open that file and look for a `talks:` key alongside `awards:`, `proposals:` and `outreach:`.

- If it's there, append one item in the same shape the existing entries use. Match their field names exactly; don't introduce new ones.
- If it isn't there, say so, propose the shape of the entry (title, venue, location, date, and whether it was a contributed talk, invited talk or poster), and get his agreement before adding the key. Whoever renders the CV page has to know about it, so tell him the CV layout may need a matching change.

Copy the title, venue and date exactly as he gives them. Don't guess a date from a conference name, and don't infer whether a talk was invited.

### Option B — build a talks section

This is a bigger change and he should decide, not you. If he wants it, it means:

1. A `talks` collection in `src/content.config.ts`, with its own schema.
2. A `templates/talk.md` blank file matching that schema.
3. An index page at `src/pages/talks/index.astro`, which adds a live URL at `/talks/` that then has to stay stable.
4. A nav entry in the site layout.
5. A section in `ADDING_CONTENT.md` describing all of it.
6. Moving the talks off the CV, or accepting that they appear in two places.

Lay that out, ask whether he wants it, and only start once he says yes. Don't create an empty collection "ready for later" — an empty collection is a thing that can break a build for no benefit.

## Either way

- Don't invent a venue, a date, or whether a talk was invited. Missing detail gets a `TODO:` and a question.
- After any change: `export PATH="/opt/homebrew/bin:$PATH" && cd /Users/jackson/Desktop/Website && npm run check && npm run build`, and report what actually happened.
- Don't commit or push.
