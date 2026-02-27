# Filter the SNP data set
plink --bfile 439.snp.drought --geno 0.2 --maf 0.05 --allow-extra-chr --make-bed --out 439.snp.drought.miss_maf

# Admixture analysis
for K in 2 2 3 4 5 6 7 8; do admixture --cv 439.snp.drought.miss_maf.bed $K | tee log${K}.out; done
grep -h CV log*.out

# Phylotree analysis
VCF2Dis -i 439.snp.drought.miss_maf.vcf -o VCF2Dis_439line.mat
fastme-2.1.5-linux64 -i VCF2Dis_439line -o VCF2Dis_439line.nwk -m U

# LD estimation
PopLDdecay -InVCF 439.snp.drought.miss_maf.vcf -OutStat 439.poplddecay 

# PCA analysis
gcta64 --bfile 439.snp.drought.miss_maf --autosome --make-grm --out 439.gmat
gcta64  --grm 439.gmat --pca 3 --out 439.pca

# GWAS analysis
emmax-kin-intel64 -v -d 10 439.snp.drought.miss_maf
emmax-intel64 -v -d 10 -t 439.snp.drought.miss_maf -p 439.phenotype.ws_asi.txt -k 439.snp.drought.miss_maf.aBN.kinf -o emmax.439.miss_maf.genomic.WSASI.res
