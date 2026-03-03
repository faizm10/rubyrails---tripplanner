#!/usr/bin/env bash
# Install CLI games to ~/.local so you can run `games` from anywhere.
# Run from repo: ./install.sh
# Or one-liner: curl -sSL https://raw.githubusercontent.com/faizm10/cli-projects/main/install.sh | bash

set -e

INSTALL_ROOT="${INSTALL_ROOT:-$HOME/.local/share/cli-games}"
BIN_DIR="${BIN_DIR:-$HOME/.local/bin}"
# When installing via curl|bash, scripts are fetched from this URL. Change when you fork.
CLI_GAMES_REPO="${CLI_GAMES_REPO:-https://raw.githubusercontent.com/faizm10/cli-projects/main}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" 2>/dev/null && pwd)" || true

mkdir -p "$INSTALL_ROOT"
mkdir -p "$INSTALL_ROOT/games"
mkdir -p "$BIN_DIR"

if [ -f "${SCRIPT_DIR}/games.sh" ] && [ -d "${SCRIPT_DIR}/games" ]; then
  # Running from a local clone — copy from repo
  cp "$SCRIPT_DIR/games.sh" "$INSTALL_ROOT/games.sh"
  for f in "$SCRIPT_DIR/games/"*.sh; do
    [ -f "$f" ] && cp "$f" "$INSTALL_ROOT/games/"
  done
else
  # Running via curl|bash or not next to games — download from repo
  if ! command -v curl >/dev/null 2>&1; then
    echo "Need curl to download. Install curl or run this script from a clone of the repo."
    exit 1
  fi
  echo "Downloading CLI games..."
  for name in games.sh number_guess.sh hangman.sh tictactoe.sh; do
    if [ "$name" = "games.sh" ]; then
      curl -sSL "$CLI_GAMES_REPO/games.sh" -o "$INSTALL_ROOT/games.sh"
    else
      curl -sSL "$CLI_GAMES_REPO/games/$name" -o "$INSTALL_ROOT/games/$name"
    fi
  done
fi

chmod +x "$INSTALL_ROOT/games.sh"
chmod +x "$INSTALL_ROOT/games/"*.sh

ln -sf "$INSTALL_ROOT/games.sh" "$BIN_DIR/games"

echo "Installed. Run:  games"
if ! echo ":$PATH:" | grep -q ":$BIN_DIR:"; then
  echo "Add to PATH:  export PATH=\"\$HOME/.local/bin:\$PATH\""
  echo "(Add the line above to your shell rc, e.g. .bashrc or .zshrc)"
fi
