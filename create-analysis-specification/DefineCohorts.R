
library(CohortGenerator)
library(knitr)

cohortDefinitionSet <- getCohortDefinitionSet(
  settingsFileName = "./cohorts/Cohorts.csv",
  jsonFolder = "./cohorts/json",
  sqlFolder = "./cohorts/sql"
)

ncoCohortSet <- readCsv(
  file = "./concept-sets/negative-control/NegativeControls.csv"
)

kable(cohortDefinitionSet[, c("cohortId", "cohortName")])
kable(ncoCohortSet)





