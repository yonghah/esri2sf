#' Import data from ESRI's ArcGIS Server
#'
#' These functions are the interface to the user.
#'
#' @param url character string for service url, e.g. <https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/>.
#' @param outFields vector of fields you want to include. default is '*' for all fields".
#' @param where string for where condition. Default is `1=1` for all rows.
#' @param token string for authentication token (if needed).
#' @param geomType string specifying the layer geometry ('esriGeometryPolygon' or 'esriGeometryPoint' or 'esriGeometryPolyline' - if `NULL`, will try to be inferred from the server)
#' @param crs coordinate reference system (see [sf::st_sf()]). Should either be NULL, a numeric WKTid, or a 'EPSG:' or 'ESRI:' prefixed WKTid. Default is 4326. NULL returns the feature in the same CRS that the layer is hosted as in the Feature/Map Server. The handling of custom projstiring or WKT CRS's needs additional functionality built in from the GDAL package.
#' @param bbox bbox class object from [sf::st_bbox()].
#' @param ... additional named parameters to pass to the query. ex) "resultRecordCount = 3"
#' @return sf dataframe (`esri2sf`) or tibble dataframe (`esri2df`).
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

esri2sf <- function(url, outFields = c("*"), where = "1=1", bbox = NULL, token = "",
                    geomType = NULL, crs = 4326, ...) {
  layerInfo <- jsonlite::fromJSON(content(POST(url, query = list(f = "json",
                                                                 token = token), encode = "form", config = config(ssl_verifypeer = FALSE)),
                                          as = "text"))
  print(layerInfo$type)
  if (is.null(geomType)) {
    if (is.null(layerInfo$geometryType))
      stop("geomType is NULL and layer geometry type ('esriGeometryPolygon' or 'esriGeometryPoint' or 'esriGeometryPolyline') could not be inferred from server.")

    geomType <- layerInfo$geometryType
  }

  print(geomType)

  if (!is.null(layerInfo$extent$spatialReference$latestWkid)) {
    layerCRS <- layerInfo$extent$spatialReference$latestWkid
  } else if (!is.null(layerInfo$extent$spatialReference$wkid)) {
    layerCRS <- layerInfo$extent$spatialReference$wkid
  } else if (!is.null(layerInfo$extent$spatialReference$wkt)) {
    layerCRS <- layerInfo$extent$spatialReference$wkt
  } else {
    stop("No crs found. Check that layer at url has a Spatial Reference.")
  }
  print(paste0("Coordinate Reference System: ", layerCRS))

  if (class(bbox) == "bbox") {
    if ((sf::st_crs(bbox)$input != layerCRS) && !is.null(layerCRS)) {
      bbox <- sf::st_bbox(sf::st_transform(sf::st_as_sfc(bbox), layerCRS))
    }
  } else if (!is.null(bbox)) {
    stop("The provided bbox must be a class bbox object.")
  }

  bbox <- paste0(unlist(as.list(bbox), use.names=FALSE), collapse = ",")

  queryUrl <- paste(url, "query", sep = "/")
  esriFeatures <- getEsriFeatures(queryUrl, outFields, where, bbox, token, crs, ...)

  if (is.null(crs)) {
    crs <- layerCRS
  }

  esri2sfGeom(esriFeatures, geomType, crs)
}

#' @describeIn esri2sf Retrieve table object (no spatial data).
#' @export
esri2df <- function(url, outFields = c("*"), where = "1=1", token = "", ...) {
  layerInfo <- fromJSON(content(
    POST(url,
         query = list(f = "json", token = token),
         encode = "form",
         config = config(ssl_verifypeer = FALSE)
    ), as = "text"))

  print(layerInfo$type)
  if (layerInfo$type != "Table") stop("Layer type for URL is not 'Table'.")

  queryUrl <- paste(url, "query", sep = "/")
  esriFeatures <- getEsriFeatures(queryUrl, outFields, where, token)  #, ...)
  getEsriTable(esriFeatures)
}
