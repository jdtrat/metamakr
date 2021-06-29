.onAttach <- function(...) {
  # See if any packages are needed
  needed <- pkgs[!is_attached(pkgs)]
  # If no packages are needed, return
  if (length(needed) == 0) {
    return()
    # Otherwise, attach any needed packages
  } else {
    {{name}}_attach()
  }

}

# Detach all loaded packages for seeing the pretty startup message (:
{{ name }}_detach <- function() {
  pak <- paste0("package:", pkgs)
  lapply(pak[pak %in% search()], detach, character.only = TRUE)
  invisible()
}


# List all packages imported by {{ name }}
{{ name }}_packages <- function() {
  # get all imports from {{ name }}'s package description file
  raw <- utils::packageDescription("{{ name }}")$Imports
  # return a character vector of all the imports
  imports <- strsplit(raw, ",")[[1]]
  # "^\\s+" matches white space at the beginning of a character string
  # "\\s+$ matches white space at the end of a character string
  parsed <- gsub("^\\s+|\\s+$", "", imports)
  # for each import, take only the first complete word (i.e. the package name)
  names <- vapply(strsplit(parsed, "\\s+"), "[[", 1, FUN.VALUE = character(1))

  return(names)

}
