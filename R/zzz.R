#' Get object ids
#'
#' @noRd
#' @importFrom httr2 resp_body_json
getObjectIds <- function(url,
                         where = NULL,
                         token = NULL,
                         geometry = NULL,
                         geometryType = NULL,
                         ...) {
  if (is.null(where)) {
    where <- "1=1"
  }

  resp <-
    esriRequest(
      url = url,
      append = "query",
      token = token,
      f = "json",
      where = where,
      geometryType = geometryType,
      geometry = geometry,
      returnIdsOnly = TRUE,
      ...
    )

  resp <- httr2::resp_body_json(resp = resp, check_type = FALSE)

  resp$objectIds
}

#' Get count of maximum records per request
#'
#' @noRd
getMaxRecordsCount <- function(url,
                               token = NULL,
                               maxRecords = NULL,
                               upperLimit = FALSE) {
  if (!is.null(maxRecords)) {
    if (!is.integer(maxRecords)) {
      maxRecords <- as.integer(maxRecords)
    }

    return(maxRecords)
  }

  urlInfo <- esriCatalog(url = url, token = token)

  if (!is.null(urlInfo[["maxRecordCount"]])) {
    if (urlInfo[["maxRecordCount"]] > 25000 && upperLimit) {
      maxRC <- 25000L
    } else {
      maxRC <- urlInfo[["maxRecordCount"]]
    }
  } else {
    maxRC <- 500L
  }

  maxRC
}

#' Get table for Table layer
#'
#' @noRd
#' @importFrom dplyr bind_rows as_tibble
getEsriTable <- function(jsonFeats) {
  atts <- lapply(
    lapply(jsonFeats, `[[`, 1),
    function(att) lapply(att, function(x) ifelse(is.null(x), NA, x))
  )

  df <-
    dplyr::bind_rows(
      lapply(atts, as.data.frame.list, stringsAsFactors = FALSE)
    )

  dplyr::as_tibble(df)
}


#' Get features using feature ids from getObjectIds
#'
#' @noRd
#' @importFrom httr2 resp_body_json
#' @importFrom cli cli_abort
getEsriFeaturesByIds <- function(ids,
                                 url,
                                 fields = NULL,
                                 token = NULL,
                                 crs = 4326,
                                 simplifyDataFrame = FALSE,
                                 simplifyVector = simplifyDataFrame,
                                 ...) {
  if (is.null(fields)) {
    fields <- c("*")
  }

  objectIds <- I(paste(ids, collapse = ","))
  outFields <- I(paste(fields, collapse = ","))

  resp <-
    esriRequest(
      url,
      append = "query",
      f = "json",
      objectIds = objectIds,
      outFields = outFields,
      outSR = crs,
      token = token,
      ...
    )

  resp <-
    httr2::resp_body_json(
      resp,
      check_type = FALSE,
      # Additional parameters passed to jsonlite::fromJSON
      digits = NA,
      simplifyDataFrame = simplifyDataFrame,
      simplifyVector = simplifyVector,
    )

  resp[["features"]]
}


#' Get ESRI features
#'
#' @noRd
#' @importFrom cli cli_alert_danger
#' @importFrom dplyr case_when
#' @importFrom jsonlite toJSON
#' @importFrom sf st_crs
getEsriFeatures <- function(url,
                            fields = NULL,
                            where = NULL,
                            geometry = NULL,
                            geometryType = NULL,
                            maxRecords = NULL,
                            token = NULL,
                            crs = 4326,
                            progress = FALSE,
                            call = parent.frame(),
                            ...) {
  ids <-
    getObjectIds(
      url = url,
      where = where,
      geometry = geometry,
      geometryType = geometryType,
      token = token,
      ...
    )

  if (is.null(ids)) {
    cli::cli_warn("No records match the search criteria.")
    invisible(return(NULL))
  }

  maxRC <- getMaxRecordsCount(url, token, maxRecords, upperLimit = TRUE)
  idSplits <- split(ids, seq_along(ids) %/% maxRC)

  crs <-
    dplyr::case_when(
      is.null(crs) ~ "",
      is.numeric(crs) ~ as.character(crs),
      isWktID(crs) ~ sub(pattern = "^(EPSG|ESRI):", replacement = "", x = crs),
      TRUE ~ as.character(jsonlite::toJSON(list("wkt" = WKTunPretty(sf::st_crs(crs)$WKT1_ESRI)), auto_unbox = TRUE))
    )

  error_fn <-
    function(x) {
      cli::cli_abort(
        message = c(
          "Your query can't be completed.",
          "*" = "Try setting the {.arg maxRecords} parameter
          (500 or less suggested) and retrying your request."
        ),
        parent = x,
        call = call
      )
    }

  # Check if pbapply progress bar can be used
  if (progress) {
    results <-
      tryCatch(
        lapply(
          cli::cli_progress_along(idSplits),
          function(x) {
            getEsriFeaturesByIds(idSplits[[x]], url, fields, token, crs, ...)
          }
        ),
        error = error_fn
      )
  } else {
    results <-
      tryCatch(
        lapply(
          idSplits,
          getEsriFeaturesByIds,
          url, fields, token, crs, ...
        ),
        error = error_fn
      )
  }

  unlist(results, recursive = FALSE)
}

isWktID <- function(crs) {
  is.numeric(crs) || grepl(pattern = "^(EPSG|ESRI):[[:digit:]]+$", x = crs)
}

WKTunPretty <- function(wkt) {
  gsub("\\n[[:blank:]]*", "", wkt)
}

utils::globalVariables(
  c("name", "serviceType", "type", "urlType")
)
