# OpenIQ Roadmap

The roadmap separates **what we can build** from **what we can scientifically claim**. A software milestone never automatically upgrades a psychometric claim.

## Phase 0 — Grounding and reproducibility

**Goal:** understand and reproduce the open literature before creating a new test.

- [ ] Build source/provenance registry for MaRs-IB, OMIB, ICAR/SAPA, TestMyBrain, OpenCogData, standards, and ethics guidance.
- [ ] Establish R research environment (`renv`) with `psych`, `mirt`, `lavaan`, `TAM`, `catR`, `mirtCAT`, and DIF/linking tools as needed.
- [ ] Reproduce published MaRs-IB calibration/validation analyses from public data/code.
- [ ] Reproduce core OMIB psychometric results independently.
- [ ] Reproduce selected ICAR/SAPA structural/reliability analyses without redistributing protected test material.
- [ ] Create reproducibility log: expected results, observed results, deviations, package versions, commit hashes.

**Gate:** We can regenerate key published estimates from upstream materials and explain each transformation.

## Phase 1 — OpenIQ-Gf v0.1 (personal research build)

**Goal:** produce a scientifically honest, auditable fluid-reasoning estimate.

- [ ] Choose one published fixed form or assemble a form strictly according to published/calibrated parameters.
- [ ] Keep personal-baseline scored items hidden from the developer/test-taker until baseline completion.
- [ ] Implement administration, practice, response capture, and versioned session logging.
- [ ] Implement/verify IRT scoring (initially EAP/MAP as appropriate to the source model).
- [ ] Report theta, uncertainty, reference sample, form version, raw accuracy, and limitations.
- [ ] Record response times but do not mix them into the primary score without a validated joint model.
- [ ] Compare against an independent open matrix source (e.g. OMIB) without naively averaging incompatible scales.

**Claim allowed:** experimental fluid/matrix-reasoning estimate relative to the named calibration sample.

## Phase 2 — Multidomain cognitive profile

**Goal:** broaden beyond matrix reasoning without prematurely claiming Full Scale IQ.

Candidate domains:
- fluid reasoning
- working memory
- processing speed
- spatial reasoning
- quantitative reasoning
- verbal/crystallized reasoning

Use validated/open tasks where possible (including TestMyBrain candidates) and preserve task-specific scoring/norms until joint calibration is justified.

**Gate:** each domain has documented reliability/validity evidence and a defensible score interpretation.

## Phase 3 — OpenIQ-GCA experimental general factor

**Goal:** determine empirically whether a general cognitive ability score is supported.

- [ ] Collect publication-ready human data only after ethics/governance review.
- [ ] Pre-register hypotheses, exclusion rules, factor models, and validation criteria.
- [ ] Compare correlated-factor, hierarchical, bifactor, and plausible alternative structures.
- [ ] Hold out an independent validation sample.
- [ ] Evaluate reliability, measurement information, convergent/discriminant evidence, and predictive/criterion relations where ethically appropriate.

**Claim allowed only if supported:** experimental general cognitive ability estimate for the studied population.

## Phase 4 — Norming, fairness, and India-focused validation

- [ ] Define the target population before sampling.
- [ ] Develop sampling/weighting strategy rather than treating an internet convenience sample as population norms.
- [ ] Study age, education, language background, region, device, and other justified grouping variables.
- [ ] Test measurement invariance and Differential Item Functioning (DIF).
- [ ] Quantify device/browser effects, especially for speeded tasks.
- [ ] Document non-invariance and limitations rather than deleting inconvenient evidence.

## Phase 5 — Adaptive/open item generation research

- [ ] Link/equate item banks before putting scores on a common scale.
- [ ] Simulate CAT offline before adaptive administration.
- [ ] Validate stopping rules, exposure controls, and content balancing.
- [ ] Research automatic item generation and whether structural features predict empirical item difficulty.
- [ ] Never treat predicted difficulty as equivalent to human calibration.

## Phase 6 — Publication and reusable open instrument

Target outputs:
- reproducible technical manual
- versioned test forms/item-bank provenance
- methods paper / validation paper(s)
- machine-readable scoring model
- open-source administration client
- public limitations and model cards
- citation metadata and archived releases/DOIs

A public “IQ-style” score is the **end of the evidence chain**, not the starting feature.
