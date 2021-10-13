#' @title Get parts of the Map/Feature Server URL
#'
#' @description A collection of functions that pull select parts out of a
#'   Map/Feature Server URL.
#'
#' @param url The url for a Map/Feature server or for a layer/table in a
#'   Map/Feature Server.
#'
#' @return Character string of the request part of the url.
#'
#' @describeIn urlParts Full Map/Feature Server URL
#' @export
urlParts_urlServer <- function(url) {
  return(sub("/[[:digit:]]+$", '', url))
}

#' @describeIn urlParts URL host
#' @export
urlParts_host <- function(url) {
  return(unlist(strsplit(sub("https://|http://", "", url), "/"))[1])
}

#' @describeIn urlParts URL instance
#' @export
urlParts_instance <- function(url) {
  return(unlist(strsplit(sub("https://|http://", "", url), "/"))[2])
}

#' @describeIn urlParts URL folder(s)
#' @export
urlParts_folder <- function(url) {
  folderService <- unlist(strsplit(sub("/MapServer.*|/FeatureServer.*", "", sub(".*/rest/services/", "", url)), "/"))
  if (length(folderService) > 1) {
    out <- paste0(folderService[-length(folderService)], collapse = "/")
  } else {
    out <- ""
  }
  return(out)
}

#' @describeIn urlParts URL service
#' @export
urlParts_service <- function(url) {
  serviceSplit <- unlist(strsplit(sub("/MapServer.*|/FeatureServer.*", "", url), "/"))
  return(serviceSplit[length(serviceSplit)])
}

#' @describeIn urlParts Layer/Table ID
#' @export
urlParts_layerID <- function(url) {
  return(as.integer(regmatches(url, regexpr("[0-9]+$",url))))
}
