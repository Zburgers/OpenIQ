#!/usr/bin/env Rscript

file_arg <- grep("^--file=", commandArgs(trailingOnly = FALSE), value = TRUE)
script_path <- if (length(file_arg)) sub("^--file=", "", file_arg[[1]]) else "smoke_test.R"
project <- normalizePath(dirname(script_path), mustWork = TRUE)
renv::load(project = project, quiet = TRUE)

packages <- c("psych", "mirt", "lavaan", "TAM", "catR")
missing <- packages[!vapply(packages, requireNamespace, logical(1), quietly = TRUE)]
if (length(missing)) {
  stop("Missing required packages: ", paste(missing, collapse = ", "))
}

RNGkind("L'Ecuyer-CMRG")
set.seed(20260911L)
probe <- sample.int(100L, 5L)
expected <- c(10L, 4L, 99L, 8L, 75L)
stopifnot(identical(probe, expected))

cat("R smoke test passed\n")
cat("R:", R.version.string, "\n")
for (pkg in c("psych", "mirt", "lavaan", "TAM", "catR")) {
  cat(pkg, as.character(packageVersion(pkg)), "\n")
}
