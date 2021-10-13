#' @title Get All Layers and Tables
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
#' @param urlServer The url for the Map/Feature server. Ends in 'MapServer' or
#'   'FeatureServer'.
#'
#' @return A list from the JSON return.
#' @export
getAllLayersAndTables <- function(urlServer) {
  query <- list(
    f = "json",
    returnDomainNames = TRUE
  )

  r <- httr::POST(paste(urlServer, "layers", sep = "/"),
            body = query, encode = "form")
  response <- jsonlite::fromJSON(httr::content(r, "text"))
  return(response)
}
