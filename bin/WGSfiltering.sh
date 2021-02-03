##############################################################################################
# This pipeline was created for the analysis of ATTRACT Genome Burden / CVWAS analysis
# Updated on 3/2/2021
# Author: Wilson Tan / Roger Foo
# Description:
# This shell script will take pre-processed / processed plink files, and convert them into
# Filtered files ready for burden test
# Part of the script can also be adapted for GWAS analysis
##############################################################################################

#!/bin/bash


## Software / Package needed
## Please add full path / add to your ENV
## software/scripts can be found in bin
PLINK=/mnt/projects/wlwtan/cardiac_epigenetics/SG10K/ATTRACT/plink
R=R-3.5.1
HETRMR=removeHETERO.r
PLOTPOP=popPLOT.r
##ln -s ../attract_preQC.bed .

## INPUT
## PLINK FILES MADE BY ZHENG
INPUT=/mnt/projects/dcklinzing/dcklinzing/ATTRACT/joint_call_vcf_whole_genome/plink/preQC/attract_preQC.bed

##Step 1: Remove autosome
##Step 1: Remove individual with missingness per individual (missing) > 5%
ln -s /mnt/projects/dcklinzing/dcklinzing/ATTRACT/joint_call_vcf_whole_genome/plink/preQC/attract_preQC.* .
$PLINK --bfile attract_preQC --autosome --mind 0.05 --out filtered_attract_preQC --make-bed --allow-no-sex


##Step 2: Variant pruning and remove related samples
##Step 2: windowsize stepsize r2
##Step 2: het: computes observed and expected autosomal homozygous genotype counts for each sample
##Step 2: Remove samples with unusual heterozygosity
$PLINK --bfile filtered_attract_preQC --indep-pairwise 200 50 0.25 --out QC_filtered_attract_preQC
$PLINK --bfile filtered_attract_preQC --extract QC_filtered_attract_preQC.prune.in --het --out QC_filtered_attract_preQC
$R --no-save -q < $HETRMR
$PLINK --bfile filtered_attract_preQC --extract QC_filtered_attract_preQC.prune.in --keep filtered_attract_preQC.valid.sample --rel-cutoff 0.2 --out QC_filtered_attract_preQC 
$PLINK --bfile filtered_attract_preQC --make-bed --keep QC_filtered_attract_preQC.rel.id --out parse1_QC_filtered_attract_preQC


##Step 3: Variant filtering for common variant (for computation of population) and remove differential missing SNPs
##Step 3: note: maf 0.01
$PLINK --bfile parse1_QC_filtered_attract_preQC --maf 0.01 --biallelic-only --hwe 1e-6 --geno 0.05 --allow-no-sex --make-bed --out parse2_QC_filtered_attract_preQC
$PLINK --bfile parse2_QC_filtered_attract_preQC --test-missing midp --allow-no-sex --out parse2_QC_filtered_attract_preQC
awk '{if($5<0.00005){print $2}}' parse2_QC_filtered_attract_preQC.missing  > parse2_QC_filtered_attract_preQC.missingsnp
$PLINK --bfile parse2_QC_filtered_attract_preQC --make-bed  --out parse3_QC_filtered_all ttract_preQC --exclude parse2_QC_filtered_attract_preQC.missingsnp


##Step 4: run PCA to identify population stratification
##Step 4: retain 10 PC
##Step 4: Use Excel/R to plot the eigenvec from the output, and decide on the cut-off to generate chinese.txt, indian.txt, malay.txt
##Step 4: Jump to Step 7 if the intension was to do common varian analysis
$PLINK --bfile parse2_QC_filtered_attract_preQC --pca 10 --out parse2_QC_filtered_attract_preQC


##Step 5: Ancestry specific calculation
##Step 5: Remove ancestry specific relatives
###Chinese
$PLINK --bfile filtered_attract_preQC --keep chinese.txt --make-bed --out chinese
$PLINK --bfile chinese --indep-pairwise 200 50 0.25 --out chinese
$PLINK --bfile chinese --extract chinese.prune.in --rel-cutoff 0.2 --out chinese
$PLINK --bfile filtered_attract_preQC --make-bed --keep chinese.rel.id --out parse1_chinese
$PLINK --bfile parse1_chinese --max-maf 0.01 --hwe 1e-6 --geno 0.05 --allow-no-sex --make-bed --out rare_parse1_chinese
$PLINK --bfile parse1_chinese --maf 0.01 --hwe 1e-6 --geno 0.05 --allow-no-sex --make-bed --out common_parse1_chinese

$PLINK --bfile filtered_attract_preQC --keep malay.txt --make-bed --out malay
$PLINK --bfile malay --indep-pairwise 200 50 0.25 --out malay
$PLINK --bfile malay --extract malay.prune.in --rel-cutoff 0.2 --out malay
$PLINK --bfile filtered_attract_preQC --make-bed --keep malay.rel.id --out parse1_malay
$PLINK --bfile parse1_malay --max-maf 0.01 --hwe 1e-6 --geno 0.05 --allow-no-sex --make-bed --out rare_parse1_malay
$PLINK --bfile parse1_malay --maf 0.01 --hwe 1e-6 --geno 0.05 --allow-no-sex --make-bed --out common_parse1_malay

$PLINK --bfile filtered_attract_preQC --keep indian.txt --make-bed --out indian
$PLINK --bfile indian --indep-pairwise 200 50 0.25 --out indian
$PLINK --bfile indian --extract indian.prune.in --rel-cutoff 0.2 --out indian
$PLINK --bfile filtered_attract_preQC --make-bed --keep indian.rel.id --out parse1_indian
$PLINK --bfile parse1_indian --max-maf 0.01 --hwe 1e-6 --geno 0.05 --allow-no-sex --make-bed --out rare_parse1_indian
$PLINK --bfile parse1_indian --maf 0.01 --hwe 1e-6 --geno 0.05 --allow-no-sex --make-bed --out common_parse1_indian

##Step 6: extract RARE SNPs (excluding those which are common at ancestry level) MAF<0.01
$PLINK --bfile parse1_QC_filtered_attract_preQC --max-maf 0.01 --biallelic-only --hwe 1e-6 --geno 0.05 --allow-no-sex --make-bed --out rare_parse2_QC_filtered_attract_preQC

##Step 7: If you want to obtain samples which are clearly defined as chinese/malay/indian, use the following files. Else, the above file is ok, and you can adjust for population stratification later in model using the PC values
cat rare_parse1_chinese.fam rare_parse1_malay.fam rare_parse1_indian.fam > filtered.race.fam
$PLINK --bfile rare_ATTRACT --keep filtered.race.fam --max-maf 0.01 --allow-no-sex --make-bed --out final_rare_ATTRACT







