skip_if_offline_url <- function(url) {
  skip_if_offline()
  response <- httr::GET(url)
  if (!httr::http_error(response) & httr::content(response, as = 'text') != "") {
    return(invisible(TRUE))
  }
  skip(paste0(url, " could not be resolved."))
}
