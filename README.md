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
  
Carroll, Laura M., Martin Wiedmann, Jasna Kovac. 2019. "Proposal of a taxonomic nomenclature for the *Bacillus cereus* group which reconciles genomic definitions of bacterial species with clinical and industrial phenotypes." *bioRxiv* 779199; doi: https://doi.org/10.1101/779199.


------------------------------------------------------------------------

## Installation

1. Download R, if necessary: https://www.r-project.org/

2. Dowload R Studio, if necessary: https://www.rstudio.com/products/rstudio/download/

3. Open R Studio, and install the ```devtools``` package, if necessary, by typing the following command into R Studio's console:

```
install.packages("devtools")
```

4. Load ```devtools``` by typing the following command into R Studio's console:

```
library(devtools)
```

5. Install ```bactaxR``` by typing the following command into R Studio's console:

```
install_github("lmc297/bactaxR")
```

6. Load ```bactaxR``` by typing the following command into R Studio's console:
```
library(bactaxR)
```

## Tutorials

### Tutorial 1: Construct a dendrogram using pairwise ANI values, identify medoid genomes, and visualize medoid-based clusters in a graph

1. For this tutorial, we're going to use pairwise ANI values that were calculated between 36 *B. cereus* group genomes using <a href="https://github.com/ParBLiSS/FastANI">FastANI</a> (a subset of the original data set, which will save time and memory; for all 2,231 genomes used in the full data set, see Supplementary Table S1 of the paper). 

Click <a href="https://raw.githubusercontent.com/lmc297/bactaxR/master/data/bactaxR_fastani_output.txt">here</a> to download the data set. This tab-separated file was produced by FastANI, with query genomes in the first column, reference genomes in the second column, and ANI values in the third column.

Feel free to save this file in the directory of your choice; if you would like to follow along with this tutorial exactly, using identical path/file names, save this file in your home directory as ```bactaxR_fastani_output.txt```.

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

Note: bactaxR can use pairwise ANI values calculated using any ANI tool, not just FastANI; you can use ```read.ANI``` with any headerless, tab-delimited file where query genome is in the first column, reference genome is in the second, and ANI values are in the third. Additionally, if you already have a data frame of query genomes/reference genomes/ANI values loaded into R, you can use the ```load.ANI``` function to store it as a ```bactaxRObject```. Note that both of these functions check to make sure that these ANI values are pairwise all-vs-all ANI values (i.e., all query genome names must be identically present in the reference genome column, and vice-versa). See ```?read.ANI``` and ```?load.ANI``` for more information.

We can obtain a summary of our ```bactaxR``` object using the following command:

```
summary(ani)
```

This should tell us that our data set has 36 genomes and 1,296 total comparisons; this makes sense, because 36^2 = 1,296 (i.e., these are pairwise comparisons).

5. Next, we will construct a dendrogram and identify medoid genomes with a single command. Most researchers have relied on a <a href="https://www.nature.com/articles/s41467-018-07641-9">genomospecies threshold of 95</a>, so let's use that as a threshold for identifying medoid genomes here. To build a dendrogram and identify medoid genomes at a 95 ANI genomospecies threshold, run the following command:

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

