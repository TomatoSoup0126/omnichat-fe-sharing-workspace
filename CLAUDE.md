# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

A Slidev workspace that hosts multiple frontend engineering sharing presentations (2023~). Built with pnpm workspaces, each presentation is an independent Slidev project under `slides/YYYY/sharing-YYYYMMDD/`.

Live site: https://fe-sharing-workspace.netlify.app/

## Commands

### Workspace (root)

```bash
pnpm new [YYYYMMDD] [title] [info]    # Scaffold a new presentation
pnpm build                             # Build all presentations
pnpm preview                           # Preview all presentations
```

### Individual presentation

```bash
pnpm --filter sharing-YYYYMMDD dev     # Dev server for a specific presentation
pnpm --filter sharing-YYYYMMDD build   # Build a specific presentation
pnpm --filter sharing-YYYYMMDD export  # Export (e.g. PDF)
```

Or navigate to the project directory and run `pnpm dev` / `pnpm build` / `pnpm export`.

## Architecture

### Workspace structure

- **pnpm workspaces** with `slides/**` as package glob
- **pnpm-workspace.yaml** catalogs shared dependency versions (`vue`, `@slidev/cli`, themes)
- **slidev-workspace.yaml** configures the portal page (hero, sidebar, baseUrl)
- **postinstall** runs `scripts/patch-slidev-workspace.js` to patch the slidev-workspace package: reverses sort order (newest first), adds date-based sorting, widens max-width to 1024px

### Presentation conventions

Each presentation lives at `slides/YYYY/sharing-YYYYMMDD/` and contains:
- `slides.md` — main content with YAML front matter (theme, title, author, date as `YYYY.MM.DD`, info, transition, mdc, monaco)
- `package.json` — private package with `dev`/`build`/`export` scripts
- `public/` — static assets (images, videos), referenced with absolute paths like `/YYYYMMDD/image.png`

### Deployment

Netlify via `netlify.toml`. Build pipeline:
1. `pnpm install` — installs all workspace deps, triggers postinstall patch
2. `pnpm build` — builds all presentations into `dist/`
3. `node scripts/generate-redirects.js` — generates `_redirects` for SPA routing

### Git conventions

Commit messages use emoji prefixes: `📝` docs, `🧹` chore, `🐛` fix, etc.
