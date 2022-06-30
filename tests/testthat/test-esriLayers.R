test_that("esriLayers checks", {
  skip_if_offline_url(url = "https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/3")
  skip_if_offline_url(url = "https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/TaxParcel/AssessorsBasemap/MapServer")
  skip_if_offline_url(url = "https://carto.nationalmap.gov/arcgis/rest/services/contours/MapServer")
  skip_if_offline_url(url = "https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Elevation/ESRI_Elevation_World/GPServer")

  expect_snapshot(esriLayers('https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/3'))
  expect_snapshot(esriLayers('https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/TaxParcel/AssessorsBasemap/MapServer'))
  expect_snapshot(esriLayers('https://carto.nationalmap.gov/arcgis/rest/services/contours/MapServer'))

  expect_error(esriLayers("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Elevation/ESRI_Elevation_World/GPServer"), 'Function requires a "MapServer" or "FeaturepServer" url', fixed=TRUE)
})
