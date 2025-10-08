#!/usr/bin/env python3
import itertools, sys, pathlib
seeds_users = ["admin","user","msfadmin","root"]
seeds_pass = ["admin","msfadmin","123456","toor","spring2025","Company","company"]
mangles = [
lambda s: s,
str.lower,
str.upper,
lambda s: s+"123",
lambda s: s+"!",
lambda s: s.replace('o','0').replace('i','1').replace('a','@'),
]
out = pathlib.Path("data/wordlists")
out.mkdir(parents=True, exist_ok=True)
with open(out/"users.txt","w") as fu:
fu.write("\n".join(sorted(set(m(u) for u in seeds_users for m in mangles))))
with open(out/"pass.txt","w") as fp:
base = set(m(p) for p in seeds_pass for m in mangles)
combos = set(p+suffix for p in base for suffix in ("2024","2025","@123","#","!") )
fp.write("\n".join(sorted(base | combos)))
