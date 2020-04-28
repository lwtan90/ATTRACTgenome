###
# Documentation for ATTRACT Data Processing  
###


## Step 1: Remove duplicate samples  
```
(base) [wlwtan@n069 zheng_preQC]$ ./plink --bfile attract_preQC --remove unwanted_list.txt --out filtered_attract_preQC --make-bed
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
2383 phenotype values loaded from .fam.
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
Among remaining phenotypes, 1365 are cases and 1018 are controls.  (67
phenotypes are missing.)
--make-bed to filtered_attract_preQC.bed + filtered_attract_preQC.bim +
filtered_attract_preQC.fam ... done.
```





