# AI Training Hub — Plex Consulting

Interactive AI training platform for "Leading in the Age of AI" sessions.

## Deployment

Hosted on **Cloudflare Pages** with auto-deploy from this repo.

### Setup Steps

1. **Cloudflare Dashboard** → Pages → Create Project → Connect GitHub → `Mavkiwi/claudestuff`
2. Build settings: None (static HTML). Output directory: `/`
3. Custom domain: Add via Cloudflare DNS (e.g., `training.plex.nz`)

### Database (D1)

```bash
# Install Wrangler
npm install -g wrangler

# Login
npx wrangler login

# Create the D1 database
npx wrangler d1 create ai-training-db

# Paste the database_id into wrangler.toml
# Apply schema
npx wrangler d1 execute ai-training-db --file=./db/schema.sql
```

### Architecture

```
Cloudflare Pages (static frontend)
  └─ /functions/api/*.js  (Pages Functions = serverless)
       └─ Cloudflare D1 (SQLite at the edge)
```

- **Frontend**: Static HTML/JS/CSS — deployed globally via CDN
- **Backend**: Pages Functions (lightweight serverless, runs at edge)
- **Database**: D1 (SQLite-compatible, encrypted at rest, edge-local)
- **Security**: No public DB endpoint. Only Functions can query D1.
