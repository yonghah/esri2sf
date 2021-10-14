test_that("esriUrl_ServerUrl returns correct substring", {
  expect_identical(esriUrl_ServerUrl("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/3"), "https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer")
  expect_identical(esriUrl_ServerUrl("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer"), "https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer")
  expect_identical(esriUrl_ServerUrl("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/"), "https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer")
  expect_error(esriUrl_ServerUrl("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/"))
})

test_that("esriUrl_isValid checks", {
  expect_true(esriUrl_isValid("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/3"))
  expect_true(esriUrl_isValid("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer"))

  expect_message(esriUrl_isValid("https://sampleserver1.arcgisonline.com/ArcGIS/rest/Demographics/ESRI_Census_USA/MapServer/3", displayReason = TRUE), "Url is not a valid ESRI Map or Feature Service Url.\n'/rest/services' not found in the url.")
  expect_false(esriUrl_isValid("https://sampleserver1.arcgisonline.com/ArcGIS/rest/Demographics/ESRI_Census_USA/MapServer/3"))

  expect_message(esriUrl_isValid("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA", displayReason = TRUE), "Url is not a valid ESRI Map or Feature Service Url.\n'/MapServer' or '/FeatureServer not found in the url.")
  expect_false(esriUrl_isValid("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA"))

  expect_message(esriUrl_isValid("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census/MapServer/3", displayReason = TRUE), "Url is not a valid ESRI Map or Feature Service Url.\nService 'Demographics/ESRI_Census' of type 'MapServer' does not exist or is inaccessible.\nAn unexpected error occurred processing the request.")
  expect_false(esriUrl_isValid("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census/MapServer/3"))

  expect_message(esriUrl_isValid("https://sampleserver1.arcgisonline.com/ArcGI/rest/services/Demographics/ESRI_Census_USA/MapServer/3", displayReason = TRUE), "Url is not a valid ESRI Map or Feature Service Url.\nCould not access url with {httr}.", fixed = TRUE)
  expect_false(esriUrl_isValid("https://sampleserver1.arcgisonline.com/ArcGI/rest/services/Demographics/ESRI_Census_USA/MapServer/3"))
})
