# Local coding agent on a Mac mini M4 Pro (48 GB): Ollama + GitHub Copilot

A headless Mac mini serving local coding models over the LAN with Ollama, used as a coding
agent from VS Code with GitHub Copilot (bring your own model). Includes the settings, the
benchmark scripts, raw results, and a [comparison of 7 local coding models](#model-comparison-7-local-coding-models):
Ornith 1.5, Qwen 3.6 35B-A3B, Qwen 3.8 27B, Flint, Nemotron 3.5 Lightning, Laguna XS 2.1 and Muse Glimmer.

Tested October 2026: Mac mini M4 Pro, 48 GB, macOS 26.5.1, Ollama 0.40.8 (MLX runner),
llama.cpp b11669, VS Code with the Ollama extension 0.0.13.

## Results

### Which model

| Model (Ollama tag) | Weights | Prefill 8k / 30k | Decode | Thinking | Use it for |
|---|---|---|---|---|---|
| **`ornith-1.5:35b`** (MoE, 3B active) | 23 GB | 677 / 494 tok/s | 59 tok/s | **on** | **everyday agent work** (recommended) |
| `qwen3.6:35b-mlx` (MoE, 3B active) | 23 GB | **713 / 551 tok/s** | **63 tok/s** | **off** (overthinks) | fast agent work, baseline |
| `qwen3.8:27b-mlx` (dense) | 18 GB | 99 / 91 tok/s | 28 tok/s | on (`medium`) | hard problems, when you can wait |

Why these three and not the others: see the [model comparison](#model-comparison-7-local-coding-models)
(Flint, Nemotron 3.5 Lightning, Laguna XS 2.1 and Muse Glimmer were tested and dropped).

A coding agent sends ~20-30k tokens on the first turn (system prompt, tool definitions,
files). Uncached, that takes **~45-60 s on the MoE models and ~5 min on the 27B**.

### Engine comparison (Qwen 3.6 35B-A3B, 4-bit, q8_0 KV cache, thinking off)

| Engine | Prefill 8k | Prefill 30k | Decode 8k / 30k |
|---|---|---|---|
| **Ollama MLX runner** (`-mlx` tag, nvfp4) | **708 tok/s** | **550 tok/s** | **60 / 52 tok/s** |
| Ollama GGUF Q4_K_M (llama.cpp runner) | 634 | 507 | 55 / 43 |
| llama.cpp `llama-server`, Q4_K_M, best of `-b/-ub` 512-4096 | 711 | 520 | 51 / 42 |

llama.cpp batch size matters (`-ub 512`: 639, `1024`: 690, `2048`: 711, `4096`: 700 tok/s),
but even tuned it only matches MLX at 8k and falls behind at 30k.
Published benchmarks claiming llama.cpp prefills 1.4-2.2x faster than MLX did not hold here.

### Decode, 27B dense (~500 tokens of generated code)

| | short context | 30k context |
|---|---|---|
| **Ollama MLX** (`qwen3.8:27b-mlx`) | **28.5 tok/s** | **25.8 tok/s** |
| Ollama GGUF + MTP (`qwen3.8:27b-mtp-q4_K_M`) | 25.4 tok/s | 20.7 tok/s |

### Prompt cache

Same prefix + a new user turn (what an agent does every step): **0.3 s at 8k, 0.4 s at 30k**.
The cache is what makes agent work usable. You only pay the cold prefill on the first
turn, after switching models, after a restart, or when the client changes the start of
the prompt.

### Findings

- **The `-mlx` tags already include MTP (multi-token prediction).** They contain the
  `mtp.*` tensors and Ollama uses them automatically. A dense 27B at 4-bit cannot decode
  faster than ~17 tok/s without speculation (273 GB/s / ~16 GB of weights); it does 28.5.
  The separate `-mtp-` GGUF tags bring the same trick to the slower llama.cpp runner.
- **MTP / DFlash speed up decode only, not prefill.**
- **q8_0 KV cache is free:** same prefill and decode speed as f16, ~2 GB less memory at 128k.
- **`num_batch` has no effect on the MLX runner** (708 / 711 / 712 tok/s at 512 / 2048 / 4096).
- **KV cache type is server-wide** (`OLLAMA_KV_CACHE_TYPE`), it cannot go in a Modelfile.
- **Thinking cannot be set in a Modelfile** (`PARAMETER think` is rejected). It is chosen per
  request. The 27B supports `false | low | medium | xhigh`, the 35B only on/off.
- **Ollama's GGUF blobs do not load in upstream llama.cpp** (non-standard
  `rope.dimension_sections`). For llama.cpp use `ggml-org/Qwen3.6-35B-A3B-GGUF`.
- Context: 128k with q8_0 KV loads in **23 GB (35B)** and **19.3 GB (27B)**.

### Thinking loops (Qwen 3.6 35B-A3B)

The Qwen 35B tends to overthink. 6 tricky prompts with thinking on and a 6,000-token cap:

| presence_penalty | did not finish |
|---|---|
| 0 (Qwen "precise coding") | 3 / 6, rerun: 4 / 6 |
| 1.5 (Qwen "thinking, general") | 2 / 6 |

Given 16,000 tokens, two of them still had no answer after ~11k thinking tokens, with 0%
verbatim repetition: not a copy-paste loop but endless re-checking. **With thinking off,
the 35B answered the same prompts correctly in 76-1,000 tokens.** Hence:

- 35B: **thinking off by default** (`"qwen3.6-35b-a3b-agent:latest": false`); turn it on only
  for a hard question you are willing to wait for.
- Ornith 1.5 does not have this problem (0 / 6 unfinished, see the comparison), so it runs with thinking on.
- All Modelfiles set **`num_predict 16384`**. The VS Code Ollama extension sends no output
  limit, so without a cap a runaway generation runs until the 128k context is full (~40 min).
- Test it yourself: `python3 bench/loops.py http://localhost:8080 qwen3.6-35b-a3b-agent 0`

## Model comparison: 7 local coding models

All measured on the same Mac mini (M4 Pro, 48 GB, Ollama 0.40.8, q8_0 KV cache, 128k context)
with [bench/run-model-tests.sh](bench/run-model-tests.sh). Raw logs: [results/](results/).

### Measured on this Mac

| Model (Ollama tag) | Type | Weights | Prefill 8k / 30k (tok/s) | Decode short / 30k (tok/s) | Thinking ON: unfinished of 6 | Thinking OFF: wrong answers |
|---|---|---|---|---|---|---|
| Flint 40B-A2B (`flint:latest`) | MoE, 2.5B active | 22 GB | **724** / 564 | **103** / **81** | 2 | 3 of 6 unfinished ⁴ |
| Qwen 3.6 35B-A3B (`qwen3.6:35b-mlx`) | MoE, 3B active | 23 GB | 713 / 551 | 80 / 68 | **4** | 0 |
| Ornith 1.5 35B-A3B (`ornith-1.5:35b`) ¹ | MoE, 3B active | 23 GB | 677 / 494 | 59 / 50 | **0** | 0 |
| Nemotron 3.5 Lightning (`nemotron-3.5-lightning:30b-a3b-nvfp4`) | hybrid Mamba-MoE, 3B active | 19 GB | 674 / **584** | 87 / 71 | **0** | 1 (2^61−1 "not prime") |
| Laguna XS 2.1 (`laguna-xs-2.1:nvfp4`) | MoE, 3B active | 20 GB | 568 / 435 | 107 / 69 | 3 | 1 (2^61−1 "not prime") |
| Qwen 3.8 27B (`qwen3.8:27b-mlx`) | dense | 18 GB | 99 / 91 | 29 / 26 | not tested ² | not tested ² |
| Muse Glimmer 30B (`muse-glimmer:30b-nvfp4`) | dense | 17 GB | 101 / 97 | 15 / 15 | not tested ² | not tested ² |
| Muse Glimmer 30B + DFlash (`muse-glimmer:30b-nvfp4-dflash`) | dense | 19 GB | 100 / 96 | 23 / 22 ³ | not tested ² | not tested ² |

¹ GGUF Q4_K_M on Ollama's llama.cpp runner; all others run on the MLX runner.
² The loop test was only run for MoE models; the dense models are too slow for agent work here anyway.
³ DFlash: +50% decode at 95% draft acceptance, prefill unchanged.
⁴ Flint keeps reasoning with thinking off: answers ran to the 6,000-token cap or came back empty.

- **Prefill** = cold prompt processing (unique prefix, no cache hit). Tokenizers differ: the same
  8k-token text is 6,780 tokens for Flint and 7,595 for Qwen, so Flint's lead is ~10% larger in practice.
- **Decode** = ~500 tokens of generated code after a short prompt / after a 30k-token context.
- **Thinking ON / OFF** = [bench/loops.py](bench/loops.py): 6 prompts that provoke overthinking,
  6,000-token cap. "Unfinished" = hit the cap without an answer.
- Every model passed the tool-call check. Laguna's known "empty output on macOS" bug did not occur.
- Flint's MLX build (`flint:40b-a2b-gguf-nvfp4`) needs Ollama 0.40.9 (pre-release on test day).

### Official agentic coding benchmarks (vendor-reported)

| Model | Terminal-Bench 2.1 | SWE-bench Pro | SWE-bench Verified |
|---|---|---|---|
| Qwen 3.8 27B | **73.0** | **61.7** ⁵ | not reported |
| Ornith 1.5 35B-A3B | 67.8 | 59.6 | **79.0** |
| Flint 40B-A2B | 54.9 | (89.7 on "v2", not comparable) | 74.2 |
| Qwen 3.6 35B-A3B | 52.5 ⁶ | 49.5 | 73.4 |
| Muse Glimmer 30B | 51.7 | 51.2 | 76.0 |
| Laguna XS 2.1 | 37.5 (Terminal-Bench **2.0**) | 47.6 | 70.9 |
| Nemotron 3.5 Lightning (NVFP4) | 23.5 | – | 52.8 |

⁵ on Qwen's corrected task set · ⁶ as listed on the Ornith card; Qwen's own card reports Terminal-Bench 2.0: 51.5

Terminal-Bench is the closest to Copilot agent mode / Hermes-style work (multi-step tool use in a
terminal); SWE-bench Pro is harder and less contaminated than SWE-bench Verified. Each vendor uses its
own harness and settings, so only large gaps are meaningful. Sources: the model cards of
[Qwen3.8-27B](https://huggingface.co/Qwen/Qwen3.8-27B), [Qwen3.6-35B-A3B](https://huggingface.co/Qwen/Qwen3.6-35B-A3B),
[Ornith-1.5-35B-A3B](https://huggingface.co/ornith-ai/Ornith-1.5-35B-A3B), [Flint](https://huggingface.co/RecursiveSI/flint),
[Laguna-XS-2.1](https://huggingface.co/poolside/Laguna-XS-2.1) and
[Nemotron-3.5-Lightning NVFP4](https://huggingface.co/nvidia/NVIDIA-Nemotron-3.5-Lightning-30B-A3B-NVFP4);
Muse Glimmer's numbers as listed on the Qwen3.8 and Ornith cards.

### Verdict

- **Ornith 1.5 35B-A3B: best all-rounder.** Strong benchmarks, no overthinking with thinking on,
  correct with thinking off, nearly as fast as Qwen. Reported to occasionally break tool calls in
  very long sessions: try it in real work before switching.
- **Qwen 3.6 35B-A3B: fast, but use it with thinking off.** With thinking on it left 3-4 of 6 prompts
  unfinished in two runs.
- **Nemotron 3.5 Lightning: fastest at long context** and thinks efficiently, but scores far lower on
  agentic coding benchmarks. Keep thinking on.
- **Flint: fastest overall**, but overthinks and cannot really switch thinking off. Needs the output cap.
- **Qwen 3.8 27B: highest benchmark scores**, but ~7x slower prefill than the MoE models. Fine for
  unattended work, painful interactively.
- **Laguna XS 2.1, Muse Glimmer: not recommended here** (slower and/or weaker; Muse is dense).

## Setup

### 1. Mac: prerequisites

System Settings: Remote Login on, automatic login on (FileVault must be off for that),
optionally Screen Sharing. Then:

```bash
sudo pmset -a disablesleep 1     # never sleep
sudo pmset -a womp 1             # wake on network
sudo pmset -a autorestart 1      # power on again after a power failure
```

### 2. Mac: Ollama

```bash
brew install ollama
cp macos/local.ollama.server.plist ~/Library/LaunchAgents/
launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/local.ollama.server.plist
echo 'export OLLAMA_HOST=127.0.0.1:8080' >> ~/.zshrc   # the CLI must know the port
```

The server listens on **port 8080 on all interfaces**. Change `OLLAMA_HOST` in the plist if
you want something else. Logs: `/tmp/ollama.log`.

### 3. Mac: GPU memory limit (40 of 48 GB)

```bash
sudo cp macos/local.iogpu.wiredlimit.plist /Library/LaunchDaemons/
sudo chown root:wheel /Library/LaunchDaemons/local.iogpu.wiredlimit.plist
sudo launchctl bootstrap system /Library/LaunchDaemons/local.iogpu.wiredlimit.plist
sysctl iogpu.wired_limit_mb      # -> 40960
```

### 4. Mac: models

```bash
ollama pull qwen3.6:35b-mlx      # 23 GB; rerun if it times out, it resumes
ollama pull qwen3.8:27b-mlx      # 18 GB
ollama create qwen3.6-35b-a3b-agent -f modelfiles/Modelfile.qwen3.6-35b-a3b-agent
ollama create qwen3.8-27b-agent     -f modelfiles/Modelfile.qwen3.8-27b-agent

# the recommended everyday model (see the model comparison above)
ollama pull ornith-1.5:35b       # 22 GB
ollama create ornith-1.5-agent      -f modelfiles/Modelfile.ornith-1.5-agent
```

Ornith reports no thinking levels to clients, so the VS Code extension ignores
`ollama.thinkingLevels` for it: it always runs with thinking on (the server default), which is
fine because it did not overthink in the tests.

The Modelfiles set a 128k context (Copilot cannot set `num_ctx` per request) and Qwen's
recommended sampling for coding (temperature 0.6, top_p 0.95, top_k 20).

### 5. VS Code: GitHub Copilot with the Ollama extension

Install the **Ollama** extension (publisher Ollama, id `ollama.ollama`), then add
[vscode/settings.json](vscode/settings.json) to your user `settings.json` with your Mac's IP.

- The extension always shows a built-in **"Ollama"** group in the model picker, listing every
  model at `ollama.endpoint`. Without `ollama.endpoint` it tries `127.0.0.1:11434` and shows
  `fetch failed: connect ECONNREFUSED`.
- Do **not** also add an `ollama-models` entry to `chatLanguageModels.json`: it is listed in
  addition to the built-in group, so every model appears twice.
- Hide the base tags (`qwen3.6:35b-mlx`, `qwen3.8:27b-mlx`, `ornith-1.5:35b`) with the eye icon in
  *Language Models*.
- The gear icon of the built-in group says *"Language model provider group Ollama for vendor
  ollama-models not found"*. That is harmless: the group is configured via `ollama.*` settings.
- Thinking comes only from `ollama.thinkingLevels` (read on every request, no reload).
  The extension has no reasoning-effort control in the model picker.

Picking another model in Copilot makes Ollama load it automatically (the other one is
unloaded). Start a new chat instead of switching mid-conversation, or the new model has to
prefill the whole conversation cold.

### 6. Optional: switch model / thinking from your laptop

```bash
export MAC_USER=your-mac-user MAC_HOST=192.168.1.50
./client/switch-model.sh ornith       # preload Ornith (thinking always on)
./client/switch-model.sh 35b          # preload the Qwen 35B, thinking off
./client/switch-model.sh 27b xhigh    # 27B with maximum thinking
./client/switch-model.sh 35b off
./client/switch-model.sh status
```

Runs in Git Bash on Windows or a terminal on macOS/Linux; needs `ssh`, `curl`, `jq`.

## Benchmarks

Copy `bench/` to the Mac and run:

```bash
# prefill, cold (unique prefix, no cache hit) and warm (same prefix + one new turn)
python3 bench/bench.py ollama http://localhost:8080 qwen3.6-35b-a3b-agent 8000 32000
OPTS='{"num_batch":2048}' python3 bench/bench.py ollama http://localhost:8080 qwen3.6-35b-a3b-agent 8000
python3 bench/bench.py llamacpp http://localhost:8081 any-name 8000 32000   # llama-server

# decode: ~500 tokens of code after a short prompt and after a 30k context
python3 bench/decode.py http://localhost:8080 qwen3.8-27b-agent 0 30000
```

llama.cpp settings used for the comparison:

```bash
llama-server -m Qwen3.6-35B-A3B-Q4_K_M.gguf --port 8081 -ngl 99 -c 131072 \
  -fa on -ctk q8_0 -ctv q8_0 -b 2048 -ub 2048 -np 1 --jinja
```

Test any Ollama model the same way (writes `results/<date>_<model>.log`):

```bash
bench/run-model-tests.sh flint:latest                 # full test set
bench/run-model-tests.sh some-dense-model decode-only # skip the loop test
```

Numbers depend on the prompt content, the context length and the software versions.
Treat them as a snapshot, and run the scripts on your own machine.

## How this was made

The setup, the benchmark scripts, all test runs and this repository were created by
**Claude Code with Claude Opus 5.5 (medium thinking effort)**, working with the repository owner.
Commands ran on the Mac mini over SSH; all numbers in the tables come from the raw logs in
[results/](results/).
