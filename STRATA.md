# Qwen3.8-Flash-Next (125B MoE) with Strata on a 48 GB Mac mini

A 125B-parameter model (6B active per token) on the same Mac mini M4 Pro 48 GB, served by
[Strata](https://github.com/Niko1221/Strata) instead of Ollama. The goal: a much bigger model than
the 35B-A3B at usable speed, with the full 128k context an agent needs.

Tested 3 November 2026: Strata 0.2.10 (engine 0.1.56, Metal), macOS 26.5.1.
Raw logs: [results/](results/) (files starting with `2026-11-03`). All three models measured on
the same day with the same scripts, 128k context, 8-bit KV cache, thinking off.

## Results

### Speed, compared with the Ollama models

| | **Flash-Next Gyro-S** (Strata) | Ornith 1.5 35B-A3B (Ollama) | Qwen 3.8 27B dense (Ollama) |
|---|---|---|---|
| Parameters (total / active) | 125B / 6B | 35B / 3B | 27B / 27B |
| Cold prefill 8k | 280 tok/s (27 s) | **676 tok/s** (11 s) | 99 tok/s (1.3 min) |
| Cold prefill 30k | 281 tok/s (1.8 min) | **491 tok/s** (1 min) | 91 tok/s (5.5 min) |
| Cold prefill ~113k | **279 tok/s (6.7 min)** | 245 tok/s (7.7 min) | 67 tok/s (28 min) |
| Warm turn (cached prefix + new question), 8k / 30k / 113k | 0.5 / 0.5 / 0.5 s | 0.2 / 0.3 / 0.6 s | 0.4 / 0.5 / 0.9 s |
| Decode, short / 30k context | 31 / 31 tok/s | **57 / 48 tok/s** | 27 / 25 tok/s |
| Decode after ~69k context ¹ | 32 tok/s | 33 tok/s | 17 tok/s |
| Generation after ~113k context ² | 26 tok/s | 27 tok/s | 12 tok/s |
| Memory with 128k context | 40.4 GB | 22 GB | 30 GB |

¹ ~500 tokens of code ([bench/oa_tests.py](bench/oa_tests.py) / [bench/decode.py](bench/decode.py) `decode 120000`;
the filler text tokenizes to ~69k tokens). ² The 128-token reply in the ~113k prefill run.

- **Flash-Next's speed is flat from 8k to 113k** (279-281 tok/s prefill, 31-32 tok/s decode); the
  Ollama models slow down as the context grows.
- **At short and medium context Ornith is about 2× faster.** Around 100k tokens the two meet:
  Flash-Next reads a full 128k context faster than Ornith, and decodes at the same speed.
- **The 27B is the slowest everywhere**, and at 113k it needs 28 minutes for a cold prompt.
- A Copilot agent's first turn (~29k tokens) takes **~1.8 min cold** on Flash-Next (Ornith ~1 min, the
  27B ~5.5 min). After that the prompt cache answers each turn in ~0.5 s.

### Quality checks

| | Flash-Next Gyro-S | Ornith 1.5 |
|---|---|---|
| Tool call (OpenAI API) | ✅ | ✅ |
| Thinking ON: unfinished of 6 | **0** | 0 |
| Thinking ON: avg thinking tokens | ~2,280 | ~1,600 |
| Thinking OFF: wrong answers | **0 of 6** | 0 of 6 |

Same 6 prompts as in the [model comparison](README.md#model-comparison-9-local-coding-models)
([bench/oa_tests.py](bench/oa_tests.py) `loops`, 6,000-token cap). With thinking off it answered
all six correctly.
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
  --tune skip --access lan --no-api-key --port 8081 --yes --no-tui --restart \
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
| `--access lan --no-api-key --port 8081` | Reachable from other machines on the LAN without a key, like Ollama. Port 8081 keeps Ollama's 8080 free. Strata warns that anyone on the network can then use the model *and its tools*: the tools are MCP servers configured in Strata, and there are none here (`/mcp` reports 0). Leave out `--no-api-key` to require a key (`strata launch --show-key`), or use `--access local` to keep it on the Mac. |

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

- **API:** OpenAI-compatible at `http://<mac>:8081/v1` (chat completions with tool calls) and
  Anthropic-compatible at `http://<mac>:8081`. Model id: `qwen3.8-flash-next-gyro-gyro-s`.
- **Thinking off:** `"reasoning_effort": "none"` (or `"chat_template_kwargs": {"enable_thinking": false}`).
- **One request at a time:** the DFlash2 drafter makes Strata serve requests one by one.

### VS Code: GitHub Copilot custom endpoint

The Ollama extension only talks to Ollama, so Strata is added as a Copilot custom endpoint (bring
your own model). Add the group from [vscode/chatLanguageModels.strata.json](vscode/chatLanguageModels.strata.json)
to `chatLanguageModels.json` in your VS Code user folder (`%APPDATA%\Code\User` on Windows,
`~/Library/Application Support/Code/User` on macOS) and replace `192.168.1.50` with your Mac's IP.

- No API key is needed (`--no-api-key`). With a key, Copilot does not ask for it on its own: a
  request fails with "missing or wrong API key" until the key is set for the "Strata" group in
  *Manage Models*.
- **Thinking:** choose the reasoning effort in the model picker: `medium` = thinking on (default),
  `none` = thinking off. Both gave correct answers in the tests; `none` answers faster.
- `maxInputTokens` 114,688 + `maxOutputTokens` 16,384 = the 128k context.
- Strata runs on **port 8081** so it never collides with Ollama's 8080. While Strata runs, Ollama is
  stopped and the Ollama models in the picker show connection errors.
- Start a new chat for Flash-Next: the first turn of a Copilot agent (~29k tokens) takes ~1.8 min cold.
- **Back to Ollama:** `~/.local/bin/strata launch --stop`, then
  `launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/local.ollama.server.plist`.
  A reboot also restores Ollama and the 40 GB GPU limit; Strata does not start at boot.

### Switching from the laptop

[client/switch-model.sh](client/switch-model.sh) switches between the two servers with one command
(after installing Strata once, steps 1-3 above):

```bash
export MAC_USER=your-mac-user MAC_HOST=192.168.1.50
./client/switch-model.sh strata     # stop Ollama, GPU limit 42 GB (asks for the Mac password), start Strata
./client/switch-model.sh ornith     # stop Strata, start Ollama, load Ornith
./client/switch-model.sh status     # what is running: Ollama models and/or Strata
```

## Benchmarks

```bash
bench/run-strata-tests.sh        # tool call, prefill 8k/30k/120k, decode, thinking loops
```

[bench/oa_tests.py](bench/oa_tests.py) runs the decode, thinking-loop and tool-call tests over the
OpenAI API (Strata, llama-server); [bench/bench.py](bench/bench.py) `llamacpp` mode measures prefill
from the `timings` Strata returns.

## Verdict

- **Flash-Next on Strata is a usable "big model" mode for this Mac:** a 125B model with 128k context,
  correct on every check, at ~280 tok/s prefill and ~31 tok/s decode at any context length.
- **It replaces the Qwen 3.8 27B as the "think harder" option:** 3-4× faster prefill, faster decode,
  and much faster at long context (6.7 min vs. 28 min for a cold 113k prompt).
- **Ornith stays the everyday model:** about 2× faster up to ~30k tokens, which is where most agent
  turns are, with a quarter of the memory.
- **The cost:** Strata needs ~40 GB, so it cannot run next to Ollama, macOS keeps only ~6-8 GB,
  and switching between the two means restarting servers.
