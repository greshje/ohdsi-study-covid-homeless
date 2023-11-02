source("https://raw.githubusercontent.com/OHDSI/CohortGeneratorModule/v0.1.0/SettingsFunctions.R")

# Create the cohort definition shared resource element for the analysis specification
cohortDefinitionSharedResource <- createCohortSharedResourceSpecifications(
  cohortDefinitionSet = cohortDefinitionSet
)

# Create the negative control outcome shared resource element for the analysis specification
ncoSharedResource <- createNegativeControlOutcomeCohortSharedResourceSpecifications(
  negativeControlOutcomeCohortSet = ncoCohortSet,
  occurrenceType = "all",
  detectOnDescendants = TRUE
)

# Create the module specification
cohortGeneratorModuleSpecifications <- createCohortGeneratorModuleSpecifications(
  incremental = TRUE,
  generateStats = TRUE
)

