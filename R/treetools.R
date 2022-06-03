#' Highlight taxa in a phylogeny using a discrete variable
#'
#' This function highlights taxa in a phylogeny using the groupOTU
#'  function in tidytree/ggtree.
#'
#' @param phylo A phylo object
#' @param trait_list Named list, where names corresponds to traits and
#' vectors under each name correspond to taxa associated with that trait.
#' Defaults to NULL (no list is supplied).
#' @param color_palette Vector of trait color(s). Defaults to
#' one color per trait using the viridis color scale, i.e.,
#' viridis(n = length(trait_list)).
#' @param phylo_layout Any ggtree phylogeny layout.
#' Defaults to "circular".
#' @param tip_label_size Size of tip labels. Defaults to 2.
#' @param show_legend Display legend (True or False). Defaults to True.
#' @param legend_position Position of legend. Defaults to "left".
#' @return A ggplot2 object
#' @export
phylo.discrete_trait_OTU <- function(phylo,
                                     trait_list = NULL,
                                     color_palette = viridis(n = length(trait_list)),
                                     phylo_layout = "circular",
                                     tip_label_size = 2,
                                     show_legend = T,
                                     legend_position = "left"){
  if (!(is.null(trait_list))){
    target <- phylo$tip.label
    p <- groupOTU(phylo, trait_list)
    p <- ggtree(p, layout = phylo_layout, aes(color = group))}
  else{
    p <- ggtree(phylo, layout = phylo_layout)
  }

  if (phylo_layout == "circular"){
    p <- p + geom_tiplab(aes(angle=angle),size=tip_label_size) +
      scale_color_manual(values = color_palette)}
  else{
    p <- p + geom_tiplab(size=tip_label_size) +
      scale_color_manual(values = color_palette)
  }
  if (show_legend == T){
    p <- p + theme(legend.position = legend_position)}
  return(p)
}

#' Add a discrete trait heatmap to a phylogeny
#'
#' This function adds a discrete trait heatmap to a phylogeny
#' produced by phylo.discrete_trait_OTU (or any ggplot2/ggtree plot).
#'
#' @param plot A ggplot2/ggtree plot
#' @param phylo phylo object which was used to construct plot.
#' @param trait_data_frame Data frame, where each row corresponds to a
#' tip in the phylogeny, and each column corresponds to a discrete trait.
#' Row names should match phylogeny tip labels exactly, and column names
#' should correspond to the trait name. Cells should contain character
#' values corresponding to the trait(s) (equivalent values in the
#' data frame will be assigned the same color, i.e., all cells with "0"
#' will be the same color, all cells with "cat" will be another color, etc.).
#' @param color_palette Vector of heatmap cell color(s). Defaults to
#' one color per unique cell value using the viridis color scale.
#' @param font_size Size of trait names. Defaults to 2.
#' @param font_angle Angle of trait names. Defaults to 90.
#' @param font_offset_y Vertical offset of trait names. Defaults to 0.
#' @param heatmap_width Width of heatmap, compared to width of tree.
#'  Defaults to 1.
#' @param heatmap_offset Offset of heatmap to tree. Defaults to 0.5.
#' @return A ggplot2 object
#' @export
phylo.discrete_trait_heatmap <- function(plot,
                                         phylo,
                                         trait_data_frame,
                                         color_palette = viridis(option = "viridis", n = length(unique(as.vector(apply(X = trait_data_frame, MARGIN = 2, FUN = function(x) unique(x)))))),
                                         font_size = 2,
                                         font_angle = 90,
                                         font_offset_y = 0,
                                         heatmap_width = 1,
                                         heatmap_offset = 0.5){
  if (!(is.null(trait_data_frame))){
    target <- phylo$tip.label
    trait_data_frame <- trait_data_frame[match(target, rownames(trait_data_frame)),]
    if (all(phylo$tip.label == rownames(trait_data_frame))){
      p <- gheatmap(p = plot, data = trait_data_frame,
                    font.size = font_size, width = heatmap_width,
                    offset = heatmap_offset) +
            scale_fill_manual(values = color_palette)
      return(p)
    }
    else{
      stop("Tip labels in phylo object do not match rownames(trait_data_frame).")
    }}
  else{
    stop("trait_data_frame is NULL. Please supply a trait data frame.")
  }
}




