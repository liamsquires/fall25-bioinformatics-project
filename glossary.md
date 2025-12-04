Helpful terms for understanding the paper.

- **Differential Transcript Usage (DTU)**

Changes in how a gene’s transcripts are proportionally used between conditions. DTU reflects shifts in isoform composition rather than total gene expression.

- **DEXSeq**

A statistical framework (R/Bioconductor) for testing differential exon usage. The paper repurposes it to test differential usage of equivalence classes.

- **Transcript**

One particular spliced RNA product of a gene. A gene may produce multiple transcript isoforms.

- **Equivalence Class (EC)**

A group of transcripts that are all compatible with the same set of sequencing reads. If a read can map to transcript A or B but not C, it belongs to the EC {A, B}. ECs are created automatically by pseudo-aligners like Salmon/Kallisto.

- **Equivalence Class Count (ECC)**

The number of reads assigned to each equivalence class. These raw counts are the central statistical unit of the paper’s method.

- **Pseudo-alignment**

A fast technique (Salmon, Kallisto) that assigns reads to transcripts or transcript sets without full alignment to a reference genome. Produces ECs as part of the process.

- **Salmon / Kallisto**

Ultra-fast RNA-seq quantification tools based on pseudo-alignment. They produce transcript abundance estimates and ECs.

- **Longranger / STAR / Tophat (mentioned as context)**

Genome-aligning mappers that fully align reads to the genome—used by exon-count-based approaches.

- **Exon Bin**

A genomic segment defined by overlapping exons from multiple transcripts. Exon-count-based DTU methods treat each bin as a unit of measurement.

- **Transcript Abundance Estimates**

Quantitative estimates of transcript expression levels (TPM, counts, etc.), typically produced by Salmon/Kallisto after solving for isoform proportions. These estimates have more variance than raw ECs.

- **Negative Binomial GLM**

A statistical model used for count data with over-dispersion (variance > mean). DEXSeq uses this model; the paper treats EC counts as its input.

- **Dispersion**

A measure of how variable counts are across replicates relative to the mean. Lower dispersion → more reliable statistical testing.

- **FDR (False Discovery Rate)**

The expected proportion of false positives among all discoveries. Key metric for evaluating DTU detection methods.

- **TPR (True Positive Rate)**

Proportion of truly changing features (exons, ECs, transcripts) correctly identified as changing.

- **EC-to-Gene Map**

The mapping from equivalence classes to the genes whose transcripts they involve. Needed to group ECs by gene prior to performing DTU tests.

- **Fragment Length Distribution / GC Bias**

Sequencing-specific properties used by transcript quantifiers but not by EC-based counting. They influence abundance estimation but not equivalence class formation.

- **Bootstrapping (Salmon / Kallisto)**

A way to estimate uncertainty in transcript abundance estimates. Not needed for EC counts, which are deterministic.

- **Bottomly Dataset**

An RNA-seq dataset (mouse strains) commonly used for benchmarking. The paper uses it as a real-data test case.

- **DRIMSeq / DEXSeq / SUPPA / IsoformSwitchAnalyzeR**

Other tools for DTU or differential splicing analysis—used as comparisons or references.

- **Junction Read**

A read that spans an exon–exon junction. Traditional splicing analyses rely on these; EC-based methods do not.

- **Alternative Splicing**

The biological process that generates multiple transcript isoforms from a single gene via exon skipping, alternative 5’/3’ splice sites, intron retention, etc.

- **Isoform**

Another term for transcript; an alternative version of a gene's RNA product.
