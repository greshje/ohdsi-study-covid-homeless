# ---
#
# Init.R
# 
# ---

# ---
#
# run the functionsForInit.R script
#
# ---

source("FunctionsForInit.R")

# There is a binary version available but the source version is later:
#   binary source needs_compilation
# pROC 1.18.4 1.18.5              TRUE

# installFromCran("pROC", "1.18.5")

# ---
#
# install the libraries
#
# ---

# install correct versions of HADES packages
print("* * * installing libraries * * *")
installFromGithub("ohdsi/CohortDiagnostics", ref = "v3.2.3")
installFromGithub("ohdsi/Characterization", ref = "v0.1.1")
installFromGithub("ohdsi/CohortIncidence", ref = "v3.1.5")
installFromGithub("ohdsi/CohortMethod", ref = "v5.1.0")
installFromGithub("ohdsi/SelfControlledCaseSeries", ref = "v4.2.0")
installFromGithub("ohdsi/PatientLevelPrediction", ref = "v6.3.4")
installFromGithub("OHDSI/Strategus", "v0.1.0")
# installs from cran
installFromCran("knitr", ref="1.45")

# load the libraries
print("* * * installing libraries * * *")
library(CohortDiagnostics)
library(Characterization)
library(CohortIncidence)
library(CohortMethod)
library(SelfControlledCaseSeries)
library(PatientLevelPrediction)
library(CohortGenerator)
library(Strategus)
library(knitr)

print("* * * DONE WITH INIT.R * * *")
