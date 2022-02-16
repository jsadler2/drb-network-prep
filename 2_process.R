source("2_process/src/pair_nhd_reaches.R")
source("2_process/src/pair_nhd_catchments.R")
source("2_process/src/create_GFv1_NHDv2_xwalk.R")

p2_targets_list <- list(
  
  # Pair PRMS segments (NHGFv1) with intersecting NHDPlusV2 reaches and contributing NHDPlusV2 catchments
  tar_target(
    p2_prms_nhdv2_xwalk,
    create_GFv1_NHDv2_xwalk(prms_lines = p1_GFv1_reaches_sf,
                            nhd_lines = p1_nhdv2reaches_sf,
                            prms_hrus = p1_GFv1_catchments_sf,
                            min_area_overlap = 0.5,
                            drb_segs_spatial = drb_segs_spatial)
  )
  
)






