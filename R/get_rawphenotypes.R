##' .. content for \description{Importing raw_phenotype data and changing "Sex" from boolean FALSE to "female"} (no empty lines) ..
##'
##' .. content for \details{} ..
##'
##' @title

##' @return
##' @author akirosingh
##' @export
get_rawphenotypes <- function() {

  raw_phenotypes <- readr::read_csv(here("data/raw_data","raw_phenotype.csv"))
  raw_phenotypes$Sex <- ("female")
  raw_phenotypes
}
