#!/bin/bash
# Ralph loop — bounded AUTONOMOUS iterations. Repeatedly launches a
# fresh-context, non-interactive Claude; each iteration does ONE ticket,
# commits, and exits. Stops on the COMPLETE promise or the iteration cap.
#
# Usage:  ./afk-ralph.sh <iterations> specs/<feature-slug>
#
# NOTE: -p (print mode) cannot answer permission prompts. --permission-mode
# acceptEdits auto-approves file edits, but shell commands must be allowlisted
# in .claude/settings.local.json or they get denied and iterations stall.
set -e

ITERATIONS="${1:?Usage: $0 <iterations> <spec-dir>}"
SPEC_DIR="${2:?Usage: $0 <iterations> <spec-dir>   e.g. $0 10 specs/my-feature}"

BRANCH=$(git rev-parse --abbrev-ref HEAD)
if [ "$BRANCH" = "{{MAINLINE}}" ]; then
  echo "Refusing to run on {{MAINLINE}}. Create a work branch first:"
  echo "  git fetch origin && git checkout -b ralph/$(basename "$SPEC_DIR") origin/{{MAINLINE}}"
  exit 1
fi

touch "$SPEC_DIR/progress.txt"

for ((i=1; i<=ITERATIONS; i++)); do
  echo "=== Ralph iteration $i/$ITERATIONS ($(git rev-parse --short HEAD)) ==="
  result=$(claude --permission-mode acceptEdits -p "@$SPEC_DIR/spec.md @$SPEC_DIR/progress.txt \
1. Read the spec, every ticket in $SPEC_DIR/tickets/, and the progress file. \
2. Pick the highest-priority ticket on the frontier (all blockers done, Status: ready-for-agent). \
3. Implement it test-first. \
4. Run the tests you touched, then the full gate: {{GATE}}. \
5. Set that ticket's Status to done and check off its acceptance criteria. \
6. Append one line per action to $SPEC_DIR/progress.txt. \
7. Commit your changes to the current branch. \
ONLY WORK ON A SINGLE TICKET. \
If every ticket is done, output <promise>COMPLETE</promise>.")

  echo "$result"

  if [[ "$result" == *"<promise>COMPLETE</promise>"* ]]; then
    echo ""
    echo "All tickets complete after $i iteration(s)."
    exit 0
  fi
done

echo "Iteration cap reached ($ITERATIONS). Check $SPEC_DIR/progress.txt and re-run to continue."
