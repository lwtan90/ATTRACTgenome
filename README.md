###
# Documentation for ATTRACT Data Processing  
###

## Estimate Heterozygosity and remove samples with extreme heterozygosity values  
 
```  

./plink --bfile filtered_attract_preQC --keep QC_filtered_attract_preQC.fam --indep-pairwise 200 50 0.25 --out QC_filtered_attract_preQC  
./plink --bfile filtered_attract_preQC --extract QC_filtered_attract_preQC.prune.in --keep QC_filtered_attract_preQC.fam --het --out QC_filtered_attract_preQC  
R-3.5.1 --no-save -q < removeHETERO.r  
```  
  
## Check relatedness  

```   

./plink --bfile filtered_attract_preQC --extract QC_filtered_attract_preQC.prune.in --keep filtered_attract_preQC.valid.sample --rel-cutoff 0.2 --out QC_filtered_attract_preQC   
./plink --bfile filtered_attract_preQC --make-bed --keep QC_filtered_attract_preQC.rel.id --out parse1_QC_filtered_attract_preQC  
```  

## Filter variants for MAF, HWE, GENOTYPE RATE  
```  

./plink --bfile parse1_QC_filtered_attract_preQC --maf 0.01 --hwe 1e-6 --geno 0.05 --allow-no-sex --make-bed --out parse2_QC_filtered_attract_preQC    
```  
  
## Test for missingness  
```  

./plink --bfile parse2_QC_filtered_attract_preQC --test-missing midp --allow-no-sex --out parse2_QC_filtered_attract_preQC  
awk '{if($5<0.00005){print $2}}' parse2_QC_filtered_attract_preQC.missing  > parse2_QC_filtered_attract_preQC.missingsnp    
./plink --bfile parse2_QC_filtered_attract_preQC --make-bed  --out parse3_QC_filtered_attract_preQC --exclude parse2_QC_filtered_attract_preQC.missingsnp    
```  

## Run PCA to identify population stratification  
```  

./plink --bfile parse3_QC_filtered_attract_preQC --indep-pairwise 200 50 0.25 --out parse3_QC_filtered_attract_preQC  
./plink --bfile parse3_QC_filtered_attract_preQC --pca 10 --out parse3_QC_filtered_attract_preQC  
```  

OUTPUT:  

<p align="center">
  <img height="400" src="https://github.com/lwtan90/ATTRACTgenome/blob/master/img/PC12.png">
</p>  

