#' test
#'
#' @docType data
#'
#' @usage data(test)
#'
#' @format A data frame
#'
#' @keywords datasets
#'
"test"

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
"bactaxR_metadata"
