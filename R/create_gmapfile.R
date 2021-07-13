##' .. content for \description{Create gmap data in the prepared data folder} (no empty lines) ..
##'
##' .. content for \details{} ..
##'
##' @title
##' @param genofile
##' @return
##' @author akirosingh
##' @export
create_gmapfile <- function(genofile) {

  #In gmap, just keep marker, chr, and cM
  gmap <- genofile %>%
    select(marker, chr, cM)
  #Add three rows at the top of gmap to read in notes

  f <- file(here("data/prepared_data",  "gmap.csv"), "w")
  #Add three rows at the top of gmap to read in notes

  writeLines("#gmap data for Gupta et al (2021)",f)
  writeLines("#nrow 425272",f)
  writeLines("#ncol 3",f)
  # Writing the geno file
  write.csv(x = gmap, file = f,row.names = F)
  close(f)


}
