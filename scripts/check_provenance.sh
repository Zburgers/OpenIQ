#!/usr/bin/env bash
set -euo pipefail

ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
cd "$ROOT"

required=(
  README.md
  RESEARCH_CHECKLIST.md
  ROADMAP.md
  CONTRIBUTING.md
  resources/SOURCES.md
  resources/registry.yml
  resources/MANUAL_RESOURCES.md
  resources/references.bib
  external/README.md
  external/sources.lock.yml
  external/INVENTORY.md
  docs/research/DECISIONS.md
  studies/001-mars-replication/PROTOCOL.md
  studies/002-omib-replication/PROTOCOL.md
  ethics/README.md
  docs/agents/BOOTSTRAP_AGENT_PROMPT.md
  psychometrics/R/renv.lock
  studies/001-mars-replication/UPSTREAM_MAP.md
  studies/001-mars-replication/REPRODUCTION_PLAN.md
)
for path in "${required[@]}"; do
  test -f "$path" || { echo "missing required provenance file: $path" >&2; exit 1; }
done

declare -A expected=(
  [external/vendor/mars-irt]=04eecdaf77d0ee657c65351eab5ed9e744b1ce14
  [external/vendor/testmybrain]=ec09ea0d35779bb39997131313dfd1380ee34922
  [external/vendor/opencogdata]=aef5a7149eff8f1120e9ef6fd7b3c25f7bc8e63c
)
for path in "${!expected[@]}"; do
  actual=$(git -C "$path" rev-parse HEAD)
  test "$actual" = "${expected[$path]}" || {
    echo "SHA mismatch: $path: $actual != ${expected[$path]}" >&2
    exit 1
  }
done

if git ls-files --error-unmatch external/vendor/mars-irt >/dev/null 2>&1 \
  || git ls-files 'external/vendor/**' | grep -q .; then
  echo "vendor repositories must remain untracked" >&2
  exit 1
fi
if git ls-files 'psychometrics/R/renv/library/**' | grep -q .; then
  echo "renv library must remain untracked" >&2
  exit 1
fi

echo "provenance checks passed"
