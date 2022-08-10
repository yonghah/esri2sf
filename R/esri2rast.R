#' Import data from ArcGIS ImageServer url using the exportImage API
#'
#' See the ArcGIS REST API documentation for more information on the exportImage
#' API
#' <https://developers.arcgis.com/rest/services-reference/enterprise/export-image.htm>
#'
#' @noRd
#' @param url ImageServer url
#' @param bbox Bounding box for image to return; defaults to `NULL`.
#' @param token defaults to `NULL`.
#' @param format defaults to "jpgpng". Options include "jpgpng", "png", "png8",
#'   "png24", "jpg", "bmp", "gif", "tiff", "png32", "bip", "bsq", and "lerc"
#' @param adjustAspectRatio defaults to `FALSE`
#' @return SpatRaster object from `terra::rast`
esri2rast <- function(url,
                      bbox = NULL,
                      token = NULL,
                      format = "jpgpng",
                      adjustAspectRatio = FALSE,
                      ...) {
  if (!requireNamespace("terra", quietly = TRUE)) {
    cli::cli_abort("{.pkg terra} must be installed to use {.fn esri2rast}.")
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

  format <-
    match.arg(
      tolower(format),
      c("jpgpng", "png", "png8", "png24", "jpg", "bmp",
        "gif", "tiff", "png32", "bip", "bsq", "lerc")
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

  ras
}
