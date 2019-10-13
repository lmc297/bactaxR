# load sample fastANI data
#bactaxR_fastANI <- read.ANI(file = "data/bactaxR_fastani_output.txt")
# read phylogeny
bactaxR_phylo <- read.newick(file = "data/bactaxR_phylogeny.nwk")
# read metadata
bactaxR_metadata <- read_excel("data/sup_table_s1_genomes_ani.xlsx", skip = 1)
test <- read.delim("data/hello.txt", header = F, sep = "\t")
bactaxR_data <- list(phylogeny = bactaxR_phylo, metadata = bactaxR_metadata)# ANI = bactaxR_fastANI, 
print(bactaxR_data)
print(length(bactaxR_data))
print("bactaxR data loaded.")
devtools::use_data(test, overwrite=T)
devtools::use_data(bactaxR_phylo, bactaxR_metadata, overwrite = T)#, overwrite = T)
#usethis::use_data(bactaxR_data, overwrite = T)
