#' Import data from ESRI's ArcGIS Server
#'
#' These functions are the interface to the user.
#'
#' @param url character string for service url, e.g.
#'   <https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/>.
#'
#' @param outFields vector of fields you want to include. default is `NULL` for
#'   all fields.
#' @param where string for where condition. Default is `NULL` (equivalent to
#'   `1=1`) to return all rows.
#' @param token string for authentication token. defaults to `NULL`.
#' @param crs coordinate reference system (see [sf::st_sf()]). Should either be
#'   `NULL` or a CRS that can be handled by GDAL through sf::st_sf(). Default is
#'   `getOption("esri2sf.crs", 4326)` which sets the CRS to EPSG:4326 if no option
#'   is set. If CRS is `NULL` feature is returned with the same CRS that the
#'   layer is hosted as in the Feature/Map Server.
#' @param bbox bbox class object from [sf::st_bbox()] or a simple feature object
#'   that can be converted to a bounding box.
#' @param geometry An `sf` or `bbox` object. Currently, `sf` objects with a single
#'   POINT feature are supported. All other `sf` objects are converted to `bbox`
#'   objects.
#' @param progress Show progress bar from [cli::cli_progress_along()] if `TRUE`.
#'   Default `FALSE`.
#' @param geomType string specifying the layer geometry ('esriGeometryPolygon'
#'   or 'esriGeometryPoint' or 'esriGeometryPolyline' - if `NULL`, will try to
#'   be inferred from the server)
#' @param spatialRel Spatial relationship applied to the input `geometry` when
#'   performing the query; defaults to `NULL` (equivalent to
#'   "esriSpatialRelIntersects"). Additional supported options include
#'   "esriSpatialRelContains", "esriSpatialRelCrosses",
#'   "esriSpatialRelEnvelopeIntersects", "esriSpatialRelIndexIntersects",
#'   "esriSpatialRelOverlaps", "esriSpatialRelTouches", "esriSpatialRelWithin"
#' @param replaceDomainInfo If `TRUE`, add domain information to the return data frame.
#'   Default `FALSE`.
#' @param ... additional named parameters to pass to the query. (e.g.
#'   `"resultRecordCount = 3"`). See the [ArcGIS REST APIs
#'   documentation](https://developers.arcgis.com/rest/services-reference/enterprise/query-map-service-layer-.htm)
#'   for more information on all supported parameters.
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
#' @importFrom cli cli_inform cli_rule cli_abort cli_alert_success cli_dl
#' @importFrom sf st_geometry_type
esri2sf <- function(url,
                    outFields = NULL,
                    where = NULL,
                    geometry = NULL,
                    bbox = NULL,
                    token = NULL,
                    crs = getOption("esri2sf.crs", 4326),
                    progress = FALSE,
                    geomType = NULL,
                    spatialRel = NULL,
                    replaceDomainInfo = FALSE,
                    ...) {
  layerInfo <- esrimeta(url = url, token = token)

  # Share basic layer information
  cli::cli_inform(
    c("v" = "Downloading {.val {layerInfo$name}} from {.url {url}}")
  )

  # Get the layer geometry type
  if (is.null(geomType)) {
    if (is_missing_geomType(layerInfo)) {
      cli::cli_inform(
        c("!" = "geomType is {.val NULL} and a layer geometry type can't be found for this url.")
      )

      cli::cli_rule("Attempting to download layer with {.fn esri2df}")

      return(
        esri2df(
          url = url,
          outFields = outFields,
          where = where,
          token = token,
          progress = progress,
          replaceDomainInfo = replaceDomainInfo,
          ...
        )
      )
    }

    layerGeomType <- layerInfo$geometryType
  } else {
    if ((!is.null(layerInfo$geometryType)) && (layerInfo$geometryType != geomType)) {
      cli::cli_inform(
        c("!" = "The provided {.arg geomType} value {.val {geomType}} does not
          match the layer geometryType value {.val {layerInfo$geometryType}}.")
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

    cli::cli_dl(
      c("Service Coordinate Reference System" = "{.val {sf::st_crs(layerCRS)$input}}")
    )
  } else {
    cli::cli_inform(
      c("!" = "The spatial reference for this layer is missing.")
    )

    if (!is.null(crs)) {
      cli::cli_inform(
        c("i" = "Trying to access the layer using the provided {.arg crs}: {.val {crs}}.")
      )

      layerCRS <- crs
    }
  }

  if (is.null(crs)) {
    crs <- layerCRS
  }

  if (!is.null(bbox)) {
    geometry <- bbox2geometry(bbox)
  }

  # Set default geometryType for spatial filter
  geometryType <- NULL

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

  cli::cli_dl(
    c("Output Coordinate Reference System" = "{.val {sf::st_crs(crs)$input}}")
  )

  if (!is.null(spatialRel)) {
    spatialRel_opts <-
      c(
        "esriSpatialRelIntersects", "esriSpatialRelContains",
        "esriSpatialRelCrosses", "esriSpatialRelEnvelopeIntersects",
        "esriSpatialRelIndexIntersects", "esriSpatialRelOverlaps",
        "esriSpatialRelTouches", "esriSpatialRelWithin"
      )

    spatialRel <-
      match.arg(
        spatialRel,
        spatialRel_opts
      )
  }

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
      spatialRel = spatialRel,
      ...
    )

  # Convert geometry to simple features
  sfdf <-
    esri2sfGeom(
      jsonFeats = esriFeatures,
      layerGeomType = layerGeomType,
      crs = crs
    )

  if (!replaceDomainInfo) {
    return(sfdf)
  }

  addDomainInfo(sfdf, url = url, token = token)
}

#' Is layerInfo missing geometryType?
#'
#' @noRd
is_missing_geomType <- function(layerInfo) {
  any(c(is.null(layerInfo$geometryType), (layerInfo$geometryType == "")))
}

#' @describeIn esri2sf Retrieve table object (no spatial data).
#' @export
#' @importFrom cli cli_warn cli_rule cli_inform cli_dl
esri2df <- function(url,
                    outFields = NULL,
                    where = NULL,
                    token = NULL,
                    progress = FALSE,
                    replaceDomainInfo = FALSE,
                    ...) {
  layerInfo <- esrimeta(url = url, token = token)

  if (!is.null(layerInfo$type) && layerInfo$type != "Table") {
    cli::cli_warn(
      "The provided layer {.var {layerInfo$name}} is not a {.val 'table'}."
    )

    cli::cli_rule("Attempting to download layer with {.fn esri2sf}")
    return(
      esri2sf(
        url = url,
        outFields = outFields,
        where = where,
        token = token,
        progress = progress,
        replaceDomainInfo = replaceDomainInfo,
        ...
      )
    )
  }

  cli::cli_inform(c("v" = "Downloading {.val {layerInfo$name}}"))

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

  if (!replaceDomainInfo) {
    return(df)
  }

  addDomainInfo(df, url = url, token = token)
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
  layerInfo <-
    esriCatalog(url = url, token = token, simplifyVector = TRUE, ...)

  if (!fields) {
    return(layerInfo)
  }

  dplyr::bind_rows(layerInfo$fields)
}


#' Helper function for getting layer CRS based on spatialReference
#'
#' @noRd
#' @importFrom sf st_crs
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
    layerCRS <- sf::st_crs(layerCRS)$srid
  }

  if (is.null(layerCRS)) {
    cli::cli_abort(
      "Valid layer coordinate reference system can't be found.",
      "*" = "Check that the layer at the url has a spatial reference."
    )
  }

  layerCRS
}


#' Helper function for setting geometryType based on geometry parameter
#'
#' @noRd
#' @importFrom cli cli_abort
sf2geometryType <- function(x, by_geometry = FALSE) {
  if (inherits(x, "bbox")) {
    return("esriGeometryEnvelope")
  } else if (inherits(x, "sf")) {
    geometryType <- sf::st_geometry_type(x, by_geometry = by_geometry)

    return(
      switch(as.character(geometryType),
        "POINT" = "esriGeometryPoint",
        "MULTIPOLYGON" = "esriGeometryPolygon",
        "MULTIPOINT" = "esriGeometryMultipoint",
        "LINESTRING" = "esriGeometryPolyline",
        "MULTILINESTRING" = "esriGeometryPolyline"
      )
    )
  }

  cli::cli_abort("{.arg geometry} must be a sf or bbox object.")
}


#' Helper function for converting simple feature object to geometry parameter
#' for spatial filter
#'
#' Currently only supports sf objects with POINT geometry. All other sf or bbox
#' objects are converted to a bbox.
#'
#' @noRd
#' @importFrom sf st_sf st_as_sfc st_transform st_bbox st_coordinates
#' @importFrom cli cli_abort
sf2geometry <- function(x, geometryType = NULL, layerCRS = NULL) {
  if (!is.null(layerCRS)) {
    if (inherits(x, "bbox")) {
      x <- sf::st_sf(sf::st_as_sfc(x))
    }
    x <- sf::st_transform(x, layerCRS)
  }

  if (!(sf::st_geometry_type(x, by_geometry = FALSE) == "POINT")) {
    x <- sf::st_bbox(x)
    geometryType <- "esriGeometryEnvelope"
  }

  switch(geometryType,
    "esriGeometryEnvelope" = paste0(
      unlist(as.list(x), use.names = FALSE),
      collapse = ","
    ),
    "esriGeometryPoint" = paste0(
      sf::st_coordinates(x),
      collapse = ","
    )
  )
}

#' Helper to convert bbox to sf or error on non-sf and non-bbox objects
#'
#' @noRd
bbox2geometry <- function(bbox) {
  # convert sf class bbox to bbox class
  if (inherits(bbox, "sf")) {
    bbox <- sf::st_bbox(sf::st_union(bbox))
  }

  if (!inherits(bbox, "bbox")) {
    cli::cli_abort(
      c("{.arg bbox} must be a {.code bbox} or {.code sf} class object.",
        "i" = "The class of the provided {.arg bbox} is {.val {class(bbox)}}"
      )
    )
  }

  bbox
}
