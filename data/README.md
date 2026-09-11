# Data Policy

OpenIQ separates **open source research datasets**, **derived public artifacts**, and **participant/private data**.

## Local layout

```text
data/
  raw/              # immutable acquired data; gitignored
  private/          # participant/private data; gitignored
  processed/        # reproducible non-sensitive intermediates where appropriate
  public/           # explicitly approved, redistributable research artifacts
  dictionaries/     # schemas/codebooks
```

## Rules

- Never commit direct identifiers, contact information, consent records, IP-derived identifiers, or raw participant exports.
- Prefer stable source URLs + checksums + acquisition scripts over committing third-party datasets.
- Keep raw data immutable. All cleaning/transforms should be scripted into derived datasets.
- Record data exclusions with machine-readable reason codes; do not manually delete inconvenient observations.
- A dataset's availability on the internet does not imply permission to redistribute it.
- Human-subject data collected for publication requires the applicable ethics/consent/governance process first.
