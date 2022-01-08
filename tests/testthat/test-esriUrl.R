test_that("esriUrl_serverUrl returns correct substring", {
  skip_if_offline_url(url = "https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/3")

  expect_identical(esriUrl_serverUrl("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/3"), "https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer")
  expect_identical(esriUrl_serverUrl("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer"), "https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer")
  expect_identical(esriUrl_serverUrl("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/"), "https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer")
  expect_error(esriUrl_serverUrl("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/"), "Url is not a valid ESRI Map or Feature Service Url.\n'/MapServer' or '/FeatureServer' not found in the url.")
})

test_that("esriUrl_isValid checks", {
  skip_if_offline_url(url = "https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/3")

  expect_true(esriUrl_isValid("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/3"))
  expect_true(esriUrl_isValid("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer"))

  expect_message(esriUrl_isValid("https://sampleserver1.arcgisonline.com/ArcGIS/rest/Demographics/ESRI_Census_USA/MapServer/3", displayReason = TRUE), "Url is not a valid ESRI Map or Feature Service Url.\n'/rest/services' not found in the url.")
  expect_false(esriUrl_isValid("https://sampleserver1.arcgisonline.com/ArcGIS/rest/Demographics/ESRI_Census_USA/MapServer/3"))

  expect_message(esriUrl_isValid("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA", displayReason = TRUE), "Url is not a valid ESRI Map or Feature Service Url.\n'/MapServer' or '/FeatureServer' not found in the url.")
  expect_false(esriUrl_isValid("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA"))

  expect_message(esriUrl_isValid("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/test", displayReason = TRUE), "Url does not end in '/MapServer' or '/FeatureServer' or a layer/table ID.")
  expect_false(esriUrl_isValid("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/test"))

  expect_message(esriUrl_isValid("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census/MapServer/3", displayReason = TRUE), "Url is not a valid ESRI Map or Feature Service Url.\nService 'Demographics/ESRI_Census' of type 'MapServer' does not exist or is inaccessible.\nAn unexpected error occurred processing the request.")
  expect_false(esriUrl_isValid("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census/MapServer/3"))

  expect_message(esriUrl_isValid("https://sampleserver1.arcgisonline.com/ArcGI/rest/services/Demographics/ESRI_Census_USA/MapServer/3", displayReason = TRUE), "Url is not a valid ESRI Map or Feature Service Url.\nCould not access url with {httr}.", fixed = TRUE)
  expect_false(esriUrl_isValid("https://sampleserver1.arcgisonline.com/ArcGI/rest/services/Demographics/ESRI_Census_USA/MapServer/3"))
})


test_that("esriUrl_isValidID checks", {
  skip_if_offline_url(url = "https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/3")

  expect_true(esriUrl_isValidID("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/3"))

  expect_false(esriUrl_isValidID("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/"))
  expect_message(esriUrl_isValidID("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/", displayReason = TRUE), "Url is not a valid ESRI Map or Feature Service Url.\nUrl does not end in '/MapServer' or '/FeatureServer' or a layer/table ID.")
  expect_message(esriUrl_isValidID("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer", displayReason = TRUE), "Url does not end in a layer ID.")
})


test_that("esriUrl_isValidService checks", {
  skip_if_offline_url(url = "https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/3")

  expect_true(esriUrl_isValidService("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer"))

  expect_false(esriUrl_isValidService("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/"))
  expect_false(esriUrl_isValidService("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/0"))
  expect_message(esriUrl_isValidService("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/", displayReason = TRUE), "Url is not a valid ESRI Map or Feature Service Url.\nUrl does not end in '/MapServer' or '/FeatureServer' or a layer/table ID.")
  expect_message(esriUrl_isValidService("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/0", displayReason = TRUE), "Url does not end in a '/MapServer' or '/FeatureServer'.")
})

test_that("esriUrl_parseUrl", {
  skip_if_offline_url(url = "https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/3")
  skip_if_offline_url(url = "https://services.arcgis.com/V6ZHFr6zdgNZuVG0/arcgis/rest/services/Landscape_Trees/FeatureServer/0")

  expect_snapshot(esriUrl_parseUrl('https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/3'))
  expect_snapshot(esriUrl_parseUrl('https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer'))
  expect_snapshot(esriUrl_parseUrl('https://services.arcgis.com/V6ZHFr6zdgNZuVG0/arcgis/rest/services/Landscape_Trees/FeatureServer/0'))

  expect_error(esriUrl_parseUrl("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/"), "Url is not a valid ESRI Map or Feature Service Url.\n'/MapServer' or '/FeatureServer' not found in the url.")
})
