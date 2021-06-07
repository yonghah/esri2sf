getWKT(wktID)
wktID <- 102698
wktID <- 4326
wktID <- "EPSG:4326"
wktID <- "ESRI:102698"
wktID <- "ESRI:4326"


getWKT <- function(wktID, esri = FALSE) {
  if (esri) {
    url <- paste0("https://epsg.io/", wktID, ".esriwkt")
    wkt <- readLines(con = url, warn = FALSE)
  } else {
    url <- paste0("https://epsg.io/", wktID, ".wkt")
    html <- read_html(url)
    wkt <- html_text(html_element(html, "p"))
  }
  wkt
}


getWKT2 <- function(wktID, esri = FALSE) {

  urlbase <- "https://spatialreference.org/ref"

  if (is.numeric(wktID) | stringr::str_detect(wktID, "^EPSG:[:digit:]+")) {
    if (is.character(wktID)) {
      wktID <- stringr::str_remove(wktID, "^EPSG:")
    }
    url <- file.path(urlbase, "epsg", as.character(wktID))
  } else if (stringr::str_detect(wktID, "^ESRI:[:digit:]+")) {
    wktID <- stringr::str_remove(wktID, "^ESRI:")
    url <- file.path(urlbase, "esri", wktID)
  } else if (stringr::str_detect(wktID, "^SR-ORG:[:digit:]+")) {
    wktID <- stringr::str_remove(wktID, "^SR-ORG:")
    url <- file.path(urlbase, "sr-org", wktID)
  }




}

crs <- 102698
crs <- "EPSG:4326"
crs <- 4326
crs <- "ESRI:4326"
crs <- "ESRI:102698"
# isWktID <- function(crs) {
#
#   is.numeric(crs) | stringr::str_detect(crs, "^(EPSG|ESRI):[:digit:]+")
#
# }
isWktID(crs)


getWKTidAuthority(wktID)




CPL_crs_from_input <- utils::getFromNamespace("CPL_crs_from_input", "sf")
CPL_crs_parameters <- utils::getFromNamespace("CPL_crs_parameters", "sf")
x <- "EPSG:4326"
test <- CPL_crs_from_input(x)
CPL_crs_parameters(test)
str(test)
test$proj4string

