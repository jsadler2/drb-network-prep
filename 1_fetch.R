
p1_targets_list <- list(
  
  # Download PRMS reaches for the DRB
  tar_target(
    p1_GFv1_reaches_shp_zip,
    # Downloaded this manually from ScienceBase: 
    # https://www.sciencebase.gov/catalog/item/5f6a285d82ce38aaa244912e
    # Because it's a shapefile, it's not easily downloaded using sbtools
    # like other files are (see https://github.com/USGS-R/sbtools/issues/277).
    # Because of that and since it's small (<700 Kb) I figured it'd be fine to
    # just include in the repo and have it loosely referenced to the sb item ^
    "1_fetch/in/study_stream_reaches.zip",
    format = "file"
  ),

  # Unzip folder containing PRMS reaches shapefile
  tar_target(
    p1_GFv1_reaches_shp,
    unzip(p1_GFv1_reaches_shp_zip, exdir = "1_fetch/out/study_stream_reaches"),
    format = "file"
  ),
  
  # Read PRMS reaches shapefile in as an sf object
  tar_target(
    p1_GFv1_reaches_sf,
    sf::st_read(dsn = unique(dirname(p1_GFv1_reaches_shp)), layer = "study_stream_reaches", quiet=TRUE)
  )
  
)
  