
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
#'   no format is required if `info` is "item" or "thumbnail".
#' @inheritParams esriRequest
#' @rdname esriInfo
#' @export
#' @importFrom httr2 resp_body_json resp_body_xml resp_body_raw
#' @importFrom dplyr as_tibble
#' @importFrom cli cli_abort
esriInfo <- function(url, info = NULL, format = NULL, token = NULL, ...) {
  info <- match.arg(info, c("item", "metadata", "thumbnail", "info"))

  append <-
    switch(info,
      "item" = "info/iteminfo",
      "metadata" = "info/metadata",
      "thumbnail" = "info/thumbnail"
    )


  if (info == "item") {
    f <- "json"

    resp <-
      esriRequest(
        url = url,
        append = append,
        f = f,
        token = token
      )

    resp <- httr2::resp_body_json(resp = resp, check_type = FALSE, ...)

    if (!is.null(resp[["extent"]])) {
      resp[["extent"]] <-
        list(
          extent2bbox(
            resp[["extent"]],
            crs = getLayerCRS(resp[["extent"]][["spatialReference"]])
          )
        )
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

    return(httr2::resp_body_xml(resp = resp, check_type = FALSE, ...))
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
        "The {.pkg magick} package must be installed when {.arg info} is set to {.val thumbnail}."
      )
    }

    magick::image_read(resp)
  }
}


#' Convert numeric extent to bounding box object
#'
#' @noRd
#' @importFrom sf st_bbox
extent2bbox <- function(x, crs = 4326) {
  sf::st_bbox(
    c(
      xmin = x[["xmin"]],
      ymin = x[["ymin"]],
      xmax = x[["xmax"]],
      ymax = x[["ymax"]]
    ),
    crs = crs
  )
}
