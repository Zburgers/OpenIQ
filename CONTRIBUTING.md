# Contributing to OpenIQ

OpenIQ is a research instrument before it is a software product. Contributions can change what is measured, so ordinary application-development assumptions are not sufficient.

## Core rules

- Do not add copyrighted/restricted test items, leaked professional test material, or answer keys.
- Do not change a scored item's wording, visual geometry, distractors, timing, or response format in place. Create a new item version.
- Do not modify scoring/norm transforms without a study reference, rationale, and tests against the reference implementation.
- Do not describe a fluid-reasoning result as Full Scale IQ.
- Do not add arbitrary time bonuses/penalties to ability scores.
- Do not commit participant-level raw/private data.
- Every imported resource needs provenance, upstream URL, version/commit/checksum when possible, citation, and license/access status.

## Research changes

A research-affecting pull request should state:

1. construct affected;
2. hypothesis/rationale;
3. source/paper/protocol;
4. data used;
5. analysis/scoring change;
6. expected impact on score interpretation;
7. backwards compatibility/version bump;
8. licensing/test-security implications.

## Reproducibility

Reference psychometric analyses should run from scripts/notebooks committed under `studies/` or `psychometrics/`. Record random seeds, package versions, source-data checksums, and upstream commit hashes.

## Security

Test security is measurement integrity. Never expose restricted item content or solution keys in logs, screenshots, public fixtures, CI output, issue bodies, or documentation.
