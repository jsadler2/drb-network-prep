
write_to_rds <- function(data, outfile){
  saveRDS(data, file = outfile)
  return(outfile)
}

write_to_csv <- function(data, outfile){
  readr::write_csv(data, file = outfile)
  return(outfile)
}
