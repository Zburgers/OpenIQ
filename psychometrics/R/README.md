# R reference environment

See [RUNTIME.md](RUNTIME.md) for the exact runtime, restore command, and deterministic seed policy.

The initial package set is `psych`, `mirt`, `lavaan`, `TAM`, and `catR`. `catR` is present for later simulation/research only; no CAT implementation belongs in this bootstrap.

Restore and verify from this directory:

```sh
Rscript -e 'renv::restore(prompt = FALSE, transactional = TRUE)'
Rscript smoke_test.R
Rscript session_info.R
```

Commit `renv.lock`, `.Rprofile`, and `renv/activate.R`/settings as needed for project activation. Never commit `renv/library/` or staging files.
