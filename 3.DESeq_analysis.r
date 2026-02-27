library(DESeq2)
library(ggplot2)
library(dplyr)
library(edgeR)
library(matrixStats)

readCount = read.table("readCount.csv", header=T, sep=",")

rownames(readCount) = readCount$gene_id
readCount = readCount[,-1]

ws = readCount[,1:6]

# DE analysis
condition = factor(c(rep("OE",3), rep("WT",3)))

coldata = data.frame(row.names=colnames(ws), condition)
dds = DESeqDataSetFromMatrix(countData=ws, colData=coldata, design=~condition)
keep = rowSums(counts(dds) >= 10) >= 3
dds = dds[keep, ]
dds = DESeq(dds, parallel = T)
res = results(dds, independentFiltering = TRUE)

res <- as.data.frame(res) %>%
  mutate(significance = case_when(
            (abs(log2FoldChange) > 1 & padj < 0.05) ~ "Yes",
             TRUE ~ "No"),
         log2FoldChange = -log2FoldChange
  )

write.table(res, "ws_deseq_res_sig.csv", quote=F, sep=",")
