#!/bin/bash
# Switch the Ollama server on the Mac to another model and set the thinking level
# used by the VS Code Ollama extension. Run it on the machine where VS Code runs
# (Git Bash on Windows, or a terminal on macOS/Linux). Needs ssh, curl and jq.
#
# Usage: ./switch-model.sh <27b|35b> [off|on|low|medium|xhigh]   (thinking; default: on)
#        ./switch-model.sh status
#
# Thinking cannot be set on the server (Ollama Modelfiles have no "think" option).
# The VS Code Ollama extension sends it with every request, taken from the
# "ollama.thinkingLevels" setting, so this script edits that setting.
# It applies to the next request, no window reload needed.
#   27b: off | low | medium | xhigh   ("on" = medium)
#   35b: off | on                      (any level = on)

# --- edit these, or set them as environment variables ---
REMOTE_USER="${MAC_USER:-your-mac-user}"
REMOTE_HOST="${MAC_HOST:-192.168.1.50}"
SERVER_PORT="${MAC_PORT:-8080}"

case "$(uname -s)" in
    MINGW*|MSYS*|CYGWIN*) VSCODE_SETTINGS="$APPDATA/Code/User/settings.json" ;;
    Darwin)               VSCODE_SETTINGS="$HOME/Library/Application Support/Code/User/settings.json" ;;
    *)                    VSCODE_SETTINGS="$HOME/.config/Code/User/settings.json" ;;
esac

# --- parse args ---
case "$1" in
    27b)    MODEL="qwen3.8-27b-agent" ;;
    35b)    MODEL="qwen3.6-35b-a3b-agent" ;;
    status)
        echo "Loaded on ${REMOTE_HOST}:"
        curl -s --connect-timeout 10 "http://${REMOTE_HOST}:${SERVER_PORT}/api/ps" \
            | jq -r '.models[] | "  \(.name)  ctx=\(.context_length)  vram=\(.size_vram/1e9|floor)GB"'
        echo "VS Code ollama.thinkingLevels:"
        jq -r '."ollama.thinkingLevels" // {} | to_entries[] | "  \(.key): \(.value)"' "$VSCODE_SETTINGS"
        exit 0 ;;
    *)      echo "Usage: $0 <27b|35b> [off|on|low|medium|xhigh] | status"; exit 1 ;;
esac

THINKING="${2:-on}"
case "$MODEL:$THINKING" in
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
