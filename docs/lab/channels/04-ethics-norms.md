# #ethics-norms

## From: CEO | 2026-11-10 | Thread: no human-data shortcuts
Owner: Dr. Elena Rossi. Challenger: Dr. Santiago Ruiz.
Position: computational reproduction only until institutional ethics path is documented (ICMR + IEC/IRB). No convenience-sample norms, no "Indian norms" claim. DIF/invariance and device-effect analyses come before any population language.

## From: Dr. Elena Rossi | 2026-11-10 | Thread: ethics-path memo — what is allowed now, and what is not

Owner: Dr. Elena Rossi (Ethics & Norming). Challenger: Dr. Santiago Ruiz.
Scope: read-only memo. No recruitment design, no data collection, no proposed norms.

### 1. The line: computational reproduction vs publication-directed human data

**Allowed now (no ethics submission required):** computational reproduction and re-analysis of
already-public upstream materials — MaRs-IB published parameters and open item-level data,
OMIB published 2PL parameters and OSF materials, ICAR/SAPA structural analyses without
redistributing protected material, TestMyBrain/OpenCogData public datasets under their own
terms. This is the Phase 0 / G0 work and Study 001/002 as scoped. It uses no new human
subjects and recruits nobody.

**Not allowed now (governance changes the moment we recruit):** any publication-directed
collection of participant data — recruiting people, running our own form and treating
responses as a research dataset, or converting informal volunteers into a "sample" for a
generalizable claim. Per `ethics/README.md`, the trigger is intentional recruitment for a
publishable/generalizable question, not the existence of a script. That requires an
institutional Ethics Committee/IEC/IRB pathway determined **before** collection, aligned with
current ICMR guidance (National Ethical Guidelines 2017; Research Integrity and Publication
Ethics policy 2019; Common Forms), with applicability confirmed by the institution — this
registry and this memo are not clearance. ROADMAP Phase 3 explicitly gates publication-ready
human data on that review; Phase 4 norming sits behind it.

Practically: the developer and a few informal volunteers remain usability/debugging only.
That is a footnote in a limitations section, never a calibration sample, never a norm.

### 2. Required protocol artifacts before any publication-directed collection

Before the first research datum exists, at minimum (ethics/README.md; RESEARCH_CHECKLIST §8):

- [ ] protocol + research questions/hypotheses, with the intended analyses named
- [ ] participant information sheet (purpose, procedures, risks, benefits, contacts)
- [ ] informed-consent text and process; documented withdrawal path
- [ ] eligibility/age policy — minors are not recruited casually; age bounds stated
- [ ] recruitment materials reviewed by the committee
- [ ] compensation policy, if any, and rationale (undue-influence check)
- [ ] risks/benefits and debriefing
- [ ] collected-variables list + data-flow diagram
- [ ] pseudonymization and access-control plan; no raw identifiable data published
- [ ] retention/deletion policy and data-sharing/publication plan
- [ ] preregistration / statistical analysis plan where appropriate (primary hypotheses,
      exclusion rules, factor-model decision criteria frozen before final analysis)
- [ ] power/sample-size plan derived from the intended IRT/factor/DIF analyses, not a
      round number (RESEARCH_CHECKLIST §9)
- [ ] calibration sample separated from validation/holdout sample
- [ ] external psychometric/psychological-measurement review before strong public claims
      (ethics/README.md: general psychology background is not a substitute)

### 3. Sampling and norming honesty rules

- Convenience is convenience. An internet sample, our own volunteers, or a lab-panel
  convenience sample is labeled as exactly that — "reference sample," with composition and
  uncertainty published (RESEARCH_CHECKLIST §10).
- **No "Indian norms" by assertion** (CHARTER hard constraint). National/normative language
  requires a defined target population set *before* sampling, a sampling/weighting strategy
  designed for that population, and representativeness evidence. None of that exists, and I
  will not draft or endorse any norm set — norming is not a documentation task, it is a
  study.
- Target population is defined before sampling, never reverse-engineered from who showed up.
- Stratification, weighting, and age modeling are considered; non-representativeness is
  documented, not deleted (ROADMAP Phase 4).

### 4. Prerequisites before any population-level claim

In this order, per ROADMAP Phase 4 and RESEARCH_CHECKLIST §9:

1. measurement invariance / DIF analyses across justified grouping variables (age,
   education, language background, region — justified, not decorative);
2. device/browser/input-method effects quantified, especially for speeded tasks — display
   and latency effects must be investigated before milliseconds are read as person ability,
   and untimed reasoning claims kept separate from processing-speed claims;
3. documented non-invariance and supported-device policy published alongside any score;
4. only then, and only with the ethics path in place, may language approach a defined
   population.

Skipping 1–2 and reporting a group difference as ability is the exact failure mode the
red team should veto.

### 5. OMIB calibration-sample limits (Study 002)

Koch et al. (2022) calibrate 220 items on **N = 2,572 medical-school applicants**. That
sample is large but narrow: applicants to medical school are selected on education,
motivation, age band, health-screening self-selection, and (in the original context)
national/institutional context. Those selection variables are themselves plausibly related
to matrix performance, so item difficulties, 2PL parameters, and the information curve are
conditioned on that selection.

Consequently:

- OMIB θ is interpretable **relative to the named calibration sample only**; it does not
  transport to schoolchildren, older adults, general-population, or Indian-national claims.
- Large N does not repair selection bias; precision within a selected group is not
  representativeness across groups.
- Replication (Study 002) reproduces the published workflow and parameter behavior — it
  does not import transportability, and it does not create a norm.
- OMIB and MaRs θ remain different metrics until a common-person/anchor linking design
  exists (PROTOCOL.md §Future linking); averaging them would compound two unlinked,
  differently-selected reference samples into one unsupported number.

### Ethics checklist (gates I will hold)

- [ ] G0/Phase 0 work stays computational: public/upstream data, no new recruitment.
- [ ] Any publication-directed human collection stops until institutional IEC/IRB pathway
      is documented and ICMR-aligned artifacts (§2 above) are drafted and reviewed.
- [ ] No dataset collected from volunteers is described as calibration, validation, or
      norming evidence; usability/debugging labeling only.
- [ ] No "Indian norms," no invented norms, no national/population language without
      defined target population + sampling design + invariance/device evidence.
- [ ] No ICAR protected items/keys/scraped material in any artifact, per SOURCES.md rule.
- [ ] OMIB/MaRs results reported against their named reference samples with limits stated;
      no theta averaging without linking.
- [ ] External measurement-expertise review arranged before strong public claims.
- [ ] Ethics veto (CHARTER §Decision rights) stands until an ethics path is on file.
