#' Get object ids
#'
#' @noRd
#' @importFrom httr2 resp_body_json
getObjectIds <- function(url,
                         where = NULL,
                         token = NULL,
                         objectIds = NULL,
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
      objectIds = objectIds,
      where = where,
      geometryType = geometryType,
      geometry = geometry,
      returnIdsOnly = TRUE,
      ...
    )

  resp <- httr2::resp_body_json(resp = resp, check_type = FALSE)

  resp[["objectIds"]]
}

#' Get count of maximum records per request
#'
#' @noRd
getMaxRecordsCount <- function(url,
                               token = NULL,
                               maxRecords = NULL,
                               upperLimit = FALSE) {
  if (!is.null(maxRecords)) {
    return(as.integer(maxRecords))
  }

  urlInfo <- esriCatalog(url = url, token = token)

  if (!is.null(urlInfo[["maxRecordCount"]])) {
    if (urlInfo[["maxRecordCount"]] > 25000 && upperLimit) {
      return(25000L)
    }

    return(urlInfo[["maxRecordCount"]])
  }

  500L
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
getEsriFeaturesByIds <- function(objectIds = NULL,
                                 url,
                                 fields = NULL,
                                 token = NULL,
                                 crs = NULL,
                                 simplifyDataFrame = FALSE,
                                 simplifyVector = simplifyDataFrame,
                                 ...) {
  if (!is.null(objectIds)) {
    objectIds <- I(paste(objectIds, collapse = ","))
  }

  if (is.null(fields)) {
    fields <- c("*")
  }

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
#' @importFrom dplyr case_when
#' @importFrom jsonlite toJSON
#' @importFrom sf st_crs
#' @importFrom cli cli_warn cli_progress_along
getEsriFeatures <- function(url,
                            fields = NULL,
                            where = NULL,
                            geometry = NULL,
                            geometryType = NULL,
                            objectIds = NULL,
                            token = NULL,
                            crs = NULL,
                            progress = FALSE,
                            call = parent.frame(),
                            ...) {
  crs <-
    dplyr::case_when(
      is.null(crs) ~ "",
      is.numeric(crs) ~ as.character(crs),
      isWktID(crs) ~ sub(pattern = "^(EPSG|ESRI):", replacement = "", x = crs),
      TRUE ~ as.character(jsonlite::toJSON(list("wkt" = WKTunPretty(sf::st_crs(crs)$WKT1_ESRI)), auto_unbox = TRUE))
    )

  ids <-
    getObjectIds(
      url = url,
      where = where,
      geometry = geometry,
      geometryType = geometryType,
      token = token,
      objectIds = objectIds,
      ...
    )

  if (is.null(ids)) {
    cli::cli_warn("No records match the search criteria.")
    invisible(return(NULL))
  }

  # Get max record count and split ids based on count
  maxRC <- getMaxRecordsCount(url, token, upperLimit = TRUE)
  idSplits <- split(ids, seq_along(ids) %/% maxRC)

  seq_fn <- seq_along

  # Check if pbapply progress bar can be used
  if (progress) {
    seq_fn <- cli::cli_progress_along
  }

  results <- lapply(
    seq_fn(idSplits),
    function(x) {
      getEsriFeaturesByIds(
        objectIds = idSplits[[x]],
        url = url,
        fields = fields,
        token = token,
        crs = crs,
        ...
      )
    }
  )

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
