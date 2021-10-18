# esriUrl_parseUrl

    Code
      esriUrl_parseUrl(
        "https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/3")
    Output
      $url
      [1] "https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer/3"
      
      $scheme
      [1] "https://"
      
      $host
      [1] "sampleserver1.arcgisonline.com"
      
      $instance
      [1] "ArcGIS"
      
      $restIndicator
      [1] "rest/services"
      
      $folderName
      [1] "Demographics"
      
      $serviceName
      [1] "ESRI_Census_USA"
      
      $layerID
      [1] 3
      

---

    Code
      esriUrl_parseUrl(
        "https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer")
    Output
      $url
      [1] "https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Demographics/ESRI_Census_USA/MapServer"
      
      $scheme
      [1] "https://"
      
      $host
      [1] "sampleserver1.arcgisonline.com"
      
      $instance
      [1] "ArcGIS"
      
      $restIndicator
      [1] "rest/services"
      
      $folderName
      [1] "Demographics"
      
      $serviceName
      [1] "ESRI_Census_USA"
      
      $layerID
      integer(0)
      

---

    Code
      esriUrl_parseUrl(
        "https://services.arcgis.com/V6ZHFr6zdgNZuVG0/arcgis/rest/services/Landscape_Trees/FeatureServer/0")
    Output
      $url
      [1] "https://services.arcgis.com/V6ZHFr6zdgNZuVG0/arcgis/rest/services/Landscape_Trees/FeatureServer/0"
      
      $scheme
      [1] "https://"
      
      $host
      [1] "services.arcgis.com"
      
      $instance
      [1] "V6ZHFr6zdgNZuVG0/arcgis"
      
      $restIndicator
      [1] "rest/services"
      
      $folderName
      [1] ""
      
      $serviceName
      [1] "Landscape_Trees"
      
      $layerID
      [1] 0
      

