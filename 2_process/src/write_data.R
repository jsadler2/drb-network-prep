
write_to_rds <- function(data, outfile){
  saveRDS(data, file = outfile)
  return(outfile)
}



write_to_csv <- function(data, outfile){
  readr::write_csv(data, file = outfile)
  return(outfile)
}


write_sf <- function(data_sf, dsn, layer, driver, quiet, append){
  #' 
  #' @description This function writes an sf object to a file or 
  #' database. Uses same arguments as sf::st_write and returns
  #' a character string indicating the file path, including location and 
  #' path extension
  #' 
  #' @param data_sf sf object to write to file
  #' @param dsn character string indicating the data source name; see 
  #' ??st_write for more details
  #' @param layer character string indicating the layer name; If layer 
  #' is missing, the basename of dsn is taken; see ??st_write for more
  #' details
  #' @param driver character string indicating the name of the driver to
  #' be used; see ??st_write for more details
  #' @param quiet logical, suppress info; see ??st_write for more details
  #' @param append logical, if FALSE, overwrite layer if it already exists; 
  #' see ??st_write for more details
  #'
  
  sf::st_write(data_sf, 
               dsn = dsn, 
               layer = layer, 
               driver = driver,
               quiet = quiet,
               append = append) 
  
  return(dsn)
  
}


