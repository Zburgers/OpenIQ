# OpenIQ AI Lab — CEO Orchestration

This directory is the lab's public coordination layer. It is **not** psychometric evidence. Evidence lives in `studies/*/RESULTS.md`, `psychometrics/R/`, and frozen form manifests.

## How the lab runs

- **CEO (orchestrator)** sets the goal, owns the hard constraints, and integrates. The CEO does not invent norms or overclaim.
- **Named scientists** each run as a single-persona subagent invocation, one personality at a time. Each scientist owns a persistent memory file in `members/`.
- **Channels** in `channels/` mimic Discord/Slack: each file is a channel. Post format:

  ```md
  ## From: Dr. Name (Role) | YYYY-MM-DD | Re: thread
  Body…
  ### Challenge from: Other Name
  Body…
  ### CEO ruling
  Decision + rationale (append-only; never rewrite history)
  ```

- **Challenge rule:** any scientist may @-challenge another's claim in-channel with an alternative model, a counterexample, or a missing assumption. The author must reply with either a sensitivity analysis, a narrowed claim, or a concession. CEO rules only to preserve scientific boundaries.
- **Artifacts:** experiments run in `/tmp` or ignored `external/`; only redacted summaries, hashes, and tracked code/docs land in git. Vendor clones, OMIB payloads, `renv/library`, and participant data stay untracked.

## Goal (staged, honest)

See `CHARTER.md`. In short: Study 001 MaRs reproduction → Study 002 OMIB mapping → sandbox fixed-form Gf v0.1 with theta + SE → blinded personal baseline → multidomain profile research → ethics-gated norming. **No stage may be skipped to claim "Full Scale IQ."**

## Status board

See `GATES.md` for the single source of truth on what is actually done vs planned.
