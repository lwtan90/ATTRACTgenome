#######################################################################
#Post-processing script for Burden Test (burdentestPIPELINE.sh).  
#Purpose: To combine the p-value estimated from individual genes, and perform
#         multiple testing correction using bonferroni procedure.
#Dependencies:
#1. countVARperGene.r: a R script to calculate total number of variants per gene in target.setid file
#2. qqplot.r: to generate qqlot to assess the appropriateness of the test
#3. manhatan.r: to generate manhatan plot
#Author: Wilson Tan
#Date: 5/2/2021
#####################################################################

### Step 1: Transfer all gene p-value files into a folder (allstat)
mkdir allstat
mv *.stat allstat/


### Step 2: Count number of variants per gene
Rscript-3.5.1 bin/burdentest/countVARperGENE.r target.setid

### Step 3: adjust p-value and plot various graphs
cat allstat/*.stat | grep BURDEN | sort -k2,2g > statistics.txt
Rscript-3.5.1 bin/burdentest/qqplot.r statistics.txt burden.qqplot.png
Rscript-3.5.1 bin/burdentest/manhatan.r statistics.txt burden.manhatan.png

### If you are interested to see if SKAT produces the same set of significance
#cat allstat/*.stat | grep SKAT | sort -k2,2g > skat_statistics.txt
#Rscript-3.5.1 bin/burdentest/qqplot.r skat_statistics.txt skat.qqplot.png
#Rscript-3.5.1 bin/burdentest/manhatan.r skat_statistics.txt skat.manhatan.png



