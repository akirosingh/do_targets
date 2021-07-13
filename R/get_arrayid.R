##' .. content for \description{Import array id} (no empty lines) ..
##'
##' .. content for \details{} ..
##'
##' @title

##' @return
##' @author akirosingh
##' @export
get_arrayid <- function() {

  readr::read_csv(here("data/raw_data","array_id.csv"))


}
