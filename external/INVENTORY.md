# External source inventory

All sources below were cloned by `scripts/bootstrap_external.sh` on 2026-09-11. The clones are intentionally gitignored and are not copied into tracked OpenIQ directories.

## `mars-irt`

- Canonical source: https://github.com/ndawlab/mars-irt.git
- OpenIQ pin: `04eecdaf77d0ee657c65351eab5ed9e744b1ce14` (`main`)
- Related upstream branch tips inspected: `calibration` `2ba65518b018191ac8196e8e5754a1bffafaf85e`, `validation-A` `ffd1fc5f8b04f26b326df19e8f16cec9dc51ca30`, `validation-B` `14b5b04cbe56fa9896547df4a7e7f334fb85b7e1`.
- License file: `LICENSE` (MIT-style text, Copyright 2019-2022 Daw Lab).
- Purpose: primary Study 001 reproduction target for MaRs-IB calibration, item parameters, information, and validation forms.
- Major useful paths: `01_Priors/`, `02_Design/`, `03_Calibration/`, `04_Validation/`, `05_Figures/`, `manuscript/`, `tutorials/`, `requirements.txt`.
- Redistribution: the repository code is licensed by `LICENSE`; the included research data, generated results, and any stimuli remain subject to their own rights and research-use constraints. OpenIQ does not assume blanket redistribution permission.
- Local/untracked: yes. Keep the complete clone under `external/vendor/mars-irt`; do not vendor its item media, raw participant exports, or generated output into OpenIQ.

## `testmybrain`

- Canonical source: https://github.com/manybrainsproject/TestMyBrainCodeRepo.git
- OpenIQ pin: `ec09ea0d35779bb39997131313dfd1380ee34922` (`main`)
- License files: `LICENSE` (GNU GPLv3 text) and `COPYING.LESSER` (GNU LGPLv3 text). The upstream README states that cognitive-test code and the TestMyBrain library are LGPLv3; stimuli normally use CC-BY-SA 4.0 unless a task overview says otherwise.
- Purpose: later candidate source for processing-speed, attention, working-memory, vocabulary, and related multidomain research; not required for Study 001 execution.
- Major useful paths: `TMB_Library/TestMyBrain_GitHub.12.18.js`; `TMB_Tests/` and its task directories (`TMB_Matrix`, `TMB_DigitSpan`, `TMB_DigitSymbolMatching`, `TMB_FlankerAttention`, `TMB_TrailMaking`, `TMB_Vocab`, and others), each with task documentation and source/media.
- Redistribution: code/library redistribution is permitted only with the applicable LGPLv3/GPLv3 notices and source obligations. Stimulus redistribution is task-specific; inspect each task overview before any reuse.
- Local/untracked: yes. Keep the clone under `external/vendor/testmybrain`; do not copy task media or scored content into tracked OpenIQ paths.

## `opencogdata`

- Canonical source: https://github.com/nimh-dsst/OpenCogData.git
- OpenIQ pin: `aef5a7149eff8f1120e9ef6fd7b3c25f7bc8e63c` (`docs`)
- License files: root `LICENSE` (MIT, Copyright 2023 National Institute of Mental Health) and `themes/OpenCogData/LICENSE` (MIT, Copyright 2021 Lhc_fl).
- Purpose: discover publicly described cognitive-task datasets and candidate replication data; the catalogue is not itself a license grant for indexed datasets.
- Major useful paths: `source/_posts/` (dataset catalogue entries), `source/about/`, `source/contribute/`, `templates/`, `tools/`, `package.json`, `package-lock.json`, `.github/workflows/pages.yml`.
- Redistribution: OpenCogData project code is MIT. Each indexed dataset retains its own access, license, consent, and redistribution terms; metadata-only use is the default.
- Local/untracked: yes. Keep the clone under `external/vendor/opencogdata`; do not copy indexed datasets into OpenIQ.

## Verification

The three checked-out commits are verified by `scripts/check_provenance.sh`. `external/sources.lock.yml` is the authority for the three bootstrap pins; the additional MaRs branch tips above are recorded for the Study 001 map and are not independent OpenIQ lockfile pins.
