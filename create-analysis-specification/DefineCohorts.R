library(CohortGenerator)

cohortDefinitionSet <- getCohortDefinitionSet(
  settingsFileName = "testdata/Cohorts.csv",
  jsonFolder = "testdata/cohorts",
  sqlFolder = "testdata/sql",
  packageName = "Strategus"
)

ncoCohortSet <- readCsv(
  file = system.file("testdata/negative_controls_concept_set.csv", package = "Strategus")
)

