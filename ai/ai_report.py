#!/usr/bin/env python3
import pandas as pd, matplotlib.pyplot as plt, pathlib, yaml, textwrap, subprocess
ROOT = pathlib.Path(__file__).resolve().parents[1]
OUT = ROOT/"data/out"; OUT.mkdir(parents=True, exist_ok=True)

# 1) Carrega CSVs
frames = []
for name in ("medusa_ftp.csv","medusa_smb.csv","medusa_dvwa.csv"):
p = OUT/name
if p.exists():
df = pd.read_csv(p); df["vector"] = name.split("_")[1].split(".")[0]
frames.append(df)

df = pd.concat(frames, ignore_index=True) if frames else pd.DataFrame(columns=["account","password","source","vector"])

# 2) Métricas simples
summary = df.groupby("vector").size().rename("hits").to_frame()
summary.to_csv(OUT/"summary.csv")

# 3) Gráfico (hits por vetor)
if not df.empty:
ax = summary.plot(kind='bar', legend=False, title='Credenciais válidas por vetor')
ax.set_xlabel('Vetor'); ax.set_ylabel('Hits')
plt.tight_layout(); plt.savefig(OUT/"chart_hits.png"); plt.close()

# 4) Recomendações (rules)
RULES = ROOT/"ai/rules_mitigations.yaml"
if RULES.exists():
rules = yaml.safe_load(RULES.read_text())
else:
rules = {
'ftp': ['Desabilitar FTP ou migrar para SFTP','Aplicar senhas fortes e MFA onde possível','Fail2ban/ips de bloqueio'],
'smb': ['Account lockout policy','Desabilitar SMBv1','Auditar tentativas e habilitar logon failures'],
'dvwa': ['Rate limiting no login','CAPTCHA','Bloquear enumeração de usuários']
}

recs = []
for v in summary.index:
recs.extend([f"[{v}] {r}" for r in rules.get(v, [])])

# 5) Gera Markdown
md = ["# Relatório — Brute Force com IA\n"]
md.append("## Sumário")
md.append(summary.to_markdown())
md.append("\n## Credenciais encontradas (top 20)")
md.append(df.head(20).to_markdown(index=False))
md.append("\n## Recomendações")
md.extend([f"- {r}" for r in recs])

(OUT/"report.md").write_text("\n\n".join(md))

# 6) PDF via pandoc (se instalado)
try:
subprocess.run(["pandoc", str(OUT/"report.md"), "-o", str(OUT/"report.pdf")], check=True)
except Exception:
pass
