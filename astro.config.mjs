// @ts-check
import { defineConfig } from 'astro/config';

export default defineConfig({
  // Custom domain, bought from Cloudflare on 2026-11-16. The same domain is in
  // public/CNAME and has to match GitHub Settings -> Pages -> Custom domain.
  // Changing it in one place and not the others breaks the site.
  site: 'https://jacksondtaylorastro.com',
  // No `base` is set on purpose. This repo is a GitHub *user site*
  // (Jackson-D-Taylor.github.io), so it is served from the root.
  // Adding a `base` here would break every stylesheet and internal link.
  trailingSlash: 'always',
  build: { format: 'directory' },
  devToolbar: { enabled: false },
});
