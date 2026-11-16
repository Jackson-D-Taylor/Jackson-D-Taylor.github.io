---
# ---------------------------------------------------------------------------
# Blank publication file. Copy it, don't edit it in place:
#
#   cp templates/publication.md src/content/publications/<slug>.md
#
# THE FILENAME IS THE URL. src/content/publications/exotrojans.md is served at
# /publications/exotrojans/. Renaming the file later breaks that link wherever
# it has been shared, so pick the name once and keep it. Short, readable, no
# year, no volume number, no author names: "exotrojans", "redback-j2053",
# "algorithmic-pulsar-timer".
#
# Fields marked REQUIRED must be filled in or the build fails with a message
# naming the file and the field. Fields marked OPTIONAL can be deleted
# outright if they don't apply.
#
# Every fact below comes off the paper itself. If you can't find one, write
#   TODO: check the PDF
# and leave it — a TODO is a visible reminder, a guess isn't.
#
# The schema that enforces all of this is src/content.config.ts.
# Longer explanation of each field in ADDING_CONTENT.md.
# ---------------------------------------------------------------------------

# REQUIRED. Exactly as printed on the paper, including capitalisation.
# If the arXiv title differs from the journal title, the journal wins.
title: ""

# REQUIRED. Every author, in the order the paper prints them, "First Last".
# For a long list you can enter the first ten and set authorsTruncated below,
# but authorCount must still be the real total.
authors:
  - ""
  - ""

# REQUIRED. Jackson's place in that list, counting from 1.
authorPosition: 1

# REQUIRED. true only if Jackson is first author.
firstAuthor: false

# OPTIONAL (defaults to false). true when `authors` above holds a shortened
# list; the page then prints "and N others".
authorsTruncated: false

# REQUIRED. The real number of authors on the paper, even when the list above
# is shortened.
authorCount: 1

# REQUIRED. Journal name spelled out: "The Astrophysical Journal",
# "The Astrophysical Journal Letters", "Monthly Notices of the Royal
# Astronomical Society", "Astronomy & Astrophysics".
journal: ""

# OPTIONAL. Leave out for an advance article that hasn't been assigned one yet.
volume: ""

# OPTIONAL. The article ID: "128", "L6", "A166".
articleNumber: ""

# OPTIONAL. Page range, or the page count if that's all the paper gives.
pages: ""

# REQUIRED. Four digits. For an advance article, the year on the copyright line.
year: 2026

# OPTIONAL. The published date, when the paper prints one (YYYY-MM-DD).
# Received / revised / accepted dates are not this. Delete the line if the
# paper doesn't print a publication date.
published: 2026-01-01

# OPTIONAL. Shown in place of volume and pages when the paper isn't typeset
# yet, e.g. "Advance article". Delete once the real numbers arrive.
status: ""

# REQUIRED. DOI only, no https:// and no doi.org prefix.
doi: ""

# OPTIONAL, and only for preprints. Bare identifier, no "arXiv:" prefix.
# Published already? Leave this blank; the DOI is the link that matters.
arxiv: ""

# OPTIONAL. Only when the paper prints a collaboration under the author list,
# e.g. "NANOGrav". A collaboration thanked in the acknowledgements is not this.
collaboration: ""

# OPTIONAL. Two or three words for the publications index, e.g. "Pulsar timing".
topic: ""

# OPTIONAL (defaults to 0). Ordering within a year on the index page; higher
# sorts first. Leave at 0 unless two papers from one year come out backwards.
weight: 0

# OPTIONAL. Key into src/components/explainers/index.ts, when this paper has
# an interactive explainer. Leave it out otherwise.
explainer: ""

# ---------------------------------------------------------------------------
# Figures. An entry here means Jackson has approved that figure for the public
# site. There is no "approved: false" — if it isn't in this list it doesn't go
# up. An empty list is normal and the page handles it.
#
# Run scripts/convert-figures.sh to produce the web copies first; it writes
# them to public/figures/<slug>/. Originals stay in source_material/, which is
# gitignored and never published.
# ---------------------------------------------------------------------------
figures: []
# figures:
#   - src: "/figures/<slug>/<name>.webp"
#     # REQUIRED, max 600 chars. What the data show, for someone who can't see
#     # the image. "Scatter of residuals against orbital phase" — not "a plot".
#     alt: ""
#     # OPTIONAL, max 400 chars. Printed under the figure. This is new prose,
#     # so Jackson approves the wording.
#     caption: ""
#     # result | logo | animation. Default: result.
#     #   result    — numbered, captioned, links to the full-size version
#     #   logo      — never numbered, never captioned
#     #   animation — needs the `video` block below
#     kind: result
#     # OPTIONAL. Link to the full-resolution original.
#     full: "/figures/<slug>/<name>-full.webp"
#     # true for a working figure that isn't the peer-reviewed published
#     # version. Any true here puts the standing notice above the figures.
#     unpublished: true
#   - src: "/figures/<slug>/<name>-poster.webp"
#     alt: ""
#     kind: animation
#     video:
#       mp4: "/figures/<slug>/<name>.mp4"
#       webm: "/figures/<slug>/<name>.webm"
#       poster: "/figures/<slug>/<name>-poster.webp"
#     unpublished: true

# ---------------------------------------------------------------------------
# The plain-language one-pager.
#
# This is the only part of the file that isn't copied off the paper, and none
# of it appears on the site until `reviewed` is true. Write it for a curious
# person with no astronomy background: a relative, a journalist, an
# undergraduate deciding what to work on. No equations. No acronyms you
# haven't just defined.
#
# The character limits are what keep this to one printed sheet.
# ---------------------------------------------------------------------------
lay:
  # REQUIRED. The gate. Stays false until Jackson has read every sentence
  # below and agreed to it. Nothing in `lay` renders while this is false.
  reviewed: false

  # REQUIRED, max 220 chars. The whole paper in one sentence.
  hook: ""

  # OPTIONAL. One number worth staring at, set large. On a paper with no
  # figures this is the visual anchor of the page, so try to find one.
  keyNumber:
    value: "" # max 24 chars, e.g. "3.1 kJy", "49", "~1 M⊕"
    label: "" # max 140 chars — what the number is

  # REQUIRED, max 800 chars. What was actually done. Methods, in plain words.
  whatWeDid: ""

  # REQUIRED, max 800 chars. The result. If the answer was "nothing", say that
  # first and plainly — a non-detection is a result and shouldn't be dressed
  # up as a near-miss discovery.
  whatWeFound: ""

  # REQUIRED, max 600 chars. Why anyone outside the field should care. No
  # overclaiming; the honest version is more interesting anyway.
  whyItMatters: ""

  # REQUIRED, max 600 chars. An everyday comparison. Rendered in a labelled
  # box, so it reads as an analogy rather than a claim about the physics.
  analogy: ""

  # REQUIRED. Between 3 and 5 terms — fewer or more fails the build.
  # Define the words a non-astronomer would stumble on, not the ones you find
  # interesting.
  glossary:
    - term: "" # max 60 chars
      definition: "" # max 260 chars
    - term: ""
      definition: ""
    - term: ""
      definition: ""
---

The abstract goes here, below the `---`, copied word for word from the paper.
Don't tidy it, don't shorten it, don't fix its punctuation. Keep the unicode
characters the journal used (−, ⊙, χ², ∼) rather than swapping in ASCII.

If you want to add a note of your own underneath it — how the project started,
what you'd do differently — put it in its own paragraph. Most papers won't
need one.
