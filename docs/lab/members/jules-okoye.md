# Jules Okoye — Item Bank & Test Security (persistent notes)

- 2026-11-10 CEO note: Owns inventories + versioning + blinding. OMIB local files verified untracked; file-level license still unresolved. First task: publish OMIB inventory summary (structure only, no item content) in #study-002.

## 2026-11-10 — Blinding audit + OMIB inventory + manifest schema posted to #study-002

- **Audit PASS:** 69 tracked files, zero media/payload extensions, zero `item_id` content dumps (only policy prose in CHARTER/DECISIONS/001-PROTOCOL). `external/vendor`, `external/downloads`, `external/restricted`, `renv/library` all untracked (git ls-files = 0 rows) and `.gitignore`-covered; `check_provenance.sh` run → `provenance checks passed`.
- **Containment:** OMIB payloads exist only in `external/downloads/omib/` (repo-wide find, `.git` excluded). Six files; local SHA-256 == provider SHA-256 for all six. `Item Data.xlsx` not opened — no rows read.
- **License:** still unresolved at file level (OSF node null, paper says GPLv3). All six files: local-only, untracked, no redistribution assumed. No new downloads.
- **Versioning gap found:** hard rules exist (CHARTER:25 no in-place item edits; app/README immutable manifest, no silent geometry/text changes; 001/002 PROTOCOL blinding) but no manifest artifact exists. Proposed two-part schema: tracked content-free manifest (`form_id`, semver `form_version`, `item_id`+`item_version` hashes, `parameters.source_commit`, `scoring_code_version`, `frozen_at.manifest_sha256`/`frozen_commit`, `blinding_ref` pointer) with the actual blinding record kept separate and untracked.
- Guardrails held: no ICAR material, no WAIS/Raven, no personal-form preview, no θ averaging, no item rows or stimuli printed. Next watch: keep `studies/002/UPSTREAM_MAP.md` (Thorne's, untracked) out of my lane; re-run audit after any payload move.
