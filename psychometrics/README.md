# Psychometrics

The psychometrics layer is the **reference implementation** for score meaning. The web app must not become the source of truth for a scientific scoring model.

## Initial stack

R first:

- `psych` — reliability/exploratory psychometrics
- `mirt` — IRT/MIRT and multiple-group/DIF work
- `lavaan` — CFA/SEM/invariance
- `TAM` — complementary IRT/Rasch workflows where appropriate
- `catR` / later `mirtCAT` — CAT simulation only after fixed-form scoring is reproduced

Python/TypeScript may implement production scoring after results are numerically verified against the R reference.

## Required reproducibility metadata

Every analysis should capture:

- input dataset provenance + checksum
- upstream source commit/release
- package versions/session info
- random seed(s)
- preprocessing/exclusion rules
- model specification
- estimator and convergence diagnostics
- numerical tolerance used for replication checks

## Scoring discipline

A raw score, an IRT theta, a percentile, and an IQ-style standardized score are different objects. Transformations between them must be explicit and justified. Do not equate theta scales from separate calibrations without linking/equating evidence.
