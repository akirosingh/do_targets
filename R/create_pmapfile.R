##' .. content for \description{Create pmapfile in the prepared data folder} (no empty lines) ..
##'
##' .. content for \details{} ..
##'
##' @title
##' @param genofile
##' @return
##' @author akirosingh
##' @export
create_pmapfile <- function(genofile) {

  #In pmap, just keep marker, chr, and pos
  pmap <- genofile %>%
    select(marker, chr, pos)
  #Add three rows at the top of gmap to read in notes

  f <- file(here("data/prepared_data",  "pmap.csv"), "w")


  writeLines("#pmap data for Gupta et al (2021)",f)
  writeLines("#nrow 425272",f)
  writeLines("#ncol 3",f)
  # Writing the geno file
  write.csv(x = pmap, file = f,row.names = F)
  close(f)



}
