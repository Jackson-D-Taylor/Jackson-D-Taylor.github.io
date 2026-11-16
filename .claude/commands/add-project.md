---
description: Add a project — explains that projects are folded into the paper pages
argument-hint: project name and a sentence about it
---

The project Jackson wants to add:

$ARGUMENTS

## Say this first, before doing anything

This site has no `/projects/` section. Projects were folded into the paper pages when the site was built — a project that produced a paper is described on that paper's page, which keeps one subject in one place.

Then offer him the two options, in this order, and wait for an answer.

### Option A — put it on the paper page it belongs to

Ask which paper this project goes with. The files are in `src/content/publications/`. The project's description belongs in that file's body (below the frontmatter, after the abstract) or in the `lay` block, depending on what he's trying to say:

- Background, how it started, what the code does, where it lives: the body.
- Something a non-specialist needs in order to follow the paper: the `lay` block, which means setting `lay.reviewed: false` again so he re-reads it before it goes public.

Software with its own repository can also be linked from the body. Don't add a new frontmatter field for it — the schema in `src/content.config.ts` is fixed and a new field there is a change he has to approve.

If the project has no paper, say so plainly: there's currently nowhere on the site for it, and that's Option B.

### Option B — build a projects section

This is a bigger change and he should decide, not you. If he wants it, it means:

1. A `projects` collection in `src/content.config.ts`, with its own schema.
2. A `templates/project.md` blank file matching that schema.
3. An index page at `src/pages/projects/index.astro`, plus a page per project — which adds live URLs at `/projects/` and `/projects/<slug>/` that then have to stay stable.
4. A nav entry in the site layout.
5. A section in `ADDING_CONTENT.md` describing all of it.
6. A decision about what happens to the project material already sitting on the paper pages.

Lay that out, ask whether he wants it, and only start once he says yes. Don't create an empty collection "ready for later".

## Either way

- Don't write claims about what a project did that he hasn't made himself. If you need a detail, ask.
- Don't rewrite his descriptions. Suggest edits instead.
- After any change: `export PATH="/opt/homebrew/bin:$PATH" && cd /Users/jackson/Desktop/Website && npm run check && npm run build`, and report what actually happened.
- Don't commit or push.
