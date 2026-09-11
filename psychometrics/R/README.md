# R Reference Environment

This directory will contain the canonical psychometric implementation.

## Bootstrap

1. Install current stable R.
2. From this directory, initialize `renv` (`renv::init()`).
3. Install only the packages required by the current study; freeze with `renv::snapshot()`.
4. Commit `renv.lock` but not `renv/library/`.

Initial packages to evaluate:

```r
install.packages(c(
  "renv",
  "psych",
  "mirt",
  "lavaan",
  "TAM",
  "catR"
))
```

Do not add CAT complexity until Study 001 fixed-form scoring is reproduced.
