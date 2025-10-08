#!/usr/bin/env bash
set -euo pipefail
OUT=./data/out
mkdir -p "$OUT"
# Converte as saídas do Medusa para CSV simples
python3 - "$OUT" << 'PY'
import re, json, csv, sys, pathlib
out = pathlib.Path(sys.argv[1])
raw = out/"raw"
pattern = re.compile(r"ACCOUNT:\s*([^\s]+)\s*PASSWORD:\s*([^\s]+)")
for name in ["medusa_ftp.txt","medusa_smb.txt","medusa_dvwa.txt"]:
p = raw/name
if not p.exists():
continue
rows = []
for line in p.read_text(errors='ignore').splitlines():
m = pattern.search(line)
if m:
rows.append({"account":m.group(1),"password":m.group(2),"source":name})
if rows:
with open(out/(name.replace('.txt','.csv')), 'w', newline='') as f:
w = csv.DictWriter(f, fieldnames=rows[0].keys())
w.writeheader(); w.writerows(rows)
PY
