##' .. content for \description{} (no empty lines) ..
##'
##' .. content for \details{} ..
##'
##' @title

##' @return
##' @author akirosingh
##' @export
get_rawgenotypes <- function() {
 #TODO: When data is online make this function download from url
  readr::read_csv(here("data/raw_data","raw_genotype.csv"))

}

