#!/usr/bin/env python3
"""Decode, thinking-loop and tool-call tests over the OpenAI API (Strata, llama-server).
Usage: oa_tests.py <base_url> <model> decode [ctx...] | loops [cap] | tool
Same prompts and settings as decode.py / loops.py; thinking off = reasoning_effort none.
API_KEY=... sends it as a bearer token (Strata with --access lan)."""
import json, os, random, string, sys, urllib.request
base, model, mode = sys.argv[1:4]
args = sys.argv[4:]

def chat(body):
    body = {"model": model, "stream": False, **body}
    headers = {"Content-Type": "application/json"}
    if os.environ.get("API_KEY"):
        headers["Authorization"] = "Bearer " + os.environ["API_KEY"]
    req = urllib.request.Request(base + "/v1/chat/completions", json.dumps(body).encode(), headers)
    return json.load(urllib.request.urlopen(req, timeout=3600))

if mode == "decode":
    TASK = "Write a complete Python module implementing a thread-safe LRU cache class with get, put, delete, resize and stats methods, with docstrings and type hints. Output only code."
    def filler(n, seed):
        rnd = random.Random(seed); out = []
        for _ in range(n // 60):
            nm = "".join(rnd.choices(string.ascii_lowercase, k=8))
            out.append(f"def {nm}(items, limit={rnd.randint(1,99)}):\n    return [x * {rnd.randint(2,9)} for i, x in enumerate(items) if i < limit]\n\n")
        return "".join(out)
    for ctx in [int(c) for c in args] or [0, 30000]:
        seed = random.randint(0, 1 << 30)
        msgs = ([{"role": "system", "content": f"Session {seed}.\n" + filler(ctx, seed)}] if ctx else []) + [{"role": "user", "content": TASK}]
        r = chat({"messages": msgs, "max_tokens": 500, "temperature": 0.6, "reasoning_effort": "none"})
        t = r["timings"]
        acc = f" | draft {t['draft_n_accepted']}/{t['draft_n']} accepted" if t.get("draft_n") else ""
        print(f"{model[:30]:30s} ctx {ctx//1000:>3}k: prefill {t['prompt_n']} tok @ {t['prompt_per_second']:6.0f} tok/s | decode {t['predicted_n']} tok @ {t['predicted_per_second']:5.1f} tok/s{acc}", flush=True)

elif mode == "loops":
    cap = int(args[0]) if args else 6000
    PROMPTS = [
        "A bat and a ball cost $1.10. The bat costs $1 more than the ball. How much is the ball? Then: if 5 machines make 5 widgets in 5 minutes, how long do 100 machines take for 100 widgets?",
        "This Python function should return the second largest distinct value but fails for some inputs. Find all bugs and give the fixed code:\ndef second(xs):\n    a = b = 0\n    for x in xs:\n        if x > a: a, b = x, a\n        elif x > b: b = x\n    return b",
        "Is 2^61 - 1 prime? Explain briefly how you know.",
        "Write a regex that matches valid IPv4 addresses (0-255 in each octet, no leading zeros) and nothing else.",
        "In a TypeScript monorepo, `tsc -b` succeeds but VS Code shows 'Cannot find module @app/core' in one package. List the most likely causes in order.",
        "How many times does the digit 1 appear when writing all integers from 1 to 999?",
    ]
    for think_on in (True, False):
        tot_think = hits = 0
        print(f"---- loops, thinking {'ON' if think_on else 'OFF'}", flush=True)
        for i, p in enumerate(PROMPTS, 1):
            body = {"messages": [{"role": "user", "content": p}], "max_tokens": cap}
            if not think_on:
                body["reasoning_effort"] = "none"
            r = chat(body)
            c = r["choices"][0]; m = c["message"]
            hit = c.get("finish_reason") == "length"; hits += hit
            think = len(m.get("reasoning_content") or m.get("reasoning") or "") // 4; tot_think += think
            t = r["timings"]
            print(f"think={think_on} #{i}: ~{think:5d} thinking tok, {r['usage']['completion_tokens']:5d} total tok, {t['predicted_per_second']:5.1f} tok/s, {'CAP HIT (loop/overthink)' if hit else 'answered'}", flush=True)
            print("      ->", (m.get("content") or "-")[-160:].replace("\n", " "), flush=True)
        print(f"think={think_on} SUMMARY: avg ~{tot_think // len(PROMPTS)} thinking tok, cap hits {hits}/{len(PROMPTS)}", flush=True)

elif mode == "tool":
    tools = [{"type": "function", "function": {"name": "read_file", "description": "Read a file",
              "parameters": {"type": "object", "properties": {"filePath": {"type": "string"}}, "required": ["filePath"]}}}]
    r = chat({"messages": [{"role": "user", "content": "Read the file src/main.py"}], "tools": tools, "reasoning_effort": "none"})
    print("tool call:", json.dumps(r["choices"][0]["message"].get("tool_calls")), flush=True)
