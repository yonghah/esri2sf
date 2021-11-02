
test_that("esri2df returns expected values [1]", {
  url <- 'https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/WaterTemplate/WaterDistributionInventoryReport/MapServer/5'
  skip_if_offline_url(url)
  expect_snapshot(esri2df(url = url,
                          objectIds = paste(1:10, collapse = ",")))
  expect_snapshot(esri2df(url = url,
                          where = "OBJECTID <= 10 AND FACILITYID = '4'"))
})


test_that("esri2df returns expected values [2]", {
  url <- 'https://opendata.baltimorecity.gov/egis/rest/services/Hosted/311_Customer_Service_Requests_2020_csv/FeatureServer/0'
  skip_if_offline_url(url)
  expect_true(nrow(esri2df(url = url, where = "agency = 'Health' AND srstatus = 'New'")) > 1)
})

