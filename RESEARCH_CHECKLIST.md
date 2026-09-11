# OpenIQ Master Research Checklist

Use this as the operational control surface. Detailed notes belong in their domain folders, not in the root README.

## 0. Governance and claims

- [x] Define v0.1 as fluid/matrix reasoning, not Full Scale IQ.
- [x] Separate OpenIQ licensing from third-party licensing.
- [x] Establish reproduce-before-invent principle.
- [ ] Create `CITATION.cff` after finalizing preferred author/contributor metadata.
- [ ] Decide release/versioning policy for research artifacts and test forms.
- [ ] Define a claims register: each public claim -> supporting study/version/evidence.

## 1. Acquire and inventory sources

- [x] Register MaRs-IB original paper and IRT validation repository.
- [x] Register OMIB paper and OSF resource.
- [x] Register ICAR guidance and SAPA/ICAR open-data publication.
- [x] Register TestMyBrain toolkit/code/norm information.
- [x] Register OpenCogData.
- [x] Register AERA/APA/NCME testing standards.
- [x] Register ITC technology-based assessment and test-security guidance.
- [x] Register ICMR ethics/research-integrity guidance for India.
- [ ] Fetch approved external repositories to `external/vendor/` locally using `external/sources.lock.yml`.
- [ ] Download non-Git resources only after recording license/access terms and checksum.
- [ ] Never commit ICAR protected items/answer keys or any resource whose redistribution terms are unclear.

## 2. Research environment

- [ ] Install R (current stable) and RStudio/VS Code tooling.
- [ ] Initialize `renv` under `psychometrics/R/`.
- [ ] Add core packages: `psych`, `mirt`, `lavaan`, `TAM`, `catR`; add others only when a study requires them.
- [ ] Freeze package versions in `renv.lock`.
- [ ] Add Python/TypeScript only for production scoring/app code; R remains the reference psychometrics implementation initially.
- [ ] Add deterministic seeds and session-info capture to every analysis.

## 3. Study 001 — MaRs replication

- [ ] Read Chierchia et al. (2019) and Zorowitz et al. (2023) end-to-end.
- [ ] Map upstream repository branches/data/code.
- [ ] Re-run published model comparison/calibration pipeline.
- [ ] Reproduce item parameter tables within documented numerical tolerance.
- [ ] Reproduce test-information/short-form assembly outputs.
- [ ] Reproduce validation results where public data support it.
- [ ] Record deviations in `studies/001-mars-replication/RESULTS.md`.
- [ ] Peer-check our interpretation before using parameters in an app.

## 4. Study 002 — OMIB replication

- [ ] Acquire OSF materials under their stated GPLv3/open conditions.
- [ ] Reproduce 2PL scoring/item characteristics from source data where available.
- [ ] Understand OMIB's response format and scoring semantics before integrating.
- [ ] Do not put MaRs and OMIB theta estimates on one scale without linking/equating evidence.

## 5. Personal baseline protocol

- [ ] Build with sandbox/practice items only.
- [ ] Freeze the scored personal form and scoring code before the developer/test-taker sees its items.
- [ ] Define testing environment (quiet room, no calculator/search/AI/help, uninterrupted session).
- [ ] Record device/browser/input method and interruptions.
- [ ] Take baseline once before inspecting solutions/items.
- [ ] Preserve the result with test version, model version, and uncertainty.
- [ ] Use a separate form/source for later confirmation to reduce practice contamination.

## 6. v0.1 application

- [ ] Practice/instruction flow.
- [ ] Versioned form manifest.
- [ ] Item renderer.
- [ ] Session/event logging.
- [ ] Correctness scoring isolated from display code.
- [ ] Reference IRT scoring verified against R implementation.
- [ ] Uncertainty calculation and tests.
- [ ] Research report UI that exposes provenance and limitations.
- [ ] No arbitrary `correct - time_penalty` formula.

## 7. Online/hardware validity

- [ ] Log browser/OS/device class/viewport/input method.
- [ ] For speeded tests, investigate display/input latency and device effects before interpreting milliseconds as person ability.
- [ ] Define supported-device policy per task.
- [ ] Track focus loss/visibility changes as quality metadata, not automatic evidence of cheating.
- [ ] Separate untimed reasoning claims from processing-speed claims.

## 8. Ethics before publication-directed data collection

- [ ] Identify an eligible institutional Ethics Committee/IRB/IEC or obtain formal guidance on whether review/exemption is required.
- [ ] Draft protocol, participant information sheet, consent, withdrawal procedure, recruitment plan, data-retention policy, and risk assessment.
- [ ] Define age eligibility; do not recruit minors casually.
- [ ] Define compensation policy, if any.
- [ ] Pre-register primary hypotheses/analysis where appropriate.
- [ ] Establish pseudonymization and access controls.
- [ ] Do not publish raw identifiable participant data.

## 9. Calibration and validation study

- [ ] Power/sample-size plan based on the intended IRT/factor/DIF analyses rather than a generic target.
- [ ] Calibration sample separated from validation/holdout sample.
- [ ] Reliability: appropriate omega/test-retest/split-half/IRT information as justified.
- [ ] Validity evidence: content, response process, internal structure, relations to external variables, consequences/limitations.
- [ ] Factor-model comparison with predeclared decision criteria.
- [ ] DIF/invariance analyses for justified groups.
- [ ] Missingness/exclusion rules frozen before final analysis.

## 10. Norming

- [ ] Define target population explicitly.
- [ ] Determine whether sample is representative enough for population norms.
- [ ] If using convenience data, label reference sample honestly rather than calling it national norms.
- [ ] Consider stratification/weighting and age modeling.
- [ ] Publish normative sample composition and uncertainty.

## 11. Publication readiness

- [ ] Reproducible analysis from raw/approved data to paper tables/figures.
- [ ] Locked package/environment versions.
- [ ] Archived release + DOI where possible.
- [ ] Technical manual with validity/reliability/norming/limitations.
- [ ] External psychometrics/psychology review before strong public claims.
- [ ] Research-integrity and authorship decisions documented before submission.
