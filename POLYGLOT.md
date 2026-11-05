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
OPENAI_PORT=8080 bench/polyglot/run.sh 27b openai/qwen3.8-27b-agent --reasoning-effort none   # Ollama, thinking off
```

The 27B runs through Ollama's OpenAI endpoint because `--reasoning-effort none` switches thinking off
there.

## Results

| Model | Python (30) | JavaScript (30) | **Total (60)** | Passed on 1st try | Malformed edits | Run time |
|---|---|---|---|---|---|---|
| Ornith 1.5 35B-A3B, thinking on | 19 (63%) | 17 (57%) | **36 (60%)** | 12 (20%) | 4 of 60 | 4 h 02 min |
| Qwen3.8-Flash-Next Gyro-S, thinking off | 23 (77%) | 19 (63%) | **42 (70%)** | 18 (30%) | 2 of 60 | 1 h 51 min |
| Qwen 3.8 27B, thinking off | 15 (50%) | 19 (63%) | **34 (57%)** | 12 (20%) | 5 of 60 | 3 h 52 min |

- **Ornith** solved most exercises on the second try, after seeing the failing tests: 12 on the first
  try, 36 after the second. No syntax errors or placeholder ("lazy") code; 4 answers had an edit block
  that did not match the file. ~11,400 output tokens and ~4 min per exercise, mostly thinking.
- **Flash-Next** without thinking: 18 on the first try, 42 after the second. No syntax errors or
  placeholder code; 2 answers had an edit block that did not match the file. ~1,800 output tokens and
  ~1.8 min per exercise: about 6× fewer tokens and twice as fast as Ornith with thinking.
- **27B** without thinking: 12 on the first try, 34 after the second. 3 answers got stuck repeating the
  same edit block (99–144 times) until the 16k output cap; 5 answers had an edit block that did not
  match the file, and 3 times it asked a question instead of editing. ~2,000 output tokens but
  ~3.8 min per exercise: the dense model is the slowest per token.

All runs use Aider's default `temperature 0` (greedy). A second 27B run with Qwen's thinking-off sampling
(temperature 0.7, top_p 0.8, presence_penalty 1.5) scored 32/60 (53%), still with 2 runaway answers:
the sampling settings do not explain the gap.

Raw results (per exercise: Aider's result JSON and the full chat with the model's edits and the test
output): [results/polyglot/](results/polyglot/).

## Verdict

- **Flash-Next (Strata) writes the best code of the three and is also the fastest**: 70%, half the run
  time of the others and the fewest broken edits. Its lead (10–13 points) is about the margin of error,
  so it is likely better, not proven.
- **The 27B brings no quality gain over the MoE models.** Under the same conditions (thinking off) it
  scored 8 points below Flash-Next, was twice as slow and was the only model that looped.
- **Ornith reached 60% with thinking on**, at ~6× the output tokens of the Qwens without thinking.

The test covers single-file Python and JavaScript exercises; it does not measure tool use, long
agentic sessions or the other languages in daily use (C#, Terraform, Bash).
