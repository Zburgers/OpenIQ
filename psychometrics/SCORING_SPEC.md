# Scoring Spec — Sandbox Gf v0.1 (fixed-form EAP/MAP)

**Owner:** Devon Kai (Scoring Prototype, Sandbox) · **Date:** 2026-11-10
**Status:** SPEC ONLY — no scored-form UI, no production code. Requires challenge by Dr. Priya Nair (construct) and Dr. Santiago Ruiz (red team) before any `app/` implementation.
**Applies to:** G1 "Sandbox Gf v0.1" (see `docs/lab/CHARTER.md`). Blocked on G0-4 for real parameters; runnable today on sandbox/synthetic item IDs and parameters only.

Reference implementation: R/`mirt` (`psychometrics/R/`). Production implementation must match it numerically (§9). The `app/` shell only calls this contract; it must not invent psychometrics (`app/README.md`).

---

## 0. Scope and non-goals

In scope: one **fixed** form, unidimensional IRT, **EAP as the reported estimator**, MAP as a cross-check, theta + uncertainty, versioned report.

Explicit non-goals (hard constraints, from CHARTER / app README / PROTOCOL non-goals):

- No `% correct → IQ` conversion of any kind. Raw accuracy appears only as a descriptive count.
- No `correct − time penalty`. RT is metadata, never an ability input.
- No CAT / adaptive administration (`catR` stays research-only; see `psychometrics/R/README.md`).
- No real item stimuli, no personal-form content anywhere in this spec or its fixtures. Sandbox IDs only (`SBX-*`).
- No FSIQ language: no score produced here is, maps to, or is labeled Full Scale IQ.
- No invented norms, no averaging of θ across independent calibrations (MaRs θ ≠ OMIB θ).

## 1. Inputs and version identity

The scoring function has exactly three arguments. Anything else that exists in the session is metadata (§7) and **cannot** change the score.

```
score(form, model, responses) -> ScoreResult

form  := { form_id, form_version, manifest_hash }   # immutable manifest of item IDs
model := { model_id, model_version,
           family: "1PL" | "3PL",
           param_source, param_hash }               # versioned parameter export
responses := { item_id -> 0 | 1 }                   # only observed, manifest-listed items
```

Parameter file (upstream export, e.g. from Study 001 `data/params.csv` after G0-4 acceptance):

| column | meaning |
|---|---|
| `item_id` | sandbox/stable ID, never item content |
| `model` | `1PL` or `3PL` — params are never mixed across families |
| `a` (`alpha`) | discrimination (1PL: fixed `1.0`, may be omitted) |
| `b` (`beta`) | difficulty |
| `c` (`gamma`) | guessing (1PL: fixed `0.0`, may be omitted) |
| `param_source` | provenance string, e.g. `mars-irt@04eecdaf…` or `G0-4-export` |
| `param_hash` | sha256 of the export bytes |

Rules: parameters are **loaded**, never estimated at scoring time; keyed by `item_id`; `param_hash` and `manifest_hash` are baked into every report and log line. No item geometry/text/distractors are read by the scorer (blinding rule).

## 2. Models

For item *j* with parameters `(a_j, b_j, c_j)` and response `x_j`:

```
1PL:  a_j = 1, c_j = 0                     # single difficulty per item
3PL:  a_j, b_j, c_j free (from upstream export)

π_j(θ) = 1 / (1 + exp(-a_j · (θ - b_j)))         # logistic core
p_j(θ) = c_j + (1 - c_j) · π_j(θ)                # ICC
P(x_j | θ) = p_j(θ)^x_j · (1 - p_j(θ))^(1 - x_j)
```

Both families are supported; exactly one is active per `model_id`. Choosing 1PL vs 3PL is a **model version change**, not a silent toggle — the report records which ran.

## 3. Estimator — EAP (reported), MAP (cross-check)

Prior: standard normal `logprior(θ) = -θ²/2 + const`, declared as part of `model_version`. The prior is proper, which is exactly why EAP is the estimator of record: MLE diverges (→ ±∞) on all-correct/all-wrong patterns, and MAP alone is fragile at the tails.

### 3.1 Pseudocode (deterministic, no RNG)

```
PRECHECK
  1. every responded item_id ∈ manifest        else ERROR("unknown_item")
  2. every value ∈ {0, 1}                      else ERROR("invalid_response")   # never coerce
  3. n_observed = |responses|, n_total = |manifest|
  4. if n_observed == 0: return NO_ESTIMATE(reason = "no observed items")       # no theta, ever

GRID
  bounds = [-6, +6], step = 0.01                                       # fixed, recorded
  repeat at most 5 times:
      θ_k = bounds.lo + k·step,  k = 0..K
      ℓ_k = logprior(θ_k) + Σ_{j observed} [ x_j·log p_j(θ_k) + (1-x_j)·log(1-p_j(θ_k)) ]
      w   = softmax(ℓ)                                                 # logsumexp for stability
      if w[0] + w[K] < 1e-6: break                                     # tails negligible
      bounds = [bounds.lo - 2, bounds.hi + 2]                          # deterministic expansion
  if edge mass still ≥ 1e-6 after 5 expansions:
      flag "grid_overflow" and report with that flag (never clamp silently)

EAP (reported)
  θ̂_eap = Σ w_k · θ_k
  SE    = posterior SD = sqrt( Σ w_k · (θ_k - θ̂_eap)² )                # SE ≡ posterior SD for EAP
  CI95  = weighted 2.5% / 97.5% quantiles of {θ_k, w_k}                # grid is already computed
  num_err = |θ̂_eap(step 0.005) - θ̂_eap(step 0.01)|                     # QA metric, logged not shown

MAP (cross-check only, never the headline number)
  θ̂_map = argmax_k ℓ_k
  SE_map = 1 / sqrt( I(θ̂_map) + 1 )                                    # +1 = information of N(0,1) prior

OUTPUT: { theta_eap, se_eap, ci95, theta_map, se_map,
          n_observed, n_total, grid_bounds, grid_step, flags[] }
```

Design notes (the "no arbitrary formulas" clause):

- The **only** constants are numerical: logsumexp tail tolerance `1e-6`, grid step `0.01`, expansion `2.0`, cap `5`. They control floating-point accuracy, not psychometric meaning, and each is verified in §9.
- Reported `SE` **is** the posterior SD (same quantity for EAP). We do not invent a separate SE formula. Posterior SD at extremes is the honest answer to Priya's challenge ("EAP shrinks extremes — report SE + posterior SD, never a bare IQ-like number"): the shrinkage stays, and the CI/SE makes it visible instead of pretending the point estimate is exact.
- No RT, no device, no timing term appears anywhere in `ℓ_k`.

## 4. Information function

Test information (observed items only):

```
I(θ)   = Σ_j  p_j'(θ)² / ( p_j(θ) · (1 - p_j(θ)) )
p_j'(θ) = (1 - c_j) · a_j · π_j(θ) · (1 - π_j(θ))
```

- Report/plot `I(θ)` and per-item `I_j(θ)` on the scoring grid (descriptive, versioned with the model).
- `I(θ)` is what converts MAP's point estimate to `SE_map` (§3), and what the verification plan cross-checks across languages (§9).
- Low information at an extreme is expressed by a **wide SE/CI**, not by truncating or rescaling theta.

## 5. Missing, out-of-range, and edge handling

| case | behavior |
|---|---|
| item unanswered / unadministered | skipped in the likelihood (factor = 1). Never imputed, never counted wrong, never defaulted right. `n_observed`/`n_total` reported. |
| zero observed items | `NO_ESTIMATE` — no theta, no SE, explicit reason. |
| response value ∉ {0,1} (e.g. `-1`, `2`) | hard `ERROR("invalid_response")`, no partial score, incident logged with item ID (never content). No silent coercion or clipping. |
| item_id not in manifest | hard `ERROR("unknown_item")` (guards against stale/forged forms). |
| posterior mass at grid edge | deterministic grid expansion (§3); residual → `grid_overflow` flag. **Never clamp θ to the grid bound.** |
| extreme true ability (θ_true = ±4 in tests) | EAP shrinkage toward the prior is expected and *documented*: CI widens, point estimate stays finite. Test T6 asserts shrinkage is present and disclosed, not "fixed". |
| low information (few/ambiguous responses) | no suppression threshold: wide SE + `n_observed/n_total` carry that uncertainty to the reader. |
| model/param mismatch (family vs export) | hard `ERROR("param_family_mismatch")`. |

## 6. Determinism and seeds

- **Scoring itself uses no RNG.** Same `(form, model, responses)` → byte-identical `ScoreResult` on any machine. Test T7.
- Seeds exist only for data generation / stochastic QA:
  - R: `RNGkind("L'Ecuyer-CMRG")` then `set.seed(20260911L)` (house policy, `psychometrics/R/RUNTIME.md`), seed recorded in generated metadata.
  - Python: `numpy.random.default_rng(20260911)` recorded the same way.
  - **Cross-language fixtures are generated once, serialized, and read by both sides.** Identical seeds do *not* imply identical streams across R and NumPy; re-generating a fixture independently per language is a bug, not a tolerance question.
- Every `ScoreResult` and report embeds: `form_version`, `manifest_hash`, `model_id`, `model_version`, `param_hash`, estimator + grid + prior, software versions (`R 4.6.1`/`mirt x.y.z`, Python/`openiq-scoring x.y.z`), timestamp, seed (if any stochastic step ran).

## 7. Session logging — metadata only

Logged per session (schema-level; content never logged):

```
session_id, timestamp_utc, form_id, form_version, model_id, model_version
device_class (desktop|mobile|tablet), ua_family (browser, no full fingerprint)
input_method (touch|key), viewport bucket
focus_loss_count, visibility_hidden_count        # quality flags
rt_ms per item_id                                # response time — METADATA
n_unanswered, error_codes[]                      # e.g. invalid_response
```

Invariants, enforced by the API shape, not by convention:

1. `score()` (§1) takes only `form, model, responses`. Logger runs alongside, never through, the scorer. Test T10 proves injecting/logging different metadata yields a byte-identical `ScoreResult`.
2. RT never enters `θ`, never penalizes, never gates. If a *validated* joint RT+response model ever exists (charter-satisfying), that is a **new `model_version`**, not an edit to this one.
3. Device/browser/focus values are **quality flags surfaced in the report** (e.g. "focus lost 3×, touch input") — they can caveat a result, never change it.
4. Debug logs never contain item content, stimuli, or answer keys (personal-baseline blinding rule). Responses live in the response store keyed by item ID, not in stdout.

## 8. Report template

```md
# OpenIQ — Sandbox Gf v0.1 result

**Fluid reasoning (Gf) estimate — fixed-form IRT score.**

> ### Fluid reasoning estimate, not Full Scale IQ.

## Result
- θ (EAP): {theta_eap:+.2f}   SE (posterior SD): {se_eap:.2f}
- 95% credible interval: [{ci_lo:+.2f}, {ci_hi:+.2f}]
- MAP cross-check: θ = {theta_map:+.2f}, SE = {se_map:.2f}
- Metric: standardized **reference (calibration) sample** metric, mean 0 / SD 1 *in that sample*.
  Not population norms, not a normed IQ scale.

## Reference & versions
- Form: {form_id} v{form_version} · manifest sha256:{manifest_hash}
- Model: {model_family} · {model_id} v{model_version} · params sha256:{param_hash}
  (param source: {param_source})
- Reference sample: {reference_description + provenance link, G0-4 status}
- Estimator: EAP, grid [{lo}, {hi}] step {step}, prior N(0,1), deterministic (no RNG)
- Software: {R/mirt version}, {python/openiq-scoring version} · {timestamp_utc}

## Data quality (metadata — does not affect the score)
- Answered {n_observed}/{n_total} items ({n_missing} missing → excluded from likelihood)
- Descriptive accuracy (**not a score**): {n_correct} of {n_observed} answered correct
- Flags: {focus_loss_count} focus loss(es), {input_method}, {device_class}, RT median {rt_ms} ms/item
- Grid/numerics: {grid_expansions} expansion(s), integration error {num_err:.1e}

## Limitations
- Single unidimensional fixed form; one construct, one occasion, one device session.
- Uncertainty shown here is measurement error only; practice/fatigue/device effects are not modeled.
- Parameters are upstream/sandbox and pending Study 001 (G0-4) acceptance.
- This instrument does not measure, and must not be reported as, Full Scale IQ.
```

Copy rules for any future UI: the disclaimer line is **verbatim and always present**; the metric line always says "reference/calibration sample … not population norms"; raw accuracy always carries "(not a score)"; versions block is never collapsed away.

## 9. Verification plan — Python vs R/`mirt`

**Principle** (vertical C): R/`mirt` is the reference; production scoring is tested numerically against it, with tolerances declared **before** running.

### 9.1 Fixtures (sandbox only — no real items, no personal form)

- `fixtures/scoring_sbX.csv`: 5 sandbox item IDs `SBX-001…SBX-005`, synthetic `(a, b, c)` for both families, generated once under seed `20260911L` and committed.
- `fixtures/responses_sbX.csv`: 20 synthetic subjects × 5 items with known `theta_true`, committed and read byte-identically by R and Python.
- Both R and Python implementations must read the same fixture files. Regenerating fixtures per language is forbidden (§6).

### 9.2 Reference configurations

- **Tier A — pure cross-language check:** hand-rolled R EAP/MAP (same grid, same prior, same logsumexp) vs Python implementation. Isolates language/float error from `mirt` internals.
  **Tolerance:** `|Δθ̂| ≤ 1e-8`, `|ΔSE| ≤ 1e-8`, `|ΔI(θ)| ≤ 1e-8` (absolute) at probe thetas `{−3, −1, 0, +1, +3}`.
- **Tier B — against `mirt`:** `mirt()` built with **fixed item parameters** from the fixture export (`pars=` values, params constrained so nothing is re-estimated), then `fscores(method = "EAP", SE = TRUE)` and `fscores(method = "MAP", SE = TRUE)`.
  **Predeclared tolerance:** `|Δθ| ≤ 0.01`, `|ΔSE| ≤ 0.01` (target ≤ 1e-3). Rationale: 0.01 on a SD = 1 metric is ~1/20 of a typical reported SE (≈0.2–0.5), so it cannot change interpretation. Any exceedance → post to `#scoring-app` + `#red-team` with the delta table; investigate quadrature/model mismatch; **no silent tolerance bumps, no silent code patches** (Study 001 protocol rule).
- Info-function check: `I(θ)` from Python vs analytic R formula (Tier A tolerance) and vs `mirt::testinfo()` (Tier B tolerance).

### 9.3 Test cases (each must pass in both languages)

| # | case | assertion |
|---|---|---|
| T1 | **all-correct** | finite θ̂, smallest SE of the set; no divergence (MLE would diverge — MLE is not used) |
| T2 | **all-wrong** | finite θ̂, SE comparable to T1 (prior keeps the posterior proper) |
| T3 | **mixed** | several patterns; θ̂ ordering matches `theta_true` ordering on average; Tier A/B tolerances hold |
| T4 | **missing** | pattern with 2 of 5 unanswered ≡ scoring the 3-item subset by hand; `n_observed=3/5` reported; 0-observed → `NO_ESTIMATE` |
| T5 | **out-of-range** | value `2` and `-1` → `ERROR("invalid_response")`, no output object; unknown ID → `ERROR("unknown_item")` |
| T6 | **edge thetas** | synthetic `theta_true ∈ {−4, +4}`: shrinkage toward 0 present, CI wide, report shows SE/CI — shrinkage is disclosed, not hidden |
| T7 | **determinism** | same inputs scored twice → byte-identical result; identical across R and Python (Tier A) |
| T8 | **1PL vs 3PL** | same responses, both families → both finite, values differ, `model_id` recorded; mismatched family/param export → `ERROR("param_family_mismatch")` |
| T9 | **grid edge** | extreme pattern triggers expansion; tail mass `< 1e-6`; cap-hit produces `grid_overflow` flag, never a clamped θ |
| T10 | **metadata isolation** | vary RT / device / focus logs with responses held fixed → byte-identical `ScoreResult` |

### 9.4 Recording

Pass/fail + deltas go into `#scoring-app` (append-only) and later into the Study 001/G1 evidence the CEO cites in `GATES.md`. I do not edit `GATES.md`.

## 10. Hard-constraint self-check

- [x] No `% → IQ` — accuracy shown only as a labeled descriptive count.
- [x] No time penalty — RT is logged metadata, excluded from `score()` (T10).
- [x] No CAT — fixed form only; `catR` untouched.
- [x] No real item stimuli / personal-form content — sandbox `SBX-*` IDs and synthetic params only.
- [x] No FSIQ language beyond the mandated negation disclaimer.
- [x] No invented norms — reference sample named, sourced, and labeled as not population norms.
- [x] Theta never reported bare — SE/CI always accompany the point estimate.
