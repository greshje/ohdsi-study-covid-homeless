library(CohortGenerator)
library(knitr)

# get the cohort definitions from Cohorts.csv, json, and sql files
cohortDefinitionSet <- getCohortDefinitionSet(
  settingsFileName = "./cohorts/Cohorts.csv",
  jsonFolder = "./cohorts/json",
  sqlFolder = "./cohorts/sql"
)

# get the negative cohort set
ncoCohortSet <- readCsv(
  file = "./concept-sets/negative-control/NegativeControls.csv"
)

# display the list of cohorts and the negative controls
kable(cohortDefinitionSet[, c("cohortId", "cohortName")])
kable(ncoCohortSet)





