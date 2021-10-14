#' @title Get parts of the Map/Feature Server URL
#'
#' @description A collection of functions that pull select parts out of a
#'   Map/Feature Server URL. All urls should be a form similar to:
#' * `https://<host>/<instance>/rest/services/<folderName>/serviceName>/MapServer/<id>`
#' * `http://<host>/<instance>/rest/services/serviceName>/MapServer`
#' * `<host>/<instance>/rest/services/<folderName>/serviceName>/FeatureServer`
#' * `https://<host>/<instance>/rest/services/serviceName>/FeatureServer/<id>`
#' And having these rules:
#'  * The scheme: `https://` or `http://` part is optional
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
#' @param displayReason Should the reason for why a url is not valid be displayed.
#'
#' @return Character string of the request part of the url.
#'
#' @describeIn esriUrl Full Map/Feature Server URL
#' @export
esriUrl_ServerUrl <- function(url) {
  #Cut off layerID if present
  urlNoLayerID <- sub("/[[:digit:]]+$|/$", '', url)

  #make sure url is valid service and error otherwise
  tryCatch(
    {
      esriUrl_isValidService(urlNoLayerID, displayReason = TRUE)
    }, message = function(m) {
      stop(m$message)
    }
  )

  return(urlNoLayerID)
}

#' @describeIn esriUrl Parse Url into parts.
#' @export
esriUrl_parseUrl <- function(url) {
  #make sure url is valid and error otherwise
  tryCatch(
    {
      esriUrl_isValid(url, displayReason = TRUE)
    }, message = function(m) {
      stop(m$message)
    }
  )
  scheme <- regmatches(url, regexpr("^https://|^http://",url))
  host <- unlist(strsplit(sub(scheme, "", url), "/"))[1]
  instance <- sub("/rest/services.*", "", sub(paste0(".*",host, '/'), "", url))
  folderService <- unlist(strsplit(sub("/MapServer.*|/FeatureServer.*", "", sub(".*/rest/services/", "", url)), "/"))
  if (length(folderService) > 1) {
    folderName <- paste0(folderService[-length(folderService)], collapse = "/")
  } else {
    folderName <- ""
  }
  serviceSplit <- unlist(strsplit(sub("/MapServer.*|/FeatureServer.*", "", url), "/"))
  serviceName <- serviceSplit[length(serviceSplit)]
  layerID <- as.integer(regmatches(url, regexpr("[0-9]+$",url)))

  out <- list(
    "url"=url,
    "scheme"=scheme,
    "host"=host,
    "instance"=instance,
    "restIndicator" = "rest/services",
    "folderName"=folderName,
    "serviceName"=serviceName,
    "layerID"=layerID
  )
  return(out)
}


#' @describeIn esriUrl Check if url is valid for an ESRI REST Service. General to include potential layer id too.
#' @export
esriUrl_isValid <- function(url, displayReason = FALSE) {
  # check url succeeds
  urlError <- tryCatch({
    httr::http_error(url)
  }, error = function(cond) {TRUE})

  if (!grepl("/rest/services", url)) {
    reason <- "'/rest/services' not found in the url."
    out <- FALSE
  } else if (!grepl("/MapServer|/FeatureServer", url)) {
    reason <- "'/MapServer' or '/FeatureServer' not found in the url."
    out <- FALSE
  } else if (urlError) {
    reason <- "Could not access url with {httr}."
    out <- FALSE
  } else if (!is.na(rvest::html_element(rvest::read_html(url), 'div.restErrors'))) {
    reason <- sub("^[[:space:]]*", "", rvest::html_text(rvest::html_element(rvest::read_html(url), 'div.restErrors')))
    out <- FALSE
  } else {
    out <- TRUE
  }

  if (!out & displayReason) {
    message(paste0("Url is not a valid ESRI Map or Feature Service Url.\n", reason))
  }

  return(out)
}

#' @describeIn esriUrl Check if url is valid for an ESRI REST Service Layer or Table
#' @export
esriUrl_isValidID <- function(url, displayReason = FALSE) {
  #make sure url is valid
  if (!esriUrl_isValid(url, displayReason = displayReason)) return(FALSE)

  out <- grepl("/[[:digit:]]+$", url)
  if (!out & displayReason) {
    message('Url does not end in a layer ID.')
  }

  return(out)
}

#' @describeIn esriUrl Check if url is valid for an ESRI REST Service. No layer ID.
#' @export
esriUrl_isValidService <- function(url, displayReason = FALSE) {
  #make sure url is valid
  if (!esriUrl_isValid(url, displayReason = displayReason)) return(FALSE)

  out <- grepl("/MapServer$|/FeatureServer$", url)
  if (!out & displayReason) {
    message("Url does not end in a '/MapServer' or '/FeatureServer'.")
  }

  return(out)
}
