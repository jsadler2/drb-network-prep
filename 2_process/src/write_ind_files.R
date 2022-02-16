write_ind_files <- function(fileout,target_names) {
  #' 
  #' @description Function to save indicator files to track data changes over time
  #'
  #' @param fileout a character string that indicates the name of the file to be saved, including path and file extension 
  #' @param target_names a character string or vector of strings containing the target names of interest
  #'
  #' @value Returns a csv file containing the target metadata
  
  # Create indicator table
  ind_tbl <- tar_meta(all_of(target_names)) %>%
    select(tar_name = name, filepath = path, hash = data) %>%
    mutate(filepath = unlist(filepath))
  
  # Save indicator table
  readr::write_csv(ind_tbl, fileout)
  return(fileout)
}


write_session_info <- function(fileout){
  
  # save sf package version
  sf_version_info <- data.frame(extSoft = "sf",version = as.character(packageVersion("sf")))
  
  # save sf external dependency versions
  extSoft_version_info <- sf::sf_extSoftVersion() %>% 
    data.frame(extSoft = names(.),version = .) %>%
    bind_rows(.,sf_version_info)
  
  # Save session info table
  write_to_csv(extSoft_version_info,fileout)
  
  return(fileout)

}