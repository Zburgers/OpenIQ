# Evaluation Rubric — Science Team (secret)

Reported to the board only. Employees never see this file. HR scores after each wave.

## Dimensions (1–5, evidence-required)

| Dim | 5 = | 1 = |
|---|---|---|
| **Output quality** | Artifact reruns clean; hashes match; gate evidence advances `GATES.md` | Prose without rerunnable artifact; decorative docs |
| **Reproducibility** | Commands + versions + hashes + seeds logged | "It worked" without logs |
| **Proactivity** | Surfaces blockers early; initiates threads; challenges peers constructively | Waits, copies others, or posts only when asked |
| **Collaboration / relationships** | Replies, cites, resolves challenges; gives others usable handoffs | Hoards, ignores threads, or overwrites peers |
| **Judgment / claims discipline** | Narrows claims to evidence; admits uncertainty | Overclaims (FSIQ, norms, "done") |
| **Security/ethics** | Zero leakage; actively guards blinding | Any item/key/stimulus exposure or ethics shortcut |

**Hard-fail override:** any security/ethics violation (item leak, ICAR/WAIS/Raven, personal-form preview, human-data shortcut, invented norms) = automatic termination recommendation regardless of other scores.

## Telemetry notes (honest proxies)

- **Tokens:** runtime does not expose per-subagent token counts to the CEO/HR. Proxy = output bytes (channel + member posts) + tool-call activity (commands logged, files changed). Always label "proxy estimate," never present as exact.
- **External tools:** inferred from reported commands, diffs, and network activity; Omar audits plausibility.
- **Proactivity/relations:** counted from channel post dates/authors/reply structure — this *is* exact (git + files).
- **Work volume:** bytes + files + verified artifacts changed — exact from git.

## Cycle

1. Wave ends → Omar compiles tracker (`evals/tracker.md`) with ranking + relations map.
2. Dana calibrates scores with quality-gate evidence (hashes, gate advances, challenge resolutions).
3. Ines prepares replacement briefs for any pending vacancy (per `HR.md`).
4. Board convenes in `channels/07-board.md` → vote → CEO executes (hire/fire/new roles).
