
<!-- README.md is generated from README.Rmd. Please edit that file -->

# esri2sf

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/esri2sf)](https://CRAN.R-project.org/package=esri2sf)
[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![License:
MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

<!-- badges: end -->

Download ArcGIS FeatureServer and MapServer Data to Simple Features

The [ArcGIS
FeatureServer](https://enterprise.arcgis.com/en/server/latest/publish-services/windows/what-is-a-feature-service-.htm)
or
[MapServer](https://enterprise.arcgis.com/en/server/latest/publish-services/windows/what-is-a-map-service.htm)
services are among the most common sources for geospatial data. The
esri2sf package enables users to download data from an ArcGIS Server to
a simple feature (sf) or data frame object using the [ArcGIS REST
API](https://developers.arcgis.com/rest/). You can learn more about
[working with sf
objects](https://r-spatial.github.io/sf/articles/sf1.html) in the
documentation for the [sf package](https://r-spatial.github.io/sf/).

## How esri2sf works

This package takes the layer URL and query (created from a bounding box,
geometry, and other parameters). Typically, the ArcGIS REST API limits
the maximum number of rows that can be returned from a single query.
This package uses [httr2](https://httr2.r-lib.org/) to query the server
and initially returns the ID for all features and then batches the IDs
to return all requested features from the server.

The geometry is returned as a [FeatureSet
object](https://developers.arcgis.com/documentation/common-data-types/featureset-object.htm)
(also known as an ESRI JSON object). The JSON is converted into an sf
object and combined with the attribute data to return an sf data frame.

## Install

Use [pak](https://pak.r-lib.org/) to install this package from GitHub:

``` r
pak::pkg_install("yonghah/esri2sf")
```

## How to use esri2sf

To use esri2sf, you need is the URL of a FeatureServer or MapServer
layer you want to download. You can get the URL by viewing the URL
widget on the service’s webpage (see image below), by asking a GIS
admin, or looking at the code of a webpage where it creates a feature
layer.

![REST Service screenshot](inst/www/images/rest-service-ss.png)

You can then use the url with esri2sf to download data:

``` r
library(esri2sf)
url <- "https://services.arcgis.com/V6ZHFr6zdgNZuVG0/arcgis/rest/services/Landscape_Trees/FeatureServer/0"

df <- esri2sf(url)
#> ✔ Downloading "Landscape_Trees" from
#>   <https://services.arcgis.com/V6ZHFr6zdgNZuVG0/arcgis/rest/services/Landscape_Trees/FeatureServer/0>
#> Layer type: "Feature Layer"
#> 
#> Geometry type: "esriGeometryPoint"
#> 
#> Service Coordinate Reference System: "EPSG:3857"
#> 
#> Output Coordinate Reference System: "EPSG:4326"

plot(df)
#> Warning: plotting the first 9 out of 56 attributes; use max.plot = 56 to plot
#> all
```

<img src="man/figures/README-points-1.png" width="100%" />

<!-- ![point plot](https://user-images.githubusercontent.com/3218468/29668766-544723a2-88af-11e7-8852-e8f7d21ffd5b.png) -->

### Select fields using `outFields`

You can select specific output fields. You can check the names of the
data source columns using the `esrimeta()` function with
`fields = TRUE`. Set `progress = TRUE` to show a progress bar for larger
downloads (such as this 18000 polyline data).

``` r
url <- "https://services.arcgis.com/V6ZHFr6zdgNZuVG0/arcgis/rest/services/Florida_Annual_Average_Daily_Traffic/FeatureServer/0"

esrimeta(url, fields = TRUE)
#>          name                      type actualType                      alias
#> 1         FID          esriFieldTypeOID        int                        FID
#> 2       YEAR_ esriFieldTypeSmallInteger   smallint                      YEAR_
#> 3    DISTRICT       esriFieldTypeString   nvarchar                   DISTRICT
#> 4      COSITE       esriFieldTypeString   nvarchar                     COSITE
#> 5     ROADWAY       esriFieldTypeString   nvarchar                    ROADWAY
#> 6    DESC_FRM       esriFieldTypeString   nvarchar                   DESC_FRM
#> 7     DESC_TO       esriFieldTypeString   nvarchar                    DESC_TO
#> 8        AADT      esriFieldTypeInteger        int                       AADT
#> 9     AADTFLG       esriFieldTypeString   nvarchar                    AADTFLG
#> 10       KFLG       esriFieldTypeString   nvarchar                       KFLG
#> 11    K100FLG       esriFieldTypeString   nvarchar                    K100FLG
#> 12       DFLG       esriFieldTypeString   nvarchar                       DFLG
#> 13       TFLG       esriFieldTypeString   nvarchar                       TFLG
#> 14 BEGIN_POST       esriFieldTypeDouble      float                 BEGIN_POST
#> 15   END_POST       esriFieldTypeDouble      float                   END_POST
#> 16      KFCTR       esriFieldTypeDouble      float                      KFCTR
#> 17   K100FCTR       esriFieldTypeDouble      float                   K100FCTR
#> 18      DFCTR       esriFieldTypeDouble      float                      DFCTR
#> 19      TFCTR       esriFieldTypeDouble      float                      TFCTR
#> 20 Shape_Leng       esriFieldTypeDouble      float                 Shape_Leng
#> 21 TFCTR_copy       esriFieldTypeDouble       <NA>     % truck volume per day
#> 22  TRUCK_PER       esriFieldTypeDouble       <NA> % of truck traffic per day
#>            sqlType nullable editable domain defaultValue length
#> 1   sqlTypeInteger    FALSE    FALSE     NA           NA     NA
#> 2  sqlTypeSmallInt     TRUE     TRUE     NA           NA     NA
#> 3  sqlTypeNVarchar     TRUE     TRUE     NA           NA      1
#> 4  sqlTypeNVarchar     TRUE     TRUE     NA           NA      6
#> 5  sqlTypeNVarchar     TRUE     TRUE     NA           NA      8
#> 6  sqlTypeNVarchar     TRUE     TRUE     NA           NA     30
#> 7  sqlTypeNVarchar     TRUE     TRUE     NA           NA     30
#> 8   sqlTypeInteger     TRUE     TRUE     NA           NA     NA
#> 9  sqlTypeNVarchar     TRUE     TRUE     NA           NA      1
#> 10 sqlTypeNVarchar     TRUE     TRUE     NA           NA      1
#> 11 sqlTypeNVarchar     TRUE     TRUE     NA           NA      1
#> 12 sqlTypeNVarchar     TRUE     TRUE     NA           NA      1
#> 13 sqlTypeNVarchar     TRUE     TRUE     NA           NA      1
#> 14    sqlTypeFloat     TRUE     TRUE     NA           NA     NA
#> 15    sqlTypeFloat     TRUE     TRUE     NA           NA     NA
#> 16    sqlTypeFloat     TRUE     TRUE     NA           NA     NA
#> 17    sqlTypeFloat     TRUE     TRUE     NA           NA     NA
#> 18    sqlTypeFloat     TRUE     TRUE     NA           NA     NA
#> 19    sqlTypeFloat     TRUE     TRUE     NA           NA     NA
#> 20    sqlTypeFloat     TRUE     TRUE     NA           NA     NA
#> 21    sqlTypeOther     TRUE     TRUE     NA           NA     NA
#> 22    sqlTypeOther     TRUE     TRUE     NA           NA     NA

df <- esri2sf(url, outFields = c("AADT", "DFLG"))
#> ✔ Downloading "Florida_Annual_Average_Daily_Traffic" from
#>   <https://services.arcgis.com/V6ZHFr6zdgNZuVG0/arcgis/rest/services/Florida_Annual_Average_Daily_Traffic/FeatureServer/0>
#> Layer type: "Feature Layer"
#> 
#> Geometry type: "esriGeometryPolyline"
#> 
#> Service Coordinate Reference System: "EPSG:3857"
#> 
#> Output Coordinate Reference System: "EPSG:4326"

plot(df)
```

<img src="man/figures/README-polyline-1.png" width="100%" />

<!-- ![line plot](https://user-images.githubusercontent.com/3218468/29668781-5dc1f4de-88af-11e7-8680-4d2ad648e04f.png) -->

### Filter rows using `where`

You can filter rows as well by providing a `where` condition in
standardized SQL (SQL-92) that is applied to non-spatial attributes.
See[the ArcGIS
documentation](https://enterprise.arcgis.com/en/portal/latest/use/calculate-fields.htm#ESRI_SECTION1_28F344E2E80C410A98D443FF301DF989)
for more information on supported operators and functions.

``` r
url <- "https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/3"

mi <- esri2sf(
  url,
  where = "STATE_NAME = 'Michigan'",
  outFields = c("POP2000", "pop2007", "POP00_SQMI", "POP07_SQMI")
)
#> ✔ Downloading "Coarse Counties" from
#>   <https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/3>
#> Layer type: "Feature Layer"
#> 
#> Geometry type: "esriGeometryPolygon"
#> 
#> Service Coordinate Reference System: "EPSG:4269"
#> 
#> Output Coordinate Reference System: "EPSG:4326"

plot(mi)
```

<img src="man/figures/README-polygon-1.png" width="100%" />

<!-- ![polygon plot](https://user-images.githubusercontent.com/3218468/29668791-63e66976-88af-11e7-9f6c-5d95bac4a69e.png) -->

### Use `esri2df()` to download tabular data

You can download non-spatial tables of the ‘Table’ layer type using
`esri2df()`.

``` r
df <- esri2df("https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/WaterTemplate/WaterDistributionInventoryReport/MapServer/5", objectIds = paste(1:50, collapse = ","))
#> ✔ Downloading "AssetCondition"
#> Layer type: "Table"

df
#> # A tibble: 50 × 6
#>    OBJECTID FACILITYID FCLASS ASSETCOND CONDDATE REPLSCORE
#>       <int> <chr>      <chr>  <lgl>     <lgl>        <int>
#>  1        1 1          wMain  NA        NA               0
#>  2        2 2          wMain  NA        NA              45
#>  3        3 3          wMain  NA        NA              45
#>  4        4 4          wMain  NA        NA              45
#>  5        5 5          wMain  NA        NA              15
#>  6        6 6          wMain  NA        NA              15
#>  7        7 1          wMain  NA        NA               0
#>  8        8 2          wMain  NA        NA              45
#>  9        9 3          wMain  NA        NA              45
#> 10       10 4          wMain  NA        NA              45
#> # … with 40 more rows
#> # ℹ Use `print(n = ...)` to see more rows
```

In some cases, tables may include coordinates as numeric columns. If
this is the case, you can create a bounding box filter condition using
the following format:

``` r
bbox <- sf::st_bbox(mi)
coords <- c("longitude", "latitude")

where <- paste0(c(
  sprintf("(%s >= %s)", coords[1], bbox$xmax[[1]]),
  sprintf("(%s <= %s)", coords[1], bbox$xmin[[1]]),
  sprintf("(%s >= %s)", coords[2], bbox$ymax[[1]]),
  sprintf("(%s <= %s)", coords[2], bbox$ymin[[1]])
),
collapse = " AND "
)


where
#> [1] "(longitude >= -82.419835847249) AND (longitude <= -90.4081998349311) AND (latitude >= 48.1737952928041) AND (latitude <= 41.6974947570863)"
```

### Using the `crs` parameter

When specifying the CRS parameter, any transformation that happens will
be done within the ArcGIS REST API. Caution should be taken when
specifying an output `crs` that requires a datum transformation as ESRI
will automatically apply a default transformation (with no feedback as
to which one) which could end up adding small unexpected errors into
your data.

By default, `esri2sf()` will transform any data to WGS 1984 (EPSG:4326),
but it may be safer to set `crs = NULL` which will return the data in
the same CRS as the host service. You can also set an alternate default
crs using `options`, e.g. `options("esri2sf.crs", 3857)`.

``` r
url <- "https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/3"
where <- "STATE_NAME = 'Michigan'"
outFields <- c("POP2000", "pop2007", "POP00_SQMI", "POP07_SQMI")

# default crs = 4326
esri2sf(url, where = where, outFields = outFields)
#> ✔ Downloading "Coarse Counties" from
#>   <https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/3>
#> Layer type: "Feature Layer"
#> 
#> Geometry type: "esriGeometryPolygon"
#> 
#> Service Coordinate Reference System: "EPSG:4269"
#> 
#> Output Coordinate Reference System: "EPSG:4326"
#> Simple feature collection with 83 features and 4 fields
#> Geometry type: MULTIPOLYGON
#> Dimension:     XY
#> Bounding box:  xmin: -90.4082 ymin: 41.69749 xmax: -82.41984 ymax: 48.1738
#> Geodetic CRS:  WGS 84
#> First 10 features:
#>    POP2000 POP2007 POP00_SQMI POP07_SQMI                          geoms
#> 1     2301    2324        4.1        4.2 MULTIPOLYGON (((-88.49753 4...
#> 2    36016   36791       34.6       35.3 MULTIPOLYGON (((-88.50068 4...
#> 3     7818    7444        5.9        5.6 MULTIPOLYGON (((-88.98743 4...
#> 4     8746    8760        9.5        9.5 MULTIPOLYGON (((-88.67172 4...
#> 5    64634   64904       34.6       34.7 MULTIPOLYGON (((-87.6137 45...
#> 6    17370   17057       15.2       14.9 MULTIPOLYGON (((-88.9853 46...
#> 7     7024    7159        7.6        7.7 MULTIPOLYGON (((-85.85923 4...
#> 8     9862   10188       10.5       10.9 MULTIPOLYGON (((-87.11047 4...
#> 9     8903    8781        7.3        7.2 MULTIPOLYGON (((-86.45828 4...
#> 10   13138   12750       10.8       10.5 MULTIPOLYGON (((-88.9252 46...

# No transformation (recommended)
esri2sf(url, where = where, outFields = outFields, crs = NULL)
#> ✔ Downloading "Coarse Counties" from
#>   <https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/3>
#> Layer type: "Feature Layer"
#> 
#> Geometry type: "esriGeometryPolygon"
#> 
#> Service Coordinate Reference System: "EPSG:4269"
#> 
#> Output Coordinate Reference System: "EPSG:4269"
#> Simple feature collection with 83 features and 4 fields
#> Geometry type: MULTIPOLYGON
#> Dimension:     XY
#> Bounding box:  xmin: -90.4082 ymin: 41.69749 xmax: -82.41984 ymax: 48.1738
#> Geodetic CRS:  NAD83
#> First 10 features:
#>    POP2000 POP2007 POP00_SQMI POP07_SQMI                          geoms
#> 1     2301    2324        4.1        4.2 MULTIPOLYGON (((-88.49753 4...
#> 2    36016   36791       34.6       35.3 MULTIPOLYGON (((-88.50068 4...
#> 3     7818    7444        5.9        5.6 MULTIPOLYGON (((-88.98743 4...
#> 4     8746    8760        9.5        9.5 MULTIPOLYGON (((-88.67172 4...
#> 5    64634   64904       34.6       34.7 MULTIPOLYGON (((-87.6137 45...
#> 6    17370   17057       15.2       14.9 MULTIPOLYGON (((-88.9853 46...
#> 7     7024    7159        7.6        7.7 MULTIPOLYGON (((-85.85923 4...
#> 8     9862   10188       10.5       10.9 MULTIPOLYGON (((-87.11047 4...
#> 9     8903    8781        7.3        7.2 MULTIPOLYGON (((-86.45828 4...
#> 10   13138   12750       10.8       10.5 MULTIPOLYGON (((-88.9252 46...
```

Since the addition of the `WKT1_ESRI` output from `sf::st_crs()` in sf
version 1.0-1, you can enter common CRS format (any that `sf::st_crs()`
can handle) into the `crs` parameters and it will be able to convert to
the ESRI formatted WKT needed for the outSR field in the REST query.

Below are examples of the variety of input types that you can use with
the `crs` parameters. All examples are just different formulations of
the ESRI:102690 CRS.

``` r
# ESRI Authority Code
df1 <- esri2sf(url, where = where, outFields = outFields, crs = "ESRI:102690")
#> ✔ Downloading "Coarse Counties" from
#>   <https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/3>
#> Layer type: "Feature Layer"
#> 
#> Geometry type: "esriGeometryPolygon"
#> 
#> Service Coordinate Reference System: "EPSG:4269"
#> 
#> Output Coordinate Reference System: "ESRI:102690"
# PROJ string
df2 <- esri2sf(url, where = where, outFields = outFields, crs = "+proj=lcc +lat_1=42.1 +lat_2=43.66666666666666 +lat_0=41.5 +lon_0=-84.36666666666666 +x_0=4000000 +y_0=0 +datum=NAD83 +units=us-ft +no_defs")
#> ✔ Downloading "Coarse Counties" from
#>   <https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/3>
#> Layer type: "Feature Layer"
#> 
#> Geometry type: "esriGeometryPolygon"
#> 
#> Service Coordinate Reference System: "EPSG:4269"
#> 
#> Output Coordinate Reference System: "+proj=lcc +lat_1=42.1
#> +lat_2=43.66666666666666 +lat_0=41.5 +lon_0=-84.36666666666666 +x_0=4000000
#> +y_0=0 +datum=NAD83 +units=us-ft +no_defs"
# OGC WKT
df3 <- esri2sf(url, where = where, outFields = outFields, crs = 'PROJCS["NAD_1983_StatePlane_Michigan_South_FIPS_2113_Feet",GEOGCS["GCS_North_American_1983",DATUM["North_American_Datum_1983",SPHEROID["GRS_1980",6378137,298.257222101]],PRIMEM["Greenwich",0],UNIT["Degree",0.017453292519943295]],PROJECTION["Lambert_Conformal_Conic_2SP"],PARAMETER["False_Easting",13123333.33333333],PARAMETER["False_Northing",0],PARAMETER["Central_Meridian",-84.36666666666666],PARAMETER["Standard_Parallel_1",42.1],PARAMETER["Standard_Parallel_2",43.66666666666666],PARAMETER["Latitude_Of_Origin",41.5],UNIT["Foot_US",0.30480060960121924],AUTHORITY["EPSG","102690"]]')
#> ✔ Downloading "Coarse Counties" from
#>   <https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/3>
#> Layer type: "Feature Layer"
#> 
#> Geometry type: "esriGeometryPolygon"
#> 
#> Service Coordinate Reference System: "EPSG:4269"
#> 
#> Output Coordinate Reference System:
#> "PROJCS[\"NAD_1983_StatePlane_Michigan_South_FIPS_2113_Feet\",GEOGCS[\"GCS_North_American_1983\",DATUM[\"North_American_Datum_1983\",SPHEROID[\"GRS_1980\",6378137,298.257222101]],PRIMEM[\"Greenwich\",0],UNIT[\"Degree\",0.017453292519943295]],PROJECTION[\"Lambert_Conformal_Conic_2SP\"],PARAMETER[\"False_Easting\",13123333.33333333],PARAMETER[\"False_Northing\",0],PARAMETER[\"Central_Meridian\",-84.36666666666666],PARAMETER[\"Standard_Parallel_1\",42.1],PARAMETER[\"Standard_Parallel_2\",43.66666666666666],PARAMETER[\"Latitude_Of_Origin\",41.5],UNIT[\"Foot_US\",0.30480060960121924],AUTHORITY[\"EPSG\",\"102690\"]]"
```

Their similarity on the output CRS can be proven by the following
function that calculates the mean difference in X-Y coordinates at each
point. All are very close to 0.

``` r
coord_diff <- function(df1, df2) {
  suppressWarnings({
    c(
      "x" = mean(sf::st_coordinates(sf::st_cast(df1, "POINT"))[, 1] - sf::st_coordinates(sf::st_cast(df2, "POINT"))[, 1]),
      "y" = mean(sf::st_coordinates(sf::st_cast(df1, "POINT"))[, 2] - sf::st_coordinates(sf::st_cast(df2, "POINT"))[, 2])
    )
  })
}
coord_diff(df1, df2)
#>             x             y 
#>  1.827251e-08 -1.191372e-09
coord_diff(df1, df3)
#>             x             y 
#>  1.827251e-08 -1.191372e-09
coord_diff(df2, df3)
#> x y 
#> 0 0
```
