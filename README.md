# DIO-Medusa-IA

**Projeto autoral para ambiente controlado de laboratório** (Kali + Servidor Vulnerável + DVWA).
- Enumera o alvo (Nmap + enum4linux).
- Executa ataques de **força bruta** de forma **ética** e controlada (Medusa).
- Usa **IA local/offline** (Python) para **normalizar saídas** (`data/out/*.csv`), **gerar gráficos** (`chart_hits.png`) e **produzir relatório técnico automático** (**Markdown → PDF**).

---

## 📦 Saídas de exemplo (sanitizadas)
- PDF: [sanitizado/report-sample.pdf](sanitizado/report-sample.pdf)  
- Markdown: [sanitizado/report-sample.md](sanitizado/report-sample.md)  
- Gráfico: [sanitizado/chart_hits.png](sanitizado/chart_hits.png)  
- Sumário CSV: [sanitizado/summary.csv](sanitizado/summary.csv)  
- Evidências (texto): [sanitizado/evidence_sanitized.txt](sanitizado/evidence_sanitized.txt)

---

## ⚙️ Pré-requisitos

**Pacotes (Kali/Debian):**
```bash
sudo apt update
sudo apt install -y nmap medusa enum4linux python3-venv python3-pip pandoc \
                    texlive-fonts-recommended texlive-latex-recommended texlive-latex-extra


# na raiz do repositório
mkdir -p ai scripts data/wordlists data/out

# Requisitos Python
cat > ai/requirements.txt << 'EOF'
pandas
matplotlib
pyyaml
markdown
tabulate
EOF

Obs. O LaTeX é opcional (só precisa dele para gerar PDF via pandoc).
Para execução headless dos gráficos:
export MPLBACKEND=Agg

🔧 Configuração

Edite data/targets.env (exemplo):
TARGET_FTP=192.168.9.25
TARGET_SMB=192.168.9.25
TARGET_DVWA=http://192.168.9.25

Duas wordlists simples em data/wordlists/:
users.txt -> usuarios enumerdos via Enum4linux
pass.txt  -> dicionário de senhas corporativas

## 🚀 Execução rápida
# 1) Criar/ativar venv e instalar deps
python3 -m venv .venv
source .venv/bin/activate
pip install -U pip
pip install -r ai/requirements.txt   # inclui pandas, matplotlib, tabulate, pyyaml, markdown

####Se o venv reclamar de ensurepip/pip ausente:
sudo apt install -y python3-venv python3-virtualenv
python3 -m venv .venv
source .venv/bin/activate
python3 -m pip install -U pip

# 2) Rodar o pipeline completo (coleta + ataques + normalização)
chmod +x scripts/*.sh
./scripts/run_attacks.sh

Isso faz:
Nmap (agressivo + detecção de serviços) no alvo.
FTP brute force, SMB spraying e DVWA web form (se configurado).
Salva saídas cruas em data/out/raw/ e normaliza para data/out/*.csv.
Gera relatório e gráficos com Python.

# 3) Gerar relatório e PDF
export MPLBACKEND=Agg
python3 ai/ai_report.py
pandoc data/out/report.md -o data/out/report.pdf

🔎 Como ficam as saídas
ls -lah data/out

Exemplo (sanitizado):

<img width="967" height="361" alt="image" src="https://github.com/user-attachments/assets/5c6f37f0-9851-4de3-8b89-9f4bba319014" />

📸 Evidências e screenshots
<img width="1891" height="544" alt="image" src="https://github.com/user-attachments/assets/72d08fa8-4e20-4946-a5c2-524c6f50eaf2" />

Usuários encontrados
<img width="731" height="577" alt="image" src="https://github.com/user-attachments/assets/87eb7504-ea89-4f99-bde2-876c8e9335cd" />

Password Info
<img width="1103" height="831" alt="image" src="https://github.com/user-attachments/assets/7997b2ec-b41c-4954-8a96-6773e0282da6" />

Sumário compactado (CSV → coluna):
Gerar relatório e PDF
column -t -s, data/out/summary.csv | sed '1s/^/\n/;s/^/  /'

Abra o data/out/report.pdf — terá sumário de hits por vetor, top credenciais e gráficos.
