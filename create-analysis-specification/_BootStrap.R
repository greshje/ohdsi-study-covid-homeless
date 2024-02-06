
# ---
#
# functions to load and install libraries/packages
#
# ---

.libPaths()

StrategusRunnerLibUtil <- {}

StrategusRunnerLibUtil$setIsInit <- function (isInit) {
  StrategusRunnerLibUtil$isInit <<- isInit
}

StrategusRunnerLibUtil$setIsInit (FALSE)

StrategusRunnerLibUtil$showVersions <- function() {
  # show versions
  R.Version()
  system("java -version")
  getwd()
  # show the module list
  Strategus::getModuleList()
}

StrategusRunnerLibUtil$packageVersionExists <- function (pkgName, pkgVersion) {
  tryCatch (
    {
      return(packageVersion(pkgName) == pkgVersion)
    },
    error = function(e) {
      return(FALSE)
    }
  )
}

StrategusRunnerLibUtil$installFromCran <- function(pkgName, pkgVersion) {
  if (requireNamespace(pkgName, quietly = TRUE) == TRUE && StrategusRunnerLibUtil$packageVersionExists(pkgName, pkgVersion)) {
    print(paste("Correct version of package already installed: ", pkgName, pkgVersion, sep = " "))
  } else {  
    print(paste("* * * Installing from CRAN:", pkgName, pkgVersion, sep = " "))
    if(pkgName == "remotes") {
      install.packages("remotes", INSTALL_opts = "--no-multiarch")  
    } else {
      remotes::install_version(pkgName, version = pkgVersion, upgrade = FALSE, INSTALL_opts = "--no-multiarch", )
    }
  }
}

StrategusRunnerLibUtil$installFromGithub <- function(pkgName, pkgVersion) {
  if (requireNamespace(pkgName, quietly = TRUE) == TRUE && StrategusRunnerLibUtil$packageVersionExists(pkgName, pkgVersion)) {
    print(paste("Correct version of package already installed: ", pkgName, pkgVersion, sep = " "))
  } else {  
    print(paste("* * * Installing from GitHub:", pkgName, pkgVersion, sep = " "))
    remotes::install_github(pkgName, ref=pkgVersion, upgrade = FALSE, INSTALL_opts = "--no-multiarch")
  }
}

StrategusRunnerLibUtil$checkPackageVersion <- function(packageName) {
  available_packages <- available.packages()
  latest_keyring_version <- available_packages[packageName, "Version"]
  print(latest_keyring_version)  
}

StrategusRunnerLibUtil$removePackage <- function(pkgName) {
  required <- requireNamespace(pkgName, quietly = TRUE)
  print(paste(pkgName, required, sep = ": "))
  if (required) {
    remove.packages(pkgName)
  }
}

StrategusRunnerLibUtil$forceRemovePackage <- function(pkgName) {
  tryCatch({
    devtools::unload(pkgname)
  }, error = function(e) {
    writeLines(paste0("COULD NOT UNLOAD PACKAGE: ", pkgName))
  })
  tryCatch({
    StrategusRunnerLibUtil$removePackage(pkgName)
  }, error = function(e) {
    writeLines(paste0("COULD NOT REMOVE PACKAGE: ", pkgName))
  })
}

# ---
#
# remove libraries that are installed here
#
# ---

StrategusRunnerLibUtil$removePackagesInstalledHere <- function() {
  # from cran
  StrategusRunnerLibUtil$forceRemovePackage("keyring")
  StrategusRunnerLibUtil$forceRemovePackage("usethis")
  StrategusRunnerLibUtil$forceRemovePackage("DatabaseConnector")
  # from github
  StrategusRunnerLibUtil$forceRemovePackage("Strategus")
  StrategusRunnerLibUtil$forceRemovePackage("CohortGenerator")
  StrategusRunnerLibUtil$forceRemovePackage("CirceR")
  StrategusRunnerLibUtil$forceRemovePackage("CohortIncidence")
  # done
  StrategusRunnerLibUtil$setIsInit(FALSE)
}

# ---
#
# install and load libraries
#
# ---

StrategusRunnerLibUtil$initLibs <- function() {
  
  doInstall <- function() {
    # installs from cran
    StrategusRunnerLibUtil$installFromCran("remotes", "2.4.2.1")
    StrategusRunnerLibUtil$installFromCran("keyring", "1.3.1")
    StrategusRunnerLibUtil$installFromCran("usethis", "2.2.2")
    StrategusRunnerLibUtil$installFromCran("dplyr", "1.1.4")
    StrategusRunnerLibUtil$installFromCran("R6", "2.5.1")
    StrategusRunnerLibUtil$installFromCran("DatabaseConnector", "6.2.4")
    StrategusRunnerLibUtil$installFromCran("knitr", "1.45")
    # added for develop version of strategus
    StrategusRunnerLibUtil$installFromCran("aws.s3", "0.3.21")
    StrategusRunnerLibUtil$installFromCran("ellipsis", "0.3.2")
    StrategusRunnerLibUtil$installFromCran("markdown", "1.12")
    
    # installs from github
    StrategusRunnerLibUtil$installFromGithub("OHDSI/Strategus", "v0.2.1")
    StrategusRunnerLibUtil$installFromGithub("OHDSI/Characterization", "v0.1.3")
    StrategusRunnerLibUtil$installFromGithub("OHDSI/CohortDiagnostics", "v3.2.5")
    StrategusRunnerLibUtil$installFromGithub("OHDSI/CohortGenerator", "v0.8.1")
    StrategusRunnerLibUtil$installFromGithub("OHDSI/CohortIncidence", "v3.3.0")
    StrategusRunnerLibUtil$installFromGithub("OHDSI/CohortMethod", "v5.2.0")
    StrategusRunnerLibUtil$installFromGithub("OHDSI/PatientLevelPrediction", "v6.3.6")
    StrategusRunnerLibUtil$installFromGithub("OHDSI/SelfControlledCaseSeries", "v5.1.1")
    StrategusRunnerLibUtil$installFromGithub("OHDSI/EvidenceSynthesis", "v0.5.0")
    StrategusRunnerLibUtil$installFromGithub("OHDSI/CirceR", "v1.3.1")
    StrategusRunnerLibUtil$installFromGithub("OHDSI/Eunomia", "v1.0.2")    
    StrategusRunnerLibUtil$installFromGithub("OHDSI/OhdsiShinyModules", "v2.0.2")    
    StrategusRunnerLibUtil$installFromGithub("OHDSI/ShinyAppBuilder", "v2.0.0")    
    
    # done
    StrategusRunnerLibUtil$setIsInit(TRUE) 
    print("Done with doInstall()")
  }
  
  if(StrategusRunnerLibUtil$isInit == FALSE) {
    print("INITIALIZAING LIBRARIES...")
    doInstall()
    print("DONE INITIALIZING LIBRARIES.")
  } else {
    print("LIBRARIES ALREADY INITIALIZED, SKIPPING INITIALIZATION.")
  }
  
}

StrategusRunnerLibUtil$loadLibs <- function() {
  
  # installs from cran
  library("remotes")
  library("keyring")
  library("usethis")
  library("dplyr")
  library("R6")
  library("DatabaseConnector")
  library("knitr")
  library("aws.s3")
  library("ellipsis")
  
  # installs from github
  library("Strategus")
  library("Characterization")
  library("CohortDiagnostics")
  library("CohortGenerator")
  library("CohortIncidence")
  library("CohortMethod")
  library("PatientLevelPrediction")
  library("SelfControlledCaseSeries")
  library("EvidenceSynthesis")
  library("CirceR")

}

StrategusRunnerLibUtil$initLibs()
.libPaths()

