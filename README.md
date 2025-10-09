# DIO-Medusa-IA
**Projeto autoral para ambiente controlado de laboratório** (Kali + Servidor Vulnerável + DVWA). Enumera alvo (Nmap + enum4linux). Este repositório demonstra ataques de
força bruta de forma **ética** e controlada (Medusa) e usa **Inteligência Artificial** (local/offline) para normalizar e analisar saídas (`data/out/*.csv`), gerar gráficos (`chart_hits.png`) e **produzir um relatório técnico automático (Markdown → PDF)**.
- 
- ## ⚙️ Pré-requisitos
- Kali com `nmap`, `medusa`, `enum4linux`/`enum4linux-ng`, `python3`, `pip`, `pandoc` (para PDF) e `matplotlib`/`pandas`.
- DVWA (se usar o cenário web) com **security = low** e **Allow URL fopen** habilitado.

sudo apt update
sudo apt install -y medusa nmap python3-pip pandoc

# estando no diretório do projeto
mkdir -p ai scripts data/wordlists data/out

# requirements
cat > ai/requirements.txt << 'EOF'

pandas

matplotlib

pyyaml

markdown

EOF

Usar virtualenv (recomendado)
# 1) Dependência do venv
sudo apt install -y python3-venv

# 2) Criar e ativar o ambiente na raiz do repo
python3 -m venv .venv

# 2) ativar o venv (note o ponto ou 'source' no começo)
. .venv/bin/activate
# ou
source .venv/bin/activate

# 3) Instalar requisitos dentro do venv
pip install -U pip
pip install -r ai/requirements.txt

####Se o venv reclamar de ensurepip/pip ausente:

sudo apt install -y python3-venv python3-virtualenv

python3 -m venv .venv

source .venv/bin/activate

python3 -m pip install -U pip

4) (Opcional) Backend headless p/ gráficos e PDF

export MPLBACKEND=Agg              # evita erro de display

# Para PDF via pandoc + LaTeX (recomendado):

sudo apt install -y texlive-fonts-recommended texlive-latex-recommended texlive-latex-extra

5) Rodar o pipeline completo

chmod +x scripts/*.sh

./scripts/run_attacks.sh

## 🔑 Configuração
Edite `data/targets.env`:
```env
TARGET_FTP=192.168.9.25
TARGET_SMB=192.168.9.25
TARGET_DVWA=http://192.168.9.25
```

data/wordlists base (exemplo simples):
```
users.txt → user, msfadmin, admin, root
pass.txt  → 123456, msfadmin, admin, root
```
Gere variações com `scripts/gen_wordlists.py` (ver abaixo).

---

## 🚀 Execução rápida (tudo em um)
```bash
chmod +x scripts/*.sh
./scripts/run_attacks.sh
```
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


data/out/* contém as saídas para review (CSV, PNG, MD/PDF).

6) Verificar resultados

ls -lah data/out

<img width="550" height="130" alt="image" src="https://github.com/user-attachments/assets/87d77a25-701f-4a5d-bcaa-6fe2add5a56f" />


column -t -s, data/out/summary.csv | sed '1s/^/\n/;s/^/  /'


Abra o data/out/report.pdf — deve ter sumário de hits por vetor, top credenciais e gráficos.








