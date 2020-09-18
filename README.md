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

