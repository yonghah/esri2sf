test_that("esriUrl_serviceUrl returns correct substring", {
  skip_if_offline_url(url = "https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/3")

  expect_identical(esriUrl_serviceUrl("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/3"), "https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer")
  expect_identical(esriUrl_serviceUrl("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/3/"), "https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer")
  expect_identical(esriUrl_serviceUrl("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer"), "https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer")
  expect_identical(esriUrl_serviceUrl("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/"), "https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer")
  expect_error(esriUrl_serviceUrl("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/"), "Url is not a valid ESRI Service Url.\nCould not access url with {httr}.", fixed=TRUE)
})


test_that("esriUrl_isValidType checks", {
  skip_if_offline_url(url = "https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/3")

  #General Errors
  expect_false(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/Demographics/ESRI_Census_USA/MapServer/3"))
  expect_message(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/Demographics/ESRI_Census_USA/MapServer/3", displayReason = TRUE), "Url is not a valid ESRI Service Url.\n'/rest/services' not found in the url.")
  expect_false(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA"))
  expect_message(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA", displayReason = TRUE), "Url is not a valid ESRI Service Url.\nCould not access url with {httr}.", fixed=TRUE)
  expect_false(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/test"))
  expect_message(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/test", displayReason = TRUE), "Url is not a valid ESRI Service Url.\nError code: 400\nMessage: Unable to complete  operation")

  #General Successes
  expect_true(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/3"))
  expect_true(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/3/", type = NA_character_))
  expect_true(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer"))
  expect_true(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics"))
  expect_true(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services"))

  #Valid Feature
  expect_true(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/3", type = 'Feature'))
  expect_true(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/3/", type = 'Feature'))
  expect_false(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer", type = 'Feature'))
  expect_message(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer", type = 'Feature', displayReason = TRUE), "Url is not a valid ESRI Service Url.\nUrl does not end in a feature ID.")
  expect_false(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics", type = 'Feature'))
  expect_message(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics", type = 'Feature', displayReason = TRUE), "Url is not a valid ESRI Service Url.\nUrl does not end in a feature ID.")
  expect_false(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services", type = 'Feature'))
  expect_message(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services", type = 'Feature', displayReason = TRUE), "Url is not a valid ESRI Service Url.\nUrl does not end in a feature ID.")
  expect_false(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/Demographics/ESRI_Census_USA/MapServer/3", type = 'Feature'))
  expect_message(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/Demographics/ESRI_Census_USA/MapServer/3", type = 'Feature', displayReason = TRUE), "Url is not a valid ESRI Service Url.\n'/rest/services' not found in the url.")
  expect_false(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA", type = 'Feature'))
  expect_message(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA", type = 'Feature', displayReason = TRUE), "Url is not a valid ESRI Service Url.\nCould not access url with {httr}.", fixed=TRUE)
  expect_false(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/test", type = 'Feature'))
  expect_message(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/test", type = 'Feature', displayReason = TRUE), "Url is not a valid ESRI Service Url.\nError code: 400\nMessage: Unable to complete  operation")

  #Valid Service
  expect_false(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/3", type = 'Service'))
  expect_message(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/3", type = 'Service', displayReason = TRUE), "Url is not a valid ESRI Service Url.\nUrl does not end in a '/MapServer' or '/FeatureServer'.")
  expect_true(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer", type = 'Service'))
  expect_true(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/", type = 'Service'))
  expect_false(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics", type = 'Service'))
  expect_message(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics", type = 'Service', displayReason = TRUE), "Url is not a valid ESRI Service Url.\nUrl does not end in a '/MapServer' or '/FeatureServer'.")
  expect_false(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services", type = 'Service'))
  expect_message(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services", type = 'Service', displayReason = TRUE), "Url is not a valid ESRI Service Url.\nUrl does not end in a '/MapServer' or '/FeatureServer'.")
  expect_false(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/Demographics/ESRI_Census_USA/MapServer/3", type = 'Service'))
  expect_message(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/Demographics/ESRI_Census_USA/MapServer/3", type = 'Service', displayReason = TRUE), "Url is not a valid ESRI Service Url.\n'/rest/services' not found in the url.")
  expect_false(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA", type = 'Service'))
  expect_message(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA", type = 'Service', displayReason = TRUE), "Url is not a valid ESRI Service Url.\nCould not access url with {httr}.", fixed=TRUE)
  expect_false(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/test", type = 'Service'))
  expect_message(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/test", type = 'Service', displayReason = TRUE), "Url is not a valid ESRI Service Url.\nError code: 400\nMessage: Unable to complete  operation")

  #Valid Folder
  expect_false(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/3", type = 'Folder'))
  expect_message(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/3", type = 'Folder', displayReason = TRUE), "Url is not a valid ESRI Service Url.\nUrl is not a 'Folder' endpoint.")
  expect_false(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer", type = 'Folder'))
  expect_message(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer", type = 'Folder', displayReason = TRUE), "Url is not a valid ESRI Service Url.\nUrl is not a 'Folder' endpoint.")
  expect_true(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics", type = 'Folder'))
  expect_true(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/", type = 'Folder'))
  expect_true(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services", type = 'Folder'))
  expect_false(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/Demographics/ESRI_Census_USA/MapServer/3", type = 'Folder'))
  expect_message(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/Demographics/ESRI_Census_USA/MapServer/3", type = 'Folder', displayReason = TRUE), "Url is not a valid ESRI Service Url.\n'/rest/services' not found in the url.")
  expect_false(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA", type = 'Folder'))
  expect_message(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA", type = 'Folder', displayReason = TRUE), "Url is not a valid ESRI Service Url.\nCould not access url with {httr}.", fixed=TRUE)
  expect_false(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/test", type = 'Folder'))
  expect_message(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/test", type = 'Folder', displayReason = TRUE), "Url is not a valid ESRI Service Url.\nError code: 400\nMessage: Unable to complete  operation")

  #Valid Root
  expect_false(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/3", type = 'Root'))
  expect_message(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/3", type = 'Root', displayReason = TRUE), "Url is not a valid ESRI Service Url.\nUrl does not end in '/rest/services'.")
  expect_false(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer", type = 'Root'))
  expect_message(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer", type = 'Root', displayReason = TRUE), "Url is not a valid ESRI Service Url.\nUrl does not end in '/rest/services'.")
  expect_false(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics", type = 'Root'))
  expect_message(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics", type = 'Root', displayReason = TRUE), "Url is not a valid ESRI Service Url.\nUrl does not end in '/rest/services'.")
  expect_true(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services", type = 'Root'))
  expect_true(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/", type = 'Root'))
  expect_false(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/Demographics/ESRI_Census_USA/MapServer/3", type = 'Root'))
  expect_message(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/Demographics/ESRI_Census_USA/MapServer/3", type = 'Root', displayReason = TRUE), "Url is not a valid ESRI Service Url.\n'/rest/services' not found in the url.")
  expect_false(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA", type = 'Root'))
  expect_message(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA", type = 'Root', displayReason = TRUE), "Url is not a valid ESRI Service Url.\nCould not access url with {httr}.", fixed=TRUE)
  expect_false(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/test", type = 'Root'))
  expect_message(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/test", type = 'Root', displayReason = TRUE), "Url is not a valid ESRI Service Url.\nError code: 400\nMessage: Unable to complete  operation")

  #Test returnType - no type
  expect_identical(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/3", returnType = TRUE), "Feature")
  expect_identical(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer", returnType = TRUE), "Service")
  expect_identical(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/", returnType = TRUE), NA_character_)
  expect_identical(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/", returnType = TRUE), "Folder")
  expect_identical(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services", returnType = TRUE), "Root")

  #Test returnType - Feature
  expect_identical(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/3", type = 'Feature', returnType = TRUE), "Feature")
  expect_identical(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/3", type = 'Service', returnType = TRUE), "Feature")
  expect_identical(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/3", type = 'Folder', returnType = TRUE), "Feature")
  expect_identical(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/3", type = 'Root', returnType = TRUE), "Feature")

  #Test returnType - Service
  expect_identical(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer", type = 'Feature', returnType = TRUE), "Service")
  expect_identical(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer", type = 'Service', returnType = TRUE), "Service")
  expect_identical(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer", type = 'Folder', returnType = TRUE), "Service")
  expect_identical(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer", type = 'Root', returnType = TRUE), "Service")

  #Test returnType - Service
  expect_identical(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics", type = 'Feature', returnType = TRUE), "Folder")
  expect_identical(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics", type = 'Service', returnType = TRUE), "Folder")
  expect_identical(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics", type = 'Folder', returnType = TRUE), "Folder")
  expect_identical(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics", type = 'Root', returnType = TRUE), "Folder")

  #Test returnType - Root
  expect_identical(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services", type = 'Feature', returnType = TRUE), "Root")
  expect_identical(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services", type = 'Service', returnType = TRUE), "Root")
  expect_identical(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services", type = 'Folder', returnType = TRUE), "Root")
  expect_identical(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services", type = 'Root', returnType = TRUE), "Root")

  #Test returnType - Error
  expect_identical(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/", type = 'Feature', returnType = TRUE), NA_character_)
  expect_identical(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/", type = 'Service', returnType = TRUE), NA_character_)
  expect_identical(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/", type = 'Folder', returnType = TRUE), NA_character_)
  expect_identical(esriUrl_isValidType("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/", type = 'Root', returnType = TRUE), NA_character_)

})

test_that("esriUrl_isValid checks", {
  skip_if_offline_url(url = "https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/3")

  expect_true(esriUrl_isValid("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/3"))
  expect_true(esriUrl_isValid("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer"))
  expect_true(esriUrl_isValid("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics"))
  expect_true(esriUrl_isValid("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services"))
  expect_true(esriUrl_isValid("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/3/"))
  expect_true(esriUrl_isValid("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/"))
  expect_true(esriUrl_isValid("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/"))
  expect_true(esriUrl_isValid("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/"))

  expect_message(esriUrl_isValid("https://sampleserver1.arcgisonline.com/ArcGIS/rest/Demographics/ESRI_Census_USA/MapServer/3", displayReason = TRUE), "Url is not a valid ESRI Service Url.\n'/rest/services' not found in the url.")
  expect_false(esriUrl_isValid("https://sampleserver1.arcgisonline.com/ArcGIS/rest/Demographics/ESRI_Census_USA/MapServer/3"))

  expect_message(esriUrl_isValid("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA", displayReason = TRUE), "Url is not a valid ESRI Service Url.\nCould not access url with {httr}.", fixed=TRUE)
  expect_false(esriUrl_isValid("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA"))

  expect_message(esriUrl_isValid("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/test", displayReason = TRUE), "Url is not a valid ESRI Service Url.\nError code: 400\nMessage: Unable to complete  operation.")
  expect_false(esriUrl_isValid("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/test"))

  expect_message(esriUrl_isValid("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census/MapServer/3", displayReason = TRUE), "Url is not a valid ESRI Service Url.\nError code: 400\nMessage: Unable to complete  operation")
  expect_false(esriUrl_isValid("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census/MapServer/3"))

  expect_message(esriUrl_isValid("https://sampleserver1.arcgisonline.com/ArcGI/rest/services/Demographics/ESRI_Census_USA/MapServer/3", displayReason = TRUE), "Url is not a valid ESRI Service Url.\nCould not access url with {httr}.", fixed = TRUE)
  expect_false(esriUrl_isValid("https://sampleserver1.arcgisonline.com/ArcGI/rest/services/Demographics/ESRI_Census_USA/MapServer/3"))
})

test_that("esriUrl_isValid requires token", {
  skip_if_not(keyExists(service = "ArcGISServer", username = "login"), "Secret ArcGISServer key not found. Only works for maintainer and is okay to skip.")
  creds <- jsonlite::fromJSON(keyring::key_get(service = "ArcGISServer", username = "login"))
  token <- generateToken(server = paste0("https://", creds[['servername']]), uid = creds[['username']], pwd = creds[['password']], expiration = 5000)
  tokenUrl <- paste0("https://", creds[['servername']], "/arcgis/rest/services/PublicSafety/PublicSafetyMapService/MapServer")
  skip_if_offline_url(url = tokenUrl)

  expect_message(esriUrl_isValid(url = tokenUrl, token = "", displayReason = TRUE), "Url is not a valid ESRI Service Url.\nError code: 499\nMessage: Token Required")
  expect_false(esriUrl_isValid(url = tokenUrl, token = ""))

  expect_true(esriUrl_isValid(url = tokenUrl, token = token))

})



test_that("esriUrl_isValidFeature checks", {
  skip_if_offline_url(url = "https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/3")

  expect_true(esriUrl_isValidFeature("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/3"))
  expect_true(esriUrl_isValidFeature("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/3/"))

  expect_false(esriUrl_isValidFeature("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/"))
  expect_message(esriUrl_isValidFeature("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/", displayReason = TRUE), "Url does not end in a feature ID.")
  expect_message(esriUrl_isValidFeature("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer", displayReason = TRUE), "Url does not end in a feature ID.")
})


test_that("esriUrl_isValidService checks", {
  skip_if_offline_url(url = "https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/3")

  expect_true(esriUrl_isValidService("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer"))
  expect_true(esriUrl_isValidService("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/"))

  expect_false(esriUrl_isValidService("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/0"))
  expect_message(esriUrl_isValidService("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/0", displayReason = TRUE), "Url does not end in a '/MapServer' or '/FeatureServer'.")
})


test_that("esriUrl_isValidRoot checks", {
  skip_if_offline_url(url = "https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics")

  expect_true(esriUrl_isValidRoot("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services"))
  expect_true(esriUrl_isValidRoot("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/"))

  expect_false(esriUrl_isValidRoot("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics"))
  expect_message(esriUrl_isValidRoot("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics", displayReason = TRUE), "Url does not end in '/rest/services'.")
})


test_that("esriUrl_isValidFolder checks", {
  skip_if_offline_url(url = "https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer")

  expect_true(esriUrl_isValidFolder("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services"))
  expect_true(esriUrl_isValidFolder("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/"))
  expect_true(esriUrl_isValidFolder("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics"))
  expect_true(esriUrl_isValidFolder("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/"))

  expect_false(esriUrl_isValidFolder("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer"))
  expect_message(esriUrl_isValidFolder("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer", displayReason = TRUE), "Url is not a 'Folder' endpoint.")
})


test_that("esriUrl_parseUrl", {
  skip_if_offline_url(url = "https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/3")
  skip_if_offline_url(url = "https://services.arcgis.com/V6ZHFr6zdgNZuVG0/arcgis/rest/services/Landscape_Trees/FeatureServer/0")

  expect_snapshot(esriUrl_parseUrl('https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/3'))
  expect_snapshot(esriUrl_parseUrl('https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer'))
  expect_snapshot(esriUrl_parseUrl('https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics'))
  expect_snapshot(esriUrl_parseUrl('https://sampleserver1.arcgisonline.com/ArcGIS/rest/services'))
  expect_snapshot(esriUrl_parseUrl('https://services.arcgis.com/V6ZHFr6zdgNZuVG0/arcgis/rest/services/Landscape_Trees/FeatureServer/0/'))


  expect_error(esriUrl_parseUrl("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/"), "Url is not a valid ESRI Service Url.\nCould not access url with {httr}.", fixed = TRUE)
})
