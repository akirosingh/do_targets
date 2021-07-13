library(targets)

source("./packages.R")

## Load your R files
lapply(list.files("./R", full.names = TRUE), source)

# Set target-specific options such as packages.
tar_option_set(packages = "dplyr")

# End this file with a list of target objects.
list(
  tar_target(raw_phenotypes, get_rawphenotypes()),
  #TODO: When raw_genotype is online make a download script
  tar_target(raw_genotypes, get_rawgenotypes()),
  tar_target(markers, get_markers()),
  tar_target(array_id, get_arrayid()),
  tar_target(sample_index, get_sampleindex()),
  tar_target(genofile, create_genofile(raw_genotypes, markers,array_id)),
  tar_target(gmapfile, create_gmapfile(genofile)),
  tar_target(pmapfile, create_pmapfile(genofile)),
  tar_target(foundergenofile, create_foundergenofile(genofile)),
  tar_target(phenotypes, calculate_phenotypes(raw_phenotypes)),
  tar_target(phenofile, create_phenotypes(phenotypes,sample_index)),
  tar_target(controlfile, create_control()),
  # # # create_zipfile needs to make the zip and output the directory. If one already exists the do_malaria folder might throw an error because you will have added two control files
  tar_target(create_zipfile, zip_datafiles(genofile,gmapfile,pmapfile,foundergenofile,phenofile,controlfile)),
  tar_target(do_malaria, read_cross2(create_zipfile)),
  tar_target(Xcovar,get_x_covar(do_malaria)),
  tar_target(map, insert_pseudomarkers(do_malaria$gmap, step=1))#,
  # tar_target(pr, calc_genoprob(do_malaria,map, quiet=FALSE,  error_prob=0.002)),
  # tar_target(apr, genoprob_to_alleleprob(pr)),
  # tar_target(kinship, calc_kinship(apr, type= "overall", omit_x=FALSE, use_allele_probs= TRUE, quiet=FALSE)),
  # tar_target(scan, scan1(pr, do_malaria$pheno, Xcovar=Xcovar))
  # tar_target(permutations, scan1perm(pr, do_malaria$pheno, Xcovar=Xcovar, n_perm=1)),
  # # The individual parental contribution need to be calculated for each phenotype as well as the gene contributions.
  # tar_target(fig1, create_fig1(phenotypes)),
  # tar_target(fig2, create_fig2(phenotypes)),
  # tar_target(fig3, create_fig3()),
  # tar_target(fig4, create_fig4()),
  # tar_target(fig5, create_fig5()),
  # tar_target(supfig1, create_supfig1()),
  # tar_target(supfig2, create_supfig2())
  # # TODO: Fill out metadata
)
