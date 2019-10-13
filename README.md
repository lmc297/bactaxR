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

4. Let's load our pairwise ANI information into a ```bactaxRObject```; this will allow us to construct dendrograms and graphs and identify medoid genomes, exactly as was done in the paper. To do so, run the following command:

```
ani <- read.ANI(file = "~/bactaxR_fastani_output.txt")
```
This command:

* Uses the ```read.ANI``` function in ```bactaxR``` to read pairwise ANI values produed by FastANI 
* Checks to make sure that these ANI values are pairwise all-vs-all ANI values (i.e., all query genomes must be identically present in the reference genome column, and vice-versa)
* Stores genome names and pairwise comparisons as a ```bactaxRObject```

Note: you can use ```read.ANI``` with any headerless, tab-delimited file where query genome is in the first column, reference genome is in the second, and ANI values are in the third. Additionally, if you already have a data frame loaded into R, you can use the ```load.ANI``` function. See ```?read.ANI``` and ```?load.ANI``` for more information.
