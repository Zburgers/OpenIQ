# R reference runtime

This project environment was bootstrapped on 2026-09-11 on Fedora 44 x86_64 with R 4.6.1 and renv 1.2.4. The exact dependency graph is in `renv.lock`; do not commit `renv/library/`.

Restore from the repository root with:

```sh
cd psychometrics/R
Rscript -e 'renv::restore(prompt = FALSE, transactional = TRUE)'
Rscript smoke_test.R
```

The initial research package set is `psych`, `mirt`, `lavaan`, `TAM`, and `catR`. `catR` is included for later simulation and research; this bootstrap does not implement computerized adaptive testing.

Randomness policy:

- New OpenIQ scripts must set and report an explicit seed before stochastic work.
- Prefer `RNGkind("L'Ecuyer-CMRG")` for R workflows and record the seed in generated metadata.
- The smoke test uses `20260911L` only as a deterministic environment probe.
- The pinned MaRs upstream scripts use NumPy seed `0` for the main calibration fit and `47404` in several posterior-predictive/design scripts; preserve those conventions during reproduction unless a compatibility patch documents a deliberate change.
- Never use the personal baseline form, its item content, or its scored output as a runtime smoke fixture.
