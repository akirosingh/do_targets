##' .. content for \description{Import sample_index} (no empty lines) ..
##'
##' .. content for \details{} ..
##'
##' @title

##' @return
##' @author akirosingh
##' @export
get_sampleindex <- function() {

  readr::read_csv(here("data/raw_data","sample_index.csv"))

}
