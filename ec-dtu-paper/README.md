EC DTU paper
============

Repository structure
--------------------

* `data` - each subdirectory contains EC, transcript and exon counts from the following data sets:
    * `data/drosophila` - simulated drosophila data from Soneson et al.[1]
    * `data/hsapiens` - simulated human data from Soneson et al.[1]
    * `data/bottomly` - real mouse data from Bottomly et al.[2]
* `R` - helper functions to perform analyses and generate paper figures
* `ref` - transcript ID lookup tables and results from the Soneson et al. paper (used for comparison)

Running the analyses
--------------------

First download the simulation truth data from [http://imlspenticton.uzh.ch/robinson_lab/splicing_comparison/](http://imlspenticton.uzh.ch/robinson_lab/splicing_comparison/) and place all the text files under `ref/soneson_results/`. Next, download the RunInfo metadata table for the Bottomly data set from [NCBI](https://www.ncbi.nlm.nih.gov/Traces/study/?acc=SRP004777). Put this file under `ref/`.

Download the feature counts for the Love et al. data from [10.5281/zenodo.2644723](https://doi.org/10.5281/zenodo.2644723). Un-tar the data into the notebook directory.

The `ec-dtu-paper.Rmd` markdown notebook can now be run using knitr in RStudio. This will run the paper analyses and generate the figures under the `figures` folder. This analysis will be time consuming to run from start to finish, and a multi-core and high-memory machine is therefore recommended.

Dependencies
------------

Please install the following R packages:

```
install.packages('ggplot2')
install.packages('gridExtra')
install.packages('VennDiagram')
install.packages('RColorBrewer')
install.packages('data.table')
install.packages('readr')
install.packages('dplyr')
install.packages('devtools')

source('http://bioconductor.org/biocLite.R')
biocLite('edgeR')
biocLite('DEXSeq')
biocLite('DRIMSeq')
biocLite('tximport')
devtools::install_github('mikelove/rnaseqDTU')
```

Generating an equivalence class matrix
--------------------------------------

Under the data folder, a matrix of equivalence class results is included per data set. This was generated using the included python script `create_salmon_ec_count_matrix.py`. This script is designed to be run on Salmon[3] output, and can be run as follows:

```
python create_salmon_ec_count_matrix.py <eq_classes> <samples> <outfile>
```

For example:
```
python create_salmon_ec_count_matrix.py \
       sample1/aux_info/eq_classes.txt sample2/aux_info/eq_classes.txt \
       sample1,sample2 ec_matrix.txt
```

**NOTE:** for later versions of salmon, do not use the `--validateMappings` flag, **unless** you also use the `--hardFilter` flag. Otherwise, ECs cannot be matched correctly between samples.

A script for transforming Kallisto[4] output is also included. Kallisto must be run using the `--batch` parameter (see [https://pachterlab.github.io/kallisto/manual](https://pachterlab.github.io/kallisto/manual)), with all samples concurrently. The usage for the script is as follows:

```
usage: create_kallisto_ec_count_matrix.py [-h]
                                          ec_file counts_file samples_file
                                          tx_ids_file out_file

positional arguments:
  ec_file       Kallisto equivalence class file (matrix.ec).
  counts_file   Kallisto counts file (matrix.tsv).
  samples_file  Kallisto samples file (matrix.cells).
  tx_ids_file   File containing one transcript ID per line, in same order as
                the fasta reference used for kallisto.
  out_file      Output file.
```

[numpy](https://pypi.org/project/numpy/) and [pandas](https://pandas.pydata.org/) is required to run both scripts.

References
----------

[1] Bottomly, D., Walter, N. A. R., Hunter, J. E., Darakjian, P., Kawane, S., Buck, K. J., … Hitzemann, R. (2011). Evaluating gene expression in C57BL/6J and DBA/2J mouse striatum using RNA-Seq and microarrays. PLoS ONE, 6(3). https://doi.org/10.1371/journal.pone.0017820

[2] Soneson, C., Matthes, K. L., Nowicka, M., Law, C. W., & Robinson, M. D. (2016). Isoform prefiltering improves performance of count-based methods for analysis of differential transcript usage. Genome Biology, 17(1), 1–15. https://doi.org/10.1186/s13059-015-0862-3

[3] Patro, R., Duggal, G., Love, M. I., Irizarry, R. A., & Kingsford, C. (2017). Salmon provides fast and bias-aware quantification of transcript expression. Nature Methods, 14(4), 021592. https://doi.org/10.1038/nmeth.4197

[4] Bray, N. L., Pimentel, H., Melsted, P., & Pachter, L. (2016). Near-optimal probabilistic RNA-seq quantification. Nature Biotechnology, 34(5), 525–527. https://doi.org/10.1038/nbt.3519
