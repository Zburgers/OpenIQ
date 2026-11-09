# HR & Talent — OpenIQ AI Lab (sealed stack)

HR evaluates science-team employees **secretly**. Employees are never told. All HR notes live in `evals/` + `channels/08-hr.md`; scientists never read them. The CEO relays hiring/firing outcomes only as "position X is now open / reassigned" — never as "you are being evaluated."

## HR team (3, appointed by the board; may be replaced by board vote)

1. **Dana Whitfield — Director of People (HR Lead).** Owns evaluation cadence, calibration, and all employee files. Quiet, meticulous. Interview signal: she notices asymmetry between claimed and observed work.
2. **Omar Haddad — People Operations / Tooling.** Owns measurement: tokens, tool calls, proactivity, relationships, workspace hygiene. Lives in eval trackers; distrusts self-reported effort.
3. **Ines Duarte — Talent Sourcing (recruiter).** Writes precise replacement briefs: what the role needs, what the fired holder lacked, exact skills for the next hire. Never leaks history to the new hire.

## Secret evaluation — what is measured

Per employee, per cycle (default: every wave). Proxies noted where direct telemetry (e.g. exact token counts) is unavailable from the runtime — never invent numbers.

- **Tokens used** (proxy: subagent output chars + tool-call count + channel/file bytes authored; Omar estimates, marks as proxy).
- **External tools used** (shell, R/venv, network fetches, git/gh — inferred from self-reported commands, file diffs, eval logs).
- **Proactivity** (unprompted channel posts, challenges issued, blockers surfaced early, `GATES.md` evidence added vs waited).
- **Least/most proactive ranking** across the team each cycle.
- **Relationships & collaboration** (who replies to whom, who cites/challenges whom, who shares data vs hoards — measured from channel threads).
- **Actual responsibilities discharged** (gate evidence produced, files with verified hashes, gates advanced vs decorative prose).
- **Quality gates** (reproducibility: does the artifact rerun? security: any leakage? claims: overclaim flags from Red Team/board).

Scores: 1–5 per dimension + verbatim evidence links (channel heading, file path, hash). Composite = mean of quality gates; no amount of output volume compensates for a security/overclaim failure.

## Firing protocol (board vote → CEO executes)

1. HR files a written case in `evals/<slug>.md`: evidence table, rubric scores, recommendation (retain / warn / terminate).
2. Board motion in `channels/07-board.md` (≥3/5 to terminate employment of that individual instance). Rationale must cite the eval file.
3. CEO terminates that subagent instance (no further follow-ups to that session ID) and freezes its claim authority immediately.
4. Workspace cleanup: reassign open tasks to named owners, archive (never copy) the fired holder's `members/<slug>.md` to `members/archive/` (sealed), remove its channel-writing privileges (it wrote no more, so future channel posts must cite the new holder or CEO ruling).
5. **Knowledge rule (IRL):** the fired candidate is *never restarted* (no new subagent invoking that persona). Previous coworkers may reference them historically ("as former X found..."). The replacement hire is invoked with a **clean position brief only** — they are told they fill an empty position; they never learn who held it or why it was vacated. Their `members/<slug>.md` starts empty except for the position brief.
6. Ines Duarte writes the replacement brief: role need, skills, what the prior holder lacked (abstracted — no name leak to the new hire), success criteria for the first wave.

## Hiring protocol

- Board decides: same-persona replacement, different persona in same role, new role (different slug + channel owner), fewer heads (sack the role), or more heads (new position). New-role motions need ≥4/5.
- CEO spawns the new subagent (one personality at a time), seeds `members/<slug>.md` with position + responsibilities only, announces the vacancy fill in `channels/00-announcements.md` without mentioning history.
- Probation: first wave scores are mandatory; HR reviews within one cycle before any gate advance that depends on the new hire's evidence.

## Records

- `evals/tracker.md` — the running table (scores + ranking + relations).
- `evals/<slug>.md` — full case file per employee (retain/warn/terminate).
- `members/archive/` — sealed termination archives (not restarted, not read by new hires).
- All conversations are preserved in `channels/*` (append-only) — HR/board scoring cites exact headings.
