# metamakr

#### Easily Create a Meta Package

 <!-- badges: start -->
  [![R-CMD-check](https://github.com/jdtrat/metamakr/workflows/R-CMD-check/badge.svg)](https://github.com/jdtrat/metamakr/actions)
  <!-- badges: end -->

------------------------------------------------------------------------

 The tidyverse bundles together a suite of packages that "share common data representations and 'API' design," allowing easy installation and loading of multiple packages at once. Inspired by the [tidyverse](https://tidyverse.tidyverse.org), metamakr is designed to help users create their own verse of packages. metamakr is a development tool that allows you to bundle your own related packages, e.g. all internal packages for a research lab or company.

------------------------------------------------------------------------

## Installation

You can install the development version of metamakr from GitHub as follows:

``` r
if (!require("remotes")) install.packages("remotes")
remotes::install_github("jdtrat/metamakr")

# Load package
library(metamakr)
```

## Usage

metamakr provides one function, `create_meta_package()`, which accepts three arguments: the name of the meta package, a character vector of the packages to import, and (optionally), a logical vector indicating which of the imported packages are development versions. 

`create_meta_package()` calls [`usethis::use_package()` or `usethis::use_dev_package()`](https://usethis.r-lib.org/reference/use_package.html) for each import and creates three files used to attach the packages as needed with a tidyverse-style startup message. These files are:

|   File   |                                              Description                                             |
|:--------:|:----------------------------------------------------------------------------------------------------:|
| attach.R | Provides code used to attach all (unattached) packages.  This includes the stylized startup message. |
|  utils.R |                  Provides code for utility functions used to style startup message.                  |
|   zzz.R  |                  Defines the `.onAttach()` function to display the startup message.                  |

