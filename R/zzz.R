#' @import utils
.onAttach <- function(libname, pkgname) {
    packageStartupMessage("Loading biscuiteerData.")
    if (has_internet()) {
        biscuiteerDataCacheAll(showProgress = FALSE)
    }
}
