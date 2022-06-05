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

  return(resp$objectIds)
}

#' Get count of maximum records per request
#'
#' @noRd
getMaxRecordsCount <- function(url,
                               token = NULL,
                               upperLimit = FALSE) {
  urlInfo <- esriCatalog(url = url, token = token)

  if (!is.null(urlInfo[["maxRecordCount"]])) {
    if (urlInfo[["maxRecordCount"]] > 25000 & upperLimit) {
      maxRC <- 25000L
    } else {
      maxRC <- urlInfo[["maxRecordCount"]]
    }
  } else {
    maxRC <- 500L
  }

  return(maxRC)
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
  df <- dplyr::bind_rows(lapply(atts, as.data.frame.list, stringsAsFactors = FALSE))

  return(dplyr::as_tibble(df))
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

  # create Simple Features from ArcGIS servers json response
  resp <-
    esriRequest(
      url,
      append = "query",
      f = "json",
      token = token,
      objectIds = paste(ids, collapse = ","),
      outFields = paste(fields, collapse = ","),
      outSR = crs,
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

  return(resp[["features"]])
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
                            token = NULL,
                            crs = 4326,
                            progress = FALSE,
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
    cli::cli_alert_danger("No records match the search criteria.")
    return()
  }
  maxRC <- getMaxRecordsCount(url, token, upperLimit = TRUE)
  idSplits <- split(ids, seq_along(ids) %/% maxRC)

  crs <-
    dplyr::case_when(
      is.null(crs) ~ "",
      is.numeric(crs) ~ as.character(crs),
      isWktID(crs) ~ sub(pattern = "^(EPSG|ESRI):", replacement = "", x = crs),
      TRUE ~ as.character(jsonlite::toJSON(list("wkt" = WKTunPretty(sf::st_crs(crs)$WKT1_ESRI)), auto_unbox = TRUE))
    )

  # Check if pbapply progress bar can be used
  if (!requireNamespace("pbapply", quietly = TRUE) & progress) {
    cli::cli_alert_danger(
      "The {.pkg pbapply} package is not installed.
      {.pkg pbapply} is required to use the {.arg progress} argument.
      Setting {.arg progress} to {.val FALSE}."
    )
    progress <- FALSE
  }

  if (progress) {
    results <-
      pbapply::pblapply(
        idSplits,
        getEsriFeaturesByIds,
        url, fields, token, crs, ...
      )
  } else {
    results <-
      lapply(
        idSplits,
        getEsriFeaturesByIds,
        url, fields, token, crs, ...
      )
  }

  return(unlist(results, recursive = FALSE))
}

#' Get authority string for WKT (well known text) id
#'
#' @noRd
#' @importFrom sf sf_proj_search_paths
#' @importFrom DBI dbConnect dbGetQuery dbDisconnect
#' @importFrom RSQLite SQLite
#' @importFrom cli cli_abort
getWKTidAuthority <- function(wktID) {
  projPaths <- file.path(sf::sf_proj_search_paths(), "proj.db")
  projDB <- projPaths[file.exists(projPaths)][1]

  con <- DBI::dbConnect(RSQLite::SQLite(), projDB)

  crsData <- DBI::dbGetQuery(con, paste0("SELECT * FROM crs_view WHERE code = '", wktID, "'"))

  DBI::dbDisconnect(con)

  if (nrow(crsData) == 0) {
    cli::cli_abort("WKTid: {.val {wktID}} not found in {.file proj.db}")
  }

  if (nrow(crsData) > 1) {
    cli::cli_abort(
      "WKTid: {.val {wktID}} has multiple entries in  {.file proj.db}.
    Please specify authority (EPSG|ESRI) in {.arg crs} argument"
    )
  }

  wktID <- paste0(crsData$auth_name, ":", crsData$code)

  return(wktID)
}

isWktID <- function(crs) {
  is.numeric(crs) || grepl(pattern = "^(EPSG|ESRI):[[:digit:]]+$", x = crs)
}

WKTunPretty <- function(wkt) {
  gsub("\\n[[:blank:]]*", "", wkt)
}

utils::globalVariables(c("name", "serviceType", "type", "urlType"))
