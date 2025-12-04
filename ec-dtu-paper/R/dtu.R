run_dexseq <- function(counts, genes, group, cpm_cutoff, n_sample_cutoff, cores=8) {
    BPPARAM=MulticoreParam(workers=cores)
    start.time <- Sys.time(); print(start.time)

    counts <- as.matrix(counts[,!colnames(counts)%in%c('ec_names','exon_id','gene_id')])

    sampleTable <- data.frame(condition=as.factor(group))
    rownames(sampleTable) <- colnames(counts)

    dx <- DEXSeqDataSet(counts, sampleData = sampleTable,
                        design=~sample + exon + condition:exon,
                        groupID = genes$gene_id, featureID = genes$feature_id)
    dx <- estimateSizeFactors(dx)
    dx <- estimateDispersions(dx, BPPARAM=BPPARAM)
    dx <- testForDEU(dx, BPPARAM=BPPARAM)
    dx <- estimateExonFoldChanges(dx, BPPARAM=BPPARAM)

    dxr <- DEXSeqResults(dx)
    pgq <- perGeneQValue(dxr)

    end.time <- Sys.time(); print(start.time)
    print(end.time - start.time)

    return(list(dexseq_object=dx,
                dexseq_results=dxr,
                gene_FDR=data.frame(gene=names(pgq), FDR=pgq)))
}

run_diffsplice <- function(df, group, sample_regex,
                           feature=c('tx', 'ec', 'ex'),
                           cpm_cutoff=0, n_sample_cutoff=0,
                           simple_filter=FALSE) {
    if (feature == 'tx') {
        samps <- data.frame(sample_id = colnames(df)[grep(sample_regex, colnames(df))])
        samps$condition <- as.numeric(as.factor(group)) - 1

        d <- get_tx_info(df, samps, sample_regex)
    } else {
        fname <- ifelse(feature == 'ec', 'ec_names', 'exon_id')
        samples <- names(df)[names(df) %like% sample_regex]
        sampleTable <- data.frame(sample_id = samples,
                                  condition = group)
        df <- data.frame(df)
        df$feature_id <- df[,fname]
        df <- distinct(df[,c(samples, 'gene_id', 'feature_id')])
        d <- dmDSdata(counts = df, samples = sampleTable)
    }
    if(simple_filter) {
        n <- length(group)
        n.small <- min(as.numeric(table(group)))
        d <- dmFilter(d, min_samps_feature_expr=n.small,
                      min_feature_expr=10,
                      min_samps_gene_expr=n,
                      min_gene_expr=10)
    }
    sample.data <- DRIMSeq::samples(d)
    counts <- round(as.matrix(counts(d)[,-c(1:2)]))
    genes <- counts(d)[,c(1:2)]

    results <- run_dexseq(counts, genes, group, cpm_cutoff, n_sample_cutoff)
    return(results)
}

get_random_comp <- function(samples, n, group1='D2', group2='B6') {
    g1s <- samples[samples$type==group1,]$sample
    g2s <- samples[samples$type==group2,]$sample

    g1 <- sample(g1s, n)
    g2 <- sample(g2s, n)

    return(samples[samples$sample%in%c(g1, g2),])
}
