test_that("urlParts_urlServer returns correct substring", {
  expect_identical(urlParts_urlServer("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/3"), "https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer")
  expect_identical(urlParts_urlServer("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer"), "https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer")
  expect_identical(urlParts_urlServer("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/"), "https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer")
  expect_error(urlParts_urlServer("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/"))
})

test_that("urlParts_isValid checks", {
  expect_error(urlParts_isValid("https://sampleserver1.arcgisonline.com/ArcGIS/rest/Demographics/ESRI_Census_USA/MapServer/3"))
  expect_true(urlParts_isValid("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/3"))
  expect_true(urlParts_isValid("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer"))
  expect_error(urlParts_isValid("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA"))
  expect_error(urlParts_isValid("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census/MapServer/3"))
  expect_error(urlParts_isValid("https://sampleserver1.arcgisonline.com/ArcGI/rest/services/Demographics/ESRI_Census_USA/MapServer/3"))
})
