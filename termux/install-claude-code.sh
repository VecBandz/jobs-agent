#!/data/data/com.termux/files/usr/bin/bash
#
# Installs the Claude Code CLI inside Termux on Android.
# Run this from a Termux shell:
#   bash install-claude-code.sh
#
set -euo pipefail

log() { printf '\n\033[1;34m==> %s\033[0m\n' "$1"; }
err() { printf '\033[1;31mError: %s\033[0m\n' "$1" >&2; }

if [ ! -d "/data/data/com.termux/files/usr" ]; then
  err "This script must be run inside Termux."
  exit 1
fi

log "Updating Termux packages"
pkg update -y
pkg upgrade -y

log "Installing dependencies (nodejs-lts, git, ripgrep)"
pkg install -y nodejs-lts git ripgrep

if ! command -v termux-setup-storage >/dev/null 2>&1; then
  log "termux-tools not found, installing"
  pkg install -y termux-tools
fi

log "Granting storage access (approve the Android permission prompt if shown)"
termux-setup-storage || true

NODE_VERSION="$(node --version)"
log "Node.js installed: ${NODE_VERSION}"

log "Installing Claude Code CLI via npm"
npm install -g @anthropic-ai/claude-code

if ! command -v claude >/dev/null 2>&1; then
  err "Installation finished but the 'claude' command was not found on PATH."
  err "Try restarting Termux, then run: claude --version"
  exit 1
fi

log "Claude Code installed successfully: $(claude --version)"
log "Run 'claude' to start, then follow the login prompt to authenticate."
