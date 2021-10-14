#' @title Get parts of the Map/Feature Server URL
#'
#' @description A collection of functions that pull select parts out of a
#'   Map/Feature Server URL. All urls should be a form similar to:
#' * `https://<host>/<instance>/rest/services/<folderName>/serviceName>/MapServer/<id>`
#' * `http://<host>/<instance>/rest/services/serviceName>/MapServer`
#' * `<host>/<instance>/rest/services/<folderName>/serviceName>/FeatureServer`
#' * `https://<host>/<instance>/rest/services/serviceName>/FeatureServer/<id>`
#' And having these rules:
#'  * The `https://` or `http://` part is optional
#'  * The `host` part is the domain of the url.
#'  * The `instance`  is the first subpage after the domain in the url.
#'  * The `/rest/services` is the second and third subpage in the url. These are standard for all ESRI REST Services.
#'  * The `folderName` part is optional and indicates the file structure in the REST Service. It consists of all subpages between `/rest/services/` and the `serviceName` part.
#'  * The `serviceName` part is the last subpage betore the `/Mapserver` or `/FeatureServer` in the url.
#'  * `/Mapserver` or `/FeatureServer` specifies whether the file is a map or feature service.
#'  * The `id` is optional and specifies the layer or table in the map service.
#'
#'
#' @param url The url for a Map/Feature server or for a layer/table in a
#'   Map/Feature Server.
#'
#' @return Character string of the request part of the url.
#'
#' @describeIn urlParts Full Map/Feature Server URL
#' @export
urlParts_urlServer <- function(url) {
  urlNoLayerID <- sub("/[[:digit:]]+$|/$", '', url)
  if (!grepl(".*/MapServer$|.*/FeatureServer$", urlNoLayerID)) stop("Url does not end in '/MapServer' or '/FeatureServer'.")
  return(urlNoLayerID)
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
urlParts_folderName <- function(url) {
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

#' @describeIn urlParts Check if url is valid for an ESRI REST Service
#' @export
urlParts_isValid <- function(url) {
  # check for /rest/services
  if (!grepl("/rest/services", url)) stop("'/rest/services' not found in the url.")
  # check for /MapServer or /FeatureServer
  if (!grepl("/MapServer|/FeatureServer", url)) stop("'/MapServer' or '/FeatureServer not found in the url.")
  # check url succeeds
  if (httr::http_error(url)) stop("Could not access url with {httr}.")
  # check if error on page (url succeeds but ESRI still has error)
  if (!is.na(rvest::html_element(rvest::read_html(url), 'div.restErrors'))) stop(sub("^[[:space:]]*", "", rvest::html_text(rvest::html_element(rvest::read_html(url), 'div.restErrors'))))
  TRUE
}

# urlParts_isValidID
# urlParts_isValidService
