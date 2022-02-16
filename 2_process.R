source("2_process/src/pair_nhd_reaches.R")
source("2_process/src/pair_nhd_catchments.R")
source("2_process/src/create_GFv1_NHDv2_xwalk.R")
source("2_process/src/write_data.R")
source("2_process/src/write_ind_files.R")

p2_targets_list <- list(
  
  # Pair PRMS segments (NHGFv1) with intersecting NHDPlusV2 reaches and contributing NHDPlusV2 catchments
  tar_target(
    p2_prms_nhdv2_xwalk,
    create_GFv1_NHDv2_xwalk(prms_lines = p1_GFv1_reaches_sf,
                            nhd_lines = p1_nhdv2reaches_sf,
                            prms_hrus = p1_GFv1_catchments_sf,
                            min_area_overlap = 0.5,
                            drb_segs_spatial = drb_segs_spatial)
  ),
  
  # Save GFv1-NHDv2 xwalk table 
  tar_target(
    p2_prms_nhdv2_xwalk_rds,
    write_to_rds(p2_prms_nhdv2_xwalk,"2_process/out/GFv1_NHDv2_xwalk.rds"),
    format = "file"
  ),
  
  # Create and save indicator file
  tar_target(
    p2_data_summary_csv,
    write_ind_files("2_process/log/GFv1_data_summary.csv",
                    target_names = c("p1_GFv1_reaches_sf","p1_GFv1_catchments_sf",
                                     "p1_nhdv2reaches_sf","p2_prms_nhdv2_xwalk","p2_prms_nhdv2_xwalk_rds")),
    format = "file"
  ),
  
  # Create and save sf session info
  tar_target(
    p2_sf_version_csv,
    write_session_info("2_process/log/sf_version_info.csv"),
    format = "file"
  )
  
)






