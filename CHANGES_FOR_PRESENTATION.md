# MarketOps — roteiro para apresentar à gestora

## O problema de negócio

O MarketOps pode funcionar como uma camada operacional sobre os dados que a empresa já possui: centraliza pedidos, compra, logística internacional, exceções, cancelamentos, indicadores e comunicação com o cliente em uma única tela.

A proposta não é substituir o Databricks. Quando a integração corporativa for aprovada, o Databricks pode permanecer como fonte tratada e governada dos dados; o MarketOps consome as alterações relevantes e transforma dados em ação operacional.

## Fluxo recomendado para a demonstração

1. Abra o dashboard e explique os indicadores e filtros.
2. Abra um pedido e mostre a timeline logística, os produtos e os dados do cliente.
3. Abra **Alertas automáticos de entrega**. Escolha um pedido, informe seu e-mail real no campo de demonstração e envie um teste. O histórico mostra se o SMTP enviou, simulou ou falhou.
4. Explique o fluxo futuro: mudança de status no Databricks → `/api/databricks/reconcile` → atualização do pedido → e-mail automático → registro do alerta.
5. Abra **Integração Databricks** e destaque que hoje é uma arquitetura preparada, não uma conexão ativa. Use o botão de reconciliação somente como demonstração.
6. Abra **Relatórios**, confira o indicador de SMTP e envie o relatório completo com planilha anexa.
7. Abra um pedido cancelado e mostre **Desfazer cancelamento**. O status é recalculado a partir dos dados logísticos existentes e o histórico de cancelamento permanece para auditoria.
8. Ative o modo escuro e mostre que os cartões, formulários, tabelas, alertas e gráficos continuam legíveis.

## Configuração de e-mail no Render

O arquivo `.env.local` existe apenas para desenvolvimento local. No site publicado, as variáveis precisam ser criadas em **Render > Environment**:

```text
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_SECURE=false
SMTP_USER=<conta de envio>
SMTP_PASSWORD=<senha de app / segredo SMTP>
SMTP_FROM=<remetente>
APP_URL=https://marketops-logistics-dashboard.onrender.com
```

Para a demonstração com clientes fictícios `@example.com`, configure também:

```text
DEMO_ALERT_RECIPIENT=<seu e-mail real de teste>
```

Assim, os dados continuam fictícios na interface, mas os e-mails de demonstração podem chegar a uma caixa real controlada por você.

## Databricks em linguagem simples

Databricks é a plataforma onde a empresa pode concentrar, tratar e governar dados de várias fontes. No cenário do MarketOps, uma tabela Gold/Delta pode representar o estado logístico já tratado de cada pedido.

A aplicação não precisa copiar todo o Databricks. Ela precisa receber somente as alterações relevantes. Um exemplo é usar Change Data Feed (CDF) para identificar linhas inseridas ou atualizadas e entregar essas mudanças ao backend MarketOps.

Fluxo proposto:

```text
ERP / marketplace / transportadoras
              ↓
       Databricks Delta/Gold
              ↓
        mudanças de status
              ↓
POST /api/databricks/reconcile
              ↓
        backend MarketOps
          ↙           ↘
   PostgreSQL       e-mail SMTP
          ↘           ↙
       interface + histórico
```

O nome `gold_logistics.marketplace_shipments` usado no projeto é uma proposta de contrato de dados. Não deve ser apresentado como uma tabela já existente na empresa.

## Frase curta para explicar o valor

> “O Databricks organiza e disponibiliza o dado; o MarketOps transforma a mudança desse dado em acompanhamento, exceção operacional, relatório e comunicação automática com o cliente.”

## Antes da apresentação

- Faça um novo deploy no Render após atualizar as variáveis de ambiente.
- Confira `/api/email/status` pela própria tela de Relatórios: o selo deve aparecer como **SMTP conectado neste ambiente**.
- Use um e-mail seu no campo de teste dos alertas.
- Não use endereços reais de clientes na versão de portfólio.
- Confirme que nenhum arquivo `.env.local` ou segredo foi enviado para o repositório.
