#' Import data from ESRI's ArcGIS Server
#'
#' These functions are the interface to the user.
#'
#' @param url character string for service url, e.g.
#'   <https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/>.
#' @param outFields vector of fields you want to include. default is '*' for all
#'   fields".
#' @param where string for where condition. Default is `1=1` for all rows.
#' @param token string for authentication token (if needed). defaults to `NULL`.
#' @param geomType string specifying the layer geometry ('esriGeometryPolygon'
#'   or 'esriGeometryPoint' or 'esriGeometryPolyline' - if `NULL`, will try to
#'   be inferred from the server)
#' @param crs coordinate reference system (see [sf::st_sf()]). Should either be
#'   `NULL` or a CRS that can be handled by GDAL through sf::st_sf(). Default is
#'   4326. `NULL` returns the feature in the same CRS that the layer is hosted as
#'   in the Feature/Map Server.
#' @param bbox bbox class object from [sf::st_bbox()] or a simple feature object
#'   that can be converted to a bounding box.
#' @param geometry A sf object.
#' @param progress Show progress bar with [pbapply::pblapply()] if `TRUE`. Default
#'   FALSE.
#' @param replaceDomainInfo add domain information to the return dataframe?
#'   Default `TRUE`.
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
                    outFields = c("*"),
                    where = "1=1",
                    bbox = NULL,
                    token = NULL,
                    geomType = NULL,
                    crs = 4326,
                    progress = FALSE,
                    replaceDomainInfo = FALSE,
                    geometry = NULL,
                    ...) {
  layerInfo <- esrimeta(url, token)

  # Get the layer geometry type
  if (is.null(geomType)) {
    if (is.null(layerInfo$geometryType) | (layerInfo$geometryType == "")) {
      cli::cli_alert_warning("geomType is {.val NULL} and a layer geometry type could not be determined from the server.")
      cli::cli_rule("Attempting to download layer with {.fn esri2df}")

      return(esri2df(url = url, outFields = outFields, where = where, token = token, progress = progress, replaceDomainInfo = replaceDomainInfo, ...))
    }

    layerGeomType <- layerInfo$geometryType
  }

  # Get the layer CRS from the layer spatial reference
  layerSR <- layerInfo$extent$spatialReference
  layerCRS <- NULL

  if ("latestWkid" %in% names(layerSR)) {
    layerCRS <- layerSR$latestWkid
  } else if ("wkid" %in% names(layerSR)) {
    layerCRS <- layerSR$wkid
  } else if ("wkt" %in% names(layerSR)) {
    layerCRS <- layerSR$wkt
  }

  if (is.null(layerCRS)) {
    cli::cli_abort("No crs found. Check that the layer at the url has a spatial reference.")
  }

  if (is.null(crs)) {
    crs <- layerCRS
  }

  # Set default geometryType for spatial filter
  geometryType <- NULL

  # Use bbox to set geometry and geometryType
  if (!is.null(bbox)) {
    geometryType <- "esriGeometryEnvelope"
    geometry <- bbox2geometry(bbox = bbox, layerCRS = layerCRS)
  } else if (!is.null(geometry)) {

    # Set geometryType based on geometry type of simple feature
    if (class(geometry) == "bbox") {
      geometryType <- "esriGeometryEnvelope"
      geometry <- bbox2geometry(bbox = bbox, layerCRS = layerCRS)
    } else if ("sf" %in% class(geometry)) {
      geometryType <- sf::st_geometry_type(geometry, by_geometry = FALSE)

      geometryType <-
        switch(geometryType,
          "POINT" = "esriGeometryPoint",
          "MULTIPOLYGON" = "esriGeometryPolygon",
          "MULTIPOINT" = "esriGeometryMultipoint",
          "LINESTRING" = "esriGeometryPolyline",
          "MULTILINESTRING" = "esriGeometryPolyline"
        )

      geometry <- sf2geometry(x = geometry, geometryType = geometryType, layerCRS = layerCRS)
    }
  }

  # Alert user with basic layer information
  cli::cli_alert_success("Downloading {.val {layerInfo$name}}")

  cli::cli_dl(
    items = c(
      "Layer type" = "{.val {layerInfo$type}}",
      "Geometry type" = "{.val {layerInfo$geometryType}}",
      "Service Coordinate Reference System" = "{.val {sf::st_crs(layerCRS)$input}}",
      "Output Coordinate Reference System" = "{.val {sf::st_crs(crs)$input}}"
    )
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
                    outFields = c("*"),
                    where = "1=1",
                    token = NULL,
                    progress = FALSE,
                    replaceDomainInfo = FALSE,
                    ...) {
  layerInfo <- esrimeta(url, token)

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
esrimeta <- function(url, token = "", fields = FALSE, ...) {

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

  if (class(bbox) != "bbox") {
    cli::cli_abort("The provided bbox is not a {.code bbox} class object.")
  }

  if (sf::st_crs(bbox) != layerCRS) {
    bbox <- sf::st_bbox(sf::st_transform(sf::st_as_sfc(bbox), layerCRS))
  }

  geometry <- paste0(unlist(as.list(bbox), use.names = FALSE), collapse = ",")

  return(geometry)
}


#' Helper function for converting simple feature object to geometry parameter for spatial filter
#'
#' Currently only supports sf objects with POINT geometry.
#'
#' @noRd
#' @importFrom sf st_transform st_coordinates
#' @importFrom cli cli_abort
sf2geometry <- function(x, geometryType, layerCRS) {
  x <- sf::st_transform(x, layerCRS)

  if (geometryType == "esriGeometryPoint") {
    x <- sf::st_coordinates(x)
    geometry <- paste0(x, collapse = ",")
  } else {
    cli::cli_abort("The {.arg geometry} parameter currently only supports bounding boxes or simple feature POINT objects.")
  }

  return(geometry)
}
