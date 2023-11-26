source("https://raw.githubusercontent.com/OHDSI/CharacterizationModule/v0.4.0/SettingsFunctions.R")
characterizationModuleSpecifications <- createCharacterizationModuleSpecifications(
  targetIds = c(1, 2),
  outcomeIds = 3,
  covariateSettings = FeatureExtraction::createDefaultCovariateSettings(),
  dechallengeStopInterval = 30,
  dechallengeEvaluationWindow = 30,
  timeAtRisk = data.frame(
    startAnchor = c("cohort start", "cohort start"),
    riskWindowStart = c(1, 1),
    endAnchor = c("cohort end", "cohort end"),
    riskWindowEnd = c(180, 180)
  )
)
