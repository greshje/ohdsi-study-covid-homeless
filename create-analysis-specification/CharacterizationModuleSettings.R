source("https://raw.githubusercontent.com/OHDSI/CharacterizationModule/v0.4.0/SettingsFunctions.R")
characterizationModuleSpecifications <- createCharacterizationModuleSpecifications(
  targetIds = c(1, 2),
  outcomeIds = 3,
  covariateSettings = FeatureExtraction::createDefaultCovariateSettings(),
  dechallengeStopInterval = 30,
  dechallengeEvaluationWindow = 30,
  timeAtRisk = data.frame(
    riskWindowStart = c(1, 1),
    startAnchor = c("cohort start", "cohort start"),
    riskWindowEnd = c(0, 180),
    endAnchor = c("cohort end", "cohort end")
  )
)
