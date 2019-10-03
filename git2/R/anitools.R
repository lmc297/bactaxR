setClass(Class = "bactaxRObject",
         slots = list(ANI = "numeric",
                      query = "character",
                      reference = "character"))


setMethod("summary",signature(object="bactaxRObject"),function(object) {
  cat("An object of class bactaxRObject \n")
  cat("Number of genomes: ", length(unique(object@query)), "\n")
  cat("Total number of pairwise ANI comparisons: ", length(object@ANI))
})


#' Read pairwise output from fastANI
#'
#' This function reads a file of pairwise ANI values calculated by fastANI
#' (or a file of pairwise ANI values constructed using other methods; see below).
#' This file must contain pairwise comparisons for all query and reference genomes
#'  (i.e., all-vs-all comparisons).
#'
#' @param file Path to file containing pairwise ANI comparisons output by fastANI
#'  (or any 3+ column file, described as follows).
#' The file should not have a header, and should contain 3 or more columns,
#' each separated by a tab. Columns 1, 2, and 3 should contain the query genome,
#' reference genome, and the associated ANI value, respectively
#' (remaining columns will be ignored).
#' @return A bactaxRObject object
#' @export
read.ANI <- function(file) {
  f <- read.delim(file = file,
                        header = F,
                        sep = "\t",
                        stringsAsFactors = F)
  f <- f[,1:3]
  colnames(f) <- c("query", "reference", "ANI")
  f$query <- unlist(lapply(strsplit(x = f$query,
                                    split = "/"),
                           function(x) x[length(x)]))
  f$reference <- unlist(lapply(strsplit(x = f$reference,
                                    split = "/"),
                           function(x) x[length(x)]))
  if(all(f$query%in%f$reference)){
    obj <- new("bactaxRObject",
               query = f$query,
               reference = f$reference,
               ANI = f$ANI)
    return(obj)
  }
  else{
    stop("Error: file does not contain pairwise comparisons for all genomes.")
  }
}

#' Store data frame or matrix as bactaxRObject object
#'
#' This function takes a matrix or data frame already stored in memory,
#' and converts it to a bactaxR object. The matrix or data frame should contain at
#' least 3 columns, where Column 1 contains a query genome, Column 2 contains a
#' reference genome, and Column 3 contains ANI values (ranging from 0 to 100)
#' This matrix or data frame must contain pairwise comparisons for all query and reference genomes
#'  (i.e., all-vs-all comparisons).
#'
#' @param x Matrix or data frame, where Columns 1, 2, and 3 contain the query genome,
#' reference genome, and associated ANI values, respectively (remaining columns will be ignored).
#' @return A bactaxRObject
#' @export
load.ANI <- function(x) {
  f <- x[,1:3]
  colnames(f) <- c("query", "reference", "ANI")
  if(all(f$query%in%f$reference)){
    obj <- new("bactaxRObject",
               query = f$query,
               reference = f$reference,
               ANI = f$ANI)
    return(obj)
  }
  else{
    stop("Error: file does not contain pairwise comparisons for all genomes.")
  }
}





#' Construct a histogram using ANI values
#'
#' This function constructs a histogram using ANI values
#'
#' @param bactaxRObject A bactaxRObject
#' @param binwidth Width of bins in the histogram. Defaults to 0.01 (ANI).
#' @param xmin Minimum value for the X-axis. Defaults to 79 (ANI).
#' @param xmax Maximum value for the X-axis. Defaults to 100 (ANI).
#' @param xline Numeric value (or vector of numeric values) at which
#' to draw vertical line(s) along the X-axis (i.e., ANI values).
#' Defaults to NULL (no vertical lines).
#' @param xlinecol Character (or vector of characters) corresponding to
#' ggplot2 color(s) for xline. Defaults to "#20A387FF".
#' @param xlinetype Character (or vector of characters) corresponding to
#' ggplot2 line type(s) for xline. Defaults to "dashed".
#' @return A ggplot2 object
#' @export
ANI.histogram <- function(bactaxRObject,
                          bindwidth=0.01,
                          xmin=79,
                          xmax=100,
                          xline=NULL,
                          xlinecol="#20A387FF",
                          xlinetype="dashed"){
  x <- data.frame(bactaxRObject@ANI)
  colnames(x) <- "ANI"
  p <- ggplot(x, aes(x=ANI)) +
    geom_histogram(binwidth = bindwidth) +
    scale_x_continuous(breaks = seq(xmin, xmax)) +
    xlab("Average Nucleotide Identity (ANI)") +
    ylab(paste("Count (", length(x$ANI), " total comparisons)", sep = ""))
  if (!(is.null(xline))){
    p <- p +
      geom_vline(xintercept = xline, linetype = xlinetype, color = xlinecol)

  }
  return(p)
}


#' Construct a dendrogram using pairwise ANI values and identity medoid genomes
#'
#' This function constructs a dendrogram using pairwise ANI values
#' calculated between genomes and the dissimilarity metric described
#' by Carroll, Wiedmann, and Kovac (2019), yielding medoid genomes and
#' cluster assignments at an ANI coalescence threshold (if supplied by the user).
#'
#' @param bactaxRObject A bactaxRObject
#' @param ANI_threshold ANI threshold at which to assign genomes to
#' clusters and identify medoid genomes. Defaults to 95.
#' @param label_size Size of dendrogram tip labels. Defaults to an
#' arbitrarily small number (i.e., 1e-10), so that tip labels are hidden.
#' @param color_palette Color palette to use for dendrogram. Defaults to
#' magma(1000, begin = 0.2).
#' @param xline Numeric value (or vector of numeric values) at which
#' to draw vertical line(s) along the dendrogram X-axis
#' (i.e., ANI values). Defaults to NULL (no vertical lines).
#' @param xlinecol Character (or vector of characters) corresponding to
#' ggplot2 color(s) for xline. Defaults to "#20A387FF".
#' @param xlinetype Character (or vector of characters) corresponding to
#' ggplot2 line type(s) for xline. Defaults to "dashed".
#' @return medoid_genomes A data frame of medoid genomes detected at an ANI threshold (ANI_threshold).
#' If an ANI threshold of NULL supplied, this will be NULL.
#' @return cluster_assignments A data frame containing all genomes and the genomospecies clusters to which
#' they are assigned at an ANI threshold (ANI_threshold).
#' If an ANI threshold of NULL is supplied, this will be NULL.
#' @export
ANI.dendrogram <- function(bactaxRObject,
                           ANI_threshold = 95,
                           label_size = 1e-10,
                           color_palette = magma(1000, begin = 0.2),
                           xline=NULL,
                           xlinecol="#20A387FF",
                           xlinetype="dashed"){
  fastani <- data.frame(bactaxRObject@query, bactaxRObject@reference, bactaxRObject@ANI)
  colnames(fastani) <- c("query", "reference", "ANI")
  s <- dcast(fastani, formula <- query~reference, value.var = "ANI")
  rownames(s) <- s$query
  s <- as.matrix(s[ , !(colnames(s) == "query")])
  j <- matrix(data = 100, nrow = nrow(s), ncol = ncol(s))
  d <- j - s
  d.sym <- 0.5 * (d + t(d))
  d.dist <- as.dist(d.sym)
  h <- hclust(d = d.dist, method = "average")
  dend <- as.dendrogram(h)
  dend %>% set("labels_cex", label_size) %>% highlight_branches_col(color_palette) %>% plot(horiz=T, xlab = "Dissimilarity (100-ANI)")
  if (!(is.null(xline))){
    abline(v = xline, lty = xlinetype, col = xlinecol)
  }
  if (!(is.null(ANI_threshold))){
    clusters <- cutree(tree = dend, h = 100 - ANI_threshold)
    nclus <- length(table(clusters))
    medoid.genome <- c()
    medoid.cluster <- c()
    allgenomes.cluster <- c()
    allgenomes.genome <- c()
    allgenomes.medoid <- c()
    for (i in 1:nclus){
      genomes <- clusters[which(clusters == i)]
      if (length(genomes) > 1){
        genomes.d <- d.sym[which(rownames(d.sym)%in%names(genomes)),]
        genomes.d <- genomes.d[,which(colnames(genomes.d)%in%names(genomes))]
        gnames <- rownames(genomes.d)
        genomes.d <- as.dist(genomes.d)
        medoid <- pam(x = genomes.d, k = 1)
        medoid.genome <- c(medoid.genome, medoid$medoids)
        allgenomes.genome <- c(allgenomes.genome, gnames)
        allgenomes.cluster <- c(allgenomes.cluster, rep(i, length(gnames)))
        allgenomes.medoid <- c(allgenomes.medoid, rep(medoid$medoids, length(gnames)))}
      else{
        medoid <- names(genomes)
        medoid.genome <- c(medoid.genome, medoid)
        allgenomes.cluster <- c(allgenomes.cluster, i)
        allgenomes.genome <- c(allgenomes.genome, medoid)
        allgenomes.medoid <- c(allgenomes.medoid, medoid)}
      medoid.cluster <- c(medoid.cluster, i)

    }
    medoid_genomes <- data.frame(medoid.cluster, medoid.genome)
    colnames(medoid_genomes) <- c("Cluster", "Genome")
    cluster_assignments <- data.frame(allgenomes.cluster, allgenomes.genome, allgenomes.medoid)
    colnames(cluster_assignments) <- c("Cluster", "Genome", "Cluster_Medoid")
    return(list("medoid_genomes"= medoid_genomes, "cluster_assignments" = cluster_assignments))
  }
  else{
    return(NULL)
  }
}


#' Construct an undirected graph using pairwise ANI values
#'
#' This function constructs an undirected graph using pairwise ANI values
#' calculated between genomes and the similarity metric described
#' by Carroll, Wiedmann, and Kovac (2019).
#'
#' @param bactaxRObject A bactaxRObject
#' @param ANI_threshold ANI threshold; an edge will be drawn between two genomes
#' whose pairwise ANI value is greater than or equal to this threshold.
#' Defaults to 95.
#' @param graphopt_charge Charge parameter passed to layout_with_graphopt
#' function in the igraph package. Defaults to 0.02.
#' @param graphout_niter Number of iterations to perform for layout_with_graphopt
#' funtion in the igraph package. Defaults to 500.
#' @param edge_color Color of edges in graph. Defaults to
#' gray, specifically hcl(h = 168, c = 5, l = 58, alpha = 0.1).
#' @param metadata Named vector, where names correspond to node names,
#' and vector elements correspond to metadata to map to nodes (e.g., species
#' name). Vector names must match node names exactly. Defaults to NULL
#' (no metadata stupplied).
#' @param color_palette Vector of colors to apply to nodes.
#' Defaults to one color (using the plasma color scale) per unique
#' metadata value, i.e., plasma(n = length(unique(metadata))).
#' @param node_size Size of nodes in graph. Defaults to 3.
#' @param show_legend Display legend (True or False). Defaults to True.
#' @param legend_pos_x x coordinate used to position the legend.
#' Default is -2.
#' @param legend_pos_y y coordinate used to position the legend.
#' Default is 1.
#' @param legend_cex Character expansion factor relative to current
#' ```par("cex")``` to pass to R's ```legend``` function.
#' Defaults to 0.5.
#' @param legend_ncol Number of columns to display in legend.
#' Defaults to 1.
#' @return A plot object
#' @export
ANI.graph <- function(bactaxRObject,
                      ANI_threshold = 95,
                      graphopt_charge = 0.02,
                      graphout_niter = 500,
                      edge_color = hcl(h = 168, c = 5, l = 58, alpha = 0.1),
                      metadata = NULL,
                      color_palette = plasma(n = length(unique(metadata))),
                      node_size = 3,
                      show_legend = T,
                      legend_pos_x = -2,
                      legend_pos_y = 1,
                      legend_cex = 0.5,
                      legend_ncol = 1){
  fastani <- data.frame(bactaxRObject@query, bactaxRObject@reference, bactaxRObject@ANI)
  colnames(fastani) <- c("query", "reference", "ANI")
  s <- dcast(fastani, formula <- query~reference, value.var = "ANI")
  rownames(s) <- s$query
  s <- as.matrix(s[ , !(colnames(s) == "query")])
  j <- matrix(data = 100, nrow = nrow(s), ncol = ncol(s))
  d <- j - s
  d.sym <- 0.5 * (d + t(d))
  s.sym <- -1 * (d.sym-100)
  rownames(s.sym) <- rownames(s)
  colnames(s.sym) <- colnames(s)
  ig <- graph.adjacency(s.sym, mode = "undirected", weighted = T, diag = F)
  ig <- delete_edges(graph = ig, edges = which(E(ig)$weight < ANI_threshold))
  if (!(is.null(metadata))){
  target <- as_ids(V(ig))
  metadata <- metadata[match(target, names(metadata))]
  ig <- set_vertex_attr(graph = ig, name = "species", index = as.character(names(metadata)), value = as.character(metadata))}
  l <- layout_with_graphopt(ig, charge = graphopt_charge)
  plot(ig, layout = l, vertex.label = NA,
       vertex.color = color_palette[as.numeric(as.factor(vertex_attr(ig, "species")))],
       vertex.size = node_size, vertex.frame.color = NA, edge.color = edge_color)
  if (!(is.null(metadata)) & show_legend == T){
  legend(x = legend_pos_x, y = legend_pos_y, c(unique(V(ig)$species)), col = color_palette, pt.bg = color_palette, pch = 21, cex = legend_cex, ncol = legend_ncol)}
}
