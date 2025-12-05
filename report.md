# Abstract (Liam)
- purpose of the paper is to confirm the results of the other paper

The purpose of this report is to confirm the results of "Using equivalence class counts for fast and accurate testing of differential transcript usage" by Cmero et al. [1]. The paper's main thesis is that equivalence class counts (ECCs) are good replacements for exon or transcript-based methods for differential transcipt usage (DTU) analysis. We check their results in two main ways: 1) by recreating the figures used in the paper via their provided Github repository [2], and; 2) by trying their proposed pipeline for DTU analysis via their published vignette [2]. We were able to successfully recreate some, but not all, of the figures in the paper, due to limitations in our available compute power. We were able to follow the pipeline manually to completion via the vignette [2], but were unable to run their pipeline provided as an alternative to the manual steps.

# Background (Tristan)
- take inspiration from original paper's background
- RNA-seq data can be used in DTU
- typically done with exon-count data for accurfacy or transcript quantification estimates for speed
- transcript estimates come from ECs, so might as well just use ECs directly; gives a nice balance of accuracy and speed

# Methods
### Paper (Liam)
Cmero et al. included a Github repository for replicating the figures created in their publication [2]. The repository contains data, helper scripts, and a .Rmd notebook which generates the paper figures from the data. We were able to successfully run the .Rmd notebook and recreate many of the figures in the paper. The paper's figures from three sources of data, from drosphila, humans (hsapiens), and mouse (Bottomly). We were particularly successful on the drosphila data, which is a toy data set and smaller than the other two. We had some challenges running the data on the larger data sets, we assume because our machine didn't have enough RAM - the machine used in the paper statedly had 256GB of RAM and an 8 core CPU [1, Table 1]. The .Rmd cached important data, so we were able to run it multiple times and complete it bit by bit, removing the larger data sets or skipping figures if necessary. The figures we produced are stored in this repo in ec-dtu-paper/figures-run#, where # is the number of the run during which the figure was generated. The figures we created are shown in the Results section.


### Vignette (Tristan)
- completed associated vignette for DTU analysis
- included the steps we took in pipeline.ipynb
### Challenges (Both)
- R installation/dependencies and packages (Liam)
- Runtimes and compute were limited for us (Liam)
- Vignette pipeline was outdated (just used Salmon) (Tristan)

As mentioned in the Paper section, runtimes and compute power were limited for us compared to authors. As such, we often had to limit figure generation to the drosphila data. Note that this is because the ec-dtu-paper repo congregates and compare the different methods of gathering DTU data (via exons, ECCs, transcripts), compared to the vignette which focused only on equivalence class counts, which are less expensive to run. Another issue we faced with replicating the paper figures was that the repo used BiocLite to install dependencies, which is now obsolete and BiocManager has taken it's place. A similar challenge is that many packages required by the paper had in turn their own set of dependencies. These two challenges required much sleuthing before being able to run the code. The other issue was that the dependency dplyr had snce been updated, causing a bug in the original code. Newer dplyr (v1.1.4) preserves the data.table class through inner_join, whereas older versions converted it to a tibble/data.frame. A modification had to be made to the load_data.R helper function in the ec-dtu-paper repo.


# Results
### Paper (Liam)
- include figures and refer to them to talk about speed, FDR/TPR, etc.
- side-by-side with their original figures

In total, we generated the following figures. Some figures are supplementary and not included in the paper directly.

*Figure2-1*. The original figure is included on the right. Note that the bottomly data is not included.

<img src="ec-dtu-paper/figures-run1/Figure2-1.png" width="45%"> <img src="PaperOriginalFigures/Figure2-1.jpg" width="45%">

*SupplementaryFigure1-1*. This is only on the drosophila data.

<img src="ec-dtu-paper/figures-run2/SupplementaryFigure1-1.png" width="45%"> 

*SupplementaryFigure6-1*. This is only on the drosophila data. This is a more detailed version of Figure 3a in the original paper, included on the right.

<img src="ec-dtu-paper/figures-run3/SupplementaryFigure6-1.png" width="45%"> <img src="PaperOriginalFigures/Figure3.jpg" width="45%">

### Vignette (Tristan)
- include figures and refer to them to talk about speed, FDR/TPR, etc.
- side-by-side with their original figures

# Discussion (Liam)
In conclusion, we were able to successfully replicate much of the work done in the paper, and our results reflect the findings of the original. We encounter some challenges which limited our reproductions, most notably a) being unable to run the provided pipeline in the vignette, instead doing the process manually, and; 2) being unable to replicate all figures from the paper on all data due to computational limitations.

In general, the original work was well documented and we're grateful for the precision with which they provided their methods and code. Although we encountered difficulties with outdated dependencies and so on, by and large the process was smooth and well described by the orginal authors.

# References
[1] M. Cmero, N. M. Davidson, and A. Oshlack, “Using equivalence class counts for fast and accurate testing of differential transcript usage,” F1000Research, vol. 8, p. 265, Apr. 2019. doi:10.12688/f1000research.18276.2 
[2] M. Cmero, “ec-dtu-paper,” Oshlack/ec-dtu-paper, https://github.com/Oshlack/ec-dtu-paper (accessed 2025). 
[3] M. Cmero, Vignette, https://github.com/Oshlack/ec-dtu-paper/wiki/Vignette (accessed 2025). 