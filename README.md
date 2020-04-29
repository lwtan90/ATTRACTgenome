###
# Documentation for ATTRACT Data Processing  
###


## Step 1: Remove duplicate samples  

Command:  
```
./plink --bfile attract_preQC --remove unwanted_list.txt --out filtered_attract_preQC --make-bed
```  
<br />  
Run Log:  
```
PLINK v1.90b6.16 64-bit (19 Feb 2020)          www.cog-genomics.org/plink/1.9/
(C) 2005-2020 Shaun Purcell, Christopher Chang   GNU General Public License v3
Logging to filtered_attract_preQC.log.
Options in effect:
  --bfile attract_preQC
  --make-bed
  --out filtered_attract_preQC
  --remove unwanted_list.txt

128966 MB RAM detected; reserving 64483 MB for main workspace.
80728670 variants loaded from .bim file.
2461 people (0 males, 0 females, 2461 ambiguous) loaded from .fam.
Ambiguous sex IDs written to filtered_attract_preQC.nosex .
2460 phenotype values loaded from .fam.
--remove: 2450 people remaining.
Warning: Ignoring phenotypes of missing-sex samples.  If you dont want those
phenotypes to be ignored, use the --allow-no-sex flag.
Using 1 thread (no multithreaded calculations invoked).
Before main variant filters, 2450 founders and 0 nonfounders present.
Calculating allele frequencies... done.
Warning: Nonmissing nonmale Y chromosome genotype(s) present; many commands
treat these as missing.
Total genotyping rate in remaining samples is 0.987541.
80728670 variants and 2450 people pass filters and QC.
Among remaining phenotypes, 1413 are cases and 1037 are controls.
--make-bed to filtered_attract_preQC.bed + filtered_attract_preQC.bim +
filtered_attract_preQC.fam ... done.
```  


## Step 2: Preliminary QC  
Command:  
```
./plink --bfile filtered_attract_preQC --maf 0.1 --hwe 1e-6 --geno 0.2 --mind 0.2 --write-snplist --make-just-fam --allow-no-sex --out QC_filtered_attract_preQC
```
<br />
Run Log:  
```
PLINK v1.90b6.16 64-bit (19 Feb 2020)          www.cog-genomics.org/plink/1.9/
(C) 2005-2020 Shaun Purcell, Christopher Chang   GNU General Public License v3
Logging to QC_filtered_attract_preQC.log.
Options in effect:
  --allow-no-sex
  --bfile filtered_attract_preQC
  --geno 0.2
  --hwe 1e-6
  --maf 0.1
  --make-just-fam
  --mind 0.2
  --out QC_filtered_attract_preQC
  --write-snplist

128966 MB RAM detected; reserving 64483 MB for main workspace.
80728670 variants loaded from .bim file.
2450 people (0 males, 0 females, 2450 ambiguous) loaded from .fam.
Ambiguous sex IDs written to QC_filtered_attract_preQC.nosex .
2450 phenotype values loaded from .fam.
0 people removed due to missing genotype data (--mind).
Using 1 thread (no multithreaded calculations invoked).
Before main variant filters, 2450 founders and 0 nonfounders present.
Calculating allele frequencies... done.
Warning: Nonmissing nonmale Y chromosome genotype(s) present; many commands
treat these as missing.
Total genotyping rate is 0.987541.
1644194 variants removed due to missing genotype data (--geno).
Warning: --hwe observation counts vary by more than 10%.  Consider using
--geno, and/or applying different p-value thresholds to distinct subsets of
your data.
--hwe: 1674018 variants removed due to Hardy-Weinberg exact test.
72089508 variants removed due to minor allele threshold(s)
(--maf/--max-maf/--mac/--max-mac).
5320950 variants and 2450 people pass filters and QC.
Among remaining phenotypes, 1413 are cases and 1037 are controls.
List of variant IDs written to QC_filtered_attract_preQC.snplist .
--make-just-fam to QC_filtered_attract_preQC.fam ... done.
```

## Step 3: Pruning  
Command:  
```
./plink --bfile filtered_attract_preQC --keep QC_filtered_attract_preQC.fam --extract QC_filtered_attract_preQC.snplist --indep-pairwise 200 50 0.25 --out QC_filtered_attract_preQC
```
<br />  
Run Log:
```
PLINK v1.90b6.16 64-bit (19 Feb 2020)          www.cog-genomics.org/plink/1.9/
(C) 2005-2020 Shaun Purcell, Christopher Chang   GNU General Public License v3
Logging to QC_filtered_attract_preQC.log.
Options in effect:
  --bfile filtered_attract_preQC
  --extract QC_filtered_attract_preQC.snplist
  --indep-pairwise 200 50 0.25
  --keep QC_filtered_attract_preQC.fam
  --out QC_filtered_attract_preQC

128966 MB RAM detected; reserving 64483 MB for main workspace.
80728670 variants loaded from .bim file.
2450 people (0 males, 0 females, 2450 ambiguous) loaded from .fam.
Ambiguous sex IDs written to QC_filtered_attract_preQC.nosex .
2450 phenotype values loaded from .fam.
--extract: 5320950 variants remaining.
--keep: 2450 people remaining.
Warning: Ignoring phenotypes of missing-sex samples.  If you dont want those
phenotypes to be ignored, use the --allow-no-sex flag.
Using 1 thread (no multithreaded calculations invoked).
Before main variant filters, 2450 founders and 0 nonfounders present.
Calculating allele frequencies... done.
Total genotyping rate is 0.995284.
5320950 variants and 2450 people pass filters and QC.
Note: No phenotypes present.
Pruned 389720 variants from chromosome 1, leaving 28135.
Pruned 410414 variants from chromosome 2, leaving 26918.
Pruned 358946 variants from chromosome 3, leaving 23197.
Pruned 372957 variants from chromosome 4, leaving 21446.
Pruned 323012 variants from chromosome 5, leaving 19832.
Pruned 314109 variants from chromosome 6, leaving 18879.
Pruned 300121 variants from chromosome 7, leaving 19339.
Pruned 270312 variants from chromosome 8, leaving 16185.
Pruned 218987 variants from chromosome 9, leaving 15735.
Pruned 261101 variants from chromosome 10, leaving 17097.
Pruned 248017 variants from chromosome 11, leaving 15690.
Pruned 241501 variants from chromosome 12, leaving 17548.
Pruned 186717 variants from chromosome 13, leaving 11970.
Pruned 160204 variants from chromosome 14, leaving 11188.
Pruned 136894 variants from chromosome 15, leaving 10961.
Pruned 150884 variants from chromosome 16, leaving 11974.
Pruned 125373 variants from chromosome 17, leaving 11613.
Pruned 141732 variants from chromosome 18, leaving 10384.
Pruned 112083 variants from chromosome 19, leaving 9921.
Pruned 111998 variants from chromosome 20, leaving 8758.
Pruned 72678 variants from chromosome 21, leaving 4887.
Pruned 64776 variants from chromosome 22, leaving 5857.
Pruned 131 variants from chromosome 23, leaving 1677.
Pruned 7740 variants from chromosome 25, leaving 1352.
Pruning complete.  4980407 of 5320950 variants removed.
Marker lists written to QC_filtered_attract_preQC.prune.in and
QC_filtered_attract_preQC.prune.out .
```

## Step 4: Estimate heterozygosity  
Command:  
```
./plink --bfile filtered_attract_preQC --extract QC_filtered_attract_preQC.prune.in --keep QC_filtered_attract_preQC.fam --het --out QC_filtered_attract_preQC
```
<br />  
Run Log:  
```
PLINK v1.90b6.16 64-bit (19 Feb 2020)          www.cog-genomics.org/plink/1.9/
(C) 2005-2020 Shaun Purcell, Christopher Chang   GNU General Public License v3
Logging to QC_filtered_attract_preQC.log.
Options in effect:
  --bfile filtered_attract_preQC
  --extract QC_filtered_attract_preQC.prune.in
  --het
  --keep QC_filtered_attract_preQC.fam
  --out QC_filtered_attract_preQC

128966 MB RAM detected; reserving 64483 MB for main workspace.
80728670 variants loaded from .bim file.
2450 people (0 males, 0 females, 2450 ambiguous) loaded from .fam.
Ambiguous sex IDs written to QC_filtered_attract_preQC.nosex .
2450 phenotype values loaded from .fam.
--extract: 340543 variants remaining.
--keep: 2450 people remaining.
Warning: Ignoring phenotypes of missing-sex samples.  If you dont want those
phenotypes to be ignored, use the --allow-no-sex flag.
Using 1 thread (no multithreaded calculations invoked).
Before main variant filters, 2450 founders and 0 nonfounders present.
Calculating allele frequencies... done.
Total genotyping rate is 0.975041.
340543 variants and 2450 people pass filters and QC.
Note: No phenotypes present.
--het: 338866 variants scanned, report written to QC_filtered_attract_preQC.het
```


### Step 5: Remove samples that exceeded heterozygosity  
Command:
```
./plink --bfile filtered_attract_preQC --extract QC_filtered_attract_preQC.prune.in --keep filtered_attract_preQC.valid.sample --check-sex --out QC_filtered_attract_preQC
```
<br />  
Run Log:
```
data = read.table("QC_filtered_attract_preQC.het",header=TRUE)
summary(data)
m = mean(data$F)
s = sd(data$F)
s
m

#Retain samples with F coefficient within 3 SD of the population mean
valid = subset(data,F<=m+3*s & F>= m-3*s)
dim(valid)
dim(data)

write.table(valid[,c(1,2)], "filtered_attract_preQC.valid.sample",quote=F,row.names=F)

```

OUTPUT:  
```
> data = read.table("QC_filtered_attract_preQC.het",header=TRUE)
> summary(data)
      FID            IID           O.HOM.           E.HOM.      
 WHB1809:   1   WHB1809:   1   Min.   :131897   Min.   :178600  
 WHB1810:   1   WHB1810:   1   1st Qu.:212330   1st Qu.:213100  
 WHB1811:   1   WHB1811:   1   Median :218397   Median :214500  
 WHB1812:   1   WHB1812:   1   Mean   :216782   Mean   :212929  
 WHB1813:   1   WHB1813:   1   3rd Qu.:222675   3rd Qu.:215600  
 WHB1814:   1   WHB1814:   1   Max.   :241171   Max.   :218000  
 (Other):2444   (Other):2444                                    
     N.NM.              F           
 Min.   :277029   Min.   :-0.70910  
 1st Qu.:330768   1st Qu.:-0.02477  
 Median :333004   Median : 0.03123  
 Mean   :330510   Mean   : 0.03457  
 3rd Qu.:334624   3rd Qu.: 0.08676  
 Max.   :338203   Max.   : 0.55910  
                                    
> 
> 
> m = mean(data$F)
> s = sd(data$F)
> s
[1] 0.1089366
> m
[1] 0.03456561
> valid = subset(data,F<=m+3*s & F>= m-3*s)
> dim(valid)
[1] 2411    6
> dim(data)
[1] 2450    6
> 
> 
> write.table(valid[,c(1,2)], "filtered_attract_preQC.valid.sample",quote=F,row.names=F)
```

### Step 6: Sex check  
Command:  
```
./plink --bfile filtered_attract_preQC --extract QC_filtered_attract_preQC.prune.in --keep filtered_attract_preQC.valid.sample --rel-cutoff 0.2 --out QC_filtered_attract_preQC
```  
<br />
Run Log:  
```
PLINK v1.90b6.16 64-bit (19 Feb 2020)          www.cog-genomics.org/plink/1.9/
(C) 2005-2020 Shaun Purcell, Christopher Chang   GNU General Public License v3
Logging to QC_filtered_attract_preQC.log.
Options in effect:
  --bfile filtered_attract_preQC
  --check-sex
  --extract QC_filtered_attract_preQC.prune.in
  --keep filtered_attract_preQC.valid.sample
  --out QC_filtered_attract_preQC

128966 MB RAM detected; reserving 64483 MB for main workspace.
80728670 variants loaded from .bim file.
2450 people (853 males, 1592 females, 5 ambiguous) loaded from .fam.
Ambiguous sex IDs written to QC_filtered_attract_preQC.nosex .
2450 phenotype values loaded from .fam.
--extract: 340543 variants remaining.
--keep: 2411 people remaining.
Warning: Ignoring phenotypes of missing-sex samples.  If you dont want those
phenotypes to be ignored, use the --allow-no-sex flag.
Using 1 thread (no multithreaded calculations invoked).
Before main variant filters, 2411 founders and 0 nonfounders present.
Calculating allele frequencies... done.
Warning: 513940 het. haploid genotypes present (see
QC_filtered_attract_preQC.hh ); many commands treat these as missing.
Total genotyping rate in remaining samples is 0.975364.
340543 variants and 2411 people pass filters and QC.
Among remaining phenotypes, 1375 are cases and 1031 are controls.  (5
phenotypes are missing.)
--check-sex: 1677 Xchr and 0 Ychr variant(s) scanned, 2105 problems detected.
Report written to QC_filtered_attract_preQC.sexcheck .
```



### Step 7: Check Relatedness  
Command:  
```
./plink --bfile filtered_attract_preQC --make-bed --keep QC_filtered_attract_preQC.rel.id --out QC_filtered_attract_preQC --extract QC_filtered_attract_preQC.snplist
```
<br />
Run Log:  
```
Options in effect:
  --bfile filtered_attract_preQC
  --extract QC_filtered_attract_preQC.prune.in
  --keep filtered_attract_preQC.valid.sample
  --out QC_filtered_attract_preQC
  --rel-cutoff 0.2

128966 MB RAM detected; reserving 64483 MB for main workspace.
80728670 variants loaded from .bim file.
2450 people (853 males, 1592 females, 5 ambiguous) loaded from .fam.
Ambiguous sex IDs written to QC_filtered_attract_preQC.nosex .
2450 phenotype values loaded from .fam.
--extract: 340543 variants remaining.
--keep: 2411 people remaining.
Warning: Ignoring phenotypes of missing-sex samples.  If you dont want those
phenotypes to be ignored, use the --allow-no-sex flag.
Using up to 39 threads (change this with --threads).
Before main variant filters, 2411 founders and 0 nonfounders present.
Calculating allele frequencies... done.
Warning: 513940 het. haploid genotypes present (see
QC_filtered_attract_preQC.hh ); many commands treat these as missing.
Total genotyping rate in remaining samples is 0.975364.
340543 variants and 2411 people pass filters and QC (before --rel-cutoff).
Among remaining phenotypes, 1375 are cases and 1031 are controls.  (5
phenotypes are missing.)
Excluding 1677 variants on non-autosomes from relationship matrix calc.
Relationship matrix calculation complete.
166 people excluded by --rel-cutoff.
Remaining sample IDs written to QC_filtered_attract_preQC.rel.id .
```


### Step 8: Generate the QC-ed file  
Command:  
```
./plink --bfile QC_filtered_attract_preQC --pca 10 --out QC_filtered_attract_preQC
```
<br />
Run Log:  
```
PLINK v1.90b6.16 64-bit (19 Feb 2020)          www.cog-genomics.org/plink/1.9/
(C) 2005-2020 Shaun Purcell, Christopher Chang   GNU General Public License v3
Logging to QC_filtered_attract_preQC.log.
Options in effect:
  --bfile filtered_attract_preQC
  --extract QC_filtered_attract_preQC.snplist
  --keep QC_filtered_attract_preQC.rel.id
  --make-bed
  --out QC_filtered_attract_preQC

128966 MB RAM detected; reserving 64483 MB for main workspace.
80728670 variants loaded from .bim file.
2450 people (853 males, 1592 females, 5 ambiguous) loaded from .fam.
Ambiguous sex IDs written to QC_filtered_attract_preQC.nosex .
2450 phenotype values loaded from .fam.
--extract: 5320950 variants remaining.
--keep: 2245 people remaining.
Warning: Ignoring phenotypes of missing-sex samples.  If you dont want those
phenotypes to be ignored, use the --allow-no-sex flag.
Using 1 thread (no multithreaded calculations invoked).
Before main variant filters, 2245 founders and 0 nonfounders present.
Calculating allele frequencies... done.
Warning: 496293 het. haploid genotypes present (see
QC_filtered_attract_preQC.hh ); many commands treat these as missing.
Total genotyping rate in remaining samples is 0.995572.
5320950 variants and 2245 people pass filters and QC.
Among remaining phenotypes, 1350 are cases and 895 are controls.
--make-bed to QC_filtered_attract_preQC.bed + QC_filtered_attract_preQC.bim +
QC_filtered_attract_preQC.fam ... done.
```


### Step 9: PCA  
```
PLINK v1.90b6.16 64-bit (19 Feb 2020)          www.cog-genomics.org/plink/1.9/
(C) 2005-2020 Shaun Purcell, Christopher Chang   GNU General Public License v3
Logging to QC_filtered_attract_preQC.log.
Options in effect:
  --bfile QC_filtered_attract_preQC
  --out QC_filtered_attract_preQC
  --pca 10

128966 MB RAM detected; reserving 64483 MB for main workspace.
5320950 variants loaded from .bim file.
2245 people (756 males, 1485 females, 4 ambiguous) loaded from .fam.
Ambiguous sex IDs written to QC_filtered_attract_preQC.nosex .
2245 phenotype values loaded from .fam.
Warning: Ignoring phenotypes of missing-sex samples.  If you dont want those
phenotypes to be ignored, use the --allow-no-sex flag.
Using up to 39 threads (change this with --threads).
Before main variant filters, 2245 founders and 0 nonfounders present.
Calculating allele frequencies... done.
Warning: 496293 het. haploid genotypes present (see
QC_filtered_attract_preQC.hh ); many commands treat these as missing.
Total genotyping rate is 0.995572.
5320950 variants and 2245 people pass filters and QC.
Among remaining phenotypes, 1348 are cases and 893 are controls.  (4 phenotypes
are missing.)
Excluding 1808 variants on non-autosomes from relationship matrix calc.
Relationship matrix calculation complete.
--pca: Results saved to QC_filtered_attract_preQC.eigenval and
QC_filtered_attract_preQC.eigenvec .
```

OUTPUT:  
<p align="center">
  <img height="400" src="https://github.com/lwtan90/ATTRACTgenome/blob/master/img/PC12.png">
</p>  


