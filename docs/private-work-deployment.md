# Separação entre demonstração pública e ambiente de trabalho

Use dois repositórios GitHub distintos:

1. **Público/pessoal:** somente dados sintéticos, `.env.example`, documentação e imagens sem informações da empresa.
2. **Privado/corporativo:** cópia controlada do código, dados reais apenas em PostgreSQL/Databricks e segredos no cofre do ambiente de deploy.

Não use apenas uma branch privada dentro do repositório público: histórico, forks e configurações podem expor arquivos. Nunca envie `.env.local`, token Databricks, senha SMTP, planilhas reais, logs com clientes ou dumps do banco para o Git.

Variáveis mínimas no ambiente privado:

```text
DATABASE_URL=
SUPABASE_URL=
SUPABASE_ANON_KEY=
SUPABASE_SERVICE_ROLE_KEY=
SMTP_HOST=
SMTP_PORT=
SMTP_USER=
SMTP_PASS=
SMTP_FROM=
DATABRICKS_RECONCILE_TOKEN=
```

O Databricks corporativo deve executar um Workflow incremental e chamar o endpoint de reconciliação com HTTPS e token. Restrinja o ambiente privado por login, perfis aprovados e, se disponível, SSO/VPN da empresa.
