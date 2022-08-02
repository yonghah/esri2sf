#' Import data from ArcGIS ImageServer url using the exportImage API
#'
#' @noRd
#' @param url ImageServer url
#' @param bbox Bounding box for image to return; defaults to `NULL`.
#' @param token defaults to `NULL`.
#' @param format defaults to "jpgpng"
#' @param adjustAspectRatio defaults to `FALSE`
esri2rast <- function(url,
                      bbox = NULL,
                      token = NULL,
                      format = "jpgpng",
                      adjustAspectRatio = FALSE,
                      ...) {
  if (!requireNamespace("terra", quietly = TRUE)) {
    cli::cli_abort("The {.pkg terra} package is not installed.")
  }

  layerInfo <- esrimeta(url = url, token = token)

  layerCRS <- getLayerCRS(spatialReference = layerInfo$extent$spatialReference)

  if (sf::st_crs(bbox) != sf::st_crs(layerCRS)) {
    bbox <- sf::st_transform(bbox, layerCRS)
  }

  esriEnvelope <-
    sf2geometry(
      x = bbox,
      geometryType = "esriEnvelope",
      layerCRS = layerCRS
    )

  req <-
    esriRequest(
      url = url,
      append = "exportImage",
      bbox = esriEnvelope,
      format = format,
      f = "image",
      adjustAspectRatio = adjustAspectRatio,
      .perform = FALSE,
      ...
    )

  ras <- terra::rast(req$url)

  terra::ext(ras) <- as.numeric(bbox)

  return(ras)
}
