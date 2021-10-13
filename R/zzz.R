
generateToken <- function(server, uid, pwd = "", expiration = 5000) {
  # generate auth token from GIS server
  if (pwd == "") pwd <- rstudioapi::askForPassword("pwd")

  query <- list(
    username = uid,
    password = pwd,
    expiration = expiration,
    client = "requestip",
    f = "json"
  )

  r <- httr::POST(paste(server, "arcgis/admin/generateToken", sep = "/"),
            body = query, encode = "form")
  jsonlite::fromJSON(httr::content(r, "parsed"))$token
}

# Generate a OAuth token for Arcgis Online
# How to obtain clientId and clientSecret is described here:
# https://developers.arcgis.com/documentation/core-concepts/security-and-authentication/accessing-arcgis-online-services/
generateOAuthToken <- function(clientId, clientSecret, expiration = 5000) {

  query = list(
    client_id = clientId,
    client_secret = clientSecret,
    expiration = expiration,
    grant_type = "client_credentials"
  )

  r <- httr::POST("https://www.arcgis.com/sharing/rest/oauth2/token", body = query)
  httr::content(r, type = "application/json")$access_token
}


getObjectIds <- function(queryUrl, where, bbox, token = "", ...) {

  # create Simple Features from ArcGIS servers json response
  query <- list(where = where, geometryType = "esriGeometryEnvelope",
                geometry = bbox, returnIdsOnly = "true", token = token,
                f = "json", ...)

  responseRaw <- httr::content(httr::POST(queryUrl, body = query, encode = "form",
                              config = httr::config(ssl_verifypeer = FALSE)), as = "text")

  response <- jsonlite::fromJSON(responseRaw)
  response$objectIds
}

getMaxRecordsCount <- function(queryUrl, token, upperLimit = FALSE) {

  url <- sub("/query$", "", queryUrl)

  query <- list(f = "json", token = token)

  responseRaw <- httr::content(httr::POST(url, body = query, encode = "form",
                              config = httr::config(ssl_verifypeer = FALSE)), as = "text")
  response <- jsonlite::fromJSON(responseRaw)

  if (!is.null(response[['maxRecordCount']])) {
    if (response[['maxRecordCount']] > 25000 & upperLimit) {
      maxRC <- 25000L
    } else {
      maxRC <- response[['maxRecordCount']]
    }
  } else {
    maxRC <- 500L
  }

  maxRC

}

getRecordsCount <- function(queryUrl, where, token = "", ...) {

  query <- list(where = where, returnCountOnly = 'true', token = token, f = "json", ...)

  responseRaw <- httr::content(httr::POST(queryUrl, body = query, encode = "form",
                              config = httr::config(ssl_verifypeer = FALSE)), as = "text")
  response <- jsonlite::fromJSON(responseRaw)

  response[['count']]

}

getEsriTable <- function(jsonFeats) {
  atts <- lapply(lapply(jsonFeats, `[[`, 1),
                 function(att) lapply(att, function(x) ifelse(is.null(x), NA, x)))
  df <- dplyr::bind_rows(lapply(atts, as.data.frame.list, stringsAsFactors = FALSE))
  dplyr::as_tibble(df)
}


getEsriFeaturesByIds <- function(ids, queryUrl, fields, token = "", crs = 4326, ...) {
  # create Simple Features from ArcGIS servers json response
  query <- list(objectIds = paste(ids, collapse = ","),
                outFields = paste(fields, collapse = ","),
                token = token, outSR = crs, f = "json", ...)

  responseRaw <- httr::content(httr::POST(queryUrl, body = query, encode = "form",
                              config = httr::config(ssl_verifypeer = FALSE)), as = "text")

  response <- jsonlite::fromJSON(responseRaw, simplifyDataFrame = FALSE, simplifyVector = FALSE,
                       digits = NA)

  if ('error' %in% names(response)) {
    stop(paste0("Error code: ", response$error$code, ".\n  Message: ", response$error$message, "\n  Details: ", response$error$details))
  }

  response$features
}

esri2sfPoint <- function(features) {
  getPointGeometry <- function(feature) {
    if (is.numeric(unlist(feature$geometry))) {
      sf::st_point(unlist(feature$geometry))
    } else sf::st_point()
  }
  sf::st_sfc(lapply(features, getPointGeometry))
}

esri2sfPolygon <- function(features) {
  ring2matrix <- function(ring) do.call(rbind, lapply(ring, unlist))
  rings2multipoly <- function(rings)
    sf::st_multipolygon(list(lapply(rings, ring2matrix)))

  getGeometry <- function(feature) {
    if (is.null(unlist(feature$geometry$rings))) {
      sf::st_multipolygon()
    } else rings2multipoly(feature$geometry$rings)
  }

  sf::st_sfc(lapply(features, getGeometry))
}

esri2sfPolyline <- function(features) {
  path2matrix <- function(path) do.call(rbind, lapply(path, unlist))
  paths2multiline <- function(paths) sf::st_multilinestring(lapply(paths, path2matrix))

  getGeometry <- function(feature) paths2multiline(feature$geometry$paths)

  sf::st_sfc(lapply(features, getGeometry))
}

getEsriFeatures <- function(queryUrl, fields, where, bbox, token = "", crs = 4326, progress = FALSE, ...) {
  ids <- getObjectIds(queryUrl, where, bbox, token, ...)
  if (is.null(ids)) {
    warning("No records match the search criteria.")
    return()
  }
  maxRC <- getMaxRecordsCount(queryUrl, token, upperLimit = TRUE)
  idSplits <- split(ids, seq_along(ids) %/% maxRC)

  if (is.null(crs)) {
    crs <- ""
  } else if (is.numeric(crs)) {
    crs <- as.character(crs)
  } else if (isWktID(crs)) {
    crs <- sub(pattern = "^(EPSG|ESRI):", replacement = "", x = crs)
  } else {
    crs <- jsonlite::toJSON(list("wkt" = WKTunPretty(sf::st_crs(crs)$WKT1_ESRI)), auto_unbox=TRUE)
  }

  #Check if pbapply progress bar can be used
  if (!requireNamespace("pbapply", quietly = TRUE) & progress) {
    warning("Package \"pbapply\" needed to use the progress argument. Please install it. Setting `progress` to FALSE.",
         call. = FALSE)
    progress <- FALSE
  }

  if (progress) {
    results <- pbapply::pblapply(idSplits, getEsriFeaturesByIds, queryUrl, fields, token, crs, ...)
  } else {
    results <- lapply(idSplits, getEsriFeaturesByIds, queryUrl, fields, token, crs, ...)
  }

  unlist(results, recursive = FALSE)
}

esri2sfGeom <- function(jsonFeats, geomType, crs = 4326) {
  # convert esri json to simple feature
  geoms <- switch(geomType,
                  esriGeometryPolygon = esri2sfPolygon(jsonFeats),
                  esriGeometryPoint = esri2sfPoint(jsonFeats),
                  esriGeometryPolyline = esri2sfPolyline(jsonFeats)
  )


  #Format CRS
  if (isWktID(crs)) {
    crs <- gsub(pattern = "^(EPSG|ESRI):", replacement = "", x = crs)
    crs <- getWKTidAuthority(crs)
  }


  # attributes
  atts <- lapply(lapply(jsonFeats, `[[`, 1),
                 function(att) lapply(att, function(x) ifelse(is.null(x), NA, x)))

  af <- dplyr::bind_rows(lapply(atts, as.data.frame.list, stringsAsFactors = FALSE))
  # geometry + attributes
  sf::st_sf(geoms, af, crs = crs)
}


getWKTidAuthority <- function(wktID) {

  projPaths <- file.path(sf::sf_proj_search_paths(), "proj.db")
  projDB <- projPaths[file.exists(projPaths)][1]

  con <- DBI::dbConnect(RSQLite::SQLite(), projDB)

  crsData <- DBI::dbGetQuery(con, paste0("SELECT * FROM crs_view WHERE code = '", wktID, "'"))

  DBI::dbDisconnect(con)

  if (nrow(crsData) == 0) {
    stop(paste0("WKTid: ", wktID, " not found in proj.db"))
  }

  if (nrow(crsData) > 1) {
    stop(paste0("WKTid: ", wktID, " has multiple entries in proj.db. Please specify authority (EPSG|ESRI) in crs argument"))
  }

  wktID <- paste0(crsData$auth_name, ":", crsData$code)

  wktID

}

isWktID <- function(crs) {

  is.numeric(crs) || grepl(pattern = "^(EPSG|ESRI):[[:digit:]]+$", x = crs)

}

WKTunPretty <- function(wkt) {

  gsub("\\n[[:blank:]]*", "", wkt)

}
