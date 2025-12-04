Dependencies corrected to:

install.packages("BiocManager")
BiocManager::install(c("edgeR", "DEXSeq", "DRIMSeq", "tximport"))
devtools::install_github("mikelove/rnaseqDTU")

since biocLite is obsolete

Note that the following packages are necessary to get devtools:
install.packages(c("systemfonts", "textshaping", "ragg"))

plus these:
sudo apt install libfreetype6-dev libfontconfig1-dev libharfbuzz-dev libfribidi-dev libpng-dev libtiff5-dev libjpeg-dev



Caching caused some issues while running the R file.

A modification had to be made to make ec_names work due to an update with one of the data handling classes. Claude says this:
"
    1. The original code had a bug that worked in older versions of dplyr (circa 2018) but breaks in modern versions
    2. Newer dplyr (v1.1.4) preserves the data.table class through inner_join, whereas older versions converted it to a tibble/data.frame
"

I used claude to comment out the sections that used data other than the drosophila because running the hsapiens data crashed my WSL.



Had to give up on supplementary figure 8 and others.