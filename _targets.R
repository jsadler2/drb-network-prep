library(targets)

options(tidyverse.quiet = TRUE)
tar_option_set(packages = c("tidyverse","sf","purrr", 
                            "sbtools","nhdplusTools")) 

source("1_fetch.R")
source("2_process.R")

dir.create("1_fetch/out/", showWarnings = FALSE)
dir.create("1_fetch/log/", showWarnings = FALSE)
dir.create("2_process/out/", showWarnings = FALSE)
dir.create("2_process/log/", showWarnings = FALSE)

# Define dataset of interest for the national geospatial fabric (used to fetch PRMS catchment polygons):
gf_data_select <- 'GeospatialFabricFeatures_02.zip'

# Define minor HUCs (hydrologic unit codes) that make up the DRB to use in calls to dataRetrieval functions
# Lower Delaware: 0204 subregion (for now, exclude New Jersey Coastal (https://water.usgs.gov/GIS/huc_name.html)
drb_huc8s <- c("02040101","02040102","02040103","02040104","02040105","02040106",
               "02040201","02040202","02040203","02040204","02040205","02040206","02040207")

# Return the complete list of targets
c(p1_targets_list)


