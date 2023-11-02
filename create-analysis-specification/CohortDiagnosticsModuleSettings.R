source("https://raw.githubusercontent.com/OHDSI/CohortDiagnosticsModule/v0.1.0/SettingsFunctions.R")
cohortDiagnosticsModuleSpecifications <- createCohortDiagnosticsModuleSpecifications(
  runInclusionStatistics = TRUE,
  runIncludedSourceConcepts = TRUE,
  runOrphanConcepts = TRUE,
  runTimeSeries = FALSE,
  runVisitContext = TRUE,
  runBreakdownIndexEvents = TRUE,
  runIncidenceRate = TRUE,
  runCohortRelationship = TRUE,
  runTemporalCohortCharacterization = TRUE,
  incremental = FALSE
)