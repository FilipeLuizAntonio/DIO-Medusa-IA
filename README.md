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

Usar virtualenv (recomendado)
# 1) Dependência do venv
sudo apt install -y python3-venv

# 2) Criar e ativar o ambiente na raiz do repo
python3 -m venv .venv

# 3) ativar o venv (note o ponto ou 'source' no começo)
. .venv/bin/activate
# ou
source .venv/bin/activate

# 4) Instalar requisitos dentro do venv
pip install -U pip
pip install -r ai/requirements.txt

####Se o venv reclamar de ensurepip/pip ausente:
sudo apt install -y python3-venv python3-virtualenv
python3 -m venv .venv
source .venv/bin/activate
python3 -m pip install -U pip

# 5) (Opcional) Backend headless p/ gráficos e PDF
export MPLBACKEND=Agg              # evita erro de display

# 6)Para PDF via pandoc + LaTeX (recomendado):
sudo apt install -y texlive-fonts-recommended texlive-latex-recommended texlive-latex-extra

## 🚀 Execução rápida
```bash
# 1) Criar/ativar venv e instalar deps
python3 -m venv .venv
source .venv/bin/activate
pip install -U pip
pip install -r ai/requirements.txt   # inclui pandas, matplotlib, tabulate, pyyaml, markdown

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
<img width="1459" alt="evidências" src="https://github.com/user-attachments/assets/17b09d3e-8f97-4b09-915d-8d5da42c0a48" />

Usuários encontrados
<img width="1370" alt="users" src="https://github.com/user-attachments/assets/48ab2aa3-8468-4703-a716-e0652e8795b3" />

Password Info
<img width="823" alt="pwd-info" src="https://github.com/user-attachments/assets/f07e4b28-83f9-4af8-9ba7-36503600e319" />

Sumário compactado (CSV → coluna):
Gerar relatório e PDF
## 🔑 Configuração
Edite `data/targets.env`:
TARGET_FTP=192.168.9.25
TARGET_SMB=192.168.9.25
TARGET_DVWA=http://192.168.9.25

Duas wordlists simples em data/wordlists/
data/wordlists base (exemplo simples):

users.txt -> usuários enumerados via linux4enum
pass.txt  -> dicionário de senhas corporativas

(Opcional) Gere variações com um gerador próprio scripts/gen_wordlists.py (se quiser ampliar o dicionário).

## 🚀 Execução rápida (tudo em um)
1. Criar/ativar venv e instalar deps
python3 -m venv .venv
source .venv/bin/activate
python3 -m pip install -U pip
pip install -r ai/requirements.txt

Isso irá:
1) Rodar **Nmap** (agressivo + detecção de serviços) no alvo.
2) Executar **FTP brute force**, **SMB spraying** e **DVWA web form** (se configurado).
3) Salvar saídas cru (`raw`) + **normalizar** em `data/out/*.csv`.
4) Rodar **`ai/ai_report.py`** → gera `data/out/report.md` + `data/out/report.pdf` + gráficos `.png`.

<img width="936" height="232" alt="image" src="https://github.com/user-attachments/assets/16c80a78-f3de-4f7b-a7df-6aa1de041e29" />

---
📸 Evidências e screenshots
<img width="1459" height="454" alt="image" src="https://github.com/user-attachments/assets/17b09d3e-8f97-4b09-915d-8d5da42c0a48" />

Usuários encontrados
<img width="1370" height="221" alt="image" src="https://github.com/user-attachments/assets/48ab2aa3-8468-4703-a716-e0652e8795b3" />


Password Info
<img width="823" height="604" alt="image" src="https://github.com/user-attachments/assets/f07e4b28-83f9-4af8-9ba7-36503600e319" />


<img width="1648" height="147" alt="image" src="https://github.com/user-attachments/assets/0b575c66-1d43-4640-9ee5-05aa585a7677" />

5) gerar relatório e PDF
export MPLBACKEND=Agg
python3 ai/ai_report.py
pandoc data/out/report.md -o data/out/report.pdf

data/out/* contém as saídas para review (CSV, PNG, MD/PDF).

6) Verificar resultados

ls -lah data/out

<img width="550" height="130" alt="image" src="https://github.com/user-attachments/assets/87d77a25-701f-4a5d-bcaa-6fe2add5a56f" />


column -t -s, data/out/summary.csv | sed '1s/^/\n/;s/^/  /'


Abra o data/out/report.pdf — deve ter sumário de hits por vetor, top credenciais e gráficos.
