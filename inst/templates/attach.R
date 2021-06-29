
pkgs <- {{{ imports }}}

{{ name }}_attach <- function() {
  # Create `to_load` which is a character vector of all {{ name }}
  # packages not loaded in the current R session.
  to_load <- check_loaded()

  # If to_load has length 0, all main packages are loaded.
  # Nothing will be attached.
  if (length(to_load) == 0) {
    return(invisible())
  }

  # Create a line rule with two text labels:
  # "Attaching packages" on the left-hand side and
  # {{ name }} with the package version on the right-hand side
  load_header <- cli::rule(
    left = crayon::bold("Attaching packages"),
    right = paste0("{{ name }} ", package_version("{{ name }}"))
  )

  # Return a character string containing the package version for each of {{ name }}'s constituents
  versions <- vapply(to_load, package_version, character(1))

  packages <- paste0(
    crayon::green(cli::symbol$tick), " ", crayon::blue(format(to_load)), " ",
    crayon::col_align(versions, max(crayon::col_nchar(versions)))
  )

  # Format for two columns
  # if there is an odd number of packages, add ""
  if (length(packages) %% 2 == 1) {
    packages <- append(packages, "")
  }
  # Divide the packages into column 1 and 2
  col1 <- seq_len(length(packages) / 2)
  # paste the packages in column one with a space and those not in column 1
  info <- paste0(packages[col1], "     ", packages[-col1])

  # display the message!
  msg(load_header)
  msg(paste(info, collapse = "\n"))

  # Load the constituent packages!
  # character.only = TRUE must be used in order to
  # supply character strings to `library()`
  suppressPackageStartupMessages(
    lapply(to_load, library, character.only = TRUE)
  )

  # Thanks for playing
  invisible()

}
