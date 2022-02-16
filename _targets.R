library(targets)

options(tidyverse.quiet = TRUE)
tar_option_set(packages = c("tidyverse","sf",
                            "purrr", "sbtools")) 

source("1_fetch.R")
source("2_process.R")

dir.create("1_fetch/out/", showWarnings = FALSE)
dir.create("1_fetch/log/", showWarnings = FALSE)
dir.create("2_process/out/", showWarnings = FALSE)
dir.create("2_process/log/", showWarnings = FALSE)

# Define dataset of interest for the national geospatial fabric (used to fetch PRMS catchment polygons):
gf_data_select <- 'GeospatialFabricFeatures_02.zip'

# Return the complete list of targets
c(p1_targets_list)


