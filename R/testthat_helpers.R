skip_if_offline_url <- function(url) {
  testthat::skip_if_offline()
  response <- httr::GET(url)
  if (!httr::http_error(response) & httr::content(response, as = 'text') != "") {
    return(invisible(TRUE))
  }
  testthat::skip(paste0(url, " could not be resolved."))
}


keyExists <- function(service, username) {
  out <- tryCatch({
    keyring::key_get(service = service, username = username)
    TRUE
  }, error = function(e) {
    FALSE
  })
  out
}
