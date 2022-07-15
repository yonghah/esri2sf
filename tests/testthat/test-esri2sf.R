test_that("esri2sf works", {
  sample_url <- "http://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Louisville/LOJIC_PublicSafety_Louisville/MapServer/1"
  sample_df_url <- "https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/WaterTemplate/WaterDistributionInventoryReport/MapServer/5"

  sample_sf <-
    esri2sf(
      url = sample_url
    )

  expect_s3_class(
    esri2sf(
      url = sample_url
    ),
    "sf"
  )

  expect_s3_class(
    esri2sf(
      url = sample_url,
      crs = NULL
    ),
    "sf"
  )

  expect_s3_class(
    esri2sf(
      url = sample_url,
      outFields = "ADDRESS"
    ),
    "sf"
  )

  expect_s3_class(
    esri2sf(
      url = sample_url,
      geometry = suppressWarnings(sf::st_centroid(sample_sf[1, ]))
    ),
    "sf"
  )

  expect_s3_class(
    esri2sf(
      url = sample_url,
      geometry = sf::st_bbox(sample_sf)
    ),
    "sf"
  )

  expect_s3_class(
    esri2sf(
      url = sample_url,
      geometry = sf::st_bbox(sample_sf),
      spatialRel = "esriSpatialRelIntersects"
    ),
    "sf"
  )

  expect_s3_class(
    esri2sf(
      url = sample_url,
      progress = TRUE
    ),
    "sf"
  )

  expect_s3_class(
    esri2sf(
      url = sample_df_url,
      where = "OBJECTID <= 10 AND FACILITYID = '4'"
    ),
    "data.frame"
  )
})
