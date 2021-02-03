# ATTRACT Genome Analysis  
Author: Wilson Tan  
Date: 2/2/2021  

### Description  
This document will describe the steps taken to process ATTRACT WGS dataset, and prepare for downstream analyses such as Burden Test and GWAS analysis.
No result will be posted here as the project has yet to be published.  
The pipeline assumes that the variants  have been transformed into plink binary file formats. No description on mapping and variant calling will be provided here.  

## Input Files  
plink binary file formats (bim,bed,fam)  
Current plink file location: /mnt/projects/dcklinzing/dcklinzing/ATTRACT/joint_call_vcf_whole_genome/plink/preQC/attract_preQC  

## Analysis Workflow  
The analyses can be divided into three parts:  
1. Preparation of files required for burden test  
2. Annotation of variants using ANNOVAR  
3. Burden Test  

## Preparation of Files Required for Burden Test  
<details>  
<summary> Details </summary>  
The script involved in this section can be found in bin/WGSfiltering.sh.  
  
### Filtering Criteria  

1. Rate of Genotype missingness per individual: 5%
2. Autosomes only  
3. Heterozygosity (retain F statistics within 3 std from population mean)  
4. Relatedness score cutoff 20%  
5. HWE: 1e-6  
6. Genotype missingness: 5%  

## Steps  
Step 1: Remove autosome and individuals with genotype missingness per individual (missing) > 5%  
Step 2: Variant pruning, remove related samples as well as samples with unusual heterozygosity  
Step 3: Variant filtering for common variant (for computation of population) and remove differential missing SNPs  
Step 4: run PCA to identify population stratification, and divide samples into chinese/indian/malays  
Step 5: Ancestry-specific calculation to identify ancestry-level-common-variants  
Step 6: extract RARE SNPs (excluding those which are common at ancestry level) MAF<0.01  
Step 7: If you want to obtain samples which are clearly defined as chinese/malay/indian, use the following files. Else, the above file in STep 6 is ok, and you can adjust for population stratification later in model using the PC values  

  
## Final files for all analyses  
1. rare_parse2_QC_filtered_attract_preQC (without removing mixed lineage)  
2. final_rare_ATTRACT (removing mixed lineages)  

</details>  


## Burden Test  

<details>  
<summary> Details </summary>  
The script involved in this section can be found in bin/burdentest/burdentestPIPELINE.sh.  
Dependencies:  
1. SKAT  (https://cran.r-project.org/web/packages/SKAT/index.html)  

2. PLINK v1.9 (https://zzz.bwh.harvard.edu/plink/)  

This pipeline runs on SGE. Please modify the execution of the scripts if you have other linux system.  
The key script to burdentestPIPELINE.sh is bin/burdentest/burden.sh  

```
#!/bin/bash

PLINK=/mnt/projects/wlwtan/cardiac_epigenetics/SG10K/ATTRACT/GWAS/plink
GENE=$1


## forming input required for burden test
grep $GENE target.setid | awk '{print $2}' > "test_"$GENE".id"
$PLINK --bfile EXONPLUS.parse3_rare_parse1_QC_filtered_attract_preQC --extract "test_"$GENE".id" --out "test_"$GENE --make-bed

## Burden tes takes in genotype matrix
$PLINK --bfile "test_"$GENE --recodeA --out "test_"$GENE".mat"

## Actual burden test is done here
Rscript-3.5.1 /mnt/projects/wlwtan/cardiac+_epigenetics/burdentest.r $GENE
rm "test_"$GENE*
```

</details>  
