#!/usr/bin/env python3
"""Thinking-loop test (Ollama API). Usage: loops.py <base_url> <model> <presence_penalty> [cap]
Runs prompts that tend to cause overthinking, reports thinking length, cap hits and the end of
each answer. Thinking is on by default; THINK=false runs the same prompts with thinking off."""
import json, os, sys, urllib.request
base, model, pp = sys.argv[1], sys.argv[2], float(sys.argv[3])
cap = int(sys.argv[4]) if len(sys.argv) > 4 else 6000
think_on = os.environ.get("THINK", "true") != "false"
PROMPTS = [
    "A bat and a ball cost $1.10. The bat costs $1 more than the ball. How much is the ball? Then: if 5 machines make 5 widgets in 5 minutes, how long do 100 machines take for 100 widgets?",
    "This Python function should return the second largest distinct value but fails for some inputs. Find all bugs and give the fixed code:\ndef second(xs):\n    a = b = 0\n    for x in xs:\n        if x > a: a, b = x, a\n        elif x > b: b = x\n    return b",
    "Is 2^61 - 1 prime? Explain briefly how you know.",
    "Write a regex that matches valid IPv4 addresses (0-255 in each octet, no leading zeros) and nothing else.",
    "In a TypeScript monorepo, `tsc -b` succeeds but VS Code shows 'Cannot find module @app/core' in one package. List the most likely causes in order.",
    "How many times does the digit 1 appear when writing all integers from 1 to 999?",
]
tot_think = hits = 0
for i, p in enumerate(PROMPTS, 1):
    body = {"model": model, "stream": False, "think": think_on, "messages": [{"role": "user", "content": p}],
            "options": {"num_predict": cap, "presence_penalty": pp}}
    r = json.load(urllib.request.urlopen(urllib.request.Request(base + "/api/chat", json.dumps(body).encode(), {"Content-Type": "application/json"}), timeout=1800))
    hit = r.get("done_reason") == "length"; hits += hit
    think = len(r["message"].get("thinking") or "") // 4; tot_think += think
    print(f"pp={pp} think={think_on} #{i}: ~{think:5d} thinking tok, {r['eval_count']:5d} total tok, {'CAP HIT (loop/overthink)' if hit else 'answered'}", flush=True)
    print("      ->", (r["message"]["content"] or "-")[-160:].replace("\n", " "), flush=True)
print(f"pp={pp} think={think_on} SUMMARY: avg ~{tot_think // len(PROMPTS)} thinking tok, cap hits {hits}/{len(PROMPTS)}")
