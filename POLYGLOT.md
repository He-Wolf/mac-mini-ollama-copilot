# Coding quality: Aider Polyglot on the local models

The [speed tests](README.md) and the 6-prompt check show how fast the models are and whether they
overthink, but not which one writes the best code. This benchmark compares the coding quality of the
three main models **as they actually run on this Mac**: quantized, with the same server settings as in
daily use. Vendor benchmarks are measured on the full-precision models.

| Model | Server | Weights | Thinking |
|---|---|---|---|
| Ornith 1.5 35B-A3B (`ornith-1.5-agent`) | Ollama | GGUF Q4_K_M | on (Ornith has no levels) |
| Qwen3.8-Flash-Next Gyro-S (`qwen3.8-flash-next-gyro-gyro-s`) | [Strata](STRATA.md) | Gyro-S, ~2-bit | `medium` |
| Qwen 3.8 27B (`qwen3.8-27b-agent`) | Ollama | MLX nvfp4 | `medium` |

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
| Harness | Aider `benchmark/benchmark.py` (aider TBD), polyglot-benchmark 7e0611e |
| Edit format | TBD |
| Tries per exercise | 2 |
| Parallel requests | 1 (the servers serve one request at a time) |
| Context | 128k (`num_ctx 131072` in the Modelfiles; Strata `--context 128k`) |
| Output cap | 16,384 tokens per answer |

Run command: TBD.

## Results

| Model | Python (30) | JavaScript (30) | **Total (60)** | Passed on 1st try | Malformed edits | Run time |
|---|---|---|---|---|---|---|
| Ornith 1.5 35B-A3B | TBD | TBD | **TBD** | TBD | TBD | TBD |
| Qwen3.8-Flash-Next Gyro-S | TBD | TBD | **TBD** | TBD | TBD | TBD |
| Qwen 3.8 27B | TBD | TBD | **TBD** | TBD | TBD | TBD |

Raw results: TBD.

## Verdict

TBD.
