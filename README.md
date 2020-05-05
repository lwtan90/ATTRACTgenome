###
# Documentation for ATTRACT Data Processing  
###

<details>  
<summary> QC procesing of entire datasets </summary>  

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
./plink --bfile filtered_attract_preQC --mind 0.05 --write-snplist --make-just-fam --allow-no-sex --out QC_filtered_attract_preQC
```  

<br />  

Run Log:   

```
Options in effect:
  --allow-no-sex
  --bfile filtered_attract_preQC
  --make-just-fam
  --mind 0.05
  --out QC_filtered_attract_preQC
  --write-snplist

128966 MB RAM detected; reserving 64483 MB for main workspace.
80728670 variants loaded from .bim file.
2450 people (853 males, 1592 females, 5 ambiguous) loaded from .fam.
Ambiguous sex IDs written to QC_filtered_attract_preQC.nosex .
2450 phenotype values loaded from .fam.
6 people removed due to missing genotype data (--mind).
IDs written to QC_filtered_attract_preQC.irem .
Using 1 thread (no multithreaded calculations invoked).
Before main variant filters, 2444 founders and 0 nonfounders present.
Calculating allele frequencies... done.
Warning: 65671759 het. haploid genotypes present (see
QC_filtered_attract_preQC.hh ); many commands treat these as missing.
Warning: Nonmissing nonmale Y chromosome genotype(s) present; many commands
treat these as missing.
Total genotyping rate in remaining samples is 0.986548.
80728670 variants and 2444 people pass filters and QC.
Among remaining phenotypes, 1409 are cases and 1035 are controls.
List of variant IDs written to QC_filtered_attract_preQC.snplist .
--make-just-fam to QC_filtered_attract_preQC.fam ... done.
```

## Step 3: Pruning  
Command:  
```
./plink --bfile filtered_attract_preQC --keep QC_filtered_attract_preQC.fam --indep-pairwise 200 50 0.25 --out QC_filtered_attract_preQC
```  

<br />    

Run Log:  

```
Logging to QC_filtered_attract_preQC.log.
Options in effect:
  --bfile filtered_attract_preQC
  --indep-pairwise 200 50 0.25
  --keep QC_filtered_attract_preQC.fam
  --out QC_filtered_attract_preQC

128966 MB RAM detected; reserving 64483 MB for main workspace.
80728670 variants loaded from .bim file.
2450 people (853 males, 1592 females, 5 ambiguous) loaded from .fam.
Ambiguous sex IDs written to QC_filtered_attract_preQC.nosex .
2450 phenotype values loaded from .fam.
--keep: 2444 people remaining.
Warning: Ignoring phenotypes of missing-sex samples.  If you dont want those
phenotypes to be ignored, use the --allow-no-sex flag.
Using 1 thread (no multithreaded calculations invoked).
Before main variant filters, 2444 founders and 0 nonfounders present.
Calculating allele frequencies... done.
Warning: 65671759 het. haploid genotypes present (see
QC_filtered_attract_preQC.hh ); many commands treat these as missing.
Warning: Nonmissing nonmale Y chromosome genotype(s) present; many commands
treat these as missing.
Total genotyping rate in remaining samples is 0.986548.
80728670 variants and 2444 people pass filters and QC.
Among remaining phenotypes, 1407 are cases and 1032 are controls.  (5
phenotypes are missing.)
Pruned 1567507 variants from chromosome 1, leaving 4710840.
Pruned 1672662 variants from chromosome 2, leaving 5085933.
Pruned 1428133 variants from chromosome 3, leaving 4218187.
Pruned 1418271 variants from chromosome 4, leaving 3977763.
Pruned 1272867 variants from chromosome 5, leaving 3755133.
Pruned 1223313 variants from chromosome 6, leaving 3480907.
Pruned 1153573 variants from chromosome 7, leaving 3362984.
Pruned 1069180 variants from chromosome 8, leaving 3169113.
Pruned 868378 variants from chromosome 9, leaving 2519742.
Pruned 1008435 variants from chromosome 10, leaving 2877542.
Pruned 959765 variants from chromosome 11, leaving 2824828.
Pruned 974710 variants from chromosome 12, leaving 2821226.
Pruned 728995 variants from chromosome 13, leaving 2067283.
Pruned 636022 variants from chromosome 14, leaving 1847146.
Pruned 562429 variants from chromosome 15, leaving 1646710.
Pruned 657093 variants from chromosome 16, leaving 1916038.
Pruned 551578 variants from chromosome 17, leaving 1654058.
Pruned 557691 variants from chromosome 18, leaving 1598342.
Pruned 489510 variants from chromosome 19, leaving 1360989.
Pruned 471925 variants from chromosome 20, leaving 1366249.
Pruned 277456 variants from chromosome 21, leaving 745877.
Pruned 285331 variants from chromosome 22, leaving 795386.
Pruned 1316002 variants from chromosome 23, leaving 1544027.
Pruned 103898 variants from chromosome 24, leaving 4565.
Pruned 41764 variants from chromosome 25, leaving 81314.
Pruning complete.  21296488 of 80728670 variants removed.
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
Logging to QC_filtered_attract_preQC.log.
Options in effect:
  --bfile filtered_attract_preQC
  --extract QC_filtered_attract_preQC.prune.in
  --het
  --keep QC_filtered_attract_preQC.fam
  --out QC_filtered_attract_preQC

128966 MB RAM detected; reserving 64483 MB for main workspace.
80728670 variants loaded from .bim file.
2450 people (853 males, 1592 females, 5 ambiguous) loaded from .fam.
Ambiguous sex IDs written to QC_filtered_attract_preQC.nosex .
2450 phenotype values loaded from .fam.
--extract: 59432182 variants remaining.
--keep: 2444 people remaining.
Warning: Ignoring phenotypes of missing-sex samples.  If you dont want those
phenotypes to be ignored, use the --allow-no-sex flag.
Using 1 thread (no multithreaded calculations invoked).
Before main variant filters, 2444 founders and 0 nonfounders present.
Calculating allele frequencies... done.
Warning: 15389794 het. haploid genotypes present (see
QC_filtered_attract_preQC.hh ); many commands treat these as missing.
Warning: Nonmissing nonmale Y chromosome genotype(s) present; many commands
treat these as missing.
Total genotyping rate in remaining samples is 0.988693.
59432182 variants and 2444 people pass filters and QC.
Among remaining phenotypes, 1407 are cases and 1032 are controls.  (5
phenotypes are missing.)
--het: 57883590 variants scanned, report written to
QC_filtered_attract_preQC.het .
```


### Step 5: Remove samples that exceeded heterozygosity  

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
> 
> #Read the file from the heterozygosity estimates
> data = read.table("QC_filtered_attract_preQC.het",header=TRUE)
> summary(data)
      FID            IID           O.HOM.             E.HOM.        
 WHB1809:   1   WHB1809:   1   Min.   :55140176   Min.   :55050000  
 WHB1810:   1   WHB1810:   1   1st Qu.:56699893   1st Qu.:56630000  
 WHB1811:   1   WHB1811:   1   Median :56755622   Median :56700000  
 WHB1812:   1   WHB1812:   1   Mean   :56711723   Mean   :56649223  
 WHB1813:   1   WHB1813:   1   3rd Qu.:56792558   3rd Qu.:56750000  
 WHB1814:   1   WHB1814:   1   Max.   :56954223   Max.   :56990000  
 (Other):2438   (Other):2438                                        
     N.NM.                F           
 Min.   :55572484   Min.   :-0.52160  
 1st Qu.:57227750   1st Qu.: 0.05188  
 Median :57302242   Median : 0.11205  
 Mean   :57250658   Mean   : 0.10507  
 3rd Qu.:57358505   3rd Qu.: 0.16687  
 Max.   :57614768   Max.   : 0.52990  
                                      
> m = mean(data$F)
> s = sd(data$F)
> s
[1] 0.09463362
> m
[1] 0.1050662
> 
> #Retain samples with F coefficient within 3 SD of the population mean
> valid = subset(data,F<=m+3*s & F>= m-3*s)
> dim(valid)
[1] 2405    6
> dim(data)
[1] 2444    6
> 
> write.table(valid[,c(1,2)], "filtered_attract_preQC.valid.sample",quote=F,row.names=F)
> 

```

### Step 6: Sex check  
Command:  
```
./plink --bfile filtered_attract_preQC --extract QC_filtered_attract_preQC.prune.in --keep filtered_attract_preQC.valid.sample --check-sex --out QC_filtered_attract_preQC 
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
  --extract QC_filtered_attract_preQC.prune.in
  --keep filtered_attract_preQC.valid.sample
  --out QC_filtered_attract_preQC
  --rel-cutoff 0.2

128966 MB RAM detected; reserving 64483 MB for main workspace.
80728670 variants loaded from .bim file.
2450 people (853 males, 1592 females, 5 ambiguous) loaded from .fam.
Ambiguous sex IDs written to QC_filtered_attract_preQC.nosex .
2450 phenotype values loaded from .fam.
--extract: 59432182 variants remaining.
--keep: 2405 people remaining.
Warning: Ignoring phenotypes of missing-sex samples.  If you dont want those
phenotypes to be ignored, use the --allow-no-sex flag.
Using up to 39 threads (change this with --threads).
Before main variant filters, 2405 founders and 0 nonfounders present.
Calculating allele frequencies... done.
Warning: 15268186 het. haploid genotypes present (see
QC_filtered_attract_preQC.hh ); many commands treat these as missing.
Warning: Nonmissing nonmale Y chromosome genotype(s) present; many commands
treat these as missing.
Total genotyping rate in remaining samples is 0.988744.
59432182 variants and 2405 people pass filters and QC (before --rel-cutoff).
Among remaining phenotypes, 1372 are cases and 1028 are controls.  (5
phenotypes are missing.)
Excluding 1548592 variants on non-autosomes from relationship matrix calc.
Relationship matrix calculation complete.
97 people excluded by --rel-cutoff.
Remaining sample IDs written to QC_filtered_attract_preQC.rel.id .
```


### Step 8: Generate the Sample QC-ed file  
Command:  
```
./plink --bfile filtered_attract_preQC --make-bed --keep QC_filtered_attract_preQC.rel.id --out parse1_QC_filtered_attract_preQC
```  

<br />  

Run Log:    

```
Options in effect:
  --bfile filtered_attract_preQC
  --keep QC_filtered_attract_preQC.rel.id
  --make-bed
  --out parse1_QC_filtered_attract_preQC

128966 MB RAM detected; reserving 64483 MB for main workspace.
80728670 variants loaded from .bim file.
2450 people (853 males, 1592 females, 5 ambiguous) loaded from .fam.
Ambiguous sex IDs written to parse1_QC_filtered_attract_preQC.nosex .
2450 phenotype values loaded from .fam.
--keep: 2308 people remaining.
Warning: Ignoring phenotypes of missing-sex samples.  If you dont want those
phenotypes to be ignored, use the --allow-no-sex flag.
Using 1 thread (no multithreaded calculations invoked).
Before main variant filters, 2308 founders and 0 nonfounders present.
Calculating allele frequencies... done.
Warning: 60756050 het. haploid genotypes present (see
parse1_QC_filtered_attract_preQC.hh ); many commands treat these as missing.
Warning: Nonmissing nonmale Y chromosome genotype(s) present; many commands
treat these as missing.
Total genotyping rate in remaining samples is 0.986627.
80728670 variants and 2308 people pass filters and QC.
Among remaining phenotypes, 1358 are cases and 950 are controls.
--make-bed to parse1_QC_filtered_attract_preQC.bed +
parse1_QC_filtered_attract_preQC.bim + parse1_QC_filtered_attract_preQC.fam ...
done.
```

### Step 9: QC at SNPs level
Command:  

```
./plink --bfile parse1_QC_filtered_attract_preQC --maf 0.01 --hwe 1e-6 --geno 0.05 --allow-no-sex --make-bed --out parse2_QC_filtered_attract_preQC  

```  

Run Log:  
```
PLINK v1.90b6.16 64-bit (19 Feb 2020)          www.cog-genomics.org/plink/1.9/
(C) 2005-2020 Shaun Purcell, Christopher Chang   GNU General Public License v3
Logging to parse2_QC_filtered_attract_preQC.log.
Options in effect:
  --allow-no-sex
  --bfile parse1_QC_filtered_attract_preQC
  --geno 0.05
  --hwe 1e-6
  --maf 0.01
  --make-bed
  --out parse2_QC_filtered_attract_preQC

128966 MB RAM detected; reserving 64483 MB for main workspace.
80728670 variants loaded from .bim file.
2308 people (790 males, 1514 females, 4 ambiguous) loaded from .fam.
Ambiguous sex IDs written to parse2_QC_filtered_attract_preQC.nosex .
2308 phenotype values loaded from .fam.
Using 1 thread (no multithreaded calculations invoked).
Before main variant filters, 2308 founders and 0 nonfounders present.
Calculating allele frequencies... done.
Warning: 60756050 het. haploid genotypes present (see
parse2_QC_filtered_attract_preQC.hh ); many commands treat these as missing.
Warning: Nonmissing nonmale Y chromosome genotype(s) present; many commands
treat these as missing.
Total genotyping rate is 0.986627.
4239480 variants removed due to missing genotype data (--geno).
Warning: --hwe observation counts vary by more than 10%.  Consider using
--geno, and/or applying different p-value thresholds to distinct subsets of
your data.
--hwe: 882813 variants removed due to Hardy-Weinberg exact test.
65681379 variants removed due to minor allele threshold(s)
(--maf/--max-maf/--mac/--max-mac).
9924998 variants and 2308 people pass filters and QC.
Among remaining phenotypes, 1358 are cases and 950 are controls.
--make-bed to parse2_QC_filtered_attract_preQC.bed +
parse2_QC_filtered_attract_preQC.bim + parse2_QC_filtered_attract_preQC.fam ...
done.
```    

### Step 10: Run test-missing to identify bad SNPs  
  
Command:  
```
./plink --bfile parse2_QC_filtered_attract_preQC --test-missing midp --allow-no-sex --out parse2_QC_filtered_attract_preQC
```  


Run Log:  
```
PLINK v1.90b6.16 64-bit (19 Feb 2020)          www.cog-genomics.org/plink/1.9/
(C) 2005-2020 Shaun Purcell, Christopher Chang   GNU General Public License v3
Logging to parse2_QC_filtered_attract_preQC.log.
Options in effect:
  --allow-no-sex
  --bfile parse2_QC_filtered_attract_preQC
  --out parse2_QC_filtered_attract_preQC
  --test-missing midp

128966 MB RAM detected; reserving 64483 MB for main workspace.
9924998 variants loaded from .bim file.
2308 people (790 males, 1514 females, 4 ambiguous) loaded from .fam.
Ambiguous sex IDs written to parse2_QC_filtered_attract_preQC.nosex .
2308 phenotype values loaded from .fam.
Using 1 thread (no multithreaded calculations invoked).
Before main variant filters, 2308 founders and 0 nonfounders present.
Calculating allele frequencies... done.
Warning: 1083019 het. haploid genotypes present (see
parse2_QC_filtered_attract_preQC.hh ); many commands treat these as missing.
Warning: Nonmissing nonmale Y chromosome genotype(s) present; many commands
treat these as missing.
Total genotyping rate is 0.997122.
9924998 variants and 2308 people pass filters and QC.
Among remaining phenotypes, 1358 are cases and 950 are controls.
Writing --test-missing report to parse2_QC_filtered_attract_preQC.missing ...
done.
```  

### Step 11: Remove SNPs with case-control missingness < 5e-5  
Command:  
```
awk '{if($5<0.00005){print $2}}' parse2_QC_filtered_attract_preQC.missing  > parse2_QC_filtered_attract_preQC.missingsnp
./plink --bfile parse2_QC_filtered_attract_preQC --make-bed  --out parse3_QC_filtered_attract_preQC --exclude parse2_QC_filtered_attract_preQC.missingsnp  


```  
  
Run Log:  
```
Logging to parse3_QC_filtered_attract_preQC.log.
Options in effect:
  --bfile parse2_QC_filtered_attract_preQC
  --exclude parse2_QC_filtered_attract_preQC.missingsnp
  --make-bed
  --out parse3_QC_filtered_attract_preQC

128966 MB RAM detected; reserving 64483 MB for main workspace.
9924998 variants loaded from .bim file.
2308 people (790 males, 1514 females, 4 ambiguous) loaded from .fam.
Ambiguous sex IDs written to parse3_QC_filtered_attract_preQC.nosex .
2308 phenotype values loaded from .fam.
--exclude: 9820292 variants remaining.
Warning: Ignoring phenotypes of missing-sex samples.  If you dont want those
phenotypes to be ignored, use the --allow-no-sex flag.
Using 1 thread (no multithreaded calculations invoked).
Before main variant filters, 2308 founders and 0 nonfounders present.
Calculating allele frequencies... done.
Warning: 647883 het. haploid genotypes present (see
parse3_QC_filtered_attract_preQC.hh ); many commands treat these as missing.
Warning: Nonmissing nonmale Y chromosome genotype(s) present; many commands
treat these as missing.
Total genotyping rate is 0.997395.
9820292 variants and 2308 people pass filters and QC.
Among remaining phenotypes, 1358 are cases and 950 are controls.
--make-bed to parse3_QC_filtered_attract_preQC.bed +
parse3_QC_filtered_attract_preQC.bim + parse3_QC_filtered_attract_preQC.fam ...
done.
```  

### Step 12: Prune the final QC SNPs  

Command:  

```
./plink --bfile parse3_QC_filtered_attract_preQC --indep-pairwise 200 50 0.25 --out parse3_QC_filtered_attract_preQC
```  
Run Log:  

```
PLINK v1.90b6.16 64-bit (19 Feb 2020)          www.cog-genomics.org/plink/1.9/
(C) 2005-2020 Shaun Purcell, Christopher Chang   GNU General Public License v3
Logging to parse3_QC_filtered_attract_preQC.log.
Options in effect:
  --bfile parse3_QC_filtered_attract_preQC
  --indep-pairwise 200 50 0.25
  --out parse3_QC_filtered_attract_preQC

128966 MB RAM detected; reserving 64483 MB for main workspace.
9820292 variants loaded from .bim file.
2308 people (790 males, 1514 females, 4 ambiguous) loaded from .fam.
Ambiguous sex IDs written to parse3_QC_filtered_attract_preQC.nosex .
2308 phenotype values loaded from .fam.
Warning: Ignoring phenotypes of missing-sex samples.  If you dont want those
phenotypes to be ignored, use the --allow-no-sex flag.
Using 1 thread (no multithreaded calculations invoked).
Before main variant filters, 2308 founders and 0 nonfounders present.
Calculating allele frequencies... done.
Warning: 647883 het. haploid genotypes present (see
parse3_QC_filtered_attract_preQC.hh ); many commands treat these as missing.
Warning: Nonmissing nonmale Y chromosome genotype(s) present; many commands
treat these as missing.
Total genotyping rate is 0.997395.
9820292 variants and 2308 people pass filters and QC.
Among remaining phenotypes, 1356 are cases and 948 are controls.  (4 phenotypes
are missing.)
Pruned 627433 variants from chromosome 1, leaving 154883.
Pruned 665864 variants from chromosome 2, leaving 155700.
Pruned 582841 variants from chromosome 3, leaving 130632.
Pruned 588124 variants from chromosome 4, leaving 119049.
Pruned 518398 variants from chromosome 5, leaving 115019.
Pruned 505341 variants from chromosome 6, leaving 108156.
Pruned 472045 variants from chromosome 7, leaving 107665.
Pruned 422428 variants from chromosome 8, leaving 93993.
Pruned 350393 variants from chromosome 9, leaving 82099.
Pruned 419085 variants from chromosome 10, leaving 92614.
Pruned 386837 variants from chromosome 11, leaving 85867.
Pruned 391552 variants from chromosome 12, leaving 93394.
Pruned 297705 variants from chromosome 13, leaving 63839.
Pruned 258293 variants from chromosome 14, leaving 60697.
Pruned 221880 variants from chromosome 15, leaving 56446.
Pruned 236097 variants from chromosome 16, leaving 61769.
Pruned 199897 variants from chromosome 17, leaving 62047.
Pruned 228729 variants from chromosome 18, leaving 51767.
Pruned 176624 variants from chromosome 19, leaving 53514.
Pruned 175976 variants from chromosome 20, leaving 46236.
Pruned 109295 variants from chromosome 21, leaving 24562.
Pruned 107404 variants from chromosome 22, leaving 29399.
Pruned 1310 variants from chromosome 23, leaving 10791.
Pruned 16 variants from chromosome 24, leaving 28.
Pruned 12366 variants from chromosome 25, leaving 4193.
Pruning complete.  7955933 of 9820292 variants removed.
Marker lists written to parse3_QC_filtered_attract_preQC.prune.in and
parse3_QC_filtered_attract_preQC.prune.out .
```  


### Step 13: PCA  
Command:  
```
./plink --bfile parse3_QC_filtered_attract_preQC --pca 10 --out parse3_QC_filtered_attract_preQC
```  
<br />  
Run Log:  

```
PLINK v1.90b6.16 64-bit (19 Feb 2020)          www.cog-genomics.org/plink/1.9/
(C) 2005-2020 Shaun Purcell, Christopher Chang   GNU General Public License v3
Logging to parse3_QC_filtered_attract_preQC.log.
Options in effect:
  --bfile parse3_QC_filtered_attract_preQC
  --out parse3_QC_filtered_attract_preQC
  --pca 10

128966 MB RAM detected; reserving 64483 MB for main workspace.
9820292 variants loaded from .bim file.
2308 people (790 males, 1514 females, 4 ambiguous) loaded from .fam.
Ambiguous sex IDs written to parse3_QC_filtered_attract_preQC.nosex .
2308 phenotype values loaded from .fam.
Warning: Ignoring phenotypes of missing-sex samples.  If you dont want those
phenotypes to be ignored, use the --allow-no-sex flag.
Using up to 39 threads (change this with --threads).
Before main variant filters, 2308 founders and 0 nonfounders present.
Calculating allele frequencies... done.
Warning: 647883 het. haploid genotypes present (see
parse3_QC_filtered_attract_preQC.hh ); many commands treat these as missing.
Warning: Nonmissing nonmale Y chromosome genotype(s) present; many commands
treat these as missing.
Total genotyping rate is 0.997395.
9820292 variants and 2308 people pass filters and QC.
Among remaining phenotypes, 1356 are cases and 948 are controls.  (4 phenotypes
are missing.)
Excluding 12145 variants on non-autosomes from relationship matrix calc.
Relationship matrix calculation complete.
--pca: Results saved to parse3_QC_filtered_attract_preQC.eigenval and
parse3_QC_filtered_attract_preQC.eigenvec .
```

OUTPUT:  
<p align="center">
  <img height="400" src="https://github.com/lwtan90/ATTRACTgenome/blob/master/img/PC12.png">
</p>  
  

## Step 14: Testing for QTL with Marker BG  
Command:  
```
./plink --bfile parse3_QC_filtered_attract_preQC --linear --allow-no-sex --adjust --covar parse3_QC_filtered_attract_preQC.pca --covar-name PC1,PC2 --out BG
```  
<br />  
Run Log:  

```
Options in effect:
  --adjust
  --allow-no-sex
  --bfile parse3_QC_filtered_attract_preQC
  --covar parse3_QC_filtered_attract_preQC.pca
  --covar-name PC1,PC2
  --linear
  --out BG

128966 MB RAM detected; reserving 64483 MB for main workspace.
9820292 variants loaded from .bim file.
2308 people (0 males, 0 females, 2308 ambiguous) loaded from .fam.
Ambiguous sex IDs written to BG.nosex .
2293 phenotype values loaded from .fam.
Using 1 thread (no multithreaded calculations invoked).
--covar: 2 out of 10 covariates loaded.
Before main variant filters, 2308 founders and 0 nonfounders present.
Calculating allele frequencies... done.
Warning: Nonmissing nonmale Y chromosome genotype(s) present; many commands
treat these as missing.
Total genotyping rate is 0.997395.
9820292 variants and 2308 people pass filters and QC.
Phenotype data is quantitative.
Writing linear model association results to BG.assoc.linear ... done.
--adjust: Genomic inflation est. lambda (based on median chisq) = 1.05289.
--adjust values (9820248 variants) written to BG.assoc.linear.adjusted .
```   
OUTPUT:  

<p align="center">
  <img height="400" src="https://github.com/lwtan90/ATTRACTgenome/blob/master/img/BG_manhattan.png">
</p>   

<p align="center">
  <img height="400" src="https://github.com/lwtan90/ATTRACTgenome/blob/master/img/BG_QQ.png">
</p>  




## Step 15: Testing for QTL with Marker PB  
Command:  
```
```  
<br />  
Run Log:  

```
PLINK v1.90b6.16 64-bit (19 Feb 2020)          www.cog-genomics.org/plink/1.9/
(C) 2005-2020 Shaun Purcell, Christopher Chang   GNU General Public License v3
Logging to PB.log.
Options in effect:
  --adjust
  --allow-no-sex
  --bfile parse3_QC_filtered_attract_preQC
  --covar parse3_QC_filtered_attract_preQC.pca
  --covar-name PC1,PC2
  --linear
  --out PB

128966 MB RAM detected; reserving 64483 MB for main workspace.
9820292 variants loaded from .bim file.
2308 people (0 males, 0 females, 2308 ambiguous) loaded from .fam.
Ambiguous sex IDs written to PB.nosex .
2291 phenotype values loaded from .fam.
Using 1 thread (no multithreaded calculations invoked).
--covar: 2 out of 10 covariates loaded.
Before main variant filters, 2308 founders and 0 nonfounders present.
Calculating allele frequencies... done.
Warning: Nonmissing nonmale Y chromosome genotype(s) present; many commands
treat these as missing.
Total genotyping rate is 0.997395.
9820292 variants and 2308 people pass filters and QC.
Phenotype data is quantitative.
Writing linear model association results to PB.assoc.linear ... done.
--adjust: Genomic inflation est. lambda (based on median chisq) = 1.14225.
--adjust values (9820248 variants) written to PB.assoc.linear.adjusted .
```  


## Step 16: Testing for QTL with Marker PANPT  
Command:  
```
```  
<br />  
Run Log:  

```
Logging to BM_PANPT.log.
Options in effect:
  --adjust
  --allow-no-sex
  --bfile parse3_QC_filtered_attract_preQC
  --covar parse3_QC_filtered_attract_preQC.pca
  --covar-name PC1,PC2
  --linear
  --out BM_PANPT

128966 MB RAM detected; reserving 64483 MB for main workspace.
9820292 variants loaded from .bim file.
2308 people (0 males, 0 females, 2308 ambiguous) loaded from .fam.
Ambiguous sex IDs written to BM_PANPT.nosex .
968 phenotype values loaded from .fam.
Using 1 thread (no multithreaded calculations invoked).
--covar: 2 out of 10 covariates loaded.
Before main variant filters, 2308 founders and 0 nonfounders present.
Calculating allele frequencies... done.
Warning: Nonmissing nonmale Y chromosome genotype(s) present; many commands
treat these as missing.
Total genotyping rate is 0.997395.
9820292 variants and 2308 people pass filters and QC.
Phenotype data is quantitative.
Writing linear model association results to BM_PANPT.assoc.linear ... done.
--adjust: Genomic inflation est. lambda (based on median chisq) = 1.00613.
--adjust values (9820239 variants) written to BM_PANPT.assoc.linear.adjusted .
```    

</details>  
<break />
<break />
<details>  
<summary> QC Processing of Chinese Cohort </summary>  
## Subsetting Chinese patients only based on PCA  
Command:  
```
```  
<br />
Run Log:  
```
PLINK v1.90b6.16 64-bit (19 Feb 2020)          www.cog-genomics.org/plink/1.9/
(C) 2005-2020 Shaun Purcell, Christopher Chang   GNU General Public License v3
Logging to chinese_QC_filtered_attract_preQC.log.
Options in effect:
  --allow-no-sex
  --bfile parse1_QC_filtered_attract_preQC
  --geno 0.05
  --hwe 1e-6
  --keep chinese.txt
  --maf 0.01
  --make-bed
  --out chinese_QC_filtered_attract_preQC

129044 MB RAM detected; reserving 64522 MB for main workspace.
80728670 variants loaded from .bim file.
2308 people (790 males, 1514 females, 4 ambiguous) loaded from .fam.
Ambiguous sex IDs written to chinese_QC_filtered_attract_preQC.nosex .
2308 phenotype values loaded from .fam.
--keep: 1550 people remaining.
Using 1 thread (no multithreaded calculations invoked).
Before main variant filters, 1550 founders and 0 nonfounders present.
Calculating allele frequencies... done.
Warning: 39042920 het. haploid genotypes present (see
chinese_QC_filtered_attract_preQC.hh ); many commands treat these as missing.
Warning: Nonmissing nonmale Y chromosome genotype(s) present; many commands
treat these as missing.
Total genotyping rate in remaining samples is 0.986487.
4266770 variants removed due to missing genotype data (--geno).
Warning: --hwe observation counts vary by more than 10%, due to the X
chromosome.  You may want to use a less stringent --hwe p-value threshold for X
chromosome variants.
--hwe: 676457 variants removed due to Hardy-Weinberg exact test.
66128463 variants removed due to minor allele threshold(s)
(--maf/--max-maf/--mac/--max-mac).
9656980 variants and 1550 people pass filters and QC.
Among remaining phenotypes, 834 are cases and 716 are controls.
--make-bed to chinese_QC_filtered_attract_preQC.bed +
chinese_QC_filtered_attract_preQC.bim + chinese_QC_filtered_attract_preQC.fam
... done.

```  

</details>  

