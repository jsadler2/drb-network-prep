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

# Return the complete list of targets
c(p1_targets_list)


