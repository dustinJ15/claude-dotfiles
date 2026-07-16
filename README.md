# claude-dotfiles

Personal Claude Code configuration, synced across machines. Currently: the
**Pocock workflow skills** (grill → spec → tickets → Ralph loop), adapted from
[mattpocock/skills](https://github.com/mattpocock/skills).

## Contents

```text
skills/
├── grill-me/     /grill-me    — relentless one-question-at-a-time design interview
├── to-spec/      /to-spec     — synthesize the grilled conversation into specs/<slug>/spec.md
├── to-tickets/   /to-tickets  — break a spec into tracer-bullet tickets with blocking edges
├── implement/    /implement   — implement one ticket: TDD → gate → code-review → commit
└── ralph-init/   /ralph-init  — scaffold the workflow into a new repo (specs/, loop
                                 scripts from its {{GATE}}/{{MAINLINE}} templates,
                                 agent-docs block, permission allowlist)
```

Local adaptations vs. Matt Pocock's originals: no issue tracker — specs and tickets are
local markdown under `specs/<slug>/` (spec.md + tickets/NN-*.md + progress.txt).

## Install (new machine)

```bash
git clone https://github.com/dustinJ15/claude-dotfiles ~/code/claude-dotfiles
```

Then link `~/.claude/skills` into the repo:

- **Windows (PowerShell):** `~/code/claude-dotfiles/install.ps1`
- **macOS / Linux:** `~/code/claude-dotfiles/install.sh`

Both refuse to touch an existing `~/.claude/skills` — move it aside first (or merge its
folders into `skills/` here and commit).

## Day-to-day

Because `~/.claude/skills` is a link into this repo, editing a skill *is* editing the
repo:

```bash
cd ~/code/claude-dotfiles
git add -A && git commit -m "Describe the skill change" && git push   # after edits
git pull                                                              # on the other machine
```

## Workflow crib sheet

Fresh chat per phase (`/clear` between them):

1. `/grill-me` over an idea/bug doc — answer 30–80 questions
2. `/to-spec` in the same chat — writes `specs/<slug>/spec.md`
3. `/to-tickets specs/<slug>/spec.md` — approve the vertical-slice breakdown
4. Branch off the mainline, then `./ralph-once.sh specs/<slug>` (supervised) →
   `./afk-ralph.sh 10 specs/<slug>` (autonomous) → push → PR

In a repo without the scaffolding, run `/ralph-init` first.
