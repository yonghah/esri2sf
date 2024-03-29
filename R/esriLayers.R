#' @title Get All Layers and Tables for the whole service
#'
#' @description Retrieve JSON for all layers and tables as specified in
#' [https://si-pweb-vecmap.si.edu/vectormap/sdk/rest/index.html#/All_Layers_and_Tables/02ss0000005t000000/](https://si-pweb-vecmap.si.edu/vectormap/sdk/rest/index.html#/All_Layers_and_Tables/02ss0000005t000000/).
#' Service type must either be a MapServer or FeatureServer.
#' Performs a POST request towards the server url in one of the following the
#' forms:
#' * `https://<host>/<instance>/rest/services/<folderName>/serviceName>/MapServer/layers`
#' * `https://<host>/<instance>/rest/services/serviceName>/MapServer/layers`
#' * `https://<host>/<instance>/rest/services/<folderName>/serviceName>/FeatureServer/layers`
#' * `https://<host>/<instance>/rest/services/serviceName>/FeatureServer/layers`
#'
#' @param url The url for the Map/Feature server. If given a url specifying a
#' layer or table ID it will truncate it.
#' @param token String for authentication token (if needed).
#'
#' @return A list from the JSON return.
#' @export
esriLayers <- function(url, token = "") {
  #Format url (remove layer.table ID and check it is valid)
  urlServer <- esriUrl_serviceUrl(url, token = token)

  if (!grepl("/(FeatureServer|MapServer)/?$", urlServer)) {
    stop("Url is not valid.\n Service type is not either 'MapServer' or 'FeatureServer'")
  }

  query <- list(
    f = "json",
    token = token,
    returnDomainNames = TRUE
  )

  r <- httr::POST(paste(urlServer, "layers", sep = "/"),
            body = query, encode = "form")
  response <- jsonlite::fromJSON(httr::content(r, "text"))
  return(response)
}
