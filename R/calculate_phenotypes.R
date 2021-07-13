##' .. content for \description{Calculating phenotype from raw phenotype to use for fig 1 and to hand off to the phenofile} (no empty lines) ..
##'
##' .. content for \details{} ..
##'
##' @title
##' @param raw_phenotypes
##' @return
##' @author akirosingh
##' @export
calculate_phenotypes <- function(raw_phenotypes) {

  #This converts columns we care about to numeric
  id <- c("Temperature","Weight", "Accuri Count")
  raw_phenotypes[id] = data.matrix(raw_phenotypes[id])

  Day0 <- raw_phenotypes[raw_phenotypes$Day==0,]

  Initial <- subset(Day0, select = c("Number", "Temperature", "Weight"))
  names(Initial) <- c("Number", "Initial Temperature", "Initial Weight")
  Datai <-  merge(raw_phenotypes,Initial)

  Dataic <- Datai%>%
    # calculate percent weight relative to day 0
    mutate(`Percent Bodyweight` = ((Datai$Weight) / (Datai$`Initial Weight`) * 100))  %>%
    # calculate percent weight loss relative to day 0
    mutate(`Percent Change in Weight` = (((Datai$Weight)-(Datai$`Initial Weight`)) / (Datai$`Initial Weight`)) * 100)%>%
    # calculate weight loss relative to day 0
    mutate(`Change in Weight` = (Datai$Weight)-(Datai$`Initial Weight`)) %>%
    # calculate RBCs from raw accuri score
    mutate(RBC = (Datai$`Accuri Count`) / 2000) %>%
    # calculate delta temperature relative to day 0
    mutate(`Change in Temperature` = ((Datai$Temperature) - (Datai$`Initial Temperature`))) %>%
    # calculate parasite density
    mutate(`Parasite Density` = Parasitemia * RBC) %>%
    # calculate uninfected RBC
    mutate(`Uninfected RBC` = (1-Parasitemia)*RBC) %>%
    # Grouping by mouse to prevent derivative function (dplyr::lag) from combining mice
    group_by(Number) %>%
    # calculate RBC Lysis
    mutate(`RBC Lysis` = (((RBC)-(dplyr::lag(RBC)))*10^6)/dplyr::lag(`Parasite Density`)) %>%
    # calculate BystanderEff
    mutate(`Bystander Effect` = (((RBC*10^6)-`Parasite Density`)-((dplyr::lag(RBC)*10^6)-dplyr::lag(`Parasite Density`)))/dplyr::lag(`Parasite Density`)) %>%
    # calculate Burst size
    mutate(`Burst Size` = `Parasite Density` - dplyr::lag(`Parasite Density`)) %>%
    # calculate derivative of Temperature
    mutate(dTemperature = Temperature - dplyr::lag(Temperature)) %>%
    # calculate derivative of RBC
    mutate(dRBC = RBC - dplyr::lag(RBC)) %>%
    # calculate derivative of Weight
    mutate(dWeight = Weight - dplyr::lag(Weight)) %>%
    ungroup() %>%
    mutate(`RBC Lysis`= gsub(-Inf, NA, `RBC Lysis`)) %>%
    mutate(`RBC Lysis`= gsub(Inf, NA, `RBC Lysis`)) %>%
    mutate(`Bystander Effect`= gsub(-Inf, NA, `Bystander Effect`)) %>%
    mutate(`Bystander Effect`= gsub(Inf, NA, `Bystander Effect`))

  # Removing a measurement error
  Dataic$RBC[2710] <- NA

  Dataic$Description <- factor(Dataic$Description, levels = c("A/J", "C57BL/6J", "129S1/SvImJ", "NOD/ShiLtJ", "NZO/HILtJ", "CAST/EiJ", "PWK/PhJ", "WSB/EiJ","DO"))

  Grouped <- Dataic %>%
    subset(Description != "DO") %>%
    group_by(Description, Day) %>%
    summarize(RBCavg = mean(RBC,na.rm = T), RBCse = std.error(RBC, na.rm = T), Parasitemiaavg = mean(Parasitemia, na.rm = T), Parasitemiase = std.error(Parasitemia, na.rm = T), PercentChangeinWeightavg = mean(`Percent Change in Weight`,na.rm=T), PercentChangeinWeightse = std.error(`Percent Change in Weight`,na.rm = T), ChangeinTemperatureavg = mean(`Change in Temperature`, na.rm=T), ChangeinTemperaturese = std.error(`Change in Temperature`, na.rm=T), ParasiteDensityavg = mean(`Parasite Density`, na.rm=T), ParasiteDensityse = std.error(`Parasite Density`, na.rm = T) )

  Grouped$Description <- factor(Grouped$Description, levels = c("A/J", "C57BL/6J", "129S1/SvImJ", "NOD/ShiLtJ", "NZO/HILtJ", "CAST/EiJ", "PWK/PhJ", "WSB/EiJ","DO"))

  saveRDS(Dataic, file = here("data/prepared_data/","Dataic.rds"))
  saveRDS(Grouped, file = here("data/prepared_data/","Grouped.rds"))

  Dataic

}
