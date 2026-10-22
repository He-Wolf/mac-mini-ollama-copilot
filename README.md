# Local coding agent on a Mac mini M4 Pro (48 GB): Ollama + Qwen + GitHub Copilot

A headless Mac mini serving Qwen 3.6 35B-A3B and Qwen 3.8 27B over the LAN with Ollama,
used as a coding agent from VS Code with GitHub Copilot (bring your own model).
Includes the settings, the benchmark scripts and measured results.

Tested October 2026: Mac mini M4 Pro, 48 GB, macOS 26.5.1, Ollama 0.40.8 (MLX runner),
llama.cpp b11669, VS Code with the Ollama extension 0.0.13.

## Results

### Which model

| Model (Ollama tag) | Weights | Prefill 8k / 30k | Decode | Use it for |
|---|---|---|---|---|
| `qwen3.6:35b-mlx` (MoE, 3B active) | 23 GB | **708 / 550 tok/s** | **60 tok/s** | everyday agent work |
| `qwen3.8:27b-mlx` (dense) | 18 GB | ~99 / 96 tok/s | 28 tok/s | hard problems, when you can wait |

A coding agent sends ~20-30k tokens on the first turn (system prompt, tool definitions,
files). Uncached, that takes **~45 s on the 35B and ~5 min on the 27B**.

### Engine comparison (35B-A3B, 4-bit, q8_0 KV cache, thinking off)

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
```

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
- Hide the base tags (`qwen3.6:35b-mlx`, `qwen3.8:27b-mlx`) with the eye icon in
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
./client/switch-model.sh 35b          # preload the 35B, thinking on
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

Numbers depend on the prompt content, the context length and the software versions.
Treat them as a snapshot, and run the scripts on your own machine.
