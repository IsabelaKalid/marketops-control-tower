# MarketOps — SMTP and release checklist

## Local Gmail SMTP

Create `.env.local` in the project root (it is ignored by Git):

```dotenv
SMTP_HOST="smtp.gmail.com"
SMTP_PORT="587"
SMTP_SECURE="false"
SMTP_USER="your-account@gmail.com"
SMTP_PASSWORD="your-16-character-app-password"
SMTP_FROM="MarketOps <your-account@gmail.com>"
SMTP_CONNECTION_TIMEOUT_MS="10000"
DEMO_ALERT_RECIPIENT="your-account@gmail.com"
APP_URL="http://localhost:3000"
```

Never commit `.env.local`, paste the password into source code, or use the normal Google account password.
The backend removes spaces from a Google App Password before authentication.

## Verification

1. Run `npm ci`, `npm run lint`, and `npm run build`.
2. Run `npm run dev` and sign in with an `admin` or `operations` account.
3. Call `POST /api/email/verify` with the signed-in user's bearer token. This checks SMTP without sending.
4. In the Alerts drawer, enter the SMTP account as the test recipient and send a test alert.
5. Confirm that the alert status is `sent`, then confirm receipt (including the spam folder).

## Reviewed behavior

- Automatic delivery alerts are generated only when the shipment status changes; synthetic `@example.com` recipients are never contacted.
- Cancellation sends an alert and persists the reason. Undo recalculates status from logistics data and rolls back the in-memory change if PostgreSQL persistence fails.
- Dark mode follows the system initially, persists the user's choice, and applies the root `dark` class.
- Future Databricks reconciliation accepts changed records at `POST /api/databricks/reconcile`; service calls use `x-marketops-integration-key`, compared in constant time.
- Databricks credentials and the webhook secret belong only in protected environment variables.

