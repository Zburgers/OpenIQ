# Manual resource provenance

Checked 2026-09-11. The bootstrap queried OSF/PsychArchives metadata but did not download an OMIB, MaRs stimulus, or ICAR item/data payload. Therefore no local payload checksum is claimed. Checksums below are provider-advertised SHA-256 values and are not local verification results.

## OMIB

- Canonical project: https://osf.io/4km79/
- OSF API metadata: https://api.osf.io/v2/nodes/4km79/
- Node title: `Open Matrices Item Bank`; public node; OSF node-level license field was null when queried.
- License evidence: Koch et al. (2022) states GPLv3 for the item bank, but the current OSF file metadata does not attach an individual license to these files. Treat redistribution as unresolved until file-level terms are confirmed.
- OpenIQ disposition: local/untracked under `external/downloads/omib` if acquired; do not move any file into tracked OpenIQ content yet.

| File | Canonical file URL | Size | Provider SHA-256 | Bootstrap downloaded | Disposition |
|---|---|---:|---|---|---|
| `Web Version.zip` | https://osf.io/download/dxw34/ | 27,171 bytes | `c9e2fd0dd01977f95592e781abe2f1fb4ced9171869eb0e58cc50d8fe1ae53a2` | no | local only pending file-level terms |
| `Instructions for Implementation.docx` | https://osf.io/download/dvsbz/ | 17,354 bytes | `6c8fdac507f09bb21c4f039a975a5d68d8e046c72b8c0a92cd9e94e45a70d6ed` | no | local only pending file-level terms |
| `Item Template.docx` | https://osf.io/download/gx7qt/ | 190,634 bytes | `aa5a006030b79d40a09298e57ca9a0385bcc58c7591a7db3143258bd376fa28f` | no | local only pending file-level terms |
| `Item Data.xlsx` | https://osf.io/download/fqtzp/ | 38,920 bytes | `ace35c7212c22a88c61d25b51e37b9fe25eeafd4fb6e910048d2cef5e2687bfd` | no | local only pending file-level terms |
| `Figural Matrices.zip` | https://osf.io/download/f7t6b/ | 201,846 bytes | `a84257998c1af479cb3097d35f9c6e2fb14abce6f022c3d2eb4b2b56a91589b3` | no | item/stimulus payload; local only pending terms |
| `Construction Elements.zip` | https://osf.io/download/k2d9x/ | 20,304 bytes | `10ace73c7fa1ba968c3699c9d3879c4e22f18b51db5ecea39449455e8990373d` | no | stimulus construction payload; local only pending terms |

## MaRs stimuli

- Canonical project: https://osf.io/g96f4/
- OSF API metadata: https://api.osf.io/v2/nodes/g96f4/
- Node title: `The Matrix Reasoning Item Bank`; description: `Stimuli`; public node.
- OSF node license metadata says `Other` and instructs users to see `license.txt` in OSF Storage. As of this check, the OSF API storage root returned no file records, so individual filenames, file URLs, and provider checksums could not be recovered from the live API.
- Paper terms: Chierchia et al. (2019) describes the materials as freely available for non-commercial use and asks users to cite the paper. This does not resolve the missing current file-level `license.txt` or authorize redistribution inside OpenIQ.
- OpenIQ disposition: no MaRs stimulus payload was downloaded; if later acquired, keep it under `external/downloads/mars-stimuli`, record each file's canonical URL and locally computed SHA-256, and keep it untracked until rights are clear.

## ICAR access and security boundary

- Legacy project URL: https://icar-project.com/ (the prior site now redirects its information to the TU Dortmund page).
- Current project page: https://sms.statistik.tu-dortmund.de/en/research/projects/completed-research-projects/international-cognitive-ability-resource-icar/
- Current archive record: https://doi.org/10.23668/psycharchives.22167
- The current archive exposes two files at different terms: `ZPID_Einreichung.zip` is Sharing Level 1 (Scientific Use), Scientific Use License v1 (`https://doi.org/10.23668/psycharchives.4988`) and is described as containing tests and automatic item generators; `readme.txt` is Sharing Level 0, CC-BY 4.0. The archive explicitly gives preservation of item integrity, including scoring keys, as the reason for the restricted level.
- Exact access path: open the PsychArchives record, select the file-level `ZPID_Einreichung.zip` download, accept the Scientific Use License v1, and provide the intended-use information requested by PsychArchives. Do not download or expose the protected archive as part of this bootstrap.
- The legacy ICAR home page says the Sample Test requires prior registration by emailing the project contact. The current maintained project page lists `doebler@statistik.tu-dortmund.de` as repository maintainer. If OpenIQ needs ICAR material, the repository owner must email that maintainer with OpenIQ's institutional/academic affiliation and intended scientific use, complete any requested registration or license acceptance, and confirm the permitted local-use/redistribution boundary. That user-action-gated subtask stops here.
- The previously registered guidance URL `https://icar-project.com/attachments/download/138/Guidelines.pdf` and the indexed `/137/Guidelines.pdf` returned 404 on 2026-09-11. The current archive sharing-level and file-level terms are the live access guidance used here; this URL drift is unresolved and must not be guessed away.
- Never scrape, log, screenshot, commit, or summarize protected ICAR questions, answers, scoring keys, or psychometric material. No ICAR protected material was accessed or downloaded.

## Unresolved questions

1. Confirm the individual OMIB file licenses/attribution notices; node-level OSF metadata is insufficient.
2. Recover and verify the current MaRs OSF file listing and `license.txt`; the live API currently exposes an empty storage root.
3. Obtain owner approval/registration for ICAR before any controlled download or use.
