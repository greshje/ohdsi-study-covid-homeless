
library(CohortGenerator)
library(knitr)

cohortDefinitionSet <- getCohortDefinitionSet(
  settingsFileName = "testdata/Cohorts.csv",
  jsonFolder = "testdata/cohorts",
  sqlFolder = "testdata/sql",
  packageName = "Strategus"
)

ncoCohortSet <- readCsv(
  file = system.file("testdata/negative_controls_concept_set.csv", package = "Strategus")
)

kable(cohortDefinitionSet[, c("cohortId", "cohortName")])
kable(ncoCohortSet)


