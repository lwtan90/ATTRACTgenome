# ATTRACT Genome Analysis  
Author: Wilson Tan  
Date: 18/9/2020  

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
