#' Create an index of folders, services, layers, and tables for an ArcGIS Server
#'
#' Currently only returns layers and tables for MapServer and FeatureServer
#' services. Consider using [esriCatalog] with `format = "sitemap"` or `format = "geositemap"`
#' as an alternative approach to indexing available folders and services.
#'
#' @rdname esriIndex
#' @param url URL for ArcGIS server, folder, or service.
#' @param folderPath,serviceName Name of parent folder or service; only used
#'   internally (not intended for user).
#' @param recurse If `TRUE`, recursively check folders and services to return an
#'   index that includes services in folders, subfolders, layers, and tables.
#'   Defaults to `FALSE`.
#' @inheritParams esriRequest
#' @param ... Additional parameters passed to [esriCatalog]
#' @export
#' @importFrom dplyr bind_cols bind_rows mutate if_else case_when relocate
esriIndex <- function(url, folderPath = NULL, serviceName = NULL, recurse = FALSE, token = NULL, ...) {
  esriResp <- esriCatalog(url, token = token, ...)

  index <- NULL
  urlIndex <- url

  if (!!length(esriResp[["folders"]])) {
    folders <-
      dplyr::bind_cols(
        "name" = unlist(esriResp$folders),
        "urlType" = "folder"
      )

    index <-
      dplyr::bind_rows(
        index,
        folders
      )
  }

  if (!!length(esriResp[["services"]])) {
    services <-
      dplyr::bind_rows(esriResp$services)

    services <-
      dplyr::bind_cols(
        services,
        "urlType" = "service"
      )

    index <-
      dplyr::bind_rows(
        index,
        services
      )
  }

  if (is.null(index)) {
    return(index)
  }

  urlbase <-
    regmatches(
      urlIndex,
      regexpr(pattern = ".+(?=/)", text = urlIndex, perl = TRUE)
    )

  index <-
    dplyr::mutate(
      index,
      url = NULL,
      url = dplyr::if_else(
        grepl(pattern = "/", x = name),
        urlbase,
        urlIndex
      ),
      url = dplyr::case_when(
        (urlType == "folder") ~ paste0(url, "/", name),
        TRUE ~ paste0(url, "/", name, "/", type)
      )
    )

  index <-
    dplyr::bind_cols(
      index,
      "folderPath" = folderPath,
      "serviceName" = serviceName
    )

  if (!requireNamespace("purrr", quietly = TRUE) & recurse) {
    cli::cli_alert_danger(
      "The {.pkg purrr} package is not installed.
    {.pkg purrr} is required to use the {.arg recurse} argument for {.fn esriIndex}.
    Setting {.arg recurse} to {.val FALSE}."
    )

    recurse <- FALSE
  }

  if (recurse) {
    folderIndex <- subset(index, urlType == "folder")

    if (nrow(folderIndex) > 0) {
      folderIndex <-
        purrr::map2_dfr(
          folderIndex$url,
          folderIndex$name,
          ~ esriIndex(url = .x, folderPath = .y, serviceName = serviceName, recurse = TRUE)
        )

      index <-
        dplyr::bind_rows(
          index,
          folderIndex
        )
    }

    layerIndex <- subset(index, type %in% c("MapServer", "FeatureServer", "ImageServer", "GeocodeServer", "GeometryServer", "GPServer"))

    if (nrow(layerIndex) > 0) {
      layerIndex <-
        purrr::map2_dfr(
          layerIndex$url,
          layerIndex$name,
          ~ esriIndexLayers(url = .x, folderPath = folderPath, serviceName = .y, recurse = TRUE)
        )

      index <-
        dplyr::bind_rows(
          index,
          layerIndex
        )
    }
  }

  index <-
    dplyr::mutate(
      index,
      serviceType = dplyr::case_when(
        grepl("FeatureServer", url) ~ "FeatureServer",
        grepl("MapServer", url) ~ "MapServer",
        grepl("ImageServer", url) ~ "ImageServer",
        grepl("GeocodeServer", url) ~ "GeocodeServer",
        grepl("GeometryServer", url) ~ "GeometryServer",
        grepl("GPServer", url) ~ "GPServer"
      )
    )

  index <-
    dplyr::relocate(
      index,
      urlType, folderPath, serviceName, serviceType,
      .after = "url"
    )

  return(index)
}

#' @name esriIndexLayers
#' @rdname esriIndex
#' @export
#' @importFrom dplyr bind_cols bind_rows
esriIndexLayers <- function(url, folderPath = NULL, serviceName = NULL, token = "", ...) {
  esriResp <- esriCatalog(url, token = token, ...)

  index <- NULL

  if (!!length(esriResp[["layers"]])) {
    layers <-
      dplyr::bind_cols(
        dplyr::bind_rows(esriResp$layers),
        "urlType" = "layer"
      )

    index <-
      dplyr::bind_rows(
        index,
        layers
      )
  }

  if (!!length(esriResp[["tables"]])) {
    tables <-
      dplyr::bind_cols(
        dplyr::bind_rows(esriResp$tables),
        "urlType" = "table"
      )

    index <-
      dplyr::bind_rows(
        index,
        tables
      )
  }

  if (is.null(index)) {
    return(index)
  }

  index <-
    dplyr::bind_cols(
      index,
      "url" = paste0(url, "/", index$id),
      "folderPath" = folderPath,
      "serviceName" = serviceName
    )

  index <-
    dplyr::distinct(
      index,
      url,
      .keep_all = TRUE
    )

  return(index)
}

#' Get information on folders, services, tables, and layers using the Catalog
#' service
#'
#' <https://developers.arcgis.com/rest/services-reference/enterprise/catalog.htm>
#'
#' @rdname esriCatalog
#' @param format Format to use for request. Supported options include "json", "sitemap", or "geositemap"; "html" and "kmz" are not
#'   currently supported.
#' @param option Option parameter, "footprints" is the only option.
#' @param outSR Output spatial reference.
#' @inheritParams esriRequest
#' @export
#' @importFrom httr2 request req_url_query req_perform resp_body_json resp_body_xml
#' @importFrom xml2 as_list
#' @importFrom dplyr bind_rows
esriCatalog <- function(url, format = "json", token = NULL, option = NULL, outSR = NULL, ...) {
  format <- match.arg(format, c("json", "html", "kmz", "sitemap", "geositemap"))

  if (format == "json") {
    stopifnot(
      is.null(option) | (option == "footprints"),
      is.null(outSR) | (!is.null(outSR) && (option == "footprints"))
    )

    resp <-
      dplyr::case_when(
        is.null(option) ~ "catalog",
        is.null(outSR) ~ "option",
        !is.null(outSR) ~ "outSR"
      )

    resp <-
      switch(resp,
        "catalog" = esriRequest(url, format = format, token = token, ...),
        "option" = esriRequest(url, format = format, token = token, option = option, ...),
        "outSR" = esriRequest(url, format = format, token = token, option = option, outSR = outSR, ...)
      )

    json <- httr2::resp_body_json(resp = resp, check_type = FALSE, ...)

    return(json)
  }

  if (format %in% c("sitemap", "geositemap")) {
    sitemap <- httr2::resp_body_xml(resp = resp, ...)

    sitemap <- xml2::as_list(sitemap)

    sitemap <- dplyr::bind_rows("url" = unlist(sitemap, use.names = FALSE))

    return(sitemap)
  }

  cli::cli_abort("{.fn esriCatalog} does not support {.val {format}} as a {.arg format} argument.")
}
