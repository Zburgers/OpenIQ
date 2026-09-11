#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
VENDOR="$ROOT/external/vendor"
mkdir -p "$VENDOR"

clone_pinned() {
  local name="$1"
  local url="$2"
  local ref="$3"
  local dest="$VENDOR/$name"

  if [[ ! -d "$dest/.git" ]]; then
    echo "==> cloning $name"
    git clone --filter=blob:none "$url" "$dest"
  else
    echo "==> $name already exists; fetching"
    git -C "$dest" fetch --all --tags --prune
  fi

  git -C "$dest" checkout --detach "$ref"
  local actual
  actual="$(git -C "$dest" rev-parse HEAD)"
  if [[ "$actual" != "$ref" ]]; then
    echo "ERROR: $name expected $ref but got $actual" >&2
    exit 1
  fi
  echo "    pinned at $actual"
}

clone_pinned \
  "mars-irt" \
  "https://github.com/ndawlab/mars-irt.git" \
  "04eecdaf77d0ee657c65351eab5ed9e744b1ce14"

clone_pinned \
  "testmybrain" \
  "https://github.com/manybrainsproject/TestMyBrainCodeRepo.git" \
  "ec09ea0d35779bb39997131313dfd1380ee34922"

clone_pinned \
  "opencogdata" \
  "https://github.com/nimh-dsst/OpenCogData.git" \
  "aef5a7149eff8f1120e9ef6fd7b3c25f7bc8e63c"

cat <<'EOF'

Git sources are ready under external/vendor/ (gitignored).

Manual/review-gated sources still require provenance/license handling:
  - OMIB:         https://osf.io/4km79/
  - MaRs stimuli: https://osf.io/g96f4/
  - ICAR:         https://icar-project.com/  (follow current registration/security guidance)

Do not commit downloaded stimuli/data until resources/SOURCES.md explicitly records
that redistribution is allowed and required attribution/license files are preserved.
EOF
