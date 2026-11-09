# Study 001 upstream map

This map is based on the four relevant `ndawlab/mars-irt` branch tips inspected on 2026-09-11. The upstream clone remains under ignored `external/vendor/mars-irt`; OpenIQ does not copy its participant data, item media, or generated output into tracked source directories.

| Branch | Inspected commit | Role |
|---|---|---|
| `main` | `04eecdaf77d0ee657c65351eab5ed9e744b1ce14` | analysis repository, manuscript, tutorials |
| `calibration` | `2ba65518b018191ac8196e8e5754a1bffafaf85e` | public calibration experiment application |
| `validation-A` | `ffd1fc5f8b04f26b326df19e8f16cec9dc51ca30` | validation application with short forms |
| `validation-B` | `14b5b04cbe56fa9896547df4a7e7f334fb85b7e1` | validation application with long form |

## Main analysis tree

- `01_Priors/` contains pilot-study data, selection notebooks, prior/model-fitting scripts, posterior-predictive checks, and Stan models for the prior work.
- `02_Design/` contains recovery simulations, design assembly/PSIS scripts, and Stan models used to assess the calibration design.
- `03_Calibration/` is the primary calibration workflow. It contains 1,584 raw participant JSON records, processed `data.csv`/`metadata.tsv`/`reject.csv`, design matrices, notebooks, Python scripts, Stan models, and tracked Stan summaries.
- `04_Validation/` contains 1,018 short-form and 1,062 long-form raw JSON records, processed form-specific data, fixed item parameters, validation notebooks, collation/fitting scripts, and validation Stan models.
- `05_Figures/` contains generated figure inputs/outputs; `manuscript/` contains LaTeX, bibliography, and manuscript artifacts; `tutorials/` contains public form-level examples and an assembly notebook.

## Calibration workflow

1. `03_Calibration/scripts/collate_data.py` reads sorted raw JSON, removes practice trials, normalizes response time to seconds, joins item metadata, and writes processed metadata/response tables.
2. `make_design.py` filters rejected/missing records, standardizes response-time and item-feature covariates, and writes `X1.csv`, `X2.csv`, and `X3.csv`.
3. The modeling scripts construct person/item matrices and call CmdStanPy with four chains, 5,000 warmup iterations, 2,500 sampling iterations, four-way parallelism, and seed `0` for the main fit. Model selection is a command argument, not an implicit default.
4. `fit_irt_ppc.py`, `fit_irt_x2.py`, and `fit_irt_sgddm.py` produce posterior/design diagnostics using the upstream NumPy seed `47404` where specified.

The calibration model family includes 1PL, generalized 1PL, and 3PL variants with explanatory person/item covariates and family/clone residual components. The Stan files in `03_Calibration/stan_models/` are the authoritative specifications. One upstream conditional in `fit_irt_ppc.py` appears to make a gamma assignment unconditional; preserve and report this behavior until an explicit sensitivity analysis authorizes a statistical change.

## Validation workflow

`04_Validation/scripts/` collates the short/long responses, applies the fixed `alpha`, `beta`, and `gamma` values from `data/params.csv`, and fits the validation models in Stan. `01_Assembly.ipynb` documents the form construction, information, and reliability calculations; the remaining notebooks cover screening, descriptive results, and self-report analyses. Validation-A exposes three 12-item short-form routes; validation-B exposes a 24-item long-form route. This map intentionally records form structure without reproducing scored item content or a personal form.

## Dependencies and useful artifacts

- Python dependencies declared by upstream: NumPy, SciPy, pandas, statsmodels, numba, tqdm, CmdStanPy, ArviZ, `mip`, matplotlib, seaborn (minimum seaborn 0.11.1).
- The upstream notebooks require a Jupyter execution environment and should be run with outputs directed to a disposable copy.
- Important generated artifacts include processed tables, design matrices, Stan posterior summaries/draws, posterior-predictive diagnostics, information/reliability summaries, figures, and manuscript tables. Their exact provenance must retain the upstream commit and command log.
- The public stimuli dependency is the MaRs OSF project (`https://osf.io/g96f4/`), whose current file listing/license file was not recoverable in the bootstrap; see `resources/MANUAL_RESOURCES.md`.

## Status

The upstream tree and notebook/script structure are mapped. No calibration or validation model was executed by this bootstrap, so no Study 001 numerical reproduction is claimed. `run.sh` deliberately reports `PLANNED_NOT_EXECUTED` until the command-level plan has been run in a pinned Python/CmdStan environment.
