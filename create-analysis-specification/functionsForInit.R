# ---
#
# functionsForInit.R
# 
# ---

environment(new.env())

# ---
#
# versions
#
# ---

R.Version()
system("java -version")
getwd()

# ---
#
# install functions
#
# ---

installFromCran <- function(pkgName, ref) {
  if (!requireNamespace(pkgName, quietly = TRUE) || packageVersion(pkgName) != ref) {
    remotes::install_version(pkgName, version = ref, upgrade = FALSE, INSTALL_opts = "--no-multiarch")
  }
}

installFromGithub <- function(pkgName, ref) {
  if (!requireNamespace(pkgName, quietly = TRUE) || packageVersion(pkgName) != ref) {
    remotes::install_github(pkgName, ref=ref, upgrade = FALSE, INSTALL_opts = "--no-multiarch")
  }
}

checkPackageVersion <- function(packageName) {
  available_packages <- available.packages()
  latest_keyring_version <- available_packages[packageName, "Version"]
  print(latest_keyring_version)  
}

