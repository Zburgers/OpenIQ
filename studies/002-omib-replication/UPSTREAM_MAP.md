# Study 002 upstream map — OMIB (Open Matrices Item Bank)

Inspected 2026-11-10. This map records what the upstream OSF node actually contains, how the payload is structured, and what is still unresolved about licensing. The OMIB payload itself lives only under gitignored `external/downloads/omib/` (local, untracked); no OMIB file, item graphic, item code, solution string, or per-item parameter row is reproduced here. Structure and aggregate ranges are described only.

## Sources

| Kind | Identifier |
|---|---|
| Paper | Koch, Spinath, Greiff & Becker (2022), *Development and Validation of the Open Matrices Item Bank*, Journal of Intelligence 10(3):41 |
| DOI | `10.3390/jintelligence10030041` |
| Open full text | https://pmc.ncbi.nlm.nih.gov/articles/PMC9326670/ |
| Canonical OSF project | https://osf.io/4km79/ |
| OSF node API | https://api.osf.io/v2/nodes/4km79/ |
| OSF storage API | https://api.osf.io/v2/nodes/4km79/files/osfstorage/ (queried 2026-11-10: `total=6`, `next=null`; only provider is `osfstorage`, so no `?version=1` fallback was needed) |
| Related study docs | `studies/002-omib-replication/PROTOCOL.md`, `resources/SOURCES.md`, `resources/MANUAL_RESOURCES.md` |

Node metadata as returned on 2026-11-10: title `Open Matrices Item Bank`, `public: true`, `category: project`, `date_modified: 2022-07-12`, **`license: null`** (node-level license field is still empty).

## File inventory (all 6 files, provider metadata + local verification)

Downloaded 2026-11-10 with `curl -sL` from the canonical `osf.io/download/<id>/` URLs into `external/downloads/omib/` (gitignored via `.gitignore` line `external/downloads/`; confirmed with `git check-ignore`). Every local `sha256sum` matched the provider-advertised SHA-256 exactly, and every local byte size matched the API `size`.

| File | OSF file ID | Canonical download URL | Size (bytes) | Provider MD5 | Provider/local SHA-256 (verified match) | OSF `date_modified` |
|---|---|---|---:|---|---|---|
| `Figural Matrices.zip` | `6280d00452d172241a80aba2` | https://osf.io/download/f7t6b/ | 201,846 | `5995c27886fe1e0e2fb990e80ff00307` | `a84257998c1af479cb3097d35f9c6e2fb14abce6f022c3d2eb4b2b56a91589b3` | 2022-05-15 |
| `Instructions for Implementation.docx` | `62b56dea604ec4025e7afabc` | https://osf.io/download/dvsbz/ | 17,354 | `a0175688c6590b8fb01ca6da56f9ac0c` | `6c8fdac507f09bb21c4f039a975a5d68d8e046c72b8c0a92cd9e94e45a70d6ed` | 2022-06-24 |
| `Item Template.docx` | `62b56dea465aa4028c1d418e` | https://osf.io/download/gx7qt/ | 190,634 | `ca08cf45857115d74bfe86e816a96da4` | `aa5a006030b79d40a09298e57ca9a0385bcc58c7591a7db3143258bd376fa28f` | 2022-06-24 |
| `Item Data.xlsx` | `62b56deaca81740251ba2db5` | https://osf.io/download/fqtzp/ | 38,920 | `be8df33e7c9901c248cac60a98dd367d` | `ace35c7212c22a88c61d25b51e37b9fe25eeafd4fb6e910048d2cef5e2687bfd` | 2022-06-24 |
| `Web Version.zip` | `62b56dfc604ec402417af8b2` | https://osf.io/download/dxw34/ | 27,171 | `a88532d3fb1a127d418709608b9b4e2a` | `c9e2fd0dd01977f95592e781abe2f1fb4ced9171869eb0e58cc50d8fe1ae53a2` | 2022-06-24 |
| `Construction Elements.zip` | `62b56e09ca81740251ba2e02` | https://osf.io/download/k2d9x/ | 20,304 | `3eb271025c3b76542ec4107eec6da8f3` | `10ace73c7fa1ba968c3699c9d3879c4e22f18b51db5ecea39449455e8990373d` | 2022-06-24 |

The provider SHA-256 values now have a local verification result; this supersedes the "no local payload checksum claimed" note in `resources/MANUAL_RESOURCES.md` for OMIB (that file's check date was 2026-09-11).

## Payload structure (inspected, content not reproduced)

### `Item Data.xlsx`

Single worksheet `Item Data`, used range `A1:O221` — one header row plus 220 item rows (one row per item, `Item` 1–220, `Set` 1–10 with exactly 22 items per set). Columns:

| Col | Header | Structure |
|---|---|---|
| A | `Set` | integer 1–10 (test form membership) |
| B | `Item` | integer 1–220 (matches `Item_<n>.svg` filenames) |
| C–H | `Addition`, `Subtraction`, `Disjuncitve Union` *(sic)*, `Intersection`, `Rotation`, `Completeness` | binary 0/1 flags: which of the six construction rules the item uses (bank-wide rates ≈ .47–.55) |
| I | `Rules` | integer 1–5 = count of rules used; bank distribution 20/50/80/50/20 for 1/2/3/4/5 rules, i.e. exactly the paper's per-set recipe (2+5+8+5+2) × 10 sets |
| J | `mean` | CTT item mean, range .06–.98 |
| K | `r.drop` | CTT part–whole correlation, range .01–.75 |
| L | `b` | 2PL difficulty/threshold; 219 numeric values in [−8.98, 2.41]; one cell is the literal string `---` |
| M | `a` | 2PL discrimination; 219 numeric values in [0.11, 5.16]; the same single row is `---` |
| N | `Item Solution` | all-digits 0/1 content (20-element solution vector) but **stored as a spreadsheet number**, so leading zeros are lost (stored lengths 1–20 digits; 216 distinct values). Any reader must zero-pad back to 20 characters before use |
| O | `Complete Item Code` | 188-character string: nine comma-delimited groups of twenty `0`/`1` characters (9×20 + 8 commas = 188), 220 distinct — this is the "item code" the web implementation expects |

The single `---` row is worksheet row 8 (`Set` 4, `Item` 7): that item has no published `a`/`b`. Do not impute it silently; treat it as a documented parameter gap.

### `Instructions for Implementation.docx` (24 non-empty paragraphs, outline)

1. Title: "Instructions for the Implementation of the OMIB" — items developed primarily for computer-based testing; a pen-and-paper version also exists.
2. **Computer-Based Version** — `Web Version` folder (HTML/CSS/JS) for modern browsers; changeable variables: line 7 (current item number and total items to display), line 10 (starting time limit in seconds), line 207 (insert the item code from this OSF repository; "All valid item codes consist of nine groups of 20 ones and zeros, with the groups being delimited by commas"), line 208 (repeat the time limit from line 10). Contact the first author for further changes.
3. **Accessing the data (CB)** — two hidden inputs: `solution` = a 20-character `1`/`0` string of selected construction elements (1 = selected, 0 = not selected); `log` = click log with millisecond timings. Custom item types (e.g. QuestBack) import HTML directly.
4. **Pen-and-paper version** — `Item Template.docx` contains 20 pages of OMR-ready (optical mark recognition) matrix items; scan with any OMR software (authors tested Remark Office); all elements must be scanned in a fixed order (left-to-right, top-to-bottom), checked = `1`, unchecked = `0`.
5. **Test scoring** — both modes yield one 20-character `1`/`0` string per item; scoring compares it to the correct solution in `Item Data.xlsx`; **exact string equality → 1, anything else → 0** (dichotomous). R example given: `item_x_recoded = ifelse(item_x_raw == item_x_solution, 1, 0)`.
6. Contact section (first author of the companion article).

### `Figural Matrices.zip`

226 SVG entries, filenames only: `Anchor_1.svg` … `Anchor_6.svg` (the six anchor items shared by every test set) and `Item_1.svg` … `Item_220.svg` (6 + 220 = 226). Individual entry sizes range ≈ 3.8–12.4 KB; uncompressed total ≈ 1.87 MB. No other file types.

### `Construction Elements.zip`

41 entries: `Option1.svg` … `Option20.svg` at the root (the 20 selectable response elements, ≈ 345–406 bytes each) and a `With Border/` subfolder with the same 20 names in a bordered variant (≈ 792–879 bytes each), plus the folder entry itself. Two style variants × 20 elements.

### `Web Version.zip`

6 entries: `index.html`, `css/matrices.css`, `javascript/drawing.js`, `javascript/svg.js`. This is the reference computer-based implementation described by the instructions (item code inserted at line 207, time limit at line 10).

### `Item Template.docx`

A4 pages (`w=11906`, `h=16838`), 42 media entries; the only text content in the document body is repeated OMR circle glyphs — i.e. purely graphical OMR answer sheets, matching the "20 pages of OMR-ready items" description. No extractable item parameters or solution text.

## Response format and scoring semantics

- **Stimulus**: 3 × 3 matrix stem with the last cell empty; below it a palette of **20 construction elements** from which the test-taker constructs the response (paper §2.2/Figure 1).
- **Interaction**: click an element to select (red border), click again to deselect; no time limit in the calibration study; two practice items with feedback before the scored items; no feedback on scored items.
- **Response representation**: a 20-character binary string (element selected = `1`), captured in the hidden `solution` field (CB) or by OMR scanning in fixed reading order (paper).
- **Scoring**: exact string match of the response against the item's solution string from `Item Data.xlsx` → dichotomous correct/incorrect. There is no partial credit and no partial-credit weighting in the published workflow.
- **Model**: dichotomous **2PL** per Koch et al. (2022). Items were screened per test set with `mirt` misfit criteria (Wilson 2005: infit/outfit < 0.75 or > 1.33 together with a significant t-statistic); for items retaining the 2PL, threshold `b` and discrimination `a` were estimated with the R package `equateMultiple` (Battauz 2021) using anchor items to control for sample differences across the 10 forms. CTT item means and part–whole correlations came from `psych`; a multigroup CFA with `lavaan` (WLSMV, configural/strong/strict invariance) supported the single-factor reading. The `a`/`b` columns in `Item Data.xlsx` are the resulting published2PL parameters.

## Construction elements

Six transformation rules from Becker et al. (2016), applied to simple geometric shapes chosen for distinctiveness (to avoid confounding induction with visual perception): (1) addition, (2) subtraction, (3) disjunctive union / single-element addition, (4) intersection, (5) rotation, (6) completeness. Items were built on a planned normal-ish distribution of rule counts (2 items with 1 rule, 5 with 2, 8 with 3, 5 with 4, 2 with 5 per 22-item set; two items with three rules among the anchors). Two students constructed items from rule lists using a tool built by the first author. The six rule flags (cols C–H), the rule count (col I), the 20-element solution (col N), and the nine-group item code (col O) are the machine-readable construction metadata; the `Construction Elements.zip` palette and `Figural Matrices.zip` SVGs are the visual assets.

## Calibration design and sample limits

- **Design**: 10 test sets × 22 items + 6 shared anchor items = 28 items per participant; each participant took exactly one set (anchor-based equating, following Weber 2021 / Battauz 2017). Because the CTT difficulties of the 10 sets differed significantly while equated IRT difficulties did not, forms are not interchangeable without equating.
- **Administration**: self-paced, unproctored online test-preparation study for German medical-school admissions; order of subtests randomized; participants could skip whole subtests; no time limit on the matrices items (mean completion 26.05 min, SD 7.07; mean items solved 16.82, SD 7.79; only 1% solved all 28 correctly).
- **Sample size discrepancy (document, do not resolve)**: the abstract reports **N = 2,572** medical-school applicants; §2.1 reports 4,657 registered, minus 1,076 who skipped the matrices and 1,020 who gave no responses, giving a final sample of **N = 2,561**. Both figures appear in the published paper. OpenIQ should cite both and not silently pick one.
- **Population limits**: German medical-school applicants in a paid (€100, fee-waivable) test-prep study — a selected, high-achieving sample with possible preselection by GPA and, per the authors, restricted variance in general ability, which they note can bias item difficulties downward (overestimating ease) and weaken difficulty prediction from construction rules. Demographics: M age 19.34 (SD 2.58, range 15–45); 73.02% identified female, 25.11% male, 3 nonbinary, 45 unreported. Self-paced unproctored administration implies no experimental control over testing conditions. Consequence for OpenIQ: OMIB parameters are not norms, not a clinical or general-population reference, and any theta scale derived from them inherits this calibration sample.

## MaRs / OMIB non-linking constraint

MaRs-IB (Study 001) and OMIB were calibrated on different samples, with different item sets, response formats (MaRs multiple-choice vs OMIB constructed 20-element response), and different IRT pipelines. **No theta metric is shared.** Per `PROTOCOL.md`: do not average raw theta estimates from independent calibrations; any common-metric claim requires a future common-person and/or anchor-item linking/equating design. Rank/construct-level comparison (e.g. Spearman association of item properties within each bank, information-curve shapes) is allowed; score-level interchangeability is not. Scores from this study are never to be labeled "Full Scale IQ".

## Unresolved file-level license questions

1. Koch et al. (2022) states the item bank is provided under **GPLv3**, but the OSF node's `license` field is `null` and none of the six files carries a file-level license or `license.txt` notice in OSF metadata (confirmed again 2026-11-10). No license text exists inside the downloaded archives either (no LICENSE/COPYING entry in any of the three zips or two docx containers).
2. It is **unresolved whether GPLv3 is intended to cover the SVG stimuli and `Item Data.xlsx`**, or only the implementation code (`Web Version.zip`); the paper does not scope the statement and the files do not carry it. OpenIQ must not invent or infer a broader grant.
3. Therefore the disposition in `resources/MANUAL_RESOURCES.md` stands: payload stays local under `external/downloads/omib/`, untracked, no redistribution, no copying into tracked OpenIQ content, until file-level terms are confirmed with the authors/OSF record. Attribution to Koch et al. (2022) + the OSF node is required in any case.
4. The paper's Data Availability Statement ("datasets … in online repositories") points at this OSF node, which contains **no respondent-level response data** — only item-level metadata, stimuli, and implementation files. Any claim of reproducing the published 2PL estimates from raw data is therefore blocked upstream unless the authors provide the response data; see `REPRODUCTION_PLAN.md`.

## Security/scope notes

- No ICAR material was accessed, downloaded, or summarized; the ICAR boundary in `resources/MANUAL_RESOURCES.md` is untouched.
- No human data were collected for this study.
- OMIB payloads remain untracked (`git check-ignore` passes); this map and `REPRODUCTION_PLAN.md` are the only tracked Study 002 outputs of this bootstrap.

## Status

Sources, file inventory, checksums, and payload structure are mapped and locally verified. No model was fit in this bootstrap: no 2PL refit, no MCMC, no MaRs comparison has been executed, and no Study 002 numerical result is claimed.
