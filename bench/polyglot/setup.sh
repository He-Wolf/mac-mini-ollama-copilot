#!/bin/bash
# Set up Aider's polyglot benchmark (Linux or WSL with Docker) with a fixed subset: 30 Python + 30 JavaScript exercises.
set -e
docker version --format 'docker {{.Server.Version}}'
mkdir -p ~/bench && cd ~/bench
[ -d aider ] || git clone -q --depth 1 https://github.com/Aider-AI/aider.git
cd aider
mkdir -p tmp.benchmarks
[ -d tmp.benchmarks/polyglot-benchmark ] || git clone -q --depth 1 https://github.com/Aider-AI/polyglot-benchmark tmp.benchmarks/polyglot-benchmark
echo "aider $(git log -1 --format='%h %cs')"
echo "polyglot $(git -C tmp.benchmarks/polyglot-benchmark log -1 --format='%h %cs')"

# fixed subset: 30 Python + 30 JavaScript exercises, seed 42, same for every model
python3 - <<'PY'
import os, random, shutil
src = "tmp.benchmarks/polyglot-benchmark"; dst = "tmp.benchmarks/polyglot-60"
shutil.rmtree(dst, ignore_errors=True)
rnd = random.Random(42); picked = []
for lang in ("python", "javascript"):
    p = os.path.join(src, lang, "exercises", "practice")
    if not os.path.isdir(p): continue
    ex = sorted(os.listdir(p)); chosen = sorted(rnd.sample(ex, 30))
    for e in chosen:
        shutil.copytree(os.path.join(p, e), os.path.join(dst, lang, "exercises", "practice", e))
    picked.append(f"{lang} ({len(ex)}): " + ", ".join(chosen))
open(os.path.join(dst, "SUBSET.txt"), "w").write("\n".join(picked) + "\n")
print("\n".join(picked))
PY

./benchmark/docker_build.sh > /tmp/polyglot-build.log 2>&1 && echo "docker image built" || { tail -20 /tmp/polyglot-build.log; exit 1; }
docker images --format '{{.Repository}}:{{.Tag}} {{.Size}}' | grep -i aider
