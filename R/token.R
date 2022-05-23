#' @title Create authorization tokens
#'
#' @description Generate tokens for accessing credentialed ArcGIS REST Servers.
#'
#' `generateToken()` can create a token from the public token endpoint
#' `https://<host>:\<port\>/\<site\>/tokens/generateToken` or the admin endpoint
#' `https://\<host\>:\<port\>/\<site\>/admin/generateToken` for ArcGIS REST Servers. See
#' `https://developers.arcgis.com/rest/services-reference/enterprise/generate-token.htm` or
#' `https://developers.arcgis.com/rest/services-reference/enterprise/generate-admin-token.htm`
#' respectively for more information.
#'
#' `generateOAuthToken()` can create an OAuth token for ArcGIS Online Services.
#' See `https://developers.arcgis.com/documentation/core-concepts/security-and-authentication/accessing-arcgis-online-services/`
#' or `https://developers.arcgis.com/documentation/mapping-apis-and-services/security/oauth-2.0/`
#' for more information.
#'
#' @param server The ArcGIS REST Server you want to connect to: `https://\<host\>:\<port\>`
#' @param uid The user id of the account used to create the token connection to
#' the server
#' @param pwd The password of the account used to create the token connection to
#' the server. If left blank, RStudio will prompt you for the password. If you
#' aren't using RStudio, you must specify it in the function call.
#' @param type Either 'tokens' or 'admin'. Specify the endpoint you use to
#' create the token. Defaults to 'tokens'.
#' @param expiration Set an expiration limit on the token in minutes. Max
#' expiration date may be controlled by the server.
#' @param clientId Client ID
#' @param cliendSecret Client Secret
#'
#' @return Character string with the token

#' @describeIn token Create ArcGIS REST Service Token
#' @export
generateToken <- function(server, uid, pwd = "", type = c("tokens", "admin"), expiration = 5000) {
  type <- match.arg(type)

  # generate auth token from GIS server
  if (pwd == "") pwd <- rstudioapi::askForPassword("pwd")

  query <- list(
    username = uid,
    password = pwd,
    expiration = expiration,
    client = "requestip",
    f = "json"
  )

  r <- httr::POST(paste(server, "arcgis", type, "generateToken", sep = "/"),
    body = query, encode = "form"
  )
  jsonlite::fromJSON(httr::content(r, "parsed"))$token
}


#' @describeIn token Create ArcGIS OAuth Token
#' @export
generateOAuthToken <- function(clientId, clientSecret, expiration = 5000) {
  query <- list(
    client_id = clientId,
    client_secret = clientSecret,
    expiration = expiration,
    grant_type = "client_credentials"
  )

  r <- httr::POST("https://www.arcgis.com/sharing/rest/oauth2/token", body = query)
  httr::content(r, type = "application/json")$access_token
}
