# OpenIQ

**OpenIQ is an open, reproducible research program for psychometrically grounded cognitive assessment.**

The long-term goal is to build an open-source cognitive-ability battery whose scores are traceable from responses -> psychometric model -> reference population -> uncertainty -> validation evidence.

> [!IMPORTANT]
> OpenIQ is a research project, not a clinical diagnostic instrument. The first milestone targets **fluid/matrix reasoning (Gf)**. Until broader validation and norming justify it, OpenIQ must not present a fluid-reasoning score as Full Scale IQ.

## Research principles

1. **Evidence before claims.** A score is only as meaningful as its calibration, norming population, reliability, validity evidence, and uncertainty.
2. **Reproduce before inventing.** Reproduce published open psychometric pipelines before designing new items or models.
3. **Open by default, secure where scientifically necessary.** Publish code, analyses, protocols, and provenance when licensing and test-security constraints permit it; never expose restricted items or scoring keys just for convenience.
4. **No fake precision.** Report uncertainty and the exact reference population. Never manufacture an “IQ” conversion from raw accuracy or response time.
5. **No silent timing bonus.** Response time is research data unless a validated scoring model explicitly uses it.
6. **Version everything.** Item versions, forms, models, norms, exclusions, datasets, and reports must be reproducible.
7. **Ethics before publication-directed human data collection.** Obtain appropriate institutional/ethics guidance before collecting data intended for research publication.

## Current milestone — v0.1

Build and reproduce a **fixed-form, IRT-scored fluid-reasoning assessment** from an openly documented, already-calibrated matrix item bank. **MaRs-IB** is the primary candidate; **OMIB** is the independent comparison/replication source.

The v0.1 report must expose: latent ability estimate (theta), standard error/posterior uncertainty, reference calibration sample, test/item-bank version, raw accuracy as descriptive information only, and an explicit statement that the result is **not Full Scale IQ**.

## Repository map

- [`RESEARCH_CHECKLIST.md`](RESEARCH_CHECKLIST.md) — master execution/governance checklist
- [`ROADMAP.md`](ROADMAP.md) — staged research and product roadmap
- [`resources/`](resources/) — source registry, provenance, licensing, acquisition rules
- [`docs/research/verticals/`](docs/research/verticals/) — research curriculum (theory -> ethics)
- [`studies/`](studies/) — preregisterable/reproducible study protocols and analyses
- [`psychometrics/`](psychometrics/) — R-first psychometric research environment
- [`app/`](app/) — assessment application boundary
- [`data/`](data/) — data policy/local dataset layout
- [`ethics/`](ethics/) — consent, governance, and publication-readiness material
- [`external/`](external/) — locally fetched upstream resources governed by source-specific rules

## Start here

1. Read [`RESEARCH_CHECKLIST.md`](RESEARCH_CHECKLIST.md).
2. Read [`resources/SOURCES.md`](resources/SOURCES.md) before downloading or redistributing anything.
3. Reproduce Study 001 in [`studies/001-mars-replication/`](studies/001-mars-replication/).
4. If you want a meaningful personal baseline, **do not inspect the final scored baseline items before taking it**. Develop with sandbox/practice items instead.
5. Keep claims narrower than the evidence. “Fluid reasoning estimate” is acceptable for v0.1; “your IQ is X” is not.

## Licensing and third-party material

Original OpenIQ code is licensed under [`LICENSE`](LICENSE). Third-party papers, datasets, test items, stimuli, scoring keys, and code retain their upstream licenses and restrictions. **The root license does not relicense third-party material.** See [`resources/SOURCES.md`](resources/SOURCES.md) and [`external/README.md`](external/README.md).

## Status

**Bootstrap / literature-reproduction stage.** No OpenIQ score is currently validated for clinical diagnosis, educational placement, employment decisions, or other high-stakes use.
