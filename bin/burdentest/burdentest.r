#########################################################
# This script will run BURDEN test / SKAT analysis on 1 gene
# You will need to install SKAT
# Dependency: SKAT (Run on R version 3.5.0 and above)
# 
# Description:
# Rscript-3.5.0 burdentest.r ENSG0002992929.1
# It will take the gene ID as an argument
#
# Output:
# Each gene will be assigned a SKAT and BURTEN P-value respectively
#
# Note:
# This script will only estimate significance for 1 gene (NOT Multiple genes)
#########################################################



## Check if you have SKAT installed
## If not, it will run SKAT installation from CRAN
if (!require("SKAT", character.only = TRUE)) {
      install.packages("SKAT", dependencies = TRUE)
      library("SKAT")
}else{
	require(SKAT)
}

## User's argument: gene id recorded in setid file.
## The test will be performed based on Matrix File (see files required point 3)
## Output in the form of p-value will be recorded in the outputfile
args = commandArgs(TRUE)
target = args[1]
outputfile = paste(target,".stat",sep="")


## Files required
## 1. eigenvalue estimated by plink (see example in resource/pca.cov
## 2. FAM file from the WGSfiltering processing (see example in resource/EXONPLUS.parse3_rare_parse1_QC_filtered_attract_preQC.fam
## 3. Genotype Matrix File(see example in resource/test_ENSG000.mat.raw)
## 1. eigenvalue file
FAM_Cov = read.table("/mnt/projects/wlwtan/cardiac_epigenetics/SG10K/ATTRACT/GWAS/burden/EXON/covariate/pca.cov",header=TRUE,sep="\t")

## 2. FAM file
pheno = read.table("EXONPLUS.parse3_rare_parse1_QC_filtered_attract_preQC.fam",header=FALSE)

## 3. Genotype Matrix File
rawfile = paste("test_",target,".mat.raw",sep="")
Z = read.table(rawfile,header=TRUE,row.names=1)
Z[ is.na(Z) ] = 0
Z.mat = Z[,grep("chr",colnames(Z))]


## Manipulating files (Touch only if you know what you are doing)
pheno = pheno[ pheno$V6>0, ]
Z.mat = Z.mat[rownames(Z.mat)%in%pheno$V1, ]
pheno = pheno[match(rownames(Z.mat),pheno$V1),]
FAM_Cov = FAM_Cov[match(pheno$V1,FAM_Cov$V1),]
summary(FAM_Cov)
dim(Z.mat)
dim(pheno)


## Forming the model required for testing
y.b = pheno$V6
y.b = pheno$V6-1
summary(y.b)
length(y.b)
###if you believe that no correction is required, use the following NULL model (commented out)
###obj <- SKAT_Null_Model(y.b~1,out_type="D")
obj<-SKAT_Null_Model(y.b ~ FAM_Cov$PC1 + FAM_Cov$PC2 + FAM_Cov$PC3 + FAM_Cov$PC4 + FAM_Cov$PC5 + FAM_Cov$PC6 + FAM_Cov$PC7 + FAM_Cov$PC8 + FAM_Cov$PC9 + FAM_Cov$PC10, out_type="D")

Z.mat = as.matrix(Z.mat)

## Calculate SKAT analysis P-value
allSNPs.SKAT = SKAT(Z.mat,obj)$p.value
allSNPs.SKAT

## Calculate Burden Test P-value
allSNPs.burden = SKAT(Z.mat, obj, r.corr=1)$p.value
allSNPs.burden


## Consolidate output and write to outputfile
## Each gene will have its own p-value
result = data.frame(file=rep(target),pvalue=c(allSNPs.SKAT,allSNPs.burden),test=c("SKAT","BURDEN"))
result
write.table(result,file=outputfile,sep="\t",quote=FALSE,row.names=F,col.names=F)

