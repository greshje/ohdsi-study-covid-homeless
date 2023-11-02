
analysisSpecifications <- createEmptyAnalysisSpecificiations() %>%
  addSharedResources(cohortDefinitionSharedResource) %>%
  addSharedResources(ncoSharedResource) %>%
  addModuleSpecifications(cohortGeneratorModuleSpecifications) %>%
  addModuleSpecifications(cohortDiagnosticsModuleSpecifications) %>%
  addModuleSpecifications(cohortIncidenceModuleSpecifications) %>%
  addModuleSpecifications(characterizationModuleSpecifications) %>%
  addModuleSpecifications(cohortMethodModuleSpecifications) 

ParallelLogger::saveSettingsToJson(
  analysisSpecifications, 
  file.path("./strategus-specification", "StrategusSpecification.json"))


