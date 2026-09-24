# Set your GitHub PAT to avoid rate limits during package installation
Sys.setenv(GITHUB_PAT = "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")

# Activate the renv project (or confirm it's already active)
if (is.null(renv::project())) {
  message("This isn't an active renv project.")
  renv::activate()
} else {
  message("We're in an active renv project.")
}

# Install all locked dependencies
message("Restoring/synchronizing the project library.")
renv::restore()

# Install the module itself into the renv library
message("Installing the package.")
renv::install(".")

# Print the library path — you'll need this for JASP developer mode
message("R libPath for developer mode:\n", .libPaths()[1])