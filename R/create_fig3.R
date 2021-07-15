##' .. content for \description{} (no empty lines) ..
##'
##' .. content for \details{} ..
##'
##' @title

##' @return
##' @author akirosingh
##' @export
create_fig3 <- function() {



  setwd("~/GitHub/Diversity-Outbred-Malaria-Project/Malaria_Diversity_Outbred_Project/Setup/Processed_Data")

  library(tidyverse)
  library(readr)
  library(qtl2)

  axiom8_phenotypes <- readRDS(file = "Phenotypes.rds")
  theme_set(theme_classic(base_size = 12))


  ggplot(axiom8_phenotypes, aes(x = as.factor(reorder(Number, MaxParasitemia)), y = (MaxParasitemia*100))) + geom_point(aes(color=as.factor(UndetectedParasitemia)), size=2, alpha=0.7) + labs(x = "Mouse Number", y = "Parasitemia (%)") + theme(legend.position = "none") + scale_color_manual(values = c("black","steelblue3")) + scale_x_discrete(expand=c(0.01,0)) + theme(axis.text.x=element_blank(),axis.ticks.x=element_blank())

  setwd("/Users/Schneider Lab/Documents/")


  load("axiom8ex.Rda")
  load("axiom7ex_apr.Rda")
  load("axiom7ex_kinship.Rda")
  load("axiom7ex_sex.Rda")
  load("axiom7ex_Xcovar.Rda")
  load("axiom7ex_pr.Rda")






  cross <- axiom8ex
  cross_name <- "axiom8ex"

  pheno <- "UndectedParasitemia"
  model <- "binary" #c("normal", "binary")
  perms <- 1


  load(paste(paste(cross_name, sep="_", pheno), sep=".", "Rda"))


  load(paste(paste("perm", cross_name, sep="_", pheno), sep=".", "Rda"))

  summary(perm_cross_outpheno, alpha= c(0.2, 0.1, 0.05, 0.01))
  sig99_cross_outpheno <- summary(perm_cross_outpheno, alpha= 0.01)
  sig95_cross_outpheno <- summary(perm_cross_outpheno, alpha= 0.05)
  sig90_cross_outpheno <- summary(perm_cross_outpheno, alpha= 0.1)
  sig80_cross_outpheno <- summary(perm_cross_outpheno, alpha= 0.2)

  bestmarker_cross_outpheno <- rownames (max(cross_outpheno, cross$pmap))
  markerpos_bestmarker_cross_outpheno <- find_markerpos(cross, bestmarker_cross_outpheno)
  chr_cross_outpheno <- as.numeric(markerpos_bestmarker_cross_outpheno[1,1])

  markerpos_bestmarker_cross_outpheno

  threshold_cross_outpheno <-maxlod(cross_outpheno, map = NULL, chr = NULL)-1

  #Find peaks above significance thresholds
  peaks_cross_outpheno <- find_peaks(scan1_output = cross_outpheno,
                                     map= cross$pmap,
                                     threshold = threshold_cross_outpheno,
                                     peakdrop = Inf,
                                     drop = NULL,
                                     prob = NULL,
                                     thresholdX = NULL,
                                     peakdropX = NULL,
                                     dropX = NULL,
                                     probX = NULL,
                                     expand2markers = TRUE,
                                     sort_by = "lod",
                                     cores = 1)


  ##To estimate the QTL effects from each of the 8 founder strains on the chromosome with the highest QTL
  load(paste(paste("coef", cross_name, sep="_", pheno), sep=".", "Rda"))


  ##Plot qtl graph
  par(mar=c(4.1, 4.1, 0.6, 0.6))
  plot(cross_outpheno,
       cross$pmap,col="steelblue3", altcol = "steelblue3", bgcol = "white", altbgcol = "white", gap = 0)



  ##Add horizontal threshold lines to plot
  abline(h = sig99_cross_outpheno, col="#FF0000FF")
  abline(h = sig95_cross_outpheno, col="#FFAA00FF")
  abline(h = sig90_cross_outpheno, col="#FFAA00FF", lty=5)


  ## Parental Contribution


  plot_coefCC(coef_cross_outpheno,
              map = cross$pmap[chr_cross_outpheno],
              columns = 1:8,
              scan1_output = cross_outpheno,
              add = TRUE,
              xlim =NULL,
              ylim = c(-0.1,0.5),
              bgcolor = "white", legend = "topright")

  chr_cross_outpheno
  cross_outpheno
  ##Calculate LOD support intervals using lod_int()-(qtl2scan)
  lod_int_bestmarker_cross_outpheno <- lod_int(scan1_output = cross_outpheno,
                                               map= cross$pmap,
                                               chr= chr_cross_outpheno,
                                               lodcolumn = 1,
                                               threshold = threshold_cross_outpheno,
                                               peakdrop = Inf,
                                               drop = 1.5,
                                               expand2markers = TRUE)


  lod_int_bestmarker_cross_outpheno


  ## Genes of interest

  k <- calc_kinship(axiom7ex_apr, "loco")
  query_variants <-create_variant_query_func("../Desktop/cc_variants.sqlite")
  query_genes <- create_gene_query_func("../Desktop/mouse_genes_mgi.sqlite")

  # This works but the LOD doesn't match the previous scan so obviously I'm feeding in something wrong. Actually I'm not sure I'm feeding it anything from the actual phenotype.
  out_snps <- scan1snps(axiom8ex_pr, axiom8ex$pmap, axiom8ex$pheno, k[["13"]], axiom7ex_sex, query_func=query_variants,chr= 2, start = 79.309, end = 79.6, keep_all_snps=TRUE)

  genes <- query_genes(chr= 2, start = 79.309, end = 79.6)

  ## Plotting Interval

  par(mar=c(4.1, 4.1, 0.6, 0.6))
  plot(out_snps$lod, out_snps$snpinfo, drop_hilit=1.5, genes=genes, bgcolor = "white")

  top <- top_snps(out_snps$lod, out_snps$snpinfo)
  print(top[,c(1, 8:15, 20)], row.names=FALSE)

  #Older plots

  #ggplot(axiom8_phenotypes, aes(x = as.factor(reorder(Number, MaxParasitemia)), y = (MaxParasitemia*100))) + geom_point(aes(fill=as.factor(UndetectedParasitemia)), colour="white",pch=21, size=6) + labs(x = "Mouse Number", y = "Parasitemia (%)") + theme(legend.position = "none") + scale_fill_manual(values = c("black","steelblue3")) + scale_x_discrete(expand=c(0.01,0)) + theme(axis.text.x=element_blank(),axis.ticks.x=element_blank())

  #ggplot(axiom8_phenotypes, aes(x = as.factor(reorder(Number, MaxParasitemia)), y = (MaxParasitemia*100))) + geom_point(aes(fill=as.factor(UndetectedParasitemia)), colour="white",pch=21, size=2) + labs(x = "Mouse Number", y = "Parasitemia (%)") + theme(legend.position = "none") + scale_fill_manual(values = c("black","steelblue3")) + scale_x_discrete(expand=c(0.01,0)) + theme(axis.text.x=element_blank(),axis.ticks.x=element_blank())

  #ggplot(axiom8_phenotypes, aes(x = as.factor(Number), y = MaxParasitemia)) + geom_point(aes(color=as.factor(UndetectedParasitemia)),pch="O", size=4) + labs(x = "Mouse Number", y = "Parasitemia (%)") + theme(legend.position = "none") + scale_color_manual(values = c("black","steelblue3")) + theme(axis.text.x=element_blank(),axis.ticks.x=element_blank())


}
