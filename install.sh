#!/bin/bash
# Link ~/.claude/skills to this repo's skills/ via a symlink.
set -e

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
LINK="$HOME/.claude/skills"
TARGET="$REPO_DIR/skills"

mkdir -p "$HOME/.claude"

if [ -e "$LINK" ] || [ -L "$LINK" ]; then
  echo "$LINK already exists. Move it aside (or merge its contents into $TARGET) first." >&2
  exit 1
fi

ln -s "$TARGET" "$LINK"
echo "Linked $LINK -> $TARGET"
