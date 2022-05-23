#' @title Get All Layers and Tables for the whole service
#'
#' @description Retrieve JSON for all layers and tables as specified in
#' [https://si-pweb-vecmap.si.edu/vectormap/sdk/rest/index.html#/All_Layers_and_Tables/02ss0000005t000000/](https://si-pweb-vecmap.si.edu/vectormap/sdk/rest/index.html#/All_Layers_and_Tables/02ss0000005t000000/).
#' Service type must either be a MapServer or FeatureServer.
#' Performs a request towards the server url in one of the following the
#' forms:
#' * `https://<host>/<instance>/rest/services/<folderName>/serviceName>/MapServer/layers`
#' * `https://<host>/<instance>/rest/services/serviceName>/MapServer/layers`
#' * `https://<host>/<instance>/rest/services/<folderName>/serviceName>/FeatureServer/layers`
#' * `https://<host>/<instance>/rest/services/serviceName>/FeatureServer/layers`
#'
#' @inheritParams esriRequest
#' @param url The url for the Map/Feature server. If given a url specifying a
#' layer or table ID it will truncate it.
#' @param returnDomainNames If `TRUE`, the REST API response does not include
#'   the full domain information for each layer (only the domain names). Defaults to `TRUE`.
#' @param returnUpdates If `TRUE`, updated features will be returned; defaults to `NULL`.
#' @param ... Additional parameters passed to
#' @return A list from the JSON return.
#' @export
#' @importFrom httr2 resp_body_json
esriLayers <- function(url, token = NULL, returnUpdates = NULL, returnDomainNames = TRUE, ...) {
  # Format url (remove layer.table ID and check it is valid)
  urlServer <- esriUrl_serviceUrl(url, token = token)

  is_urlServer(urlServer)

  resp <-
    esriRequest(
      url = url,
      f = "json",
      token = token,
      returnDomainNames = returnDomainNames,
      returnUpdates = returnUpdates
    )

  resp <- httr2::resp_body_json(resp = resp, check_type = FALSE, ...)

  return(resp)
}

#' Is URL a FeatureServer or MapServer URL?
#'
#' @noRd
#' @importFrom cli cli_abort
is_urlServer <- function(url) {
  if (!grepl("/(FeatureServer|MapServer)/?$", url)) {
    cli::cli_abort(
      c(
        "Invalid {.arg url}:",
        "{.url {url}}",
        "Function requires a {.val MapServer} or {.val FeaturepServer} url."
      )
    )
  }
}
