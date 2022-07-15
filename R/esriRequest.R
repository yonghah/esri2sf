#' Use {httr2} to create a request for the ArcGIS REST API
#'
#' @param url A folder, service, or layer URL that can be used with the ArcGIS
#'   REST API.
#' @param append String to append to url using [httr2::req_url_path_append];
#'   defaults to `NULL`.
#' @param f,format Return format to use as query parameter with
#'   [httr2::req_url_query]; defaults to "json".
#' @param token String for authentication token; defaults to `NULL`.
#' @param .perform If `TRUE`, perform the request with [httr2::req_perform] and
#'   return the response. If `FALSE`, return the request.
#' @param .cache If `TRUE`, pass a cache folder path created with [rappdirs::user_cache_dir] and `esri2sf`
#'   package to the path parameter of [httr2::req_cache].
#' @param .max_seconds Passed to max_seconds parameter of [httr2::req_retry]
#' @param ... Additional parameters passed to [httr2::req_url_query]
#' @rdname esriRequest
#' @importFrom httr2 request req_url_path_append req_url_query req_perform
#' @importFrom cli cli_ul cli_abort
esriRequest <- function(url,
                        append = NULL,
                        f = NULL,
                        format = NULL,
                        token = NULL,
                        .perform = TRUE,
                        .cache = FALSE,
                        .max_seconds = 3,
                        ...) {
  # Make request based on url
  req <- httr2::request(url)

  # Append method or other url elements
  if (!is.null(append)) {
    req <- httr2::req_url_path_append(req = req, append)
  }

  # Add token and other query parameters
  if (is.null(token)) {
    token <- ""
  }

  # Add f and format query parameters if provided
  req <-
    httr2::req_url_query(
      req,
      f = f,
      format = format,
      token = token,
      ...
    )

  req <-
    httr2::req_user_agent(
      req = req,
      string = "esri2sf (https://github.com/yonghah/esri2sf)"
    )

  # Check if rappdirs::user_cache_dir can be used
  if (!requireNamespace("rappdirs", quietly = TRUE) & .cache) {
    cli::cli_alert_danger(
      "The {.pkg rappdirs} package is not installed.
      {.pkg rappdirs} is required to use the {.arg .cache} argument.
      Setting {.arg .cache} to {.val FALSE}."
    )
    .cache <- FALSE
  }


  if (.cache) {
    req <-
      httr2::req_cache(
        req = req,
        path = rappdirs::user_cache_dir("esri2sf")
      )
  }

  req <-
    httr2::req_retry(
      req = req,
      max_seconds = .max_seconds
    )

  # Return request if perform is FALSE
  if (!.perform) {
    return(req)
  }

  # Otherwise perform the request
  httr2::req_perform(req = req)
}
