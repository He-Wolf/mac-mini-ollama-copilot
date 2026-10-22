#!/usr/bin/env python3
"""Prefill/decode benchmark. Usage: bench.py <ollama|llamacpp> <base_url> <model> [sizes...]
Cold = unique prefix (no cache hit). Warm = same prefix + short new user turn (agent follow-up)."""
import json, random, string, sys, time, urllib.request

kind, base, model = sys.argv[1:4]
sizes = [int(s) for s in sys.argv[4:]] or [8000, 32000]

def code_block(n_tokens, seed):
    rnd = random.Random(seed)
    out, approx = [], 0
    while approx < n_tokens:
        name = "".join(rnd.choices(string.ascii_lowercase, k=8))
        out.append(f"def {name}(items, limit={rnd.randint(1,99)}):\n    result = []\n    for i, x in enumerate(items):\n        if x % {rnd.randint(2,9)} == 0 and i < limit:\n            result.append(x * {rnd.randint(2,9)})\n    return result\n\n")
        approx += 60
    return "".join(out)

def call(messages):
    if kind == "ollama":
        body = {"model": model, "stream": False, "think": False, "messages": messages, "options": {"num_predict": 128, **json.loads(__import__("os").environ.get("OPTS", "{}"))}}
        url = base + "/api/chat"
    else:
        body = {"model": model, "stream": False, "messages": messages, "max_tokens": 128,
                "chat_template_kwargs": {"enable_thinking": False}, "cache_prompt": True}
        url = base + "/v1/chat/completions"
    t = time.time()
    r = json.load(urllib.request.urlopen(urllib.request.Request(url, json.dumps(body).encode(), {"Content-Type": "application/json"}), timeout=1800))
    wall = time.time() - t
    if kind == "ollama":
        pn, ps = r["prompt_eval_count"], r["prompt_eval_duration"] / 1e9
        gn, gs = r["eval_count"], r["eval_duration"] / 1e9
        reply = r["message"]["content"]
    else:
        tm = r["timings"]
        pn, ps = tm["prompt_n"], tm["prompt_ms"] / 1000
        gn, gs = tm["predicted_n"], tm["predicted_ms"] / 1000
        reply = r["choices"][0]["message"]["content"]
    return pn, ps, gn, gs, wall, reply

for size in sizes:
    seed = random.randint(0, 1 << 30)
    sys_msg = {"role": "system", "content": f"Session {seed}. You are a coding agent.\n" + code_block(size, seed)}
    m1 = [sys_msg, {"role": "user", "content": "Summarize what these functions do in one sentence."}]
    pn, ps, gn, gs, wall, reply = call(m1)
    print(f"{model[:28]:28s} cold {size//1000:>3}k: prefill {pn:6d} tok {pn/ps:7.0f} tok/s ({ps:5.1f}s) | gen {gn/gs:5.1f} tok/s | wall {wall:5.1f}s", flush=True)
    m2 = m1 + [{"role": "assistant", "content": reply}, {"role": "user", "content": "Now list three of the function names."}]
    pn, ps, gn, gs, wall, _ = call(m2)
    print(f"{model[:28]:28s} warm {size//1000:>3}k: prefill {pn:6d} tok {pn/max(ps,1e-6):7.0f} tok/s ({ps:5.1f}s) | gen {gn/gs:5.1f} tok/s | wall {wall:5.1f}s", flush=True)
