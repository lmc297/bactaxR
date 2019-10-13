#' bactaxR sample data
#'
#' Taxonomic and phylogenomic data from a
#' study of 2,231 B. cereus group isolate genomes.
#' Data incudes pairwise average nucleotide identity
#' (ANI) values calculated between a subset of
#' B. cereus group genomes (n = 36), a phylogeny 
#' of 2,231 B. cereus group isolates, and metadata 
#' for 2,231 B. cereus group genomes (i.e., 
#' Supplementary Table S1 in Carroll, Wiedmann, and 
#' Kovac [2019]).
#'
#'
#'
#' @docType data
#'
#' @usage data(bactaxR_data)
#'
#' @format A list, where the first element is a bactaxRObject containing 
#' pairwise ANI values between 36 B. cereus group genomes (i.e., fastANI 
#' output), the second is a phylogeny of class phylo, and the third is a tibble of metadata.
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
#' data(bactaxR_data)
#' \donttest{plot.histogram <- ANI.histogram(bactaxRObject = bactaxR_data$ANI, bindwidth = 0.001)}
#' \donttest{plot.histogram}
#' \donttest{plot.tree <- phylo.discrete_trait_OTU(phylo = bactaxR_data$phylogeny,
#' phylo_layout = "circular", tip_label_size = 0.5)}
#' \donttest{plot.tree}
#' \donttest{head(bactaxR_data$metadata)}
"bactaxR_data"
