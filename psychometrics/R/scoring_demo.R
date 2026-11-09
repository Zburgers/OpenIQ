#!/usr/bin/env Rscript

# scoring_demo.R — sandbox-only stub (Devon Kai, 2026-11-10)
# Synthetic 5-item / 20-subject data only. No upstream parameters, no real
# items, no personal-form content. Prints EAP theta + SE via mirt.
# Not a product path; see ../SCORING_SPEC.md for the spec this previews.

file_arg <- grep("^--file=", commandArgs(trailingOnly = FALSE), value = TRUE)
script_path <- if (length(file_arg)) sub("^--file=", "", file_arg[[1]]) else "scoring_demo.R"
project <- normalizePath(dirname(script_path), mustWork = TRUE)
renv::load(project = project, quiet = TRUE)

suppressPackageStartupMessages(library(mirt))

RNGkind("L'Ecuyer-CMRG")
set.seed(20260911L)

n_subj <- 20L
n_items <- 5L

# Synthetic sandbox item parameters (generated here once; not upstream data)
a <- round(runif(n_items, 0.8, 1.8), 3)
b <- round(runif(n_items, -1.5, 1.5), 3)
c <- round(runif(n_items, 0.10, 0.25), 3)
theta_true <- round(rnorm(n_subj), 3)

# 3PL response matrix: rows = subjects, cols = items
p <- sapply(seq_len(n_items), function(j)
  c[j] + (1 - c[j]) / (1 + exp(-a[j] * (theta_true - b[j]))))
X <- matrix(rbinom(n_subj * n_items, 1L, p), nrow = n_subj)
colnames(X) <- sprintf("SBX-I%02d", seq_len(n_items))

mod <- mirt(X, 1, itemtype = "3PL", verbose = FALSE)
fs <- fscores(mod, method = "EAP", SE = TRUE)

out <- data.frame(
  subject = sprintf("SBX-S%02d", seq_len(n_subj)),
  theta_true = theta_true,
  theta_eap = round(fs[, "F1"], 3),
  se = round(fs[, "SE_F1"], 3)
)
print(out, row.names = FALSE)

cat("\nseed: 20260911L (L'Ecuyer-CMRG) | mirt", as.character(packageVersion("mirt")), "\n")
cat("sandbox synthetic only — theta/SE demo, not a score\n")
