
load_package <- function(info, index) {
  if (info$dev[index]) {
    usethis::use_dev_package(info$name[index])
  } else if (!info$dev[index]) {
    usethis::use_package(info$name[index])
  }
}

#' Create a 'Verse' or 'Meta' Package
#'
#' Inspired by the package [tidyverse](https://tidyverse.tidyverse.org/), this
#' function helps you easily create your own 'verse' or 'Meta' package to
#' facilitate easy installation and loading of multiple, related packages. Plus,
#' you'll get a nice 'tidyverse' style startup message.
#'
#' @param name The meta package name
#' @param imports A character vector of the packages you're bundling
#' @param dev If any of the packages included are development versions (e.g. on
#'   GitHub and not on CRAN), supply a vector of TRUE/FALSE indicating the
#'   development version should be used.
#'
#' @export
#'
#' @examples
#'
#' \dontrun{
#' create_meta_package(name = "myPackageName",
#'                     imports = c("publishedPackage1",
#'                                 "publishedPackage2")
#' )
#'
#'
#' create_meta_package(name = "myPackageName",
#'                     imports = c("publishedPackage1",
#'                                 "devPackage",
#'                                 "publishedPackage2",
#'                     ),
#'                     dev = c(FALSE,
#'                             TRUE,
#'                             FALSE)
#' )
#' }
#'
create_meta_package <- function(name, imports, dev) {

attach_file <- whisker::whisker.render(
    template = readLines(system.file("templates/attach.R",
                                     package = "metamakr")),
    data = list(name = name, imports = deparse(substitute(imports)))
    )

utils_file <- whisker::whisker.render(
  template = readLines(system.file("templates/utils.R",
                                   package = "metamakr")),
  data = list(name = name)
)

zzz_file <- whisker::whisker.render(
  template = readLines(system.file("templates/zzz.R",
                                   package = "metamakr")),
  data = list(name = name)
)

  usethis::write_over(usethis::proj_path("R/attach.R"), lines = attach_file)
  usethis::write_over(usethis::proj_path("R/utils.R"), lines = utils_file)
  usethis::write_over(usethis::proj_path("R/zzz.R"), lines = zzz_file)

  pkg_imports <- c("cli", "crayon", "utils", "rstudioapi", imports)

  if (missing(dev)) {
    lapply(pkg_imports, usethis::use_package)
  } else {
    pkg_dev <- c(FALSE, FALSE, FALSE, FALSE, dev)
    lapply(1:length(pkg_imports), load_package, info = list(name = pkg_imports, dev = pkg_dev))
  }

  invisible()

}
