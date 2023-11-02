source("https://raw.githubusercontent.com/OHDSI/CohortIncidenceModule/v0.2.0/SettingsFunctions.R")
library(CohortIncidence)
targets <- list(
  createCohortRef(id = 1, name = "Celecoxib"),
  createCohortRef(id = 2, name = "Diclofenac"),
  createCohortRef(id = 4, name = "Celecoxib Age >= 30"),
  createCohortRef(id = 5, name = "Diclofenac Age >= 30")
)
outcomes <- list(createOutcomeDef(id = 1, name = "GI bleed", cohortId = 3, cleanWindow = 9999))

tars <- list(
  createTimeAtRiskDef(id = 1, startWith = "start", endWith = "end"),
  createTimeAtRiskDef(id = 2, startWith = "start", endWith = "start", endOffset = 365)
)
analysis1 <- createIncidenceAnalysis(
  targets = c(1, 2, 4, 5),
  outcomes = c(1),
  tars = c(1, 2)
)

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