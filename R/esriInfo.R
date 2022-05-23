
#' Get info from a service url
#'
#' Return service item info, metadata, or thumbnail. The {magick} package is
#' required to return a thumbnail.
#'
#' Additional documentation:
#' <https://developers.arcgis.com/rest/services-reference/enterprise/info.htm>
#'
#' @param info Options include "item", "metadata", or "thumbnail".
#' @param format If `info = "metadata"`, options include "fgdc" or "iso19139";
#'   "json" format is used for `info = "item"` and no format is required for
#'   `info = "thumbnail"`
#' @inheritParams esriRequest
#' @rdname esriInfo
#' @export
#' @importFrom httr2 request req_url_path_append req_url_query req_perform resp_body_json
#' @importFrom dplyr as_tibble
esriInfo <- function(url, info = NULL, format = NULL, token = NULL, ...) {
  info <- match.arg(info, c("item", "metadata", "thumbnail", "info"))

  append <-
    switch(info,
      "item" = "info/iteminfo",
      "metadata" = "info/metadata",
      "thumbnail" = "info/thumbnail"
    )


  if (info == "item") {
    format <- "json"

    resp <-
      esriRequest(
        url = url,
        append = append,
        format = format,
        token = token
      )

    resp <- httr2::resp_body_json(resp = resp, check_type = FALSE, ...)

    if (!is.null(resp[["extent"]])) {
      resp[["extent"]] <- list(extent2bbox(resp[["extent"]]))
    }

    resp[["typeKeywords"]] <- list(resp[["typeKeywords"]])
    resp[["tags"]] <- list(resp[["tags"]])

    return(dplyr::as_tibble(resp))
  }

  if (info == "metadata") {
    format <- match.arg(format, c("fgdc", "iso19139"))
    output <- "html"

    # Specifies metadata style.
    # The default is item description metadata style.
    resp <-
      esriRequest(
        url = url,
        append = append,
        format = format,
        token = token,
        output = output
      )

    resp <- httr2::resp_body_xml(resp = resp, check_type = FALSE, ...)
  }

  if (info == "thumbnail") {
    resp <-
      esriRequest(
        url = url,
        append = append,
        format = format,
        token = token
      )

    resp <- httr2::resp_body_raw(resp = resp)

    if (!requireNamespace("magick", quietly = TRUE)) {
      cli::cli_abort(
        "The {.pkg magick} package is required when {.arg info} is set to {.val thumbnail}."
      )
    }

    return(magick::image_read(resp))
  }
}


#' Convert numeric extent to bounding box object
#'
#' @noRd
#' @importFrom sf st_bbox
extent2bbox <- function(x, crs = 4326) {
  sf::st_bbox(
    c(
      xmin = x[[1]][[1]],
      ymin = x[[1]][[2]],
      xmax = x[[2]][[1]],
      ymax = x[[2]][[2]]
    ),
    crs = crs
  )
}
