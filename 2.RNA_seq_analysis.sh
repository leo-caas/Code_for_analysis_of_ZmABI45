# build index
hisat2-build -p 4 Zea_mays.Zm-B73-REFERENCE-NAM-5.0.dna.toplevel.fa B73_NAM_5.0

# align
hisat2 -p 32 --dta -t -q -x B73_NAM_5.0 -1 H18_L2_UDI091.R1.fastq.gz -2 H18_L2_UDI091.R2.fastq.gz -S H_OE_1.sam --new-summary --summary-file H_OE_1.summary.txt

# sort the sam files
/software/samtools-1.19/samtools sort -@ 8 -o H_OE_1.sort.bam H_OE_1.sam 

# tringtie calculate gene expression
stringtie -e -B -p 32 -G Zea_mays.Zm-B73-REFERENCE-NAM-5.0.58.gff3 -o H_OE_1.gtf -A H_OE_1.abund.txt H_OE_1.sort.bam

