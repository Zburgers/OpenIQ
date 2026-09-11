# Bootstrap Agent Prompt

Use this prompt with a capable coding/research agent that has terminal + Git access.

---

You are bootstrapping the `Zburgers/OpenIQ` repository as a serious open psychometrics research project. Work as a research engineer: preserve provenance, do not overclaim, and do not expose restricted test content.

## Read first

Before editing anything, read in full:

- `README.md`
- `RESEARCH_CHECKLIST.md`
- `ROADMAP.md`
- `CONTRIBUTING.md`
- `resources/SOURCES.md`
- `resources/registry.yml`
- `external/README.md`
- `external/sources.lock.yml`
- `docs/research/DECISIONS.md`
- `studies/001-mars-replication/PROTOCOL.md`
- `studies/002-omib-replication/PROTOCOL.md`
- `ethics/README.md`

Do not weaken the scientific-claim boundaries in those files.

## Mission

Finish the local research bootstrap and prepare Study 001 to run. Do **not** build a flashy IQ website yet.

### 1. External Git sources

Run `scripts/bootstrap_external.sh` and verify the checked-out commits exactly match `external/sources.lock.yml`.

Inventory:
- `external/vendor/mars-irt`
- `external/vendor/testmybrain`
- `external/vendor/opencogdata`

Create `external/INVENTORY.md` containing each upstream source, commit, detected license file(s), important directories, and how OpenIQ intends to use it. Do not copy entire upstream repositories into tracked OpenIQ paths.

### 2. Manual OSF/resources

Investigate the canonical OSF resources:
- OMIB: `https://osf.io/4km79/`
- MaRs stimuli: `https://osf.io/g96f4/`

Before downloading, record file-level names, source URLs, license/attribution information, and whether redistribution is clearly permitted. If terms are unclear, keep the resource local/untracked and document the uncertainty. For any downloaded archive/file, record SHA-256 checksums in a manifest.

For ICAR, **do not scrape or publish protected items, scoring keys, or restricted psychometric material**. Read current project guidance and document the access/registration steps only. If access requires user action, stop that subtask and report the exact action needed.

### 3. Papers and bibliography

Create `resources/references.bib` with accurate metadata for at least:
- Chierchia et al. 2019 MaRs-IB — DOI 10.1098/rsos.190232
- Zorowitz et al. 2023 MaRs IRT — DOI 10.3758/s13428-023-02067-8
- Koch et al. 2022 OMIB — DOI 10.3390/jintelligence10030041
- Condon & Revelle ICAR/SAPA data paper — DOI 10.5334/jopd.25
- Singh et al. TestMyBrain DNT — DOI 10.1080/13803395.2021.2002269
- Chalmers 2012 `mirt` — DOI 10.18637/jss.v048.i06

Use canonical publisher/PubMed/PMC metadata. Do not invent author/year/page details.

Do not commit publisher PDFs merely because they are downloadable. Links/citations are enough unless redistribution is clearly permitted and useful.

### 4. R psychometrics environment

Under `psychometrics/R/`:
- initialize `renv`;
- install current study dependencies (start with `psych`, `mirt`, `lavaan`, `TAM`, `catR`; do not add packages gratuitously);
- commit `renv.lock`, not the local library;
- add a `session_info.R` helper and a minimal smoke test proving packages load;
- document exact R version.

Do not introduce CAT implementation beyond package availability; CAT is not v0.1.

### 5. Study 001 upstream map

Create `studies/001-mars-replication/UPSTREAM_MAP.md` after inspecting all upstream MaRs branches (`main`, `calibration`, `validation-A`, `validation-B`). Map:
- datasets
- scripts/notebooks
- item parameter outputs
- tutorials/form assembly material
- environment/dependencies
- calibration workflow
- validation workflow
- stimuli dependency

Then create `studies/001-mars-replication/REPRODUCTION_PLAN.md` with an ordered command-level plan to reproduce published results without editing upstream data.

### 6. Reproducibility harness

Add a root `Makefile` or equivalent thin task runner with commands such as:
- `bootstrap-external`
- `r-smoke`
- `study-001` (may initially call a documented wrapper/TODO rather than pretending the full replication is done)
- `check-provenance`

Never hide failed reproduction results. If upstream code no longer runs on current R, document the failure and isolate compatibility fixes rather than silently changing the analysis.

### 7. Personal baseline isolation

The repo owner wants to take the eventual test. Prevent contamination:
- do not print/render the final scored MaRs baseline items/solutions in normal setup logs/docs;
- development uses practice/sandbox material;
- if a final personal form is assembled, keep its content isolated from the owner until administration while retaining enough metadata for reproducibility afterward.

### 8. Git discipline

Create a branch such as `chore/research-runtime-bootstrap`.
Commit only OpenIQ-authored scripts/docs/config/lockfiles and explicitly redistributable small artifacts. External clones, large datasets, restricted items, and participant data remain untracked as specified by `.gitignore`.

Open a PR summarizing:
- sources acquired
- licenses verified
- unresolved access/license questions
- R environment status
- Study 001 readiness
- exact commands to reproduce setup

## Hard prohibitions

- Do not copy WAIS/Raven proprietary items.
- Do not call a matrix score Full Scale IQ.
- Do not derive IQ as `percent correct` or `correct - time penalty`.
- Do not merge MaRs and OMIB theta scales without linking/equating.
- Do not commit protected ICAR material.
- Do not collect a publication-directed human-subject dataset as part of bootstrap.
- Do not expose the repo owner to final personal-baseline scored items before they take them.

## Definition of done

The repository can be cloned on a clean machine, external open dependencies can be reproduced at pinned versions, R psychometrics dependencies are locked, Study 001 has a complete upstream map and executable reproduction plan, and all unresolved licensing/access/ethics questions are explicit rather than guessed away.

---
