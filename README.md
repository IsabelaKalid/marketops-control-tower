# MarketOps Control Tower

Full-stack marketplace order and international logistics control tower. MarketOps centralizes purchase follow-up, shipment milestones, operational exceptions, financial indicators and management reports in a single responsive interface.

[![Live Demo](https://img.shields.io/badge/Live_Demo-Open_application-16a34a?style=for-the-badge)](https://marketops-logistics-dashboard.onrender.com)
[![React](https://img.shields.io/badge/React-19-149eca?style=flat-square&logo=react)](https://react.dev/)
[![TypeScript](https://img.shields.io/badge/TypeScript-5-3178c6?style=flat-square&logo=typescript)](https://www.typescriptlang.org/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-Supabase-4169e1?style=flat-square&logo=postgresql)](https://www.postgresql.org/)
[![Render](https://img.shields.io/badge/Deployed_on-Render-000000?style=flat-square&logo=render)](https://render.com/)

> **Live application:** https://marketops-logistics-dashboard.onrender.com  
> The free Render service may take a short time to wake up after a period of inactivity.

## Project overview

MarketOps Control Tower was designed to provide an end-to-end view of marketplace orders—from purchase confirmation through warehouse receipt, international transit, distribution-center entry and final delivery.

The application combines operational workflows with management indicators, helping teams identify delays, follow invoiced shipments and analyze sales and cancellations over time.

The public version uses a PostgreSQL database populated exclusively with synthetic customers, products, orders, invoices and tracking events.

## Demo

### Application walkthrough

![MarketOps Control Tower demonstration](docs/screenshots/marketops-demo.gif)

### Monitoring dashboard

![MarketOps monitoring dashboard](docs/screenshots/dashboard.jpg)

### Order management

![Marketplace order management](docs/screenshots/orders.jpg)

### Order details and logistics tracking

![Order details and logistics tracking](docs/screenshots/order-details.jpg)

### Reports and analytics

![MarketOps reports and analytics](docs/screenshots/reports.jpg)

## Main features

- Search by order, customer, SKU, ASIN or date
- Filters by seller, period, order status and operational condition
- Spreadsheet and card views
- Pagination and responsive layouts
- Individual and bulk purchase confirmation
- Individual and bulk order cancellation
- Confirmation safeguards before cancelling orders
- Purchase-confirmation and cancellation history
- International logistics tracking timeline
- Warehouse receipt, ETD, ETA, DI, distribution-center entry and delivery dates
- Monitoring of orders without warehouse registration
- Monitoring of invoiced orders currently in transit
- KPIs for orders, revenue, seller cost, cancellations and lead time
- Monthly sales and cancellation charts
- Filter-aware operational and financial summaries
- Excel batch import
- Filtered Excel export
- Email reports with KPIs, charts and spreadsheet attachments
- Independent English and Portuguese controls
- Light and dark themes
- PostgreSQL persistence
- Synthetic-data fallback for local demonstrations
- Health-check endpoint and Render deployment configuration

## Architecture

```mermaid
flowchart LR
    U["Browser"] --> F["React + TypeScript"]
    F --> A["Express REST API"]
    A --> P[("PostgreSQL / Supabase")]
    A --> E["Email and Excel reports"]
    D["Future Databricks source"] -.-> A
```

The same application layer can work with the bundled synthetic dataset during development or PostgreSQL in production.

The data-access structure also allows a future Databricks integration without requiring the user interface to be replaced.

## Technology stack

| Layer | Technologies |
| --- | --- |
| Front end | React 19, TypeScript, Tailwind CSS, Motion and Lucide React |
| Back end | Node.js, Express and TypeScript |
| Database | PostgreSQL and Supabase |
| Reports | Nodemailer and SheetJS |
| Tooling | Vite, esbuild and tsx |
| Deployment | Render Blueprint |
| Version control | Git and GitHub |

## Data model

The PostgreSQL schema separates the operational domain into the following core tables:

- `orders`: purchase, customer, status and financial information
- `order_items`: products, SKUs, ASINs, quantities and prices
- `logistics`: shipment information and international logistics milestones
- `order_events`: chronological tracking events
- `purchase_confirmation_history`: purchase-confirmation audit trail
- `cancellation_history`: cancellation reasons and audit trail

## Running locally

### Requirements

- Node.js 20 or newer
- npm

### Installation

Clone the repository:

```bash
git clone https://github.com/IsabelaKalid/marketops-control-tower.git
cd marketops-control-tower
```

Install the dependencies:

```bash
npm install
```

Copy `.env.example` to `.env.local`.

To run the application with the bundled synthetic dataset:

```env
DATA_SOURCE="synthetic"
DATABASE_URL=""
DATABASE_SSL="true"
```

Start the development server:

```bash
npm run dev
```

Open the application at:

```text
http://localhost:3000
```

The API health endpoint is available at:

```text
http://localhost:3000/api/health
```

## PostgreSQL and Supabase setup

1. Create a PostgreSQL or Supabase project.
2. Run `database/001_schema.sql`.
3. Run the files inside `database/seed_chunks/` in numerical order.
4. Run `database/seed_chunks/99_validate.sql`.
5. Configure `.env.local`:

```env
DATA_SOURCE="postgres"
DATABASE_URL="postgresql://USER:PASSWORD@HOST:PORT/DATABASE"
DATABASE_SSL="true"
```

The included database seed contains only fictional demonstration data.

## Quality checks

Run the TypeScript validation:

```bash
npm run lint
```

Create the production build:

```bash
npm run build
```

Start the production server locally:

```bash
npm start
```

## Deployment on Render

The repository includes a `render.yaml` Blueprint containing:

- Node.js runtime configuration
- Build command
- Start command
- Free service plan
- Environment configuration
- `/api/health` health check

The following secret is required in Render:

```text
DATABASE_URL
```

Optional email configuration:

```text
SMTP_HOST
SMTP_PORT
SMTP_SECURE
SMTP_USER
SMTP_PASSWORD
SMTP_FROM
```

Databricks environment variables should only be configured when that integration becomes available.

Render supplies the `PORT` environment variable automatically.

## Privacy and security

- All bundled names, orders and customer information are fictional.
- All products, invoices and tracking codes are synthetic.
- No confidential company dataset is included.
- Environment files and credentials are excluded from Git.
- Runtime state files are excluded from Git.
- Secrets are configured through `.env.local` during local development.
- Production secrets are stored as protected environment variables in Render.

## Roadmap

- Connect the production ingestion layer to Databricks
- Add authenticated users and role-based permissions
- Enable customer email and messaging notifications
- Add automated tests and continuous integration
- Add configurable operational alerts
- Expand audit and activity history

## Author

Developed by [Isabela Kalid](https://github.com/IsabelaKalid) as a portfolio project focused on full-stack development, data analytics and logistics operations.

## License

Copyright © 2026 Isabela Kalid. All rights reserved.

This source code is publicly available for portfolio and evaluation purposes only. Copying, redistribution, modification or commercial use is not permitted without prior written authorization.

See the [LICENSE](LICENSE) file for complete terms.