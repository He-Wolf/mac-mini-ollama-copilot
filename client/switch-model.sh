#!/bin/bash
# Switch the Ollama server on the Mac to another model and set the thinking level
# used by the VS Code Ollama extension. Run it on the machine where VS Code runs
# (Git Bash on Windows, or a terminal on macOS/Linux). Needs ssh, curl and jq.
#
# Usage: ./switch-model.sh <27b|35b|ornith|tiel> [off|on|low|medium|xhigh]   (thinking; default: 35b off, 27b on)
#        ./switch-model.sh strata     (Qwen3.8-Flash-Next on Strata instead of Ollama, see STRATA.md)
#        ./switch-model.sh status
#
# Strata needs ~40 GB, so Ollama and Strata never run together: "strata" stops Ollama and raises
# the GPU limit to 42 GB (sudo, asks for the Mac password); an Ollama model stops Strata and
# starts Ollama again. A reboot of the Mac always comes back with Ollama and the 40 GB limit.
#
# Thinking cannot be set on the server (Ollama Modelfiles have no "think" option).
# The VS Code Ollama extension sends it with every request, taken from the
# "ollama.thinkingLevels" setting, so this script edits that setting.
# It applies to the next request, no window reload needed.
#   27b: off | low | medium | xhigh   ("on" = medium)
#   35b: off | on                      (any level = on)
#   ornith, tiel: always on in VS Code. They report no thinking levels, so the extension
#           ignores ollama.thinkingLevels for them and the server default (thinking on) applies.

# --- edit these, or set them as environment variables ---
REMOTE_USER="${MAC_USER:-your-mac-user}"
REMOTE_HOST="${MAC_HOST:-192.168.1.50}"
SERVER_PORT="${MAC_PORT:-8080}"
STRATA_PORT="${STRATA_PORT:-8081}"

case "$(uname -s)" in
    MINGW*|MSYS*|CYGWIN*) VSCODE_SETTINGS="$APPDATA/Code/User/settings.json" ;;
    Darwin)               VSCODE_SETTINGS="$HOME/Library/Application Support/Code/User/settings.json" ;;
    *)                    VSCODE_SETTINGS="$HOME/.config/Code/User/settings.json" ;;
esac

# --- parse args ---
case "$1" in
    27b)    MODEL="qwen3.8-27b-agent" ;;
    35b)    MODEL="qwen3.6-35b-a3b-agent" ;;
    ornith) MODEL="ornith-1.5-agent" ;;
    tiel)   MODEL="tiel-coder-agent" ;;
    strata) MODEL="strata" ;;
    status)
        echo "Ollama on ${REMOTE_HOST}:${SERVER_PORT}:"
        if PS=$(curl -sf --connect-timeout 10 "http://${REMOTE_HOST}:${SERVER_PORT}/api/ps"); then
            echo "$PS" | jq -r '.models[] | "  \(.name)  ctx=\(.context_length)  vram=\(.size_vram/1e9|floor)GB"'
        else
            echo "  not running"
        fi
        CODE=$(curl -s -o /dev/null -w '%{http_code}' --connect-timeout 10 "http://${REMOTE_HOST}:${STRATA_PORT}/v1/models")
        case "$CODE" in 200|401) echo "Strata on ${REMOTE_HOST}:${STRATA_PORT}: running" ;;
                        *)       echo "Strata on ${REMOTE_HOST}:${STRATA_PORT}: not running" ;; esac
        echo "VS Code ollama.thinkingLevels:"
        jq -r '."ollama.thinkingLevels" // {} | to_entries[] | "  \(.key): \(.value)"' "$VSCODE_SETTINGS"
        exit 0 ;;
    *)      echo "Usage: $0 <27b|35b|ornith|tiel|strata> [off|on|low|medium|xhigh] | status"; exit 1 ;;
esac

# --- Strata: stop Ollama, 42 GB GPU limit, start Qwen3.8-Flash-Next (settings: STRATA.md) ---
if [ "$MODEL" = "strata" ]; then
    echo "============================================"
    echo "Switching ${REMOTE_HOST} to Strata (Qwen3.8-Flash-Next Gyro-S, port ${STRATA_PORT})"
    echo "============================================"
    # One SSH session with a terminal, so sudo can ask for the Mac password.
    STRATA_SCRIPT='
set -e
if [ "$(sysctl -n iogpu.wired_limit_mb)" -lt 43008 ]; then
    echo "[1/3] GPU memory limit -> 42 GB (sudo):"
    sudo sysctl iogpu.wired_limit_mb=43008
fi
if launchctl print gui/$(id -u)/local.ollama.server >/dev/null 2>&1; then
    echo "[2/3] Stopping Ollama..."
    launchctl bootout gui/$(id -u)/local.ollama.server
    sleep 3
fi
echo "[3/3] Starting Strata (about 1 min; the very first start downloads ~65 GB)..."
~/.local/bin/strata launch --model gyro-s --family gyro --context 128k --vision off \
    --tune skip --access lan --port '"${STRATA_PORT}"' --yes --no-tui --restart \
    --set STRATA_METAL_STREAM=1 --set STRATA_METAL_ARENA_GB=30 \
    --set conversation-cache-mib=1024 --set STRATA_METAL_PROMPT_CHUNK=4096 \
    | grep -E "Ready|Network|API key|rror" || true
'
    ssh -t -o ConnectTimeout=10 "${REMOTE_USER}@${REMOTE_HOST}" "bash -c $(printf '%q' "$STRATA_SCRIPT")"
    CODE=$(curl -s -o /dev/null -w '%{http_code}' --connect-timeout 10 "http://${REMOTE_HOST}:${STRATA_PORT}/v1/models")
    echo ""
    echo "============================================"
    case "$CODE" in
        200|401) echo "SUCCESS: Strata is serving on http://${REMOTE_HOST}:${STRATA_PORT}/v1"
                 echo "============================================"
                 echo "In VS Code pick 'Qwen3.8 Flash-Next (Strata)' in the Copilot model picker."
                 echo "API key: ssh ${REMOTE_USER}@${REMOTE_HOST} '~/.local/bin/strata launch --show-key'" ;;
        *)       echo "WARNING: Strata does not answer on port ${STRATA_PORT} (HTTP ${CODE})."
                 echo "============================================"
                 echo "Engine log on the Mac: ~/.local/state/strata/launch/gyro-s-128k.engine.log" ;;
    esac
    read -p "Press any key to close..."
    exit 0
fi

# default: thinking off for the 35B (it tends to overthink), on for the 27B
[ "$MODEL" = "qwen3.6-35b-a3b-agent" ] && THINKING="${2:-off}" || THINKING="${2:-on}"
case "$MODEL:$THINKING" in
    ornith-1.5-agent:*|tiel-coder-agent:*)
                                        [ -n "$2" ] && echo "Note: thinking of ${MODEL} cannot be changed from VS Code (always on)."
                                        THINKING="on (fixed)"; THINK_VAL="" ;;
    *:off)                              THINK_VAL="false" ;;
    qwen3.8-27b-agent:on)               THINK_VAL='"medium"' ;;
    qwen3.8-27b-agent:low|qwen3.8-27b-agent:medium|qwen3.8-27b-agent:xhigh)
                                        THINK_VAL="\"$THINKING\"" ;;
    qwen3.6-35b-a3b-agent:on|qwen3.6-35b-a3b-agent:low|qwen3.6-35b-a3b-agent:medium|qwen3.6-35b-a3b-agent:xhigh)
                                        THINKING="on"; THINK_VAL="true" ;;
    *)   echo "Thinking must be one of: off on low medium xhigh"; exit 1 ;;
esac

echo "============================================"
echo "Switching to ${MODEL} on ${REMOTE_HOST}"
echo "Thinking: ${THINKING} (ollama.thinkingLevels=${THINK_VAL})"
echo "============================================"

# SSH in. MODEL and port are passed as $1/$2 to `bash -s`; nothing else expands locally.
ssh -o ConnectTimeout=10 "${REMOTE_USER}@${REMOTE_HOST}" bash -s "${MODEL}" "${SERVER_PORT}" <<'REMOTE_SCRIPT'
set -e
MODEL="$1"
export OLLAMA_HOST="127.0.0.1:$2"
OLLAMA=/opt/homebrew/bin/ollama

# Strata and Ollama never run together (see "strata" above)
if pgrep -f 'strata --serve' >/dev/null; then
    echo "[0/3] Stopping Strata..."
    ~/.local/bin/strata launch --stop > /dev/null
fi
if ! launchctl print gui/$(id -u)/local.ollama.server >/dev/null 2>&1; then
    echo "[0/3] Starting Ollama..."
    launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/local.ollama.server.plist
    for i in $(seq 30); do curl -sf "http://${OLLAMA_HOST}/api/version" > /dev/null && break; sleep 1; done
fi

echo "[1/3] Unloading other models..."
for m in $("$OLLAMA" ps | awk 'NR>1 {print $1}'); do
    [ "$m" = "${MODEL}:latest" ] || "$OLLAMA" stop "$m"
done

echo "[2/3] Loading ${MODEL} (kept in memory)..."
curl -sf "http://${OLLAMA_HOST}/api/generate" -d "{\"model\":\"${MODEL}\",\"keep_alive\":-1}" > /dev/null

echo "[3/3] Loaded:"
"$OLLAMA" ps
REMOTE_SCRIPT

if [ $? -ne 0 ]; then
    echo ""
    echo "FAILED: SSH or remote script failed."
    echo "Check connectivity to ${REMOTE_HOST} and try again."
    exit 1
fi

# Set the thinking level for this model in VS Code. settings.json must be plain JSON
# (no comments); the file is rewritten with 4-space indent (CRLF on Windows).
if [ -n "$THINK_VAL" ]; then
    echo ""
    echo "Setting ollama.thinkingLevels[${MODEL}:latest]=${THINK_VAL} in VS Code..."
    cp "$VSCODE_SETTINGS" "${VSCODE_SETTINGS}.bak"
    if jq --indent 4 --arg m "${MODEL}:latest" --argjson v "$THINK_VAL" \
            '."ollama.thinkingLevels"[$m] = $v' "${VSCODE_SETTINGS}.bak" > "${VSCODE_SETTINGS}.tmp"; then
        case "$(uname -s)" in
            MINGW*|MSYS*|CYGWIN*) sed 's/$/\r/' "${VSCODE_SETTINGS}.tmp" > "$VSCODE_SETTINGS" ;;
            *)                    cp "${VSCODE_SETTINGS}.tmp" "$VSCODE_SETTINGS" ;;
        esac
    else
        echo "  jq failed (comments in settings.json?), settings left unchanged."
        echo "  Set it by hand: \"ollama.thinkingLevels\": { \"${MODEL}:latest\": ${THINK_VAL} }"
    fi
    rm -f "${VSCODE_SETTINGS}.tmp"
fi

# Verify the switch
if curl -s --connect-timeout 10 "http://${REMOTE_HOST}:${SERVER_PORT}/api/ps" | grep -q "\"${MODEL}:latest\""; then
    echo ""
    echo "SUCCESS: Switched to ${MODEL} (thinking=${THINKING})"
    echo "In VS Code pick '${MODEL}:latest' (Ollama) in the Copilot model picker."
else
    echo ""
    echo "WARNING: Could not verify model switch. Check: curl http://${REMOTE_HOST}:${SERVER_PORT}/api/ps"
    exit 1
fi
