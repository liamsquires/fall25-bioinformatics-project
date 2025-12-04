plot_bottomly_boxplot <- function(results, cols, title='', toplot=c('FDR', 'TPR'), hline=NA, lines=F) {
    results$feature <- factor(results$feature, levels=names(cols))
    p <- ggplot(results, aes_string('feature', toplot, group='iter', colour='feature')) +
            geom_boxplot(group = 'feature', outlier.shape = NA) +
            geom_jitter(width=0.2, size=0.4) +
            theme_bw() +
            theme(legend.position = 'none',
                  plot.title = element_text(hjust=0.5),
                  text = element_text(size = 18)) +
            ylim(0,1) +
            ylab('') +
            xlab('') +
            ggtitle(title) +
            scale_color_manual(values = cols)
    if(lines) {
        p <- p + geom_line(alpha=0.3, colour='grey')
    }
    if(!is.na(hline)) {
        p <- p + geom_hline(yintercept = hline, colour='grey',  linetype='dotted')
    }
    return(p)
}

plot_ec_usage <- function(dxr, gene, lookup, ec_col='ec_names', conds=c('c1', 'c2'), FDR=0.05) {
    ids <- lookup[lookup$gene_id == gene,]$id
    dxg <- data.frame(dxr[rownames(dxr)%in%ids,])
    dxg$id <- rownames(dxg)

    significant <- which(dxg$padj < FDR)
    res <- inner_join(dxg, lookup, by='id')
    res <- data.table(res)[,paste(transcript, collapse=':'),
                           by=c(ec_col, conds[1], conds[2], 'padj')]
    res <- data.frame(res)
    mres <- melt(res, id.vars=c(ec_col, 'V1', 'padj'))

    sig_dat <- NULL
    ec_order <- levels(as.factor(res[, ec_col]))
    for(sigec in res[which(res$padj < FDR), ec_col]) {
        nextec_idx <- which(ec_order==sigec)+1
        if (nextec_idx > length(ec_order)) {
            nextec <- sigec
            sig_dat <- rbind(sig_dat, data.frame(ec1=sigec, ec2=Inf))
        } else {
            nextec <- ec_order[nextec_idx]
            sig_dat <- rbind(sig_dat, data.frame(ec1=sigec, ec2=nextec))
        }
    }

    g1 <- ggplot(data=mres) +
        geom_rect(data=sig_dat,
                  aes(xmin=ec1, xmax=ec2, ymin = -Inf, ymax = Inf),
                  fill = "lightyellow",
                  alpha = 0.8) +
        geom_step(data=mres, aes_string(ec_col, 'value', colour='variable', group='variable')) +
        theme_bw() +
        theme(axis.text.x = element_text(angle = 90)) +
        ylab('log EC usage') +
        labs(colour = 'condition') +
        ylim(0, max(c(dxr[,conds[1]], dxr[,conds[2]]))) +
        ggtitle(gene)

    sigecs <- distinct(mres[which(mres$padj < FDR),c(ec_col, 'V1')])
    print(sigecs)
    return(g1)
}
