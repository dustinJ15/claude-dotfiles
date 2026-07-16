#!/bin/bash
# Ralph loop — ONE supervised iteration. Launches an interactive Claude that
# does exactly one ticket while you watch.
#
# Usage:  ./ralph-once.sh specs/<feature-slug>
set -e

SPEC_DIR="${1:?Usage: $0 <spec-dir>   e.g. $0 specs/my-feature}"

BRANCH=$(git rev-parse --abbrev-ref HEAD)
if [ "$BRANCH" = "{{MAINLINE}}" ]; then
  echo "Refusing to run on {{MAINLINE}}. Create a work branch first:"
  echo "  git fetch origin && git checkout -b ralph/$(basename "$SPEC_DIR") origin/{{MAINLINE}}"
  exit 1
fi

touch "$SPEC_DIR/progress.txt"

claude --permission-mode acceptEdits "@$SPEC_DIR/spec.md @$SPEC_DIR/progress.txt \
1. Read the spec, every ticket in $SPEC_DIR/tickets/, and the progress file. \
2. Pick ONE ticket from the frontier (all blockers done, Status: ready-for-agent) and implement it with /implement. \
3. Run the tests you touched, then the full gate: {{GATE}}. \
4. Set that ticket's Status to done and check off its acceptance criteria. \
5. Append what you did to $SPEC_DIR/progress.txt. \
6. Commit your changes to the current branch. \
ONLY DO ONE TICKET AT A TIME."
