# bactaxR
Bacterial taxonomy construction and evaluation in R

## Overview

bactaxR is an R package which contains functions to aid in average-nucleotide identity (ANI)-centric bacterial taxonomy 
construction and evaluation. Specific functions include:

* Parsing output from <a href="https://github.com/ParBLiSS/FastANI">fastANI</a>
* Identification of ANI-based genomospecies breakpoints
* ANI-based dendrogram construction
* Identification of medoid genomes using selected genomospecies thresholds
* Mapping discrete traits (e.g., genomospecies, presence or absence of a phenotypic trait) to phylogenies

Post issues at https://github.com/lmc297/bactaxR/issues

### Citation

#### If you found bactaxR and/or its source code to be useful, please cite:
  
Carroll, Laura M., Martin Wiedmann, Jasna Kovac. 2020. "Proposal of a Taxonomic Nomenclature for the *Bacillus cereus* Group Which Reconciles Genomic Definitions of Bacterial Species with Clinical and Industrial Phenotypes." *mBio* 11(1): e00034-20; DOI: 10.1128/mBio.00034-20.


------------------------------------------------------------------------

## Installation

1. Download R, if necessary: https://www.r-project.org/

2. Dowload R Studio, if necessary: https://www.rstudio.com/products/rstudio/download/

3. Open R Studio, and install the ```devtools``` package, if necessary, by typing the following command into R Studio's console:

```
install.packages("devtools")
```

4. Install ```ggtree``` from Bioconductor, if necessary, by running the following commands from R Studio's console:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("ggtree")
```

5. Load ```devtools``` by typing the following command into R Studio's console:

```
library(devtools)
```

6. Install ```bactaxR``` by typing the following command into R Studio's console:

```
install_github("lmc297/bactaxR")
```

**Note:** Users who get an error when installing ```bactaxR``` should run the following command before attempting to install `bactaxR` again: `Sys.setenv("R_REMOTES_NO_ERRORS_FROM_WARNINGS"=TRUE)`

7. Load ```bactaxR``` by typing the following command into R Studio's console:
```
library(bactaxR)
```

------------------------------------------------------------------------


## Tutorials

### Tutorial 1: Construct a histogram and dendrogram using pairwise ANI values, identify medoid genomes, and visualize medoid-based clusters in a graph

1. For this tutorial, we're going to use pairwise ANI values that were calculated between 36 *B. cereus* group genomes using <a href="https://github.com/ParBLiSS/FastANI">FastANI</a> (a subset of the original data set, which will save time and memory; for all 2,231 genomes used in the full data set, see Supplementary Table S1 of the paper). 

Click <a href="https://raw.githubusercontent.com/lmc297/bactaxR/master/data/bactaxR_fastani_output.txt">here</a> to download the data set. This tab-separated file was produced by FastANI, with query genomes in the first column, reference genomes in the second column, and ANI values in the third column.

Feel free to save this file in the directory of your choice; if you would like to follow along with this tutorial exactly, using identical path/file names, save this file in your **home** directory as ```bactaxR_fastani_output.txt```.

2. Open RStudio; if you have not already installed ```bactaxR```, follow the installation instructions above.

3. If you have not already done so, load ```bactaxR``` using the following command:

```
library(bactaxR)
```

4. Let's store our pairwise ANI information as a ```bactaxRObject```; this will allow us to construct dendrograms and graphs and identify medoid genomes, exactly as was done in the paper. To do so, run the following command (replace ```~/bactaxR_fastani_output.txt``` with the path to your own file, if necessary):

```
ani <- read.ANI(file = "~/bactaxR_fastani_output.txt")
```
This command:

* Uses the ```read.ANI``` function in ```bactaxR``` to read ```bactaxR_fastani_output.txt```, an output file produed by FastANI 
* Stores genome names and pairwise comparisons as a ```bactaxRObject```, assigning it to the variable name ```ani```

Note: bactaxR can use pairwise ANI values calculated using any ANI tool, not just FastANI; you can use ```read.ANI``` with any headerless, tab-delimited file where query genome is in the first column, reference genome is in the second, and ANI values (ranging from 0 to 100) are in the third. Additionally, if you already have a data frame of query genomes/reference genomes/ANI values loaded into R, you can use the ```load.ANI``` function to store it as a ```bactaxRObject```. Note that both of these functions check to make sure that these ANI values are pairwise all-vs-all ANI values (i.e., all query genome names must be identically present in the reference genome column, and vice-versa). Additionally, **your ANI values should be between 0 and 100** (i.e., if they are between 0 and 1, multiply them by 100; for example, 0.95 ANI becomes 95 ANI, 0.971 ANI becomes 97.1 ANI). See ```?read.ANI``` and ```?load.ANI``` for more information.

We can obtain a summary of our ```bactaxR``` object using the following command:

```
summary(ani)
```

This should tell us that our data set has 36 genomes and 1,296 total comparisons; this makes sense, because 36^2 = 1,296 (i.e., these are pairwise comparisons).

5. Next, we'll construct a histogram using our pairwise ANI values. To build a histogram and store it as a variable ```h```, run the following command:

```
h <- ANI.histogram(bactaxRObject = ani, bindwidth = 0.1)
```

This command:

* Builds a histogram using pairwise ANI values stored in a ```bactaxRObject``` (here, we're using our ```bactaxRObject``` which we named ```ani```)
* Uses a histogram bin width of 0.1

To view the histogram, just run:
```
h
```

For more options for annotating/displaying your histogram, see ```?ANI.histogram```


6. Next, we will construct a dendrogram and identify medoid genomes with a single command. Most researchers have relied on a <a href="https://www.nature.com/articles/s41467-018-07641-9">genomospecies threshold of 95</a>, so let's use that as a threshold for identifying medoid genomes here. To build a dendrogram and identify medoid genomes at a 95 ANI genomospecies threshold, run the following command:

```
dend <- ANI.dendrogram(bactaxRObject = ani, ANI_threshold = 95, xline = c(4,5,6,7.5), xlinecol = c("#ffc425", "#f37735", "deeppink4", "black"), label_size = 0.5)
```

This command:

* Constructs a dendrogram, using the methods described in the paper, with ANI dissimilarity plotted along the X-axis
* Identifies medoid genomes at a 95 ANI threshold, using the ```ANI_threshold``` parameter
* Annotates the dendrogram using vertical lines at the specified ANI dissimilarity (i.e., X-axis) threshold(s), using the ```xline``` parameter for X-axis position and the ```xlinecol``` parameter for color information (here, we have vertical lines at dissimilarity values of 4, 5, 6, and 7.5, which correspond to ANI values of 96, 95, 94, and 92.5, respectively; these parameters are just for annotating the dendrogram plot, and have no analytical value/effect on the identification of medoid genomes or dendrogram construction)
* Annotates the dendrogram using tip labels with size 0.5 (```label_size = 0.5```; by default, this is set to an arbitrarily small number so that tip labels are hidden)

See ```?ANI.dendrogram``` for a complete list of options.

We can see the medoid genomes identified at our specified ANI threshold (i.e., 95) by running ```dend$medoid_genomes```

We can see the clusters to which all of our genomes were assigned at our specified ANI threshold using ```dend$cluster_assignments```

7. Let's construct an ANI similarity graph using our pairwise ANI values, and color it using the 95 ANI cluster assignments we produced in step 6. If we look at ```?ANI.graph```, we can see that we need to supply metadata (i.e., the discrete attributes which we will use to color our graph; in our case, cluster assignment) in the form of a named vector.

To do this, we'll create a vector, ```metadata```, which contains our cluster assinments:

```
metadata <- dend$cluster_assignments$Cluster
```

7. Next, we'll name our vector of cluster assignments with their associated genome labels:

```
names(metadata) <- dend$cluster_assignments$Genome
```

8. Now we can construct our graph as follows (we'll use a 95 ANI threshold like we did before):

```
ANI.graph(bactaxRObject = ani, ANI_threshold = 95,
          metadata = metadata,
          legend_pos_x = -1.5, show_legend = T, graphout_niter = 1000000, 
          legend_ncol = 1, edge_color = "black")
```

This command:

* Constructs a graph, drawing an edge between any two genomes which share an ANI value greater than or equal to ```ANI_threshold``` (here, we set this to 95)
* Colors nodes (i.e., points) using the named vector ```metadata``` (here, we used clusters identified in step 6 at a 95 ANI threshold)
* Annotate and color the graph according to various user-supplied parameters (see ```?ANI.graph``` for more details)

### Tutorial 2: Annotate a phylogeny using discrete traits

1. For this tutorial, we're going to annotate a phylogeny constructed using 79 marker genes identified in 2,231 *B. cereus* group genomes, using discrete metadata (i.e., species assignments and presence/absence of phenotypic traits).

Click <a href="https://raw.githubusercontent.com/lmc297/bactaxR/master/data/bactaxR_phylogeny.nwk">here</a> to download the phylogeny (in <a href="https://en.wikipedia.org/wiki/Newick_format">Newick</a> format).

Feel free to save this file in the directory of your choice; if you would like to follow along with this tutorial exactly, using identical path/file names, save this file in your **home** directory as ```bactaxR_phylogeny.nwk```.

2. Click <a href="https://github.com/lmc297/bactaxR/blob/master/data/sup_table_s1_genomes_ani.xlsx">here</a>, and click "Download" to download a Microsoft Excel file which contains metadata for all 2,231 genomes (i.e., Supplementary Table S1 from the paper).

Feel free to save this file in the directory of your choice; if you would like to follow along with this tutorial exactly, using identical path/file names, save this file in your **home** directory as ```sup_table_s1_genomes_ani.xlsx``` (note that if you download the file as described here, it will likely be stored in your Downloads directory; please move it to your home directory if you would like to use exact path names).

3. Open RStudio; if you have not already installed ```bactaxR```, follow the installation instructions above.

4. If you have not already done so, load ```bactaxR``` using the following command:

```
library(bactaxR)
```

5. If you have not already done so, load the ```phytools``` package using the following command:

```
library(phytools)
```

6. If you have not already done so, load the ```readxl``` package using the following command:

```
library(readxl)
```


7. Read the phylogeny into R using the ```read.newick``` function in ```phytools```, via the following command (replace ```~/bactaxR_phylogeny.nwk``` with the path to your own file, if necessary):

```
tree <- read.newick(file = "~/bactaxR_phylogeny.nwk")
```

If we run the command ```tree```, we can see that our phylogeny has 2,231 tips (i.e., genomes) and is unrooted.

8. Read the metadata into R using the ```read_excel``` funtion in the ```readxl``` package, via the following command (replace ```~/sup_table_s1_genomes_ani.xlsx``` with the path to your own file, if necessary):

```
x <- read_excel(path = "~/sup_table_s1_genomes_ani.xlsx", skip = 1)
```

We can get a summary of our metadata by running ```summary(x)```

9. We need to make sure our tree tip labels match the isolate names in our metadata file (i.e., those in the Study ID column); if we type ```table(tree$tip.label%in%x$`Study IDa,b`)```, we can see see that some of our tree tip labels cannot be found in StudyID column in our metadata table. This is because some of our tree tip labels have dashes instead of underscores. To replace all dashes in our tree tip labels with underscores, run the following command:

```
tree$tip.label <- gsub(pattern = "-", replacement = "_", x = tree$tip.label)
```

If we type ```table(tree$tip.label%in%x$`Study IDa,b`)```, we can now see that all of our tip labels can be found in our metadata Study ID column.

10. Let's treat "*B. manliponensis*", the most distant member of the group, as an outgroup along which we can root our tree. To do so, run the following command:

```
tree <- root(tree, outgroup = "B_manliponensis_JCM_15802_TYPE_STRAIN.fna")
```

If we run ```tree```, we should see that our tree is now rooted.

11. Let's color our tree using the ```phylo.discrete_trait_OTU``` function in ```bactaxR``` and genomospecies assignments produced at a 92.5 ANI threshold (see the column of our metadata titled "Closest Medoid Genome at 92.5 ANI Threshold (ANI)"). 

If we use the command ```?phylo.discrete_trait_OTU```, we can see that we need to supply a named list to ```trait_list```, where the names correspond to the traits (i.e., genomospecies assignments), and the vectors under each name correspond to the taxa associated with each name (i.e., each genome assigned to a particular genomospecies).

Let's run the following command to create a vector named ```metadata.92_5```; this vector is identical to our column "Closest Medoid Genome at 92.5 ANI Threshold (ANI)", except we are discarding all of the information after a "(" character (i.e., we are removing the ANI values appended to each medoid genome):

```
metadata.92_5 <- unlist(lapply(strsplit(x = x$`Closest Medoid Genome at 92.5 ANI Threshold (ANI)`, split = "\\("), "[[", 1))
```

If we run ```table(metadata.92_5)```, we can see the number of genomes assigned to each genomospecies.

12. Let's name the vector of genomospecies assignments (```metadata.92_5```) using the corresponding Study IDs (which match tip labels found in the tree):

```
names(metadata.92_5) <- x$`Study IDa,b`
```

13. To make the list more interpretable, run each of the following commands below; these will replace the genomospecies medoid genome names with their respective names proposed in the manuscript:

```
metadata.92_5 <- gsub(pattern = "Bacillus_anthracis_GCF_001683155_1_ASM168315v1_genomic.fna", replacement = "B. mosaicus ", x = metadata.92_5)
metadata.92_5 <- gsub(pattern = "B_bingmayongensis_FJAT-13831_TYPE_STRAIN.fna", replacement = "B. bingmayongensis ", x = metadata.92_5)
metadata.92_5 <- gsub(pattern = "Bacillus_cereus_GCF_002568015_1_ASM256801v1_genomic.fna", replacement = "B. cereus s.s. ", x = metadata.92_5)
metadata.92_5 <- gsub(pattern = "Bacillus_cytotoxicus_GCF_002251005_2_ASM225100v2_genomic.fna", replacement = "B. cytotoxicus ", x = metadata.92_5)
metadata.92_5 <- gsub(pattern = "B_gaemokensis_KCTC_13318_TYPE_STRAIN.fna", replacement = "B. gaemokensis ", x = metadata.92_5)
metadata.92_5 <- gsub(pattern = "Bacillus_cereus_GCF_002559215_1_ASM255921v1_genomic.fna", replacement = "B. luti ", x = metadata.92_5)
metadata.92_5 <- gsub(pattern = "B_manliponensis_JCM_15802_TYPE_STRAIN.fna", replacement = "B. manliponensis ", x = metadata.92_5)
metadata.92_5 <- gsub(pattern = "Bacillus_cereus_GCF_002550135_1_ASM255013v1_genomic.fna", replacement = "B. mycoides ", x = metadata.92_5)
metadata.92_5 <- gsub(pattern = "Bacillus_cereus_GCF_002576795_1_ASM257679v1_genomic.fna", replacement = "B. paramycoides ", x = metadata.92_5)
metadata.92_5 <- gsub(pattern = "Bacillus_pseudomycoides_GCF_002588885_1_ASM258888v1_genomic.fna", replacement = "B. pseudomycoides ", x = metadata.92_5)
metadata.92_5 <- gsub(pattern = "B_toyonensis_BCT_7112_TYPE_STRAIN.fna", replacement = "B. toyonensis ", x = metadata.92_5)
metadata.92_5 <- gsub(pattern = "Bacillus_cereus_GCF_002583515_1_ASM258351v1_genomic.fna", replacement = "Unknown B. cereus group Species 13", x = metadata.92_5)
metadata.92_5 <- gsub(pattern = "Bacillus_cereus_GCF_002550855_1_ASM255085v1_genomic.fna", replacement = "Unknown B. cereus group Species 14 ", x = metadata.92_5)
metadata.92_5 <- gsub(pattern = "Bacillus_cereus_GCF_002559665_1_ASM255966v1_genomic.fna", replacement = "Unknown B. cereus group Species 15 ", x = metadata.92_5)
metadata.92_5 <- gsub(pattern = "Bacillus_cereus_GCF_002578045_1_ASM257804v1_genomic.fna", replacement = "Unknown B. cereus group Species 16 ", x = metadata.92_5)
metadata.92_5 <- gsub(pattern = "Bacillus_cereus_GCF_002584535_1_ASM258453v1_genomic.fna", replacement = "Unknown B. cereus group Species 17 ", x = metadata.92_5)
metadata.92_5 <- gsub(pattern = "Bacillus_mycoides_GCF_000746925_1_BHP_1_genomic.fna", replacement = "B. clarus ", x = metadata.92_5)
metadata.92_5 <- gsub(pattern = "Bacillus_pseudomycoides_GCF_002552625_1_ASM255262v1_genomic.fna", replacement = "Unknown B. cereus group Species 18", x = metadata.92_5)
```

14. Remove the NA value (produced due to the footer in the metadata Excel sheet) using the following function:

```
metadata.92_5 <- na.omit(metadata.92_5)
```

If we run ```table(metadata.92_5)```, we should see that our genomospecies genome names have been repaced with species names.

15. We can now construct the named list that we will supply to ```trait_list```. To construct this list, we'll first initiate an empty list, and assign it to the variable name ```clades.92_5```:

```
clades.92_5 <- list()
```

16. Now run the following, which will loop through each genomospecies in our named vector (```metadata.92_5```), identify all genomes which belong to that genomospecies, and store it in our list, ```clades.92_5```:

```
for (i in 1:length(unique(metadata.92_5))){
  myclust <- as.character(unique(metadata.92_5)[i])
  tiplabs <- names(metadata.92_5)[which(metadata.92_5==myclust)]
  clades.92_5[[myclust]] <- tiplabs
}
```

If we type ```names(clades.92_5)```, we should see that our list has named elements, with one per genomospecies.

17. Let's create a color palette for our tree by running the following function, which uses the ```viridis``` palette to color known/proposed species, and colors the root of the tree and unknown species black:

```
pal.tree_92_5 <- c("black", viridis(option = "viridis", n = 12), rep("black", 6))
```

18. We can finally color our phylogeny using the ```phylo.discrete_trait_OTU``` function in ```bactaxR```by running the following:

```
tree_92_5 <- phylo.discrete_trait_OTU(phylo = tree, trait_list = clades.92_5,
                                        color_palette = pal.tree_92_5,
                                        phylo_layout = "circular", tip_label_size = 0.5)
```

This command:

* Uses ```phylo.discrete_trait_OTU``` to color the phylogeny using a named list, ```clades.92_5```
* Colors the respective clusters using the provided ```color_palette```
* Displays the phylogeny in a circular layout with a tip label size of 0.5

To view the phylogeny, run:
```
tree_92_5
```

To see more phylogeny annotation options, see ```?phylo.discrete_trait_OTU```

19. Let's add a heatmap to our tree to display predicted phenotypic information (i.e., anthrax toxin, cereulide, and Cry/Cyt toxin production) for our isolates. If we type ```?phylo.discrete_trait_heatmap```, we see that we need to supply a data frame to ```trait_data_frame```, where each row corresponds to an isolate and each column to a trait.

To construct a trait data frame, with row names which match our Study ID/tree tip labels, run the following command:

```
traitmap <- data.frame(x$`Anthrax toxin-encoding cya, lef, and pagAc`,
                       x$`Cereulide synthetase-encoding cesABCDc`,
                       x$`Known Cry- and/or Cyt-encoding genesd`,
                       row.names = x$`Study IDa,b`)
```

20. Let's change our column names to the trait which they represent:

```
colnames(traitmap) <- c("Anthrax", "Cereulide", "Thuringiensis")
```

21. Run each of the following commands to replace cells which correspond to the absence of genes/a trait with a numerical character (i.e., "0", "1", or "2" for Anthrax, Cereulide, and Thuringiensis traits, respectively):

```
traitmap$Anthrax <- ifelse(test = grepl(pattern = "Absent", x = traitmap$Anthrax), yes = "0", no = "Anthrax toxin genes present")
traitmap$Cereulide <- ifelse(test = grepl(pattern = "Absent", x = traitmap$Cereulide), yes = "1", no = "Cereulide synthetase genes present")
traitmap$Thuringiensis <- ifelse(test = grepl(pattern = "No Cry", x = traitmap$Thuringiensis), yes = "2", no = "Known Cry- and/or Cyt-encoding genes present")
```

22. Now we can add our heatmap using the following command:

```
tree_92_5.2 <- phylo.discrete_trait_heatmap(plot = tree_92_5, phylo = tree,
                                   trait_data_frame = traitmap,
                                   font_size = 0,
                                   heatmap_width = 0.1,
                                   heatmap_offset = 0.3,
                                   color_palette = c("#DE49681A", "#8C29811A", "#22A8841A" , "#DE4968FF", "#8C2981FF", "#22A884FF"))
```

This command:

* Adds a heatmap to our plot, ```tree_92_5```, using our phylogeny (```tree```) and our trait data frame (```traitmap```)
* Removes trait names from the heatmap (```font_size = 0```)
* Displays the heatmap with corresponding width and offset parameters
* Annotates the heatmap using the specified color palette

If we run the following, we can view our phylogeny with the heatmap added:
```
tree_92_5.2 
```

------------------------------------------------------------------------


## References

Carroll, Laura M., Martin Wiedmann, Jasna Kovac. 2020. "Proposal of a Taxonomic Nomenclature for the *Bacillus cereus* Group Which Reconciles Genomic Definitions of Bacterial Species with Clinical and Industrial Phenotypes." *mBio* 11(1): e00034-20; DOI: 10.1128/mBio.00034-20.

Carroll, Laura M., Martin Wiedmann, Jasna Kovac. 2019. "Proposal of a taxonomic nomenclature for the *Bacillus cereus* group which reconciles genomic definitions of bacterial species with clinical and industrial phenotypes." *bioRxiv* 779199; doi: https://doi.org/10.1101/779199.

Jain, Chirag, et al. High-throughput ANI Analysis of 90K Prokaryotic Genomes Reveals Clear Species Boundaries. bioRxiv 225342; doi: https://doi.org/10.1101/225342.

------------------------------------------------------------------------


Disclaimer: bactaxR is pretty neat! However, no tool is perfect. As always, interpret your results with caution. We are not responsible for taxonomic misclassifications, misclassifications of an isolate's pathogenic potential or industrial utility, and/or misinterpretations (biological, statistical, or otherwise) of bactaxR results.


