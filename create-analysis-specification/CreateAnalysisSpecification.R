# ---
#
# CreateAnalysisSpecification.R
#
# A master script to create the analysis specification for this study. 
#
# ---

# ---
#
# versions
#
# ---

R.Version()
system("java -version")
getwd()source("Init.R")

# ---
#
# build the package
#
# ---

source("DefineCohorts.R")

source("CohortGeneratorModuleSettings.R")

source("CohortDiagnosticsModuleSettings.R")

source("CohortIncidenceModuleSettings.R")

source("CharacterizationModuleSettings.R")

source("CohortMethodModuleSettings.R")

source("CreateSpecification.R")






