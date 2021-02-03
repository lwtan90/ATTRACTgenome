########################################################################
# This wrapper script will run burdentest for individual gene
# This is part of the burdentestPIPELINE.sh
# User Argument: sh burdentestPIPELINE.sh geneid
# Dependencies: target.setid, PLINK, burdentest.r, plink files from WGS filtering/filtered downstream
########################################################################

#!/bin/bash

PLINK=/mnt/projects/wlwtan/cardiac_epigenetics/SG10K/ATTRACT/GWAS/plink
GENE=$1


## forming input required for burden test
grep $GENE target.setid | awk '{print $2}' > "test_"$GENE".id"
$PLINK --bfile EXONPLUS.parse3_rare_parse1_QC_filtered_attract_preQC --extract "test_"$GENE".id" --out "test_"$GENE --make-bed

## Burden tes takes in genotype matrix
$PLINK --bfile "test_"$GENE --recodeA --out "test_"$GENE".mat"

## Actual burden test is done here
Rscript-3.5.1 burdentest.r $GENE
rm "test_"$GENE*

