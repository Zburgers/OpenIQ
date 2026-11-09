# Study 001 reproduction plan

This is the executable, immutable-source plan for reproducing the MaRs-IB IRT paper. It is intentionally separate from the personal baseline administration path.

## Commands

Run from the OpenIQ root in a disposable worktree or copy of the ignored upstream clone. Preserve the command log and environment manifest outside tracked OpenIQ source until provenance review.

```sh
make bootstrap-external
make check-provenance
git -C external/vendor/mars-irt fetch --all --tags --prune
git -C external/vendor/mars-irt rev-parse HEAD

python3 -m venv /tmp/openiq-study-001-venv
. /tmp/openiq-study-001-venv/bin/activate
python -m pip install --upgrade pip
python -m pip install -r external/vendor/mars-irt/requirements.txt
python -m pip install jupyter nbconvert
python -m cmdstanpy.install_cmdstan

cd external/vendor/mars-irt/03_Calibration
python scripts/collate_data.py
python scripts/make_design.py
for model in 1pl_m1 1pl_m2 1pl_m3 1plg_m1 1plg_m2 1plg_m3 3pl_m1 3pl_m2 3pl_m3; do
  python scripts/fit_irt.py "$model"
done
python scripts/fit_irt_ppc.py 3pl_m2
python scripts/fit_irt_x2.py 3pl_m2
python scripts/fit_irt_sgddm.py 3pl_m2

cd ../04_Validation
MARS_ROOT=$(cd .. && pwd)
python scripts/collate_sf_data.py
python scripts/collate_lf_data.py
python scripts/fit_mars_3pl.py
python scripts/fit_mars_x2.py
python scripts/fit_rpm_3pl.py
python scripts/fit_rpm_x2.py

# The two Mars validation scripts select longform in source. Run the same
# scripts against a disposable copy with only that dataset selector changed.
cp -a . /tmp/openiq-study-001-validation-shortform
sed -i "s/dataset = 'longform'/dataset = 'shortform'/" \
  /tmp/openiq-study-001-validation-shortform/scripts/fit_mars_3pl.py \
  /tmp/openiq-study-001-validation-shortform/scripts/fit_mars_x2.py
cd /tmp/openiq-study-001-validation-shortform
python scripts/fit_mars_3pl.py
python scripts/fit_mars_x2.py

cd "$MARS_ROOT"
```

Execute notebooks only after the script outputs exist, into a disposable output copy rather than in place:

```sh
mkdir -p /tmp/openiq-study-001-notebooks
for nb in 03_Calibration/*.ipynb; do
  name=$(basename "$nb")
  python -m jupyter nbconvert --to notebook --execute "$nb" \
    --output-dir /tmp/openiq-study-001-notebooks \
    --output "calibration-$name" \
    --ExecutePreprocessor.timeout=-1
done
for nb in 04_Validation/*.ipynb; do
  name=$(basename "$nb")
  python -m jupyter nbconvert --to notebook --execute "$nb" \
    --output-dir /tmp/openiq-study-001-notebooks \
    --output "validation-$name" \
    --ExecutePreprocessor.timeout=-1
done
```

Finally compare posterior summaries, item-parameter outputs, information/reliability results, figures, and manuscript tables against the paper and the upstream generated artifacts. Write a redacted comparison report containing hashes, dimensions, convergence diagnostics, and deviations; do not include item content or the personal baseline form.

## Compatibility and deviation ledger

If an upstream command fails, record before changing anything:

1. the full command and original traceback;
2. the pinned upstream commit and Python/R/package/CmdStan versions;
3. the smallest compatibility patch, kept outside the immutable clone where possible;
4. whether the patch changes data preprocessing, likelihood, priors, sampler settings, seed, or output formatting;
5. a numerical comparison against the unpatched path or a reason that comparison is impossible.

Do not silently fix statistical code. In particular, preserve the observed posterior-predictive gamma conditional behavior until it is separately reviewed. A compatibility-only patch should be accepted only when it leaves the statistical procedure and numerical inputs unchanged; otherwise it is a new analysis and must be labeled as such.

## Current status

This plan is executable but has not been run to completion in this bootstrap. The required Python/CmdStan environment and the long-running upstream fits remain a handoff. `make study-001` therefore exits nonzero with `STUDY_001_STATUS=PLANNED_NOT_EXECUTED` rather than claiming a reproduction.
