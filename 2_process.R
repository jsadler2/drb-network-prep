source("2_process/src/pair_nhd_reaches.R")
source("2_process/src/pair_nhd_catchments.R")
source("2_process/src/create_GFv1_NHDv2_xwalk.R")
source("2_process/src/munge_GFv1_catchments.R")
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
    p2_prms_nhdv2_xwalk_csv,
    write_to_csv(p2_prms_nhdv2_xwalk,"2_process/out/GFv1_NHDv2_xwalk.csv"),
    format = "file"
  ),
  
  # Reshape GFv1-NHDv2 xwalk table to return all COMIDs that drain to each PRMS segment
  tar_target(
    p2_drb_comids_all_tribs, 
    p2_prms_nhdv2_xwalk %>%
      select(PRMS_segid, comid_cat) %>% 
      tidyr::separate_rows(comid_cat,sep=";") %>% 
      rename(COMID = comid_cat)
  ),
  
  # Process catchments so that every PRMS segment has >= 1 corresponding HRU; In addition,
  # adjust catchments for 3 segments that were split in `delaware-model-prep` pipeline
  # https://github.com/USGS-R/delaware-model-prep
  tar_target(
    p2_GFv1_catchments_edited_sf,
    munge_GFv1_catchments(prms_lines = p1_GFv1_reaches_sf,
                          prms_hrus = p1_GFv1_catchments_sf,
                          segs_w_comids = p2_drb_comids_all_tribs,
                          segs_split = GFv1_segs_split,
                          crs_out = 5070,
                          verbose = TRUE)
  ),
  
  # Save processed GFv1 catchments as a geopackage
  tar_target(
    p2_GFv1_catchments_edited_gpkg,
    write_sf(p2_GFv1_catchments_edited_sf,
             dsn = "2_process/out/GFv1_catchments_edited.gpkg", 
             layer = "GFv1_catchments_edited", 
             driver = "gpkg",
             quiet = TRUE,
             # overwrite layer if already exists
             append = FALSE),
    format = "file"
  ),
  
  # Create and save indicator file
  # argument force_dep must contain name of an upstream target to force dependencies
  # and build this target when a log file already exists
  tar_target(
    p2_data_summary_csv,
    write_ind_files("2_process/log/GFv1_data_summary.csv",
                    force_dep = p2_prms_nhdv2_xwalk_csv,
                    target_names = c("p1_GFv1_reaches_sf","p1_GFv1_catchments_sf","p1_nhdv2reaches_sf",
                                     "p2_prms_nhdv2_xwalk","p2_prms_nhdv2_xwalk_csv")),
    format = "file"),
  
  # Create and save sf session info
  tar_target(
    p2_sf_version_csv,
    write_session_info("2_process/log/sf_version_info.csv"),
    format = "file"
  )
  
)






