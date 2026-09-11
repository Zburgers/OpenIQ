# OpenIQ Scientific Sources

This registry tracks the resources OpenIQ intends to study, reproduce, or build upon. It is **not** a claim that every source can be redistributed inside this repository.

## Priority 0 — standards and governance

### Standards for Educational and Psychological Testing (2014)

- Organizations: AERA, APA, NCME
- Official access: https://www.testingstandards.net/open-access-files.html and https://ncme.org/resources/books/testing-standards/
- Role: validity, reliability/precision, fairness, score interpretation, scaling/norming, administration, documentation.
- OpenIQ decision: governance reference; link rather than vendor by default.

### International Test Commission / Association of Test Publishers — Technology-Based Assessment

- Official page: https://www.intestcom.org/page/16
- Role: digital delivery, scoring, validity, fairness, accessibility, security, privacy, and technology effects.
- OpenIQ decision: mandatory reference before speeded/browser-based claims.

### International Test Commission — Test Security

- Official page: https://www.intestcom.org/page/18
- Role: item exposure, protected content, administration and security practices.
- OpenIQ decision: mandatory reference for public item banks, answer keys, and repeated testing.

### Indian Council of Medical Research (ICMR) ethics and research integrity

- Guidelines index: https://www.icmr.gov.in/guidelines
- Key documents: National Ethical Guidelines for Biomedical and Health Research Involving Human Participants (2017); Handbook (2018); ICMR Policy on Research Integrity and Publication Ethics (2019); Common Forms for Ethics Committee Review.
- Role: India-relevant ethics/governance baseline. Applicability to a particular OpenIQ study must be determined with an appropriate institutional ethics body; this registry is not legal/ethics clearance.

---

## Priority 1 — fluid/matrix reasoning foundations

### MaRs-IB — original item bank

**Paper:** Chierchia et al. (2019), *The matrix reasoning item bank (MaRs-IB): novel, open-access abstract reasoning items for adolescents and adults.* Royal Society Open Science 6:190232.

- DOI: https://doi.org/10.1098/rsos.190232
- Open full text: https://pmc.ncbi.nlm.nih.gov/articles/PMC6837216/
- Original supplementary collection: https://doi.org/10.6084/m9.figshare.c.4691780
- Reported contribution: 80 open-access matrix reasoning items; original item-level data from 659 participants aged 11–33.
- Role in OpenIQ: understand item construction, developmental effects, response-time/accuracy behavior, and original validation context.

### MaRs-IB — IRT calibration and validation

**Paper:** Zorowitz et al. (2023), *An item response theory analysis of the matrix reasoning item bank (MaRs-IB).* Behavior Research Methods 56:1104–1122.

- DOI: https://doi.org/10.3758/s13428-023-02067-8
- Open full text: https://pmc.ncbi.nlm.nih.gov/articles/PMC10551052/
- Code/data: https://github.com/ndawlab/mars-irt
- Upstream repository is archived; pinned OpenIQ bootstrap commit: `04eecdaf77d0ee657c65351eab5ed9e744b1ce14`.
- Stimuli location named by upstream: https://osf.io/g96f4/
- Upstream repo license: MIT-style license in `LICENSE`; stimuli are treated as a separate resource and must be checked independently before redistribution.
- Reported design: calibration sample N=1,501 adults; independent validation N=600; published item parameters/test-form assembly materials.
- Role in OpenIQ: **primary Study 001 reproduction target** and leading candidate for v0.1 fixed-form Gf scoring.

### OMIB — Open Matrices Item Bank

**Paper:** Koch, Spinath, Greiff & Becker (2022), *Development and Validation of the Open Matrices Item Bank.* Journal of Intelligence 10(3):41.

- DOI: https://doi.org/10.3390/jintelligence10030041
- Open full text: https://pmc.ncbi.nlm.nih.gov/articles/PMC9326670/
- OSF resource: https://osf.io/4km79/
- Reported contribution: 220 figural matrix items tested on N=2,572 medical-school applicants, with item properties including 2PL parameters, construction rules, vector graphics, templates, and example computer-based administration materials.
- Paper states the item bank is available under GPLv3.
- Role in OpenIQ: **Study 002 independent replication/comparison source**. Do not average OMIB and MaRs theta values until a linking/equating design places them on a common scale.

---

## Priority 1 — broader cognitive assessment

### ICAR — International Cognitive Ability Resource

- Project: https://icar-project.com/
- Current guidance PDF: https://icar-project.com/attachments/download/138/Guidelines.pdf
- Open-data paper: Condon & Revelle, *Selected ICAR Data from the SAPA-Project: Development and Initial Validation of a Public-Domain Measure.* Journal of Open Psychology Data. DOI: https://doi.org/10.5334/jopd.25
- Data-paper page: https://openpsychologydata.metajnl.com/articles/10.5334/jopd.25 (legacy mirror may redirect)
- Constructs in ICAR-16/60 include matrix reasoning, letter/number series, verbal reasoning, and 3D rotation; later ICAR resources include additional item types.
- Security rule: follow current ICAR registration/guidance. Do **not** commit protected/restricted ICAR items, solutions, or psychometric material merely because the project is described as public-domain/open science.
- Role in OpenIQ: theory/benchmarking, multidomain structural research, external validation candidate when permitted, and study of open cognitive-measure development.

### TestMyBrain / Many Brains Project

**Toolkit paper:** Singh et al. (2021), *The TestMyBrain Digital Neuropsychology Toolkit: Development and Psychometric Characteristics.* Journal of Clinical and Experimental Neuropsychology.

- DOI: https://doi.org/10.1080/13803395.2021.2002269
- Open full text: https://pmc.ncbi.nlm.nih.gov/articles/PMC8922997/
- Test catalogue/norm information: https://www.testmybrain.org/dashboard/tmb-tests.html
- Open-source code: https://github.com/manybrainsproject/TestMyBrainCodeRepo
- Bootstrap pin: `ec09ea0d35779bb39997131313dfd1380ee34922` (2026-05-22).
- Upstream licensing: test code/library LGPLv3; stimuli generally CC-BY-SA 4.0 unless a task overview states otherwise. Preserve task-specific attribution/license metadata.
- Reported toolkit evidence includes split-half reliabilities roughly .68–.99 across included tasks, with factors involving processing speed, working memory, and broader cognitive ability; normative sample sizes vary by task and some current tasks report >100,000 observations.
- Candidate OpenIQ roles: working memory, processing speed, attention, vocabulary/crystallized ability, matrix reasoning, and digital-testing methodology. Do not assume all tasks have identical validation depth or normative populations.

### OpenCogData (NIMH DSST)

- Catalogue: https://nimh-dsst.github.io/OpenCogData/
- About/scope: https://nimh-dsst.github.io/OpenCogData/about/
- Source: https://github.com/nimh-dsst/OpenCogData
- Bootstrap pin: `aef5a7149eff8f1120e9ef6fd7b3c25f7bc8e63c`.
- Catalogue license: MIT for the OpenCogData project; each indexed dataset retains its own terms.
- Inclusion focus: publicly available human cognitive-task datasets with trial/item-level data.
- Role in OpenIQ: dataset discovery, effect-size/power planning, model prototyping, replication candidates. OpenCogData indexing does not confer redistribution rights over indexed datasets.

---

## Priority 2 — psychometric tooling

### `mirt`

- Chalmers (2012), *mirt: A Multidimensional Item Response Theory Package for the R Environment.* Journal of Statistical Software 48(6).
- DOI: https://doi.org/10.18637/jss.v048.i06
- Docs: https://philchalmers.github.io/mirt/
- Role: unidimensional/multidimensional IRT, bifactor/two-tier models, multiple-group models, DIF and related analyses.

### `psych`

- CRAN: https://CRAN.R-project.org/package=psych
- Role: reliability, factor analysis, correlation/psychometric utilities.

### `lavaan`

- Site: https://lavaan.ugent.be/
- Role: CFA/SEM, measurement invariance workflows.

### `TAM`

- CRAN: https://CRAN.R-project.org/package=TAM
- Role: IRT/Rasch-family and multidimensional models; use where study design warrants.

### `catR`

- CRAN: https://CRAN.R-project.org/package=catR
- Magis & Barrada (2017), Journal of Statistical Software companion article.
- Role: CAT simulation, ability estimation, item selection, stopping rules, exposure/content control.

### `mirtCAT`

- CRAN: https://CRAN.R-project.org/package=mirtCAT
- Role: CAT simulation/administration based on `mirt` objects; **not a v0.1 dependency**.

---

## Resource acceptance checklist

Before a resource moves from this registry into tracked OpenIQ content:

- [ ] canonical upstream identified
- [ ] exact version/commit/release recorded
- [ ] citation recorded
- [ ] license/access conditions recorded
- [ ] redistribution permission clear
- [ ] test-security implications reviewed
- [ ] checksum recorded for downloaded archive/data when practical
- [ ] purpose in OpenIQ documented
- [ ] no participant/private data accidentally included
