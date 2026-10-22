#!/bin/bash
# Full test set for one Ollama model; output goes to results/<date>_<model>.log
# Usage: run-model-tests.sh <model> [decode-only]
export PATH=/opt/homebrew/bin:$PATH OLLAMA_HOST=127.0.0.1:8080
B=~/ollama/bench; m="$1"; out="$B/results/$(date +%F)_$(echo "$m" | tr ':/' '__').log"
{
echo "################ $m"
echo "date: $(date '+%F %T %Z') | ollama $(ollama --version 2>&1 | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' | head -1) | $(sysctl -n machdep.cpu.brand_string) $(( $(sysctl -n hw.memsize) / 1073741824 )) GB | macOS $(sw_vers -productVersion) | KV q8_0, num_ctx 131072"
ollama show $m | sed -n '/Model/,/License/p' | grep -E 'architecture|parameters|quantization|context length|completion|tools|thinking|vision|levels|default|temperature|top_|presence|draft'
curl -s localhost:8080/api/chat -d "{\"model\":\"$m\",\"stream\":false,\"think\":false,\"messages\":[{\"role\":\"user\",\"content\":\"Read the file src/main.py\"}],\"tools\":[{\"type\":\"function\",\"function\":{\"name\":\"read_file\",\"description\":\"Read a file\",\"parameters\":{\"type\":\"object\",\"properties\":{\"filePath\":{\"type\":\"string\"}},\"required\":[\"filePath\"]}}}]}" \
  | python3 -c 'import sys,json; d=json.load(sys.stdin); print("tool call:", json.dumps(d.get("message",{}).get("tool_calls")) if "message" in d else d)'
python3 $B/bench.py ollama http://localhost:8080 $m 8000 32000
python3 $B/decode.py http://localhost:8080 $m 0 30000
if [ "$2" != "decode-only" ]; then
  echo "---- loops, thinking ON"; python3 $B/loops.py http://localhost:8080 $m 0
  echo "---- loops, thinking OFF"; THINK=false python3 $B/loops.py http://localhost:8080 $m 0
fi
ollama ps | sed -n 2p
grep -E "speculative decode stats" ~/Library/Logs/ollama.log | tail -1 | cut -c1-220
} 2>&1 | tee "$out"
