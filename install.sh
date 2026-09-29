#!/usr/bin/env bash
# Symlinks the reviewer agents and skills in this repo into ~/.copilot so they are
# available as personal customizations to Copilot CLI and VS Code.
# GitHub Codespaces runs this automatically when this repo is your dotfiles repo.
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COPILOT_DIR="${COPILOT_HOME:-$HOME/.copilot}"

link() {
  local src="$1" dest="$2"
  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    echo "skip: $dest exists and is not a symlink" >&2
    return
  fi
  ln -sfn "$src" "$dest"
  echo "linked: $dest -> $src"
}

mkdir -p "$COPILOT_DIR/agents" "$COPILOT_DIR/skills"

for agent in "$REPO_DIR"/.github/agents/*.md; do
  name="$(basename "$agent" .md)"
  [ "$name" = "README" ] && continue
  link "$agent" "$COPILOT_DIR/agents/$name.agent.md"
done

for skill in "$REPO_DIR"/.github/skills/*/; do
  skill="${skill%/}"
  [ -f "$skill/SKILL.md" ] || continue
  link "$skill" "$COPILOT_DIR/skills/$(basename "$skill")"
done
