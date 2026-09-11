# Studies

Each study is a self-contained reproducibility unit.

Recommended layout:

```text
studies/NNN-name/
  PROTOCOL.md
  README.md
  analysis/
  config/
  RESULTS.md
  figures/
```

A study protocol should state the research question, sources/data, model, preprocessing/exclusions, expected replication targets, deviations, and what claims the result does or does not support.

## Initial sequence

1. `001-mars-replication` — reproduce MaRs-IB IRT calibration/validation and understand form assembly.
2. `002-omib-replication` — reproduce OMIB item/scoring properties as an independent open matrix source.
3. ICAR/SAPA structural replication — only after access/security conditions are settled.
4. TestMyBrain task evaluation — identify candidates for working memory, processing speed, vocabulary/crystallized ability, attention, etc.
5. Personal OpenIQ-Gf baseline — after scoring implementation and item isolation are frozen.
