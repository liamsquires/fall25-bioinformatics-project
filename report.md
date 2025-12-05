# 1.0 Abstract (Liam)
- purpose of the paper is to confirm the results of the other paper
- mention that "the authors" refers to the authors of [1]

# 2.0 Background (Tristan)

Looking for differential transcript usage (DTU) between samples is the most important task when analyzing differential gene expression from RNA sequencing data. This was typically done directly using estimated transcript abundances or exon counts, where using transcripts is quite fast, but has limited accuracy compared to using exon counts which gives higher accuracy, but is computationally expensive and slow [1]. Given this, the authors suggest using equivalence class counts (ECCs) as an alternative method for performing DTU. 

*P2: Go into detail on how their method works*

*P3: Talk about what they found and*

*P4: Explain how we're confirming their results*

# 3.0 Methods
### 3.1 Paper (Liam)
- simulated findings from ec-dtu-paper repo
- able to replicate their results that ECs are better in general
- talk about ec-dtu-repo
### 3.2 Vignette Procedure

The authors also provided a vignette for running DTU analysis using ECCs. This vignette uses a toy data set, which made it possible for us to replicate the results due to the compute requirements being much more manageable. The source code for the vignette is available here: https://github.com/Oshlack/ec-dtu-paper/wiki/Vignette. It provides guides on running the analysis using the authors' pipeline at https://github.com/Oshlack/ec-dtu-pipe, as well as doing it manually using Salmon or Kallisto. The main goal of replicating this vignette was for us to determine the reliableness and consistency of results from DTU analysis using ECCs.

The exact steps we took can be found in pipeline.ipynb available in our project repository: https://github.com/liamsquires/fall25-bioinformatics-project/blob/main/pipeline.ipynb. We didn't follow all the steps in the provided vignette, as we found that the authors' pipeline was buggy and was not compatible with our versions of DEXSeq and Salmon. We instead followed the steps associated with the manual setup using Salmon, as well as the DTU analysis using R.

### 3.3 Challenges (Both)
- R installation/dependencies and packages (Liam)
- Runtimes and compute were limited for us (Liam)

Lastly, as mentioned in section 3.2 above, we faced a number of challenges when trying to run the authors' provided EC-DTU-pipe pipeline. Specifically, the run_dtu stage in their pipeline made some assumptions that didn't hold up in our environment: there were extra flags that we needed to explicitly default in our call parameters, and these flags were being inferred to the wrong type (booleans instead of strings) when defaulted. The EC matrix generation and interpretation also had bugs where the scripts that were interpreting the matrix assumed that certain column names and data were being included when they weren't being generated in the first place. Luckily, they also provided steps to do a manual setup using Salmon exclusively, which worked with little to no errors.

# 4.0 Results
### 4.1 Paper (Liam)
- include figures and refer to them to talk about speed, FDR/TPR, etc.
- side-by-side with their original figures
### 4.2 Vignette Results

The results from our vignette analysis can most easily be seen by comparing our generated figures with the examples provided in the vignette. In each of the following comparisons, our generated figure is shown above the corresponding reference plot. It should be noted that, as mentioned in section 3.3, we avoided using the authors' pipeline, and instead followed their manual instructions using exclusively Salmon, which, along with the nondeterministic nature of using ECs in DTU analysis, likely caused slight variations in our results.

![dispersion_plot_us](vignette_plots/dispersion_plot_us.png)  
![dispersion_plot_vignette](vignette_plots/dispersion_plot_vignette.png)  
The above plots show the EC data before and after adjusting for dispersion. In both, the dispersion trend is roughly the same, staying in between 1e-01 and 1e-02 for all normalized count means. The ECs themselves also show very similar distributions, both before and after shrinking using dispersion normalization. 


![MA_plot_us](vignette_plots/MA_plot_us.png)  
![MA_plot_vignette](vignette_plots/MA_plot_vignette.png)  
This second set of plots highlight which ECs are significantly differentially expressed: the red dots and triangles highlight ECs that are separate enough to actually tell us something, after accounting for how often they appear. These plots also show very similar results, with ours having more usable ECs overall, with more non-differential (1181), and differential (59) ECs than the vignette examoples (974 and 47, respectively).

![DECU_plot_us](vignette_plots/DECU_plot_us.png)  
![DECU_plot_vignette](vignette_plots/DECU_plot_vignette.png)  
This last set of plots allow us to visualize our DTU analysis by looking at differential EC usage within specific genes; the yellow shading indicates which ECs' p-values are below FDR, and therefore show significantly different usage between conditions. These plots are also distinctly different, with our generated plot showing 3 out of 7 significantly differential ECs compared to the example plot's 1 out of 4. 


# 5.0 Discussion (Liam)
- summarize previous sections, state whether or not EC method is good and accurate
- mention how nice it is for them to provide repos and pipelines

(Added these as an interpretation of my results section, you can order the paragraphs however you'd like)
Our vignette results were largely comparable to the authors', but showed significantly different results. This is likely explained by one of two things: the provided EC-DTU-pipe steps differ from the manual Salmon procedure we used, or the changes we made to the plotting function and call for this table resulted in different results. Since we made only minor formatting changes for out plotting call, it seems most likely that the pipeline somehow differs from the manual Salmon procedure. It's worth noting that when running our procedure multiple times, we get consistent results each time, so this doesn't seem to be an inherent issue with EC-DTU analysis.

# 6.0 References
[1] Cmero, Marek et al. “Using equivalence class counts for fast and accurate testing of differential transcript usage.” F1000Research vol. 8 265. 7 Mar. 2019, doi:10.12688/f1000research.18276.2s

- paper repo: just include a link where appropriate in your section