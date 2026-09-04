# MarketOps Logistics Dashboard

A full-stack marketplace order and international logistics dashboard built with React, TypeScript, Express and PostgreSQL. The repository contains a fully synthetic portfolio dataset and can also connect to a PostgreSQL database.

## Features

- Order search, status, seller, date and operational filters
- Spreadsheet and card views with pagination and bulk actions
- Marketplace purchase confirmation and cancellation history
- International logistics timeline (WR, ETD, ETA, DI, distribution center and delivery)
- Sales, lead-time and cancellation dashboards
- Excel import and export
- Bilingual interface (English and Portuguese)
- Light and dark themes
- Email reports with monthly charts and spreadsheet attachment
- PostgreSQL persistence with a synthetic-data fallback

## Stack

- React 19, TypeScript and Tailwind CSS
- Express and Node.js
- PostgreSQL (compatible with Supabase)
- Vite and esbuild
- Nodemailer and SheetJS

## Local setup

Requirements: Node.js 20 or newer and npm.

```bash
npm install
```

Copy `.env.example` to `.env.local` and select a data source:

```env
DATA_SOURCE="synthetic"
DATABASE_URL=""
DATABASE_SSL="true"
```

Start the development server:

```bash
npm run dev
```

Open `http://localhost:3000`. The API health endpoint is available at `http://localhost:3000/api/health`.

## PostgreSQL / Supabase

1. Run `database/001_schema.sql` in a new database.
2. Run the files in `database/seed_chunks/` in numerical order.
3. Run `database/seed_chunks/99_validate.sql`.
4. Configure:

```env
DATA_SOURCE="postgres"
DATABASE_URL="postgresql://USER:PASSWORD@HOST:PORT/DATABASE"
DATABASE_SSL="true"
```

The seed contains only synthetic demonstration data.

## Production build

```bash
npm run lint
npm run build
npm start
```

## Render deployment

The included `render.yaml` defines the web service. In Render, add these secret environment variables:

- `DATABASE_URL`
- `SMTP_HOST`, `SMTP_PORT`, `SMTP_SECURE`, `SMTP_USER`, `SMTP_PASSWORD`, `SMTP_FROM` (optional)
- Databricks variables from `.env.example` only when that integration becomes available

Do not commit `.env.local` or credentials. Render supplies `PORT` automatically.

## Demo data and privacy

All customers, orders, products, invoices, tracking codes and logistics events bundled with this repository are fictional. Runtime state files and environment files are excluded from Git.

## License

Portfolio and educational project.
