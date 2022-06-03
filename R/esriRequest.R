#' Use {httr2} to create a request for the ArcGIS REST API
#'
#' @param url A folder, service, or layer URL that can be used with the ArcGIS
#'   REST API.
#' @param append String to append to url using [httr2::req_url_path_append];
#'   defaults to `NULL`.
#' @param format,f Return format to use as query parameter with
#'   [httr2::req_url_query]; defaults to "json".
#' @param token String for authentication token; defaults to `NULL`.
#' @param perform If `TRUE`, perform the request with [httr2::req_perform] and
#'   return the response. If `FALSE`, return the request.
#' @param ... Additional parameters passed to [httr2::req_url_query]
#' @rdname esriRequest
#' @importFrom httr2 request req_url_path_append req_url_query req_perform
#' @importFrom cli cli_ul cli_abort
esriRequest <- function(url, append = NULL, f = NULL, format = NULL, token = NULL, perform = TRUE, ...) {
  # Make request based on url
  req <- httr2::request(url)

  # Append method or other url elements
  if (!is.null(append)) {
    req <- httr2::req_url_path_append(req = req, append)
  }

  # Add f query parameter if provided
  if (!is.null(f)) {
    req <- httr2::req_url_query(req, f = f)
  }

  # Add format query parameter if provided
  if (!is.null(format)) {
    req <- httr2::req_url_query(req, format = format)
  }

  # Add token and other query parameters
  if (is.null(token)) {
    token <- ""
  }

  req <- httr2::req_url_query(req, token = token, ...)

  req <- httr2::req_user_agent(req = req, "esri2sf (https://github.com/yonghah/esri2sf)")

  # Return request if perform is FALSE
  if (!perform) {
    return(req)
  }

  # Otherwise perform the request
  resp <- httr2::req_perform(req = req)

  # Return details on error if needed
  # FIXME: This is not working
  if ("error" %in% names(resp)) {
    cli::cli_ul("{.emph {resp$error$details}}")
    cli::cli_abort("{resp$error$message} (HTTP code {.code {resp$error$code}})")
  }

  return(resp)
}
