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

#### If you found the BTyper3 tool, its source code, and/or any of its associated databases useful, please cite:
  
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
