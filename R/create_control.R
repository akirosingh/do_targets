##' .. content for \description{} (no empty lines) ..
##'
##' .. content for \details{} ..
##'
##' @title

##' @return
##' @author akirosingh
##' @export
create_control <- function() {
# TODO: Create file and zip file
  #Create control file using qtl2geno command, works better than writing your own
  #1) make sure there are 8 alleles as "alleles" input to write_control_file
  #2) cross_info should have at least one column, with no. of generations
  #3) make sure there are no heterozygous calls in founder_geno- change all AB to NoCall
  #4) make sure if crossinfo_covar is specified, crossinfo_codes are as well
  write_control_file(here("data/prepared_data/","controlfile.json"),
                     crosstype = "do",
                     geno_file = "geno.csv",
                     founder_geno_file = "foundergeno.csv",
                     gmap_file = "gmap.csv",
                     pmap_file = "pmap.csv",
                     pheno_file = "pheno.csv",
                     covar_file = "covar.csv",
                     phenocovar_file = NULL,
                     sex_file = NULL,
                     sex_covar = "Sex",
                     sex_codes = c(F="female", M="male"),
                     crossinfo_file = NULL,
                     crossinfo_covar = "ngen",
                     crossinfo_codes = c("G23L2"=1, "G25"=1, "G26"=1, "G27"=1, "G28"=1, "G29"=1, "G30"=1),
                     geno_codes = c(AA=1, AB=2, BB=3),
                     alleles = c("A", "B", "C", "D", "E", "F", "G", "H"),
                     xchr = "X",
                     sep = ",",
                     na.strings = c("NoCall"),
                     comment.char = "#",
                     geno_transposed = TRUE,
                     founder_geno_transposed = TRUE,
                     pheno_transposed = FALSE,
                     covar_transposed = FALSE,
                     phenocovar_transposed = FALSE,
                     description = NULL,
                     comments = NULL,
                     overwrite = TRUE)

}
