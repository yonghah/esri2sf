#' @title Get All Layers and Tables for the whole server
#'
#' @description Retrieve JSON for all layers and tables as specified in
#' [https://si-pweb-vecmap.si.edu/vectormap/sdk/rest/index.html#/All_Layers_and_Tables/02ss0000005t000000/](https://si-pweb-vecmap.si.edu/vectormap/sdk/rest/index.html#/All_Layers_and_Tables/02ss0000005t000000/).
#' Performs a POST request towards the server url in one of the following the
#' forms:
#' * `https://<host>/<instance>/rest/services/<folderName>/serviceName>/MapServer/layers`
#' * `https://<host>/<instance>/rest/services/serviceName>/MapServer/layers`
#' * `https://<host>/<instance>/rest/services/<folderName>/serviceName>/FeatureServer/layers`
#' * `https://<host>/<instance>/rest/services/serviceName>/FeatureServer/layers`
#'
#' @param url The url for the Map/Feature server. If given a url specifying a
#' layer or table ID it will truncate it.
#'
#' @return A list from the JSON return.
#' @export
esriLayers <- function(url) {
  #Format url (remove layer.table ID and check it is valid)
  urlServer <- esriUrl_ServerUrl(url)

  query <- list(
    f = "json",
    returnDomainNames = TRUE
  )

  r <- httr::POST(paste(urlServer, "layers", sep = "/"),
            body = query, encode = "form")
  response <- jsonlite::fromJSON(httr::content(r, "text"))
  return(response)
}
