# ---
#
# CreateAnalysisSpecification.R
#
# A master script to create the analysis specification for this study. 
# See the following web pages for source material and more details:
# https://ohdsi.github.io/Strategus/articles/CreatingAnalysisSpecification.html 
# https://ohdsi.github.io/Strategus/index.html
#
# ---

# ---
#
# versions
#
# ---

R.Version()
system("java -version")
getwd()

# ---
#
# build the package
#
# ---

source("Init.R")

source("DefineCohorts.R")

source("CohortGeneratorModuleSettings.R")

source("CohortDiagnosticsModuleSettings.R")

source("CohortIncidenceModuleSettings.R")

source("CharacterizationModuleSettings.R")

source("CohortMethodModuleSettings.R")

source("CreateSpecification.R")






