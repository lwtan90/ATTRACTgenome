#!/bin/bash


PLINK=/mnt/projects/wlwtan/cardiac_epigenetics/SG10K/ATTRACT/plink


#Step 1: Remove autosome
#Step 1: Remove individual with missingness per individual (missing) > 5%
./plink --bfile attract_preQC --autosome --mind 0.05 --out filtered_attract_preQC --make-bed --allow-no-sex


#Step 2: Variant pruning and remove related samples
#Step 2: windowsize stepsize r2
#Step 2: het: computes observed and expected autosomal homozygous genotype counts for each sample
./plink --bfile filtered_attract_preQC --indep-pairwise 200 50 0.25 --out QC_filtered_attract_preQC
./plink --bfile filtered_attract_preQC --extract QC_filtered_attract_preQC.prune.in --keep QC_filtered_attract_preQC.fam --het --out QC_filtered_attract_preQC
R-3.5.1 --no-save -q < removeHETERO.r
./plink --bfile filtered_attract_preQC --extract QC_filtered_attract_preQC.prune.in --keep filtered_attract_preQC.valid.sample --rel-cutoff 0.2 --out QC_filtered_attract_preQC 
./plink --bfile filtered_attract_preQC --make-bed --keep QC_filtered_attract_preQC.rel.id --out parse1_QC_filtered_attract_preQC

#Step 3: Variant filtering for common variant (for computation of population) and remove differential missing SNPs
#Step 3: note: maf 0.01
./plink --bfile parse1_QC_filtered_attract_preQC --maf 0.01 --hwe 1e-6 --geno 0.05 --allow-no-sex --make-bed --out parse2_QC_filtered_attract_preQC
./plink --bfile parse2_QC_filtered_attract_preQC --test-missing midp --allow-no-sex --out parse2_QC_filtered_attract_preQC
awk '{if($5<0.00005){print $2}}' parse2_QC_filtered_attract_preQC.missing  > parse2_QC_filtered_attract_preQC.missingsnp
./plink --bfile parse2_QC_filtered_attract_preQC --make-bed  --out parse3_QC_filtered_attract_preQC --exclude parse2_QC_filtered_attract_preQC.missingsnp

#Step 4: run PCA to identify population stratification
./plink --bfile parse3_QC_filtered_attract_preQC --pca 10 --out parse3_QC_filtered_attract_preQC
