# DIO-Medusa-IA
**Projeto autoral para ambiente controlado de laboratório** (Kali + Metasploitable2 + DVWA). Este repositório demonstra ataques de força bruta de forma **ética** e controlada e usa **Inteligência Artificial** (local/offline) para analisar saídas, gerar gráficos e **produzir um relatório técnico automático (Markdown → PDF)**.
- 
- ## ⚙️ Pré-requisitos
- Kali com `nmap`, `medusa`, `enum4linux`/`enum4linux-ng`, `python3`, `pip`, `pandoc` (para PDF) e `matplotlib`/`pandas`.
- DVWA (se usar o cenário web) com **security = low** e **Allow URL fopen** habilitado.

```bash
sudo apt update
sudo apt install -y medusa nmap python3-pip pandoc
pip3 install -r ai/requirements.txt
```

**ai/requirements.txt**
```txt
pandas
matplotlib
pyyaml
markdown

## 🔑 Configuração
Edite `data/targets.env`:
```env
TARGET_FTP=192.168.56.101
TARGET_SMB=192.168.56.101
TARGET_DVWA=http://192.168.56.102
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

---
