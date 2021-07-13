##' .. content for \description{Creating founder strain genofile} (no empty lines) ..
##'
##' .. content for \details{} ..
##'
##' @title
##' @param genofile
##' @return
##' @author akirosingh
##' @export
create_foundergenofile <- function(genofile) {

  # Make copy of geno file- call it parents- delete all non-parent samples (there are 500 animals from not batch B)
  parents_geno <- genofile %>%
    select(1,163:211)%>%
    pivot_longer(names_to = "Mouse", values_to = "Allele", -marker)

  # Converting Mouse sample number to Strains

  AJ <- tibble(Mouse = paste0("Schneider_B", c(53:57)), Strain = "A/J", abbr = "A")
  B6 <- tibble(Mouse = paste0("Schneider_B", c(58:62)), Strain = "C57BL/6J", abbr = "B")
  S129 <- tibble(Mouse = paste0("Schneider_B", c(63:67)), Strain = "129S1/SvImJ", abbr = "C")
  NOD <- tibble(Mouse = paste0("Schneider_B", c(68:72)), Strain = "NOD/ShiLtJ", abbr = "D")
  NZO <- tibble(Mouse = paste0("Schneider_B", c(73:77)), Strain = "NZO/HlLtJ", abbr = "E")
  PWK <- tibble(Mouse = paste0("Schneider_B", c(78:82)), Strain = "PWK/PhJ", abbr = "F")
  CAST <- tibble(Mouse = paste0("Schneider_B", c(83:87)), Strain = "CAST/EiJ", abbr = "G")
  WSB <- tibble(Mouse = paste0("Schneider_B", c(88:92)), Strain = "WSB/EiJ", abbr = "H")

  parents <- rbind(AJ,B6,S129,NOD,NZO,PWK,CAST,WSB)

  #Function to find the most common value for alleles
  Mode <- function(x) {
    ux <- unique(x)
    ux[which.max(tabulate(match(x, ux)))]
  }

  parents_strains <- merge(parents_geno, parents, by = "Mouse") %>%
    group_by(abbr, marker) %>%
    summarize(mode = Mode(Allele)) %>%
    pivot_wider(names_from = abbr, values_from = mode)
# str(parents_strains)
# library(readr)
# axiom7_foundergeno <- readr::read_csv("/Volumes/Adam/DO Project/axiom7/axiom7_foundergeno.csv")
#
# install.packages("compare")
# library(compare)
# comparison <- compare(axiom7_foundergeno,parents_strains,allowAll=TRUE)
# comparison$tM
# difference <-
#   data.frame(lapply(1:ncol(axiom7_foundergeno),function(i)setdiff(axiom7_foundergeno[,i],comparison$tM[,i])))
# colnames(difference) <- colnames(axiom7_foundergeno)
# difference
#
# str(axiom7_foundergeno)
# str(parents_strains)

  f <- file(here("data/prepared_data",  "foundergeno.csv"), "w")

  writeLines("#founder genotype data for Gupta et al (2021)",f)
  writeLines("#nrow 425272",f)
  writeLines("#ncol 9",f)
  # # Writing the founder geno file
  write.csv(x = parents_strains, file = f,row.names = F)
  close(f)
}

