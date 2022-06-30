# esri2df returns expected values [1]

    Code
      esri2df(url = url, objectIds = paste(1:10, collapse = ","))
    Message <cliMessage>
      v Downloading "AssetCondition"
      Layer type: "Table"
    Output
      # A tibble: 10 x 6
         OBJECTID FACILITYID FCLASS ASSETCOND CONDDATE REPLSCORE
            <int> <chr>      <chr>  <lgl>     <lgl>        <int>
       1        1 1          wMain  NA        NA               0
       2        2 2          wMain  NA        NA              45
       3        3 3          wMain  NA        NA              45
       4        4 4          wMain  NA        NA              45
       5        5 5          wMain  NA        NA              15
       6        6 6          wMain  NA        NA              15
       7        7 1          wMain  NA        NA               0
       8        8 2          wMain  NA        NA              45
       9        9 3          wMain  NA        NA              45
      10       10 4          wMain  NA        NA              45

---

    Code
      esri2df(url = url, where = "OBJECTID <= 10 AND FACILITYID = '4'")
    Message <cliMessage>
      v Downloading "AssetCondition"
      Layer type: "Table"
    Output
      # A tibble: 2 x 6
        OBJECTID FACILITYID FCLASS ASSETCOND CONDDATE REPLSCORE
           <int> <chr>      <chr>  <lgl>     <lgl>        <int>
      1        4 4          wMain  NA        NA              45
      2       10 4          wMain  NA        NA              45

