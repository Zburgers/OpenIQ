.PHONY: help bootstrap-external r-smoke study-001 check-provenance

help:
	@echo "OpenIQ research tasks"
	@echo "  make bootstrap-external  Clone/pin open Git research sources locally"
	@echo "  make r-smoke             Load the R reference environment (after renv bootstrap)"
	@echo "  make study-001           Run Study 001 wrapper when implemented"
	@echo "  make check-provenance    Basic provenance-file presence checks"

bootstrap-external:
	./scripts/bootstrap_external.sh

r-smoke:
	@if [ -f psychometrics/R/smoke_test.R ]; then Rscript psychometrics/R/smoke_test.R; else echo "psychometrics/R/smoke_test.R not bootstrapped yet"; exit 2; fi

study-001:
	@if [ -x studies/001-mars-replication/run.sh ]; then studies/001-mars-replication/run.sh; else echo "Study 001 runner not implemented yet; follow PROTOCOL.md"; exit 2; fi

check-provenance:
	./scripts/check_provenance.sh
