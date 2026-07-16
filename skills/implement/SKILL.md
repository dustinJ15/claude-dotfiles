---
name: implement
description: Implement a piece of work based on a spec or set of tickets. Use when working one ticket from a specs/<feature>/tickets/ folder, or when the user says "implement this ticket/spec".
---

Implement the work described by the user in the spec or tickets.

Use test-driven development where possible (the superpowers:test-driven-development skill), at pre-agreed seams.

Run typechecking regularly, single test files regularly, and the full test suite / project gate once at the end. If the project defines a visual-verification loop for UI changes, run it.

Once done, use /code-review to review the work.

Commit your work to the current branch — never directly to main; follow the project's landing conventions (e.g. a short-lived branch off origin/main plus a non-draft PR if the project uses a merge queue).

If the ticket lives in a local tickets/ folder, set its **Status** line to `done` and check off its acceptance criteria in the same commit.
