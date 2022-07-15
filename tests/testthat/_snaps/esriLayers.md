# esriLayers checks

    Code
      esriLayers(
        "https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/3")
    Output
      $currentVersion
      [1] 10.01
      
      $id
      [1] 3
      
      $name
      [1] "Coarse Counties"
      
      $type
      [1] "Feature Layer"
      
      $description
      [1] "This service presents various population statistics from Census 2000, including total population, population density, racial counts, and more. The map service presents statistics at the state, county, block group, and block point levels.\n"
      
      $definitionExpression
      [1] ""
      
      $geometryType
      [1] "esriGeometryPolygon"
      
      $copyrightText
      [1] "US Bureau of the Census: http://www.census.gov"
      
      $parentLayer
      $parentLayer$id
      [1] 2
      
      $parentLayer$name
      [1] "Counties"
      
      
      $subLayers
      list()
      
      $minScale
      [1] 0
      
      $maxScale
      [1] 1000001
      
      $defaultVisibility
      [1] TRUE
      
      $extent
      $extent$xmin
      [1] -178.2176
      
      $extent$ymin
      [1] 18.92179
      
      $extent$xmax
      [1] -66.96927
      
      $extent$ymax
      [1] 71.40624
      
      $extent$spatialReference
      $extent$spatialReference$wkid
      [1] 4269
      
      
      
      $hasAttachments
      [1] FALSE
      
      $htmlPopupType
      [1] "esriServerHTMLPopupTypeNone"
      
      $drawingInfo
      $drawingInfo$renderer
      $drawingInfo$renderer$type
      [1] "simple"
      
      $drawingInfo$renderer$symbol
      $drawingInfo$renderer$symbol$type
      [1] "esriSFS"
      
      $drawingInfo$renderer$symbol$style
      [1] "esriSFSSolid"
      
      $drawingInfo$renderer$symbol$color
      NULL
      
      $drawingInfo$renderer$symbol$outline
      $drawingInfo$renderer$symbol$outline$type
      [1] "esriSLS"
      
      $drawingInfo$renderer$symbol$outline$style
      [1] "esriSLSSolid"
      
      $drawingInfo$renderer$symbol$outline$color
      $drawingInfo$renderer$symbol$outline$color[[1]]
      [1] 0
      
      $drawingInfo$renderer$symbol$outline$color[[2]]
      [1] 0
      
      $drawingInfo$renderer$symbol$outline$color[[3]]
      [1] 0
      
      $drawingInfo$renderer$symbol$outline$color[[4]]
      [1] 255
      
      
      $drawingInfo$renderer$symbol$outline$width
      [1] 0.4
      
      
      
      $drawingInfo$renderer$label
      [1] ""
      
      $drawingInfo$renderer$description
      [1] ""
      
      
      $drawingInfo$transparency
      [1] 0
      
      $drawingInfo$labelingInfo
      NULL
      
      
      $displayField
      [1] "Name"
      
      $fields
      $fields[[1]]
      $fields[[1]]$name
      [1] "ObjectID"
      
      $fields[[1]]$type
      [1] "esriFieldTypeOID"
      
      $fields[[1]]$alias
      [1] "ObjectID"
      
      
      $fields[[2]]
      $fields[[2]]$name
      [1] "Shape"
      
      $fields[[2]]$type
      [1] "esriFieldTypeGeometry"
      
      $fields[[2]]$alias
      [1] "Shape"
      
      
      $fields[[3]]
      $fields[[3]]$name
      [1] "NAME"
      
      $fields[[3]]$type
      [1] "esriFieldTypeString"
      
      $fields[[3]]$alias
      [1] "NAME"
      
      $fields[[3]]$length
      [1] 32
      
      
      $fields[[4]]
      $fields[[4]]$name
      [1] "STATE_NAME"
      
      $fields[[4]]$type
      [1] "esriFieldTypeString"
      
      $fields[[4]]$alias
      [1] "STATE_NAME"
      
      $fields[[4]]$length
      [1] 25
      
      
      $fields[[5]]
      $fields[[5]]$name
      [1] "STATE_FIPS"
      
      $fields[[5]]$type
      [1] "esriFieldTypeString"
      
      $fields[[5]]$alias
      [1] "STATE_FIPS"
      
      $fields[[5]]$length
      [1] 2
      
      
      $fields[[6]]
      $fields[[6]]$name
      [1] "CNTY_FIPS"
      
      $fields[[6]]$type
      [1] "esriFieldTypeString"
      
      $fields[[6]]$alias
      [1] "CNTY_FIPS"
      
      $fields[[6]]$length
      [1] 3
      
      
      $fields[[7]]
      $fields[[7]]$name
      [1] "FIPS"
      
      $fields[[7]]$type
      [1] "esriFieldTypeString"
      
      $fields[[7]]$alias
      [1] "FIPS"
      
      $fields[[7]]$length
      [1] 5
      
      
      $fields[[8]]
      $fields[[8]]$name
      [1] "POP2000"
      
      $fields[[8]]$type
      [1] "esriFieldTypeInteger"
      
      $fields[[8]]$alias
      [1] "POP2000"
      
      
      $fields[[9]]
      $fields[[9]]$name
      [1] "POP2007"
      
      $fields[[9]]$type
      [1] "esriFieldTypeInteger"
      
      $fields[[9]]$alias
      [1] "POP2007"
      
      
      $fields[[10]]
      $fields[[10]]$name
      [1] "POP00_SQMI"
      
      $fields[[10]]$type
      [1] "esriFieldTypeDouble"
      
      $fields[[10]]$alias
      [1] "POP00_SQMI"
      
      
      $fields[[11]]
      $fields[[11]]$name
      [1] "POP07_SQMI"
      
      $fields[[11]]$type
      [1] "esriFieldTypeDouble"
      
      $fields[[11]]$alias
      [1] "POP07_SQMI"
      
      
      $fields[[12]]
      $fields[[12]]$name
      [1] "WHITE"
      
      $fields[[12]]$type
      [1] "esriFieldTypeInteger"
      
      $fields[[12]]$alias
      [1] "WHITE"
      
      
      $fields[[13]]
      $fields[[13]]$name
      [1] "BLACK"
      
      $fields[[13]]$type
      [1] "esriFieldTypeInteger"
      
      $fields[[13]]$alias
      [1] "BLACK"
      
      
      $fields[[14]]
      $fields[[14]]$name
      [1] "AMERI_ES"
      
      $fields[[14]]$type
      [1] "esriFieldTypeInteger"
      
      $fields[[14]]$alias
      [1] "AMERI_ES"
      
      
      $fields[[15]]
      $fields[[15]]$name
      [1] "ASIAN"
      
      $fields[[15]]$type
      [1] "esriFieldTypeInteger"
      
      $fields[[15]]$alias
      [1] "ASIAN"
      
      
      $fields[[16]]
      $fields[[16]]$name
      [1] "HAWN_PI"
      
      $fields[[16]]$type
      [1] "esriFieldTypeInteger"
      
      $fields[[16]]$alias
      [1] "HAWN_PI"
      
      
      $fields[[17]]
      $fields[[17]]$name
      [1] "OTHER"
      
      $fields[[17]]$type
      [1] "esriFieldTypeInteger"
      
      $fields[[17]]$alias
      [1] "OTHER"
      
      
      $fields[[18]]
      $fields[[18]]$name
      [1] "MULT_RACE"
      
      $fields[[18]]$type
      [1] "esriFieldTypeInteger"
      
      $fields[[18]]$alias
      [1] "MULT_RACE"
      
      
      $fields[[19]]
      $fields[[19]]$name
      [1] "HISPANIC"
      
      $fields[[19]]$type
      [1] "esriFieldTypeInteger"
      
      $fields[[19]]$alias
      [1] "HISPANIC"
      
      
      $fields[[20]]
      $fields[[20]]$name
      [1] "MALES"
      
      $fields[[20]]$type
      [1] "esriFieldTypeInteger"
      
      $fields[[20]]$alias
      [1] "MALES"
      
      
      $fields[[21]]
      $fields[[21]]$name
      [1] "FEMALES"
      
      $fields[[21]]$type
      [1] "esriFieldTypeInteger"
      
      $fields[[21]]$alias
      [1] "FEMALES"
      
      
      $fields[[22]]
      $fields[[22]]$name
      [1] "AGE_UNDER5"
      
      $fields[[22]]$type
      [1] "esriFieldTypeInteger"
      
      $fields[[22]]$alias
      [1] "AGE_UNDER5"
      
      
      $fields[[23]]
      $fields[[23]]$name
      [1] "AGE_5_17"
      
      $fields[[23]]$type
      [1] "esriFieldTypeInteger"
      
      $fields[[23]]$alias
      [1] "AGE_5_17"
      
      
      $fields[[24]]
      $fields[[24]]$name
      [1] "AGE_18_21"
      
      $fields[[24]]$type
      [1] "esriFieldTypeInteger"
      
      $fields[[24]]$alias
      [1] "AGE_18_21"
      
      
      $fields[[25]]
      $fields[[25]]$name
      [1] "AGE_22_29"
      
      $fields[[25]]$type
      [1] "esriFieldTypeInteger"
      
      $fields[[25]]$alias
      [1] "AGE_22_29"
      
      
      $fields[[26]]
      $fields[[26]]$name
      [1] "AGE_30_39"
      
      $fields[[26]]$type
      [1] "esriFieldTypeInteger"
      
      $fields[[26]]$alias
      [1] "AGE_30_39"
      
      
      $fields[[27]]
      $fields[[27]]$name
      [1] "AGE_40_49"
      
      $fields[[27]]$type
      [1] "esriFieldTypeInteger"
      
      $fields[[27]]$alias
      [1] "AGE_40_49"
      
      
      $fields[[28]]
      $fields[[28]]$name
      [1] "AGE_50_64"
      
      $fields[[28]]$type
      [1] "esriFieldTypeInteger"
      
      $fields[[28]]$alias
      [1] "AGE_50_64"
      
      
      $fields[[29]]
      $fields[[29]]$name
      [1] "AGE_65_UP"
      
      $fields[[29]]$type
      [1] "esriFieldTypeInteger"
      
      $fields[[29]]$alias
      [1] "AGE_65_UP"
      
      
      $fields[[30]]
      $fields[[30]]$name
      [1] "MED_AGE"
      
      $fields[[30]]$type
      [1] "esriFieldTypeDouble"
      
      $fields[[30]]$alias
      [1] "MED_AGE"
      
      
      $fields[[31]]
      $fields[[31]]$name
      [1] "MED_AGE_M"
      
      $fields[[31]]$type
      [1] "esriFieldTypeDouble"
      
      $fields[[31]]$alias
      [1] "MED_AGE_M"
      
      
      $fields[[32]]
      $fields[[32]]$name
      [1] "MED_AGE_F"
      
      $fields[[32]]$type
      [1] "esriFieldTypeDouble"
      
      $fields[[32]]$alias
      [1] "MED_AGE_F"
      
      
      $fields[[33]]
      $fields[[33]]$name
      [1] "HOUSEHOLDS"
      
      $fields[[33]]$type
      [1] "esriFieldTypeInteger"
      
      $fields[[33]]$alias
      [1] "HOUSEHOLDS"
      
      
      $fields[[34]]
      $fields[[34]]$name
      [1] "AVE_HH_SZ"
      
      $fields[[34]]$type
      [1] "esriFieldTypeDouble"
      
      $fields[[34]]$alias
      [1] "AVE_HH_SZ"
      
      
      $fields[[35]]
      $fields[[35]]$name
      [1] "HSEHLD_1_M"
      
      $fields[[35]]$type
      [1] "esriFieldTypeInteger"
      
      $fields[[35]]$alias
      [1] "HSEHLD_1_M"
      
      
      $fields[[36]]
      $fields[[36]]$name
      [1] "HSEHLD_1_F"
      
      $fields[[36]]$type
      [1] "esriFieldTypeInteger"
      
      $fields[[36]]$alias
      [1] "HSEHLD_1_F"
      
      
      $fields[[37]]
      $fields[[37]]$name
      [1] "MARHH_CHD"
      
      $fields[[37]]$type
      [1] "esriFieldTypeInteger"
      
      $fields[[37]]$alias
      [1] "MARHH_CHD"
      
      
      $fields[[38]]
      $fields[[38]]$name
      [1] "MARHH_NO_C"
      
      $fields[[38]]$type
      [1] "esriFieldTypeInteger"
      
      $fields[[38]]$alias
      [1] "MARHH_NO_C"
      
      
      $fields[[39]]
      $fields[[39]]$name
      [1] "MHH_CHILD"
      
      $fields[[39]]$type
      [1] "esriFieldTypeInteger"
      
      $fields[[39]]$alias
      [1] "MHH_CHILD"
      
      
      $fields[[40]]
      $fields[[40]]$name
      [1] "FHH_CHILD"
      
      $fields[[40]]$type
      [1] "esriFieldTypeInteger"
      
      $fields[[40]]$alias
      [1] "FHH_CHILD"
      
      
      $fields[[41]]
      $fields[[41]]$name
      [1] "FAMILIES"
      
      $fields[[41]]$type
      [1] "esriFieldTypeInteger"
      
      $fields[[41]]$alias
      [1] "FAMILIES"
      
      
      $fields[[42]]
      $fields[[42]]$name
      [1] "AVE_FAM_SZ"
      
      $fields[[42]]$type
      [1] "esriFieldTypeDouble"
      
      $fields[[42]]$alias
      [1] "AVE_FAM_SZ"
      
      
      $fields[[43]]
      $fields[[43]]$name
      [1] "HSE_UNITS"
      
      $fields[[43]]$type
      [1] "esriFieldTypeInteger"
      
      $fields[[43]]$alias
      [1] "HSE_UNITS"
      
      
      $fields[[44]]
      $fields[[44]]$name
      [1] "VACANT"
      
      $fields[[44]]$type
      [1] "esriFieldTypeInteger"
      
      $fields[[44]]$alias
      [1] "VACANT"
      
      
      $fields[[45]]
      $fields[[45]]$name
      [1] "OWNER_OCC"
      
      $fields[[45]]$type
      [1] "esriFieldTypeInteger"
      
      $fields[[45]]$alias
      [1] "OWNER_OCC"
      
      
      $fields[[46]]
      $fields[[46]]$name
      [1] "RENTER_OCC"
      
      $fields[[46]]$type
      [1] "esriFieldTypeInteger"
      
      $fields[[46]]$alias
      [1] "RENTER_OCC"
      
      
      $fields[[47]]
      $fields[[47]]$name
      [1] "NO_FARMS97"
      
      $fields[[47]]$type
      [1] "esriFieldTypeDouble"
      
      $fields[[47]]$alias
      [1] "NO_FARMS97"
      
      
      $fields[[48]]
      $fields[[48]]$name
      [1] "AVG_SIZE97"
      
      $fields[[48]]$type
      [1] "esriFieldTypeDouble"
      
      $fields[[48]]$alias
      [1] "AVG_SIZE97"
      
      
      $fields[[49]]
      $fields[[49]]$name
      [1] "CROP_ACR97"
      
      $fields[[49]]$type
      [1] "esriFieldTypeDouble"
      
      $fields[[49]]$alias
      [1] "CROP_ACR97"
      
      
      $fields[[50]]
      $fields[[50]]$name
      [1] "AVG_SALE97"
      
      $fields[[50]]$type
      [1] "esriFieldTypeDouble"
      
      $fields[[50]]$alias
      [1] "AVG_SALE97"
      
      
      $fields[[51]]
      $fields[[51]]$name
      [1] "SQMI"
      
      $fields[[51]]$type
      [1] "esriFieldTypeDouble"
      
      $fields[[51]]$alias
      [1] "SQMI"
      
      
      
      $typeIdField
      NULL
      
      $types
      NULL
      
      $relationships
      list()
      
      $capabilities
      [1] "Map,Query,Data"
      

---

    Code
      esriLayers(
        "https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/TaxParcel/AssessorsBasemap/MapServer")
    Output
      $currentVersion
      [1] 10.01
      
      $serviceDescription
      [1] "This sample service is used to provide an operational context with the Value Analysis Dashboard. The colors within this basemap have been muted intentionally because several overlays will be added to the base map. This map will be used primarily at the neighborhood and parcel scales. Geospatial data contained in this map service is provided by Bloomfield Township GIS, Bloomfield Township, MI. This is a sample service hosted by ESRI, powered by ArcGIS Server. ESRI has provided this example so that you may practice using ArcGIS APIs for JavaScript, Flex, and Silverlight. ESRI reserves the right to change or remove this service at any time and without notice."
      
      $mapName
      [1] "Layers"
      
      $description
      [1] "The assessor's base map is used to provide an operational context with the Value Analysis Dashboard. The colors within this basemap have been muted intentionally because several overlays will be added to the base map.  This map will be used primarily at the neighborhood and parcel scales.  Geospatial data contained in this map service is provided by Bloomfield Township GIS, Bloomfield Township, MI."
      
      $copyrightText
      [1] "Source: Bloomfield Township GIS, Bloomfield Township, MI"
      
      $layers
      $layers[[1]]
      $layers[[1]]$id
      [1] 0
      
      $layers[[1]]$name
      [1] "Tax Parcels"
      
      $layers[[1]]$parentLayerId
      [1] -1
      
      $layers[[1]]$defaultVisibility
      [1] TRUE
      
      $layers[[1]]$subLayerIds
      $layers[[1]]$subLayerIds[[1]]
      [1] 1
      
      
      $layers[[1]]$minScale
      [1] 0
      
      $layers[[1]]$maxScale
      [1] 0
      
      
      $layers[[2]]
      $layers[[2]]$id
      [1] 1
      
      $layers[[2]]$name
      [1] "Tax Parcels"
      
      $layers[[2]]$parentLayerId
      [1] 0
      
      $layers[[2]]$defaultVisibility
      [1] TRUE
      
      $layers[[2]]$subLayerIds
      NULL
      
      $layers[[2]]$minScale
      [1] 8000
      
      $layers[[2]]$maxScale
      [1] 0
      
      
      $layers[[3]]
      $layers[[3]]$id
      [1] 2
      
      $layers[[3]]$name
      [1] "Basemap"
      
      $layers[[3]]$parentLayerId
      [1] -1
      
      $layers[[3]]$defaultVisibility
      [1] TRUE
      
      $layers[[3]]$subLayerIds
      $layers[[3]]$subLayerIds[[1]]
      [1] 3
      
      $layers[[3]]$subLayerIds[[2]]
      [1] 18
      
      $layers[[3]]$subLayerIds[[3]]
      [1] 19
      
      $layers[[3]]$subLayerIds[[4]]
      [1] 24
      
      
      $layers[[3]]$minScale
      [1] 0
      
      $layers[[3]]$maxScale
      [1] 0
      
      
      $layers[[4]]
      $layers[[4]]$id
      [1] 3
      
      $layers[[4]]$name
      [1] "Transportation"
      
      $layers[[4]]$parentLayerId
      [1] 2
      
      $layers[[4]]$defaultVisibility
      [1] TRUE
      
      $layers[[4]]$subLayerIds
      $layers[[4]]$subLayerIds[[1]]
      [1] 4
      
      $layers[[4]]$subLayerIds[[2]]
      [1] 5
      
      $layers[[4]]$subLayerIds[[3]]
      [1] 6
      
      $layers[[4]]$subLayerIds[[4]]
      [1] 7
      
      $layers[[4]]$subLayerIds[[5]]
      [1] 8
      
      $layers[[4]]$subLayerIds[[6]]
      [1] 9
      
      $layers[[4]]$subLayerIds[[7]]
      [1] 10
      
      $layers[[4]]$subLayerIds[[8]]
      [1] 11
      
      $layers[[4]]$subLayerIds[[9]]
      [1] 12
      
      $layers[[4]]$subLayerIds[[10]]
      [1] 13
      
      $layers[[4]]$subLayerIds[[11]]
      [1] 14
      
      $layers[[4]]$subLayerIds[[12]]
      [1] 15
      
      $layers[[4]]$subLayerIds[[13]]
      [1] 16
      
      $layers[[4]]$subLayerIds[[14]]
      [1] 17
      
      
      $layers[[4]]$minScale
      [1] 0
      
      $layers[[4]]$maxScale
      [1] 0
      
      
      $layers[[5]]
      $layers[[5]]$id
      [1] 4
      
      $layers[[5]]$name
      [1] "Interstates <60K"
      
      $layers[[5]]$parentLayerId
      [1] 3
      
      $layers[[5]]$defaultVisibility
      [1] TRUE
      
      $layers[[5]]$subLayerIds
      NULL
      
      $layers[[5]]$minScale
      [1] 60000
      
      $layers[[5]]$maxScale
      [1] 0
      
      
      $layers[[6]]
      $layers[[6]]$id
      [1] 5
      
      $layers[[6]]$name
      [1] "Interstates >60K"
      
      $layers[[6]]$parentLayerId
      [1] 3
      
      $layers[[6]]$defaultVisibility
      [1] TRUE
      
      $layers[[6]]$subLayerIds
      NULL
      
      $layers[[6]]$minScale
      [1] 0
      
      $layers[[6]]$maxScale
      [1] 60001
      
      
      $layers[[7]]
      $layers[[7]]$id
      [1] 6
      
      $layers[[7]]$name
      [1] "US Highways"
      
      $layers[[7]]$parentLayerId
      [1] 3
      
      $layers[[7]]$defaultVisibility
      [1] TRUE
      
      $layers[[7]]$subLayerIds
      NULL
      
      $layers[[7]]$minScale
      [1] 0
      
      $layers[[7]]$maxScale
      [1] 0
      
      
      $layers[[8]]
      $layers[[8]]$id
      [1] 7
      
      $layers[[8]]$name
      [1] "Roads <4800"
      
      $layers[[8]]$parentLayerId
      [1] 3
      
      $layers[[8]]$defaultVisibility
      [1] TRUE
      
      $layers[[8]]$subLayerIds
      NULL
      
      $layers[[8]]$minScale
      [1] 4800
      
      $layers[[8]]$maxScale
      [1] 0
      
      
      $layers[[9]]
      $layers[[9]]$id
      [1] 8
      
      $layers[[9]]$name
      [1] "Roads >4800"
      
      $layers[[9]]$parentLayerId
      [1] 3
      
      $layers[[9]]$defaultVisibility
      [1] TRUE
      
      $layers[[9]]$subLayerIds
      NULL
      
      $layers[[9]]$minScale
      [1] 8000
      
      $layers[[9]]$maxScale
      [1] 4801
      
      
      $layers[[10]]
      $layers[[10]]$id
      [1] 9
      
      $layers[[10]]$name
      [1] "Right of Way"
      
      $layers[[10]]$parentLayerId
      [1] 3
      
      $layers[[10]]$defaultVisibility
      [1] TRUE
      
      $layers[[10]]$subLayerIds
      NULL
      
      $layers[[10]]$minScale
      [1] 15000
      
      $layers[[10]]$maxScale
      [1] 0
      
      
      $layers[[11]]
      $layers[[11]]$id
      [1] 10
      
      $layers[[11]]$name
      [1] "Private Roads"
      
      $layers[[11]]$parentLayerId
      [1] 3
      
      $layers[[11]]$defaultVisibility
      [1] TRUE
      
      $layers[[11]]$subLayerIds
      NULL
      
      $layers[[11]]$minScale
      [1] 8000
      
      $layers[[11]]$maxScale
      [1] 0
      
      
      $layers[[12]]
      $layers[[12]]$id
      [1] 11
      
      $layers[[12]]$name
      [1] "Major Roads >8K"
      
      $layers[[12]]$parentLayerId
      [1] 3
      
      $layers[[12]]$defaultVisibility
      [1] TRUE
      
      $layers[[12]]$subLayerIds
      NULL
      
      $layers[[12]]$minScale
      [1] 15000
      
      $layers[[12]]$maxScale
      [1] 8001
      
      
      $layers[[13]]
      $layers[[13]]$id
      [1] 12
      
      $layers[[13]]$name
      [1] "Minor Roads >8K"
      
      $layers[[13]]$parentLayerId
      [1] 3
      
      $layers[[13]]$defaultVisibility
      [1] TRUE
      
      $layers[[13]]$subLayerIds
      NULL
      
      $layers[[13]]$minScale
      [1] 15000
      
      $layers[[13]]$maxScale
      [1] 8001
      
      
      $layers[[14]]
      $layers[[14]]$id
      [1] 13
      
      $layers[[14]]$name
      [1] "Major Roads >15K"
      
      $layers[[14]]$parentLayerId
      [1] 3
      
      $layers[[14]]$defaultVisibility
      [1] TRUE
      
      $layers[[14]]$subLayerIds
      NULL
      
      $layers[[14]]$minScale
      [1] 25000
      
      $layers[[14]]$maxScale
      [1] 15001
      
      
      $layers[[15]]
      $layers[[15]]$id
      [1] 14
      
      $layers[[15]]$name
      [1] "Minor Roads >15K"
      
      $layers[[15]]$parentLayerId
      [1] 3
      
      $layers[[15]]$defaultVisibility
      [1] TRUE
      
      $layers[[15]]$subLayerIds
      NULL
      
      $layers[[15]]$minScale
      [1] 25000
      
      $layers[[15]]$maxScale
      [1] 15001
      
      
      $layers[[16]]
      $layers[[16]]$id
      [1] 15
      
      $layers[[16]]$name
      [1] "Major Roads >25K"
      
      $layers[[16]]$parentLayerId
      [1] 3
      
      $layers[[16]]$defaultVisibility
      [1] TRUE
      
      $layers[[16]]$subLayerIds
      NULL
      
      $layers[[16]]$minScale
      [1] 60000
      
      $layers[[16]]$maxScale
      [1] 25001
      
      
      $layers[[17]]
      $layers[[17]]$id
      [1] 16
      
      $layers[[17]]$name
      [1] "Minor Roads >25K"
      
      $layers[[17]]$parentLayerId
      [1] 3
      
      $layers[[17]]$defaultVisibility
      [1] TRUE
      
      $layers[[17]]$subLayerIds
      NULL
      
      $layers[[17]]$minScale
      [1] 40000
      
      $layers[[17]]$maxScale
      [1] 25001
      
      
      $layers[[18]]
      $layers[[18]]$id
      [1] 17
      
      $layers[[18]]$name
      [1] "Railroad"
      
      $layers[[18]]$parentLayerId
      [1] 3
      
      $layers[[18]]$defaultVisibility
      [1] TRUE
      
      $layers[[18]]$subLayerIds
      NULL
      
      $layers[[18]]$minScale
      [1] 0
      
      $layers[[18]]$maxScale
      [1] 0
      
      
      $layers[[19]]
      $layers[[19]]$id
      [1] 18
      
      $layers[[19]]$name
      [1] "Municipal District"
      
      $layers[[19]]$parentLayerId
      [1] 2
      
      $layers[[19]]$defaultVisibility
      [1] TRUE
      
      $layers[[19]]$subLayerIds
      NULL
      
      $layers[[19]]$minScale
      [1] 0
      
      $layers[[19]]$maxScale
      [1] 0
      
      
      $layers[[20]]
      $layers[[20]]$id
      [1] 19
      
      $layers[[20]]$name
      [1] "Hydrography"
      
      $layers[[20]]$parentLayerId
      [1] 2
      
      $layers[[20]]$defaultVisibility
      [1] TRUE
      
      $layers[[20]]$subLayerIds
      $layers[[20]]$subLayerIds[[1]]
      [1] 20
      
      $layers[[20]]$subLayerIds[[2]]
      [1] 21
      
      $layers[[20]]$subLayerIds[[3]]
      [1] 22
      
      $layers[[20]]$subLayerIds[[4]]
      [1] 23
      
      
      $layers[[20]]$minScale
      [1] 0
      
      $layers[[20]]$maxScale
      [1] 0
      
      
      $layers[[21]]
      $layers[[21]]$id
      [1] 20
      
      $layers[[21]]$name
      [1] "Waterbodies <50K"
      
      $layers[[21]]$parentLayerId
      [1] 19
      
      $layers[[21]]$defaultVisibility
      [1] TRUE
      
      $layers[[21]]$subLayerIds
      NULL
      
      $layers[[21]]$minScale
      [1] 50000
      
      $layers[[21]]$maxScale
      [1] 0
      
      
      $layers[[22]]
      $layers[[22]]$id
      [1] 21
      
      $layers[[22]]$name
      [1] "Waterway <50K"
      
      $layers[[22]]$parentLayerId
      [1] 19
      
      $layers[[22]]$defaultVisibility
      [1] TRUE
      
      $layers[[22]]$subLayerIds
      NULL
      
      $layers[[22]]$minScale
      [1] 50000
      
      $layers[[22]]$maxScale
      [1] 0
      
      
      $layers[[23]]
      $layers[[23]]$id
      [1] 22
      
      $layers[[23]]$name
      [1] "Waterbodies >50K"
      
      $layers[[23]]$parentLayerId
      [1] 19
      
      $layers[[23]]$defaultVisibility
      [1] TRUE
      
      $layers[[23]]$subLayerIds
      NULL
      
      $layers[[23]]$minScale
      [1] 0
      
      $layers[[23]]$maxScale
      [1] 50001
      
      
      $layers[[24]]
      $layers[[24]]$id
      [1] 23
      
      $layers[[24]]$name
      [1] "Waterway >50K"
      
      $layers[[24]]$parentLayerId
      [1] 19
      
      $layers[[24]]$defaultVisibility
      [1] TRUE
      
      $layers[[24]]$subLayerIds
      NULL
      
      $layers[[24]]$minScale
      [1] 0
      
      $layers[[24]]$maxScale
      [1] 50001
      
      
      $layers[[25]]
      $layers[[25]]$id
      [1] 24
      
      $layers[[25]]$name
      [1] "Facilities"
      
      $layers[[25]]$parentLayerId
      [1] 2
      
      $layers[[25]]$defaultVisibility
      [1] TRUE
      
      $layers[[25]]$subLayerIds
      $layers[[25]]$subLayerIds[[1]]
      [1] 25
      
      $layers[[25]]$subLayerIds[[2]]
      [1] 26
      
      
      $layers[[25]]$minScale
      [1] 0
      
      $layers[[25]]$maxScale
      [1] 0
      
      
      $layers[[26]]
      $layers[[26]]$id
      [1] 25
      
      $layers[[26]]$name
      [1] "FacilitySite <15K"
      
      $layers[[26]]$parentLayerId
      [1] 24
      
      $layers[[26]]$defaultVisibility
      [1] TRUE
      
      $layers[[26]]$subLayerIds
      NULL
      
      $layers[[26]]$minScale
      [1] 15000
      
      $layers[[26]]$maxScale
      [1] 0
      
      
      $layers[[27]]
      $layers[[27]]$id
      [1] 26
      
      $layers[[27]]$name
      [1] "Recreation Land"
      
      $layers[[27]]$parentLayerId
      [1] 24
      
      $layers[[27]]$defaultVisibility
      [1] TRUE
      
      $layers[[27]]$subLayerIds
      NULL
      
      $layers[[27]]$minScale
      [1] 15000
      
      $layers[[27]]$maxScale
      [1] 0
      
      
      $layers[[28]]
      $layers[[28]]$id
      [1] 27
      
      $layers[[28]]$name
      [1] "Taxing Districts"
      
      $layers[[28]]$parentLayerId
      [1] -1
      
      $layers[[28]]$defaultVisibility
      [1] TRUE
      
      $layers[[28]]$subLayerIds
      $layers[[28]]$subLayerIds[[1]]
      [1] 28
      
      $layers[[28]]$subLayerIds[[2]]
      [1] 29
      
      $layers[[28]]$subLayerIds[[3]]
      [1] 30
      
      $layers[[28]]$subLayerIds[[4]]
      [1] 31
      
      
      $layers[[28]]$minScale
      [1] 0
      
      $layers[[28]]$maxScale
      [1] 0
      
      
      $layers[[29]]
      $layers[[29]]$id
      [1] 28
      
      $layers[[29]]$name
      [1] "Assessment Neighborhoods"
      
      $layers[[29]]$parentLayerId
      [1] 27
      
      $layers[[29]]$defaultVisibility
      [1] TRUE
      
      $layers[[29]]$subLayerIds
      NULL
      
      $layers[[29]]$minScale
      [1] 15000
      
      $layers[[29]]$maxScale
      [1] 8001
      
      
      $layers[[30]]
      $layers[[30]]$id
      [1] 29
      
      $layers[[30]]$name
      [1] "School Tax District"
      
      $layers[[30]]$parentLayerId
      [1] 27
      
      $layers[[30]]$defaultVisibility
      [1] TRUE
      
      $layers[[30]]$subLayerIds
      NULL
      
      $layers[[30]]$minScale
      [1] 55000
      
      $layers[[30]]$maxScale
      [1] 15001
      
      
      $layers[[31]]
      $layers[[31]]$id
      [1] 30
      
      $layers[[31]]$name
      [1] "Local Tax District <55K"
      
      $layers[[31]]$parentLayerId
      [1] 27
      
      $layers[[31]]$defaultVisibility
      [1] TRUE
      
      $layers[[31]]$subLayerIds
      NULL
      
      $layers[[31]]$minScale
      [1] 55001
      
      $layers[[31]]$maxScale
      [1] 0
      
      
      $layers[[32]]
      $layers[[32]]$id
      [1] 31
      
      $layers[[32]]$name
      [1] "Local Tax District >55K"
      
      $layers[[32]]$parentLayerId
      [1] 27
      
      $layers[[32]]$defaultVisibility
      [1] TRUE
      
      $layers[[32]]$subLayerIds
      NULL
      
      $layers[[32]]$minScale
      [1] 0
      
      $layers[[32]]$maxScale
      [1] 55001
      
      
      $layers[[33]]
      $layers[[33]]$id
      [1] 32
      
      $layers[[33]]$name
      [1] "Hillshade"
      
      $layers[[33]]$parentLayerId
      [1] -1
      
      $layers[[33]]$defaultVisibility
      [1] TRUE
      
      $layers[[33]]$subLayerIds
      NULL
      
      $layers[[33]]$minScale
      [1] 0
      
      $layers[[33]]$maxScale
      [1] 0
      
      
      
      $tables
      $tables[[1]]
      $tables[[1]]$id
      [1] 33
      
      $tables[[1]]$name
      [1] "DYNAMICVALUE"
      
      
      
      $spatialReference
      $spatialReference$wkid
      [1] 4326
      
      
      $singleFusedMapCache
      [1] TRUE
      
      $tileInfo
      $tileInfo$rows
      [1] 512
      
      $tileInfo$cols
      [1] 512
      
      $tileInfo$dpi
      [1] 96
      
      $tileInfo$format
      [1] "JPEG"
      
      $tileInfo$compressionQuality
      [1] 90
      
      $tileInfo$origin
      $tileInfo$origin$x
      [1] -400
      
      $tileInfo$origin$y
      [1] 400
      
      
      $tileInfo$spatialReference
      $tileInfo$spatialReference$wkid
      [1] 4326
      
      
      $tileInfo$lods
      $tileInfo$lods[[1]]
      $tileInfo$lods[[1]]$level
      [1] 0
      
      $tileInfo$lods[[1]]$resolution
      [1] 0.0002974326
      
      $tileInfo$lods[[1]]$scale
      [1] 125000
      
      
      $tileInfo$lods[[2]]
      $tileInfo$lods[[2]]$level
      [1] 1
      
      $tileInfo$lods[[2]]$resolution
      [1] 0.0001522855
      
      $tileInfo$lods[[2]]$scale
      [1] 64000
      
      
      $tileInfo$lods[[3]]
      $tileInfo$lods[[3]]$level
      [1] 2
      
      $tileInfo$lods[[3]]$resolution
      [1] 7.614275e-05
      
      $tileInfo$lods[[3]]$scale
      [1] 32000
      
      
      $tileInfo$lods[[4]]
      $tileInfo$lods[[4]]$level
      [1] 3
      
      $tileInfo$lods[[4]]$resolution
      [1] 3.807138e-05
      
      $tileInfo$lods[[4]]$scale
      [1] 16000
      
      
      $tileInfo$lods[[5]]
      $tileInfo$lods[[5]]$level
      [1] 4
      
      $tileInfo$lods[[5]]$resolution
      [1] 1.903331e-05
      
      $tileInfo$lods[[5]]$scale
      [1] 7999
      
      
      $tileInfo$lods[[6]]
      $tileInfo$lods[[6]]$level
      [1] 5
      
      $tileInfo$lods[[6]]$resolution
      [1] 9.515465e-06
      
      $tileInfo$lods[[6]]$scale
      [1] 3999
      
      
      $tileInfo$lods[[7]]
      $tileInfo$lods[[7]]$level
      [1] 6
      
      $tileInfo$lods[[7]]$resolution
      [1] 4.758922e-06
      
      $tileInfo$lods[[7]]$scale
      [1] 2000
      
      
      $tileInfo$lods[[8]]
      $tileInfo$lods[[8]]$level
      [1] 7
      
      $tileInfo$lods[[8]]$resolution
      [1] 2.379461e-06
      
      $tileInfo$lods[[8]]$scale
      [1] 1000
      
      
      $tileInfo$lods[[9]]
      $tileInfo$lods[[9]]$level
      [1] 8
      
      $tileInfo$lods[[9]]$resolution
      [1] 1.784596e-06
      
      $tileInfo$lods[[9]]$scale
      [1] 750
      
      
      $tileInfo$lods[[10]]
      $tileInfo$lods[[10]]$level
      [1] 9
      
      $tileInfo$lods[[10]]$resolution
      [1] 1.189731e-06
      
      $tileInfo$lods[[10]]$scale
      [1] 500
      
      
      
      
      $initialExtent
      $initialExtent$xmin
      [1] -83.31369
      
      $initialExtent$ymin
      [1] 42.55829
      
      $initialExtent$xmax
      [1] -83.30237
      
      $initialExtent$ymax
      [1] 42.56714
      
      $initialExtent$spatialReference
      $initialExtent$spatialReference$wkid
      [1] 4326
      
      
      
      $fullExtent
      $fullExtent$xmin
      [1] -83.3771
      
      $fullExtent$ymin
      [1] 42.52335
      
      $fullExtent$xmax
      [1] -83.15089
      
      $fullExtent$ymax
      [1] 42.6259
      
      $fullExtent$spatialReference
      $fullExtent$spatialReference$wkid
      [1] 4326
      
      
      
      $units
      [1] "esriDecimalDegrees"
      
      $supportedImageFormatTypes
      [1] "PNG24,PNG,JPG,DIB,TIFF,EMF,PS,PDF,GIF,SVG,SVGZ,AI,BMP"
      
      $documentInfo
      $documentInfo$Title
      [1] "Assessor's Basemap"
      
      $documentInfo$Author
      [1] "ESRI"
      
      $documentInfo$Comments
      [1] ""
      
      $documentInfo$Subject
      [1] ""
      
      $documentInfo$Category
      [1] ""
      
      $documentInfo$Keywords
      [1] ""
      
      $documentInfo$Credits
      [1] ""
      
      
      $capabilities
      [1] "Map,Query,Data"
      

---

    Code
      esriLayers(
        "https://carto.nationalmap.gov/arcgis/rest/services/contours/MapServer")
    Output
      $currentVersion
      [1] 10.81
      
      $serviceDescription
      [1] "The USGS Elevation Contours service from The National Map displays contours generated for the United States at various scales. Small-scale contours were created by USGS TNM from 1 arc-second data with 100-meter contours, and are visible at 1:600,000 and smaller scales. Medium-scale contours were created by USGS EROS from 1/3-arc-second data with 100-foot intervals, and are visible between 1:150,000 and 1:600,000. Additional medium-scale contours were created by USGS EROS from 1/3-arc-second data with 50-foot intervals, and are visible between 1:50,000 and 1:150,000. Large scale contours are updated every quarter, and are created by USGS TNM for the 7.5' 1:24,000-scale US Topo digital map series. These contours are derived from 1/3 arc-second or better resolution data, and are visible at scales 1:50,000 and larger. Large scale contour intervals are variable across the United States depending on complexity of topography, and as contours are generated per US Topo quadrangle, lines may not match across quad boundaries. The National Map download client allows free downloads of public domain contour data in either Esri File Geodatabase or Shapefile formats. The 3D Elevation Program (3DEP) provides elevation data for The National Map and basic elevation information for earth science studies and mapping applications. Scientists and resource managers use elevation data for global change research, hydrologic modeling, resource monitoring, mapping and visualization, and many other applications. For additional information on 3DEP, go to http://nationalmap.gov/3DEP/. \n"
      
      $mapName
      [1] "Layers"
      
      $description
      [1] "Elevation"
      
      $copyrightText
      [1] "USGS The National Map: 3D Elevation Program. Data Refreshed July, 2022."
      
      $supportsDynamicLayers
      [1] TRUE
      
      $layers
      $layers[[1]]
      $layers[[1]]$id
      [1] 0
      
      $layers[[1]]$name
      [1] "Contours - Small-Scale"
      
      $layers[[1]]$parentLayerId
      [1] -1
      
      $layers[[1]]$defaultVisibility
      [1] TRUE
      
      $layers[[1]]$subLayerIds
      $layers[[1]]$subLayerIds[[1]]
      [1] 1
      
      $layers[[1]]$subLayerIds[[2]]
      [1] 2
      
      $layers[[1]]$subLayerIds[[3]]
      [1] 3
      
      $layers[[1]]$subLayerIds[[4]]
      [1] 4
      
      $layers[[1]]$subLayerIds[[5]]
      [1] 5
      
      $layers[[1]]$subLayerIds[[6]]
      [1] 6
      
      $layers[[1]]$subLayerIds[[7]]
      [1] 7
      
      $layers[[1]]$subLayerIds[[8]]
      [1] 8
      
      
      $layers[[1]]$minScale
      [1] 3000000
      
      $layers[[1]]$maxScale
      [1] 600001
      
      $layers[[1]]$type
      [1] "Group Layer"
      
      
      $layers[[2]]
      $layers[[2]]$id
      [1] 1
      
      $layers[[2]]$name
      [1] "Continental US Labels"
      
      $layers[[2]]$parentLayerId
      [1] 0
      
      $layers[[2]]$defaultVisibility
      [1] TRUE
      
      $layers[[2]]$subLayerIds
      NULL
      
      $layers[[2]]$minScale
      [1] 0
      
      $layers[[2]]$maxScale
      [1] 0
      
      $layers[[2]]$type
      [1] "Feature Layer"
      
      $layers[[2]]$geometryType
      [1] "esriGeometryPolyline"
      
      
      $layers[[3]]
      $layers[[3]]$id
      [1] 2
      
      $layers[[3]]$name
      [1] "Continental US Contours"
      
      $layers[[3]]$parentLayerId
      [1] 0
      
      $layers[[3]]$defaultVisibility
      [1] TRUE
      
      $layers[[3]]$subLayerIds
      NULL
      
      $layers[[3]]$minScale
      [1] 0
      
      $layers[[3]]$maxScale
      [1] 0
      
      $layers[[3]]$type
      [1] "Feature Layer"
      
      $layers[[3]]$geometryType
      [1] "esriGeometryPolyline"
      
      
      $layers[[4]]
      $layers[[4]]$id
      [1] 3
      
      $layers[[4]]$name
      [1] "Alaska Labels"
      
      $layers[[4]]$parentLayerId
      [1] 0
      
      $layers[[4]]$defaultVisibility
      [1] TRUE
      
      $layers[[4]]$subLayerIds
      NULL
      
      $layers[[4]]$minScale
      [1] 0
      
      $layers[[4]]$maxScale
      [1] 0
      
      $layers[[4]]$type
      [1] "Feature Layer"
      
      $layers[[4]]$geometryType
      [1] "esriGeometryPolyline"
      
      
      $layers[[5]]
      $layers[[5]]$id
      [1] 4
      
      $layers[[5]]$name
      [1] "Alaska Contours"
      
      $layers[[5]]$parentLayerId
      [1] 0
      
      $layers[[5]]$defaultVisibility
      [1] TRUE
      
      $layers[[5]]$subLayerIds
      NULL
      
      $layers[[5]]$minScale
      [1] 0
      
      $layers[[5]]$maxScale
      [1] 0
      
      $layers[[5]]$type
      [1] "Feature Layer"
      
      $layers[[5]]$geometryType
      [1] "esriGeometryPolyline"
      
      
      $layers[[6]]
      $layers[[6]]$id
      [1] 5
      
      $layers[[6]]$name
      [1] "Hawaii Labels"
      
      $layers[[6]]$parentLayerId
      [1] 0
      
      $layers[[6]]$defaultVisibility
      [1] TRUE
      
      $layers[[6]]$subLayerIds
      NULL
      
      $layers[[6]]$minScale
      [1] 0
      
      $layers[[6]]$maxScale
      [1] 0
      
      $layers[[6]]$type
      [1] "Feature Layer"
      
      $layers[[6]]$geometryType
      [1] "esriGeometryPolyline"
      
      
      $layers[[7]]
      $layers[[7]]$id
      [1] 6
      
      $layers[[7]]$name
      [1] "Hawaii Contours"
      
      $layers[[7]]$parentLayerId
      [1] 0
      
      $layers[[7]]$defaultVisibility
      [1] TRUE
      
      $layers[[7]]$subLayerIds
      NULL
      
      $layers[[7]]$minScale
      [1] 0
      
      $layers[[7]]$maxScale
      [1] 0
      
      $layers[[7]]$type
      [1] "Feature Layer"
      
      $layers[[7]]$geometryType
      [1] "esriGeometryPolyline"
      
      
      $layers[[8]]
      $layers[[8]]$id
      [1] 7
      
      $layers[[8]]$name
      [1] "Puerto Rico/VI Labels"
      
      $layers[[8]]$parentLayerId
      [1] 0
      
      $layers[[8]]$defaultVisibility
      [1] TRUE
      
      $layers[[8]]$subLayerIds
      NULL
      
      $layers[[8]]$minScale
      [1] 0
      
      $layers[[8]]$maxScale
      [1] 0
      
      $layers[[8]]$type
      [1] "Feature Layer"
      
      $layers[[8]]$geometryType
      [1] "esriGeometryPolyline"
      
      
      $layers[[9]]
      $layers[[9]]$id
      [1] 8
      
      $layers[[9]]$name
      [1] "Puerto Rico/VI Contours"
      
      $layers[[9]]$parentLayerId
      [1] 0
      
      $layers[[9]]$defaultVisibility
      [1] TRUE
      
      $layers[[9]]$subLayerIds
      NULL
      
      $layers[[9]]$minScale
      [1] 0
      
      $layers[[9]]$maxScale
      [1] 0
      
      $layers[[9]]$type
      [1] "Feature Layer"
      
      $layers[[9]]$geometryType
      [1] "esriGeometryPolyline"
      
      
      $layers[[10]]
      $layers[[10]]$id
      [1] 9
      
      $layers[[10]]$name
      [1] "Contours - 100-Foot"
      
      $layers[[10]]$parentLayerId
      [1] -1
      
      $layers[[10]]$defaultVisibility
      [1] TRUE
      
      $layers[[10]]$subLayerIds
      $layers[[10]]$subLayerIds[[1]]
      [1] 10
      
      $layers[[10]]$subLayerIds[[2]]
      [1] 11
      
      $layers[[10]]$subLayerIds[[3]]
      [1] 12
      
      $layers[[10]]$subLayerIds[[4]]
      [1] 13
      
      
      $layers[[10]]$minScale
      [1] 600000
      
      $layers[[10]]$maxScale
      [1] 150001
      
      $layers[[10]]$type
      [1] "Group Layer"
      
      
      $layers[[11]]
      $layers[[11]]$id
      [1] 10
      
      $layers[[11]]$name
      [1] "Index Labels"
      
      $layers[[11]]$parentLayerId
      [1] 9
      
      $layers[[11]]$defaultVisibility
      [1] TRUE
      
      $layers[[11]]$subLayerIds
      NULL
      
      $layers[[11]]$minScale
      [1] 0
      
      $layers[[11]]$maxScale
      [1] 0
      
      $layers[[11]]$type
      [1] "Feature Layer"
      
      $layers[[11]]$geometryType
      [1] "esriGeometryPolyline"
      
      
      $layers[[12]]
      $layers[[12]]$id
      [1] 11
      
      $layers[[12]]$name
      [1] "Index Contours"
      
      $layers[[12]]$parentLayerId
      [1] 9
      
      $layers[[12]]$defaultVisibility
      [1] TRUE
      
      $layers[[12]]$subLayerIds
      NULL
      
      $layers[[12]]$minScale
      [1] 0
      
      $layers[[12]]$maxScale
      [1] 0
      
      $layers[[12]]$type
      [1] "Feature Layer"
      
      $layers[[12]]$geometryType
      [1] "esriGeometryPolyline"
      
      
      $layers[[13]]
      $layers[[13]]$id
      [1] 12
      
      $layers[[13]]$name
      [1] "Intermediate Labels"
      
      $layers[[13]]$parentLayerId
      [1] 9
      
      $layers[[13]]$defaultVisibility
      [1] TRUE
      
      $layers[[13]]$subLayerIds
      NULL
      
      $layers[[13]]$minScale
      [1] 0
      
      $layers[[13]]$maxScale
      [1] 0
      
      $layers[[13]]$type
      [1] "Feature Layer"
      
      $layers[[13]]$geometryType
      [1] "esriGeometryPolyline"
      
      
      $layers[[14]]
      $layers[[14]]$id
      [1] 13
      
      $layers[[14]]$name
      [1] "Intermediate Contours"
      
      $layers[[14]]$parentLayerId
      [1] 9
      
      $layers[[14]]$defaultVisibility
      [1] TRUE
      
      $layers[[14]]$subLayerIds
      NULL
      
      $layers[[14]]$minScale
      [1] 0
      
      $layers[[14]]$maxScale
      [1] 0
      
      $layers[[14]]$type
      [1] "Feature Layer"
      
      $layers[[14]]$geometryType
      [1] "esriGeometryPolyline"
      
      
      $layers[[15]]
      $layers[[15]]$id
      [1] 14
      
      $layers[[15]]$name
      [1] "Contours - 50-Foot"
      
      $layers[[15]]$parentLayerId
      [1] -1
      
      $layers[[15]]$defaultVisibility
      [1] TRUE
      
      $layers[[15]]$subLayerIds
      $layers[[15]]$subLayerIds[[1]]
      [1] 15
      
      $layers[[15]]$subLayerIds[[2]]
      [1] 16
      
      $layers[[15]]$subLayerIds[[3]]
      [1] 17
      
      $layers[[15]]$subLayerIds[[4]]
      [1] 18
      
      
      $layers[[15]]$minScale
      [1] 150000
      
      $layers[[15]]$maxScale
      [1] 50001
      
      $layers[[15]]$type
      [1] "Group Layer"
      
      
      $layers[[16]]
      $layers[[16]]$id
      [1] 15
      
      $layers[[16]]$name
      [1] "Index Labels"
      
      $layers[[16]]$parentLayerId
      [1] 14
      
      $layers[[16]]$defaultVisibility
      [1] TRUE
      
      $layers[[16]]$subLayerIds
      NULL
      
      $layers[[16]]$minScale
      [1] 0
      
      $layers[[16]]$maxScale
      [1] 0
      
      $layers[[16]]$type
      [1] "Feature Layer"
      
      $layers[[16]]$geometryType
      [1] "esriGeometryPolyline"
      
      
      $layers[[17]]
      $layers[[17]]$id
      [1] 16
      
      $layers[[17]]$name
      [1] "Index Contours"
      
      $layers[[17]]$parentLayerId
      [1] 14
      
      $layers[[17]]$defaultVisibility
      [1] TRUE
      
      $layers[[17]]$subLayerIds
      NULL
      
      $layers[[17]]$minScale
      [1] 0
      
      $layers[[17]]$maxScale
      [1] 0
      
      $layers[[17]]$type
      [1] "Feature Layer"
      
      $layers[[17]]$geometryType
      [1] "esriGeometryPolyline"
      
      
      $layers[[18]]
      $layers[[18]]$id
      [1] 17
      
      $layers[[18]]$name
      [1] "Intermediate Labels"
      
      $layers[[18]]$parentLayerId
      [1] 14
      
      $layers[[18]]$defaultVisibility
      [1] TRUE
      
      $layers[[18]]$subLayerIds
      NULL
      
      $layers[[18]]$minScale
      [1] 0
      
      $layers[[18]]$maxScale
      [1] 0
      
      $layers[[18]]$type
      [1] "Feature Layer"
      
      $layers[[18]]$geometryType
      [1] "esriGeometryPolyline"
      
      
      $layers[[19]]
      $layers[[19]]$id
      [1] 18
      
      $layers[[19]]$name
      [1] "Intermediate Contours"
      
      $layers[[19]]$parentLayerId
      [1] 14
      
      $layers[[19]]$defaultVisibility
      [1] TRUE
      
      $layers[[19]]$subLayerIds
      NULL
      
      $layers[[19]]$minScale
      [1] 0
      
      $layers[[19]]$maxScale
      [1] 0
      
      $layers[[19]]$type
      [1] "Feature Layer"
      
      $layers[[19]]$geometryType
      [1] "esriGeometryPolyline"
      
      
      $layers[[20]]
      $layers[[20]]$id
      [1] 19
      
      $layers[[20]]$name
      [1] "Contours - Large-Scale"
      
      $layers[[20]]$parentLayerId
      [1] -1
      
      $layers[[20]]$defaultVisibility
      [1] TRUE
      
      $layers[[20]]$subLayerIds
      $layers[[20]]$subLayerIds[[1]]
      [1] 20
      
      $layers[[20]]$subLayerIds[[2]]
      [1] 24
      
      $layers[[20]]$subLayerIds[[3]]
      [1] 28
      
      $layers[[20]]$subLayerIds[[4]]
      [1] 32
      
      
      $layers[[20]]$minScale
      [1] 50000
      
      $layers[[20]]$maxScale
      [1] 0
      
      $layers[[20]]$type
      [1] "Group Layer"
      
      
      $layers[[21]]
      $layers[[21]]$id
      [1] 20
      
      $layers[[21]]$name
      [1] "Normal Labels"
      
      $layers[[21]]$parentLayerId
      [1] 19
      
      $layers[[21]]$defaultVisibility
      [1] TRUE
      
      $layers[[21]]$subLayerIds
      $layers[[21]]$subLayerIds[[1]]
      [1] 21
      
      $layers[[21]]$subLayerIds[[2]]
      [1] 22
      
      $layers[[21]]$subLayerIds[[3]]
      [1] 23
      
      
      $layers[[21]]$minScale
      [1] 0
      
      $layers[[21]]$maxScale
      [1] 0
      
      $layers[[21]]$type
      [1] "Group Layer"
      
      
      $layers[[22]]
      $layers[[22]]$id
      [1] 21
      
      $layers[[22]]$name
      [1] "Normal Index Labels"
      
      $layers[[22]]$parentLayerId
      [1] 20
      
      $layers[[22]]$defaultVisibility
      [1] TRUE
      
      $layers[[22]]$subLayerIds
      NULL
      
      $layers[[22]]$minScale
      [1] 0
      
      $layers[[22]]$maxScale
      [1] 0
      
      $layers[[22]]$type
      [1] "Feature Layer"
      
      $layers[[22]]$geometryType
      [1] "esriGeometryPolyline"
      
      
      $layers[[23]]
      $layers[[23]]$id
      [1] 22
      
      $layers[[23]]$name
      [1] "Normal Intermediate Labels"
      
      $layers[[23]]$parentLayerId
      [1] 20
      
      $layers[[23]]$defaultVisibility
      [1] TRUE
      
      $layers[[23]]$subLayerIds
      NULL
      
      $layers[[23]]$minScale
      [1] 0
      
      $layers[[23]]$maxScale
      [1] 0
      
      $layers[[23]]$type
      [1] "Feature Layer"
      
      $layers[[23]]$geometryType
      [1] "esriGeometryPolyline"
      
      
      $layers[[24]]
      $layers[[24]]$id
      [1] 23
      
      $layers[[24]]$name
      [1] "Normal Supplemental Labels"
      
      $layers[[24]]$parentLayerId
      [1] 20
      
      $layers[[24]]$defaultVisibility
      [1] FALSE
      
      $layers[[24]]$subLayerIds
      NULL
      
      $layers[[24]]$minScale
      [1] 0
      
      $layers[[24]]$maxScale
      [1] 0
      
      $layers[[24]]$type
      [1] "Feature Layer"
      
      $layers[[24]]$geometryType
      [1] "esriGeometryPolyline"
      
      
      $layers[[25]]
      $layers[[25]]$id
      [1] 24
      
      $layers[[25]]$name
      [1] "Normal Contours"
      
      $layers[[25]]$parentLayerId
      [1] 19
      
      $layers[[25]]$defaultVisibility
      [1] TRUE
      
      $layers[[25]]$subLayerIds
      $layers[[25]]$subLayerIds[[1]]
      [1] 25
      
      $layers[[25]]$subLayerIds[[2]]
      [1] 26
      
      $layers[[25]]$subLayerIds[[3]]
      [1] 27
      
      
      $layers[[25]]$minScale
      [1] 0
      
      $layers[[25]]$maxScale
      [1] 0
      
      $layers[[25]]$type
      [1] "Group Layer"
      
      
      $layers[[26]]
      $layers[[26]]$id
      [1] 25
      
      $layers[[26]]$name
      [1] "Normal Index Contours"
      
      $layers[[26]]$parentLayerId
      [1] 24
      
      $layers[[26]]$defaultVisibility
      [1] TRUE
      
      $layers[[26]]$subLayerIds
      NULL
      
      $layers[[26]]$minScale
      [1] 0
      
      $layers[[26]]$maxScale
      [1] 0
      
      $layers[[26]]$type
      [1] "Feature Layer"
      
      $layers[[26]]$geometryType
      [1] "esriGeometryPolyline"
      
      
      $layers[[27]]
      $layers[[27]]$id
      [1] 26
      
      $layers[[27]]$name
      [1] "Normal Intermediate Contours"
      
      $layers[[27]]$parentLayerId
      [1] 24
      
      $layers[[27]]$defaultVisibility
      [1] TRUE
      
      $layers[[27]]$subLayerIds
      NULL
      
      $layers[[27]]$minScale
      [1] 0
      
      $layers[[27]]$maxScale
      [1] 0
      
      $layers[[27]]$type
      [1] "Feature Layer"
      
      $layers[[27]]$geometryType
      [1] "esriGeometryPolyline"
      
      
      $layers[[28]]
      $layers[[28]]$id
      [1] 27
      
      $layers[[28]]$name
      [1] "Normal Supplemental Contours"
      
      $layers[[28]]$parentLayerId
      [1] 24
      
      $layers[[28]]$defaultVisibility
      [1] FALSE
      
      $layers[[28]]$subLayerIds
      NULL
      
      $layers[[28]]$minScale
      [1] 0
      
      $layers[[28]]$maxScale
      [1] 0
      
      $layers[[28]]$type
      [1] "Feature Layer"
      
      $layers[[28]]$geometryType
      [1] "esriGeometryPolyline"
      
      
      $layers[[29]]
      $layers[[29]]$id
      [1] 28
      
      $layers[[29]]$name
      [1] "Depression Labels"
      
      $layers[[29]]$parentLayerId
      [1] 19
      
      $layers[[29]]$defaultVisibility
      [1] FALSE
      
      $layers[[29]]$subLayerIds
      $layers[[29]]$subLayerIds[[1]]
      [1] 29
      
      $layers[[29]]$subLayerIds[[2]]
      [1] 30
      
      $layers[[29]]$subLayerIds[[3]]
      [1] 31
      
      
      $layers[[29]]$minScale
      [1] 0
      
      $layers[[29]]$maxScale
      [1] 0
      
      $layers[[29]]$type
      [1] "Group Layer"
      
      
      $layers[[30]]
      $layers[[30]]$id
      [1] 29
      
      $layers[[30]]$name
      [1] "Depression Index Labels"
      
      $layers[[30]]$parentLayerId
      [1] 28
      
      $layers[[30]]$defaultVisibility
      [1] TRUE
      
      $layers[[30]]$subLayerIds
      NULL
      
      $layers[[30]]$minScale
      [1] 0
      
      $layers[[30]]$maxScale
      [1] 0
      
      $layers[[30]]$type
      [1] "Feature Layer"
      
      $layers[[30]]$geometryType
      [1] "esriGeometryPolyline"
      
      
      $layers[[31]]
      $layers[[31]]$id
      [1] 30
      
      $layers[[31]]$name
      [1] "Depression Intermediate Labels"
      
      $layers[[31]]$parentLayerId
      [1] 28
      
      $layers[[31]]$defaultVisibility
      [1] TRUE
      
      $layers[[31]]$subLayerIds
      NULL
      
      $layers[[31]]$minScale
      [1] 0
      
      $layers[[31]]$maxScale
      [1] 0
      
      $layers[[31]]$type
      [1] "Feature Layer"
      
      $layers[[31]]$geometryType
      [1] "esriGeometryPolyline"
      
      
      $layers[[32]]
      $layers[[32]]$id
      [1] 31
      
      $layers[[32]]$name
      [1] "Depression Supplemental Labels"
      
      $layers[[32]]$parentLayerId
      [1] 28
      
      $layers[[32]]$defaultVisibility
      [1] TRUE
      
      $layers[[32]]$subLayerIds
      NULL
      
      $layers[[32]]$minScale
      [1] 0
      
      $layers[[32]]$maxScale
      [1] 0
      
      $layers[[32]]$type
      [1] "Feature Layer"
      
      $layers[[32]]$geometryType
      [1] "esriGeometryPolyline"
      
      
      $layers[[33]]
      $layers[[33]]$id
      [1] 32
      
      $layers[[33]]$name
      [1] "Depression Contours"
      
      $layers[[33]]$parentLayerId
      [1] 19
      
      $layers[[33]]$defaultVisibility
      [1] FALSE
      
      $layers[[33]]$subLayerIds
      $layers[[33]]$subLayerIds[[1]]
      [1] 33
      
      $layers[[33]]$subLayerIds[[2]]
      [1] 34
      
      $layers[[33]]$subLayerIds[[3]]
      [1] 35
      
      
      $layers[[33]]$minScale
      [1] 0
      
      $layers[[33]]$maxScale
      [1] 0
      
      $layers[[33]]$type
      [1] "Group Layer"
      
      
      $layers[[34]]
      $layers[[34]]$id
      [1] 33
      
      $layers[[34]]$name
      [1] "Depression Index Contours"
      
      $layers[[34]]$parentLayerId
      [1] 32
      
      $layers[[34]]$defaultVisibility
      [1] TRUE
      
      $layers[[34]]$subLayerIds
      NULL
      
      $layers[[34]]$minScale
      [1] 0
      
      $layers[[34]]$maxScale
      [1] 0
      
      $layers[[34]]$type
      [1] "Feature Layer"
      
      $layers[[34]]$geometryType
      [1] "esriGeometryPolyline"
      
      
      $layers[[35]]
      $layers[[35]]$id
      [1] 34
      
      $layers[[35]]$name
      [1] "Depression Intermediate Contours"
      
      $layers[[35]]$parentLayerId
      [1] 32
      
      $layers[[35]]$defaultVisibility
      [1] TRUE
      
      $layers[[35]]$subLayerIds
      NULL
      
      $layers[[35]]$minScale
      [1] 0
      
      $layers[[35]]$maxScale
      [1] 0
      
      $layers[[35]]$type
      [1] "Feature Layer"
      
      $layers[[35]]$geometryType
      [1] "esriGeometryPolyline"
      
      
      $layers[[36]]
      $layers[[36]]$id
      [1] 35
      
      $layers[[36]]$name
      [1] "Depression Supplemental Contours"
      
      $layers[[36]]$parentLayerId
      [1] 32
      
      $layers[[36]]$defaultVisibility
      [1] TRUE
      
      $layers[[36]]$subLayerIds
      NULL
      
      $layers[[36]]$minScale
      [1] 0
      
      $layers[[36]]$maxScale
      [1] 0
      
      $layers[[36]]$type
      [1] "Feature Layer"
      
      $layers[[36]]$geometryType
      [1] "esriGeometryPolyline"
      
      
      
      $tables
      list()
      
      $spatialReference
      $spatialReference$wkid
      [1] 102100
      
      $spatialReference$latestWkid
      [1] 3857
      
      
      $singleFusedMapCache
      [1] FALSE
      
      $initialExtent
      $initialExtent$xmin
      [1] -9944377
      
      $initialExtent$ymin
      [1] 5204490
      
      $initialExtent$xmax
      [1] -9941849
      
      $initialExtent$ymax
      [1] 5205233
      
      $initialExtent$spatialReference
      $initialExtent$spatialReference$wkid
      [1] 102100
      
      $initialExtent$spatialReference$latestWkid
      [1] 3857
      
      
      
      $fullExtent
      $fullExtent$xmin
      [1] -19942612
      
      $fullExtent$ymin
      [1] 2000339
      
      $fullExtent$xmax
      [1] 20012149
      
      $fullExtent$ymax
      [1] 11535723
      
      $fullExtent$spatialReference
      $fullExtent$spatialReference$wkid
      [1] 102100
      
      $fullExtent$spatialReference$latestWkid
      [1] 3857
      
      
      
      $minScale
      [1] 3000000
      
      $maxScale
      [1] 0
      
      $units
      [1] "esriMeters"
      
      $supportedImageFormatTypes
      [1] "PNG32,PNG24,PNG,JPG,DIB,TIFF,EMF,PS,PDF,GIF,SVG,SVGZ,BMP"
      
      $documentInfo
      $documentInfo$Title
      [1] "USGS TNM Elevation – Contours"
      
      $documentInfo$Author
      [1] "U. S. Geological Survey - National Geospatial Program"
      
      $documentInfo$Comments
      [1] "See https://viewer.nationalmap.gov/help for assistance with The National Map viewer, download client, services, or metadata."
      
      $documentInfo$Subject
      [1] "Elevation"
      
      $documentInfo$Category
      [1] ""
      
      $documentInfo$AntialiasingMode
      [1] "Fast"
      
      $documentInfo$TextAntialiasingMode
      [1] "Force"
      
      $documentInfo$Keywords
      [1] "a-16,ngda,contour,line,index,intermediate,depression,supplemental,elevation,topography,topographic,terrain,relief,altitude,United States,US,NGP-TNM,REST,WMS,US Topo"
      
      
      $capabilities
      [1] "Data,Map,Query"
      
      $supportedQueryFormats
      [1] "JSON, geoJSON"
      
      $exportTilesAllowed
      [1] FALSE
      
      $referenceScale
      [1] 0
      
      $supportsDatumTransformation
      [1] TRUE
      
      $maxRecordCount
      [1] 1000
      
      $maxImageHeight
      [1] 4096
      
      $maxImageWidth
      [1] 4096
      
      $supportedExtensions
      [1] "WMSServer"
      

