# load sample fastANI data
bactaxR_fastANI <- read.ANI(file = "data/bactaxR_fastani_output.txt")
# read phylogeny
bactaxR_phylo <- read.newick(file = "data/bactaxR_phylogeny.nwk")
# read metadata
bactaxR_metadata <- read_excel("data/sup_table_s1_genomes_ani.xlsx", skip = 1)
bactaxR_data <- list(bactaxR_fastANI, bactaxR_phylo, bactaxR_metadata)
usethis::use_data(bactaxR_data, overwrite = T)
