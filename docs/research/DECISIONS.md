# Research Decision Log

This file records decisions that should not be casually reversed by implementation convenience.

## D-001 — v0.1 construct

**Decision:** OpenIQ v0.1 targets matrix/fluid reasoning, not Full Scale IQ.

**Reason:** Existing open calibrated matrix banks let us build an auditable early instrument; a broad `g`/FSIQ interpretation requires multidomain evidence, joint calibration/structure, and appropriate norming.

## D-002 — primary reproduction source

**Decision:** MaRs-IB IRT calibration/validation is Study 001 and primary v0.1 reference. OMIB is Study 002 and an independent matrix comparison source.

## D-003 — response time

**Decision:** Record item response time in v0.1 but do not include it in the primary reasoning ability score unless a validated model explicitly supports that use.

## D-004 — psychometrics implementation

**Decision:** R is the initial reference environment. Production implementations in Python/TypeScript must be verified numerically against the reference.

## D-005 — external resources

**Decision:** Prefer pinned local acquisition over vendoring third-party materials. Public availability is not treated as blanket redistribution permission.

## D-006 — personal baseline contamination

**Decision:** The person taking the personal baseline should not inspect the final scored-form items/solutions before baseline administration. Development uses sandbox/practice material and/or item IDs/parameters.

## D-007 — norms

**Decision:** No convenience sample will be called “Indian norms” or “population norms” without a defensible sampling/norming argument.

## D-008 — CAT

**Decision:** Fixed-form reproduction precedes adaptive testing. CAT starts with simulation after item calibration/scoring is understood.

## D-009 — human-subject research

**Decision:** Informal self/usability testing is distinct from publication-directed participant research. Establish the applicable ethics-review/exemption path before deliberately collecting a publication/generalizable research dataset.
