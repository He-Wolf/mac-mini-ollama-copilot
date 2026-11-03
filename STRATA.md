# Qwen3.8-Flash-Next (125B MoE) with Strata on a 48 GB Mac mini

A 125B-parameter model (6B active per token) on the same Mac mini M4 Pro 48 GB, served by
[Strata](https://github.com/Niko1221/Strata) instead of Ollama. The goal: a much bigger model than
the 35B-A3B at usable speed, with the full 128k context an agent needs.

Tested 3 November 2026: Strata 0.2.10 (engine 0.1.56, Metal), macOS 26.5.1.
Raw logs: [results/](results/) (files starting with `2026-11-03_strata`).

## Results

### Speed, compared with the Ollama models

| | **Flash-Next Gyro-S** (Strata) | Tiel Coder 35B-A3B (Ollama) | Qwen 3.8 27B dense (Ollama) |
|---|---|---|---|
| Parameters (total / active) | 125B / 6B | 35B / 3B | 27B / 27B |
| Cold prefill 8k | **280 tok/s** (27 s) | 647 tok/s | TBD (99 tok/s on 22 Oct) |
| Cold prefill 30k | **281 tok/s** (1.8 min) | 483 tok/s | TBD (91 tok/s on 22 Oct) |
| Cold prefill ~113k | **279 tok/s** (6.7 min) | not measured | TBD |
| Warm turn (cached prefix + new question) | 0.5 s at any length | 0.2-0.3 s | TBD |
| Decode, short / 30k context | **31 / 31 tok/s** | 66 / 52 tok/s | 28.5 / 25.8 tok/s |
| Decode after ~113k context | ~26 tok/s ¹ | not measured | TBD |
| Memory | 40.4 GB | 23 GB | 19.3 GB |

¹ Generation speed of the 128-token reply in the 113k prefill run (thinking off).

- **Prefill does not slow down with context:** 279-281 tok/s from 8k to 113k. The Ollama models lose
  speed as the context grows.
- A Copilot agent's first turn (~29k tokens) takes **~1.8 min cold** (Tiel ~1 min, the 27B ~5 min).
  After that the prompt cache answers each turn in ~0.5 s.

### Quality checks

| | Flash-Next Gyro-S | Tiel Coder | Ornith 1.5 |
|---|---|---|---|
| Tool call (OpenAI API) | ✅ | ✅ | ✅ |
| Thinking ON: unfinished of 6 | **0** | 0 | 0 |
| Thinking ON: avg thinking tokens | ~2,280 | ~1,430 | ~1,600 |
| Thinking OFF: wrong answers | **0 of 6** | 2 of 6 | 0 of 6 |

Same 6 prompts as in the [model comparison](README.md#model-comparison-9-local-coding-models)
([bench/oa_tests.py](bench/oa_tests.py) `loops`, 6,000-token cap). With thinking off it answered
all six correctly, including details the smaller models got wrong (2^61−1 is the 9th Mersenne prime).
Answers are fairly long: 400-1,200 tokens with thinking off.

No official agentic coding benchmarks are published for Qwen3.8-Flash-Next or the Gyro-S pack.

## Why Gyro-S

Strata offers several packs of the same model. On a Mac, the GPU and CPU share one memory pool, so
what matters is the Mac memory table in Strata's [MAC.md](https://github.com/Niko1221/Strata/blob/main/docs/MAC.md),
not the PC table in MODELS.md ("With 48 GB, Q2_0 and IQ2_XS fit" means 48 GB of RAM *plus* a
graphics card):

| Pack | Needs on a Mac | KL divergence vs. the full model (lower is better) |
|---|---|---|
| **Gyro-S** | **~38 GB** | 0.268 |
| Q2_0 | ~46 GB | 0.312 |
| IQ2_XS | not offered on Mac | 0.236 |

- **Gyro-S fits in memory**, all experts included. Q2_0 does not fit in 48 GB and streams experts from
  the SSD on every token. A [test of Q2_0 on an M5 Pro 48 GB](https://elitetestengineering.substack.com/p/qwen-38-flash-next-strata-on-a-mac)
  measured 19-22 tok/s decode; Strata also turns the draft model off while streaming.
- Gyro-S is also closer to the full model than Q2_0 by KL divergence.
- The 58.5 GB file contains a 28.8 GB n-gram table that always stays on the SSD (by design, at every
  memory size). Strata reads a few rows of it per token; it costs no measurable speed here.

### Where everything is

| Part | Where | Size |
|---|---|---|
| All 24,576 experts | memory ("expert arena") | 26.2 GB |
| Dense weights (attention, shared parts) | memory | 3.6 GB |
| Draft model (DFlash2), KV cache, conversation cache, buffers | memory | ~10 GB |
| N-gram table | SSD | 28.8 GB |

While a prompt is read, Strata borrows part of the expert arena for buffers (4.9 GB with
4096-token chunks). The least-used experts are read back from the SSD afterwards.

## Setup

### 1. Install

```bash
curl -fsSL https://github.com/Niko1221/Strata/releases/latest/download/install.sh -o install.sh
sh install.sh            # no sudo; installs to ~/.local/share/strata, command ~/.local/bin/strata
```

### 2. Make room

Strata needs ~40 GB, so Ollama cannot run at the same time:

```bash
launchctl bootout gui/$(id -u)/local.ollama.server         # stop Ollama
sudo sysctl iogpu.wired_limit_mb=43008                      # 42 GB for the GPU (until reboot)
```

The default 40 GB limit is not enough. 42 GB leaves macOS ~6-8 GB: fine for a headless Mac or light
GUI use, but heavy apps will push it into swap.

### 3. Start

```bash
~/.local/bin/strata launch --model gyro-s --family gyro --context 128k --vision off \
  --tune skip --access local --port 8080 --yes --no-tui --restart \
  --set STRATA_METAL_STREAM=1 --set STRATA_METAL_ARENA_GB=30 \
  --set conversation-cache-mib=1024 --set STRATA_METAL_PROMPT_CHUNK=4096
```

The first run downloads ~65 GB (model, draft layer, DFlash2 drafter).

| Setting | Why |
|---|---|
| `STRATA_METAL_STREAM=1`, `STRATA_METAL_ARENA_GB=30` | Strata's setup picks `STRATA_METAL_STREAM=0` for Gyro-S on 48 GB, which maps the whole 58.5 GB file (n-gram table included) into GPU memory. The first request then never starts and Strata's watchdog restarts the engine every ~1.5-2 min. "Streaming" mode with an arena big enough for all experts keeps every expert in memory and the table on the SSD. Strata caps the arena at what fits (26.2 GB here). |
| `conversation-cache-mib=1024` | Strata parks finished conversations in RAM so a returning chat skips the cold prefill. By default it took 8 GB; 1 GB holds about one long conversation. |
| `STRATA_METAL_PROMPT_CHUNK=4096` | +13% prefill (see below). |
| `--vision off` | Saves ~0.9 GB (text only). |
| `--context 128k` | KV cache int8 (default), ~1.7 GB at 128k. |
| `--access local` | API only on the Mac. Use `--access lan` to reach it from other machines; Strata then requires an API key (`strata launch --show-key`). |

### Tuning (8k cold prefill / short decode)

| Variant | Prefill | Decode |
|---|---|---|
| Default (DFlash2 drafter, 1024-token chunks) | 247 tok/s | 33.1 tok/s |
| CPU share in prefill off (`STRATA_PREFILL_CPU_SHARE=0`) | 245 | 32.2 |
| MTP draft layer instead of DFlash2 (`--drafting mtp`) | 238 | 28.7 |
| Strata's tuner (`--tune quick`) | 251 | 31.8 |
| Chunks of 2048 | 270 (30k: 266) | 32.5 |
| **Chunks of 4096** | **279 (30k: 280)** | **32.5** |
| Chunks of 8192 | 30k: 274 | – |

The DFlash2 drafter has ~85-90% of its drafted tokens accepted.

## Using it

- **API:** OpenAI-compatible at `http://<mac>:8080/v1` (chat completions with tool calls) and
  Anthropic-compatible at `http://<mac>:8080`. Model id: `qwen3.8-flash-next-gyro-gyro-s`.
- **Thinking off:** `"reasoning_effort": "none"` (or `"chat_template_kwargs": {"enable_thinking": false}`).
- **VS Code Copilot:** the Ollama extension does not work with Strata; add it as a custom
  OpenAI-compatible endpoint.
- **One request at a time:** the DFlash2 drafter makes Strata serve requests one by one.
- **Back to Ollama:** `~/.local/bin/strata launch --stop`, then
  `launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/local.ollama.server.plist`.
  A reboot also restores Ollama and the 40 GB GPU limit.

## Benchmarks

```bash
bench/run-strata-tests.sh        # tool call, prefill 8k/30k/120k, decode, thinking loops
```

[bench/oa_tests.py](bench/oa_tests.py) runs the decode, thinking-loop and tool-call tests over the
OpenAI API (Strata, llama-server); [bench/bench.py](bench/bench.py) `llamacpp` mode measures prefill
from the `timings` Strata returns.

## Verdict

TBD after the Qwen 3.8 27B 128k run.
