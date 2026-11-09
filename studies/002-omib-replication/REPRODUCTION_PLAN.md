# Study 002 reproduction plan (OMIB)

Executable plan for reproducing the OMIB item/scoring workflow of Koch et al. (2022). Ordered stages; each stage must pass before the next claims anything. All OMIB payload handling is local-only: `external/downloads/omib/` is gitignored, and no OMIB file, item graphic, item code, solution string, or per-item parameter row may be committed or redistributed.

Run from the OpenIQ root. Keep the command log and environment manifest outside tracked OpenIQ source until provenance review.

## Stage 0 — status of this plan

Stages 1–2 (acquisition and verification) were executed on 2026-11-10 and their results are recorded in `UPSTREAM_MAP.md`. Stages 3–5 are **not** executed; no 2PL refit, no MCMC, and no MaRs comparison has been run. Nothing in this plan may be reported as a Study 002 result until its stage commands have actually been run and logged.

## Stage 1 — local-only acquisition

Re-runnable; idempotent (overwrites the local copies). Expected SHA-256 values are the provider-advertised hashes recorded in `UPSTREAM_MAP.md`.

```sh
mkdir -p external/downloads/omib
cd external/downloads/omib

while IFS='|' read -r name url; do
  curl -sL -o "$name" "$url"
done <<'EOF'
Figural Matrices.zip|https://osf.io/download/f7t6b/
Instructions for Implementation.docx|https://osf.io/download/dvsbz/
Item Template.docx|https://osf.io/download/gx7qt/
Item Data.xlsx|https://osf.io/download/fqtzp/
Web Version.zip|https://osf.io/download/dxw34/
Construction Elements.zip|https://osf.io/download/k2d9x/
EOF
```

Freshness check against the live node (any new/changed file invalidates `UPSTREAM_MAP.md`):

```sh
curl -s "https://api.osf.io/v2/nodes/4km79/files/osfstorage/" | python3 -m json.tool | less
curl -s "https://api.osf.io/v2/nodes/4km79/" | python3 -c "import json,sys; print(json.load(sys.stdin)['data']['attributes'].get('license'))"
```

## Stage 2 — verification (must pass before Stage 3)

```sh
cd external/downloads/omib
sha256sum * | sort
# expect, in alphabetical order:
# 10ace73c...90373d  Construction Elements.zip
# a8425799...1589b3  Figural Matrices.zip
# 6c8fdac5...a70d6ed  Instructions for Implementation.docx
# ace35c72...2687bfd  Item Data.xlsx
# aa5a0060...76fa28f  Item Template.docx
# c9e2fd0d...ae53a2  Web Version.zip
# (full values in UPSTREAM_MAP.md; every value must equal the provider SHA-256)

cd ../..
git check-ignore -v "external/downloads/omib/Item Data.xlsx"   # must print .gitignore match
git status --porcelain external/                               # must print nothing
```

Structural inspection (structure only — do not print solution strings, item codes, or per-item rows into any tracked file or report):

```sh
python3 - <<'PY'
import zipfile, re, xml.etree.ElementTree as ET
ns = {'m': 'http://schemas.openxmlformats.org/spreadsheetml/2006/main'}
z = zipfile.ZipFile('external/downloads/omib/Item Data.xlsx')
ss = [''.join(t.text or '' for t in si.iter('{http://schemas.openxmlformats.org/spreadsheetml/2006/main}t'))
      for si in ET.fromstring(z.read('xl/sharedStrings.xml'))]
ws = ET.fromstring(z.read('xl/worksheets/sheet1.xml'))
print('dimension:', ws.find('m:dimension', ns).get('ref'))          # expect A1:O221
def val(c):
    v = c.find('m:v', ns)
    return None if v is None else (ss[int(v.text)] if c.get('t') == 's' else v.text)
rows = list(ws.find('m:sheetData', ns))
hdr = [val(c) for c in rows[0]]
print('headers:', hdr)
PY

unzip -l "external/downloads/omib/Figural Matrices.zip" | tail -1   # 226 entries
unzip -l "external/downloads/omib/Construction Elements.zip" | tail -1  # 41 entries
unzip -l "external/downloads/omib/Web Version.zip" | tail -1       # 6 entries
```

Gate: checksums match, files stay untracked, workbook is `A1:O221` with the 15 documented headers, archive entry counts match `UPSTREAM_MAP.md`. On any mismatch, stop and update the map; do not proceed with stale provenance.

## Stage 3 — R environment

```sh
cd psychometrics/R
Rscript -e 'renv::restore(prompt = FALSE, transactional = TRUE)'
Rscript smoke_test.R
Rscript session_info.R
cd ../..
```

The lockfile already pins `mirt`, `psych`, `lavaan`, `TAM`. Record `session_info.R` output in the command log. If `readxl`/`openxlsx` is needed it is **not** in the lockfile — do not add dependencies casually; instead export a CSV from the workbook with the standard-library Python snippet below (output stays in the gitignored download folder):

```sh
python3 - <<'PY' > external/downloads/omib/item_data.csv
import zipfile, re, csv, sys, xml.etree.ElementTree as ET
ns = {'m': 'http://schemas.openxmlformats.org/spreadsheetml/2006/main'}
z = zipfile.ZipFile('external/downloads/omib/Item Data.xlsx')
ss = [''.join(t.text or '' for t in si.iter('{http://schemas.openxmlformats.org/spreadsheetml/2006/main}t'))
      for si in ET.fromstring(z.read('xl/sharedStrings.xml'))]
ws = ET.fromstring(z.read('xl/worksheets/sheet1.xml'))
def val(c):
    v = c.find('m:v', ns)
    return None if v is None else (ss[int(v.text)] if c.get('t') == 's' else v.text)
w = csv.writer(sys.stdout)
for r in ws.find('m:sheetData', ns):
    cells = {re.match(r'([A-Z]+)', c.get('r')).group(1): val(c) for c in r}
    w.writerow([cells.get(col) for col in 'ABCDEFGHIJKLMNO'])
PY
```

Note for whoever reads the CSV later: column `N` (`Item Solution`) is stored numerically upstream, so leading zeros are lost — zero-pad to 20 characters before comparing; column `L`/`M` contain one literal `---` row (`Set` 4, `Item` 7) with no published `a`/`b`. These are data facts to handle explicitly, never to "fix" silently.

## Stage 4 — 2PL refit plan (gated on response data)

**Gate (blocking).** The OSF node contains no respondent-level response data (see `UPSTREAM_MAP.md`), and OpenIQ must not collect human data to fill the gap. Therefore:

- **4a — only if** the authors provide respondent-level response data with permitted research use: fit the published model and compare.
- **4b — otherwise (default path):** run the two data-free verification analyses below. Label everything from 4b as *verification/simulation*, never as a refit of the paper's estimates.

### 4a — refit (conditional, requires external response data obtained under agreed terms)

Data contract: a respondents × items binary matrix of scored responses (exact-match 0/1 already computed per the instructions), plus the form assignment (1–10) per respondent. Practice items excluded; the six anchors present for every respondent.

```r
# fit_2pl.R — run under psychometrics/R renv
library(mirt)
resp <- read.csv(Sys.getenv("OMIB_RESPONSES"), check.names = FALSE)  # 0/1 matrix, untracked path
items <- read.csv("external/downloads/omib/item_data.csv")           # from Stage 3

# published parameters for comparison (drop the documented '---' row)
pub <- items[items$b != "---", c("Item", "a", "b")]
pub$a <- as.numeric(pub$a); pub$b <- as.numeric(pub$b)

fit <- mirt(resp, 1, itemtype = "2PL", method = "EM", SE = TRUE)     # deterministic ML; no MCMC here
coef_fit <- coef(fit, IRTpars = TRUE, simplify = TRUE)$items         # a (slope), b (intercept-based IRTpars)

cmp <- merge(data.frame(Item = as.integer(colnames(resp)),
                        a_fit = coef_fit[, "a"], b_fit = coef_fit[, "b"]),
             pub, by = "Item")
cmp$a_delta <- cmp$a_fit - cmp$a
cmp$b_delta <- cmp$b_fit - cmp$b
summary(abs(cmp$a_delta)); summary(abs(cmp$b_delta))
```

Predeclared acceptance tolerances (declared before looking at results): `|Δa| ≤ 0.10` and `|Δb| ≤ 0.10` for a genuine refit on the same responses; any larger deviation goes to the deviation ledger with sample size, convergence (`fit@OptimInfo$converged`), and parameterization (mirt `IRTpars` a/b vs the paper's `equateMultiple` a/b — `d = -a·b` reparameterization must be checked before declaring a mismatch). Note the upstream pipeline screened misfit per form with `mirt` infit/outfit criteria (Wilson 2005) and estimated final `a`/`b` with `equateMultiple` anchors; a plain single-group `mirt` fit is an approximation of that pipeline and must be labeled as a deviation if the anchor-equating step is not reproduced (replicate it with `equateMultiple` only if its inputs are available).

### 4b — data-free verification (default; no human data, no MCMC)

```r
# verify_published_parameters.R
library(mirt)
items <- read.csv("external/downloads/omib/item_data.csv")
ok <- items[items$b != "---", ]
a <- as.numeric(ok$a); b <- as.numeric(ok$b)

# (1) item information and test information from published parameters
info_item <- function(th, a, b) a^2 * plogis(a * (th - b)) * (1 - plogis(a * (th - b)))
th <- seq(-4, 4, 0.01)
test_info <- rowSums(sapply(seq_along(a), function(i) info_item(th, a[i], b[i])))
plot(th, test_info, type = "l", xlab = "theta", ylab = "test information")

# (2) simulation-based recovery: generate responses from published a/b under the real design
#     (10 forms x 22 items + 6 shared anchors = 28 per respondent), N = 2561 per paper §2.1,
#     then refit with mirt and check that recovered parameters track the generating values.
#     This validates the OpenIQ pipeline; it does NOT reproduce the paper's estimates.
set.seed(20261110)
```

Acceptance for 4b: parameter-recovery correlations and mean absolute deviations reported alongside the seed and session info, explicitly titled *pipeline validation by simulation*. The paper's own reported values (item mean M = .55, part–whole M = .54, per-form difficulty ANOVA, invariance fit indices) can be cited for context but cannot be recomputed without responses.

## Stage 5 — comparison with MaRs, without averaging theta

Hard rules (from `PROTOCOL.md` and `resources/SOURCES.md`):

1. **Never** average, pool, or regress OMIB and MaRs theta estimates onto a shared metric. No common-person or anchor data exist; a linking study is a prerequisite, not a follow-up.
2. Compare **ranks/construct behavior** only: e.g. Spearman correlations of within-bank standardized item difficulty `b` and discrimination `a`, distributions of rule counts vs MaRs item features, information-curve shapes (peak location, width) each on its own theta axis.
3. Any figure showing both banks must use separate axes or explicitly labeled, separately standardized axes; state in the caption that the metrics are not equated.
4. Never label any score or composite "Full Scale IQ".
5. No ICAR material enters this comparison.

```r
# compare_rank_only.R — OMIB side from Stage 4, MaRs side from Study 001 outputs
# mars <- read.csv(<Study 001 item parameter export>)   # provenance: upstream commit + command log
# omib <- items[items$b != "---", ]
# cor.test(rank(scale(as.numeric(omib$b))), rank(scale(as.numeric(mars$b))),
#          method = "spearman")   # rank association only; inputs stay bank-internal
```

Report the association with both banks' N, parameterization, and the explicit statement that theta scales are unlinked. Effect sizes on ranks are the deliverable; person-level score comparison is out of scope for Study 002.

## Deviation ledger

If any command fails or a number disagrees with `UPSTREAM_MAP.md` or the paper, record before changing anything: the full command and traceback; checksums/versions (`session_info.R`, `renv.lock` hash); the smallest patch; whether the patch touches data handling, likelihood, estimation method, or output formatting; and a numerical comparison against the unpatched path or a reason it is impossible. Do not silently "fix" statistical code, impute the `---` row, re-zero-pad solutions differently, or resolve the paper's N = 2,572 vs N = 2,561 discrepancy in our favor — document, do not decide.

## Current status

`STUDY_002_STATUS=STAGES_1_2_DONE_REFIT_NOT_EXECUTED`. Acquisition, checksum verification, and structural inspection completed 2026-11-10 (results in `UPSTREAM_MAP.md`). Stage 3+ has not been run; the 2PL refit remains gated on response data that the public OSF node does not contain; no MaRs comparison and no Study 002 numerical claim exists yet. Full MCMC is explicitly out of scope for this environment.
