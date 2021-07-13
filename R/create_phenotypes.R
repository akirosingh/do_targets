##' .. content for \description{} (no empty lines) ..
##'
##' .. content for \details{} ..
##'
##' @title
##' @param phenotypes
##' @param sample_index
##' @return
##' @author akirosingh
##' @export
create_phenotypes <- function(phenotypes, sample_index) {

  Phenotypes <- phenotypes %>%
    subset(Day %in% c(0,5:15)) %>%
    group_by(Number) %>%
    summarize(White = as.numeric(`Coat Color`[Day==0]== "White"),
              Black = as.numeric(`Coat Color`[Day==0]== "Black"),
              Star = `Star?`[Day==0],
              StarWithoutWhite = ifelse(White==1,NA,Star),
              Lived = `Lived?`[Day==0],
              Died = ifelse(Lived == 0, 1,0),
              MinDeltaTemp = min(`Change in Temperature`, na.rm = TRUE),
              LogMinDeltaTemp =log(abs(MinDeltaTemp)+1),
              Zombie = ifelse(MinDeltaTemp<(-6.4),0,1),
              DeltaTempDay5 = `Change in Temperature`[2],
              DeltaTempDay6 = `Change in Temperature`[3],
              Day0Weight= `Initial Weight`[Day==0],
              MinPercWeight = min(`Percent Change in Weight`, na.rm=TRUE),
              MinDeltaWeight = min(`Change in Weight`, na.rm = TRUE),
              #Gainer is likely just a measure of age since only young mice are this phenotype
              Gainer = as.numeric(MinDeltaWeight==0),
              MinRBC= min(RBC, na.rm=TRUE),
              LogMinRBC = log(MinRBC),
              MaxPD = max(`Parasite Density`, na.rm=TRUE),
              DectectableMaxPD = ifelse(MaxPD>0,MaxPD,NA),
              MaxParasitemia = max(Parasitemia, na.rm = TRUE),
              DetectableMaxParasitemia = ifelse(MaxParasitemia>0,MaxParasitemia,NA),
              UndetectedParasitemia = ifelse(MaxParasitemia==0, 1,0),
              MaxdTemp = max(dTemperature, na.rm = TRUE),
              MaxdWeight = max(dWeight, na.rm = TRUE),
              MaxdRBC = max(dRBC, na.rm = TRUE),
              MaxBystanderEffect= max(`Bystander Effect`, na.rm = TRUE),
              MinBystanderEffect= min(`Bystander Effect`, na.rm = TRUE),
              MaxRBCLysis = max(`RBC Lysis`, na.rm = TRUE),
              MaxBurstSize = max(`Burst Size`, na.rm = TRUE),
              MinBurstSize = min(`Burst Size`, na.rm = TRUE),
              Description = Description[1])

  # Changing experimental measurements from a mouse (415) that died before the experiment
  Phenotypes[397,7:length(Phenotypes)] <- NA

  # Censoring the last day of mice that died from infection
  # Adding placeholders for Mice c(175,178,187,194,199,203,216,220,228,244,343)
  Placeholders <- tibble(Number = c(175,178,187,194,199,203,216,220,228,244,343))
  Phenotypes_missing <-bind_rows(Phenotypes, Placeholders)  %>% arrange(Number)

  SemiFinal_Phenotypes <-as_tibble(merge(Phenotypes_missing, sample_index, by = "Number"))



  completeFun <- function(data, desiredCols) {
    completeVec <- complete.cases(data[, desiredCols])
    return(data[completeVec, ])
  }

  SemiFinal_Phenotypes <-completeFun(SemiFinal_Phenotypes,"SampleID") %>% arrange(SampleID) %>%
    relocate(SampleID) %>%
    select(-Number)

  p <- file(here("data/prepared_data/","pheno.csv"), "w")
  writeLines("#phenotype data for Gupta et al. (2021)", p)
  writeLines(paste0("#ncol ",dim(SemiFinal_Phenotypes)[2]), p)
  writeLines(paste0("#nrow ",dim(SemiFinal_Phenotypes)[1]), p)
  write.csv(x = SemiFinal_Phenotypes, file = p,row.names = FALSE)
  close(p)


}
