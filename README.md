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
📸 Evidências e screenshots
<img width="1459" height="454" alt="image" src="https://github.com/user-attachments/assets/17b09d3e-8f97-4b09-915d-8d5da42c0a48" />

Usuários encontrados
<img width="1370" height="221" alt="image" src="https://github.com/user-attachments/assets/48ab2aa3-8468-4703-a716-e0652e8795b3" />

Password Info
<img width="823" height="604" alt="image" src="https://github.com/user-attachments/assets/f07e4b28-83f9-4af8-9ba7-36503600e319" />

data/out/* contém as saídas para review (CSV, PNG, MD/PDF).





