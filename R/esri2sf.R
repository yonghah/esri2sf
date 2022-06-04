#' Import data from ESRI's ArcGIS Server
#'
#' These functions are the interface to the user.
#'
#' @param url character string for service url, e.g.
#'   <https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/>.
#'
#' @param outFields vector of fields you want to include. default is `NULL` for
#'   all fields.
#' @param where string for where condition. Default is `NULL` for all rows.
#' @param token string for authentication token (if needed). defaults to `NULL`.
#' @param geomType string specifying the layer geometry ('esriGeometryPolygon'
#'   or 'esriGeometryPoint' or 'esriGeometryPolyline' - if `NULL`, will try to
#'   be inferred from the server)
#' @param crs coordinate reference system (see [sf::st_sf()]). Should either be
#'   `NULL` or a CRS that can be handled by GDAL through sf::st_sf(). Default is
#'   4326. `NULL` returns the feature in the same CRS that the layer is hosted
#'   as in the Feature/Map Server.
#' @param bbox bbox class object from [sf::st_bbox()] or a simple feature object
#'   that can be converted to a bounding box.
#' @param geometry An `sf` or `bbox` object. Only sf objects a single `POINT`
#'   feature are currently supported.
#' @param progress Show progress bar with [pbapply::pblapply()] if `TRUE`.
#'   Default FALSE.
#' @param replaceDomainInfo If `TRUE`, add domain information to the return data frame.
#'   Default `FALSE`.
#' @param ... additional named parameters to pass to the query. (e.g.
#'   `"resultRecordCount = 3"`)
#' @return sf dataframe (`esri2sf`) or tibble dataframe (`esri2df`) or list or
#'   dataframe (`esrimeta`).
#'
#' @describeIn esri2sf Retrieve spatial object
#'
#' @note When accessing services with multiple layers, the layer number must be
#' specified at the end of the service url (e.g.,
#' <https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/3>).
#' #' The list of layers and their respective id numbers can be found by viewing
#' the service's url in a web browser and viewing the "Layers" heading (e.g.,
#' <https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/#mapLayerList>).
#'
#' @examples
#' baseURL <- "https://sampleserver1.arcgisonline.com/ArcGIS/rest/"
#' url <- paste0(baseURL, "services/Demographics/ESRI_Census_USA/MapServer/3")
#' outFields <- c("POP2007", "POP2000")
#' where <- "STATE_NAME = 'Michigan'"
#' df <- esri2sf(url, outFields = outFields, where = where)
#' plot(df)
#'
#' @export
#' @importFrom cli cli_alert_warning cli_rule cli_abort cli_alert_success cli_dl
#' @importFrom sf st_geometry_type

esri2sf <- function(url,
                    outFields = NULL,
                    where = NULL,
                    bbox = NULL,
                    token = NULL,
                    geomType = NULL,
                    crs = 4326,
                    progress = FALSE,
                    replaceDomainInfo = FALSE,
                    geometry = NULL,
                    ...) {
  layerInfo <- esrimeta(url = url, token = token)

  # Share basic layer information
  cli::cli_alert_success("Downloading {.val {layerInfo$name}} from {.url {url}}")

  # Get the layer geometry type
  if (is.null(geomType)) {
    if (is.null(layerInfo$geometryType) | (layerInfo$geometryType == "")) {
      cli::cli_alert_warning("geomType is {.val NULL} and a layer geometry type could not be determined from the server.")
      cli::cli_rule("Attempting to download layer with {.fn esri2df}")

      return(esri2df(url = url, outFields = outFields, where = where, token = token, progress = progress, replaceDomainInfo = replaceDomainInfo, ...))
    }

    layerGeomType <- layerInfo$geometryType
  } else {
    if ((!is.null(layerInfo$geometryType)) && (layerInfo$geometryType != geomType)) {
      cli::cli_alert_warning(
        "The provided {.arg geomType} value {.val {geomType}} does not match the layer geometryType value {.val {layerInfo$geometryType}}."
      )
    }

    layerGeomType <- geomType
  }

  cli::cli_dl(
    items = c(
      "Layer type" = "{.val {layerInfo$type}}",
      "Geometry type" = "{.val {layerGeomType}}"
    )
  )

  if (!is.null(layerInfo$extent$spatialReference)) {
    layerCRS <-
      getLayerCRS(spatialReference = layerInfo$extent$spatialReference)

    layerCRS_missing <- FALSE
  } else {
    cli::cli_alert_warning(
      "The spatial reference for this layer is missing."
    )

    if (!is.null(crs)) {
      cli::cli_alert_info(
        "Attempting to access the layer using the provided {.arg crs} value {.val {crs}}."
      )

      layerCRS_missing <- TRUE
      layerCRS <- crs
    }
  }

  if (is.null(crs)) {
    crs <- layerCRS
  }

  # Set default geometryType for spatial filter
  geometryType <- NULL

  # Use bbox to set geometry and geometryType
  if (!is.null(bbox)) {
    if ("sf" %in% class(bbox)) {
      bbox <- sf::st_bbox(bbox)
    }

    if (!("bbox" %in% class(bbox))) {
      cli::cli_abort("The provided bbox is not a {.code bbox} or {.code sf} class object.")
    }

    geometry <- bbox
  }

  if (!is.null(geometry)) {
    # Set geometryType based on geometry type of simple feature
    geometryType <-
      sf2geometryType(
        x = geometry
      )

    geometry <-
      sf2geometry(
        x = geometry,
        geometryType = geometryType,
        layerCRS = layerCRS
      )
  }

  if (!layerCRS_missing) {
    cli::cli_dl(c("Service Coordinate Reference System" = "{.val {sf::st_crs(layerCRS)$input}}"))
  }

  cli::cli_dl(
    c("Output Coordinate Reference System" = "{.val {sf::st_crs(crs)$input}}")
  )

  # Get layer features
  esriFeatures <-
    getEsriFeatures(
      url = url,
      fields = outFields,
      where = where,
      geometry = geometry,
      geometryType = geometryType,
      token = token,
      crs = crs,
      progress = progress,
      ...
    )

  # Convert geometry to simple features
  sfdf <-
    esri2sfGeom(
      jsonFeats = esriFeatures,
      layerGeomType = layerGeomType,
      crs = crs
    )

  if (replaceDomainInfo & nrow(sfdf) > 0) {
    sfdf <- addDomainInfo(sfdf, url = url, token = token)
  }

  return(sfdf)
}


#' @describeIn esri2sf Retrieve table object (no spatial data).
#' @export
#' @importFrom cli cli_alert_warning cli_rule cli_alert_success cli_dl
esri2df <- function(url,
                    outFields = NULL,
                    where = NULL,
                    token = NULL,
                    progress = FALSE,
                    replaceDomainInfo = FALSE,
                    ...) {
  layerInfo <- esrimeta(url = url, token = token)

  if (layerInfo$type != "Table") {
    cli::cli_alert_warning("The provided layer {.var {layerInfo$name}} is not a {.val 'table'}.")
    cli::cli_rule("Attempting to download layer with {.fn esri2sf}")
    return(esri2sf(url = url, outFields = outFields, where = where, token = token, progress = progress, replaceDomainInfo = replaceDomainInfo, ...))
  }

  cli::cli_alert_success("Downloading {.val {layerInfo$name}}")

  cli::cli_dl(
    items = c("Layer type" = "{.val {layerInfo$type}}")
  )

  esriFeatures <-
    getEsriFeatures(
      url = url,
      fields = outFields,
      where = where,
      token = token,
      progress = progress,
      ...
    )
  df <- getEsriTable(esriFeatures)
  if (replaceDomainInfo & nrow(df) > 0) {
    df <- addDomainInfo(df, url = url, token = token)
  }

  return(df)
}


#' Retrieve layer metadata
#'
#' @name esrimeta
#' @param url url to retrieve metadata for.
#' @inheritParams esriRequest
#' @param fields `esrimeta` returns data frame with fields if `TRUE`. Default
#'   `FALSE`.
#' @export
#' @importFrom dplyr bind_rows
esrimeta <- function(url, token = NULL, fields = FALSE, ...) {

  # FIXME: esriRequest should be able to handle url error messages so url checks should be simplified.
  # make sure url is valid and error otherwise
  # tryCatch(
  #  {
  #    esriUrl_isValid(url, token = token, displayReason = TRUE)
  #  },
  #  message = function(m) {
  #    stop(m$message)
  #  }
  # )

  layerInfo <- esriCatalog(url = url, token = token, ...)

  if (fields) {
    return(dplyr::bind_rows(layerInfo$fields))
  } else {
    return(layerInfo)
  }
}



#' Helper function for getting layer CRS based on spatialReference
#'
#' @noRd
#' @importFrom cli cli_abort
getLayerCRS <- function(spatialReference, layerCRS = NULL) {

  # Get the layer CRS from the layer spatial reference
  if ("latestWkid" %in% names(spatialReference)) {
    layerCRS <- spatialReference$latestWkid
  } else if ("wkid" %in% names(spatialReference)) {
    layerCRS <- spatialReference$wkid
  } else if ("wkt" %in% names(spatialReference)) {
    layerCRS <- spatialReference$wkt
  }

  # Format CRS (from esri2sfGeom)
  if (isWktID(layerCRS)) {
    layerCRS <- gsub(pattern = "^(EPSG|ESRI):", replacement = "", x = layerCRS)
    layerCRS <- getWKTidAuthority(layerCRS)
  }

  if (is.null(layerCRS)) {
    cli::cli_abort("No crs found. Check that the layer at the url has a spatial reference.")
  }

  return(layerCRS)
}

sf2geometryType <- function(x, by_geometry = FALSE) {
  if ("bbox" %in% class(x)) {
    return("esriGeometryEnvelope")
  }

  if (!("sf" %in% class(x))) {
    cli::cli_abort("geometry must be a sf or bbox object")
  }

  geometryType <- sf::st_geometry_type(x, by_geometry = by_geometry)

  switch(as.character(geometryType),
    "POINT" = "esriGeometryPoint",
    "MULTIPOLYGON" = "esriGeometryPolygon",
    "MULTIPOINT" = "esriGeometryMultipoint",
    "LINESTRING" = "esriGeometryPolyline",
    "MULTILINESTRING" = "esriGeometryPolyline"
  )
}

#' Helper function for converting simple feature object to geometry parameter for spatial filter
#'
#' Currently only supports sf objects with POINT geometry.
#'
#' @noRd
#' @importFrom sf st_transform st_coordinates
#' @importFrom cli cli_abort
sf2geometry <- function(x, geometryType = NULL, layerCRS = NULL) {
  if ("bbox" %in% class(x)) {
    x <- sf::st_sf(sf::st_as_sfc(x))
  }

  if (!is.null(layerCRS)) {
    x <- sf::st_transform(x, layerCRS)
  }

  geometry <-
    switch(geometryType,
      "esriGeometryEnvelope" = paste0(unlist(as.list(x), use.names = FALSE), collapse = ","),
      "esriGeometryPoint" = paste0(sf::st_coordinates(x), collapse = ",")
    )

  if (is.null(geometryType)) {
    cli::cli_abort("The {.arg geometry} parameter currently only supports bounding boxes or simple feature POINT objects.")
  }

  return(geometry)
}


#' Helper function for converting bounding box to geometry parameter for spatial filter
#'
#' Supports conversion of simple feature to bounding box objects
#'
#' @noRd
#' @importFrom sf st_bbox st_union st_crs st_transform st_as_sfc
#' @importFrom cli cli_abort
bbox2geometry <- function(bbox, layerCRS) {
  if ("sf" %in% class(bbox)) {
    bbox <- sf::st_bbox(sf::st_union(bbox))
  }

  if (sf::st_crs(bbox) != layerCRS) {
    bbox <- sf::st_bbox(sf::st_transform(sf::st_as_sfc(bbox), layerCRS))
  }

  geometry <- paste0(unlist(as.list(bbox), use.names = FALSE), collapse = ",")

  return(geometry)
}
