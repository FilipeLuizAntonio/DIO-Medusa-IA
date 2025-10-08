#!/usr/bin/env bash
set -euo pipefail
ROOT=$(dirname "$0")/..
OUT=$ROOT/data/out
mkdir -p "$OUT/raw" "$OUT"
source "$ROOT/data/targets.env"
# 1) Nmap (service/version + scripts básicos)
nmap -A -sV -O "$TARGET_FTP" -oA "$OUT/raw/nmap_all"
# 2) Ataques
bash "$ROOT/scripts/ftp_bruteforce_medusa.sh"
bash "$ROOT/scripts/smb_spraying_medusa.sh"
[ -n "${TARGET_DVWA:-}" ] && bash "$ROOT/scripts/dvwa_bruteforce_medusa.sh" || true
# 3) Coleta/normalização + relatório
bash "$ROOT/scripts/collect_evidence.sh"
python3 "$ROOT/ai/ai_report.py"
