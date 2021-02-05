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
3. Setid file (lists of variants per gene)  

#### Setid Files  
A two-column tab-delimited file, comprising of gene identifier (column 1) and variant id (column 2). 
For burden test / collapsing test, this file will help the program to identify variant-gene association before the program collapses the variants for burden test. 
Different setid files should be created for different categories of test. Eg, if only non-synonymous variants were to be tested, a setid file should be created just containing non-synonymous variants for each gene, and exclude the other variant types such as synonymous, indels, etc.  
There is no naming consensus on the setid filename, but it is advised to assign a meaningful name such as nonsynonymous.setid, rather than A.setid.  


Eg. Nonsynonymous.setid  
|ENSG00000000419|chr20:50935136:G:A|
|--|--|
|ENSG00000000419|chr20:50935230:T:C|
|ENSG00000000419|chr20:50935237:C:T|
|ENSG00000000419|chr20:50941128:C:G|
|ENSG00000000419|chr20:50942085:C:A|
|ENSG00000001084|chr6:53500201:G:A|
|ENSG00000001084|chr6:53500269:A:G|  

Note:  
The variants were categorized according to variant annotation. For each category of variants, a setid should be made:  
1. nonsynonymous.setid  
2. synonymous.setid  
3. frameshift_indel.setid  
4. stoploss.setid  
5. stopgain.setid  
6. nonframeshift_indel.setid  
7. splicing.setid  #2bp from exon-intron junction
8. sift.setid  #damaging variants only
9. polyphen.setid  #pathogenic variants only
10. damaging(2/3/4/5/).setid  
11. others  

Note:  
Since we are only interested in the variants falling in coding region, to reduce memory and analysis time, you can use the coordinates listed in src/EXONPLUS.bed to extract coding variants from the plink file (rare_parse2_QC_filtered_attract_preQC/final_rare_ATTRACT).  
The resultant plink file is EXONPLUS.parse3_rare_parse1_QC_filtered_attract_preQC.  

</details>  


## Burden Test  

<details>  
<summary> Details </summary>  
The script involved in this section can be found in bin/burdentest/burdentestPIPELINE.sh.  
Dependencies:  

1. SKAT  (https://cran.r-project.org/web/packages/SKAT/index.html)  

2. PLINK v1.9 (https://zzz.bwh.harvard.edu/plink/)  

This pipeline runs on SGE. Please modify the execution of the scripts if you have other linux system.  
The key script to burdentestPIPELINE.sh is bin/burdentest/burden.sh.  

### Running Burden Test Pipeline on SGE / Aquila:  
```
###Step 1: Make a folder with any folder name (Eg: SIFT_Polyphen #I would only want to collapse variants that are predicted as pathogenic by SIFT/Polyphen)  
mkdir SIFT_Polyphen;
###Step 2: Create listvariants.sh to create target.setid required for the analysis (See bin/burdentest/listvariants.sh for details)
vi listvariants.sh
###Step 3: Run burdentestPIPELINE.sh
sh burdentestPIPELINE.sh
###Step 4: Run postBURDENTESTpipeline.sh
sh postBURDENTESTpipeline.sh
```  
<details>  

#### Description of the steps:  
##### Step 1: Make a folder with any folder name  
First, create a folder. The name of the folder should be intuitive. For example, if you are interested to perform Burden Test on pathogenic variants, the folder name should be pathogenic.  
```
mkdir Pathogenic
cd Pathogenic
```  
##### Step 2: Create listvariants.sh  
Next, create listvariants.sh that will concanate the list of variants predicted to be damaging by SIFT//Polyphen into a file called target.setid.  
To prevent double counting, kindly use "uniq".  

```
cat ../sift.setid ../polyphen.setid | sort | uniq > target.setid
```  

##### Step 3: Run burdentestPIPELINE.sh  
Store thie pipeline in a bin folder of your interest. For me, I have stored it in "/mnt/projects/wlwtan/cardiac_epigenetics/burden.sh". Therefore, before you start the analysis, change the location of the script (Full Path).  
Firstly, the pipeline will create 10,000 commands to execute burden test. (depends on the number of genes in setid file formed in Step 2).  
Next, the pipeline will split the 10,000 commands into groups of 50. You are now allowed to run 10K parallel jobs on Aquila.  
Lastly, 200 parallel jobs will be submitted to Aquila, each job should take about 1 hour.  
Note: Also kindly read burden.sh section below on how to setup the filepath within the burden.sh scripts (especially the location of plink binary files).  


```
## Form the cmd for burdentest
## target.setid can be formed by using listvariants.sh file found in the bin
## setid file <gene id><variant>
awk '{print "sh /mnt/projects/wlwtan/cardiac_epigenetics/burden.sh "$1}' target.setid | uniq > burden.cwd

## If aquila is still being used, I will split all genes into 50 lines per script, and run
split --lines=50 burden.cwd
ls x* | awk '{print "qsub -pe OpenMP 1 -l h_rt=2:00:00,mem_free=20G -V -cwd "$1}' > run.cwd
sh run.cwd
## Good luck
```  

##### Step 4: Run postBURDENTESTpipeline.sh  
This wrapper ws created to facilitate the consolidation of burden test p-values and to perform multiple-testing correction.  
The path of a few files must be organized properly:  
1. countVARperGENE.r  
2. qqplot.r  
3. manhatan.r  
These files can be found in bin/burdentest  
The final burden test output will be recorded in annotated_statistics.txt.  

```
### Step 1: Transfer all gene p-value files into a folder (allstat)
mkdir allstat
mv *.stat allstat/


### Step 2: Count number of variants per gene
Rscript-3.5.1 bin/burdentest/countVARperGENE.r target.setid

### Step 3: adjust p-value and plot various graphs
cat allstat/*.stat | grep BURDEN | sort -k2,2g > statistics.txt
Rscript-3.5.1 bin/burdentest/qqplot.r statistics.txt burden.qqplot.png
Rscript-3.5.1 bin/burdentest/manhatan.r statistics.txt burden.manhatan.png
```  
</details>  

#### Expected Output  
##### annotated_statistics.txt  
| gid | P.value | test | bonferroni | chr | start | end | hgnc | biotype | variant.count |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| GENE100 | 3.03e-06 | BURDEN | 0.04 | chr19 | 400002 | 42719898 | GENE100 | protein_coding | 8 |
| GENE20 | 2.03e-06 | BURDEN | 0.1 | chr1 | 600302 | 2714898 | GENE30 | protein_coding | 34 |  


##### qqplot.png  
<img src="https://github.com/lwtan90/ATTRACTgenome/blob/master/img/qqplot.png" width=300>  


##### manhattan.png  


  
### Details about burden.sh  
Burden.sh will consolidate the list of variants (depending on the category of interest) that are located within the coding region of a gene,
and perform SKAT/Burden test using the function implemented in R package SKAT. Plink is required to convert the genotype files into matrix format 
required by the R package for processing. Other files required for the FAM files and eigenvec files from PCA analysis performed in WGSfiltering.sh.    


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


If you have decided to run burden test on 1 gene, just run the following:  
```
sh burden.sh GENE1  

```  
  
Expect Output from burden.sh:  
```
   file       pvalue   test
1 GENE1 4.781062e-04   SKAT
2 GENE1 3.030084e-06 BURDEN
```  

Description of the columns:  
1. file: the gene of interest with the collapsed variants (In this case, GENE1).    
2. pvalue: unadjusted p-value from SKAT and Burden Test. Multiple testing correction (Bonferroni) is highly recommended with the p-value obtained from other genes.  
3. test: Burden or SKAT test.  



</details>  
