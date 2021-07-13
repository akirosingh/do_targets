##' .. content for \description{Reformatting genotype data for qtl2} (no empty lines) ..
##'
##' .. content for \details{} ..
##'
##' @title
##' @param raw_genotypes
##' @param markers
##' @param array_id
##' @return
##' @author akirosingh
##' @export
create_genofile <- function(raw_genotypes, markers, array_id) {

# Rename annotation columns to "marker", "chr", "pos", "A1", "A2"
raw_renamed <- raw_genotypes %>%
  rename(
    marker = probeset_id,
    chr = Chr_id,
    pos = Start,
    A1 = Allele_A,
    A2 = Allele_B
  ) %>%
  # fill cM based on marker
  merge(markers, by = "marker") %>%
  # Convert pos from bp (what Axiom exports as) to Mbp (what DOQTL in R reads) by dividing by 1,000,000
  mutate(pos = replace(x = pos, values =  pos / 1000000)) %>%
  # Order by chromosome and then by position
  arrange(chr, pos) %>%
  # Delete Y ("21") and MT ("22") chromosome SNPs (axiom8 has 14 SNPs on MT chromosome, 0 SNPs on Y chromosome)
  dplyr::filter(chr != 22) %>%
  #  Change chromosome 20 to read "X" (axiom8 has 4958 SNPs on X chromosome)
  mutate(chr = replace(x = chr, (chr == 20), values = "X"))


  # Renaming column names using array_id to get Sample Names
combined <- tibble(`Best Array` = names(raw_renamed)) %>%
  left_join(y= array_id, by = "Best Array") %>%
  mutate(`Sample Name`= ifelse(is.na(`Sample Name`)==T, `Best Array`, `Sample Name`))

names(raw_renamed) <- combined$`Sample Name`

geno <-  raw_renamed[,order(colnames(raw_renamed))] %>%
  select(marker, chr, pos, cM, A1, A2, pos, Affy_SNP_ID, everything())

geno_DO <- geno %>%
  select(-(2:112),-(163:211))

# Change G398.1 to G398, G418.1 to G418, G430.1 to G430, G434.1 to G434, G458.1 to G458, G459.1 to G459

names(geno_DO)[c(351,371,383,387,411,412)] <- substr(names(geno_DO)[c(351,371,383,387,411,412)],1,nchar(names(geno_DO)[c(351,371,383,387,411,412)])-2)



# Manipulate geno file

f <- file(here("data/prepared_data",  "geno.csv"), "w")

writeLines("#genotype data for Gupta et al (2021)",f)
writeLines("#nrow 425272",f)
writeLines("#ncol 502",f)
# Writing the geno file
write.csv(x = geno_DO, file = f,row.names = F)
close(f)

#output geno to make gmap and pmap
geno
}
