skip_if_offline_url <- function(url) {
  skip_if_offline()
  if (!httr::http_error(httr::GET(url))) {
    return(invisible(TRUE))
  }
  skip(paste0(url, " could not be resolved."))
}
