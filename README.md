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
The script involved in this section can be found in [here](https://github.com/lwtan90/ATTRACTgenome/blob/master/bin/WGSfiltering.sh)  
  


# Quality Control of the WGS Datasets (see bin/preQC_pipeline.sh)  
### Filtering Criteria  
1. Rate of Genotype missingness per individual: 5%
2. Autosomes only  
3. Heterozygosity (retain F statistics within 3 std from population mean)  
4. Relatedness score cutoff 20%  
5. MAF: 0.01  
6. HWE: 1e-6  
7. Genotype missingness: 5%  

### Output  
1. PCA for population stratification  
2. Non-related individuals  
3. WGS datasets with decent quality  

# Quality Control of the WGS Datasets (Rare variants)  
### Criteria  
1. Divide the samples based on ethnicity divided in the PCA.  
2. Calculate the MAF in each population, and overall in Singapore.  
3. Retain rare variants that are found in all 3 populations.  
4. Check with Gnomad all populations for evidence of rarity.  
5. Check with SG10K for evidence of rarity.  
6. Filter variants without coverage of > 10x.  
7. Filter variants without Alternative allele count > 3.  
8. 
</details>  