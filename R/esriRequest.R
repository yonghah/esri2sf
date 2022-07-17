#' Use httr2 to create a request for the ArcGIS REST API
#'
#' @param url A folder, service, or layer URL that can be used with the ArcGIS
#'   REST API.
#' @param append String to append to url using [httr2::req_url_path_append];
#'   defaults to `NULL`.
#' @param f,format Return format to use as query parameter with
#'   [httr2::req_url_query]; defaults to "json".
#' @param token String for authentication token; defaults to `NULL`.
#' @param outFields Query parameter used only for layer query requests.
#' @param .perform If `TRUE`, perform the request with [httr2::req_perform] and
#'   return the response. If `FALSE`, return the request.
#' @param .method optional method passed to [httr2::req_method]
#' @param .cache If `TRUE`, pass a cache folder path created with
#'   [rappdirs::user_cache_dir] and `esri2sf` package to the path parameter of
#'   [httr2::req_cache].
#' @param .max_seconds Passed to max_seconds parameter of [httr2::req_retry]
#' @param .is_error If `FALSE`, .is_error is passed to the is_error parameter of
#'   [httr2::req_error] function. If `TRUE`, the request does not use [httr2::req_error].
#' @param ... Additional parameters passed to [httr2::req_url_query]
#' @importFrom httr2 request req_url_path_append req_url_query url_parse
#'   req_body_json req_user_agent req_cache req_retry req_method req_error
#'   resp_body_json req_perform
#' @importFrom jsonlite toJSON
#' @importFrom cli cli_ul cli_abort
esriRequest <- function(url,
                        append = NULL,
                        f = NULL,
                        format = NULL,
                        outFields = NULL,
                        token = NULL,
                        .perform = TRUE,
                        .cache = FALSE,
                        .max_seconds = 3,
                        .is_error = TRUE,
                        ...) {

  # Create request based on url
  req <- httr2::request(url)

  # Append method or other url elements
  if (!is.null(append)) {
    req_full_url <- httr2::req_url_path_append(req, append)
  } else {
    req_full_url <- req
  }

  # Set token to required default
  if (is.null(token)) {
    token <- ""
  }

  # Add f, format, outFields, and additional query parameters if provided
  req <-
    httr2::req_url_query(
      req_full_url,
      f = f,
      format = format,
      outFields = outFields,
      token = token,
      ...
    )

  # If url is more than 2048 characters long, the query must be
  # contained in the body and submitted as a POST not a GET
  # This is only expected to be used for getEsriFeaturesByIds()
  if (nchar(req$url) > 2048) {
    query <- jsonlite::toJSON(httr2::url_parse(req$url)$query)

    where <- "1=1"

    if (any("where" %in% names(query))) {
      where <- query[["where"]]
    }

    req <- httr2::req_body_json(req_full_url, query)

    req <-
      httr2::req_url_query(
        req,
        f = f,
        format = format,
        where = where,
        outFields = outFields
      )
  }

  req <-
    httr2::req_user_agent(
      req,
      string = "esri2sf (https://github.com/yonghah/esri2sf)"
    )

  # Check if rappdirs::user_cache_dir can be used
  if (!requireNamespace("rappdirs", quietly = TRUE) & .cache) {
    cli::cli_warn(
      c("{.pkg rappdirs} must be installed if {.code .cache = TRUE}.",
        "i" = "Setting {.arg .cache} to {.val FALSE}."
      )
    )
    .cache <- FALSE
  }

  if (.cache) {
    req <-
      httr2::req_cache(
        req,
        path = rappdirs::user_cache_dir("esri2sf"),
        debug = TRUE
      )
  }

  req <-
    httr2::req_retry(
      req = req,
      max_seconds = .max_seconds
    )

  # Pass .is_error = FALSE to use httr2::req_error
  if (!.is_error) {
    req <-
      httr2::req_error(
        req,
        is_error = function(resp) {
          .is_error
        },
        body = function(resp) {
          httr2::resp_body_json(resp)$error
        }
      )
  }

  # Return request if perform is FALSE
  if (!.perform) {
    return(req)
  }

  # Otherwise perform the request
  httr2::req_perform(req = req)
}
