# Code for analysis of ZmABI45

This is the script repository for the article "A cis-regulatory variant in ZmABI45 confers drought adaptation in maize". The scripts include the code for GWAS and RNA-Seq analysis.

## 1. GWAS analysis of drought-induced ASI

GWAS was performed using the EMMAX (v20120210) based on the genome-wide SNPs obtained by next generation sequencing (NGS) in our previous study. The genetic population structure was analyzed using Admixture (v1.2.1). The phylogenetic tree was established using VCF2Dis (v1.55) and FastME (v2.0). PCA analysis was performed using GCTA (v1.94.1). The inkage disequilibrium (LD) decay was estimated using PopLDdecay (v3.43). A mixed linear model incorporating a kinship matrix was applied to test associations between genome-wide SNPs and target phenotypes. 

## 2. RNA-Seq analysis of ZmABI45 OE and WT lines
Adapter trimming and quality filtering were performed with fastp (v1.1.0). The clean reads were aligned to the maize B73 reference genome (B73 RefGen_v4) using HISAT2 (v2.2.1.0) under default settings. Gene expression levels were quantified as FPKM (fragments per kilobase of exon per million mapped fragments) using StringTie (v3.0.0). The DE genes between the transgenic and wild-type lines were identified using DESeq2 (v1.50.2)
