# Coding quality: Aider Polyglot on the local models

The [speed tests](README.md) and the 6-prompt check show how fast the models are and whether they
overthink, but not which one writes the best code. This benchmark compares the coding quality of the
three main models **as they actually run on this Mac**: quantized, with the same server settings as in
daily use. Vendor benchmarks are measured on the full-precision models.

| Model | Server | Weights | Thinking |
|---|---|---|---|
| Ornith 1.5 35B-A3B (`ornith-1.5-agent`) | Ollama | GGUF Q4_K_M | on |
| Qwen3.8-Flash-Next Gyro-S (`qwen3.8-flash-next-gyro-gyro-s`) | [Strata](STRATA.md) | Gyro-S, ~2-bit | off |
| Qwen 3.8 27B (`qwen3.8-27b-agent`) | Ollama | MLX nvfp4 | off |

## The benchmark

[Aider's polyglot benchmark](https://github.com/Aider-AI/polyglot-benchmark): Exercism exercises
picked as the hardest of their tracks. The model gets the instructions and a stub file and edits the
code; the exercise's unit tests decide. If they fail, the model sees the test output and gets a second
try. The score is the share of exercises whose tests pass after the second try.

**Subset:** 30 Python + 30 JavaScript exercises (the full set is 225 in six languages), picked at
random with a fixed seed so every model gets the same 60: [bench/polyglot/SUBSET.txt](bench/polyglot/SUBSET.txt).
Python and JavaScript are the closest to the owner's daily work (Python, TypeScript).

With 60 exercises the margin of error is about ±12 percentage points: only large differences between
the models are meaningful.

## Setup

The harness runs on the laptop (WSL with Docker); the Mac only serves the model.

```bash
bench/polyglot/setup.sh      # clones aider + polyglot-benchmark, builds the subset and the Docker image
```

| | |
|---|---|
| Harness | Aider `benchmark/benchmark.py` (aider 0.86.3.dev, 5dc9490), polyglot-benchmark 7e0611e |
| Edit format | `diff` (search/replace blocks) |
| Tries per exercise | 2 |
| Parallel requests | 1 (the servers serve one request at a time) |
| Context | 128k (`--num-ctx 131072` for Ollama; Strata `--context 128k`) |
| Output cap | 16,384 tokens per answer (Modelfile `num_predict`; Strata) |

Run each model with [bench/polyglot/run.sh](bench/polyglot/run.sh) (`MAC_HOST` = the Mac's IP); it starts a
detached Docker container, so a run survives a closed terminal:

```bash
bench/polyglot/run.sh ornith ollama_chat/ornith-1.5-agent                                      # Ollama
bench/polyglot/run.sh flash openai/qwen3.8-flash-next-gyro-gyro-s --reasoning-effort none     # Strata
```

## Results

| Model | Python (30) | JavaScript (30) | **Total (60)** | Passed on 1st try | Malformed edits | Run time |
|---|---|---|---|---|---|---|
| Ornith 1.5 35B-A3B, thinking on | 19 (63%) | 17 (57%) | **36 (60%)** | 12 (20%) | 4 of 60 | 4 h 02 min |
| Qwen3.8-Flash-Next Gyro-S, thinking off | 23 (77%) | 19 (63%) | **42 (70%)** | 18 (30%) | 2 of 60 | 1 h 51 min |
| Qwen 3.8 27B, thinking off | TBD | TBD | **TBD** | TBD | TBD | TBD |

- **Ornith** solved most exercises on the second try, after seeing the failing tests: 12 on the first
  try, 36 after the second. No syntax errors or placeholder ("lazy") code; 4 answers had an edit block
  that did not match the file. ~11,400 output tokens and ~4 min per exercise, mostly thinking.
- **Flash-Next** without thinking: 18 on the first try, 42 after the second. No syntax errors or
  placeholder code; 2 answers had an edit block that did not match the file. ~1,800 output tokens and
  ~1.8 min per exercise: about 6× fewer tokens and twice as fast as Ornith with thinking.

Raw results (per exercise: Aider's result JSON and the full chat with the model's edits and the test
output): [results/polyglot/](results/polyglot/).

## Verdict

TBD.
