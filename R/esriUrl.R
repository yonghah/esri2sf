serviceTypes <- c("MapServer", "FeatureServer", "GPServer", "GeocodeServer", "GeometryServer", "ImageServer")

esriUrl_isValidType <- function(url, type = c(NA_character_, "Root", "Folder", "Service", "Feature"), displayReason = FALSE, returnType = FALSE) {

  type <- match.arg(type)

  # check url succeeds
  urlError <- tryCatch({
    httr::http_error(httr::GET(url))
  }, error = function(cond) {TRUE})

  if (!grepl("/rest/services", url)) {
    reason <- "'/rest/services' not found in the url."
    out <- FALSE
  } else if (urlError) {
    reason <- "Could not access url with {httr}."
    out <- FALSE
  } else if (!is.na(rvest::html_element(rvest::read_html(url), 'div.restErrors'))) {
    reason <- sub("^[[:space:]]*", "", rvest::html_text(rvest::html_element(rvest::read_html(url), 'div.restErrors')))
    out <- FALSE
    if (reason == "Invalid URL") {
      url_encoded <- utils::URLencode(url)
      if (is.na(rvest::html_element(rvest::read_html(url_encoded), 'div.restErrors'))) {
        reason <- "Invalid URL: Check encoding of supplied URL."
      }
    }
  } else {
    out <- TRUE
  }

  if (out) {

    isType <- c(
      "Root" = grepl("/rest/services/?$", url),
      "Folder" = grepl("^Folder:", rvest::html_text(rvest::html_element(rvest::read_html(url), 'div.restHeader h2'))),
      "Service" = grepl(paste0("/(", paste0(serviceTypes, collapse = "|"), ")/?$"), url),
      "Feature" = grepl(paste0("/(", paste0(serviceTypes, collapse = "|"), ")/[[:digit:]]+/?$"), url)
    )

    if (!is.na(type) & !(type %in% names(which(isType))) & !returnType) {
      if (type == "Root") {
        reason <- "Url does not end in '/rest/services'."
      } else if (type == "Folder") {
        reason <- "Url is not a 'Folder' endpoint."
      } else if (type == "Service") {
        reason <- "Url does not end in a '/MapServer' or '/FeatureServer'."
      } else if (type == "Feature") {
        reason <- "Url does not end in a feature ID."
      }
      out <- FALSE
    } else {
      out <- TRUE
    }

  }

  if (!out & displayReason) {
    message(paste0("Url is not a valid ESRI Service Url.\n", reason))
  }

  if (out & returnType) {
    out <- names(isType[which(isType)[1]])
  } else if (!out & returnType) {
    out <- NA_character_
  }

  return(out)
}

#' @title Validate or parse the parts of a ESRI REST Server URL
#'
#' @description A collection of functions that pull select parts out of a
#'   ESRI Service URL. All urls should be a form similar to:
#' * `https://<host>/<instance>/rest/services/<folderPath>/serviceName>/<serviceType>/<featureID>`
#' * `http://<host>/<instance>/rest/services/serviceName>/<serviceType>`
#' * `<host>/<instance>/rest/services/<folderPath>/serviceName>/<serviceType>`
#' * `https://<host>/<instance>/rest/services/serviceName>/<serviceType>/<featureID>`
#' * `https://<host>/<instance>/rest/services/<folderPath>`
#' * `https://<host>/<instance>/rest/services`
#'
#' And having these rules:
#'  * The scheme: `https://` or `http://` part is optional
#'  * The `host` part is the domain of the url.
#'  * The `instance`  is the first subpage after the domain in the url.
#'  * The `/rest/services` is the second and third subpage in the url. These are standard for all ESRI REST Services.
#'  * The `folderPath` part is optional and indicates the file structure in the REST Service. It consists of all subpages between `/rest/services/` and the `serviceName` part (if available).
#'  * The `serviceName` part is the last subpage betore the `<serviceType>` in the url.
#'  * The `serviceType` specifies the type of service. Currently this package works to manage the following serviceTypes: 'MapServer', 'FeatureServer', 'GPServer', 'GeocodeServer', 'GeometryServer', 'ImageServer'.
#'  * The `featureID` is optional and specifies the layer or table in the map service.
#'
#'
#' @param url The url for a Map/Feature server or for a layer/table in a
#'   Map/Feature Server.
#' @param displayReason Should the reason for why a url is not valid be displayed.
#'
#' @return Character string of the request part of the url.


#' @describeIn esriUrl Check if url is valid for an ESRI REST Service. General to include potential layer id too.
#' @export
esriUrl_isValid <- function(url, displayReason = FALSE) {

  out <- esriUrl_isValidType(url=url, type = NA_character_, displayReason = displayReason, returnType = FALSE)

  return(out)
}

#' @describeIn esriUrl Check if url is valid for the root of an ESRI REST Server.
#' @export
esriUrl_isValidRoot <- function(url, displayReason = FALSE) {

  out <- esriUrl_isValidType(url=url, type = 'Root', displayReason = displayReason, returnType = FALSE)

  return(out)
}

#' @describeIn esriUrl Check if url is valid for a folder of an ESRI REST Server.
#' @export
esriUrl_isValidFolder <- function(url, displayReason = FALSE) {

  out <- esriUrl_isValidType(url=url, type = 'Folder', displayReason = displayReason, returnType = FALSE)

  return(out)
}

#' @describeIn esriUrl Check if url is valid for a Service of an ESRI REST Server. No feature ID.
#' @export
esriUrl_isValidService <- function(url, displayReason = FALSE) {

  out <- esriUrl_isValidType(url=url, type = 'Service', displayReason = displayReason, returnType = FALSE)

  return(out)
}

#' @describeIn esriUrl DEPRECATED Use esriUrl_isValidFeature
#' @export
esriUrl_isValidID <- function(url, displayReason = FALSE) {

  .Deprecated("esriUrl_isValidFeature")
  out <- esriUrl_isValidFeature(url, displayReason = displayReason)

  return(out)
}

#' @describeIn esriUrl Check if url is valid for a feature of an ESRI REST Service.
#' @export
esriUrl_isValidFeature <- function(url, displayReason = FALSE) {

  out <- esriUrl_isValidType(url=url, type = 'Feature', displayReason = displayReason, returnType = FALSE)

  return(out)
}


#' @describeIn esriUrl DEPRECATED Use esriUrl_serviceUrl
#' @export
esriUrl_ServerUrl <- function(url) {
  .Deprecated("esriUrl_serviceUrl")
  esriUrl_serviceUrl(url)
}

#' @describeIn esriUrl Retrieve Map/Feature Server URL
#' @export
esriUrl_serviceUrl <- function(url) {
  #Cut off layerID if present
  urlNoLayerID <- sub("/[[:digit:]]+/?$|/$", '', url)

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

  #Find type of URL
  urlType <- esriUrl_isValidType(url, type = NA_character_, displayReason = FALSE, returnType = TRUE)

  if (urlType == "Root") {
    folderPath = ""
    serviceName = ""
    serviceType = ""
    featureID = integer(0)
  } else if (urlType == "Folder") {
    folderPath = sub("/$", "", sub(".*/rest/services/", "", url))
    serviceName = ""
    serviceType = ""
    featureID = integer(0)
  } else if (urlType %in% c("Service", "Feature")) {
    folderService <- unlist(strsplit(sub(paste0("/(", paste0(serviceTypes, collapse = "|"), ").*"), "", sub(".*/rest/services/", "", url)), "/"))
    if (length(folderService) > 1) {
      folderPath <- paste0(folderService[-length(folderService)], collapse = "/")
    } else {
      folderPath <- ""
    }
    serviceSplit <- unlist(strsplit(sub(paste0("/(", paste0(serviceTypes, collapse = "|"), ").*"), "", url), "/"))
    serviceName <- serviceSplit[length(serviceSplit)]
    serviceType <- gsub("/", "", regmatches(url, regexpr(paste0("/(", paste0(serviceTypes, collapse = "|"), ")/?"),url)))
    if (urlType == "Service") {
      featureID = integer(0)
    } else if (urlType == "Feature") {
      featureID = as.integer(gsub("/", "", regmatches(url, regexpr("/[0-9]+/?$",url))))
    }
  }

  out <- list(
    "url"=url,
    "scheme"=scheme,
    "host"=host,
    "instance"=instance,
    "restIndicator" = "rest/services",
    "folderPath"=folderPath,
    "serviceName"=serviceName,
    "serviceType"=serviceType,
    "featureID"=featureID
  )
  return(out)
}

