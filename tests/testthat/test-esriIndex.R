test_that("esriIndex works", {
  sample_url <- "http://sampleserver1.arcgisonline.com/ArcGIS/rest/services"

  expect_s3_class(
    esriIndex(
      url = sample_url
    ),
    "data.frame"
  )

  expect_equal(
    nrow(esriIndex(
      url = sample_url
    )),
    11
  )

  expect_s3_class(
    esriIndex(
      url = sample_url,
      recurse = TRUE
    ),
    "data.frame"
  )
})
