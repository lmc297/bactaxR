#' bactaxR sample data: fastANI output
#'
#' A subset of taxonomic data from a
#' study of 2,231 B. cereus group isolate genomes.
#' Data incudes pairwise average nucleotide identity
#' (ANI) values calculated between a subset of
#' B. cereus group genomes (n = 36).
#'
#'
#'
#' @docType data
#'
#' @usage data(bactaxR_fastANI)
#'
#' @format An object of class \code{"bactaxRObject"}; see \code{\link[bactaxR]{read.ANI}}.
#'
#' @keywords datasets
#'
#' @references Laura M. Carroll, Martin Wiedmann, and Jasna Kovac. 2019.
#' Proposal of a taxonomic nomenclature for the Bacillus cereus group
#' which reconciles genomic definitions of bacterial species
#' with clinical and industrial phenotypes
#' bioRxiv 779199; doi: https://doi.org/10.1101/779199
#'
#' @examples
#' data(bactaxR_fastANI)
#' \donttest{plot.histogram <- ANI.histogram(bactaxRObject = bactaxR_fastANI, bindwidth = 0.001)}
#' \donttest{plot.histogram}
read.ANI(file = "data/bactaxR_fastani_output.txt")
"bactaxR_fastANI"



#' bactaxR sample data: phylogeny
#'
#' Phylogenomic data from a
#' study of 2,231 B. cereus group isolate genomes.
#' Data incudes a phylogeny of 2,231 B. cereus
#' group genomes.
#'
#'
#' @docType data
#'
#' @usage data(bactaxR_phylo)
#'
#' @format An object of class phylo
#'
#' @keywords datasets
#'
#' @references Laura M. Carroll, Martin Wiedmann, and Jasna Kovac. 2019.
#' Proposal of a taxonomic nomenclature for the Bacillus cereus group
#' which reconciles genomic definitions of bacterial species
#' with clinical and industrial phenotypes
#' bioRxiv 779199; doi: https://doi.org/10.1101/779199
#'
#' @examples
#' data(bactaxR_phylo)
#' \donttest{plot.tree <- phylo.discrete_trait_OTU(phylo = bactaxR_phylo,
#' phylo_layout = "circular", tip_label_size = 0.5)}
#' \donttest{plot.tree}
bactaxR_phylo <- read.newick(file = "data/bactaxR_phylogeny.nwk")
"bactaxR_phylo"

#' bactaxR sample data: metadata
#'
#' Metadata from a study of 2,231 B. cereus group
#' isolate genomes. Data incudes a Microsoft Excel
#' sheet with metadata for 2,231 B. cereus group genomes
#'  (i.e., Supplementary Table S1 from Carroll, Wiedmann,
#'  and Kovac [2019]).
#'
#'
#' @docType data
#'
#' @usage data(bactaxR_metadata)
#'
#' @format An object of class tibble
#'
#' @keywords datasets
#'
#' @references Laura M. Carroll, Martin Wiedmann, and Jasna Kovac. 2019.
#' Proposal of a taxonomic nomenclature for the Bacillus cereus group
#' which reconciles genomic definitions of bacterial species
#' with clinical and industrial phenotypes
#' bioRxiv 779199; doi: https://doi.org/10.1101/779199
#'
#' @examples
#' data(bactaxR_metadata)
#' \donttest{head(bactaxR_metadata)}
bactaxR_metadata <- read_excel("data/sup_table_s1_genomes_ani.xlsx", skip = 1)
"bactaxR_metadata"


