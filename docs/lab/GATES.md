# Gate Tracker — Single Source of Truth

Updated by CEO only. `PLANNED` ≠ done. No gate is passed by a README claim.

| Gate | Target | Status | Evidence |
|---|---|---|---|
| G0-1 Provenance | Pinned clones + OSF checksums + bib | ✅ PASS | `external/INVENTORY.md`, `resources/MANUAL_RESOURCES.md`, `resources/references.bib`, `make check-provenance` |
| G0-2 R ref env | renv lock + smoke | ✅ PASS | R 4.6.1, renv 1.2.4, `make r-smoke` |
| G0-3 Study 001 map+plan | Upstream map + executable plan | ✅ PASS (map/plan) | `studies/001-mars-replication/UPSTREAM_MAP.md`, `REPRODUCTION_PLAN.md` |
| G0-4 Study 001 numeric reproduction | Collate/design/fit/compare | 🔄 IN PROGRESS | `make study-001` still `PLANNED_NOT_EXECUTED`; pilot subagents running. Target: `RESULTS.md` with deltas |
| G0-5 Study 002 map+plan | OMIB upstream + plan | 🔄 IN PROGRESS | `studies/002-omib-replication/PROTOCOL.md` only; OMIB payloads local in `external/downloads/omib/` |
| G1 Sandbox Gf v0.1 | Fixed-form EAP demo (IDs/params only) | ⬜ NOT STARTED | Requires G0-4 params; must report theta+SE+reference, not FSIQ |
| G2 Blinded baseline | Frozen form + blinded administration record | 🔒 SEALED | Form must not be previewed. No artifacts yet by design |
| G3–G6 | Multidomain → GCA → norms → publication | ⬜ NOT STARTED | Blocked on ethics path + powered sampling; no shortcuts |

**Current lab sprint (as of 2026-11-10):** G0-4/G0-5 pilots + R cross-check. Prior background subagents (Python pilot, OMIB map, R cross-check) are the first lab wave; persona subagents below continue from their artifacts.
