# Changelog

## [v0.1.0] - 2025-10-08
### Added
- Pipeline completo de laboratório: Nmap + enum4linux + Medusa (FTP/SMB/DVWA).
- Normalização automática de saídas em `data/out/*.csv`.
- Geração de gráficos (`chart_hits.png`) e relatório técnico em Markdown.
- Exportação para PDF via Pandoc/LaTeX.
- Exemplos **sanitizados**: `sanitizado/report-sample.pdf`, `.md`, `chart_hits.png`, `summary.csv`, `evidence_sanitized.txt`.
- `.gitignore` robusto para evitar vazamento de dados sensíveis.
- Aviso legal e documentação revisada no `README`.

### Notes
- Projeto para uso **ético** em laboratório controlado (Kali + Metasploitable/DVWA).
- Para headless/CI, usar `export MPLBACKEND=Agg`.

### Known limitations
- As wordlists padrão são mínimas; para resultados mais ricos, forneça listas maiores.
- O cenário DVWA exige `security=low` e `allow_url_fopen` habilitado.
