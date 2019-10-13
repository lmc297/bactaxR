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

Click <a href="https://raw.githubusercontent.com/lmc297/bactaxR/master/data/bactaxR_fastani_output.txt">here</a> to download the data set. Feel free to save this file in the directory of your choice; if you would like to follow along with this tutorial exactly, using identical path/file names, save this file in your home directory as ```bactaxR_fastani_output.txt```.
