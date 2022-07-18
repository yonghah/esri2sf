#' Convert esri geometry features to sfc objects
#'
#' @noRd
#' @importFrom dplyr bind_rows
#' @importFrom sf st_crs st_sf
esri2sfGeom <- function(jsonFeats, layerGeomType, crs = 4326) {
  # convert esri json to simple feature
  geoms <- switch(layerGeomType,
    esriGeometryPolygon = esri2sfPolygon(jsonFeats),
    esriGeometryPoint = esri2sfPoint(jsonFeats),
    esriGeometryPolyline = esri2sfPolyline(jsonFeats)
  )

  # Format CRS
  if (isWktID(crs)) {
    crs <- sf::st_crs(crs)$srid
  }

  # attributes
  atts <-
    lapply(
      lapply(jsonFeats, `[[`, 1),
      function(att) lapply(att, function(x) ifelse(is.null(x), NA, x))
    )

  af <- dplyr::bind_rows(lapply(atts, as.data.frame.list, stringsAsFactors = FALSE))

  # combine geometry and attributes
  sf::st_sf(geoms, af, crs = crs)
}



#' Convert esriGeometryPoint to sfc MULTIPOINT
#'
#' @noRd
#' @importFrom sf st_point st_sfc
esri2sfPoint <- function(features) {
  getPointGeometry <- function(feature) {
    if (is.numeric(unlist(feature$geometry))) {
      sf::st_point(unlist(feature$geometry))
    } else {
      sf::st_point()
    }
  }
  sf::st_sfc(lapply(features, getPointGeometry))
}

#' Convert esriGeometryPolygon to sfc MULTIPOLYGON
#'
#' @noRd
#' @importFrom sf st_multipolygon st_sfc
esri2sfPolygon <- function(features) {
  ring2matrix <- function(ring) do.call(rbind, lapply(ring, unlist))
  rings2multipoly <- function(rings) {
    sf::st_multipolygon(list(lapply(rings, ring2matrix)))
  }

  getGeometry <- function(feature) {
    if (is.null(unlist(feature$geometry$rings))) {
      sf::st_multipolygon()
    } else {
      rings2multipoly(feature$geometry$rings)
    }
  }

  sf::st_sfc(lapply(features, getGeometry))
}

#' Convert esriGeometryPolyline to sfc MULTILINESTRING
#'
#' @noRd
#' @importFrom sf st_multilinestring st_sfc
esri2sfPolyline <- function(features) {
  path2matrix <- function(path) do.call(rbind, lapply(path, unlist))
  paths2multiline <- function(paths) sf::st_multilinestring(lapply(paths, path2matrix))

  getGeometry <- function(feature) paths2multiline(feature$geometry$paths)

  sf::st_sfc(lapply(features, getGeometry))
}
