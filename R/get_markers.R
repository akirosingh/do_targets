##' .. content for \description{Importing markers and centimorgan location} (no empty lines) ..
##'
##' .. content for \details{} ..
##'
##' @title

##' @return
##' @author akirosingh
##' @export
get_markers <- function() {

  readr::read_csv(here("data/raw_data","markers.csv"))


}
