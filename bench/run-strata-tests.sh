#!/bin/bash
# Full test set for the model Strata is serving (OpenAI API on :8081), up to 128k context.
# Same prompts and sizes as run-model-tests.sh. Writes results/<date>_strata_<model>.log
# Usage (on the Mac, from the repo root): bench/run-strata-tests.sh
cd "$(dirname "$0")/.."
U=${STRATA_URL:-http://localhost:8081}
export API_KEY=${API_KEY:-$(~/.local/bin/strata launch --show-key 2>/dev/null | tail -1)}
M=$(curl -s -H "Authorization: Bearer $API_KEY" $U/v1/models | python3 -c 'import sys,json;print(json.load(sys.stdin)["data"][0]["id"])')
mkdir -p results
{
echo "################ $M ($(~/.local/bin/strata --version 2>&1 | head -1))"
echo "date: $(date '+%F %T %Z') | $(sysctl -n machdep.cpu.brand_string) | macOS $(sw_vers -productVersion) | iogpu.wired_limit_mb=$(sysctl -n iogpu.wired_limit_mb)"
python3 bench/oa_tests.py $U $M tool
python3 bench/bench.py llamacpp $U $M 8000 32000 120000     # cold + warm prefill, up to ~113k tokens
python3 bench/oa_tests.py $U $M decode 0 30000
python3 bench/oa_tests.py $U $M loops 6000                  # thinking on, then off
sysctl vm.swapusage
} 2>&1 | tee results/$(date +%F)_strata_$M.log
