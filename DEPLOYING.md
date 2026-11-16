# Deploying

The site is a GitHub Pages **user site**: the repo is
`https://github.com/Jackson-D-Taylor/Jackson-D-Taylor.github.io`, it's public,
and it's served from the root of `jackson-d-taylor.github.io`. That's why
`astro.config.mjs` sets `site` but no `base` — a `base` on a user site breaks
every stylesheet and internal link.

Part 1 gets the site live. Part 2 is the custom domain, bought from
Cloudflare on 2026-11-16.

---

# Part 1 — GitHub Pages

## One-time setup

In the repo on github.com:

**Settings → Pages → Build and deployment → Source → GitHub Actions.**

Do this before the first push. The default source is "Deploy from a branch",
and with that selected the workflow builds correctly and then fails at the
deploy step with a permissions error that doesn't say what's actually wrong.

## Pushing

```sh
git push origin main
```

That's the whole deploy. `.github/workflows/deploy.yml` runs on every push to
`main`, builds the site, and publishes it. There's also a manual trigger —
Actions tab → "Deploy to GitHub Pages" → "Run workflow" — for re-running a
deploy without making a commit.

A build takes a minute or two. Watch it on the Actions tab; a red X there is
the first place to look when a change doesn't show up. If two pushes land
close together the workflow cancels the older run, so the newer build always
wins.

The site is then at **https://jackson-d-taylor.github.io**.

---

# Part 2 — A custom domain

Optional. Everything above keeps working without it.

## Buying one

Two things to compare, and only one of them is printed large:

- **Renewal price, not first-year price.** `.space` and similar novelty TLDs
  are often around $2 for the first year and around $26 every year after.
  `.com` is around $12 and stays around $12. Over a career the cheap one costs
  several times more.
- Registrars that don't charge extra for WHOIS privacy or for DNS hosting.
  Cloudflare Registrar and Namecheap are both fine. Avoid anything that
  bundles a "website builder" trial.

Prices move; check them rather than trusting this paragraph.

The domain is `jacksondtaylorastro.com`.

## Step 1 — tell GitHub first

**Settings → Pages → Custom domain → enter `jacksondtaylorastro.com` → Save.**

Do this *before* pointing DNS at GitHub. The domain is then claimed by your
repository, so there's no window where your DNS points at GitHub Pages and no
repo owns the name — which is the window someone else can step into.

GitHub will show a DNS check error straight away. That's expected; DNS doesn't
exist yet. Carry on.

## Step 2 — DNS records

At the registrar (or wherever the domain's nameservers point), add these.

**Apex — four A records**, all on `@`:

```
185.199.108.153
185.199.109.153
185.199.110.153
185.199.111.153
```

**Apex — four AAAA records**, also on `@`:

```
2606:50c0:8000::153
2606:50c0:8001::153
2606:50c0:8002::153
2606:50c0:8003::153
```

**www — one CNAME record:**

```
www  →  jackson-d-taylor.github.io
```

Note the trailing form your registrar expects; some want
`jackson-d-taylor.github.io.` with the dot.

### Delete the registrar's own records on `@`

This is the single most common reason a certificate never issues. Registrars
add their own records to a fresh domain — a parking page A record, a
"forwarding" or "URL redirect" record, sometimes an ALIAS to their own
servers. They sit on `@` alongside yours, and GitHub's DNS check sees an
address that isn't theirs and stops.

Look at the full record list and remove anything on `@` that isn't one of the
eight addresses above.

### If you're on Cloudflare

Every one of those nine records must be **DNS only** — the grey cloud, not the
orange one.

Proxied (orange) records hide the real DNS answer behind Cloudflare's own
addresses. GitHub then can't verify the domain, so the certificate never
issues, and the site sits on a TLS error indefinitely with nothing in the
GitHub UI explaining why. Click each orange cloud until it goes grey.

You can turn the proxy back on later, but there's no reason to.

## Step 3 — verify the domain on your account

This is separate from the repo setting, and it's what stops someone else
attaching your domain to their repository if you ever delete this one.

**github.com → your profile Settings (not the repo's) → Pages → Add a domain.**

GitHub gives you a TXT record to add:

```
name:   _github-pages-challenge-jackson-d-taylor
value:  (the token GitHub shows you)
```

Add it at the registrar, then click Verify. Copy the name and token from the
GitHub page rather than from here — the token is unique and GitHub's spelling
of the name is authoritative.

## Step 4 — wait, then turn on HTTPS

Once DNS has propagated, GitHub issues a Let's Encrypt certificate. The UI
says it can take up to 24 hours; it's usually minutes.

When **Settings → Pages** stops warning and the "Enforce HTTPS" checkbox
becomes available, tick it. Every `http://` request then redirects to
`https://`.

If it's still unavailable after an hour, re-check in this order: proxied
Cloudflare records, leftover parking records on `@`, a typo in one of the
eight IP addresses.

## Step 5 — update the repo

Two files, and the site is wrong in subtle ways until both are changed.

Both files are already done, as of 2026-11-16. This step is here for the next
time the domain changes.

**`astro.config.mjs`** — `site` is used for canonical URLs, the sitemap and
link previews. It now reads:

```js
site: 'https://jacksondtaylorastro.com',
```

Leave `base` alone. There still shouldn't be one.

**`public/CNAME`** — one line, the bare domain, nothing else, no comment:

```
jacksondtaylorastro.com
```

Not `https://`, not `www.`, no trailing slash. It has to match exactly what is
in Settings → Pages. Note that this site deploys through GitHub Actions, and
Pages does not read this file in that mode. The domain has to be typed into
Settings → Pages → Custom domain by hand. The file is kept as a record of
the domain.

If you ever change the domain, change it in both files and in Settings → Pages.
Two out of three leaves the site broken in ways that are hard to spot.

## Step 6 — check it

```sh
dig +short jacksondtaylorastro.com A
dig +short jacksondtaylorastro.com AAAA
dig +short www.jacksondtaylorastro.com CNAME
dig +short TXT _github-pages-challenge-jackson-d-taylor.jacksondtaylorastro.com
```

Expected: the four GitHub IPv4 addresses; the four IPv6 ones; the CNAME
answering `jackson-d-taylor.github.io.`; and the verification token.

If an A record query returns something else, that's a leftover parking record
or a proxied Cloudflare record. If it returns nothing, DNS hasn't propagated —
give it an hour.

Then load the site over `https://` and check that a `http://` address
redirects.

## What happens to the old address

`jackson-d-taylor.github.io` keeps working and redirects to the custom domain
once it's attached. Old links don't break, and anything already indexed under
the github.io address follows the redirect.

---

## When a deploy goes wrong

| Symptom | Usually |
|---|---|
| Workflow fails at the deploy step | Pages source isn't set to GitHub Actions |
| Workflow fails at the build step | A real build error; it fails the same way locally with `npm run build` |
| Site builds but a page 404s | A content file was renamed, or a page's URL changed |
| CSS missing, links point at the wrong place | A `base` got added to `astro.config.mjs` |
| Certificate never issues | Proxied Cloudflare records, or a parking record on `@` |
| Change pushed but site unchanged | Check the Actions tab; also hard-reload, Pages caches hard |
