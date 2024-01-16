
source("https://raw.githubusercontent.com/OHDSI/CohortIncidenceModule/v0.2.0/SettingsFunctions.R")

library(CohortIncidence)

# ---
#
# Define the variables for this study
#
# ---

# ---
#
# targets
#
# This is the list of treatment/control groups (cohorts)
#
# ---

targets <- list(
  createCohortRef(id = 1, name = "Homeless"),
  createCohortRef(id = 2, name = "Not Homeless")
)

# ---
#
# outcomes
#
# This is the list of outcomes (result cohorts)
#   id is the primary key (cohort_id) from Atlas/CDM
#   cohortId is the id assigned in Cohorts.csv
#
# ---

outcomes <- list(
  createOutcomeDef(
    id = 4, 
    name = "Vaccinated", 
    cohortId = 3, 
    cleanWindow = 9999)
)

# ---
#
# time at risk
#
# ---

tars <- list(
  createTimeAtRiskDef(id = 1, startWith = "start", endWith = "end"),
  createTimeAtRiskDef(id = 2, startWith = "start", endWith = "start", endOffset = 180)
)

# ---
#
# define the analysis
#
# ---

analysis1 <- createIncidenceAnalysis(
  targets = c(1, 2),
  outcomes = c(1),
  tars = c(1, 2)
)


# ---
#
# create the design
#
# ---

irDesign <- createIncidenceDesign(
  targetDefs = targets,
  outcomeDefs = outcomes,
  tars = tars,
  analysisList = list(analysis1),
  strataSettings = createStrataSettings(
    byYear = TRUE,
    byGender = TRUE
  )
)

cohortIncidenceModuleSpecifications <- createCohortIncidenceModuleSpecifications(
  irDesign = irDesign$toList()
)

