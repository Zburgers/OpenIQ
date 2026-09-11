# Study 001 — MaRs-IB IRT Replication

## Status

Planned. This is the first scientific gate for OpenIQ.

## Research objective

Reproduce enough of the published MaRs-IB psychometric pipeline to demonstrate that OpenIQ can correctly acquire the public data/code, fit/interpret the relevant IRT models, recover published item/test information, and reproduce form/scoring behavior before using MaRs parameters in an assessment application.

## Primary sources

- Chierchia et al. (2019), DOI `10.1098/rsos.190232`
- Zorowitz et al. (2023), DOI `10.3758/s13428-023-02067-8`
- https://github.com/ndawlab/mars-irt at bootstrap pin `04eecdaf77d0ee657c65351eab5ed9e744b1ce14`
- upstream stimuli pointer: https://osf.io/g96f4/

## Procedure

1. Read both papers before running code.
2. Inventory upstream branches: `main`, `calibration`, `validation-A`, `validation-B`.
3. Record environment/package versions used upstream and any modernization needed to run in 2026.
4. Identify raw/calibration/validation datasets and construct a data dictionary.
5. Re-run parameter-recovery/model-selection workflow.
6. Refit the published calibration model(s).
7. Compare reproduced item parameters with published/upstream values using predeclared tolerance.
8. Reproduce item/test information plots and published short/long form assembly logic.
9. Re-run validation analyses where the public repository provides the required data.
10. Document every deviation; do not “fix” discrepancies silently.

## Required outputs

- `RESULTS.md` with replication table: target, observed, delta, pass/fail, explanation
- machine-readable item parameter export for **internal experimental use only**, with provenance/version
- scoring notebook/script demonstrating theta estimation and uncertainty
- decision note: whether MaRs is ready to power OpenIQ-Gf v0.1

## Non-goals

- claiming Full Scale IQ
- inventing new norms
- creating new MaRs items
- CAT/adaptive administration
- combining MaRs and OMIB scales

## Personal-test contamination rule

The developer/test-taker should not inspect the eventual scored personal-form items before baseline administration. The replication agent may work with item IDs/parameters and sandbox stimuli while keeping the final baseline form isolated.
