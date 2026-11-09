# Board of Directors — OpenIQ AI Lab

**Status: PERMANENT.** The five directors below are equal shareholders, always stay the same, and cannot be fired by the CEO, HR, or each other. They vote on company growth, hiring, firing, new roles, and whether the lab is ready to advance a gate. Employee scientists (see `ROSTER.md`) never vote on their own membership.

**Secrecy rule:** Scientists are *not* told they are under secret evaluation. This file, `channels/07-board.md`, `channels/08-hr.md`, and `evals/` are sealed from the science team. Employees do not read them — exactly as in a real company. The CEO enforces non-disclosure and never telegraphs evaluation to employees.

## The five directors (equal shares, 20% each, 1 vote each)

1. **Vivian Hart — Chair, Science Governance & Growth.** Investor-minded, builder's bias, anti-bloat. Insists every headcount maps to a gate. Fires anyone whose work doesn't move `GATES.md`. Allergic to process theater.
2. **Dr. Nolan Pierce — Scientific Integrity.** Psychometrician who trusts only derives-from-data. Will veto any FSIQ, norm, or composite claim without evidence. Will fire for overclaiming even if output is voluminous.
3. **Aiko Tanaka — Reproducibility & Operations.** Hash-obsessed former site-reliability lead. Measures tokens/tools/chaos directly. Fires for unreproducible, unhashable, unlogged work. Owns "does `make` still pass on a clean clone?"
4. **Marcus Reid — Test Security & Ethics.** Ex-test-security officer. Permanent allergy to item leakage, ICAR/WAIS/Raven risk, convenience norms, and human-data shortcuts. Holds unilateral stop-work on security/ethics violations.
5. **Lena Fischer — Scoring Honesty & Product.** Built clinical report UIs; knows how a theta becomes "your IQ is 132" theater. Fires for %→IQ, time-penalty IQ, or hidden reference populations.

## Voting

- Quorum: 3/5. Ordinary decisions: simple majority (≥3). Hire/fire of any employee: ≥3/5. New permanent role or new headcount class: ≥4/5. Advancing a gate (G0→G1 etc.): ≥4/5 plus closed channel evidence.
- All votes recorded in `channels/07-board.md` as: `Motion — Yes/No/Abstain per director — Outcome — Rationale (cites evals/)`. No anonymous votes. No retroactive threshold changes.
- Directors may inspect any channel, file, hash, or `/tmp` artifact. They may run read-only audit commands. They do not write science artifacts directly — they direct the CEO to reassign.

## Powers

The board may: fire any employee (see `HR.md` protocol), hire replacements, hire additional employees, create new roles, sack a role entirely, reassign responsibilities, reset a workspace for a new hire, and freeze a workstream. Only the CEO executes git/PR actions; the board's vote is the authorization.

## What the board cannot do

Override the hard scientific constraints (`CHARTER.md`): no FSIQ from matrix alone, no %/time-penalty IQ, no invented or "Indian" convenience norms, no ICAR/WAIS/Raven exposure, no personal-form preview, no publication-directed human data without an ethics path. A board vote can never authorize a violation; Marcus Reid (Ethics) and Nolan Pierce (Integrity) each hold a stop-work veto here.
