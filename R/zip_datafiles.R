##' .. content for \description{} (no empty lines) ..
##'
##' .. content for \details{} ..
##'
##' @title
##' @param genofile
##' @param gmapfile
##' @param pmapfile
##' @param foundergenofile
##' @param phenofile
##' @param controlfile
##' @return
##' @author akirosingh
##' @export
zip_datafiles <- function(genofile, gmapfile, pmapfile, foundergenofile,
                          phenofile, controlfile) {

#zip(zipfile = here("data/prepared_data","do_malaria.zip"), files = c(here("data/prepared_data/covar.csv"),here("data/prepared_data/foundergeno.csv"),here("data/prepared_data/geno.csv"),here("data/prepared_data/gmap.csv"),here("data/prepared_data/pheno.csv"),here("data/prepared_data/pmap.csv"),here("data/prepared_data/controlfile.json")))

  # For some reason zip doesn't work on this on the Dell precision tower.

  qtl2::zip_datafiles(here("data/prepared_data/controlfile.json"),overwrite=T,quiet=F)

  here("data/prepared_data","do_malaria.zip")
}
