# ---
#
# _INIT.R
# 
# ---

# ---
#
# run the functionsForInit.R script
#
# ---

source("functionsForInit.R")

# There is a binary version available but the source version is later:
#   binary source needs_compilation
# pROC 1.18.4 1.18.5              TRUE

installFromCran("pROC", "1.18.5")

# ---
#
# install the libraries
#
# ---

# Install correct versions of HADES packages

installFromGithub("ohdsi/CohortDiagnostics", ref = "v3.2.3")
installFromGithub("ohdsi/Characterization", ref = "v0.1.1")
installFromGithub("ohdsi/CohortIncidence", ref = "v3.1.5")
installFromGithub("ohdsi/CohortMethod", ref = "v5.1.0")
installFromGithub("ohdsi/SelfControlledCaseSeries", ref = "v4.2.0")
installFromGithub("ohdsi/PatientLevelPrediction", ref = "v6.3.4")


