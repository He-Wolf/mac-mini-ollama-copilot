#!/usr/bin/env python3
"""Decode benchmark (Ollama API). Usage: decode.py <base_url> <model> [context_tokens...]
Generates ~500 tokens of code after a short prompt and after a long code context."""
import json, sys, time, urllib.request, random, string
base, model = sys.argv[1:3]
ctxs = [int(c) for c in sys.argv[3:]] or [0, 30000]
TASK = "Write a complete Python module implementing a thread-safe LRU cache class with get, put, delete, resize and stats methods, with docstrings and type hints. Output only code."
def filler(n, seed):
    rnd = random.Random(seed); out = []
    for _ in range(n // 60):
        nm = "".join(rnd.choices(string.ascii_lowercase, k=8))
        out.append(f"def {nm}(items, limit={rnd.randint(1,99)}):\n    return [x * {rnd.randint(2,9)} for i, x in enumerate(items) if i < limit]\n\n")
    return "".join(out)
for ctx in ctxs:
    seed = random.randint(0, 1 << 30)
    msgs = ([{"role": "system", "content": f"Session {seed}.\n" + filler(ctx, seed)}] if ctx else []) + [{"role": "user", "content": TASK}]
    body = {"model": model, "stream": False, "think": False, "messages": msgs, "options": {"num_predict": 500, "temperature": 0.6}}
    r = json.load(urllib.request.urlopen(urllib.request.Request(base + "/api/chat", json.dumps(body).encode(), {"Content-Type": "application/json"}), timeout=1800))
    print(f"{model[:30]:30s} ctx {ctx//1000:>3}k: prefill {r['prompt_eval_count']/(r['prompt_eval_duration']/1e9):6.0f} tok/s | decode {r['eval_count']} tok @ {r['eval_count']/(r['eval_duration']/1e9):5.1f} tok/s", flush=True)
