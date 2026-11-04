#!/bin/bash
# Run the polyglot subset against one model on the Mac.
# Usage: run.sh <run-name> <aider-model> [extra benchmark.py args...]
#   e.g. run.sh ornith ollama_chat/ornith-1.5-agent --num-tests 2
cd ~/bench/aider    # cloned by setup.sh; set MAC_HOST to the Mac's IP
NAME=$1; MODEL=$2; shift 2
docker run -d --name "polyglot-$NAME" \
    --memory=6g \
    -v "$PWD":/aider \
    -v "$PWD"/tmp.benchmarks/.:/benchmarks \
    -e AIDER_DOCKER=1 -e AIDER_BENCHMARK_DIR=/benchmarks \
    -e OLLAMA_API_BASE=http://${MAC_HOST:-192.168.1.50}:8080 \
    -e OPENAI_API_BASE=http://${MAC_HOST:-192.168.1.50}:8081/v1 -e OPENAI_API_KEY=none \
    aider-benchmark bash -c "pip install -q -e .[dev] 2>&1 | tail -2; \
      ./benchmark/benchmark.py $NAME --model $MODEL --edit-format diff --threads 1 --tries 2 \
        --num-ctx 131072 --exercises-dir polyglot-60 $*"
