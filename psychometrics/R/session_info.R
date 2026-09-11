#!/usr/bin/env Rscript

file_arg <- grep("^--file=", commandArgs(trailingOnly = FALSE), value = TRUE)
script_path <- if (length(file_arg)) sub("^--file=", "", file_arg[[1]]) else "session_info.R"
project <- normalizePath(dirname(script_path), mustWork = TRUE)
if (requireNamespace("renv", quietly = TRUE)) {
  renv::load(project = project, quiet = TRUE)
}

cat("R:", R.version.string, "\n")
cat("Platform:", R.version$platform, "\n")
cat("Project:", project, "\n\n")

packages <- c("renv", "psych", "mirt", "lavaan", "TAM", "catR")
for (pkg in packages) {
  if (requireNamespace(pkg, quietly = TRUE)) {
    cat(pkg, as.character(packageVersion(pkg)), "\n")
  } else {
    cat(pkg, "NOT INSTALLED\n")
  }
}

cat("\n")
print(utils::sessionInfo())
