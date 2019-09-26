cacheEnv <- new.env()

#' Retrieve biscuiteer data
#'
#' @param title      Title of the data
#' @param dateAdded  Version of the data (given by the date added)
#'                   (DEFAULT: "2019-09-25")
#' @param verbose    Whether to output ExperimentHub message (DEFAULT: FALSE)
#'
#' @return           Data object
#'
#' @import ExperimentHub
#' @import AnnotationHub
#'
#' @examples
#'
#'   wcgws <- biscuiteerDataGet("Zhou_solo_WCGW_inCommonPMDs.hg19.rda")
#'
#' @export
#'
biscuiteerDataGet <- function(title,
                              dateAdded = "2019-09-25",
                              verbose = FALSE) {
    if (verbose) {
        .biscuiteerDataGet(title, dateAdded = dateAdded)
    } else {
        suppressMessages(
            log <- capture.output(obj <- .biscuiteerDataGet(title,
                                             dateAdded = dateAdded))
        )
        obj
    }
}

.biscuiteerDataGet <- function(title,
                               dateAdded) {
    key <- paste0(title, "|", dateAdded)

    if (!exists(key, envir = cacheEnv, inherits = FALSE)) {
        eh <- query(ExperimentHub(localHub = TRUE), "biscuiteerData")
        obj_id <- which(eh$title == title & eh$rdatadateadded == dateAdded)
        if (length(obj_id) == 1) {
            assign(key, eh[[obj_id]], envir = cacheEnv)
        } else {
            eh <- query(ExperimentHub(localHub = FALSE), "biscuiteerData")
            obj_id <- which(eh$title == title & eh$rdatadateadded == dateAdded)
            if (length(obj_id) == 1) {
                cache(eh[obj_id])
                assign(key, eh[[obj_id]], envir = cacheEnv)
            } else {
                stop(key, " doesn't exist. Try: biscuiteerDataCacheAll(",
                     dateAdded, ").")
            }
        }
    }

    return(get(key, envir = cacheEnv, inherits = FALSE))
}

#' @importFrom curl nslookup
has_internet <- function() {
    !is.null(curl::nslookup("r-project.org", error = FALSE))
}

#' List all biscuiteer data
#'
#' @param dateAdded Version of the data (given by the date added), if "all" then
#'                  all dates will be shown (DEFAULT: "all")
#'
#' @return          All titles from biscuiteer data
#'
#' @examples
#'
#'   biscuiteerDataList()
#'
#' @export
#'
biscuiteerDataList <- function(dateAdded = "all") {
    if (has_internet()) {
        eh <- query(ExperimentHub(), "biscuiteerData")
    } else {
        eh <- query(ExperimentHub(localHub = TRUE), "biscuiteerData")
    }

    if (dateAdded == "all") {
        eh$title
    } else {
        eh$title[eh$rdatadateadded == dateAdded]
    }
}

#' List all versions of biscuiteer data
#'
#' @return  Sorted unique dates in biscuiteer data
#'
#' @examples
#'
#'   biscuiteerDataListDates()
#'
#' @export
#'
biscuiteerDataListDates <- function() {
    if (has_internet()) {
        eh <- query(ExperimentHub(), "biscuiteerData")
    } else {
        eh <- query(ExperimentHub(localHub = TRUE), "biscuiteerData")
    }

    sort(unique(eh$rdatadateadded))
}

#' Cache all biscuiteer data
#'
#' @param dateAdded     Version of the data (given by the date added), if "all"
#'                      then all dates will be cached (DEFAULT: "all")
#' @param showProgress  Whether to show progress of download (DEFAULT: FALSE)
#'
#' @return              TRUE
#'
#' @import ExperimentHub
#' @import AnnotationHub
#'
#' @examples
#' 
#'   biscuiteerDataCacheAll()
#'
#' @export
#'
biscuiteerDataCacheAll <- function(dateAdded = "all",
                                   showProgress = FALSE) {
    setExperimentHubOption(arg = "MAX_DOWNLOADS", 100)
    tryCatch(
        {
            # Load metadata
            if (showProgress) {
                eh <- query(ExperimentHub(), "biscuiteerData")
            } else {
                suppressMessages(
                    log <- capture.output(eh <- query(ExperimentHub(),
                                                      "biscuiteerData"))
                )
            }

            # Restrict to specified date
            if (dateAdded != "all") {
                eh <- eh[eh$rdatadateadded == dateAdded]
            }

            # Load actual data
            if (showProgress) {
                cache(eh)
            } else {
                suppressMessages(log <- capture.output(cache(eh)))
            }
        },
        error = function(cond) {
            message("ExperimentHub caching fails:")
            message(cond, appendLF = TRUE)
            return(FALSE)
        },
        warning = function(cond) {
            message("ExperimentHub caching warnings:")
            message(cond, appendLF = TRUE)
            return(FALSE)
        }
    )

    TRUE
}
